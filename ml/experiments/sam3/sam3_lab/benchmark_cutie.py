"""Pretrained Cutie on MPS, with isolated upstream source and one frozen mask seed."""

import argparse
from fractions import Fraction
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import time
import traceback

import av
import numpy as np
import torch

from .benchmark_tracker import memory
from .flow_experiment import dice, metrics
from .inference import overlay
from .video import mask_rle


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('reference', type=Path)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--deps', type=Path, required=True)
    parser.add_argument('--weights', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--size', type=int, default=480, help='Maximum internal shortest side')
    parser.add_argument('--max-tracked-frames', type=int, default=0)
    args = parser.parse_args()
    if args.size < 16 or args.max_tracked_frames < 0:
        parser.error('Invalid size/frame limit')
    args.output.mkdir(parents=True, exist_ok=False)
    wall = time.perf_counter()
    report = {'status': 'running', 'device': 'mps', 'precision': 'float32', 'model': 'cutie-base-mega',
              'training': False, 'agent_calls': 0, 'frames': [], 'internal_shortest_side': args.size,
              'reference': str(args.reference.resolve()),
              'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              'notes': 'Original upright RGB input. One frozen reviewed frame-90 mask initializes two independent memory passes, forward and backward. Non-seed references are read after inference for scoring only. No Agent, object prompt, refresh, training or automatic outcome label. CPU media/evaluation, MPS inference with CPU fallback disabled. End-to-end includes seed, decode, tensor transfer, tracking, mask export, scoring and video encoding; excludes cold model construction/loading/download.'}

    def save():
        (args.output / 'results.json').write_text(json.dumps(report, indent=2))

    save()
    try:
        if not torch.backends.mps.is_available() or os.environ.get('PYTORCH_ENABLE_MPS_FALLBACK') == '1':
            raise RuntimeError('Requires MPS without CPU inference fallback')
        sys.path[:0] = [str(args.source.resolve()), str(args.deps.resolve())]
        from hydra import compose, initialize_config_dir
        from omegaconf import OmegaConf
        from cutie.model.cutie import CUTIE
        from cutie.inference.inference_core import InferenceCore
        torch.set_num_threads(4)
        report['source_revision'] = subprocess.check_output(['git', '-C', str(args.source), 'rev-parse', 'HEAD'], text=True).strip()
        report['source_dirty'] = subprocess.check_output(['git', '-C', str(args.source), 'status', '--porcelain'], text=True).strip()
        report['weights_md5'] = hashlib.md5(args.weights.read_bytes()).hexdigest()
        if report['weights_md5'] != 'a6071de6136982e396851903ab4c083a':
            raise RuntimeError('Checkpoint checksum differs from official release')
        started = time.perf_counter()
        with initialize_config_dir(version_base='1.3.2', config_dir=str((args.source / 'cutie/config').resolve())):
            cfg = compose(config_name='eval_config', overrides=[f'max_internal_size={args.size}', 'use_long_term=False', 'mem_every=5'])
        model = CUTIE(cfg).eval()
        # Strict state loading avoids silent uninitialized weights/conversion.
        weights = torch.load(args.weights, map_location='cpu', weights_only=True)
        model.load_state_dict(weights, strict=True)
        model = model.to('mps').eval()
        torch.mps.synchronize()
        report.update(load_seconds=time.perf_counter()-started, parameter_count=sum(p.numel() for p in model.parameters()),
                      configuration=OmegaConf.to_container(cfg, resolve=True),
                      memory_after_load=memory(torch))
        baseline = json.loads(args.reference.read_text())
        seed_index = baseline['source']['seed_frame_index']
        height, width = baseline['source']['upright_height'], baseline['source']['upright_width']
        with np.load(args.reference.parent / f'{seed_index:04d}_prediction.npz') as data:
            seed = torch.from_numpy(data['masks'][0].astype(np.int64)).to('mps')
        processing_started = time.perf_counter()
        started = time.perf_counter()
        images, timestamps = [], []
        with av.open(baseline['video']) as source:
            rate = Fraction(source.streams.video[0].average_rate)
            origin = None
            for i, frame in enumerate(source.decode(video=0)):
                image = frame.to_image().convert('RGB').rotate(frame.rotation, expand=True)
                if image.size != (width, height):
                    raise ValueError('Source/reference dimension mismatch')
                images.append(image)
                timestamp = float(frame.time) if frame.time is not None else i / float(rate)
                if origin is None:
                    origin = timestamp
                timestamps.append(timestamp - origin)
        if len(images) != baseline['source']['frames']:
            raise ValueError('Source/reference frame count mismatch')
        report['decode_seconds'] = time.perf_counter()-started
        remaining = args.max_tracked_frames or len(images)-1
        with torch.inference_mode():
            for direction in (1, -1):
                if not remaining:
                    break
                processor = InferenceCore(model, cfg=cfg)
                order = range(seed_index, len(images)) if direction == 1 else range(seed_index, -1, -1)
                for index in order:
                    if index != seed_index and not remaining:
                        break
                    torch.mps.synchronize()
                    started = time.perf_counter()
                    tensor = torch.from_numpy(np.array(images[index])).permute(2, 0, 1).to('mps', dtype=torch.float32) / 255
                    probs = processor.step(tensor, seed if index == seed_index else None,
                                           objects=[1] if index == seed_index else None,
                                           end=index == (len(images)-1 if direction == 1 else 0))
                    torch.mps.synchronize()
                    elapsed = time.perf_counter()-started
                    if index == seed_index and direction == -1:
                        report['reverse_seed_initialization_seconds'] = elapsed
                        continue
                    mask = (probs.argmax(dim=0) == 1).cpu().numpy()
                    np.savez_compressed(args.output / f'{index:04d}_prediction.npz', masks=mask[None])
                    ys, xs = np.nonzero(mask)
                    report['frames'].append({'source_frame_index': index, 'timestamp_seconds': timestamps[index],
                        'direction': direction, 'seed_frame': index == seed_index, 'model_and_transfer_seconds': elapsed,
                        'predicted_pixels': int(mask.sum()), 'mask_rle': mask_rle(mask),
                        'box_xyxy': [int(xs.min()), int(ys.min()), int(xs.max())+1, int(ys.max())+1] if len(xs) else None})
                    if index != seed_index:
                        remaining -= 1
                    if index % 30 == 0:
                        print(f'{direction:+} frame {index}: {elapsed:.3f}s, {mask.sum()} pixels', flush=True)
                        save()
        for item in report['frames']:
            index = item['source_frame_index']
            with np.load(args.output / f'{index:04d}_prediction.npz') as p, np.load(args.reference.parent / f'{index:04d}_prediction.npz') as r:
                item.update(reference_pixels=int(r['masks'][0].sum()), dice=dice(p['masks'][0], r['masks'][0]))
        report['metrics'] = metrics(report['frames'])
        report['complete_source_coverage'] = len(report['frames']) == len(images)
        if report['complete_source_coverage']:
            started = time.perf_counter()
            with av.open(str(args.output / 'segmented.mp4'), mode='w') as destination:
                encoder = destination.add_stream('libx264', rate=rate)
                encoder.width, encoder.height, encoder.pix_fmt = width, height, 'yuv420p'
                encoder.options = {'crf': '23', 'preset': 'veryfast'}
                for i, image in enumerate(images):
                    with np.load(args.output / f'{i:04d}_prediction.npz') as data:
                        preview = overlay(image, data['masks'])
                    if i % 30 == 0 or i == len(images)-1:
                        preview.save(args.output / f'{i:04d}_overlay.png')
                    out = av.VideoFrame.from_image(preview)
                    out.pts, out.time_base = i, 1 / rate
                    for packet in encoder.encode(out):
                        destination.mux(packet)
                for packet in encoder.encode():
                    destination.mux(packet)
            report['preview_encoding_seconds'] = time.perf_counter()-started
        duration = time.perf_counter()-processing_started
        tracked = [f for f in report['frames'] if not f['seed_frame']]
        report.update(processing_seconds=duration, end_to_end_fps=len(report['frames'])/duration,
                      model_and_transfer_fps=len(tracked)/sum(f['model_and_transfer_seconds'] for f in tracked) if tracked else None,
                      memory_final=memory(torch), status='completed', total_wall_seconds=time.perf_counter()-wall)
        save()
        print(json.dumps({k: report[k] for k in ('metrics', 'processing_seconds', 'end_to_end_fps', 'model_and_transfer_fps')}, indent=2), flush=True)
    except BaseException:
        report.update(status='failed', error=traceback.format_exc())
        save()
        raise


if __name__ == '__main__':
    main()

"""Frozen-seed SAM 2.1 MPS benchmark against one reviewed video; no training/Agent."""

import argparse
from fractions import Fraction
import hashlib
from importlib.metadata import version
import json
import os
from pathlib import Path
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
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--model-id', default='facebook/sam2.1-hiera-tiny')
    parser.add_argument('--max-tracked-frames', type=int, default=0, help='0 = entire clip')
    args = parser.parse_args()
    if args.max_tracked_frames < 0:
        parser.error('Frame limit must be nonnegative')
    args.output.mkdir(parents=True, exist_ok=False)
    wall = time.perf_counter()
    report = {'status': 'running', 'model': args.model_id, 'device': 'mps',
              'precision': 'float32', 'agent_calls': 0, 'training': False,
              'reference': str(args.reference.resolve()), 'frames': [],
              'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              'versions': {p: version(p) for p in ('torch', 'transformers', 'av')},
              'mps_fallback_env': os.environ.get('PYTORCH_ENABLE_MPS_FALLBACK', 'unset'),
              'notes': 'Original upright source frames, one frozen reviewed mask seed, native forward/reverse tracking. Non-seed reference masks are read only after predictions, for scoring. No semantic object prompt, outcome classifier, training or Agent. End-to-end processing includes decode/preprocess, seed, tracking, scoring, exact mask export and preview encoding; excludes cold model loading/download.'}

    def save():
        (args.output / 'results.json').write_text(json.dumps(report, indent=2))

    save()
    try:
        from huggingface_hub import hf_hub_download
        from transformers import Sam2VideoModel, Sam2VideoProcessor
        if not torch.backends.mps.is_available() or os.environ.get('PYTORCH_ENABLE_MPS_FALLBACK') == '1':
            raise RuntimeError('Requires MPS and disabled CPU inference fallback')
        torch.set_num_threads(4)
        started = time.perf_counter()
        config = Path(hf_hub_download(args.model_id, 'config.json'))
        report['revision'] = config.parent.name
        model, loading = Sam2VideoModel.from_pretrained(
            args.model_id, revision=report['revision'], dtype=torch.float32, output_loading_info=True)
        report['loading_info'] = {k: sorted(v) if isinstance(v, set) else v for k, v in loading.items()}
        if any(loading.get(k) for k in ('missing_keys', 'mismatched_keys', 'error_msgs', 'unexpected_keys')):
            raise RuntimeError('Checkpoint mismatch; refusing incomplete/random-weight benchmark')
        model = model.to('mps').eval()
        processor = Sam2VideoProcessor.from_pretrained(args.model_id, revision=report['revision'])
        torch.mps.synchronize()
        report['load_seconds'] = time.perf_counter() - started
        report['parameter_count'] = sum(p.numel() for p in model.parameters())
        report['memory_after_load'] = memory(torch)
        print(f"Loaded {args.model_id}: {report['parameter_count']:,} parameters", flush=True)
        baseline = json.loads(args.reference.read_text())
        seed_index = baseline['source']['seed_frame_index']
        height, width = baseline['source']['upright_height'], baseline['source']['upright_width']
        with np.load(args.reference.parent / f'{seed_index:04d}_prediction.npz') as data:
            seed_mask = data['masks'][0]
        processing_started = time.perf_counter()
        session = processor.init_video_session(inference_device='mps', inference_state_device='cpu',
                                               processing_device='cpu', video_storage_device='cpu', dtype=torch.float32)
        timestamps = []
        started = time.perf_counter()
        with av.open(baseline['video']) as source:
            stream = source.streams.video[0]
            rate = Fraction(stream.average_rate)
            origin = None
            for i, frame in enumerate(source.decode(stream)):
                timestamp = float(frame.time) if frame.time is not None else i / float(rate)
                if origin is None:
                    origin = timestamp
                timestamps.append(timestamp - origin)
                image = frame.to_image().convert('RGB').rotate(frame.rotation, expand=True)
                if image.size != (width, height):
                    raise ValueError('Source/reference upright dimensions differ')
                inputs = processor(images=image, device='cpu', return_tensors='pt')
                session.add_new_frame(inputs.pixel_values[0], frame_idx=i)
        if len(timestamps) != baseline['source']['frames']:
            raise ValueError('Source/reference frame counts differ')
        report['decode_preprocess_seconds'] = time.perf_counter() - started
        processor.add_inputs_to_inference_session(session, frame_idx=seed_index, obj_ids=1, input_masks=seed_mask)

        def record(output, elapsed, direction):
            index = int(output.frame_idx)
            mask = processor.post_process_masks([output.pred_masks], original_sizes=[[height, width]])[0]
            mask = mask.detach().cpu().numpy().astype(bool).reshape(-1, height, width)[0]
            np.savez_compressed(args.output / f'{index:04d}_prediction.npz', masks=mask[None])
            ys, xs = np.nonzero(mask)
            report['frames'].append({'source_frame_index': index, 'timestamp_seconds': timestamps[index],
                'direction': direction, 'seed_frame': index == seed_index, 'model_seconds': elapsed,
                'predicted_pixels': int(mask.sum()), 'box_xyxy': [int(xs.min()), int(ys.min()), int(xs.max())+1, int(ys.max())+1] if len(xs) else None,
                'mask_rle': mask_rle(mask), 'object_score_logits': output.object_score_logits.detach().cpu().reshape(-1).tolist()})
            if index % 30 == 0:
                save()
                print(f'{direction} frame {index}: {elapsed:.3f}s; {mask.sum()} pixels', flush=True)

        started = time.perf_counter()
        with torch.inference_mode():
            output = model(inference_session=session, frame_idx=seed_index)
        torch.mps.synchronize()
        report['seed_initialization_seconds'] = time.perf_counter() - started
        record(output, report['seed_initialization_seconds'], 'seed')
        remaining = args.max_tracked_frames or len(timestamps) - 1
        with torch.inference_mode():
            for direction in ('forward', 'backward'):
                iterator = model.propagate_in_video_iterator(session, start_frame_idx=seed_index, reverse=direction == 'backward')
                while remaining:
                    torch.mps.synchronize()
                    started = time.perf_counter()
                    try:
                        output = next(iterator)
                    except StopIteration:
                        break
                    torch.mps.synchronize()
                    elapsed = time.perf_counter() - started
                    if int(output.frame_idx) == seed_index:
                        continue
                    record(output, elapsed, direction)
                    remaining -= 1
        report['tracking_and_mask_export_seconds'] = time.perf_counter() - processing_started - report['decode_preprocess_seconds']
        # Scoring is deliberately separate from inference and never changes predictions.
        for item in report['frames']:
            index = item['source_frame_index']
            with np.load(args.output / f'{index:04d}_prediction.npz') as p, np.load(args.reference.parent / f'{index:04d}_prediction.npz') as r:
                item['reference_pixels'] = int(r['masks'][0].sum())
                item['dice'] = dice(p['masks'][0], r['masks'][0])
        report['metrics'] = metrics(report['frames'])
        report['complete_source_coverage'] = len(report['frames']) == len(timestamps)
        if report['complete_source_coverage']:
            started = time.perf_counter()
            with av.open(baseline['video']) as source, av.open(str(args.output / 'segmented.mp4'), mode='w') as destination:
                encoder = destination.add_stream('libx264', rate=rate)
                encoder.width, encoder.height, encoder.pix_fmt = width, height, 'yuv420p'
                encoder.options = {'crf': '23', 'preset': 'veryfast'}
                for i, frame in enumerate(source.decode(video=0)):
                    image = frame.to_image().convert('RGB').rotate(frame.rotation, expand=True)
                    with np.load(args.output / f'{i:04d}_prediction.npz') as data:
                        preview = overlay(image, data['masks'])
                    if i % 30 == 0 or i == len(timestamps) - 1:
                        preview.save(args.output / f'{i:04d}_overlay.png')
                    out = av.VideoFrame.from_image(preview)
                    out.pts, out.time_base = i, 1 / rate
                    for packet in encoder.encode(out):
                        destination.mux(packet)
                for packet in encoder.encode():
                    destination.mux(packet)
            report['preview_encoding_seconds'] = time.perf_counter() - started
        duration = time.perf_counter() - processing_started
        tracked = [f for f in report['frames'] if not f['seed_frame']]
        report.update(processing_seconds=duration, end_to_end_fps=len(report['frames']) / duration,
                      model_fps=len(tracked) / sum(f['model_seconds'] for f in tracked) if tracked else None,
                      memory_final=memory(torch), status='completed', total_wall_seconds=time.perf_counter()-wall)
        save()
        print(json.dumps({k: report[k] for k in ('metrics', 'processing_seconds', 'end_to_end_fps', 'model_fps')}, indent=2), flush=True)
    except BaseException:
        report.update(status='failed', error=traceback.format_exc())
        save()
        raise


if __name__ == '__main__':
    main()

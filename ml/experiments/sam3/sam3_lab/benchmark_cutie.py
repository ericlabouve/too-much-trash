"""Benchmark Cutie on MPS with a reviewed seed or one-second SAM 3 anchors."""

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
from .inference import MODEL_ID, overlay
from .video import mask_rle


def one_second_samples(timestamps):
    """Select the first decoded frame at or after each whole source second."""
    times = np.asarray(timestamps)
    indices = np.searchsorted(times + 1e-6, np.arange(int(times[-1] + 1e-6) + 1))
    return sorted(set(indices.tolist()))


def anchor_gaps(frame_count, anchors):
    """Yield each non-anchor interval, bounded by zero-based anchor indices."""
    boundaries = [None, *sorted(anchors), None]
    for left, right in zip(boundaries, boundaries[1:]):
        start = 0 if left is None else left + 1
        stop = frame_count if right is None else right
        if start < stop:
            yield left, right, range(start, stop)


def gap_seed_indices(left, right, policy):
    """Always backfill before the first anchor; only the control backtracks interior gaps."""
    return left, right if left is None or policy == 'bidirectional' else None


def choose_gap_mask(index, left, right, forward, backward):
    if forward is None and backward is None:
        raise ValueError('At least one directional prediction is required')
    agreement = None
    if forward is not None and backward is not None:
        union = (forward | backward).sum()
        agreement = float((forward & backward).sum() / union) if union else 1.0
    use_forward = backward is None or (forward is not None and index - left <= right - index)
    return (forward, 'forward', agreement) if use_forward else (backward, 'backward', agreement)


def sam3_anchors(images, timestamps, baseline, args, report, save, update):
    from transformers import Sam3Model, Sam3Processor

    started = time.perf_counter()
    model = Sam3Model.from_pretrained(baseline['model'], revision=baseline['revision'],
                                     local_files_only=True, dtype=torch.float32).to('mps').eval()
    processor = Sam3Processor.from_pretrained(baseline['model'], revision=baseline['revision'],
                                             local_files_only=True)
    torch.mps.synchronize()
    report['sam_load_seconds'] = time.perf_counter() - started
    report['sam_revision'] = baseline['revision']
    report['sam_attempts'] = []
    anchors = {}
    samples = one_second_samples(timestamps)
    for n, i in enumerate(samples):
        started = time.perf_counter()
        inputs = processor(images=images[i], text=args.sam_prompt, return_tensors='pt').to('mps')
        with torch.inference_mode():
            output = model(**inputs)
            prediction = processor.post_process_instance_segmentation(
                output, threshold=args.sam_threshold, mask_threshold=.5,
                target_sizes=[(images[i].height, images[i].width)])[0]
        masks = prediction['masks'].detach().cpu().numpy().astype(bool)
        scores = prediction['scores'].detach().cpu().numpy()
        torch.mps.synchronize()
        elapsed = time.perf_counter() - started
        usable = [j for j, mask in enumerate(masks) if mask.any()]
        if len(usable) == 1:
            anchors[i] = masks[usable[0]]
        status = 'accepted' if len(usable) == 1 else 'ambiguous' if usable else 'empty'
        report['sam_attempts'].append({'frame_index': i, 'timestamp_seconds': timestamps[i],
            'status': status, 'candidate_scores': scores.tolist(), 'nonempty_candidate_count': len(usable),
            'accepted_candidate': usable[0] if status == 'accepted' else None, 'seconds': elapsed})
        np.savez_compressed(args.output / f'anchor_{i:04d}.npz', masks=masks, scores=scores)
        print(f'SAM 3 frame {i} ({timestamps[i]:.2f}s): {status}, {elapsed:.2f}s', flush=True)
        save()
        update(.1 + .3 * (n + 1) / len(samples), f'SAM 3 anchors: {n + 1}/{len(samples)} sampled')
    return anchors


def parse_args(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('reference', type=Path)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--deps', type=Path, required=True)
    parser.add_argument('--weights', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--size', type=int, default=480, help='Maximum internal shortest side')
    parser.add_argument('--max-tracked-frames', type=int, default=0)
    parser.add_argument('--sam-prompt', help='Use fresh SAM 3 candidates every second instead of the reviewed seed')
    parser.add_argument('--sam-threshold', type=float, default=.5)
    parser.add_argument('--anchor-policy', choices=('forward-after-first', 'bidirectional'),
                        help='Default with --sam-prompt: backfill before the first usable anchor, then track forward')
    args = parser.parse_args(argv)
    if args.size < 16 or args.max_tracked_frames < 0:
        parser.error('Invalid size/frame limit')
    if not 0 <= args.sam_threshold <= 1 or (args.sam_prompt is not None and not args.sam_prompt.strip()):
        parser.error('Use a nonempty prompt and a threshold between zero and one')
    if args.sam_prompt is not None and args.max_tracked_frames:
        parser.error('One-second anchor mode requires a full clip')
    if args.sam_prompt is None and args.anchor_policy is not None:
        parser.error('--anchor-policy requires --sam-prompt')
    if args.sam_prompt is not None and args.anchor_policy is None:
        args.anchor_policy = 'forward-after-first'
    return args


def main():
    run(parse_args())


def run(args, progress=None):
    """Run the CLI benchmark or track a standalone upload without evaluation masks."""
    def update(fraction, message):
        if progress is not None:
            progress(fraction, desc=message)

    args.output.mkdir(parents=True, exist_ok=False)
    wall = time.perf_counter()
    report = {'status': 'running', 'device': 'mps', 'precision': 'float32', 'model': 'cutie-base-mega',
              'training': False, 'agent_calls': 0, 'frames': [], 'internal_shortest_side': args.size,
              'reference': str(args.reference.resolve()) if args.reference is not None else None,
              'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              'notes': 'Original upright RGB input. One frozen reviewed frame-90 mask initializes two independent memory passes, forward and backward. Non-seed references are read after inference for scoring only. No Agent, object prompt, refresh, training or automatic outcome label. CPU media/evaluation, MPS inference with CPU fallback disabled. End-to-end includes seed, decode, tensor transfer, tracking, mask export, scoring and video encoding; excludes cold model construction/loading/download.'}
    if args.sam_prompt is not None:
        tracking_notes = {
            'bidirectional': 'Independent Cutie passes from both neighboring anchors, nearest anchor wins (earlier on a tie); IoU below 0.50 flags disagreement for review. Tails use the nearest available anchor.',
            'forward-after-first': 'Cutie backfills only before the first usable anchor. Afterward each accepted anchor starts a fresh forward pass to the next one or the end. No directional disagreement check.',
        }
        report.update(sam_prompt=args.sam_prompt, sam_threshold=args.sam_threshold, anchor_interval_seconds=1,
                      anchor_policy=args.anchor_policy,
                      notes='Fresh text-prompted SAM 3 on upright source frames each second. Accept exactly one nonempty candidate; this is not proof of target identity. '
                            + tracking_notes[args.anchor_policy]
                            + ' Reference masks, if supplied, are used only for scoring. No Agent, training or outcome label. MPS float32, CPU inference fallback disabled. Processing includes all anchor attempts, tracking, decode and exports; excludes cold model loading.')

    def save():
        (args.output / 'results.json').write_text(json.dumps(report, indent=2))

    save()
    try:
        if not torch.backends.mps.is_available() or os.environ.get('PYTORCH_ENABLE_MPS_FALLBACK') == '1':
            raise RuntimeError('Requires MPS without CPU inference fallback')
        if not args.source.is_dir() or not args.deps.is_dir() or not args.weights.is_file():
            raise ValueError('Cutie setup is missing. See the SAM 3 lab README for source, dependencies and weights.')
        update(0, 'Loading Cutie')
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
        baseline = json.loads(args.reference.read_text()) if args.reference is not None else {
            'video': str(args.video), 'model': MODEL_ID, 'revision': None,
        }
        if args.sam_prompt is None:
            seed_index = baseline['source']['seed_frame_index']
            with np.load(args.reference.parent / f'{seed_index:04d}_prediction.npz') as data:
                seed = torch.from_numpy(data['masks'][0].astype(np.int64)).to('mps')
        processing_started = time.perf_counter()
        update(.05, 'Decoding upright frames')
        started = time.perf_counter()
        images, timestamps = [], []
        with av.open(baseline['video']) as source:
            if not source.streams.video:
                raise ValueError('Upload must contain a video stream')
            rate = Fraction(source.streams.video[0].average_rate or 30)
            origin = None
            for i, frame in enumerate(source.decode(video=0)):
                image = frame.to_image().convert('RGB').rotate(frame.rotation, expand=True)
                if images and image.size != images[0].size:
                    raise ValueError('Video dimensions changed mid-clip')
                if args.reference is None and (i + 1) * image.width * image.height * 4 > 2 * 1024**3:
                    raise ValueError('Clip is too large for the in-memory viewer. Trim it or reduce its resolution.')
                images.append(image)
                timestamp = float(frame.time) if frame.time is not None else i / float(rate)
                if origin is None:
                    origin = timestamp
                timestamps.append(timestamp - origin)
        if not images:
            raise ValueError('Video contains no decodable frames')
        width, height = images[0].size
        if args.reference is not None and (width, height) != (baseline['source']['upright_width'], baseline['source']['upright_height']):
            raise ValueError('Source/reference dimension mismatch')
        if args.reference is not None and len(images) != baseline['source']['frames']:
            raise ValueError('Source/reference frame count mismatch')
        report['decode_seconds'] = time.perf_counter()-started
        def track_step(processor, index, mask=None, end=False):
            torch.mps.synchronize()
            started = time.perf_counter()
            tensor = torch.from_numpy(np.array(images[index])).permute(2, 0, 1).to('mps', dtype=torch.float32) / 255
            probs = processor.step(tensor, mask, objects=[1] if mask is not None else None, end=end)
            torch.mps.synchronize()
            elapsed = time.perf_counter()-started
            return (probs.argmax(dim=0) == 1).cpu().numpy(), elapsed

        def record(index, mask, elapsed, direction, is_seed, **extra):
            np.savez_compressed(args.output / f'{index:04d}_prediction.npz', masks=mask[None])
            ys, xs = np.nonzero(mask)
            report['frames'].append({'source_frame_index': index, 'timestamp_seconds': timestamps[index],
                'direction': direction, 'seed_frame': is_seed, 'model_and_transfer_seconds': elapsed,
                'predicted_pixels': int(mask.sum()), 'mask_rle': mask_rle(mask),
                'box_xyxy': [int(xs.min()), int(ys.min()), int(xs.max())+1, int(ys.max())+1] if len(xs) else None,
                **extra})

        def run_frozen_seed():
            remaining = args.max_tracked_frames or len(images)-1
            for direction in (1, -1):
                if not remaining:
                    break
                processor = InferenceCore(model, cfg=cfg)
                order = range(seed_index, len(images)) if direction == 1 else range(seed_index, -1, -1)
                for index in order:
                    if index != seed_index and not remaining:
                        break
                    mask, elapsed = track_step(processor, index, seed if index == seed_index else None,
                                               end=index == (len(images)-1 if direction == 1 else 0))
                    if index == seed_index and direction == -1:
                        report['reverse_seed_initialization_seconds'] = elapsed
                        continue
                    record(index, mask, elapsed, direction, index == seed_index)
                    if index != seed_index:
                        remaining -= 1
                    if index % 30 == 0:
                        print(f'{direction:+} frame {index}: {elapsed:.3f}s, {mask.sum()} pixels', flush=True)
                        save()

        def run_sampled_anchors(anchors):
            report['accepted_anchor_frames'] = sorted(anchors)
            report['cutie_seed_calls'] = 0
            report['cutie_prediction_calls'] = 0
            report['cutie_seed_seconds'] = 0.0
            report['cutie_directional_timing'] = {
                d: {'seed_calls': 0, 'seed_seconds': 0., 'prediction_calls': 0, 'model_and_transfer_seconds': 0.}
                for d in ('forward', 'backward')}

            def pass_from(anchor, order, direction):
                if anchor is None:
                    return {}
                processor = InferenceCore(model, cfg=cfg)
                mask = torch.from_numpy(anchors[anchor].astype(np.int64)).to('mps')
                _, elapsed = track_step(processor, anchor, mask)
                report['cutie_seed_calls'] += 1
                report['cutie_seed_seconds'] += elapsed
                report['cutie_prediction_calls'] += len(order)
                predictions = {i: track_step(processor, i, end=i == order[-1]) for i in order}
                timing = report['cutie_directional_timing'][direction]
                timing['seed_calls'] += 1
                timing['seed_seconds'] += elapsed
                timing['prediction_calls'] += len(order)
                timing['model_and_transfer_seconds'] += sum(t for _, t in predictions.values())
                return predictions

            for i, mask in anchors.items():
                record(i, mask, 0., 'sam3_anchor', True, needs_review=False)
            for left, right, gap in anchor_gaps(len(images), anchors):
                forward_seed, backward_seed = gap_seed_indices(left, right, args.anchor_policy)
                forward = pass_from(forward_seed, gap, 'forward')
                backward = pass_from(backward_seed, gap[::-1], 'backward')
                for i in gap:
                    f, ft = forward.get(i, (None, 0.))
                    b, bt = backward.get(i, (None, 0.))
                    if f is None and b is None:
                        record(i, np.zeros((height, width), bool), 0., 'no_anchor', False, needs_review=True)
                    else:
                        mask, direction, iou = choose_gap_mask(i, left, right, f, b)
                        record(i, mask, ft+bt, direction, False, left_anchor=left, right_anchor=right,
                               directional_iou=iou, needs_review=iou is not None and iou < .5)
                print(f'Cutie gap {gap[0]}–{gap[-1]}, anchors {left}/{right}', flush=True)
                save()
                update(.45 + .4 * (gap[-1] + 1) / len(images), 'Tracking gaps with Cutie')

        if args.sam_prompt is not None:
            update(.1, 'Sampling SAM 3 anchors')
            anchors = sam3_anchors(images, timestamps, baseline, args, report, save, update)
            torch.mps.empty_cache()
            with torch.inference_mode():
                run_sampled_anchors(anchors)
        else:
            with torch.inference_mode():
                run_frozen_seed()
        report['frames'].sort(key=lambda f: f['source_frame_index'])
        if args.reference is not None:
            for item in report['frames']:
                index = item['source_frame_index']
                with np.load(args.output / f'{index:04d}_prediction.npz') as p, np.load(args.reference.parent / f'{index:04d}_prediction.npz') as r:
                    item.update(reference_pixels=int(r['masks'][0].sum()), dice=dice(p['masks'][0], r['masks'][0]))
            report['metrics'] = metrics(report['frames'])
        report['complete_source_coverage'] = len(report['frames']) == len(images)
        if report['complete_source_coverage']:
            update(.9, 'Encoding overlay and exporting masks')
            started = time.perf_counter()
            with av.open(str(args.output / 'segmented.mp4'), mode='w') as destination:
                encoder = destination.add_stream('libx264', rate=rate)
                encoder.width, encoder.height, encoder.pix_fmt = width + width % 2, height + height % 2, 'yuv420p'
                encoder.options = {'crf': '23', 'preset': 'veryfast'}
                for i, image in enumerate(images):
                    with np.load(args.output / f'{i:04d}_prediction.npz') as data:
                        preview = overlay(image, data['masks'])
                    if i % 30 == 0 or i == len(images)-1:
                        preview.save(args.output / f'{i:04d}_overlay.png')
                    if preview.size != (encoder.width, encoder.height):
                        from PIL import Image
                        padded = Image.new('RGB', (encoder.width, encoder.height))
                        padded.paste(preview, (0, 0))
                        preview = padded
                    out = av.VideoFrame.from_image(preview)
                    out.pts, out.time_base = i, 1 / rate
                    for packet in encoder.encode(out):
                        destination.mux(packet)
                for packet in encoder.encode():
                    destination.mux(packet)
            report['preview_encoding_seconds'] = time.perf_counter()-started
        duration = time.perf_counter()-processing_started-report.get('sam_load_seconds', 0.)
        tracked = [f for f in report['frames'] if not f['seed_frame']]
        tracked_seconds = sum(f['model_and_transfer_seconds'] for f in tracked)
        report.update(processing_seconds=duration, end_to_end_fps=len(report['frames'])/duration,
                      model_and_transfer_fps=report.get('cutie_prediction_calls', len(tracked))/tracked_seconds if tracked_seconds else None,
                      memory_final=memory(torch), status='completed', total_wall_seconds=time.perf_counter()-wall)
        save()
        update(1, 'Done')
        print(json.dumps({k: report.get(k) for k in ('metrics', 'processing_seconds', 'end_to_end_fps', 'model_and_transfer_fps')}, indent=2), flush=True)
        return report
    except BaseException:
        report.update(status='failed', error=traceback.format_exc())
        save()
        raise


if __name__ == '__main__':
    main()

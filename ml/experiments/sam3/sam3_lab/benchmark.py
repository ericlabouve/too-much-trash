"""Measure independent SAM 3 image predictions on sampled video frames."""

import argparse
from importlib.metadata import version
import json
from pathlib import Path
import platform
import statistics
import time

import numpy as np

from .inference import MODEL_ID, load_model, overlay, segment


def sample_video(path, start, end, count):
    import av

    targets = np.linspace(start, end, count)
    samples = []
    started = time.perf_counter()
    with av.open(str(path)) as container:
        stream = container.streams.video[0]
        metadata = {
            'width': stream.width,
            'height': stream.height,
            'source_fps': float(stream.average_rate) if stream.average_rate else None,
            'duration_seconds': float(stream.duration * stream.time_base) if stream.duration else None,
        }
        for frame in container.decode(stream):
            if frame.time is None or frame.time < targets[len(samples)]:
                continue
            samples.append((float(frame.time), frame.to_image().convert('RGB')))
            if len(samples) == count:
                break
    if len(samples) != count:
        raise ValueError(f'{path}: decoded {len(samples)} of {count} requested samples')
    return samples, metadata, time.perf_counter() - started


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('manifest', type=Path)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--frames', type=int, default=8)
    parser.add_argument('--threshold', type=float, default=0.5)
    parser.add_argument('--prompt', help='Override the annotated object phrase')
    parser.add_argument('--video-id', action='append', help='Select an ID; repeat for multiple videos')
    args = parser.parse_args()
    if args.frames < 2:
        parser.error('--frames must be at least 2')
    if not 0 <= args.threshold <= 1:
        parser.error('--threshold must be between 0 and 1')
    args.output.mkdir(parents=True, exist_ok=True)
    manifest = json.loads(args.manifest.read_text())
    prepared = []
    for video in manifest['videos']:
        if args.video_id and video['id'] not in args.video_id:
            continue
        video = dict(video, action=dict(video['action']))
        if args.prompt:
            video['action']['prompt'] = args.prompt
        action = video['action']
        start = max(0, action['start'] - 0.5)
        end = min(video['length'] - 0.1, action['end'] + 0.5)
        samples, metadata, decode_seconds = sample_video(video['path'], start, end, args.frames)
        prepared.append((video, samples, metadata, decode_seconds, start, end))
    if not prepared:
        parser.error('manifest must contain videos')

    import torch

    started = time.perf_counter()
    model, _, device = load_model()
    if device == 'mps':
        torch.mps.synchronize()
    elif device == 'cuda':
        torch.cuda.synchronize()
    load_seconds = time.perf_counter() - started
    warmup = segment(prepared[0][1][0][1], prepared[0][0]['action']['prompt'], args.threshold)
    revision = getattr(model.config, '_commit_hash', None)
    if revision is None and not Path(MODEL_ID).exists():
        from huggingface_hub import hf_hub_download

        revision = Path(hf_hub_download(MODEL_ID, 'config.json', local_files_only=True)).parent.name
    record = {
        'model': MODEL_ID,
        'revision': revision,
        'device': device,
        'precision': 'float32',
        'python': platform.python_version(),
        'versions': {p: version(p) for p in ('torch', 'torchvision', 'transformers', 'av')},
        'load_seconds': load_seconds,
        'warmup_seconds': warmup.elapsed_seconds,
        'method': 'Sequential independent image predictions; sampled frames, no temporal tracking. Load, warmup, decoding, and artifact writes reported separately.',
        'videos': [],
    }
    all_times = []
    for video, samples, metadata, decode_seconds, start, end in prepared:
        folder = args.output / video['id']
        folder.mkdir(exist_ok=True)
        prediction_seconds = 0
        artifact_seconds = 0
        frames = []
        for index, (timestamp, image) in enumerate(samples):
            started = time.perf_counter()
            result = segment(image, video['action']['prompt'], args.threshold)
            elapsed = time.perf_counter() - started
            prediction_seconds += elapsed
            all_times.append(elapsed)
            started = time.perf_counter()
            image.save(folder / f'{index:03d}_source.png')
            overlay(image, result.masks).save(folder / f'{index:03d}_overlay.png')
            np.savez_compressed(folder / f'{index:03d}_prediction.npz', masks=result.masks, boxes=result.boxes, scores=result.scores)
            artifact_seconds += time.perf_counter() - started
            frames.append({'timestamp': timestamp, 'seconds': elapsed, 'mask_count': len(result.masks), 'scores': result.scores.tolist(), 'boxes': result.boxes.tolist()})
            print(f'{video["id"]} frame {index + 1}/{len(samples)}: {elapsed:.2f}s, {len(result.masks)} masks', flush=True)
        inference_fps = len(samples) / prediction_seconds
        source_fps = metadata['source_fps']
        full_window_frames = (end - start) * source_fps if source_fps else None
        item = {
            'id': video['id'], 'action': video['action'], 'threshold': args.threshold,
            **metadata, 'window_start': start, 'window_end': end,
            'sample_count': len(samples), 'prediction_seconds': prediction_seconds,
            'decode_seconds': decode_seconds, 'artifact_seconds': artifact_seconds,
            'inference_fps': inference_fps,
            'sampled_pipeline_fps': len(samples) / (prediction_seconds + decode_seconds + artifact_seconds),
            'projected_all_frame_window_processing_seconds': full_window_frames / inference_fps if full_window_frames else None,
            'frames': frames,
        }
        record['videos'].append(item)
        (args.output / 'results.json').write_text(json.dumps(record, indent=2))
    record['aggregate'] = {
        'frames': len(all_times),
        'inference_seconds': sum(all_times),
        'inference_fps': len(all_times) / sum(all_times),
        'median_frame_seconds': statistics.median(all_times),
        'p95_frame_seconds': float(np.percentile(all_times, 95)),
        'projected_30fps_one_minute_processing_seconds': 1800 * statistics.mean(all_times),
        'projected_1fps_one_minute_processing_seconds': 60 * statistics.mean(all_times),
        'projected_quarter_fps_one_minute_processing_seconds': 15 * statistics.mean(all_times),
    }
    (args.output / 'results.json').write_text(json.dumps(record, indent=2))
    print(json.dumps(record['aggregate'], indent=2), flush=True)


if __name__ == '__main__':
    main()

"""Reproducible local SAM 3 tracker benchmark; fixed visual seed, no Agent."""

import argparse
from fractions import Fraction
from importlib.metadata import version
import json
from pathlib import Path
import platform
import resource
import time
import traceback

import av
import numpy as np

from .inference import overlay
from .video import mask_rle


def memory(torch):
    # macOS reports ru_maxrss in bytes; this is process RSS, not system RAM.
    result = {'process_peak_rss_bytes': resource.getrusage(resource.RUSAGE_SELF).ru_maxrss}
    if torch.backends.mps.is_available():
        result.update(mps_tensor_bytes=torch.mps.current_allocated_memory(),
                      mps_driver_bytes=torch.mps.driver_allocated_memory())
    return result


def summarize(frames):
    measured = [f for f in frames if not f['seed_frame']]
    if not measured:
        return {}
    times = [f['model_seconds'] for f in measured]
    process_times = [f['processed_frame_seconds'] for f in measured]
    return {'tracked_frames': len(measured), 'model_seconds': sum(times),
            'model_fps': len(times) / sum(times),
            'median_model_seconds': float(np.median(times)),
            'p95_model_seconds': float(np.percentile(times, 95)),
            'processed_frame_seconds': sum(process_times),
            'processed_frame_fps': len(times) / sum(process_times)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('video', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--seed-seconds', type=float, default=3)
    parser.add_argument('--points', type=float, nargs='+', required=True,
                        help='x y label triples in upright source pixels; 1 positive, 0 negative')
    parser.add_argument('--max-tracked-frames', type=int, default=8,
                        help='Non-seed frame limit; 0 runs the complete video')
    parser.add_argument('--model-id', default='facebook/sam3')
    args = parser.parse_args()
    wall_started = time.perf_counter()
    if (not args.video.is_file() or len(args.points) % 3 or args.max_tracked_frames < 0
            or args.seed_seconds < 0 or not np.isfinite(args.points).all()
            or not np.isfinite(args.seed_seconds) or any(v not in (0, 1) for v in args.points[2::3])
            or 1 not in args.points[2::3]):
        parser.error('Video must exist, points must be triples, frame limit must be nonnegative')
    args.output.mkdir(parents=True, exist_ok=False)
    report_path = args.output / 'results.json'
    report = {'status': 'running', 'video': str(args.video.resolve()),
              'model': args.model_id, 'seed_seconds_requested': args.seed_seconds,
              'seed_method': 'Manual visual point prompts for tracker benchmarking only. No Agent or outcome labeling.',
              'point_prompts_upright_xy_label': args.points,
              'precision': 'float32', 'device': 'mps', 'python': platform.python_version(),
              'versions': {p: version(p) for p in ('torch', 'transformers', 'torchvision', 'av')},
              'timing_method': 'Native propagate_in_video_iterator, MPS synchronize around next(iterator). Frame processing includes inference, source-size mask transfer and compressed masks/sparse overlays; loading, preprocessing, JSON writes, seed and final preview encoding reported separately.',
              'frames': []}

    def save():
        report['summary'] = summarize(report['frames'])
        report_path.write_text(json.dumps(report, indent=2))

    save()
    try:
        import torch
        from huggingface_hub import hf_hub_download
        from transformers import Sam3TrackerVideoModel, Sam3TrackerVideoProcessor

        if not torch.backends.mps.is_available():
            raise RuntimeError('MPS unavailable; refusing to silently benchmark CPU')
        torch.set_num_threads(4)
        report['memory_before_load'] = memory(torch)
        started = time.perf_counter()
        config_path = Path(hf_hub_download(args.model_id, 'config.json', local_files_only=True))
        report['revision'] = config_path.parent.name
        model, loading = Sam3TrackerVideoModel.from_pretrained(
            args.model_id, local_files_only=True, dtype=torch.float32, output_loading_info=True)
        report['loading_info'] = {k: sorted(v) if isinstance(v, set) else v
                                  for k, v in loading.items() if k != 'unexpected_keys'}
        report['unexpected_key_count'] = len(loading.get('unexpected_keys', []))
        if loading.get('missing_keys') or loading.get('mismatched_keys') or loading.get('error_msgs'):
            raise RuntimeError('Checkpoint did not fully initialize tracker; refusing random-weight benchmark')
        model = model.to('mps').eval()
        processor = Sam3TrackerVideoProcessor.from_pretrained(args.model_id, local_files_only=True)
        torch.mps.synchronize()
        report['load_seconds'] = time.perf_counter() - started
        report['parameter_count'] = sum(p.numel() for p in model.parameters())
        report['memory_after_load'] = memory(torch)
        save()
        print(f"Loaded {report['parameter_count']:,} parameters on MPS in {report['load_seconds']:.2f}s", flush=True)

        # First scan locates the seed and metadata without retaining raw frames.
        started = time.perf_counter()
        with av.open(str(args.video)) as source:
            stream = source.streams.video[0]
            origin = None
            timestamps = []
            seed_image = None
            for i, frame in enumerate(source.decode(stream)):
                raw = float(frame.time) if frame.time is not None else i / float(stream.average_rate)
                if origin is None:
                    origin = raw
                timestamp = raw - origin
                timestamps.append(timestamp)
                if seed_image is None and timestamp >= args.seed_seconds:
                    seed_index = i
                    rotation = frame.rotation
                    seed_image = frame.to_image().convert('RGB').rotate(rotation, expand=True)
            if seed_image is None:
                raise ValueError('Seed timestamp outside video')
            fps = float(stream.average_rate)
        report['source'] = {'frames': len(timestamps), 'fps': fps,
                            'duration_seconds': timestamps[-1] + 1 / fps,
                            'upright_width': seed_image.width, 'upright_height': seed_image.height,
                            'rotation_degrees_applied': rotation, 'seed_frame_index': seed_index,
                            'seed_timestamp_seconds': timestamps[seed_index]}
        report['metadata_decode_seconds'] = time.perf_counter() - started
        seed_image.save(args.output / 'seed_source.png')
        if any(not 0 <= x < seed_image.width or not 0 <= y < seed_image.height
               for x, y in zip(args.points[::3], args.points[1::3])):
            raise ValueError('Point outside upright source image')
        points = [[[[args.points[i], args.points[i+1]] for i in range(0, len(args.points), 3)]]]
        labels = [[[int(args.points[i+2]) for i in range(0, len(args.points), 3)]]]
        remaining = args.max_tracked_frames or len(timestamps)

        # Populate the documented session frame store incrementally on CPU to
        # avoid a second full-video stacked tensor during preprocessing.
        session = processor.init_video_session(
            inference_device='mps', inference_state_device='cpu',
            processing_device='cpu', video_storage_device='cpu', dtype=torch.float32)
        started = time.perf_counter()
        with av.open(str(args.video)) as source:
            for i, frame in enumerate(source.decode(source.streams.video[0])):
                image = frame.to_image().convert('RGB').rotate(rotation, expand=True)
                inputs = processor(images=image, device='cpu', return_tensors='pt')
                session.add_new_frame(inputs.pixel_values[0], frame_idx=i)
        report['session_decode_preprocessing_seconds'] = time.perf_counter() - started
        report['memory_after_preprocessing'] = memory(torch)
        report['processed_video_cpu_bytes'] = sum(t.numel() * t.element_size() for t in session.processed_frames.values())
        processor.add_inputs_to_inference_session(
            session, frame_idx=seed_index, obj_ids=1, input_points=points, input_labels=labels,
            original_size=(seed_image.height, seed_image.width))

        def record(output, image, direction, seconds, total_started, seed=False):
            source_index = int(output.frame_idx)
            masks = processor.post_process_masks(
                [output.pred_masks], original_sizes=[[seed_image.height, seed_image.width]])[0]
            masks = masks.detach().cpu().numpy().astype(bool).reshape(-1, seed_image.height, seed_image.width)
            scores = output.object_score_logits.detach().cpu().reshape(-1).tolist()
            np.savez_compressed(args.output / f'{source_index:04d}_prediction.npz', masks=masks, object_score_logits=scores)
            if image is not None:
                overlay(image, masks).save(args.output / f'{source_index:04d}_overlay.png')
            mask = masks[0]
            ys, xs = np.nonzero(mask)
            box = [int(xs.min()), int(ys.min()), int(xs.max()) + 1, int(ys.max()) + 1] if len(xs) else None
            item = {'source_frame_index': source_index, 'timestamp_seconds': timestamps[source_index],
                    'direction': direction, 'object_id': 1, 'seed_frame': seed, 'model_seconds': seconds,
                    'mask_pixels': int(masks.sum()), 'object_score_logits': scores,
                    'box_xyxy': box, 'mask_rle': mask_rle(mask), 'memory': memory(torch)}
            item['processed_frame_seconds'] = time.perf_counter() - total_started
            report['frames'].append(item)
            save()
            print(f'{direction} source frame {source_index}: {seconds:.2f}s model; {item["mask_pixels"]} pixels', flush=True)

        torch.mps.synchronize()
        started = time.perf_counter()
        with torch.inference_mode():
            seed_output = model(inference_session=session, frame_idx=seed_index)
        torch.mps.synchronize()
        report['seed_initialization_seconds'] = time.perf_counter() - started
        record(seed_output, seed_image, 'seed', report['seed_initialization_seconds'], started, seed=True)

        # Both passes use the actual source indexes and native reverse=True API.
        # The same conditioning mask initializes both directions.
        for direction in ('forward', 'backward'):
            if not remaining:
                break
            iterator = model.propagate_in_video_iterator(
                session, start_frame_idx=seed_index, reverse=direction == 'backward',
                max_frame_num_to_track=remaining)
            while remaining:
                total_started = time.perf_counter()
                torch.mps.synchronize()
                started = time.perf_counter()
                try:
                    output = next(iterator)
                except StopIteration:
                    break
                torch.mps.synchronize()
                seconds = time.perf_counter() - started
                if int(output.frame_idx) == seed_index:
                    report.setdefault('cached_seed_reuse_seconds', {})[direction] = seconds
                    continue
                record(output, None, direction, seconds, total_started)
                remaining -= 1

        report['status'] = 'encoding_preview'
        report['memory_final'] = memory(torch)
        report['complete_source_coverage'] = len({f['source_frame_index'] for f in report['frames']}) == len(timestamps)
        report['method_notes'] = 'Fixed manual seed, native forward and reverse video propagation. Not a test of Agent automation or label accuracy. Model FPS excludes preprocessing, postprocessing/artifacts, decode, loading and seed initialization. MPS memory is sampled after calls, not an allocator peak; process RSS excludes some Metal allocations.'
        save()
        if report['complete_source_coverage']:
            started = time.perf_counter()
            with av.open(str(args.video)) as source, av.open(str(args.output / 'segmented.mp4'), mode='w') as destination:
                encoder = destination.add_stream('libx264', rate=Fraction(fps).limit_denominator(1001))
                encoder.width, encoder.height = seed_image.size
                encoder.pix_fmt = 'yuv420p'
                encoder.options = {'crf': '23', 'preset': 'veryfast'}
                for i, frame in enumerate(source.decode(source.streams.video[0])):
                    image = frame.to_image().convert('RGB').rotate(rotation, expand=True)
                    with np.load(args.output / f'{i:04d}_prediction.npz') as prediction:
                        masks = prediction['masks']
                    preview = overlay(image, masks)
                    if i % 30 == 0 or i == len(timestamps) - 1:
                        preview.save(args.output / f'{i:04d}_overlay.png')
                    output_frame = av.VideoFrame.from_image(preview)
                    output_frame.pts = i
                    output_frame.time_base = Fraction(1, 1) / Fraction(fps).limit_denominator(1001)
                    for packet in encoder.encode(output_frame):
                        destination.mux(packet)
                for packet in encoder.encode():
                    destination.mux(packet)
            report['preview_encoding_seconds'] = time.perf_counter() - started
            save()
        report['status'] = 'completed'
        report['total_wall_seconds'] = time.perf_counter() - wall_started
        save()
        print(json.dumps(report['summary'], indent=2), flush=True)
    except Exception as error:
        report['status'] = 'failed'
        report['error'] = {'type': type(error).__name__, 'message': str(error), 'traceback': traceback.format_exc()}
        save()
        raise


if __name__ == '__main__':
    main()

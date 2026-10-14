"""Compare independent text segmentation with recorded tracker calls on identical frames."""

import argparse
import json
from pathlib import Path
import time

import av
import numpy as np

from .benchmark_tracker import memory, summarize
from .inference import overlay


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('tracker_report', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--prompt', default='cylinder of yarn')
    parser.add_argument('--frames', type=int, default=8)
    args = parser.parse_args()
    if args.frames < 1:
        parser.error('--frames must be positive')
    baseline = json.loads(args.tracker_report.read_text())
    selected = [f for f in baseline['frames'] if not f['seed_frame'] and f['direction'] == 'forward'][:args.frames]
    if len(selected) != args.frames:
        parser.error('Tracker report has insufficient forward frames')
    args.output.mkdir(parents=True, exist_ok=False)
    report = {'status': 'running', 'prompt': args.prompt, 'tracker_report': str(args.tracker_report.resolve()),
              'tracker_matching_frames': summarize(selected), 'device': 'mps', 'precision': 'float32',
              'method': 'Identical upright source frames, text detection independently on each. Synchronized model-only times and preprocessing/postprocessing/artifact times. Loading, warmup and decode excluded.',
              'frames': []}

    def save():
        report['summary'] = summarize(report['frames'])
        (args.output / 'results.json').write_text(json.dumps(report, indent=2))

    save()
    try:
        run_comparison(baseline, report, args, save)
    except Exception as error:
        report['status'] = 'failed'
        report['error'] = {'type': type(error).__name__, 'message': str(error)}
        save()
        raise
    report['status'] = 'completed'
    save()
    print(json.dumps(report['summary'], indent=2), flush=True)


def run_comparison(baseline, report, args, save):
    import torch
    from transformers import Sam3Model, Sam3Processor

    if not torch.backends.mps.is_available():
        raise RuntimeError('MPS required')
    torch.set_num_threads(4)
    started = time.perf_counter()
    model = Sam3Model.from_pretrained(baseline['model'], revision=baseline['revision'],
                                    local_files_only=True, dtype=torch.float32).to('mps').eval()
    processor = Sam3Processor.from_pretrained(baseline['model'], revision=baseline['revision'], local_files_only=True)
    torch.mps.synchronize()
    report['load_seconds'] = time.perf_counter() - started
    report['revision'] = baseline['revision']
    report['versions'] = baseline['versions']
    selected = [f for f in baseline['frames'] if not f['seed_frame'] and f['direction'] == 'forward'][:args.frames]
    wanted = {f['source_frame_index'] for f in selected}
    samples = []
    with av.open(baseline['video']) as source:
        for i, frame in enumerate(source.decode(source.streams.video[0])):
            if i in wanted:
                samples.append((i, frame.to_image().convert('RGB').rotate(frame.rotation, expand=True)))
            if i >= max(wanted):
                break
    inputs = processor(images=samples[0][1], text=args.prompt, return_tensors='pt').to('mps')
    started = time.perf_counter()
    with torch.inference_mode():
        model(**inputs)
    torch.mps.synchronize()
    report['warmup_seconds'] = time.perf_counter() - started
    for source_index, image in samples:
        total_started = time.perf_counter()
        inputs = processor(images=image, text=args.prompt, return_tensors='pt').to('mps')
        torch.mps.synchronize()
        started = time.perf_counter()
        with torch.inference_mode():
            output = model(**inputs)
        torch.mps.synchronize()
        seconds = time.perf_counter() - started
        prediction = processor.post_process_instance_segmentation(output, threshold=0.5, mask_threshold=0.5,
                                                                 target_sizes=[(image.height, image.width)])[0]
        masks = prediction['masks'].detach().cpu().numpy().astype(bool)
        boxes, scores = prediction['boxes'].detach().cpu().numpy(), prediction['scores'].detach().cpu().numpy()
        np.savez_compressed(args.output / f'{source_index:04d}_prediction.npz', masks=masks, boxes=boxes, scores=scores)
        overlay(image, masks).save(args.output / f'{source_index:04d}_overlay.png')
        report['frames'].append({'source_frame_index': source_index, 'seed_frame': False, 'model_seconds': seconds,
                                 'processed_frame_seconds': time.perf_counter() - total_started,
                                 'mask_count': len(masks), 'mask_pixels': int(masks.sum()),
                                 'boxes': boxes.tolist(), 'scores': scores.tolist(), 'memory': memory(torch)})
        save()
        print(f'Independent source frame {source_index}: {seconds:.2f}s; {len(masks)} masks', flush=True)


if __name__ == '__main__':
    main()

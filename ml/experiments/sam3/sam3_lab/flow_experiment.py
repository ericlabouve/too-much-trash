"""Single-clip MPS optical-flow research, with reviewed masks used only for evaluation/seed."""

import argparse
from fractions import Fraction
import hashlib
from importlib.metadata import version
import json
from pathlib import Path
import time
import traceback

import av
import numpy as np
from PIL import Image
import torch
import torch.nn.functional as F

from .inference import overlay
from .video import mask_rle


def warp(mask, backward_flow, binary=True):
    """Pull source mask into destination using destination-to-source displacement."""
    h, w = mask.shape
    y, x = torch.meshgrid(torch.arange(h, device=mask.device), torch.arange(w, device=mask.device), indexing='ij')
    coords = torch.stack((x, y)).float() + backward_flow
    valid = (coords[0] >= 0) & (coords[0] <= w - 1) & (coords[1] >= 0) & (coords[1] <= h - 1)
    grid = torch.stack((2 * coords[0] / (w - 1) - 1, 2 * coords[1] / (h - 1) - 1), -1)[None]
    result = F.grid_sample(mask.float()[None, None], grid, align_corners=True)[0, 0]
    return (result >= 0.5 if binary else result), valid, grid


def consistency(source_mask, forward, backward, pixel_threshold):
    # Errors are measured on source-mask pixels, at flow resolution.
    _, valid, grid = warp(source_mask, forward)
    back_at_endpoint = F.grid_sample(backward[None], grid, align_corners=True)[0]
    error = (forward + back_at_endpoint).square().sum(0).sqrt()
    count = int(source_mask.sum().item())
    if not count:
        return {'bad_fraction': 0.0, 'out_of_frame_fraction': 0.0, 'empty_source': True}
    bad = source_mask & valid & (error > pixel_threshold)
    return {'bad_fraction': float(bad.sum().item() / count),
            'out_of_frame_fraction': float((source_mask & ~valid).sum().item() / count), 'empty_source': False}


def dice(prediction, reference):
    denominator = int(prediction.sum()) + int(reference.sum())
    return 2 * int((prediction & reference).sum()) / denominator if denominator else None


def metrics(records):
    visible = [r['dice'] for r in records if r['reference_pixels'] > 0]
    empty = [r for r in records if r['reference_pixels'] == 0]
    return {'visible_frames': len(visible), 'mean_visible_dice': float(np.mean(visible)),
            'p10_visible_dice': float(np.percentile(visible, 10)),
            'visible_fraction_below_080': float(np.mean(np.asarray(visible) < .8)),
            'empty_reference_frames': len(empty),
            'empty_reference_false_positive_frames': sum(r['predicted_pixels'] > 0 for r in empty)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('reference', type=Path, help='Reviewed tracker results.json beside exact masks')
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--widths', type=int, nargs='+', default=[256, 384])
    parser.add_argument('--iterations', type=int, nargs='+', default=[4, 8])
    parser.add_argument('--smoke', action='store_true')
    parser.add_argument('--only-policy', help='Run one named policy for standalone validation')
    parser.add_argument('--check-parity', action='store_true', help='Compare one held-object flow estimate against CPU as a numerical diagnostic')
    parser.add_argument('--anchor-intervals', type=float, nargs='+', default=[1.])
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    report = {'status': 'running', 'device': 'mps', 'agent_calls': 0,
              'runner_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              'versions': {p: version(p) for p in ('torch', 'torchvision', 'transformers', 'av')},
              'reference': str(args.reference.resolve()), 'configurations': [],
              'notes': 'Original unpainted video is input. Reviewed masks supply one frozen seed and offline scoring only. Actual text SAM refreshes use cylinder of yarn and candidate overlap with propagated mask, never reference masks. Cached flow/SAM costs are charged per policy; FPS is accounted replay throughput, not standalone wall throughput.'}

    def save():
        (args.output / 'results.json').write_text(json.dumps(report, indent=2))

    try:
        if not torch.backends.mps.is_available():
            raise RuntimeError('MPS unavailable; no CPU fallback')
        torch.set_num_threads(4)
        from torchvision.models.optical_flow import raft_small, Raft_Small_Weights
        started = time.perf_counter()
        weights = Raft_Small_Weights.DEFAULT
        model = raft_small(weights=weights).to('mps').eval()
        torch.mps.synchronize()
        report['raft_load_seconds'] = time.perf_counter() - started
        report['raft_weights'] = str(weights)
        baseline = json.loads(args.reference.read_text())
        source_path = baseline['video']
        seed_index = baseline['source']['seed_frame_index']
        fps = baseline['source']['fps']
        n = baseline['source']['frames']
        references = {}
        for i in range(n):
            with np.load(args.reference.parent / f'{i:04d}_prediction.npz') as p:
                references[i] = p['masks'][0]
        height, width = references[seed_index].shape
        transform = weights.transforms()
        anchor_cache = {}
        sam_runtime = []

        def source_image(index):
            with av.open(source_path) as c:
                for i, frame in enumerate(c.decode(video=0)):
                    if i == index:
                        return frame.to_image().convert('RGB').rotate(frame.rotation, expand=True)
            raise ValueError('Missing source frame')

        def sam_anchor(index, previous):
            # Cache raw candidates, not the identity selection, so policies remain independent.
            if index not in anchor_cache:
                image = source_image(index)
                if not sam_runtime:
                    from transformers import Sam3Model, Sam3Processor
                    t = time.perf_counter()
                    sam_model = Sam3Model.from_pretrained(baseline['model'], revision=baseline['revision'], local_files_only=True, dtype=torch.float32).to('mps').eval()
                    sam_processor = Sam3Processor.from_pretrained(baseline['model'], revision=baseline['revision'], local_files_only=True)
                    torch.mps.synchronize()
                    report['sam_load_seconds'] = time.perf_counter() - t
                    sam_runtime.extend([sam_model, sam_processor])
                torch.mps.synchronize()
                started = time.perf_counter()
                sam_model, sam_processor = sam_runtime
                sam_inputs = sam_processor(images=image, text='cylinder of yarn', return_tensors='pt').to('mps')
                with torch.inference_mode():
                    sam_outputs = sam_model(**sam_inputs)
                sam_prediction = sam_processor.post_process_instance_segmentation(sam_outputs, threshold=.5, mask_threshold=.5, target_sizes=[(height, width)])[0]
                result = {'masks': sam_prediction['masks'].cpu().numpy().astype(bool),
                          'scores': sam_prediction['scores'].cpu().numpy()}
                torch.mps.synchronize()
                elapsed = time.perf_counter() - started
                anchor_cache[index] = (result, elapsed)
                np.savez_compressed(args.output / f'anchor_{index:04d}.npz', **result)
            result, elapsed = anchor_cache[index]
            if not len(result['masks']):
                return np.zeros((height, width), bool), elapsed, 'sam_no_detection'
            if previous.any():
                intersections = (result['masks'] & previous).sum((1, 2))
                unions = (result['masks'] | previous).sum((1, 2))
                idx = int(np.argmax(intersections / np.maximum(unions, 1)))
                if intersections[idx] == 0:
                    return previous, elapsed, 'no_overlapping_candidate_refresh_rejected'
            else:
                idx = int(np.argmax(result['scores']))
            return result['masks'][idx], elapsed, 'sam_refresh'

        for flow_width in args.widths:
            configuration_wall_started = time.perf_counter()
            flow_height = max(128, round(height * flow_width / width / 8) * 8)
            if flow_width < 128 or flow_width % 8:
                raise ValueError('RAFT width must be >=128 and divisible by 8')
            started = time.perf_counter()
            inputs = []
            with av.open(source_path) as c:
                for frame in c.decode(video=0):
                    image = frame.to_image().convert('RGB').rotate(frame.rotation, expand=True).resize((flow_width, flow_height))
                    tensor = torch.from_numpy(np.array(image)).permute(2, 0, 1)[None].to('mps')
                    inputs.append(transform(tensor, tensor)[0])
            torch.mps.synchronize()
            decode_preprocess_seconds = time.perf_counter() - started
            for iterations in args.iterations:
                config = {'width': flow_width, 'height': flow_height, 'iterations': iterations, 'policies': []}
                report['configurations'].append(config)
                folder = args.output / f'raft-{flow_width}-{iterations}'
                folder.mkdir()
                with torch.inference_mode():
                    model(inputs[0], inputs[1], num_flow_updates=iterations)
                torch.mps.synchronize()
                started = time.perf_counter()
                flows, flow_seconds = {}, 0.0
                for i in range(1 if args.smoke else n - 1):
                    torch.mps.synchronize()
                    t = time.perf_counter()
                    with torch.inference_mode():
                        forward = model(inputs[i], inputs[i+1], num_flow_updates=iterations)[-1][0]
                        backward = model(inputs[i+1], inputs[i], num_flow_updates=iterations)[-1][0]
                    torch.mps.synchronize()
                    flow_seconds += time.perf_counter() - t
                    flows[i] = (forward.detach(), backward.detach())
                    if i % 30 == 0:
                        print(f'RAFT {flow_width} / {iterations}: pair {i}, cumulative {flow_seconds:.2f}s', flush=True)
                config.update(flow_seconds=flow_seconds, decode_preprocess_seconds=decode_preprocess_seconds,
                              pair_count=len(flows), bidirectional_pairs_per_second=len(flows)/flow_seconds)
                save()
                if args.check_parity and not args.smoke:
                    cpu_model = raft_small(weights=weights).eval()
                    with torch.inference_mode():
                        cpu_flow = cpu_model(inputs[seed_index].cpu(), inputs[seed_index+1].cpu(), num_flow_updates=iterations)[-1][0]
                    delta = (cpu_flow - flows[seed_index][0].cpu()).abs()
                    config['cpu_mps_parity'] = {'mean_absolute_component_error_flow_pixels': float(delta.mean()),
                                               'max_absolute_component_error_flow_pixels': float(delta.max())}
                    del cpu_model
                if args.smoke:
                    report['status'] = 'smoke_completed'
                    save()
                    print(json.dumps(config), flush=True)
                    return

                policies = [('single', None, None, None)]
                policies += [(f'fixed-{interval:g}s', interval, None, None) for interval in args.anchor_intervals]
                policies += [(f'adaptive-e{error}-f{fraction}', None, error, fraction)
                             for error in (1., 2.) for fraction in (.15, .3)]
                if args.only_policy:
                    policies = [p for p in policies if p[0] == args.only_policy]
                    if not policies:
                        raise ValueError('Unknown policy')
                for name, interval, threshold, bad_fraction in policies:
                    policy_started = time.perf_counter()
                    low_masks, per_frame, sam_times = {}, {}, []
                    seed = torch.from_numpy(references[seed_index].astype(np.float32))[None, None].to('mps')
                    seed = F.interpolate(seed, size=(flow_height, flow_width), mode='bilinear', align_corners=False)[0, 0]
                    low_masks[seed_index] = seed
                    anchor_logs = [{'index': seed_index, 'reason': 'frozen_reviewed_seed', 'seconds': baseline['seed_initialization_seconds']}]
                    heuristic_seconds = 0.
                    for direction in (1, -1):
                        current = seed.clone()
                        consecutive = 0
                        since_anchor = 0
                        for index in range(seed_index + direction, n if direction == 1 else -1, direction):
                            fwd, back = flows[index-1 if direction == 1 else index]
                            fwd, back = (fwd, back) if direction == 1 else (back, fwd)
                            torch.mps.synchronize()
                            t = time.perf_counter()
                            predicted, valid, _ = warp(current, back, binary=False)
                            reliability = consistency(current >= .5, fwd, back, threshold) if threshold is not None else None
                            predicted *= valid
                            since_anchor += 1
                            consecutive = consecutive + 1 if reliability is not None and reliability['bad_fraction'] > bad_fraction else 0
                            request = (interval is not None and since_anchor >= round(interval*fps)) or (
                                threshold is not None and consecutive >= 2 and since_anchor >= 15 and len(anchor_logs) < 12)
                            torch.mps.synchronize()
                            heuristic_seconds += time.perf_counter() - t
                            reason = 'flow'
                            if request:
                                previous = (F.interpolate(predicted.float()[None, None], size=(height, width), mode='bilinear', align_corners=False)[0, 0] >= .5).cpu().numpy()
                                mask, elapsed, reason = sam_anchor(index, previous)
                                sam_times.append(elapsed)
                                anchor_logs.append({'index': index, 'reason': reason, 'seconds': elapsed,
                                                    'reliability': reliability})
                                predicted = F.interpolate(torch.from_numpy(mask.astype(np.float32))[None, None].to('mps'), size=(flow_height, flow_width), mode='bilinear', align_corners=False)[0, 0]
                                consecutive, since_anchor = 0, 0
                            current = predicted
                            low_masks[index] = current
                            per_frame[index] = {'source_frame_index': index, 'reliability': reliability, 'method': reason}
                    # Scoring uses references only after every policy decision is finished.
                    records, full_masks = [], []
                    export_started = time.perf_counter()
                    out_folder = folder / name
                    out_folder.mkdir()
                    for i in range(n):
                        pred = (F.interpolate(low_masks[i].float()[None, None], size=(height, width), mode='bilinear', align_corners=False)[0, 0] >= .5).cpu().numpy()
                        full_masks.append(pred)
                        ref = references[i]
                        ys, xs = np.nonzero(pred)
                        item = dict(per_frame.get(i, {'source_frame_index': i, 'method': 'seed'}))
                        item.update(predicted_pixels=int(pred.sum()), reference_pixels=int(ref.sum()), dice=dice(pred, ref),
                                    box_xyxy=[int(xs.min()), int(ys.min()), int(xs.max())+1, int(ys.max())+1] if len(xs) else None,
                                    mask_rle=mask_rle(pred))
                        records.append(item)
                    with av.open(source_path) as source, av.open(str(out_folder / 'segmented.mp4'), 'w') as dest:
                        encoder = dest.add_stream('libx264', rate=Fraction(fps).limit_denominator())
                        encoder.width, encoder.height = width, height
                        encoder.pix_fmt = 'yuv420p'
                        encoder.options = {'crf': '23', 'preset': 'veryfast'}
                        for i, frame in enumerate(source.decode(video=0)):
                            image = frame.to_image().convert('RGB').rotate(frame.rotation, expand=True)
                            out = av.VideoFrame.from_image(overlay(image, full_masks[i][None]))
                            out.pts, out.time_base = i, Fraction(1, round(fps))
                            for packet in encoder.encode(out):
                                dest.mux(packet)
                        for packet in encoder.encode():
                            dest.mux(packet)
                    (out_folder / 'predictions.json').write_text(json.dumps({'frames': records, 'anchors': anchor_logs}, indent=2))
                    export_seconds = time.perf_counter() - export_started
                    accounted = decode_preprocess_seconds + flow_seconds + heuristic_seconds + sum(a['seconds'] for a in anchor_logs) + export_seconds
                    result = {'name': name, **metrics(records), 'sam_calls_including_seed': len(anchor_logs),
                              'anchor_logs': anchor_logs, 'heuristic_seconds': heuristic_seconds,
                              'sam_seconds_including_seed': sum(a['seconds'] for a in anchor_logs),
                              'export_and_evaluation_seconds': export_seconds,
                              'accounted_processing_seconds': accounted, 'accounted_fps': n/accounted,
                              'replay_wall_seconds': time.perf_counter()-policy_started,
                              'artifacts': str(out_folder.resolve())}
                    if args.only_policy and len(args.iterations) == 1:
                        result['standalone_processing_seconds'] = (time.perf_counter() - configuration_wall_started
                            - report.get('sam_load_seconds', 0.) + baseline['seed_initialization_seconds'])
                        result['standalone_fps'] = n / result['standalone_processing_seconds']
                    config['policies'].append(result)
                    save()
                    print(f'{flow_width}/{iterations} {name}: Dice={result["mean_visible_dice"]:.3f}, FPS={result["accounted_fps"]:.2f}, SAM calls={len(anchor_logs)}', flush=True)
                del flows
            del inputs
        report['status'] = 'completed'
        save()
    except BaseException as error:
        report.update(status='failed', error={'type': type(error).__name__, 'message': str(error), 'traceback': traceback.format_exc()})
        save()
        raise


if __name__ == '__main__':
    main()

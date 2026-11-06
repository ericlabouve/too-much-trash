"""Video sampling, independent predictions, and browser-playable previews."""

from fractions import Fraction
import json
from pathlib import Path
import time
import uuid

import numpy as np
from PIL import Image, ImageDraw

from .inference import MODEL_ID, overlay, segment

POLICIES = {
    'Every frame': None,
    '1 frame per second': 1.0,
    '1 frame every 4 seconds': 0.25,
    '1 frame every 5 seconds': 0.2,
}


def mask_rle(mask):
    """Exact binary shape: alternating background/foreground row-major runs."""
    flat = np.asarray(mask, dtype=np.uint8).reshape(-1)
    changes = np.flatnonzero(flat[1:] != flat[:-1]) + 1
    runs = np.diff(np.concatenate(([0], changes, [len(flat)]))).tolist()
    if len(flat) and flat[0]:
        runs.insert(0, 0)
    return {'size_hw': list(mask.shape), 'order': 'row-major', 'counts': runs}


def process_video(path, prompt, threshold, policy, output_root, progress=None):
    import av

    if not path or not Path(path).is_file():
        raise ValueError('Upload a video first')
    if not prompt or not prompt.strip():
        raise ValueError('Enter an object phrase')
    if policy not in POLICIES:
        raise ValueError('Choose a processing policy')
    if not 0 <= threshold <= 1:
        raise ValueError('Threshold must be between 0 and 1')
    root = Path(output_root) / uuid.uuid4().hex
    root.mkdir(parents=True)
    output = root / 'segmented.mp4'
    json_path = root / 'predictions.json'
    sampled_fps = POLICIES[policy]
    records = []
    started = time.perf_counter()
    inference_seconds = 0.0
    preview_fps = 24
    next_output_index = 0
    previous = None
    last_time = 0
    next_sample = 0.0
    origin_time = None
    with av.open(str(path)) as source, av.open(str(output), mode='w') as destination:
        input_stream = source.streams.video[0]
        fps = float(input_stream.average_rate or 30)
        width, height = input_stream.width, input_stream.height
        duration = float(input_stream.duration * input_stream.time_base) if input_stream.duration else None
        encoder = destination.add_stream('libx264', rate=preview_fps)
        encoder.width = width + width % 2
        encoder.height = height + height % 2
        encoder.pix_fmt = 'yuv420p'
        encoder.options = {'crf': '23', 'preset': 'veryfast'}

        def emit_until(end_time, image):
            nonlocal next_output_index
            stop = round(end_time * preview_fps)
            while next_output_index < stop:
                frame = av.VideoFrame.from_image(image)
                frame.pts = next_output_index
                frame.time_base = Fraction(1, preview_fps)
                for packet in encoder.encode(frame):
                    destination.mux(packet)
                next_output_index += 1

        for frame_index, frame in enumerate(source.decode(input_stream)):
            raw_time = float(frame.time) if frame.time is not None else frame_index / fps
            if origin_time is None:
                origin_time = raw_time
            timestamp = raw_time - origin_time
            last_time = timestamp
            if sampled_fps and timestamp + 1e-6 < next_sample:
                continue
            image = frame.to_image().convert('RGB')
            result = segment(image, prompt, threshold)
            inference_seconds += result.elapsed_seconds
            instances = [
                {'score': float(score), 'box_xyxy': box.tolist(), 'mask_rle': mask_rle(mask)}
                for score, box, mask in zip(result.scores, result.boxes, result.masks)
            ]
            records.append({'source_frame_index': frame_index, 'timestamp_seconds': timestamp, 'inference_seconds': result.elapsed_seconds, 'instances': instances})
            preview = overlay(image, result.masks)
            if preview.size != (encoder.width, encoder.height):
                padded = Image.new('RGB', (encoder.width, encoder.height))
                padded.paste(preview, (0, 0))
                preview = padded
            draw = ImageDraw.Draw(preview)
            draw.rectangle((0, 0, min(width, 440), 20), fill='black')
            draw.text((5, 4), f'Source {timestamp:.2f}s | {len(instances)} masks | held sample, no tracking', fill='white')
            if previous is not None:
                emit_until(timestamp, previous)
            previous = preview
            if sampled_fps:
                next_sample = (int(timestamp * sampled_fps + 1e-6) + 1) / sampled_fps
            if progress:
                fraction = min(0.99, timestamp / duration) if duration else None
                progress(fraction, desc=f'{len(records)} frames processed; source {timestamp:.1f}s')
        if previous is None:
            raise ValueError('Video contained no decodable frames')
        emit_until(last_time + 1 / fps, previous)
        for packet in encoder.encode():
            destination.mux(packet)
    wall_seconds = time.perf_counter() - started
    payload = {
        'schema_version': 1, 'model': MODEL_ID, 'device': result.device,
        'prompt': prompt.strip(), 'threshold': threshold, 'processing_policy': policy,
        'source': {'width': width, 'height': height, 'fps': fps, 'duration_seconds': last_time + 1 / fps},
        'coordinates': 'Pixels in original source frame; box_xyxy = [left, top, right, bottom].',
        'mask_encoding': 'Exact binary masks: row-major RLE, alternating zero/one counts starting with zeros.',
        'preview': 'Silent H.264 sampled-frame preview; each predicted snapshot is held until the next sample. No tracking or mask propagation.',
        'summary': {'processed_frames': len(records), 'inference_seconds': inference_seconds, 'inference_fps': len(records) / inference_seconds, 'wall_seconds': wall_seconds},
        'frames': records,
    }
    json_path.write_text(json.dumps(payload, indent=2))
    if progress:
        progress(1, desc='Done')
    status = f'{len(records)} frames · {wall_seconds:.1f}s total · {len(records) / inference_seconds:.2f} inference FPS · {result.device}'
    return str(output), payload, str(json_path), status

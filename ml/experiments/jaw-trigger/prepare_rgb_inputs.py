"""Prepare label-free RGB pixels paired with a frozen gray replay (no fitting).

Only the train/validation videos already represented in Fixtures are decoded.
Existing gray pixels and timestamps must reproduce exactly. RGB preserves the
display aspect ratio inside a 960x720 canvas; legacy gray pixels stay unchanged.
"""

import argparse
import hashlib
import json
from pathlib import Path
import shutil
from time import monotonic

import av
import cv2
import numpy as np

PROTOCOL = 'paired-rgb-pixels-v1'


def digest(path):
    value = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(8 * 1024 * 1024), b''):
            value.update(block)
    return value.hexdigest()


def write_json(path, value):
    path = Path(path)
    temporary = path.with_suffix(path.suffix + '.partial')
    temporary.write_text(json.dumps(value, indent=2, allow_nan=False) + '\n')
    temporary.replace(path)


def rgb_geometry(width, height, rotation, target):
    quarter = round(float(rotation) / 90)
    if abs(float(rotation) - quarter * 90) > 1e-6:
        raise ValueError('Unsupported non-quarter-turn display rotation')
    display_width, display_height = (height, width) if quarter % 2 else (width, height)
    scale = min(target[0] / display_width, target[1] / display_height)
    fitted_width = min(target[0], max(1, round(display_width * scale)))
    fitted_height = min(target[1], max(1, round(display_height * scale)))
    return {'source_width': width, 'source_height': height,
            'rotation_degrees': float(rotation), 'quarter_turns': quarter,
            'display_aspect_ratio': display_width / display_height,
            'resized_width': fitted_width, 'resized_height': fitted_height,
            'pad_left': (target[0] - fitted_width) // 2,
            'pad_top': (target[1] - fitted_height) // 2}


def render_rgb(frame, geometry, target):
    width, height = geometry['resized_width'], geometry['resized_height']
    before_width, before_height = (height, width) if geometry['quarter_turns'] % 2 else (width, height)
    pixels = frame.reformat(width=before_width, height=before_height,
                            format='rgb24').to_ndarray()
    pixels = np.rot90(pixels, geometry['quarter_turns'])
    if pixels.shape != (height, width, 3):
        raise ValueError('Decoded RGB geometry differs from declared transform')
    result = np.zeros((target[1], target[0], 3), dtype=np.uint8)
    x, y = geometry['pad_left'], geometry['pad_top']
    result[y:y + height, x:x + width] = pixels
    return result


def context(job):
    job = Path(job).resolve(strict=True)
    paths = {split: job / f'{split}.json' for split in ('train', 'validation')}
    clips = {}
    for split, path in paths.items():
        for row in json.loads(path.read_text())['clips']:
            if row['clip'] in clips:
                raise ValueError('Train/validation clips must be disjoint and unique')
            clips[row['clip']] = (split, row['video'])
    fixture_path = job / 'Fixtures/clips.json'
    fixtures = json.loads(fixture_path.read_text())
    provenance_path = job / 'fixture-provenance.json'
    provenance = json.loads(provenance_path.read_text())
    if len({row['file'] for row in fixtures}) != len(fixtures):
        raise ValueError('Fixture filenames must be unique')
    if not fixtures or {provenance[row['file']]['clip'] for row in fixtures} != set(clips) or len(fixtures) != len(clips):
        raise ValueError('Fixtures must cover exactly train/validation; no test inputs')
    return job, fixtures, provenance, clips, {
        **{f'{split}_sha256': digest(path) for split, path in paths.items()},
        'legacy_clips_sha256': digest(fixture_path),
        'legacy_provenance_sha256': digest(provenance_path)}


def prepare(job, output, *, target=(960, 720), limit=0, reserve_bytes=10 * 1024**3):
    job, fixtures, provenance, clips, hashes = context(job)
    output = Path(output).resolve()
    if output.is_relative_to(job) or job.is_relative_to(output):
        raise ValueError('Use a dedicated cache outside the immutable job')
    if any(type(n) is not int or n <= 0 for n in target) or len(target) != 2:
        raise ValueError('Target size must be two positive integers')
    if type(limit) is not int or limit < 0:
        raise ValueError('Clip limit must be nonnegative')
    output.mkdir(parents=True, exist_ok=True)
    header = {'protocol': PROTOCOL, 'target_width': target[0], 'target_height': target[1],
              'dtype': 'uint8', 'channel_order': 'RGB', 'sampling_hz': 15,
              'creator_sha256': digest(__file__), 'av_version': av.__version__,
              'cv2_version': cv2.__version__, 'numpy_version': np.__version__,
              'context_hashes': hashes}
    marker = output / 'cache.json'
    if marker.exists():
        if json.loads(marker.read_text()) != header:
            raise ValueError('Cache belongs to a different context/code/decoder; use a new directory')
    elif any(output.iterdir()):
        raise ValueError('Refuse to write into a nonempty, unmarked directory')
    else:
        write_json(marker, header)
    index_path = output / 'index.json'
    if (limit and limit < len(fixtures) and index_path.exists()
            and json.loads(index_path.read_text()).get('complete')):
        raise ValueError('A pilot limit cannot downgrade a completed cache')
    selected = fixtures[:limit] if limit else fixtures
    required_bytes = sum(len(row['timestamps']) * target[0] * target[1] * 3
                         for index, row in enumerate(selected)
                         if not (output / f'clip-{index:04d}.json').exists())
    if shutil.disk_usage(output).free < required_bytes + reserve_bytes:
        raise ValueError('Insufficient disk space for RGB cache plus reserve')
    records = []
    started = monotonic()
    for index, fixture in enumerate(selected):
        host = provenance[fixture['file']]
        split, source = clips[host['clip']]
        times = fixture['timestamps']
        if not times or any(not np.isfinite(t) for t in times) or any(a >= b for a, b in zip(times, times[1:])):
            raise ValueError('Frozen frame timestamps must be finite and increasing')
        legacy_path = job / 'Fixtures' / fixture['file']
        if digest(legacy_path) != host['sha256']:
            raise ValueError('Frozen gray fixture changed')
        source_hash = digest(source)
        row_path = output / f'clip-{index:04d}.json'
        pending_row = row_path.with_suffix('.json.partial')
        rgb_path = output / f'clip-{index:04d}.rgb.npy'
        identity = {'clip': host['clip'], 'split': split, 'source_video': source,
                    'source_video_sha256': source_hash,
                    'legacy_file': str(legacy_path), 'legacy_gray_sha256': host['sha256'],
                    'frame_count': len(times), 'timestamps': times,
                    'shape': [len(times), target[1], target[0], 3]}
        # Recover an interrupted two-file commit only from its original,
        # hash-verified pending record. Never invent metadata for an orphan.
        if not row_path.exists() and rgb_path.exists() and pending_row.exists():
            pending = json.loads(pending_row.read_text())
            if (any(pending.get(key) != value for key, value in identity.items())
                    or pending.get('rgb_file') != rgb_path.name
                    or digest(rgb_path) != pending.get('rgb_sha256')):
                raise ValueError('Interrupted cache commit does not match source/pixels')
            pending_row.replace(row_path)
        if row_path.exists():
            record = json.loads(row_path.read_text())
            if (any(record.get(key) != value for key, value in identity.items())
                    or record.get('rgb_file') != rgb_path.name
                    or digest(rgb_path) != record.get('rgb_sha256')):
                raise ValueError('Completed cache entry changed; refuse to overwrite evidence')
        else:
            if rgb_path.exists():
                raise ValueError('RGB file lacks a completion record; inspect before resuming')
            legacy = np.memmap(legacy_path, dtype=np.uint8, mode='r').reshape(-1, 240, 320)
            if len(legacy) != len(times):
                raise ValueError('Gray frame count differs from frozen timestamps')
            partial = rgb_path.with_suffix('.partial.npy')
            pixels = np.lib.format.open_memmap(partial, mode='w+', dtype=np.uint8,
                                             shape=tuple(identity['shape']))
            kept, first, geometry = 0, None, None
            try:
                with av.open(source) as video:
                    video.streams.video[0].thread_count = 1
                    for frame in video.decode(video=0):
                        if frame.time is None:
                            continue
                        first = frame.time if first is None else first
                        timestamp = frame.time - first
                        if timestamp + .001 < kept / 15:
                            continue
                        if kept >= len(times) or abs(timestamp - times[kept]) > 1e-9:
                            raise ValueError('Decoded source no longer matches frozen timestamps')
                        gray = frame.reformat(width=320, height=240, format='gray').to_ndarray()
                        gray = cv2.resize(np.rot90(gray, round(frame.rotation / 90)), (320, 240))
                        if not np.array_equal(gray, legacy[kept]):
                            raise ValueError('Decoded source no longer reproduces gray pixels exactly')
                        current = rgb_geometry(frame.width, frame.height, frame.rotation, target)
                        if geometry is not None and current != geometry:
                            raise ValueError('Source geometry changed within a clip')
                        geometry = current
                        pixels[kept] = render_rgb(frame, geometry, target)
                        kept += 1
                if kept != len(times) or digest(source) != source_hash:
                    raise ValueError('Source frame count or bytes changed')
                pixels.flush()
            finally:
                del pixels
                del legacy
            record = {**identity, 'rgb_file': rgb_path.name, 'rgb_sha256': digest(partial),
                      'transform': geometry, 'legacy_gray_bit_exact_all_frames': True,
                      'timestamps_exact_all_frames': True}
            write_json(pending_row, record)
            partial.replace(rgb_path)
            pending_row.replace(row_path)
        records.append(record)
        result = {**header, 'legacy_clips_path': str(job / 'Fixtures/clips.json'),
                  'expected_clips': len(fixtures), 'prepared_clips': len(records),
                  'complete': len(records) == len(fixtures), 'test_read': False,
                  'clips': records}
        write_json(index_path, result)
        print(json.dumps({'prepared_clips': len(records), 'expected_clips': len(fixtures),
                          'complete': result['complete'], 'elapsed_seconds': round(monotonic() - started, 2)}), flush=True)
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--job', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--limit', type=int, default=0, help='Preparation pilot only; partial indexes cannot be admitted')
    args = parser.parse_args()
    prepare(args.job, args.output, limit=args.limit)


if __name__ == '__main__':
    main()

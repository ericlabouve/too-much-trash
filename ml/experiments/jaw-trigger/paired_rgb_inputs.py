"""Read-only paired RGB replay inputs; clip metadata never belongs in inference.

The coordinator verifies all pixel hashes before dispatch and pins the index hash
in the new job. Benchmark/probe adapters can then map the same immutable arrays.
This module performs no fitting, label access, resampling, or detector work.
"""

import hashlib
import json
from pathlib import Path

import numpy as np


def digest(path):
    value = hashlib.sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(8 * 1024 * 1024), b''):
            value.update(block)
    return value.hexdigest()


def load_paired_inputs(job, index_path, expected_sha256, *, verify_pixels=False):
    """Return (fixture, gray mmap, RGB mmap) plus the pinned input declaration.

    `fixture` is benchmark bookkeeping, not a model argument. Inference receives
    only the current pixel arrays, current timestamp, and causal sensor samples.
    `verify_pixels=True` is mandatory during coordinator preparation, before any
    author starts. All inputs must stay read-only throughout the round.
    """
    job, index_path = Path(job).resolve(), Path(index_path).resolve(strict=True)
    if digest(index_path) != expected_sha256:
        raise ValueError('RGB input index changed')
    index = json.loads(index_path.read_text())
    if (index.get('protocol') != 'paired-rgb-pixels-v1'
            or index.get('complete') is not True or index.get('test_read') is not False
            or index.get('dtype') != 'uint8' or index.get('channel_order') != 'RGB'
            or index.get('sampling_hz') != 15):
        raise ValueError('RGB input cache must be complete, paired, and test-free')
    expected = {'train_sha256': job / 'train.json',
                'validation_sha256': job / 'validation.json',
                'legacy_clips_sha256': job / 'Fixtures/clips.json',
                'legacy_provenance_sha256': job / 'fixture-provenance.json'}
    if any(index['context_hashes'].get(key) != digest(path) for key, path in expected.items()):
        raise ValueError('RGB cache does not match the frozen train/validation inputs')
    fixtures = json.loads((job / 'Fixtures/clips.json').read_text())
    provenance = json.loads((job / 'fixture-provenance.json').read_text())
    records = index['clips']
    if (index['prepared_clips'] != len(fixtures) or index['expected_clips'] != len(fixtures)
            or len(records) != len(fixtures) or not fixtures
            or len({row['clip'] for row in records}) != len(records)):
        raise ValueError('RGB cache has missing or duplicate clips')
    prepared = []
    for fixture, record in zip(fixtures, records, strict=True):
        host = provenance[fixture['file']]
        if (record['clip'] != host['clip'] or record['split'] != host['split']
                or record['split'] not in ('train', 'validation')
                or record['timestamps'] != fixture['timestamps']
                or record['frame_count'] != len(fixture['timestamps'])
                or record['legacy_gray_sha256'] != host['sha256']
                or record.get('legacy_gray_bit_exact_all_frames') is not True
                or record.get('timestamps_exact_all_frames') is not True):
            raise ValueError('RGB/gray pairing or split changed')
        path = (index_path.parent / record['rgb_file']).resolve(strict=True)
        if not path.is_relative_to(index_path.parent):
            raise ValueError('RGB pixels must remain inside their cache')
        gray_path = job / 'Fixtures' / fixture['file']
        if verify_pixels and (digest(path) != record['rgb_sha256']
                              or digest(gray_path) != host['sha256']):
            raise ValueError('RGB or gray pixels changed')
        rgb = np.load(path, mmap_mode='r', allow_pickle=False)
        expected_shape = (len(fixture['timestamps']), index['target_height'], index['target_width'], 3)
        if (tuple(record['shape']) != expected_shape or rgb.shape != expected_shape
                or rgb.dtype != np.uint8 or rgb.flags.writeable):
            raise ValueError('RGB array differs from its declared read-only shape/type')
        gray = np.memmap(gray_path, dtype=np.uint8, mode='r').reshape(-1, 240, 320)
        if len(gray) != len(rgb):
            raise ValueError('RGB/gray frame counts differ')
        prepared.append((fixture, gray, rgb))
    return prepared, {'protocol': index['protocol'], 'index_path': str(index_path),
                      'index_sha256': expected_sha256, 'test_read': False,
                      'rgb_shape': [index['target_height'], index['target_width'], 3],
                      'legacy_gray_bit_exact_all_frames': True,
                      'timestamps_exact_all_frames': True,
                      'pixels_verified_now': verify_pixels}

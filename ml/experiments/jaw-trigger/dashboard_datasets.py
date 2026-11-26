"""Discover frozen collections and materialize reproducible episode split records."""

import hashlib
import json
from collections import Counter
from functools import lru_cache
from math import isfinite
from pathlib import Path
from random import Random
from statistics import median
from uuid import UUID


REFERENCE_ROOT = Path('/Users/ericlabouve/Datasets/too-much-trash/reference/current')
SPLIT_NAMES = ('train', 'validation', 'test')
SPLIT_DEFAULTS = {'datasets': ['beach', 'park', 'home'],
                  'train_percent': 60, 'validation_percent': 20, 'test_percent': 20}
SPLIT_NOTES = [
    'Random episode splits can share recording conditions and overlapping intervals.',
    'Home and park were previously used for fitting or tuning existing candidates.',
    'Button callback timestamps are jaw references; physical edge timing and clock alignment remain unverified.',
]


@lru_cache(maxsize=32)
def _frame_rate_summary(directory, snapshot_stamp, labels_stamp):
    """Use recorded source intervals; container base rates can be misleading for VFR."""
    directory=Path(directory)
    items=json.loads((directory/'labels.json').read_text())['items']
    counts=Counter();unknown=0
    for item in items:
        try:
            path=_source_path(directory,item['files']['manifest'])
            capture=json.loads(Path(path).read_text())
            intervals=[join['estimatedFrameInterval'] for join in capture.get('sensor_metadata',{}).get('videoSegmentJoins',[])
                       if type(join.get('estimatedFrameInterval')) in (int,float)
                       and isfinite(join['estimatedFrameInterval']) and join['estimatedFrameInterval']>0]
            if not intervals:raise ValueError('No source cadence evidence')
            rate=1/median(intervals)
            nearest=60 if 57-1e-9 <= rate <= 63+1e-9 else min((15,24,25,30,48,50,90,100,120,144,240),key=lambda value:abs(rate-value))
            if nearest != 60 and abs(rate-nearest)/nearest > .005:raise ValueError('Unrecognized source cadence')
            counts[str(nearest)]+=1
        except (OSError,ValueError,KeyError,TypeError,AttributeError):
            unknown+=1
    common=int(next(iter(counts))) if len(counts)==1 and unknown==0 else None
    return {'nominal_fps':common,'counts':dict(sorted(counts.items(),key=lambda item:int(item[0]))),
            'unknown_clips':unknown,'source':'capture_source_frame_intervals'}


def common_frame_rate(datasets, available):
    selected=[row for row in available if row['name'] in datasets]
    rates={row.get('frame_rate',{}).get('nominal_fps') for row in selected}
    return next(iter(rates)) if selected and len(rates)==1 and None not in rates else None


def discover_datasets(root=REFERENCE_ROOT):
    """Return collection names from actual frozen label envelopes, never guessed folders."""
    root = Path(root)
    if not (root / 'SNAPSHOT.json').is_file():
        raise ValueError('Mount the local read-only reference snapshot before selecting datasets')
    collections = []
    snapshot_stat=(root/'SNAPSHOT.json').stat()
    for directory in sorted(root.iterdir()):
        labels = directory / 'labels.json'
        if not directory.is_dir() or not labels.is_file() or directory.name.startswith('.'):
            continue
        envelope = json.loads(labels.read_text())
        if not isinstance(envelope, dict) or not isinstance(envelope.get('items'), list):
            raise ValueError(f'{directory.name} has an invalid labels envelope')
        label_counts = Counter(item.get('label') if isinstance(item.get('label'), str) and item['label']
                               else 'unlabeled' for item in envelope['items'])
        stat=labels.stat()
        frame_rate=_frame_rate_summary(str(directory),(snapshot_stat.st_mtime_ns,snapshot_stat.st_size),
                                      (stat.st_mtime_ns,stat.st_size))
        collections.append({'name': directory.name, 'clip_count': len(envelope['items']),
                            'label_counts': dict(sorted(label_counts.items())),
                            'previously_fitted': directory.name in {'home', 'park'},
                            'source': 'frozen_reference','frame_rate':frame_rate})
    return collections


def validate_split_settings(settings, available=None):
    available = discover_datasets() if available is None else available
    known = {row['name'] for row in available}
    datasets = settings.get('datasets', SPLIT_DEFAULTS['datasets'])
    if (not isinstance(datasets, list) or not datasets
            or any(not isinstance(name, str) for name in datasets)
            or len(datasets) != len(set(datasets)) or not set(datasets) <= known):
        raise ValueError('Select one or more available datasets without duplicates')
    percentages = {name: settings.get(name + '_percent', SPLIT_DEFAULTS[name + '_percent'])
                   for name in SPLIT_NAMES}
    if any(type(value) is not int or not 0 <= value <= 100 for value in percentages.values()):
        raise ValueError('Split percentages must be whole numbers between zero and 100')
    if sum(percentages.values()) != 100 or percentages['train'] == 0:
        raise ValueError('Split percentages must total 100 with a positive training share')
    return {'datasets': sorted(datasets), **{name + '_percent': value for name, value in percentages.items()}}


def _source_path(root, value):
    if not isinstance(value, str) or Path(value).is_absolute():
        raise ValueError('Dataset source paths must be relative to their collection')
    path = (root / value).resolve(strict=True)
    if not path.is_file() or not path.is_relative_to(root.resolve()):
        raise ValueError('Dataset source paths must remain inside their frozen collection')
    return str(path)


def _records(root, dataset):
    directory = root / dataset
    envelope = json.loads((directory / 'labels.json').read_text())
    records = []
    for item in envelope['items']:
        files = {key: _source_path(directory, item['files'][key])
                 for key in ('video', 'imu', 'poses', 'manifest')}
        capture = json.loads(Path(files['manifest']).read_text())
        episode_id = item['episode_id']
        if not isinstance(episode_id, str) or UUID(capture['episode_id']) != UUID(episode_id):
            raise ValueError(f'{dataset}: capture UUID does not match labels')
        episode_id = str(UUID(episode_id))
        timing = capture['timing']
        start, press, release, end = (timing[key] for key in ('start', 'press', 'release', 'end'))
        if any(type(value) not in (int, float) or not isfinite(value) for value in (start, press, release, end)):
            raise ValueError(f'{dataset}: non-finite callback timestamps')
        if not start <= press < release <= end:
            raise ValueError(f'{dataset}: expected start <= press < release <= end')
        records.append({'clip': dataset + ':' + episode_id, 'dataset': dataset, 'episode_id': episode_id,
                        'source_id': item['id'], **files, 'episode_start': start,
                        'jaw_reference': {'close': press - start, 'open': release - start},
                        'previously_fitted': dataset in {'home', 'park'},
                        'capture_complete': capture.get('complete')})
    return records


def build_split_manifest(settings, root=REFERENCE_ROOT):
    """Build a pinned, disjoint random split without writing or decoding source media."""
    root = Path(root)
    choices = validate_split_settings(settings, discover_datasets(root))
    seed = settings.get('seed', 0)
    limit = settings.get('clip_limit', 0)
    if type(seed) is not int or seed < 0 or type(limit) is not int or limit < 0:
        raise ValueError('Seed and clip limit must be nonnegative integers')
    snapshot_bytes = (root / 'SNAPSHOT.json').read_bytes()
    snapshot = json.loads(snapshot_bytes)
    records = [row for dataset in choices['datasets'] for row in _records(root, dataset)]
    identities = [row['clip'] for row in records]
    uuids = [row['episode_id'].lower() for row in records]
    if len(identities) != len(set(identities)) or len(uuids) != len(set(uuids)):
        raise ValueError('Selected collections contain duplicate capture UUIDs')
    records.sort(key=lambda row: row['clip'])
    Random(seed).shuffle(records)
    if limit:
        records = records[:limit]
    count = len(records)
    if count == 0:
        raise ValueError('The selected datasets contain no episodes')
    shares = [count * choices[name + '_percent'] / 100 for name in SPLIT_NAMES]
    counts = [int(share) for share in shares]
    for index in sorted(range(3), key=lambda i: (-(shares[i] - counts[i]), i))[:count - sum(counts)]:
        counts[index] += 1
    if any(choices[name + '_percent'] and counts[i] == 0 for i, name in enumerate(SPLIT_NAMES)):
        raise ValueError('Too few selected clips to populate every enabled split; increase the clip limit')
    splits = {}
    start = 0
    for name, size in zip(SPLIT_NAMES, counts, strict=True):
        splits[name] = records[start:start + size]
        start += size
    return {'snapshot': str(root / 'SNAPSHOT.json'),
            'snapshot_sha256': hashlib.sha256(snapshot_bytes).hexdigest(),
            'snapshot_created_at': snapshot['created_at'], 'datasets': choices['datasets'],
            'seed': seed, 'split_strategy': 'random_episode_shuffle',
            'percentages': {name: choices[name + '_percent'] for name in SPLIT_NAMES},
            'counts': {name: len(rows) for name, rows in splits.items()},
            'notes': SPLIT_NOTES, 'clips': records, 'splits': splits}

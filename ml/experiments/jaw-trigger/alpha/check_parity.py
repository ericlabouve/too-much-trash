"""Run the portable alpha artifact on private validation conformance fixtures.

No fitting/test set/phone deployment. This checks linkage and orchestration,
not the future iPhone port or live-camera preprocessing.
"""
import argparse
import importlib.util
import json
from pathlib import Path
import sys
import time

import numpy as np

if __package__:
    from .export import digest, read, verify_package, write
else:
    from export import digest, read, verify_package, write


def check(bundle):
    bundle = Path(bundle).resolve(strict=True)
    identity = verify_package(bundle)
    runtime = bundle / 'runtime'
    sys.path.insert(0, str(runtime))
    # No other package's adapter/library may be reused from a prior import.
    sys.modules.pop('alpha_library', None)
    spec = importlib.util.spec_from_file_location('alpha_selected_native', runtime / 'exact_parent_native_adapter.py')
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    config, model = read(runtime / 'config.json'), read(runtime / 'exact-parent-model.json')
    records = []
    for fixture in read(bundle / 'fixtures/index.json')['clips']:
        frames = np.memmap(bundle / 'fixtures' / fixture['file'], dtype=np.uint8, mode='r').reshape(-1, 240, 320)
        if len(frames) != len(fixture['timestamps']):
            raise ValueError('Conformance frame count differs from timestamps')
        detector = module.create_detector(config, model)
        scores, events = [], []
        streams = {name: {'times': np.asarray(s['times'], dtype=np.float64),
                          'vectors': np.asarray(s['vectors'], dtype=np.float64)}
                   for name, s in fixture['sensors'].items()}
        try:
            for frame, timestamp in zip(frames, fixture['timestamps'], strict=True):
                sensors = {}
                for name, stream in streams.items():
                    end = int(np.searchsorted(stream['times'], timestamp, side='right'))
                    start = max(0, end - 33)
                    sensors[name] = {'times': stream['times'][start:end], 'vectors': stream['vectors'][start:end]}
                score, event = detector.step(np.array(frame, copy=True), timestamp, sensors)
                scores.append(score)
                if event:
                    events.append([event, timestamp])
        finally:
            detector.close()
        max_error = float(np.max(np.abs(np.asarray(scores) - fixture['expected_scores'])))
        if max_error > 1e-6 or events != fixture['expected_events']:
            raise ValueError(f'Portable alpha parity failed: {fixture["file"]}; max error {max_error}')
        records.append({'file': fixture['file'], 'frames': len(scores),
                        'max_absolute_score_error': max_error, 'events_match': True})
    result = {'status': 'passed', 'model_id': identity['model_id'], 'clips': records,
              'manifest_sha256': digest(bundle / 'manifest.json'),
              'selection_sha256': digest(bundle / 'selection.json'),
              'fixture_index_sha256': digest(bundle / 'fixtures/index.json'),
              'host_library_sha256': digest(runtime / ('alpha_native.dylib' if sys.platform == 'darwin' else 'alpha_native.so')),
              'checked_uptime_seconds': time.monotonic(), 'fitting_performed': False,
              'test_read': False, 'iphone_port_validated': False,
              'natural_continuous_video_validated': False}
    write(bundle / 'host-parity.json', result)
    return result


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--bundle', type=Path, required=True)
    args = parser.parse_args()
    print(json.dumps(check(args.bundle), indent=2))

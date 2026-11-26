"""Freeze current-pool phone inputs and Python parity outputs; never fit a model.

Only cached validation inputs are read. Labels and expected outputs stay on the
Mac, outside Fixtures. The phone receives raw prepared grayscale frames, native
IMU samples, frozen runtime parameters and decoder settings.
"""
import argparse
from dataclasses import asdict
from hashlib import sha256
import importlib.util
import json
from pathlib import Path
import pickle
import sys

import cv2
import numpy as np

from round_one import events, features as old_features
from run_joint_round import JointCandidate


def digest(path):
    return sha256(path.read_bytes()).hexdigest()


def load_module(path, name):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def runtime_model(model):
    """Drop fitting identifiers/provenance from the deployed model payload."""
    if not isinstance(model, dict):
        return model
    return {key: runtime_model(value) for key, value in model.items()
            if key not in {'fit', 'fit_provenance', 'fit_clip_ids', 'training_clip_ids',
                           'training_only', 'sampling', 'training_rows'}}


def prepare(result_path, output, per_collection=2):
    cv2.setNumThreads(1)
    result_path = result_path.resolve(strict=True)
    job = result_path.parent
    result = json.loads(result_path.read_text())
    index = json.loads((job / 'prepared-index.json').read_text())
    sys.path[:0] = [str(job), str(job / 'baseline-artifacts')]
    modules = {
        'temporal50_hysteresis': load_module(job / 'parent-temporal/module.py', 'phone_hysteresis'),
        'temporal50_multiscale': load_module(job / 'parent-temporal-champion/temporal50.py', 'phone_multiscale'),
        'geometry50_multiscale': load_module(job / 'parent-geometry/fit.py', 'phone_geometry'),
        'extra_trees49': load_module(job / 'baseline-artifacts/forest49.py', 'phone_forest49'),
        'extra_trees50': load_module(job / 'parent-forest/forest50.py', 'phone_forest50'),
        'radial50': load_module(job / 'research/model.py', 'phone_radial'),
    }
    fixtures = output / 'Fixtures'
    fixtures.mkdir(parents=True, exist_ok=False)
    selected, counts = [], {}
    for filename in index['validation']:
        with open(filename, 'rb') as stream:
            data = pickle.load(stream)
        collection = data['row']['clip'].split(':')[0]
        if counts.get(collection, 0) < per_collection:
            counts[collection] = counts.get(collection, 0) + 1
            selected.append((filename, data))
    if not selected:
        raise ValueError('No validation inputs available')
    pool = [JointCandidate(**candidate) for candidate in result['next_pool']]
    models = result['feature_parameters']
    manifest, reference = [], {}
    for number, (source, data) in enumerate(selected):
        key = f'clip-{number:02d}'
        frames, sensors = data['frames'], data['sensors']['imu']
        pixels = np.stack([frame for _, frame in frames]).astype(np.uint8)
        if pixels.shape[1:] != (240, 320):
            raise ValueError('Expected unchanged 320x240 prepared frames')
        (fixtures / f'{key}.bin').write_bytes(pixels.tobytes())
        manifest.append({'file': f'{key}.bin', 'timestamps': [float(t) for t, _ in frames],
                         'sensors': {name: {'times': np.asarray(t).tolist(), 'vectors': np.asarray(v).tolist()}
                                     for name, (t, v) in sensors.items() if name in ('accelerometer', 'gyroscope')}})
        reference[key] = {'source_sha256': digest(Path(source)), 'source': source, 'candidates': {}}
        for candidate in pool:
            model = models.get(candidate.method)
            if candidate.method == 'geometry50_multiscale':
                measured = modules[candidate.method].features(frames, model)
            elif candidate.method == 'radial50':
                restored = {k: np.asarray(v, np.float32) if k in ('mean', 'scale', 'projection', 'centers', 'weight') else v
                            for k, v in model.items()}
                measured = modules[candidate.method].native({'frames': frames, 'sensors': {'imu': sensors}}, restored)
            elif candidate.method in modules:
                measured = modules[candidate.method].features(frames, sensors, model)
            else:
                measured = old_features(candidate.method, frames, candidate.signal, sensors, models)
            values, _ = measured
            reference[key]['candidates'][candidate.name] = {
                'scores': [float(value) for _, value in values],
                'events': events(candidate, values, confirmation_time=True)}
        print(f'Prepared {key}: {len(frames)} frames; all {len(pool)} references', flush=True)
    canonical = lambda value: json.dumps(value, sort_keys=True, separators=(',', ':'))
    spec = {'suite': 'jaw-pool-native-v1', 'round': result['round'], 'repeats': 3,
            'result_sha256': digest(result_path), 'pool_sha256': sha256(canonical(result['next_pool']).encode()).hexdigest(),
            'candidates': [{'candidate': asdict(c), 'parameters': runtime_model(models.get(c.method, {})),
                            'model_sha256': sha256(canonical(models.get(c.method, {})).encode()).hexdigest()}
                           for c in pool]}
    (fixtures / 'pool.json').write_text(json.dumps(spec))
    (fixtures / 'clips.json').write_text(json.dumps(manifest))
    (output / 'reference.json').write_text(json.dumps(reference))
    (output / 'provenance.json').write_text(json.dumps({
        'result_path': str(result_path), 'result_sha256': spec['result_sha256'], 'pool_sha256': spec['pool_sha256'],
        'selection': f'First {per_collection} validation clips per collection in frozen manifest order',
        'collections': counts, 'test_read': False, 'fitting_performed': False,
        'opencv_python': cv2.__version__,
        'fixture_sha256': {p.name: digest(p) for p in fixtures.iterdir()},
        'source_sha256': {str(p): digest(p) for p in [Path(__file__), *[Path(m.__file__) for m in modules.values()]]},
    }, indent=2))
    return output


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('result', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('--per-collection', type=int, default=2)
    args = parser.parse_args()
    if not 1 <= args.per_collection <= 5:
        parser.error('Use one to five validation clips per collection')
    prepare(args.result, args.output, args.per_collection)

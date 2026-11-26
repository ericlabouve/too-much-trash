"""Run one bounded mutation round for the local dashboard using frozen inputs."""

import argparse
from dataclasses import asdict, replace
import json
from pathlib import Path
from tempfile import NamedTemporaryFile

import cv2
import numpy as np

import round_one
from round_one import accuracy, features, load_frames, measure_events, motion_samples, pose_samples
from run_joint_round import JointCandidate, SPACE, joint_genotype, read_genotype
from ml.evolution import Policy, run_round
from dashboard_datasets import REFERENCE_ROOT, SPLIT_DEFAULTS, build_split_manifest


WORK_ROOT = Path('/Users/ericlabouve/Datasets/too-much-trash/working/runs')
DEFAULTS = {'family': 'all', 'clip_limit': 0, 'pool_size': 10, 'jaw_weight': .8,
            'target_f1': .95, 'target_basis': 'development', 'seed': 0,
            'match_seconds': .5, 'full_speed_ms': 1000 / 60 / 4, 'frame_budget_ms': 1000 / 60,
            **SPLIT_DEFAULTS}
FAMILIES = ['MLP', 'Linear', 'HOG', 'Threshold', 'Geometry', 'Optical Flow', 'Template']


def architecture(method):
    if method in {'temporal47', 'motion48', 'motion49'}:
        return 'MLP'
    if method.startswith(('linear_hog', 'geometry', 'temporal', 'motion')):
        return 'Linear'
    if method == 'imu':
        return 'Threshold'
    if method in {'flow', 'sparse_flow', 'gyro_flow', 'gradient_flow_rescue'}:
        return 'Optical Flow'
    if method in {'angle'}:
        return 'Geometry'
    if method in {'gray', 'edge', 'profile', 'aligned', 'patch'}:
        return 'Template'
    return 'HOG'


def candidate_catalog(prior):
    """Keep evaluated proposals discoverable even when portfolio selection didn't retain them."""
    candidates = {entry['candidate']['name']: entry['candidate'] for group in
                  ('incumbents', 'challengers', 'pruned_scores', 'ranked') for entry in prior.get(group, [])}
    candidates.update({candidate['name']: candidate for candidate in prior['next_pool']})
    return list(candidates.values())


def candidate_family(candidate, prior):
    return prior.get('candidate_metadata', {}).get(candidate['name'], {}).get('family') or architecture(candidate['method'])


def available_families(prior):
    return sorted({candidate_family(candidate, prior) for candidate in candidate_catalog(prior)})


def write_json(path, value):
    with NamedTemporaryFile(mode='w', dir=path.parent, prefix='.pending-', delete=False) as pending:
        json.dump(value, pending, indent=2, allow_nan=False)
        pending.write('\n')
    Path(pending.name).replace(path)


def execute(config_path):
    config = json.loads(config_path.read_text())
    settings = config['settings']
    output = config_path.parent
    status_path = output / 'status.json'
    prior = json.loads(Path(config['prior']).read_text())
    round_number = config.get('round_number', prior['round'] + 1)
    # This frozen-weight path is a diagnostic, never a route around the final review gate.
    subset = True

    def progress(fraction, message):
        write_json(status_path, {'state': 'running', 'progress': fraction, 'message': message,
                                 'round': round_number, 'subset': subset})

    try:
        progress(.01, 'Preparing the selected frozen datasets and random episode split')
        split_manifest = build_split_manifest(settings)
        write_json(output / 'inputs.json', split_manifest)
        records = split_manifest['splits']['train']
        if not records:
            raise ValueError('The selected training partition is empty')
        if settings['family'] == 'new_family':
            raise ValueError('New Family requires the agent-guided coordinator')
        pool = [JointCandidate(**row) for row in prior['next_pool']]
        if settings['family'] != 'all':
            pool = [candidate for candidate in pool if architecture(candidate.method) == settings['family']]
        pool = pool[:settings['pool_size']]
        if not pool:
            raise ValueError('The selected family has no retained candidates')
        parameters = prior['feature_parameters']
        frames, sensors, labels = [], [], []
        cv2.setNumThreads(1)
        round_one.MATCH_SECONDS = settings['match_seconds']
        for index, row in enumerate(records):
            frames.append(load_frames(Path(row['video'])))
            with Path(row['imu']).open() as source:
                imu = motion_samples({'start': row['episode_start'], 'samples': [json.loads(line) for line in source]})
            sensors.append({'imu': imu, 'poses': pose_samples(Path(row['poses']), row['episode_start'])})
            labels.append(row['jaw_reference'])
            progress(.05 + .3 * (index + 1) / len(records), f'Prepared {index + 1} of {len(records)} clips')
        cache = {}
        evaluated = []

        def evaluate(candidate):
            key = candidate.method, candidate.signal
            if key not in cache:
                cache[key] = [features(candidate.method, video, candidate.signal,
                             sensor if candidate.method in round_one.POSE_METHODS else sensor['imu'], parameters)
                              for video, sensor in zip(frames, sensors, strict=True)]
            predictions, timings = measure_events(candidate, cache[key])
            metrics = accuracy(predictions, labels)
            p95 = float(np.percentile(np.concatenate(timings), 95))
            speed = min(1., max(0., (settings['frame_budget_ms'] - p95) /
                                  (settings['frame_budget_ms'] - settings['full_speed_ms'])))
            per_clip = [accuracy([prediction], [label])['f1'] for prediction, label in zip(predictions, labels, strict=True)]
            entry = {'candidate': asdict(candidate), 'development': metrics, 'clip_f1': per_clip,
                     'p95_ms': p95, 'speed_score': speed,
                     'fitness': settings['jaw_weight'] * metrics['f1'] + (1 - settings['jaw_weight']) * speed,
                     'zero_jaw_clips': per_clip.count(0), 'worst_clip_accuracy': min(per_clip),
                     'jaw_by_event': {kind: accuracy([[(event, t) for event, t in prediction if event == kind]
                                     for prediction in predictions], [{kind: label[kind]} for label in labels])
                                     for kind in ('close', 'open')}}
            evaluated.append(entry)
            progress(.35 + .6 * min(1., len(evaluated) / (2 * len(pool))),
                     f'Evaluated {len(evaluated)} of up to {2 * len(pool)} candidates')
            return entry

        seen = {read_genotype(item) for item in prior['seen'] if len(item) in (8, 9, 11)}
        policy = Policy(pool_size=len(pool), family_limit=max(1, len(pool)), research_slots=0)
        result = run_round(pool, round_number, seen, evaluate, SPACE, policy=policy, seed=settings['seed'])
        result.update(settings=settings, mode='bounded_mutations', reporting='frozen_prior_training_diagnostic', subset=subset,
                      split_counts=split_manifest['counts'], test_evaluated=False, validation_evaluated=False,
                      feature_parameters=parameters, seed=settings['seed'], seen=sorted(seen, key=repr),
                      target_basis='development', clip_count=len(records),
                      fitness_weights={'jaw_f1': settings['jaw_weight'], 'speed_score': 1 - settings['jaw_weight']},
                      input_manifest=str(output / 'inputs.json'))
        result['history'] = [*prior.get('history', []), dict(result)]
        write_json(output / 'results.json', result)
        winner = result['ranked'][0]
        summary = {'round': round_number, 'subset': subset, 'clip_count': len(records),
                   'evaluated_candidates': len(evaluated), 'best_fitness': winner['fitness'],
                   'jaw_f1': winner['development']['f1'], 'p95_ms': winner['p95_ms'],
                   'target_reached': winner['development']['f1'] >= settings['target_f1'],
                   'target_basis': 'development', 'reporting': 'frozen_prior_training_diagnostic',
                   'split_counts': split_manifest['counts'], 'test_evaluated': False,
                   'validation_evaluated': False, 'mode': 'bounded_mutations'}
        write_json(status_path, {'state': 'completed', 'progress': 1.,
            'message': ('Subset check completed; official round was not advanced.' if subset
                        else 'Bounded mutation round completed on development footage.'),
            'result': summary, 'results_path': str(output / 'results.json')})
    except Exception as error:
        write_json(status_path, {'state': 'failed', 'progress': 0., 'message': str(error)})
        raise


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('config', type=Path)
    execute(parser.parse_args().config)

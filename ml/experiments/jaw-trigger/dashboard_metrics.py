"""Comparable validation leader series from completed, audited dashboard jobs."""

from hashlib import sha256
import json
from math import isfinite
from dashboard_datasets import REFERENCE_ROOT
from dashboard_agents import verify_publication
from dashboard_losses import load_training_histories


def leader_context(result, inputs, job_name, protocol):
    settings = result['settings']
    if result.get('reporting') != 'validation':
        return None
    identity = {
        'snapshot': inputs['snapshot_sha256'],
        'partitions': {name: sorted(row['clip'] for row in rows)
                       for name, rows in inputs['splits'].items()},
        'seed': settings['seed'],
        'scope': 'all' if settings['family'] == 'new_family' else settings['family'],
        'scoring': {key: settings[key] for key in
                    ('jaw_weight', 'match_seconds', 'full_speed_ms', 'frame_budget_ms')},
        'protocol': protocol,
        'evaluation_protocol': result.get('evaluation_protocol', 'clip_replay-v1'),
        'benchmark_protocol': result.get('benchmark_protocol', 'legacy-prototype'),
        'training_protocol': settings.get('training_protocol', 'legacy-fixed-epochs'),
    }
    identifier = sha256(json.dumps(identity, sort_keys=True).encode()).hexdigest()
    measured = {}
    for entry in [*result.get('incumbents', []), *result.get('challengers', []), *result['ranked']]:
        metrics = entry.get('split_scores', {}).get('validation', entry.get('development', {}))
        f1, p95 = metrics.get('f1'), entry.get('p95_ms')
        if not all(type(value) in (int, float) and isfinite(value) for value in (f1, p95)):
            continue
        speed = min(1., max(0., (settings['frame_budget_ms'] - p95) /
                            (settings['frame_budget_ms'] - settings['full_speed_ms'])))
        measured[entry['candidate']['name']] = {
            'name': entry['candidate']['name'], 'jaw': f1, 'p95_ms': p95,
            'fitness': settings['jaw_weight'] * f1 + (1 - settings['jaw_weight']) * speed,
        }
    if not measured:
        return None
    leader = max(measured.values(), key=lambda entry: entry['fitness'])
    datasets = ' + '.join(sorted(inputs['datasets']))
    counts = inputs['counts']
    weights = f"{settings['jaw_weight']:.0%} F1 / {1 - settings['jaw_weight']:.0%} speed"
    return {
        'id': identifier,
        'label': f"{datasets} · validation · {weights} · {identifier[:6]}",
        'summary': (f"{'Continuous stream' if result.get('evaluation_protocol') == 'continuous_stream-v1' else 'Clip replay'}"
                    f" · {counts['train']} train / {counts['validation']} validation / {counts['test']} reserved test"
                    f" · seed {settings['seed']} · scope {identity['scope']} · {weights}"
                    f" · ±{settings['match_seconds']:g}s · speed {settings['full_speed_ms']:.3f}–{settings['frame_budget_ms']:.3f} ms"),
        'identity': identity,
        'points': [{**leader, 'round': result['round'], 'job': job_name,
                    'integrity': result.get('integrity_review', {}).get('candidate_status', {}).get(leader['name'], 'legacy_unreviewed'),
                    'isolated': settings['family'] not in ('all', 'new_family') or settings.get('clip_limit', 0) > 0}],
    }


class LeaderHistory:
    def __init__(self, output, snapshot=REFERENCE_ROOT / 'SNAPSHOT.json'):
        self.output, self.cache = output, {}
        self.reference_snapshot = snapshot
        self.reference_stamp, self.reference_hash = None, None
        self.views = []

    def snapshot(self):
        groups = {}
        views = {}
        for status_path in sorted(self.output.glob('dashboard-*/status.json')):
            job = status_path.parent
            try:
                status = json.loads(status_path.read_text())
                if status.get('state') != 'completed' or status.get('mode') != 'agent_guided':
                    continue
                # Publication is a trust boundary, so don't let a cached chart bypass
                # a changed model, review, result, or stripped review configuration.
                verified_path, verified_result = verify_publication(job)
                legacy_hashes = job / 'evaluator-source/sha256.json'
                frozen_sources = [job / 'protected-source/ml/experiments/jaw-trigger' / name
                                  for name in ('round_one.py', 'joint_fitness.py')]
                paths = [status_path, verified_path, job / 'inputs.json',
                         *([legacy_hashes] if legacy_hashes.exists() else frozen_sources)]
                stamp = tuple((path.stat().st_mtime_ns, path.stat().st_size) for path in paths)
                cached = self.cache.get(job)
                if cached is None or cached[0] != stamp:
                    context = None
                    view = None
                    if status.get('state') == 'completed' and status.get('mode') == 'agent_guided':
                        if legacy_hashes.exists():
                            hashes = json.loads(legacy_hashes.read_text())
                            protocol = {name: (hashes[name] if name in hashes else
                                               hashes[f'ml/experiments/jaw-trigger/{name}'])
                                        for name in ('round_one.py', 'joint_fitness.py')}
                        else:
                            # Supervised workers pin these snapshots in their receipt.
                            protocol = {path.name: sha256(path.read_bytes()).hexdigest() for path in frozen_sources}
                        result, inputs = verified_result, json.loads(paths[2].read_text())
                        context = leader_context(result, inputs, job.name, protocol)
                        if context:
                            entries = {entry['candidate']['name']: entry for entry in
                                       [*result.get('incumbents', []), *result.get('challengers', []), *result['ranked']]}
                            view = {'context_id': context['id'], 'snapshot': inputs['snapshot_sha256'],
                                    'round': result['round'], 'job': job.name, 'summary': context['summary'],
                                    'settings': result['settings'], 'entries': list(entries.values()),
                                    'integrity_review': result.get('integrity_review'),
                                    'evaluation_protocol': result.get('evaluation_protocol', 'clip_replay-v1'),
                                    'candidate_metadata': result.get('candidate_metadata', {}),
                                    'training_histories': load_training_histories(job, result)}
                    self.cache[job] = stamp, context, view
                context = self.cache[job][1]
                if context:
                    group = groups.setdefault(context['id'], {**context, 'points': []})
                    group['points'].extend(context['points'])
                    views[context['id']] = self.cache[job][2]
            except (OSError, ValueError, KeyError, TypeError):
                # Partial jobs and legacy results without comparable provenance aren't chart points.
                continue
        try:
            stat = self.reference_snapshot.stat()
            reference_stamp = stat.st_mtime_ns, stat.st_size
            if reference_stamp != self.reference_stamp:
                self.reference_hash = sha256(self.reference_snapshot.read_bytes()).hexdigest()
                self.reference_stamp = reference_stamp
        except OSError:
            self.reference_hash = None
        self.views = sorted((view for view in views.values() if view['snapshot'] == self.reference_hash),
                            key=lambda view: view['job'])
        return sorted(groups.values(), key=lambda group: group['points'][-1]['job'])

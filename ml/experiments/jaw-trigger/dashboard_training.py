"""Audit training/checkpoint receipts without executing candidate code.

These consistency checks complement independent implementation review. They do
not prove that arbitrary candidate code computed its reported losses honestly.
"""

from hashlib import sha256
import json
from math import isclose, isfinite
from pathlib import Path
import re

from ml.evolution.training import PROTOCOL, checkpoint_key, policy_for
from dashboard_integrity import hashed_artifact, local_artifact


def _read(job, record):
    if not isinstance(record, dict):
        raise ValueError('Training evidence must identify its path and SHA256')
    _, path, _ = hashed_artifact(job, record)
    value = json.loads(path.read_text())
    if not isinstance(value, dict):
        raise ValueError('Training evidence must be a JSON object')
    return value


def _number(value, *, nonnegative=False):
    return type(value) in (int, float) and isfinite(value) and (not nonnegative or value >= 0)


def _plan(job, record, context, policy):
    envelope = _read(job, record)
    plan = envelope.get('plan', {})
    if not isinstance(plan, dict):
        raise ValueError('Training plan must be a JSON object')
    if (envelope.get('protocol') != PROTOCOL or envelope.get('context') != context
            or envelope.get('policy') != policy):
        raise ValueError('Training plans must use the pinned split and configured training policy')
    for key in ('candidate_name', 'hypothesis', 'objective', 'capacity', 'regularization'):
        if not isinstance(plan.get(key), str) or not plan[key].strip():
            raise ValueError('Training plans must justify hypothesis, objective, capacity and regularization')
    aliases = plan.get('candidate_names', [plan['candidate_name']])
    if (not isinstance(aliases, list) or not aliases
            or any(not isinstance(name, str) or not name.strip() for name in aliases)
            or len(set(aliases)) != len(aliases) or plan['candidate_name'] not in aliases):
        raise ValueError('Shared-fit aliases must be unique, predeclared names including the primary candidate')
    resources = plan.get('resources', {})
    if (not isinstance(resources, dict) or not isinstance(resources.get('device'), str) or not resources['device'].strip()
            or type(resources.get('threads')) is not int or resources['threads'] < 1):
        raise ValueError('Training plans must identify the device and thread allocation')
    if plan.get('kind') not in ('iterative', 'noniterative'):
        raise ValueError('Declare iterative or genuinely noniterative training')
    seed = plan.get('seed')
    if ('seed' not in plan or (seed is None and plan['kind'] != 'noniterative')
            or (seed is not None and (type(seed) is not int or seed < 0))):
        raise ValueError('Training plans must predeclare a nonnegative seed or deterministic noniterative null')
    if plan['kind'] == 'iterative' and (type(plan.get('max_epochs')) is not int or plan['max_epochs'] < 1
            or not isinstance(plan.get('selection_decoder'), dict)):
        raise ValueError('Iterative plans need an epoch ceiling and fixed checkpoint-selection decoder')
    return plan


def _predictions(job, record, ids):
    predictions = _read(job, record)
    if not isinstance(predictions, dict) or set(predictions) != set(ids):
        raise ValueError('Epoch predictions must cover exactly validation clips, excluding test')
    for events in predictions.values():
        if not isinstance(events, list):
            raise ValueError('Epoch predictions must contain timestamped event lists')
        for event in events:
            if (not isinstance(event, list) or len(event) != 2 or event[0] not in ('close', 'open')
                    or not _number(event[1])):
                raise ValueError('Epoch predictions must contain finite close/open events')
    return [predictions[clip] for clip in ids]


def _receipt(job, record, trial_id, started_plan, context, policy, ids, labels, accuracy):
    receipt = _read(job, record)
    if receipt.get('protocol') != PROTOCOL or receipt.get('trial_id') != trial_id:
        raise ValueError('Training receipt must identify its trial and protocol')
    if receipt.get('plan') != started_plan:
        raise ValueError('Training receipt cannot replace its predeclared plan')
    plan = _plan(job, receipt['plan'], context, policy)
    elapsed = receipt.get('elapsed_seconds')
    grace = max(5., .05 * policy['max_seconds'])
    if not _number(elapsed, nonnegative=True) or elapsed > policy['max_seconds'] + grace:
        raise ValueError('Training trial exceeded its bounded time allocation')
    checkpoint = _read(job, receipt['checkpoint'])
    if checkpoint.get('parameters') is None or not isinstance(checkpoint.get('artifacts'), list):
        raise ValueError('Selected checkpoint must freeze model parameters and artifacts')
    artifact_paths = set()
    for artifact in checkpoint['artifacts']:
        key, _, _ = hashed_artifact(job, artifact)
        if key in artifact_paths:
            raise ValueError('Checkpoint artifacts must be unique')
        artifact_paths.add(key)
    summary = {'trial_id': trial_id, 'kind': plan['kind'], 'checkpoint': receipt['checkpoint'],
               'history': receipt.get('history'), 'selected_epoch': receipt.get('selected_epoch'),
               'trained_epochs': receipt.get('trained_epochs'), 'stop_reason': receipt.get('stop_reason'),
               'resources': plan['resources'], 'elapsed_seconds': elapsed}
    if plan['kind'] == 'noniterative':
        if (receipt.get('history') is not None or receipt.get('selected_epoch') is not None
                or type(receipt.get('trained_epochs')) is not int or receipt['trained_epochs'] != 0
                or checkpoint.get('epoch') is not None
                or receipt.get('stop_reason') != 'noniterative_complete'):
            raise ValueError('Noniterative fits must not invent epochs or loss histories')
        return plan.get('candidate_names', [plan['candidate_name']]), summary, checkpoint['parameters']
    history = _read(job, receipt['history'])
    points = history.get('points')
    if (history.get('metric') != plan['objective'] or not isinstance(points, list) or not points
            or type(receipt.get('trained_epochs')) is not int or receipt['trained_epochs'] != len(points)
            or len(points) > plan['max_epochs']):
        raise ValueError('Iterative training needs every recorded epoch under its declared objective')
    previous_elapsed, gain_score, gain_epoch, stop = 0., None, 0, None
    for epoch, point in enumerate(points, 1):
        if stop is not None:
            raise ValueError('Training continued beyond its patience, epoch or time stopping rule')
        if not isinstance(point, dict) or type(point.get('epoch')) is not int or point['epoch'] != epoch:
            raise ValueError('Training epochs must be consecutive from one')
        if any(not _number(point.get(key), nonnegative=True) for key in ('train_loss', 'validation_loss', 'elapsed_seconds')):
            raise ValueError('Epoch losses and elapsed times must be finite and nonnegative')
        measured_elapsed = point['elapsed_seconds']
        if measured_elapsed < previous_elapsed or measured_elapsed > elapsed:
            raise ValueError('Training epoch timing is inconsistent with its receipt')
        previous_elapsed = measured_elapsed
        actual = accuracy(_predictions(job, point['predictions'], ids), labels)['f1']
        score = point.get('validation_score')
        if not _number(score) or not 0 <= score <= 1 or not isclose(score, actual, abs_tol=1e-12, rel_tol=0):
            raise ValueError('Epoch validation F1 must match its saved event predictions')
        if gain_score is None or score >= gain_score + policy['min_delta']:
            gain_score, gain_epoch = score, epoch
        if measured_elapsed >= policy['max_seconds']:
            stop = 'time_budget'
        elif epoch >= policy['min_epochs'] and epoch - gain_epoch >= policy['patience']:
            stop = 'patience'
        elif epoch == plan['max_epochs']:
            stop = 'max_epochs'
    if receipt.get('stop_reason') == 'time_budget' and stop is None and elapsed >= policy['max_seconds']:
        # can_start_epoch() may observe expiry between the last measurement and
        # the next optimization step. It need not add a fake terminal epoch.
        stop = 'time_budget'
    if stop is None or receipt.get('stop_reason') != stop:
        raise ValueError('Training receipt must explain its actual stopping rule')
    best = max(points, key=checkpoint_key)
    if (type(receipt.get('selected_epoch')) is not int or receipt['selected_epoch'] != best['epoch']
            or checkpoint.get('epoch') != best['epoch']):
        raise ValueError('Selected checkpoint must maximize validation F1, then minimize loss and epoch')
    summary['selected_validation_f1'] = best['validation_score']
    summary['possible_overfitting'] = (points[-1]['train_loss'] < points[0]['train_loss']
                                      and points[-1]['validation_loss'] > points[0]['validation_loss'])
    return plan.get('candidate_names', [plan['candidate_name']]), summary, checkpoint['parameters']


def verify_training_records(job, result, evaluation, settings, manifests, eligible):
    """Audit all logged attempts; bind published fits to their selected checkpoint."""
    if settings.get('training_protocol') != PROTOCOL:
        raise ValueError('New learned fits require validation-checkpoints-v1 training evidence')
    job = Path(job).resolve()
    policy = policy_for(settings)
    context = {f'{split}_manifest_sha256': sha256(Path(manifests[split]).read_bytes()).hexdigest()
               for split in ('train', 'validation')}
    training = json.loads(Path(manifests['train']).read_text())['clips']
    validation = json.loads(Path(manifests['validation']).read_text())['clips']
    ids = [row['clip'] for row in validation]
    if not ids or len(ids) != len(set(ids)):
        raise ValueError('Training selection requires a unique nonempty validation split')
    if set(ids) & {row['clip'] for row in training}:
        raise ValueError('Training and validation clips must be disjoint')
    labels = [row['jaw_reference'] for row in validation]
    fitted = evaluation.get('fitted_candidates', [])
    receipts = evaluation.get('training_receipts', {})
    if (not isinstance(fitted, list) or any(not isinstance(name, str) for name in fitted)
            or len(fitted) != len(set(fitted)) or not set(fitted) <= set(eligible)
            or not isinstance(receipts, dict) or set(receipts) != set(fitted)):
        raise ValueError('Every fitted candidate needs exactly one training receipt')
    journal_path = job / 'trials.jsonl'
    if not journal_path.exists():
        if fitted:
            raise ValueError('Learned fits require a complete trial journal')
        return {'protocol': PROTOCOL, 'policy': policy, 'candidates': {}, 'trials': 0, 'crashes': 0}
    journal_path = local_artifact(job, journal_path)
    started, completed, crashes = {}, {}, set()
    for line in journal_path.read_text().splitlines():
        event = json.loads(line)
        if not isinstance(event, dict):
            raise ValueError('Trial journal entries must be JSON objects')
        trial_id = event.get('trial_id')
        if not isinstance(trial_id, str) or not re.fullmatch(r'[A-Za-z0-9_-]{1,80}', trial_id):
            raise ValueError('Trial journal requires unique named attempts')
        status = event.get('status')
        if status == 'started':
            if trial_id in started:
                raise ValueError('Trial journal cannot restart or overwrite an attempt')
            _plan(job, event['plan'], context, policy)
            started[trial_id] = event['plan']
        elif status in ('completed', 'crash'):
            if trial_id not in started or trial_id in completed or trial_id in crashes:
                raise ValueError('Trial terminal records require exactly one preceding start')
            if status == 'crash':
                if not isinstance(event.get('reason'), str) or not event['reason'].strip():
                    raise ValueError('Failed trials must retain their failure reason')
                crashes.add(trial_id)
            else:
                completed[trial_id] = event['receipt']
        else:
            raise ValueError('Trial journal must preserve started/completed/crash lifecycle records')
    if set(started) != set(completed) | crashes:
        raise ValueError('Open training attempts cannot silently disappear from a completed round')
    import round_one
    old_tolerance = round_one.MATCH_SECONDS
    round_one.MATCH_SECONDS = settings['match_seconds']
    try:
        audited = {trial_id: _receipt(job, record, trial_id, started[trial_id], context, policy,
                                      ids, labels, round_one.accuracy)
                   for trial_id, record in completed.items()}
    finally:
        round_one.MATCH_SECONDS = old_tolerance
    candidates = {}
    used = set()
    for name, record in receipts.items():
        matching = [trial_id for trial_id, terminal in completed.items() if terminal == record]
        if len(matching) != 1:
            raise ValueError('Each published fit must identify one completed training attempt')
        trial_id = matching[0]
        recorded_names, summary, parameters = audited[trial_id]
        if name not in recorded_names:
            raise ValueError('Published fit names must match their training plans')
        models = result.get('feature_parameters', {})
        if eligible[name]['method'] not in models or parameters != models[eligible[name]['method']]:
            raise ValueError('Published model must equal the selected validation checkpoint, not the final epoch')
        used.add(trial_id)
        candidates[name] = summary
    return {'protocol': PROTOCOL, 'policy': policy, 'candidates': candidates,
            'trials': len(started), 'crashes': len(crashes),
            'unselected_completed_trials': len(completed) - len(used)}

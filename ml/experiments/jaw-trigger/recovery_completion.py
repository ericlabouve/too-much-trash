"""Finish saved evaluation/reviews without reopening failed-round authors.

Recovery is a distinct job with a review-only supervisor. Original author
lifetimes, model weights, training attempts and implementation bytes remain
bound to their immutable source job. Ordinary completion gates still audit
native scores, candidate reviews, reproduction and portfolio admission.
"""

import argparse
from copy import deepcopy
from hashlib import sha256
import json
from pathlib import Path
import os
from tempfile import NamedTemporaryFile

from dashboard_integrity import hashed_artifact, local_artifact
from dashboard_training import verify_training_records
from ml.evolution.agent_budgets import verify_agent_budgets
from ml.evolution.model_parameters import PROTOCOL as MODEL_PROTOCOL, parameters_for
from ml.evolution.resources import verify_fitting_slots
from recover_saved_candidates import verify_recovery

PROTOCOL = 'saved-round-completion-v1'
CONTROL_FILES = {'config.json', 'status.json', 'agents.json', 'deployment-specs.json'}
INPUT_FILES = ('input_dispatch.py', 'paired_rgb_inputs.py', 'rgb-input-provenance.json',
               'Fixtures/clips.json', 'fixture-provenance.json', 'prepared-index.json',
               'benchmark_native.py')


def read(path):
    return json.loads(Path(path).read_text())


def digest(path):
    return sha256(Path(path).read_bytes()).hexdigest()


def make_recovery_proof(source, archive):
    """Root-owned configuration pins; neither source nor archive is modified."""
    source, archive = Path(source).resolve(strict=True), Path(archive).resolve(strict=True)
    recovered = verify_recovery(archive)
    if Path(recovered['source_job']).resolve() != source:
        raise ValueError('Recovery archive identifies a different source job')
    return {'protocol': PROTOCOL, 'source_job': str(source), 'archive': str(archive),
            'archive_manifest_sha256': digest(archive / 'recovery.json'),
            'source_author_ledger_sha256': digest(source / 'agent-runtime.json'),
            'source_receipts_sha256': digest(source / 'agents.json'),
            'source_runtime_config_sha256': digest(source / 'runtime-config.json')}


def _normalized_specs(source, specs):
    """Empty build logs are archival evidence, not deployable dependencies."""
    normalized = deepcopy(specs)
    for spec in normalized:
        for filename in list(spec.get('artifacts', {})):
            path = (source / filename).resolve(strict=True)
            if not path.is_relative_to(source):
                raise ValueError('Saved deployment dependency leaves the source job')
            if path.suffix == '.log' and path.stat().st_size == 0:
                del spec['artifacts'][filename]
    return normalized


def _rebased_authors(source, job, receipts):
    copied = deepcopy(receipts['tasks'])
    for task in copied:
        for key in ('artifact', 'prompt_path'):
            original = local_artifact(source, task[key])
            relative = original.relative_to(source)
            current = local_artifact(job, str(relative))
            if digest(original) != digest(current):
                raise ValueError('Recovery cannot rewrite original author artifacts or prompts')
            task[key] = str(relative)
    return copied


def _source_context(job, config, result):
    proof = config.get('recovery')
    if not isinstance(proof, dict) or proof.get('protocol') != PROTOCOL:
        raise ValueError('Unknown saved-round recovery protocol')
    source = Path(proof['source_job']).resolve(strict=True)
    archive = Path(proof['archive']).resolve(strict=True)
    if source == job or source.is_relative_to(job) or job.is_relative_to(source):
        raise ValueError('Recovery job must be separate from its failed source')
    if proof != make_recovery_proof(source, archive):
        raise ValueError('Recovery source proof changed')
    original = read(source / 'config.json')
    if ('recovery' in original or config.get('settings') != original['settings']
            or config.get('prior') != original['prior']
            or config.get('round_number') != original['round_number']
            or result.get('settings') != original['settings']):
        raise ValueError('Recovery must preserve the original round, prior and settings')
    source_receipts = read(source / 'agents.json')
    authors = source_receipts.get('tasks', [])
    if not authors or any(task.get('kind') not in ('parent', 'research')
                          or task.get('status') != 'completed' for task in authors):
        raise ValueError('Only completed original authors may be recovered; no old reviewers')
    runtime_config = read(source / 'runtime-config.json')
    private = source.parent / '.agent-runtime' / f'{source.name}.json'
    if (Path(runtime_config['job']).resolve() != source
            or Path(runtime_config['ledger_path']).resolve() != private.resolve(strict=True)
            or digest(private) != proof['source_author_ledger_sha256']):
        raise ValueError('Original author ledger must match its independent supervisor copy')
    saved = read(archive / 'recovery.json')
    for record in saved['source_evidence']:
        if record['path'] in CONTROL_FILES:
            continue
        path = (job / record['path']).resolve(strict=True)
        if not path.is_relative_to(job) or not path.is_file() or digest(path) != record['sha256']:
            raise ValueError('Recovered implementation/training evidence differs from source archive')
    for filename in INPUT_FILES:
        original_path = source / filename
        if original_path.exists() and digest(local_artifact(job, filename)) != digest(original_path):
            raise ValueError('Recovery input dispatch and benchmark runner must remain unchanged')
    source_specs = read(source / 'deployment-specs.json')
    if read(job / 'deployment-specs.json') != _normalized_specs(source, source_specs):
        raise ValueError('Recovery may only omit empty build-log dependencies from saved specs')
    expected = {group: [{'candidate': spec['candidate']} for spec in source_specs
                        if spec['incumbent'] == (group == 'incumbents')]
                for group in ('incumbents', 'challengers')}
    for group, entries in expected.items():
        actual = [{'candidate': entry['candidate']} for entry in result.get(group, [])]
        if actual != entries:
            raise ValueError('Recovery must evaluate every original exact candidate configuration')
    eligible = {spec['candidate']['name']: spec['candidate'] for spec in source_specs}
    if (result.get('model_binding_protocol') != MODEL_PROTOCOL
            or set(result.get('candidate_parameters', {})) != set(eligible)):
        raise ValueError('Recovery requires all exact candidate-scoped model bindings')
    for spec in source_specs:
        if parameters_for(result, spec['candidate'], required=True) != read(source / spec['model_path']):
            raise ValueError('Recovery cannot change selected model parameters')
        expected_metadata = {k: v for k, v in spec['metadata'].items() if k != 'integrity_status'}
        observed_metadata = {k: v for k, v in result.get('candidate_metadata', {}).get(
            spec['candidate']['name'], {}).items() if k != 'integrity_status'}
        if expected_metadata != observed_metadata:
            raise ValueError('Recovery must preserve authored architecture metadata')
    bound_evaluation = read(archive / 'evaluation-binding.json')
    training_audit = verify_training_records(source, result, bound_evaluation, original['settings'],
                                             {s: source / f'{s}.json' for s in ('train', 'validation')}, eligible)
    resource_audit = verify_fitting_slots(source)
    author_audit = verify_agent_budgets(source, source_receipts, original['settings'],
                                       result['challengers'])
    return {'source': source, 'archive': archive, 'source_receipts': source_receipts,
            'training_audit': training_audit, 'resource_audit': resource_audit,
            'author_budget_audit': author_audit, 'eligible': eligible,
            'evaluation_binding': bound_evaluation}


def _evaluation_context(job, result, context):
    from deployment_benchmark import verify_deployment_benchmarks
    evaluation = read(local_artifact(job, 'evaluation.json'))
    for key in ('fitted_candidates', 'training_receipts'):
        if evaluation.get(key) != context['evaluation_binding'][key]:
            raise ValueError('Recovery training bindings must identify the saved original fits')
    ids = {split: [row['clip'] for row in read(job / f'{split}.json')['clips']]
           for split in ('train', 'validation')}
    deployment = verify_deployment_benchmarks(job, evaluation, context['eligible'],
                                              ids['train'], ids['validation'], result.get('candidate_artifacts'))
    source = context['source']
    ledger = read(local_artifact(source, 'agent-runtime.json'))
    author_end = max(cycle['ended_monotonic'] for task in ledger['tasks'] for cycle in task['cycles'])
    fit_end = 0.
    for line in (source / 'trials.jsonl').read_text().splitlines():
        event = json.loads(line)
        if event['status'] != 'completed':
            continue
        receipt = read(hashed_artifact(source, event['receipt'])[1])
        if receipt.get('fit_lease'):
            lease = read(hashed_artifact(source, receipt['fit_lease'])[1])
            fit_end = max(fit_end, lease['ended_monotonic'])
    last_native = -1.
    for reference in evaluation['deployment_benchmarks'].values():
        report = read(hashed_artifact(job, reference)[1])
        trace = read(hashed_artifact(job, report['outputs'])[1])
        if trace['started_uptime_seconds'] < max(author_end, fit_end):
            raise ValueError('Recovery native scoring must follow all original authors and fits')
        last_native = max(last_native, trace['finished_uptime_seconds'])
    return {'deployment': deployment, 'last_native': last_native}


def recovery_context(job, config, result, review_receipts, *, final=False):
    """Return independently verified original authors plus fresh reviewer receipts."""
    job = Path(job).resolve(strict=True)
    context = _source_context(job, config, result)
    tasks = review_receipts.get('tasks', [])
    if any(task.get('kind') != 'integrity_review' for task in tasks):
        raise ValueError('Recovery supervisor may run only new independent integrity reviewers')
    original_ids = {task['agent_id'] for task in context['source_receipts']['tasks']}
    if original_ids & {task.get('agent_id') for task in tasks}:
        raise ValueError('Recovery reviewers cannot reuse an original author identity')
    combined = {**review_receipts, 'tasks': [
        *_rebased_authors(context['source'], job, context['source_receipts']), *deepcopy(tasks)]}
    budgets = {'protocol': PROTOCOL, 'original_authors': context['author_budget_audit']}
    if final:
        budgets['fresh_reviewers'] = verify_agent_budgets(job, review_receipts, config['settings'],
                                                        result['challengers'], result.get('candidate_artifacts'))
        replay = _evaluation_context(job, result, context)
        last_native = replay['last_native']
        review_ledger = read(local_artifact(job, 'agent-runtime.json'))
        if last_native < 0 or any(cycle['started_monotonic'] < last_native
                                  for task in review_ledger['tasks'] for cycle in task['cycles']):
            raise ValueError('Fresh recovery reviews must start after serial native evaluation')
    return {**context, 'receipts': combined, 'agent_budget_audit': budgets}


def preflight(job):
    job = Path(job).resolve(strict=True)
    config, result = read(job / 'config.json'), read(job / 'results.json')
    context = recovery_context(job, config, result, {'tasks': []})
    replay = _evaluation_context(job, result, context)
    return {'status': 'passed', 'protocol': PROTOCOL, 'source_job': str(context['source']),
            'candidates': len(context['eligible']), 'trials': context['training_audit']['trials'],
            'crashes': context['training_audit']['crashes'], 'fitting_performed': False,
            'test_evaluated': False, 'source_author_budget_audit': context['author_budget_audit'],
            'native_evaluations': len(replay['deployment']['candidates'])}


def _atomic_bytes(path, raw):
    with NamedTemporaryFile(dir=path.parent, prefix='.recovery-', delete=False) as pending:
        temporary = Path(pending.name)
        try:
            pending.write(raw)
            pending.flush()
            os.fsync(pending.fileno())
        except BaseException:
            temporary.unlink(missing_ok=True)
            raise
    temporary.replace(path)


def _write(path, value):
    _atomic_bytes(path, (json.dumps(value, indent=2, allow_nan=False) + '\n').encode())


def finalize_recovery(job):
    """Admit only after every fresh review passes; never write outer certification.

    This prepares local result/final JSON for an independent outer owner. That
    owner must copy/hash-pin the actual private review ledger and write its own
    publication receipt plus completed status after this function succeeds.
    """
    from dashboard_agents import verify_completion
    from dashboard_integrity import review_context, verify_integrity_reviews
    from dashboard_selection import select_evaluated

    job = Path(job).resolve(strict=True)
    if read(local_artifact(job, 'status.json')).get('state') == 'completed':
        raise ValueError('Published recovery jobs cannot be finalized again')
    config, result = read(job / 'config.json'), read(job / 'results.json')
    review_receipts, evaluation = read(job / 'agents.json'), read(job / 'evaluation.json')
    manifests = {s: job / f'{s}.json' for s in ('train', 'validation')}
    context = recovery_context(job, config, result, review_receipts, final=True)
    # A rejected/missing/stale probe or review stops BEFORE portfolio selection
    # or any result write. Never discard a rejected challenger to pass the gate.
    integrity = verify_integrity_reviews(job, result, context['receipts'], config['settings'],
        review_context(job, result, config['settings'], manifests, job / 'evaluation.json'),
        evaluation.get('fitted_candidates', []))
    prior = read(config['prior'])
    proposed = deepcopy(result)
    proposed.update(select_evaluated(proposed['incumbents'], proposed['challengers'], prior,
                                     config['settings'], proposed.get('candidate_metadata')))
    measured = proposed['incumbents'] + proposed['challengers']
    proposed['target_reached'] = max(entry['development']['f1'] for entry in measured) >= config['settings']['target_f1']
    proposed['history'] = [*prior.get('history', []), {
        'round': config['round_number'], 'reporting': 'validation',
        'ranked': proposed['ranked'], 'subset': False, 'recovered': True}]
    proposed['recovery_audit'] = {'protocol': PROTOCOL, 'source_job': str(context['source']),
        'archive': str(context['archive']), 'fitting_performed': False,
        'original_author_budget_audit': context['author_budget_audit'],
        'source_training_trials': context['training_audit']['trials'],
        'source_training_crashes': context['training_audit']['crashes'],
        'fresh_reviewers': len(review_receipts['tasks']),
        'integrity_status': integrity['status'],
        'continuous_field_validation': 'pending_new_footage', 'test_evaluated': False}
    final = {'status': 'completed', 'failure_kind': 'none', 'results_path': 'results.json',
             'agent_manifest_path': 'agents.json', 'evaluation_path': 'evaluation.json',
             'message': 'Saved round recovered with serial native evaluation and fresh independent candidate reviews; test reserved.'}
    result_path = job / 'results.json'
    original_bytes = result_path.read_bytes()
    try:
        _write(result_path, proposed)
        _, verified = verify_completion(job, final, config, manifests)
        # Preserve canonical audits (including exact selected receipt/history
        # references); no duplicate or reconstructed loss histories are invented.
        _write(result_path, verified)
    except BaseException:
        _atomic_bytes(result_path, original_bytes)
        raise
    _write(job / 'agent-final.json', final)
    leader = verified['ranked'][0]
    summary = {'round': verified['round'], 'mode': 'agent_guided', 'recovered': True,
               'leader': leader['candidate']['name'], 'validation_f1': leader['development']['f1'],
               'train_f1': leader.get('split_scores', {}).get('train', {}).get('f1'),
               'p95_ms': leader['p95_ms'], 'fitness': leader['fitness'],
               'best_fitness': leader['fitness'], 'jaw_f1': leader['development']['f1'],
               'pool_size': len(verified['next_pool']), 'native_evaluations': len(measured),
               'fresh_reviewers': len(review_receipts['tasks']),
               'target_f1': config['settings']['target_f1'], 'target_reached': verified['target_reached'],
               'target_basis': 'validation', 'test_evaluated': False,
               'continuous_field_validation': 'pending_new_footage'}
    return {'final': final, 'summary': summary, 'audit': verified['recovery_audit']}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--job', required=True, type=Path)
    action = parser.add_mutually_exclusive_group(required=True)
    action.add_argument('--preflight', action='store_true')
    action.add_argument('--finalize', action='store_true')
    args = parser.parse_args()
    print(json.dumps(finalize_recovery(args.job) if args.finalize else preflight(args.job), indent=2))

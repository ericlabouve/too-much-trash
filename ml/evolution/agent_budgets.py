"""Audit runner-owned child lifetimes independently of coordinator receipts."""

from math import isclose, isfinite
from pathlib import Path
import json
from .review_bundles import PROTOCOL as REVIEW_BUNDLE_PROTOCOL, preflight_bundle, artifact_graph

PROTOCOL = 'supervised-v1'
SHUTDOWN_GRACE_SECONDS = 2.0


def budget_policy(settings):
    minutes = settings.get('agent_minutes', 30)
    if type(minutes) not in (int, float) or not isfinite(minutes) or minutes <= 0:
        raise ValueError('Agent minutes must be finite and positive')
    seconds = minutes * 60
    export_minimum = settings.get('agent_export_min_seconds', 5.)
    if type(export_minimum) not in (int, float) or not isfinite(export_minimum) or not 5 <= export_minimum <= 120:
        raise ValueError('Agent export minimum must be between 5 and 120 seconds')
    return {'protocol': PROTOCOL, 'seconds': seconds,
            'export_seconds': min(seconds / 2, 120., max(export_minimum, seconds * .1)),
            'shutdown_grace_seconds': SHUTDOWN_GRACE_SECONDS}


def _number(value):
    return type(value) in (int, float) and isfinite(value) and value >= 0


def _artifact(job, name):
    if not isinstance(name, str) or not name:
        raise ValueError('Supervised task requires an artifact path')
    path = (job / name).resolve(strict=True)
    if not path.is_relative_to(job.resolve()) or not path.is_file() or not path.stat().st_size:
        raise ValueError('Supervised artifacts must be nonempty files inside this job')
    return path


def verify_agent_budgets(job, receipts, settings, challengers=(), candidate_artifacts=None):
    """Read the outer worker's copied ledger; never trust agent-written times.

    The worker copies this file from the MCP supervisor's private location and
    pins its hash in the publication receipt before any result is published.
    Historical rounds without this protocol keep their original interpretation.
    """
    if 'agent_budget_protocol' not in settings:
        return None
    protocol = settings['agent_budget_protocol']
    if protocol != PROTOCOL:
        raise ValueError('Unknown supervised agent-budget protocol')
    policy = budget_policy(settings)
    package_protocol = settings.get('review_bundle_protocol')
    if 'review_bundle_protocol' in settings and package_protocol != REVIEW_BUNDLE_PROTOCOL:
        raise ValueError('Unknown frozen review-bundle protocol')
    ledger = json.loads(_artifact(job, 'agent-runtime.json').read_text())
    if ledger.get('protocol') != PROTOCOL or Path(ledger.get('job', '')).resolve() != job.resolve():
        raise ValueError('Agent runtime ledger must identify this job and protocol')
    knobs = ledger.get('settings', {})
    if any(knobs.get(key) != settings.get(key) for key in
           ('agent_minutes', 'agent_concurrency', 'family')):
        raise ValueError('Agent runtime budget settings differ from the frozen job')
    if package_protocol is not None and knobs.get('review_bundle_protocol') != package_protocol:
        raise ValueError('Supervisor cannot disable frozen review-package preflight')
    if 'agent_export_min_seconds' in settings and knobs.get('agent_export_min_seconds') != settings['agent_export_min_seconds']:
        raise ValueError('Supervisor export minimum differs from the frozen job')
    runtime = ledger.get('tasks', [])
    tasks = receipts.get('tasks', [])
    if not runtime or len(runtime) != len(tasks):
        raise ValueError('Every coordinator task must have exactly one supervised lifetime')
    ids = [entry.get('agent_id') or entry.get('thread_id') for entry in runtime]
    if (any(not isinstance(identifier, str) or not identifier for identifier in ids)
            or len(set(ids)) != len(ids) or set(ids) != {task.get('agent_id') for task in tasks}):
        raise ValueError('Coordinator task identities must match independent supervised threads')
    runtime_ids = [entry.get('task_id') for entry in runtime]
    if any(not isinstance(value, str) or not value for value in runtime_ids) or len(set(runtime_ids)) != len(runtime):
        raise ValueError('Supervised task identities must be distinct')
    expected_names = {entry['candidate']['parent']: entry['candidate']['name']
                      for entry in challengers if entry['candidate'].get('parent') is not None}
    total_followups = 0
    for record in runtime:
        identifier = record.get('agent_id') or record['thread_id']
        if record.get('agent_id') and record.get('thread_id') and record['agent_id'] != record['thread_id']:
            raise ValueError('Supervisor agent and CLI thread identities must agree')
        task = next(task for task in tasks if task.get('agent_id') == identifier)
        kind = task.get('kind')
        if (record.get('kind') != kind or record.get('status') != 'ready'
                or task.get('status') != 'completed'):
            raise ValueError('Only successfully finalized supervised tasks can publish')
        if kind == 'parent' and (record.get('parent') != task.get('parent')
                                or record.get('candidate_name') != expected_names.get(task.get('parent'))):
            raise ValueError('Supervised evolution task must own the evaluated parent and child')
        if kind == 'research' and record.get('candidate_name') != task.get('proposal_candidate'):
            raise ValueError('Supervised research task must own the evaluated fresh proposal')
        if kind == 'integrity_review' and record.get('candidate_name') != task.get('candidate_name'):
            raise ValueError('Supervised reviewer must own exactly the assigned candidate')
        if kind == 'integrity_review' and package_protocol is not None:
            pinned = record.get('review_bundle', {})
            current = preflight_bundle(job, pinned.get('path'), record['candidate_name'])
            if current != pinned:
                raise ValueError('Frozen review package changed after reviewer dispatch')
            expected = (candidate_artifacts or {}).get(record['candidate_name'], {})
            if current['graph'] != artifact_graph(job, expected, record['candidate_name']):
                raise ValueError('Published candidate graph differs from the reviewer-dispatched package')
        if _artifact(job, record.get('artifact')) != _artifact(job, task.get('artifact')):
            raise ValueError('Task artifact must be the supervisor-observed final artifact')
        if _artifact(job, record.get('prompt_path')) != _artifact(job, task.get('prompt_path')):
            raise ValueError('Task prompt must be the supervisor-dispatched initial prompt')
        cycles = record.get('cycles', [])
        allowed = 3 if settings['family'] == 'new_family' and kind in ('research', 'review') else 1
        if not 1 <= len(cycles) <= allowed:
            raise ValueError('Agent budget may only renew for bounded New Family architecture cycles')
        previous_end = -1.
        for index, cycle in enumerate(cycles, 1):
            start, deadline, end = (cycle.get(key) for key in
                                    ('started_monotonic', 'deadline_monotonic', 'ended_monotonic'))
            if (cycle.get('cycle') != index or not all(_number(value) for value in (start, deadline, end))
                    or start < previous_end or end < start
                    or not isclose(deadline - start, policy['seconds'], abs_tol=.01)
                    or end > deadline + SHUTDOWN_GRACE_SECONDS):
                raise ValueError('Invalid or overrun supervised agent deadline')
            if kind in ('parent', 'research'):
                export = cycle.get('export_monotonic')
                if not _number(export) or not isclose(deadline - export, policy['export_seconds'], abs_tol=.01):
                    raise ValueError('Candidate agents must reserve the configured export window')
            previous_end = end
        turns = record.get('turns', [])
        if not turns:
            raise ValueError('Supervised task needs actual execution turns')
        previous_turn_end = -1.
        for turn in turns:
            start, end = turn.get('started_monotonic'), turn.get('ended_monotonic')
            if (not _number(start) or not _number(end) or end < start or start < previous_turn_end
                    or not any(cycle['started_monotonic'] <= start <= end
                               <= cycle['ended_monotonic'] for cycle in cycles)):
                raise ValueError('Supervised turn must fit its original agent allocation')
            previous_turn_end = end
        if kind in ('parent', 'research') and turns[-1].get('phase') != 'export':
            raise ValueError('Candidate agents must finalize in an export-only turn')
        if kind in ('parent', 'research'):
            for turn in turns:
                cycle = next(cycle for cycle in cycles if cycle['started_monotonic'] <= turn['started_monotonic']
                             <= turn['ended_monotonic'] <= cycle['ended_monotonic'])
                if turn.get('phase') == 'export' and turn['started_monotonic'] < cycle['export_monotonic']:
                    raise ValueError('Successful author export cannot bypass its improvement window')
                if turn.get('phase') == 'research' and turn['ended_monotonic'] > cycle['export_monotonic'] + SHUTDOWN_GRACE_SECONDS:
                    raise ValueError('Author research cannot consume its reserved export window')
        followups = record.get('followups', 0)
        if type(followups) is not int or not 0 <= followups <= len(turns) - 1:
            raise ValueError('Supervised follow-up count must match possible continuation turns')
        total_followups += followups
    return {'protocol': PROTOCOL, 'tasks': len(runtime), 'followups': total_followups,
            'minutes_per_agent': settings['agent_minutes'],
            'export_seconds': policy['export_seconds'], 'goal_mode': 'runner-supervised'}

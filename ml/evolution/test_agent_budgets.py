"""Audit supervisor evidence without launching models or an evolution round."""

from copy import deepcopy
import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from ml.evolution.agent_budgets import PROTOCOL, budget_policy, verify_agent_budgets


class AgentBudgetTests(unittest.TestCase):
    def fixture(self, job, family='all'):
        settings = {'agent_budget_protocol': PROTOCOL, 'agent_minutes': 30,
                    'agent_concurrency': 3, 'family': family}
        records, tasks = [], []
        for index, kind in enumerate(('parent', 'research', 'review', 'integrity_review')):
            author = kind in ('parent', 'research')
            start = 1000. + index if author else 2800. + index * 30
            end = start + (1750. if author else 20.)
            directory = job / f'task-{index}'
            directory.mkdir()
            prompt = directory / 'prompt.txt'
            prompt.write_text(f'Actual independent {kind} prompt')
            artifact = directory / 'artifact.json'
            artifact.write_text(json.dumps({'kind': kind, 'evidence': 'synthetic test only'}))
            relative_prompt, relative_artifact = str(prompt.relative_to(job)), str(artifact.relative_to(job))
            candidate = 'child' if kind == 'parent' else 'fresh' if kind == 'research' else 'child' if kind == 'integrity_review' else ''
            turns = ([{'phase': 'research', 'started_monotonic': start, 'ended_monotonic': start + 500.},
                      {'phase': 'research', 'started_monotonic': start + 500., 'ended_monotonic': start + 1650.},
                      {'phase': 'export', 'started_monotonic': start + 1680., 'ended_monotonic': end}]
                     if author else [{'phase': 'review', 'started_monotonic': start, 'ended_monotonic': end}])
            record = {'task_id': f'task-{index}', 'agent_id': f'agent-{index}', 'thread_id': f'agent-{index}',
                      'kind': kind, 'status': 'ready', 'phase': 'terminal', 'parent': 'parent' if kind == 'parent' else None,
                      'candidate_name': candidate, 'artifact': relative_artifact, 'prompt_path': relative_prompt,
                      'cycles': [{'cycle': 1, 'started_monotonic': start, 'deadline_monotonic': start + 1800.,
                                  'export_monotonic': start + 1680., 'ended_monotonic': end}],
                      'turns': turns, 'followups': 1 if author else 0}
            task = {'kind': kind, 'agent_id': f'agent-{index}', 'status': 'completed',
                    'artifact': relative_artifact, 'prompt_path': relative_prompt}
            if kind == 'parent': task['parent'] = 'parent'
            if kind == 'research': task['proposal_candidate'] = 'fresh'
            if kind == 'integrity_review': task['candidate_name'] = 'child'
            records.append(record)
            tasks.append(task)
        ledger = {'protocol': PROTOCOL, 'job': str(job),
                  'settings': {key: settings[key] for key in ('agent_minutes', 'agent_concurrency', 'family')},
                  'tasks': records}
        receipts = {'tasks': tasks}
        challengers = [{'candidate': {'name': 'child', 'parent': 'parent'}},
                       {'candidate': {'name': 'fresh', 'parent': None}}]
        return settings, ledger, receipts, challengers

    def audit(self, job, settings, ledger, receipts, challengers):
        (job / 'agent-runtime.json').write_text(json.dumps(ledger))
        return verify_agent_budgets(job, receipts, settings, challengers)

    def test_budget_policy_reserves_export_without_extending_agent_allocation(self):
        self.assertEqual(budget_policy({'agent_minutes': 30})['export_seconds'], 120.)
        self.assertEqual(budget_policy({'agent_minutes': 1})['export_seconds'], 6.)
        self.assertEqual(budget_policy({'agent_minutes': .05})['export_seconds'], 1.5)
        for value in (True, 0, -1, float('nan'), float('inf'), '30'):
            with self.subTest(value=value), self.assertRaises(ValueError):
                budget_policy({'agent_minutes': value})

    def test_legacy_jobs_do_not_acquire_a_new_ledger_requirement(self):
        self.assertIsNone(verify_agent_budgets(Path('/unused'), {}, {}))
        for protocol in ('prompt-only', None):
            with self.subTest(protocol=protocol), self.assertRaisesRegex(ValueError, 'Unknown'):
                verify_agent_budgets(Path('/unused'), {}, {'agent_budget_protocol': protocol})

    def test_ready_authors_and_independent_reviewers_are_bound_to_actual_artifacts(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            settings, ledger, receipts, challengers = self.fixture(job)
            summary = self.audit(job, settings, ledger, receipts, challengers)
            self.assertEqual(summary['tasks'], 4)
            self.assertEqual(summary['followups'], 2)
            self.assertEqual(summary['minutes_per_agent'], 30)
            self.assertEqual(summary['export_seconds'], 120.)

    def test_missing_extra_duplicate_or_mismatched_identities_are_rejected(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            settings, ledger, receipts, challengers = self.fixture(job)
            for case in ('missing', 'extra', 'duplicate_agent', 'duplicate_task', 'wrong_agent', 'wrong_kind',
                         'wrong_parent', 'wrong_child', 'wrong_research', 'wrong_review', 'wrong_job',
                         'wrong_protocol', 'wrong_budget', 'wrong_prompt', 'wrong_artifact'):
                with self.subTest(case=case):
                    changed = deepcopy(ledger)
                    records = changed['tasks']
                    if case == 'missing': records.pop()
                    elif case == 'extra': records.append(deepcopy(records[0]))
                    elif case == 'duplicate_agent': records[1]['agent_id'] = records[0]['agent_id']
                    elif case == 'duplicate_task': records[1]['task_id'] = records[0]['task_id']
                    elif case == 'wrong_agent': records[0]['agent_id'] = 'invented-agent'
                    elif case == 'wrong_kind': records[0]['kind'] = 'research'
                    elif case == 'wrong_parent': records[0]['parent'] = 'different parent'
                    elif case == 'wrong_child': records[0]['candidate_name'] = 'different child'
                    elif case == 'wrong_research': records[1]['candidate_name'] = 'different fresh proposal'
                    elif case == 'wrong_review': records[3]['candidate_name'] = 'different reviewed candidate'
                    elif case == 'wrong_job': changed['job'] = str(job.parent)
                    elif case == 'wrong_protocol': changed['protocol'] = 'prompt-only'
                    elif case == 'wrong_budget': changed['settings']['agent_minutes'] = 31
                    elif case == 'wrong_prompt': records[0]['prompt_path'] = records[1]['prompt_path']
                    elif case == 'wrong_artifact': records[0]['artifact'] = records[1]['artifact']
                    with self.assertRaises(ValueError):
                        self.audit(job, settings, changed, receipts, challengers)

    def test_failed_running_blocked_or_timed_out_tasks_cannot_publish(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            settings, ledger, receipts, challengers = self.fixture(job)
            for state in ('queued', 'running', 'blocked', 'failed', 'timed_out', 'closed'):
                with self.subTest(state=state):
                    changed = deepcopy(ledger)
                    changed['tasks'][0]['status'] = state
                    with self.assertRaisesRegex(ValueError, 'successfully finalized'):
                        self.audit(job, settings, changed, receipts, challengers)
            receipts['tasks'][0]['status'] = 'failed'
            with self.assertRaisesRegex(ValueError, 'successfully finalized'):
                self.audit(job, settings, ledger, receipts, challengers)

    def test_deadlines_and_export_reserve_cannot_be_reset_or_overrun(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            settings, ledger, receipts, challengers = self.fixture(job)
            for case in ('deadline_extended', 'deadline_shortened', 'overrun', 'negative_start', 'nonfinite',
                         'bad_cycle_index', 'end_before_start', 'missing_export', 'short_reserve', 'wrong_final_phase',
                         'missing_turns', 'turn_outside_allocation'):
                with self.subTest(case=case):
                    changed = deepcopy(ledger)
                    record = changed['tasks'][0]
                    cycle = record['cycles'][0]
                    if case == 'deadline_extended': cycle['deadline_monotonic'] += 1
                    elif case == 'deadline_shortened': cycle['deadline_monotonic'] -= 1
                    elif case == 'overrun': cycle['ended_monotonic'] = cycle['deadline_monotonic'] + 3
                    elif case == 'negative_start': cycle['started_monotonic'] = -1
                    elif case == 'nonfinite': cycle['ended_monotonic'] = float('nan')
                    elif case == 'bad_cycle_index': cycle['cycle'] = 2
                    elif case == 'end_before_start': cycle['ended_monotonic'] = cycle['started_monotonic'] - 1
                    elif case == 'missing_export': cycle.pop('export_monotonic')
                    elif case == 'short_reserve': cycle['export_monotonic'] += 20
                    elif case == 'wrong_final_phase': record['turns'][-1]['phase'] = 'research'
                    elif case == 'missing_turns': record['turns'] = []
                    elif case == 'turn_outside_allocation': record['turns'][-1]['ended_monotonic'] = cycle['deadline_monotonic'] + 3
                    with self.assertRaises(ValueError):
                        self.audit(job, settings, changed, receipts, challengers)

    def test_only_new_family_research_and_architecture_review_can_renew(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            settings, ledger, receipts, challengers = self.fixture(job, family='new_family')
            for index in (1, 2):
                record = ledger['tasks'][index]
                original = record['cycles'][0]
                for number in (2, 3):
                    start = original['started_monotonic'] + (number - 1) * 1900.
                    end = start + (1750. if index == 1 else 20.)
                    record['cycles'].append({'cycle': number, 'started_monotonic': start,
                                             'deadline_monotonic': start + 1800.,
                                             'export_monotonic': start + 1680., 'ended_monotonic': end})
                    record['turns'].append({'phase': 'export' if index == 1 else 'review',
                                            'started_monotonic': start + (1680. if index == 1 else 0),
                                            'ended_monotonic': end})
            self.audit(job, settings, ledger, receipts, challengers)
            for case in ('ordinary', 'parent', 'integrity_review', 'fourth_cycle', 'overlap'):
                with self.subTest(case=case):
                    changed, config = deepcopy(ledger), deepcopy(settings)
                    if case == 'ordinary':
                        config['family'] = 'all'; changed['settings']['family'] = 'all'
                    elif case in ('parent', 'integrity_review'):
                        index = 0 if case == 'parent' else 3
                        changed['tasks'][index]['cycles'].append(deepcopy(changed['tasks'][1]['cycles'][1]))
                    elif case == 'fourth_cycle': changed['tasks'][1]['cycles'].append(deepcopy(changed['tasks'][1]['cycles'][-1]))
                    elif case == 'overlap': changed['tasks'][1]['cycles'][1]['started_monotonic'] = changed['tasks'][1]['cycles'][0]['ended_monotonic'] - 1
                    with self.assertRaises(ValueError):
                        self.audit(job, config, changed, receipts, challengers)

    def test_turns_are_serial_and_end_with_their_recorded_cycle(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            settings, ledger, receipts, challengers = self.fixture(job)
            for case in ('overlap', 'reordered', 'past_cycle_end', 'early_export', 'late_research', 'thread_alias'):
                with self.subTest(case=case):
                    changed = deepcopy(ledger)
                    record = changed['tasks'][0]
                    if case == 'overlap': record['turns'][1]['started_monotonic'] -= 1
                    elif case == 'reordered': record['turns'][0], record['turns'][1] = record['turns'][1], record['turns'][0]
                    elif case == 'past_cycle_end': record['turns'][-1]['ended_monotonic'] += 1
                    elif case == 'early_export': record['turns'][-1]['started_monotonic'] = record['cycles'][0]['export_monotonic'] - 1
                    elif case == 'late_research':
                        record['turns'][1]['ended_monotonic'] = record['cycles'][0]['export_monotonic'] + 3
                        record['turns'][-1]['started_monotonic'] = record['turns'][1]['ended_monotonic']
                    elif case == 'thread_alias': record['thread_id'] = 'different thread identity'
                    with self.assertRaises(ValueError):
                        self.audit(job, settings, changed, receipts, challengers)

    def test_followup_counter_is_a_nonnegative_integer(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            settings, ledger, receipts, challengers = self.fixture(job)
            for value in (-1, True, '1', 1.5):
                with self.subTest(value=value):
                    changed = deepcopy(ledger)
                    changed['tasks'][0]['followups'] = value
                    with self.assertRaises(ValueError):
                        self.audit(job, settings, changed, receipts, challengers)


if __name__ == '__main__':
    unittest.main()

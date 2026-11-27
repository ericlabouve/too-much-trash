"""Reject the live smoke's packaging failure before any review process starts."""

from copy import deepcopy
from hashlib import sha256
import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from .agent_runtime import Supervisor
from .agent_budgets import verify_agent_budgets
from .review_bundles import PROTOCOL, preflight_bundle, preflight_report, ReviewReportError, write_review_report
from .test_agent_runtime import Clock, ProcessFactory
from . import test_agent_budgets as budget_fixtures


class ReviewBundleTests(unittest.TestCase):
    def setUp(self):
        self.directory = TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        self.job = self.root / 'job'
        self.job.mkdir()
        self.bundle = {'candidate': {'name': 'child', 'parent': 'parent'}, 'learned': True, 'files': []}
        for name, role in [('implementation.py', 'implementation'), ('evaluator.py', 'evaluator'), ('model.json', 'model')]:
            path = self.job / name
            path.write_text('synthetic fixture')
            self.bundle['files'].append({'path': name, 'sha256': sha256(path.read_bytes()).hexdigest(), 'role': role})
        self.envelope = {'candidate': self.bundle['candidate'], 'artifact_bundle': self.bundle,
                         'context': {'context_sha256': 'a' * 64}}
        self.package = self.job / 'review-package.json'
        self.save()

    def save(self):
        self.package.write_text(json.dumps(self.envelope))

    def supervisor(self, finish=False):
        factory = ProcessFactory()
        config = {'protocol': 'supervised-v1', 'job': str(self.job), 'repository': str(self.root),
                  'ledger_path': str(self.root / 'ledger.json'), 'binary': 'codex',
                  'settings': {'agent_minutes': 1, 'agent_concurrency': 1, 'family': 'all',
                               'review_agents': 1, 'review_bundle_protocol': PROTOCOL},
                  'expected': {'parent': [], 'research': 0, 'review': 0, 'integrity_review': 1}}
        if finish:
            config['settings']['agent_export_completion'] = 'finish-v1'
        runtime = Supervisor(config, clock=Clock(), popen=factory, killpg=factory.killpg,
                             snapshot=lambda: {})
        self.addCleanup(runtime.shutdown)
        return runtime, factory

    def test_duplicate_evaluator_is_rejected_before_task_slot_or_process_is_spent(self):
        runtime, factory = self.supervisor()
        self.bundle['files'].append(dict(self.bundle['files'][1]))
        self.save()
        with self.assertRaisesRegex(ValueError, 'Duplicate frozen artifact'):
            runtime.start_agent('integrity_review', 'Review child', candidate_name='child', review_bundle=str(self.package))
        self.assertEqual(runtime.tasks, {})
        self.assertEqual(factory.processes, [])
        self.bundle['files'].pop()
        self.save()
        task = runtime.start_agent('integrity_review', 'Review child', candidate_name='child', review_bundle=str(self.package))
        self.assertEqual(len(factory.processes), 1)
        self.assertEqual(task['review_bundle'], preflight_bundle(self.job, str(self.package), 'child'))

    def test_missing_package_cannot_start_a_final_reviewer(self):
        runtime, factory = self.supervisor()
        with self.assertRaises(ValueError):
            runtime.start_agent('integrity_review', 'Review child', candidate_name='child')
        self.assertEqual(factory.processes, [])

    def report(self, candidate=None, verdict='approved'):
        return {'reviewer_id': 'thread-1', 'candidate_name': 'child', 'fresh_context': True,
                'context_sha256': 'a' * 64, 'candidates': [{
                    'candidate': self.bundle['candidate'] if candidate is None else candidate,
                    'verdict': verdict, 'findings': ['Synthetic source-inspection finding.'],
                    'inspected_paths': [r['path'] for r in self.bundle['files']],
                    'checks': [{'kind': 'synthetic', 'passed': True, 'evidence': 'model.json'}],
                    'artifact_hashes': {r['path']: r['sha256'] for r in self.bundle['files']}}]}

    def test_findings_and_required_probe_structure_are_validated_before_completion(self):
        pinned = preflight_bundle(self.job, str(self.package), 'child')
        path = self.job / 'report.json'
        report = self.report()
        report['candidates'][0]['findings'] = [{'finding': 'Wrong type'}]
        path.write_text(json.dumps(report))
        with self.assertRaisesRegex(ReviewReportError, 'text strings'):
            preflight_report(self.job, str(path), pinned, 'thread-1')
        report = self.report()
        report['candidates'][0]['checks'].append({'kind': 'extra', 'passed': True, 'evidence': 'model.json'})
        path.write_text(json.dumps(report))
        with self.assertRaisesRegex(ReviewReportError, 'exactly the required'):
            preflight_report(self.job, str(path), pinned, 'thread-1', ['synthetic'])
        body = self.report()['candidates'][0]
        write_review_report(self.job, 'report.json', pinned, 'thread-1', verdict='rejected',
                            findings=body['findings'], checks=body['checks'], inspected_paths=body['inspected_paths'],
                            required_probe_kinds=['synthetic'])
        self.assertEqual(json.loads(path.read_text())['candidates'][0]['verdict'], 'rejected')

    def test_report_requires_exact_candidate_object_and_preserves_rejected_verdict(self):
        path = self.job / 'report.json'
        pinned = preflight_bundle(self.job, str(self.package), 'child')
        path.write_text(json.dumps(self.report(candidate='child')))
        with self.assertRaisesRegex(ReviewReportError, 'FULL exact candidate object'):
            preflight_report(self.job, path.name, pinned, 'thread-1')
        path.write_text(json.dumps(self.report(verdict='rejected')))
        self.assertEqual(preflight_report(self.job, path.name, pinned, 'thread-1')['candidates'][0]['verdict'], 'rejected')

    def test_malformed_review_export_resumes_same_context_and_can_finish_past_timer(self):
        runtime, factory = self.supervisor(finish=True)
        path = self.job / 'report.json'
        path.write_text(json.dumps(self.report(candidate='child')))
        task = runtime.start_agent('integrity_review', 'Review child', candidate_name='child', review_bundle=str(self.package))
        factory.processes[-1].finish(path, candidate='child')
        runtime.clock.value = 10
        runtime.tick()
        current = runtime.get_agents()['agents'][0]
        self.assertEqual((current['status'], current['phase']), ('running', 'export'))
        self.assertTrue(Path(current['report_export_correction']['original']).exists())
        runtime.clock.value = 80
        runtime.tick()
        self.assertEqual(runtime.get_agents()['agents'][0]['status'], 'running')
        path.write_text(json.dumps(self.report()))
        factory.processes[-1].finish(path, candidate='child')
        runtime.tick()
        current = runtime.get_agents()['agents'][0]
        self.assertEqual(current['status'], 'ready')
        self.assertEqual(current['agent_id'], 'thread-1')
        self.assertEqual(current['cycles'][0]['deadline_monotonic'], 60)
        self.assertEqual(len(current['turns']), 2)

    def test_unfinished_review_analysis_still_times_out(self):
        runtime, factory = self.supervisor(finish=True)
        runtime.start_agent('integrity_review', 'Review child', candidate_name='child', review_bundle=str(self.package))
        runtime.clock.value = 60
        runtime.tick()
        runtime.clock.value = 61
        runtime.tick()
        self.assertEqual(runtime.get_agents()['agents'][0]['status'], 'timed_out')

    def test_report_correction_cannot_flip_rejection_into_approval(self):
        runtime, factory = self.supervisor(finish=True)
        path = self.job / 'report.json'
        path.write_text(json.dumps(self.report(candidate='child', verdict='rejected')))
        runtime.start_agent('integrity_review', 'Review child', candidate_name='child', review_bundle=str(self.package))
        factory.processes[-1].finish(path, candidate='child')
        runtime.tick()
        path.write_text(json.dumps(self.report(verdict='approved')))
        factory.processes[-1].finish(path, candidate='child')
        runtime.tick()
        task = runtime.get_agents()['agents'][0]
        self.assertEqual(task['status'], 'failed')
        self.assertIn('cannot change verdict', task['summary'])

    def test_scope_hash_roles_and_context_are_checked(self):
        original = deepcopy(self.envelope)
        for case in ('scope', 'hash', 'roles', 'context'):
            with self.subTest(case=case):
                self.envelope = deepcopy(original)
                if case == 'scope': self.envelope['candidate'] = {'name': 'other'}
                if case == 'hash': self.envelope['artifact_bundle']['files'][0]['sha256'] = '0' * 64
                if case == 'roles': self.envelope['artifact_bundle']['files'].pop()
                if case == 'context': self.envelope['context']['context_sha256'] = 'bad'
                self.save()
                with self.assertRaises(ValueError):
                    preflight_bundle(self.job, str(self.package), 'child')

    def test_paths_cannot_escape_the_job(self):
        outside = self.root / 'outside.py'
        outside.write_text('outside')
        self.envelope['artifact_bundle']['files'][0].update(path=str(outside), sha256=sha256(outside.read_bytes()).hexdigest())
        self.save()
        with self.assertRaisesRegex(ValueError, 'inside this job'):
            preflight_bundle(self.job, str(self.package), 'child')

    def test_audit_rejects_changed_dispatch_package_or_different_published_graph(self):
        settings, ledger, receipts, challengers = budget_fixtures.AgentBudgetTests().fixture(self.job)
        settings['review_bundle_protocol'] = PROTOCOL
        ledger['settings']['review_bundle_protocol'] = PROTOCOL
        record = next(task for task in ledger['tasks'] if task['kind'] == 'integrity_review')
        record['review_bundle'] = preflight_bundle(self.job, str(self.package), 'child')
        (self.job / 'agent-runtime.json').write_text(json.dumps(ledger))
        self.assertEqual(verify_agent_budgets(self.job, receipts, settings, challengers, {'child': self.bundle})['tasks'], 4)
        changed = deepcopy(self.bundle)
        dependency = self.job / 'new-dependency.py'
        dependency.write_text('new graph dependency')
        changed['files'].append({'path': dependency.name, 'sha256': sha256(dependency.read_bytes()).hexdigest(), 'role': 'dependency'})
        with self.assertRaisesRegex(ValueError, 'Published candidate graph'):
            verify_agent_budgets(self.job, receipts, settings, challengers, {'child': changed})
        self.envelope['note'] = 'edited after dispatch'
        self.save()
        with self.assertRaisesRegex(ValueError, 'changed after reviewer dispatch'):
            verify_agent_budgets(self.job, receipts, settings, challengers, {'child': self.bundle})


if __name__ == '__main__':
    unittest.main()

"""Dashboard integration cannot bypass runner-owned child lifetimes."""

import json
from pathlib import Path
from tempfile import TemporaryDirectory
import tomllib
import unittest
from unittest.mock import patch

from dashboard_agents import (coordinator_command, coordinator_prompt, execute,
                              supervisor_configuration, verify_completion, completed_export_wall_seconds)
from dashboard_server import validate_settings
from ml.evolution.agent_budgets import PROTOCOL
import test_dashboard_agents as receipt_fixtures


class DashboardAgentBudgetTests(unittest.TestCase):
    def settings(self, payload=None):
        with patch('dashboard_server.discover_datasets', return_value=[
                {'name': 'beach', 'clip_count': 242}, {'name': 'home', 'clip_count': 5},
                {'name': 'park', 'clip_count': 57}]):
            return validate_settings(payload or {})

    def test_new_api_jobs_require_supervised_lifetimes(self):
        self.assertEqual(self.settings()['agent_budget_protocol'], PROTOCOL)
        for protocol in ('prompt-only', '', None, True):
            with self.subTest(protocol=protocol), self.assertRaisesRegex(ValueError, 'supervised-v1'):
                self.settings({'agent_budget_protocol': protocol})

    def test_review_packages_are_checked_before_dispatch_and_cannot_opt_out(self):
        self.assertEqual(self.settings()['review_bundle_protocol'], 'frozen-bundle-v1')
        for protocol in (None, '', 'unchecked'):
            with self.subTest(protocol=protocol), self.assertRaisesRegex(ValueError, 'frozen-bundle-v1'):
                self.settings({'review_bundle_protocol': protocol})

    def test_short_budget_export_floor_cannot_be_disabled(self):
        self.assertEqual(self.settings()['agent_export_min_seconds'], 60)
        for value in (None, 5, 0, 120):
            with self.subTest(value=value), self.assertRaisesRegex(ValueError, 'export minimum'):
                self.settings({'agent_export_min_seconds': value})
        self.assertEqual(self.settings()['agent_export_completion'], 'finish-v1')
        with self.assertRaisesRegex(ValueError, 'export to finish'):
            self.settings({'agent_export_completion': None})

    def test_outer_timeout_pauses_for_actual_export_union_not_parallel_sum(self):
        with TemporaryDirectory() as directory:
            path = Path(directory) / 'ledger.json'
            ledger = {'settings': {'agent_export_completion': 'finish-v1'}, 'tasks': [
                {'kind': 'parent', 'turns': [{'phase': 'research', 'started_monotonic': 0, 'ended_monotonic': 5},
                                           {'phase': 'export', 'started_monotonic': 10, 'ended_monotonic': 20}]},
                {'kind': 'research', 'turns': [{'phase': 'export', 'started_monotonic': 15}]},
                {'kind': 'integrity_review', 'turns': [{'phase': 'review', 'started_monotonic': 0}]}]}
            path.write_text(json.dumps(ledger))
            self.assertEqual(completed_export_wall_seconds(path, 30), 20)
            self.assertEqual(completed_export_wall_seconds(path, 50), 40)
            ledger['settings'] = {}
            path.write_text(json.dumps(ledger))
            self.assertEqual(completed_export_wall_seconds(path, 50), 0)

    def test_coordinator_has_only_the_required_supervised_dispatch_mcp(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            command = coordinator_command('codex', job, job / 'schema.json', job / 'final.json')
            self.assertIn('--disable', command)
            self.assertEqual(command[command.index('--disable') + 1], 'multi_agent')
            self.assertNotIn('--enable', command)
            self.assertIn('--approve-for-me', command)
            overrides = [command[index + 1] for index, value in enumerate(command) if value == '-c']
            config = tomllib.loads('\n'.join(overrides))
            mcp = config['mcp_servers']['evolution_agents']
            self.assertTrue(mcp['required'])
            self.assertEqual(mcp['args'], ['-m', 'ml.evolution.agent_runtime', '--config', str(job / 'runtime-config.json')])
            self.assertIn('PYTHONPATH', mcp['env'])
            self.assertGreaterEqual(mcp['tool_timeout_sec'], 30)
            self.assertEqual(command[-1], '-')

    def test_supervisor_registration_counts_exact_parent_research_and_reviewer_tasks(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve() / 'job'
            job.mkdir()
            config, manifests, _, _, _, _ = receipt_fixtures.AgentReceiptTests().fixture(job)
            prior = json.loads(Path(config['prior']).read_text())
            settings = self.settings({'research_slots': 3})
            runtime = supervisor_configuration(prior, settings, job, 'codex')
            self.assertEqual(runtime['protocol'], PROTOCOL)
            self.assertEqual(runtime['expected'], {'parent': ['Threshold parent'], 'research': 3,
                                                   'review': 0, 'integrity_review': 4})
            self.assertFalse(Path(runtime['ledger_path']).is_relative_to(job))
            self.assertTrue(Path(runtime['ledger_path']).is_relative_to(job.parent))
            config['settings'] = settings
            prompt = coordinator_prompt(config, job, manifests)
            for contract in ('evolution_agents MCP tools', 'Built-in multi_agent is disabled',
                             'early author reply does NOT', 'ORIGINAL deadline', 'finalization-only turn',
                             'Only a concrete documented blocker', 'Do not activate native Goals'):
                with self.subTest(contract=contract):
                    self.assertIn(contract, prompt)

    def test_completion_requires_supervisor_ledger_before_deployment_or_review_audits(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            config, manifests, final, result, _, _ = receipt_fixtures.AgentReceiptTests().fixture(job)
            config['settings'].update(agent_budget_protocol=PROTOCOL, benchmark_protocol='deployment-v1')
            result['benchmark_protocol'] = 'deployment-v1'
            (job / 'results.json').write_text(json.dumps(result))
            with self.assertRaises(FileNotFoundError) as raised:
                verify_completion(job, final, config, manifests)
            self.assertIn('agent-runtime.json', str(raised.exception))

    def test_worker_rejects_missing_budget_protocol_before_any_live_dispatch(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            settings = self.settings()
            settings.pop('agent_budget_protocol')
            config = job / 'config.json'
            config.write_text(json.dumps({'settings': settings, 'prior': 'unused'}))
            with patch('dashboard_agents.readiness') as readiness:
                with self.assertRaisesRegex(ValueError, 'supervised-v1 per-agent lifecycle'):
                    execute(config)
                readiness.assert_not_called()


if __name__ == '__main__':
    unittest.main()

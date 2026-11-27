"""Supervision tests use synthetic child replies, never model or training calls."""

from io import StringIO
import json
from pathlib import Path
import signal
import subprocess
import sys
from tempfile import TemporaryDirectory
import time
from types import MethodType
import unittest
from unittest.mock import patch

from ml.evolution.agent_runtime import PROTOCOL, Supervisor, serve


class Clock:
    value = 0.
    def __call__(self):
        return self.value


class FakeProcess:
    def __init__(self, pid, argv, stdout, thread):
        self.pid, self.argv, self.returncode = pid, argv, None
        self.stdin = StringIO()
        self.final = Path(argv[argv.index('--output-last-message') + 1])
        stdout.write(json.dumps({'type': 'thread.started', 'thread_id': thread}) + '\n')
        stdout.flush()
    def poll(self):
        return self.returncode
    def wait(self, timeout=None):
        if self.returncode is None:
            raise subprocess.TimeoutExpired(self.argv, timeout)
        return self.returncode
    def finish(self, artifact, *, status='ready', candidate='candidate'):
        self.final.write_text(json.dumps({'status': status, 'summary': 'Synthetic validation result',
                                         'artifact': str(artifact), 'candidate_name': candidate}))
        self.returncode = 0


class ProcessFactory:
    def __init__(self):
        self.processes, self.signals = [], []
        self.replace_identity = False
    def __call__(self, argv, **kwargs):
        thread = argv[argv.index('resume') + 1] if 'resume' in argv else f'thread-{len(self.processes) + 1}'
        if self.replace_identity:
            thread = 'different-thread'
        process = FakeProcess(800000 + len(self.processes), argv, kwargs['stdout'], thread)
        self.processes.append(process)
        return process
    def killpg(self, pid, sig):
        self.signals.append((pid, sig))
        for process in self.processes:
            if process.pid == pid and sig == signal.SIGKILL:
                process.returncode = -9 if process.returncode is None else process.returncode


class SupervisorTests(unittest.TestCase):
    def setUp(self):
        self.directory = TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        self.job = self.root / 'job'; self.job.mkdir()
        self.artifact = self.job / 'candidate.json'; self.artifact.write_text('{"synthetic":true}')
        self.clock, self.factory = Clock(), ProcessFactory()
        self.config = {'protocol': PROTOCOL, 'job': str(self.job), 'repository': str(self.root),
                       'ledger_path': str(self.root / 'trusted-ledger.json'), 'binary': 'codex',
                       'settings': {'agent_minutes': 1, 'agent_concurrency': 1,
                                    'family': 'all', 'review_agents': 1, 'agent_prompt': 'My exact direction'},
                       'expected': {'parent': ['parent-A'], 'research': 2, 'review': 1, 'integrity_review': 2}}
        self.runtime = Supervisor(self.config, clock=self.clock, popen=self.factory, killpg=self.factory.killpg)
        self.addCleanup(self.runtime.shutdown)

    def start(self, kind='parent', **kwargs):
        if kind == 'parent': kwargs.setdefault('parent', 'parent-A')
        return self.runtime.start_agent(kind, 'Synthetic agent assignment', **kwargs)

    def export_finish(self, task, candidate='candidate'):
        self.clock.value = task['cycles'][-1]['export_monotonic']
        self.runtime.tick()
        self.clock.value += 1
        self.runtime.tick()
        self.factory.processes[-1].finish(self.artifact, candidate=candidate)
        self.clock.value += .5
        self.runtime.tick()

    def test_early_ready_resumes_same_identity_without_renewing_deadline(self):
        task = self.start()
        self.clock.value = 4
        self.factory.processes[-1].finish(self.artifact)
        self.runtime.tick()
        current = self.runtime.get_agents()['agents'][0]
        self.assertEqual(current['status'], 'running')
        self.assertEqual(current['followups'], 1)
        self.assertEqual(current['agent_id'], 'thread-1')
        self.assertEqual(current['cycles'][0]['deadline_monotonic'], 60)
        self.assertIn('resume', self.factory.processes[-1].argv)
        self.assertEqual(self.factory.processes[-1].argv[self.factory.processes[-1].argv.index('resume') + 1], 'thread-1')

    def test_failed_canonical_training_gate_consumes_no_reviewer_slot(self):
        self.runtime.config['review_preflight_command'] = ['/trusted/python', 'canonical-training-check']
        with patch('ml.evolution.agent_runtime.subprocess.run') as run:
            run.return_value = subprocess.CompletedProcess([], 1, '', 'Invalid epoch predictions')
            with self.assertRaisesRegex(ValueError, 'blocked reviewer dispatch'):
                self.start('integrity_review', candidate_name='candidate')
            self.assertEqual(self.runtime.tasks, {})
            self.assertEqual(self.factory.processes, [])
            run.return_value = subprocess.CompletedProcess([], 0, '{"status":"passed"}', '')
            task = self.start('integrity_review', candidate_name='candidate')
            self.assertEqual(task['training_preflight']['status'], 'passed')
            self.assertEqual(len(self.runtime.tasks), 1)

    def test_export_interrupts_research_then_finishes_before_original_deadline(self):
        task = self.start()
        self.export_finish(task)
        current = self.runtime.get_agents()['agents'][0]
        self.assertEqual((current['status'], current['phase']), ('ready', 'terminal'))
        self.assertEqual([turn['phase'] for turn in current['turns']], ['research', 'export'])
        self.assertIn((800000, signal.SIGTERM), self.factory.signals)
        self.assertIn((800000, signal.SIGKILL), self.factory.signals)
        self.assertEqual(current['cycles'][0]['deadline_monotonic'], 60)
        self.assertLess(current['cycles'][0]['ended_monotonic'], 60)
        self.assertIn('EXPORT ONLY', Path(current['turns'][-1]['prompt_path']).read_text())

    def test_hard_deadline_kills_only_the_owned_group_and_fails_closed(self):
        task = self.start()
        self.clock.value = 60
        self.runtime.tick()
        self.clock.value = 61
        self.runtime.tick()
        current = self.runtime.get_agents()['agents'][0]
        self.assertEqual(current['status'], 'timed_out')
        self.assertEqual(current['cycles'][0]['ended_monotonic'], 61)
        self.assertEqual({pid for pid, _ in self.factory.signals}, {800000})

    def test_two_minute_export_floor_uses_same_identity_and_original_deadline(self):
        self.runtime.shutdown()
        self.config['settings'].update(agent_minutes=2, agent_export_min_seconds=60)
        self.runtime = Supervisor(self.config, clock=self.clock, popen=self.factory,
                                  killpg=self.factory.killpg, snapshot=lambda: {})
        self.addCleanup(self.runtime.shutdown)
        task = self.start()
        self.assertEqual(task['cycles'][0]['export_monotonic'], 60)
        self.assertEqual(task['cycles'][0]['deadline_monotonic'], 120)
        self.export_finish(task)
        current = self.runtime.get_agents()['agents'][0]
        self.assertEqual(current['status'], 'ready')
        self.assertEqual(current['agent_id'], 'thread-1')
        self.assertEqual(current['cycles'][0]['deadline_monotonic'], 120)
        self.assertLess(current['cycles'][0]['ended_monotonic'], 120)

    def test_in_progress_export_can_finish_past_nominal_deadline(self):
        self.runtime.shutdown()
        self.config['settings'].update(agent_minutes=2, agent_export_min_seconds=60,
                                       agent_export_completion='finish-v1')
        self.runtime = Supervisor(self.config, clock=self.clock, popen=self.factory,
                                  killpg=self.factory.killpg, snapshot=lambda: {})
        self.addCleanup(self.runtime.shutdown)
        task = self.start()
        self.clock.value = 60
        self.runtime.tick()
        self.clock.value = 61
        self.runtime.tick()
        self.clock.value = 150
        self.runtime.tick()
        current = self.runtime.get_agents()['agents'][0]
        self.assertEqual((current['status'], current['phase']), ('running', 'export'))
        self.assertEqual(self.factory.processes[-1].poll(), None)
        self.factory.processes[-1].finish(self.artifact)
        self.clock.value = 155
        self.runtime.tick()
        current = self.runtime.get_agents()['agents'][0]
        self.assertEqual(current['status'], 'ready')
        self.assertEqual(current['agent_id'], 'thread-1')
        self.assertEqual(current['cycles'][0]['deadline_monotonic'], 120)
        self.assertEqual(current['cycles'][0]['ended_monotonic'], 155)

    def test_queued_agent_clock_starts_when_slot_becomes_available(self):
        self.start('review')
        second = self.start('research')
        self.assertEqual(second['status'], 'queued')
        self.assertEqual(second['cycles'], [])
        self.clock.value = 12
        self.factory.processes[0].finish(self.artifact, candidate='')
        self.runtime.tick()
        current = self.runtime.get_agents([second['task_id']])['agents'][0]
        self.assertEqual(current['cycles'][0]['started_monotonic'], 12)
        self.assertEqual(current['cycles'][0]['deadline_monotonic'], 72)

    def test_six_slots_start_six_agents_and_queue_seventh_without_spending_time(self):
        self.runtime.shutdown()
        self.config['settings']['agent_concurrency'] = 6
        self.config['expected']['integrity_review'] = 7
        self.runtime = Supervisor(self.config, clock=self.clock, popen=self.factory,
                                  killpg=self.factory.killpg, snapshot=lambda: {})
        self.addCleanup(self.runtime.shutdown)
        tasks = [self.start('integrity_review', candidate_name=f'candidate-{i}') for i in range(7)]
        self.assertEqual(len(self.factory.processes), 6)
        self.assertEqual(tasks[-1]['status'], 'queued')
        self.assertEqual(tasks[-1]['cycles'], [])
        self.clock.value = 12
        self.factory.processes[0].finish(self.artifact, candidate='candidate-0')
        self.runtime.tick()
        last = self.runtime.get_agents([tasks[-1]['task_id']])['agents'][0]
        self.assertEqual(last['cycles'][0]['started_monotonic'], 12)
        self.assertEqual(last['cycles'][0]['deadline_monotonic'], 72)

    def test_reviewers_finish_early_and_keep_independent_ids(self):
        first = self.start('integrity_review', candidate_name='A')
        self.factory.processes[-1].finish(self.artifact, candidate='A')
        self.runtime.tick()
        second = self.start('integrity_review', candidate_name='B')
        self.factory.processes[-1].finish(self.artifact, candidate='B')
        self.runtime.tick()
        records = self.runtime.get_agents()['agents']
        self.assertEqual({item['status'] for item in records}, {'ready'})
        self.assertEqual({item['followups'] for item in records}, {0})
        self.assertEqual(len({item['agent_id'] for item in records}), 2)
        self.assertNotEqual(first['task_id'], second['task_id'])

    def test_reviewer_cannot_cover_another_candidate(self):
        self.start('integrity_review', candidate_name='A')
        self.factory.processes[-1].finish(self.artifact, candidate='B')
        self.runtime.tick()
        self.assertEqual(self.runtime.get_agents()['agents'][0]['status'], 'failed')

    def test_blocker_stops_early_with_evidence(self):
        self.start()
        self.factory.processes[-1].finish(self.artifact, status='blocked', candidate='')
        self.clock.value = 5
        self.runtime.tick()
        current = self.runtime.get_agents()['agents'][0]
        self.assertEqual(current['status'], 'blocked')
        self.assertEqual(len(current['turns']), 1)

    def test_identity_change_on_resume_fails_closed(self):
        self.start()
        self.factory.replace_identity = True
        self.factory.processes[-1].finish(self.artifact)
        self.runtime.tick()
        self.runtime.tick()
        self.clock.value = 1
        self.runtime.tick()
        self.assertEqual(self.runtime.get_agents()['agents'][0]['status'], 'failed')

    def test_job_event_mirror_cannot_forge_actual_child_identity(self):
        task = self.start()
        mirror = Path(task['turns'][0]['events_path'])
        mirror.write_text(json.dumps({'type': 'thread.started', 'thread_id': 'forged'}) + '\n')
        self.runtime.tick()
        current = self.runtime.get_agents()['agents'][0]
        self.assertEqual(current['agent_id'], 'thread-1')
        self.factory.processes[-1].finish(self.artifact, status='blocked')
        self.runtime.tick()
        self.assertIn('thread-1', mirror.read_text())
        self.assertNotIn('forged', mirror.read_text())

    def test_ordinary_feedback_never_renews_deadline_and_reaches_followup(self):
        task = self.start()
        self.clock.value = 7
        self.runtime.send_message(task['task_id'], 'Inspect the missed releases')
        self.factory.processes[-1].finish(self.artifact)
        self.runtime.tick()
        current = self.runtime.get_agents()['agents'][0]
        prompt = Path(current['turns'][-1]['prompt_path']).read_text()
        self.assertIn('Inspect the missed releases', prompt)
        self.assertIn('My exact direction', prompt)
        self.assertEqual(current['cycles'][0]['deadline_monotonic'], 60)
        self.runtime.close_agent(task['task_id'])
        self.clock.value += 1
        self.runtime.tick()
        with self.assertRaises(ValueError):
            self.runtime.send_message(task['task_id'], 'Restart')

    def test_only_explicit_new_family_cycles_two_and_three_renew(self):
        self.runtime.settings['family'] = 'new_family'
        task = self.start('research')
        self.export_finish(task)
        self.clock.value = 57
        renewed = self.runtime.send_message(task['task_id'], 'Architecture needs revision', architecture_cycle=2)
        self.assertEqual(renewed['agent_id'], 'thread-1')
        self.assertEqual(renewed['cycles'][-1]['deadline_monotonic'], 117)
        self.export_finish(renewed)
        renewed = self.runtime.send_message(task['task_id'], 'Third architecture pass', architecture_cycle=3)
        self.export_finish(renewed)
        with self.assertRaises(ValueError):
            self.runtime.send_message(task['task_id'], 'Fourth pass', architecture_cycle=4)

    def test_limits_and_nonlocal_artifacts_are_rejected(self):
        self.start()
        with self.assertRaises(ValueError): self.start()
        with self.assertRaises(ValueError): self.start('parent', parent='unselected')
        outside = self.root / 'outside.json'; outside.write_text('{}')
        self.factory.processes[-1].finish(outside)
        self.runtime.tick()
        self.assertEqual(self.runtime.get_agents()['agents'][0]['status'], 'failed')

    def test_mcp_eof_cleans_running_processes_and_returns_protocol_responses(self):
        requests = [
            {'jsonrpc': '2.0', 'id': 1, 'method': 'initialize', 'params': {'protocolVersion': '2024-11-05'}},
            {'jsonrpc': '2.0', 'method': 'notifications/initialized'},
            {'jsonrpc': '2.0', 'id': 2, 'method': 'tools/list'},
            {'jsonrpc': '2.0', 'id': 3, 'method': 'tools/call', 'params': {
                'name': 'start_agent', 'arguments': {'kind': 'parent', 'parent': 'parent-A', 'prompt': 'Synthetic only'}}},
        ]
        output = StringIO()
        serve(self.runtime, StringIO('\n'.join(json.dumps(item) for item in requests)), output)
        responses = [json.loads(line) for line in output.getvalue().splitlines()]
        self.assertEqual([item['id'] for item in responses], [1, 2, 3])
        self.assertEqual(len(responses[1]['result']['tools']), 5)
        ledger = json.loads(Path(self.config['ledger_path']).read_text())
        self.assertEqual(ledger['tasks'][0]['status'], 'closed')
        self.assertIn((800000, signal.SIGKILL), self.factory.signals)

    def test_real_harmless_sleeping_process_is_killed_at_deadline(self):
        real = Supervisor(self.config, clock=self.clock)
        self.addCleanup(real.shutdown)
        real._argv = MethodType(lambda owner, task, final: [sys.executable, '-c', 'import time; time.sleep(30)'], real)
        task = real.start_agent('parent', 'Harmless local process only', parent='parent-A')
        process = real.tasks[task['task_id']]['_process']
        self.clock.value = 60
        real.tick()
        self.clock.value = 61
        real.tick()
        self.assertIsNotNone(process.poll())
        self.assertEqual(real.get_agents()['agents'][0]['status'], 'timed_out')

    def test_stalled_stdin_reader_cannot_block_watchdog(self):
        real = Supervisor(self.config, clock=self.clock)
        self.addCleanup(real.shutdown)
        real._argv = MethodType(lambda owner, task, final: [sys.executable, '-c', 'import time; time.sleep(30)'], real)
        started = time.monotonic()
        task = real.start_agent('parent', 'x' * 1000000, parent='parent-A')
        self.assertLess(time.monotonic() - started, 1.)
        self.assertFalse(task['turns'][0]['prompt_delivered'])
        process = real.tasks[task['task_id']]['_process']
        self.clock.value = 60
        real.tick()
        self.clock.value = 61
        real.tick()
        self.assertIsNotNone(process.poll())
        self.assertEqual(real.get_agents()['agents'][0]['status'], 'timed_out')

    def test_shutdown_closes_queue_and_cannot_restart_without_watchdog(self):
        task = self.start()
        queued = self.start('research')
        self.runtime.shutdown()
        count = len(self.factory.processes)
        self.runtime.tick()
        self.assertEqual(len(self.factory.processes), count)
        self.assertEqual(self.runtime.tasks[queued['task_id']]['status'], 'closed')
        with self.assertRaises(ValueError): self.start('research')
        with self.assertRaises(ValueError): self.runtime.send_message(task['task_id'], 'Restart')

    def test_recycled_descendant_pid_is_not_a_cleanup_target(self):
        observed = {800000: (1, 'CLI start'), 800010: (800000, 'original child')}
        killed = []
        self.runtime.snapshot = lambda: dict(observed)
        self.runtime.kill = lambda pid, sig: killed.append((pid, sig))
        self.start()
        self.runtime.tick()
        observed[800010] = (999, 'replacement process')
        self.clock.value = 60
        self.runtime.tick()
        self.clock.value = 61
        self.runtime.tick()
        self.assertNotIn(800010, [pid for pid, _ in killed])

    def test_grandchild_in_new_session_is_stopped_without_killing_unrelated_process(self):
        real = Supervisor(self.config, clock=self.clock)
        self.addCleanup(real.shutdown)
        marker = self.job / 'grandchild.pid'
        child_code = 'import signal,time;signal.signal(signal.SIGTERM,signal.SIG_IGN);time.sleep(30)'
        parent_code = ('import subprocess,sys,time;from pathlib import Path;'
                       f'p=subprocess.Popen([sys.executable,"-c",{child_code!r}],start_new_session=True);'
                       f'Path({str(marker)!r}).write_text(str(p.pid));time.sleep(30)')
        real._argv = MethodType(lambda owner, task, final: [sys.executable, '-c', parent_code], real)
        unrelated = subprocess.Popen([sys.executable, '-c', 'import time;time.sleep(30)'], start_new_session=True)
        def cleanup_unrelated():
            if unrelated.poll() is None: unrelated.kill()
            unrelated.wait(timeout=2)
        self.addCleanup(cleanup_unrelated)
        task = real.start_agent('parent', 'Synthetic tree only', parent='parent-A')
        until = time.monotonic() + 3
        while not marker.exists() and time.monotonic() < until:
            time.sleep(.01)
        self.assertTrue(marker.exists(), 'Synthetic grandchild did not start')
        child_pid = int(marker.read_text())
        real.tick()
        self.assertIn(child_pid, [item['pid'] for item in real.tasks[task['task_id']]['owned_processes']])
        self.clock.value = 60
        real.tick()
        self.clock.value = 61
        real.tick()
        self.assertIsNone(unrelated.poll())
        state = subprocess.run(['ps', '-o', 'stat=', '-p', str(child_pid)], capture_output=True, text=True, timeout=1)
        self.assertTrue(not state.stdout.strip() or state.stdout.strip().startswith('Z'), state.stdout)
        self.assertEqual(real.get_agents()['agents'][0]['status'], 'timed_out')


if __name__ == '__main__':
    unittest.main()

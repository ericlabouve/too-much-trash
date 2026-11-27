"""Exercise real MCP stdio and OS process cleanup with a synthetic Codex helper.

No model calls, training, dataset reads, or experiment rounds occur in these tests.
"""

import json
import os
from pathlib import Path
import queue
import signal
import subprocess
import sys
from tempfile import TemporaryDirectory
import threading
import time
import unittest

from ml.evolution.agent_budgets import verify_agent_budgets


REPOSITORY = Path(__file__).resolve().parents[2]
FAKE_CODEX = '''#!{python}
import json, os, pathlib, signal, sys, time
signal.signal(signal.SIGTERM, signal.SIG_IGN)
arguments=sys.argv[1:]
thread=(arguments[arguments.index('resume')+1] if 'resume' in arguments else 'synthetic-thread-'+str(os.getpid()))
print(json.dumps({{'type':'thread.started','thread_id':thread}}),flush=True)
prompt=sys.stdin.read()
if 'FAST_REVIEW' in prompt:
    output=pathlib.Path(arguments[arguments.index('--output-last-message')+1])
    artifact=pathlib.Path(arguments[arguments.index('--add-dir')+1])/'synthetic-report.json'
    artifact.write_text('{{"synthetic":true}}')
    output.write_text(json.dumps({{'status':'ready','summary':'Synthetic complete review',
                                  'artifact':str(artifact),'candidate_name':'candidate-A'}}))
else:
    time.sleep(30)
'''


class MCPProcess:
    def __init__(self, directory, *, minutes=1, concurrency=1):
        self.root = Path(directory)
        self.job = self.root / 'job'
        self.job.mkdir()
        binary = self.root / 'fake-codex'
        binary.write_text(FAKE_CODEX.format(python=sys.executable))
        binary.chmod(0o700)
        config = {
            'protocol': 'supervised-v1', 'job': str(self.job),
            'repository': str(REPOSITORY), 'ledger_path': str(self.root / 'private-ledger.json'),
            'binary': str(binary),
            'settings': {'agent_minutes': minutes, 'agent_concurrency': concurrency,
                         'family': 'all', 'review_agents': 1},
            'expected': {'parent': ['parent-A'], 'research': 2, 'review': 1, 'integrity_review': 2},
        }
        config_path = self.root / 'runtime-config.json'
        config_path.write_text(json.dumps(config))
        self.stderr_path = self.root / 'stderr.log'
        self.stderr = self.stderr_path.open('w')
        self.process = subprocess.Popen(
            [sys.executable, '-m', 'ml.evolution.agent_runtime', '--config', str(config_path)],
            stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=self.stderr,
            text=True, cwd=str(REPOSITORY), start_new_session=True)
        self.messages = queue.Queue()
        self.serial = 0
        self.agent_pids = set()

        def read():
            for line in self.process.stdout:
                self.messages.put(line)
            self.messages.put(None)
        threading.Thread(target=read, daemon=True).start()
        self.rpc('initialize', {'protocolVersion': '2024-11-05',
                                'clientInfo': {'name': 'synthetic-test', 'version': '1'}})
        self.process.stdin.write(json.dumps({'jsonrpc': '2.0', 'method': 'notifications/initialized'}) + '\n')
        self.process.stdin.flush()

    def rpc(self, method, params=None, timeout=8):
        self.serial += 1
        self.process.stdin.write(json.dumps({'jsonrpc': '2.0', 'id': self.serial,
                                             'method': method, 'params': params or {}}) + '\n')
        self.process.stdin.flush()
        line = self.messages.get(timeout=timeout)
        if line is None:
            raise AssertionError('MCP exited: ' + self.stderr_path.read_text())
        response = json.loads(line)  # Any stdout noise is a protocol failure.
        if response.get('id') != self.serial or response.get('jsonrpc') != '2.0' or 'error' in response:
            raise AssertionError(response)
        return response['result']

    def tool(self, name, **arguments):
        result = self.rpc('tools/call', {'name': name, 'arguments': arguments})
        if result.get('isError'):
            raise AssertionError(result)
        value = json.loads(result['content'][0]['text'])
        agents = value.get('agents', []) if isinstance(value, dict) else []
        if isinstance(value, dict) and 'task_id' in value:
            agents = [value]
        for agent in agents:
            self.agent_pids.update(turn['pid'] for turn in agent.get('turns', []) if 'pid' in turn)
        return value

    def wait_status(self, identifier, status, timeout=8):
        deadline = time.monotonic() + timeout
        while time.monotonic() < deadline:
            task = self.tool('get_agents', task_ids=[identifier])['agents'][0]
            if task['status'] == status:
                return task
            time.sleep(.1)
        raise AssertionError(f'Task did not reach {status}: {task}')

    def close(self):
        if self.process.poll() is None:
            self.process.terminate()
            try:
                self.process.wait(timeout=3)
            except subprocess.TimeoutExpired:
                self.process.kill()
                self.process.wait(timeout=3)
        # Always clean test-owned helper groups even if testing a regression.
        for pid in self.agent_pids:
            try:
                os.killpg(pid, signal.SIGKILL)
            except ProcessLookupError:
                pass
        self.stderr.close()
        self.process.stdout.close()
        if not self.process.stdin.closed:
            self.process.stdin.close()


class RuntimeStdioTests(unittest.TestCase):
    def make_server(self, **settings):
        directory = TemporaryDirectory()
        self.addCleanup(directory.cleanup)
        server = MCPProcess(directory.name, **settings)
        self.addCleanup(server.close)
        return server

    def assert_helper_reaped(self, pid):
        with self.assertRaises(ProcessLookupError):
            os.kill(pid, 0)

    def test_tools_start_get_wait_and_cancel_use_real_stdio_without_noise(self):
        server = self.make_server()
        self.assertEqual({tool['name'] for tool in server.rpc('tools/list')['tools']},
                         {'start_agent', 'get_agents', 'wait_agents', 'send_message', 'close_agent'})
        first = server.tool('start_agent', kind='research', prompt='SYNTHETIC_SLEEP')
        second = server.tool('start_agent', kind='research', prompt='SYNTHETIC_SLEEP')
        self.assertEqual(second['status'], 'queued')
        self.assertEqual(second['cycles'], [])
        pid = first['turns'][0]['pid']
        self.assertEqual(os.getpgid(pid), pid)
        waiting = server.tool('wait_agents', task_ids=[first['task_id']], timeout_seconds=0)
        self.assertEqual(waiting['agents'][0]['status'], 'running')
        server.tool('close_agent', task_id=first['task_id'])
        server.wait_status(first['task_id'], 'closed')
        self.assert_helper_reaped(pid)
        second = server.tool('get_agents', task_ids=[second['task_id']])['agents'][0]
        self.assertEqual(second['status'], 'running')
        self.assertTrue(second['cycles'])
        server.tool('close_agent', task_id=second['task_id'])
        server.wait_status(second['task_id'], 'closed')

    def test_completed_reviewer_report_survives_transport(self):
        server = self.make_server()
        task = server.tool('start_agent', kind='integrity_review',
                           candidate_name='candidate-A', prompt='FAST_REVIEW')
        completed = server.wait_status(task['task_id'], 'ready')
        self.assertEqual(completed['candidate_name'], 'candidate-A')
        self.assertEqual(completed['followups'], 0)
        self.assertTrue(Path(completed['artifact']).is_file())
        self.assertEqual(completed['agent_id'], completed['thread_id'])
        # Exercise the real supervisor/auditor schema boundary, not a separately
        # invented ledger fixture. The outer worker normally performs this copy.
        (server.job / 'agent-runtime.json').write_bytes((server.root / 'private-ledger.json').read_bytes())
        settings = json.loads((server.root / 'runtime-config.json').read_text())['settings']
        settings['agent_budget_protocol'] = 'supervised-v1'
        receipt = {'tasks': [{'kind': 'integrity_review', 'status': 'completed',
                             'agent_id': completed['agent_id'], 'candidate_name': 'candidate-A',
                             'artifact': completed['artifact'], 'prompt_path': completed['prompt_path']}]}
        audit = verify_agent_budgets(server.job, receipt, settings)
        self.assertEqual(audit['tasks'], 1)

    def test_eof_reaps_child_even_when_it_ignores_sigterm(self):
        server = self.make_server()
        task = server.tool('start_agent', kind='research', prompt='SYNTHETIC_SLEEP')
        pid = task['turns'][0]['pid']
        server.process.stdin.close()
        self.assertEqual(server.process.wait(timeout=4), 0)
        self.assert_helper_reaped(pid)

    def test_sigterm_and_sigint_reap_children(self):
        for sig in (signal.SIGTERM, signal.SIGINT):
            with self.subTest(signal=sig):
                server = self.make_server()
                task = server.tool('start_agent', kind='research', prompt='SYNTHETIC_SLEEP')
                pid = task['turns'][0]['pid']
                os.kill(server.process.pid, sig)
                server.process.wait(timeout=4)
                self.assert_helper_reaped(pid)

    def test_watchdog_deadline_is_enforced_without_coordinator_polling(self):
        # Fractional minutes shorten only this synthetic process test. The public
        # dashboard still requires integer minutes and no experiment is started.
        server = self.make_server(minutes=.05)
        task = server.tool('start_agent', kind='research', prompt='SYNTHETIC_SLEEP')
        time.sleep(4.5)
        completed = server.wait_status(task['task_id'], 'timed_out', timeout=2)
        self.assertEqual(completed['cycles'][0]['deadline_monotonic'] -
                         completed['cycles'][0]['started_monotonic'], 3)
        self.assertTrue(all(turn['phase'] in ('research', 'export') for turn in completed['turns']))
        self.assertTrue(all(turn.get('reason') for turn in completed['turns']))
        for turn in completed['turns']:
            self.assert_helper_reaped(turn['pid'])


if __name__ == '__main__':
    unittest.main()

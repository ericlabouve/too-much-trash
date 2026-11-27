"""Bounded, harmless Goal continuation diagnostic for the installed Codex CLI.

This starts one isolated read-only `codex exec`, never an experiment round.
Artifacts belong in a temporary/generated directory, not in Git. The probe's
own goal is cleared and its own thread archived through a separate app server.
It does not enable features, alter global configuration, copy authentication,
or claim that API availability proves CLI automatic continuation.

Example (allows up to 60 seconds for exec plus bounded cleanup)::

    python -m ml.evolution.goal_probe --output /tmp/tmt-goal-probe --timeout 60

Verified on Codex CLI 0.160.0, 2026-11-26: persistent exec created a Goal but
returned after one turn while it remained active. An independently exercised
persistent app-server thread automatically continued into a second turn;
ephemeral app-server threads rejected Goal set/get. Recheck after runtime
upgrades rather than assuming these surfaces share continuation semantics.
"""

import argparse
from collections import Counter
import json
import os
from pathlib import Path
import queue
import signal
import subprocess
import threading
import time


PROMPT = '''This is a harmless bounded Codex runtime diagnostic, not a project task.
Do not inspect files, write files, access network, edit configuration, or spawn agents.
The user explicitly requests a Goal for this isolated diagnostic only. Create a Goal
whose objective requires TWO DISTINCT turns: first record PROBE_FIRST_TURN; finish
that turn leaving the Goal active and incomplete; then, only on native automatic
Goal continuation, record PROBE_SECOND_TURN and mark the Goal complete.
In the first turn use the native create_goal tool, then a shell command that prints
PROBE_FIRST_TURN, then finish with FIRST_PENDING. Do not complete the Goal in that
turn and do not manually start another turn. On automatic continuation print
PROBE_SECOND_TURN, mark the Goal complete, and finish with PROBE_COMPLETE.
If no native goal creation tool is available, finish with GOAL_UNAVAILABLE instead.
Use only goal lifecycle tools and those two harmless print commands. Do not run a
training job or evolution round. The external probe imposes a short hard deadline.
'''


def stop(process):
    if process.poll() is not None:
        return
    os.killpg(process.pid, signal.SIGTERM)
    try:
        process.wait(timeout=3)
    except subprocess.TimeoutExpired:
        os.killpg(process.pid, signal.SIGKILL)
        process.wait(timeout=3)


class AppServer:
    """Small stdio client used only to clear/archive this probe's own thread."""

    def __init__(self, binary, directory, timeout=20):
        self.deadline = time.monotonic() + timeout
        self.serial = 0
        self.inbox = queue.Queue()
        self.stderr = (directory / 'cleanup-stderr.log').open('w')
        self.process = subprocess.Popen(
            [binary, '--no-daemon', 'app-server', '--stdio'], stdin=subprocess.PIPE,
            stdout=subprocess.PIPE, stderr=self.stderr, text=True, start_new_session=True)

        def read():
            for line in self.process.stdout:
                try:
                    self.inbox.put(json.loads(line))
                except ValueError:
                    pass
        threading.Thread(target=read, daemon=True).start()

    def send(self, message):
        self.process.stdin.write(json.dumps(message) + '\n')
        self.process.stdin.flush()

    def rpc(self, method, params):
        self.serial += 1
        request_id = self.serial
        self.send({'id': request_id, 'method': method, 'params': params})
        while time.monotonic() < self.deadline:
            if self.process.poll() is not None:
                raise RuntimeError('Probe cleanup app-server exited')
            try:
                message = self.inbox.get(timeout=.2)
            except queue.Empty:
                continue
            if message.get('id') == request_id and 'method' not in message:
                return message
            if 'id' in message and 'method' in message:
                self.send({'id': message['id'], 'error': {
                    'code': -32601, 'message': 'This diagnostic does not approve client requests'}})
        raise TimeoutError('Probe cleanup exceeded its deadline')

    def close(self):
        stop(self.process)
        self.stderr.close()


def run_probe(directory, *, binary='codex', timeout=60):
    directory = Path(directory).resolve()
    directory.mkdir(parents=True, exist_ok=True)
    workspace = directory / 'empty-workspace'
    workspace.mkdir(exist_ok=True)
    command = [binary, '--no-daemon', 'exec', '--sandbox', 'read-only',
               '--skip-git-repo-check', '--cd', str(workspace), '--json', PROMPT]
    started = time.monotonic()
    timed_out = False
    with (directory / 'exec-events.jsonl').open('w') as stdout, (directory / 'exec-stderr.log').open('w') as stderr:
        process = subprocess.Popen(command, stdout=stdout, stderr=stderr, text=True, start_new_session=True)
        try:
            process.wait(timeout=timeout)
        except subprocess.TimeoutExpired:
            timed_out = True
            stop(process)
    rows = []
    for line in (directory / 'exec-events.jsonl').read_text().splitlines():
        try:
            rows.append(json.loads(line))
        except ValueError:
            pass
    thread_id = next((row.get('thread_id') for row in rows if row.get('type') == 'thread.started'), None)
    items = [row.get('item', {}) for row in rows if row.get('type') == 'item.completed']
    messages = [item.get('text', '') for item in items if item.get('type') == 'agent_message']
    report = {
        'codex_version': subprocess.run([binary, '--version'], text=True, capture_output=True, timeout=5).stdout.strip(),
        'mode': 'persistent-codex-exec', 'thread_id': thread_id,
        'timeout_seconds': timeout, 'timed_out': timed_out, 'returncode': process.returncode,
        'elapsed_seconds': round(time.monotonic() - started, 3),
        'event_counts': dict(Counter(row.get('type', 'unknown') for row in rows)),
        'final_messages': messages,
        'completed_items': [{'type': item.get('type'), 'tool': item.get('tool'),
                             'command': item.get('command'), 'status': item.get('status')}
                            for item in items if item.get('type') != 'agent_message'],
        'automatic_second_turn_observed': sum(row.get('type') == 'turn.started' for row in rows) >= 2,
    }
    if thread_id:
        server = AppServer(binary, directory)
        try:
            server.rpc('initialize', {'clientInfo': {'name': 'tmt_goal_exec_probe', 'version': '1'},
                                      'capabilities': {'experimentalApi': True}})
            server.send({'method': 'initialized', 'params': {}})
            report['goal_after_exec'] = server.rpc('thread/goal/get', {'threadId': thread_id})
            report['goal_clear'] = server.rpc('thread/goal/clear', {'threadId': thread_id})
            report['archive'] = server.rpc('thread/archive', {'threadId': thread_id})
            failures = [name for name in ('goal_after_exec', 'goal_clear', 'archive')
                        if 'error' in report[name]]
            if failures:
                report['cleanup_error'] = 'RPC rejected: ' + ', '.join(failures)
        except Exception as error:
            report['cleanup_error'] = str(error)
        finally:
            server.close()
    (directory / 'summary.json').write_text(json.dumps(report, indent=2) + '\n')
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--timeout', type=float, default=60)
    parser.add_argument('--codex', default='codex')
    args = parser.parse_args()
    if not 1 <= args.timeout <= 60:
        parser.error('Use a probe deadline between one and sixty seconds')
    print(json.dumps(run_probe(args.output, binary=args.codex, timeout=args.timeout), indent=2))


if __name__ == '__main__':
    main()

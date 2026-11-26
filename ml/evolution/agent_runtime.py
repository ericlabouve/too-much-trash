"""Local MCP supervisor for bounded, independently controlled candidate agents.

The model chooses experiments; this process owns clocks, process groups and
continuation. It deliberately does not activate native Goal mode: headless Goal
availability is a separate capability, not a substitute for these controls.
"""

import argparse
from copy import deepcopy
from datetime import datetime, timezone
import json
from math import isfinite
import os
from pathlib import Path
import signal
import shutil
import subprocess
import sys
from threading import Event, RLock, Thread
from time import monotonic
from uuid import uuid4

PROTOCOL = 'supervised-v1'
KINDS = ('parent', 'research', 'review', 'integrity_review')
TERMINAL = {'ready', 'blocked', 'failed', 'timed_out', 'closed'}
FINAL_SCHEMA = {
    'type': 'object', 'additionalProperties': False,
    'required': ['status', 'summary', 'artifact', 'candidate_name'],
    'properties': {'status': {'type': 'string', 'enum': ['ready', 'blocked']},
                   'summary': {'type': 'string'}, 'artifact': {'type': 'string'},
                   'candidate_name': {'type': 'string'}},
}


def atomic_json(path, value):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f'.{path.name}.{uuid4().hex}.tmp')
    temporary.write_text(json.dumps(value, indent=2) + '\n')
    temporary.replace(path)


def process_snapshot():
    """Bounded process topology/start metadata only; never collect command lines."""
    result = subprocess.run(['ps', '-axo', 'pid=,ppid=,lstart='], capture_output=True,
                            text=True, timeout=.5, check=True)
    records = {}
    for line in result.stdout.splitlines():
        fields = line.split(None, 2)
        if len(fields) == 3:
            records[int(fields[0])] = (int(fields[1]), fields[2].strip())
    return records


class Supervisor:
    """One instance per round. `tick` is also callable with fake clocks in tests."""

    def __init__(self, config, *, clock=monotonic, popen=subprocess.Popen,
                 killpg=os.killpg, kill=os.kill, snapshot=process_snapshot):
        if config.get('protocol') != PROTOCOL:
            raise ValueError('Unsupported agent supervisor protocol')
        self.config = deepcopy(config)
        self.settings = config['settings']
        self.job = Path(config['job']).resolve(strict=True)
        self.repository = Path(config['repository']).resolve(strict=True)
        self.ledger = Path(config['ledger_path']).resolve()
        self.minutes = self.settings['agent_minutes']
        self.concurrency = self.settings['agent_concurrency']
        if (type(self.minutes) not in (int, float) or not isfinite(self.minutes)
                or self.minutes <= 0 or type(self.concurrency) is not int
                or not 1 <= self.concurrency <= 5):
            raise ValueError('Invalid agent deadline or concurrency')
        self.clock, self.popen, self.killpg = clock, popen, killpg
        self.kill, self.snapshot = kill, snapshot
        self.tasks, self.lock, self.stopping = {}, RLock(), Event()
        self.root = self.job / 'agent-runtime'
        self.root.mkdir(exist_ok=True)
        self.private_io = self.ledger.parent / f'.{self.ledger.stem}-io'
        self.private_io.mkdir(parents=True, exist_ok=True)
        self.schema_path = self.root / 'final-schema.json'
        atomic_json(self.schema_path, FINAL_SCHEMA)
        self._persist()

    def _public(self, task):
        return deepcopy({key: value for key, value in task.items()
                         if not key.startswith('_')})

    def _persist(self):
        atomic_json(self.ledger, {'protocol': PROTOCOL, 'job': str(self.job),
                    'supervisor_pid': os.getpid(),
                    'settings': {key: self.settings.get(key) for key in
                                 ('agent_minutes', 'agent_concurrency', 'family')},
                    'tasks': [self._public(task) for task in self.tasks.values()]})

    def start_agent(self, kind, prompt, parent=None, candidate_name=None):
        with self.lock:
            if self.stopping.is_set():
                raise ValueError('Agent supervisor has stopped; new work is forbidden')
            if kind not in KINDS or not isinstance(prompt, str) or not prompt.strip():
                raise ValueError('A supported kind and nonempty prompt are required')
            expected = self.config.get('expected', {})
            same = [task for task in self.tasks.values() if task['kind'] == kind]
            if kind == 'parent':
                allowed = expected.get('parent', [])
                if parent not in allowed or any(task['parent'] == parent for task in same):
                    raise ValueError('Parent must be selected and gets exactly one task')
            else:
                if parent is not None:
                    raise ValueError('Only parent tasks accept a parent')
                if len(same) >= expected.get(kind, 0):
                    raise ValueError('The configured agent count for this kind is exhausted')
            if kind == 'integrity_review':
                if not isinstance(candidate_name, str) or not candidate_name.strip():
                    raise ValueError('Final reviewer needs its one assigned candidate')
                count = sum(task['candidate_name'] == candidate_name for task in same)
                if count >= self.settings['review_agents']:
                    raise ValueError('This candidate already has its configured reviewers')
            identifier = str(uuid4())
            folder = self.root / identifier
            folder.mkdir()
            prompt_path = folder / 'initial-prompt.txt'
            direction = self.settings.get('agent_prompt', '')
            if direction and direction not in prompt:
                prompt += '\nRound direction (verbatim):\n' + direction
            prompt_path.write_text(prompt)
            task = {'task_id': identifier, 'agent_id': None, 'thread_id': None,
                    'kind': kind, 'parent': parent, 'candidate_name': candidate_name,
                    'status': 'queued', 'phase': 'queued', 'prompt_path': str(prompt_path),
                    'artifact': None, 'summary': '', 'cycles': [], 'turns': [], 'followups': 0,
                    '_folder': folder, '_prompt': prompt, '_process': None,
                    '_output_handles': [], '_queued_cycle': 1, '_phase_requested': None}
            task['owned_processes'] = []
            self.tasks[identifier] = task
            self.tick()
            return self._public(task)

    def _argv(self, task, final_path):
        argv = [self.config['binary'], '--no-daemon', '--search', '--approve-for-me',
                '--disable', 'multi_agent', '--cd', str(self.repository),
                '--add-dir', str(self.job), 'exec']
        if task['thread_id']:
            argv += ['resume', task['thread_id']]
        return [*argv, '--json', '--output-schema', str(self.schema_path),
                '--output-last-message', str(final_path), '-']

    def _launch(self, task, phase, prompt):
        now = self.clock()
        if task['_queued_cycle']:
            duration = self.minutes * 60
            reserve = min(duration / 2, max(5., min(120., duration * .1)))
            task['cycles'].append({'cycle': task['_queued_cycle'],
                                  'started_monotonic': now,
                                  'deadline_monotonic': now + duration,
                                  'export_monotonic': now + duration - reserve,
                                  'started_utc': datetime.now(timezone.utc).isoformat()})
            task['_queued_cycle'] = None
        cycle = task['cycles'][-1]
        if now >= cycle['deadline_monotonic']:
            self._terminal(task, 'timed_out', 'Agent allocation exhausted before another turn')
            return
        number = len(task['turns']) + 1
        stem = task['_folder'] / f'turn-{number:03d}'
        prompt_path = Path(f'{stem}.prompt.txt')
        final_path = Path(f'{stem}.final.json')
        events_path, errors_path = Path(f'{stem}.events.jsonl'), Path(f'{stem}.stderr.log')
        full_prompt = self._instructions(task, phase, prompt)
        prompt_path.write_text(full_prompt)
        actual_events = self.private_io / f'{task["task_id"]}-turn-{number:03d}.jsonl'
        stdout, stderr = actual_events.open('w'), errors_path.open('w')
        turn = {'number': number, 'phase': phase, 'prompt_path': str(prompt_path),
                'events_path': str(events_path), 'final_path': str(final_path),
                'started_monotonic': now, 'cycle': cycle['cycle'],
                'prompt_delivered': False, 'prompt_delivery_error': None}
        task['turns'].append(turn)
        if number == 1:
            task['prompt_path'] = str(prompt_path)
        task['phase'], task['status'] = phase, 'running'
        task['_events_offset'], task['_events_tail'] = 0, ''
        task['_actual_events_path'] = actual_events
        task['_output_handles'] = [stdout, stderr]
        try:
            process = self.popen(self._argv(task, final_path), stdin=subprocess.PIPE,
                                 stdout=stdout, stderr=stderr, text=True,
                                 cwd=str(self.repository), start_new_session=True)
            task['_process'] = process
            turn['pid'] = process.pid
            # A CLI that hangs before reading stdin must not hold the supervisor
            # lock or prevent its watchdog from enforcing deadlines.
            def deliver():
                try:
                    process.stdin.write(full_prompt)
                    process.stdin.close()
                    turn['prompt_delivered'] = True
                except (OSError, ValueError) as error:
                    turn['prompt_delivery_error'] = str(error)
                finally:
                    try:
                        process.stdin.close()
                    except (OSError, ValueError):
                        pass
            Thread(target=deliver, daemon=True).start()
        except Exception as error:
            if task['_process'] is not None:
                self._signal(task, signal.SIGKILL)
                task['_process'].wait(timeout=1)
                task['_process'] = None
            self._close_handles(task)
            self._terminal(task, 'failed', f'Could not start/resume child: {error}')

    def _instructions(self, task, phase, prompt):
        cycle = task['cycles'][-1]
        remaining = max(0., cycle['deadline_monotonic'] - self.clock())
        search_remaining = max(0., cycle['export_monotonic'] - self.clock())
        common = (
            f'You are supervised task {task["task_id"]}, kind {task["kind"]}. '
            f'Your remaining total wall allocation is {remaining:.1f} seconds. '
            f'Remaining SEARCH time is {search_remaining:.1f} seconds; absolute monotonic '
            f'search/export cutoff is {cycle["export_monotonic"]:.6f} and hard deadline '
            f'is {cycle["deadline_monotonic"]:.6f}. '
            'The supervisor enforces it across all turns, including followups. '
            'Do not spawn other agents or create Goals. Do not edit supervisor code, '
            'configuration, evaluator or deadlines. Preserve the best validated version '
            'in job-local checkpoint files after every useful improvement. Keep a complete '
            'trial journal and use the shared training monitor. Training patience ends a fit, '
            'not your research assignment: consider another useful hypothesis while time remains. '
            'Do not start a fit that cannot finish before the search cutoff. Persist checkpoints '
            'and close journals before it. Do not daemonize, double-fork, detach or leave background '
            'training/commands; all work must remain under your supervised process tree. '
            'Only training data may fit weights; validation selects; test remains reserved. '
            'A ready report is provisional until the export phase. Return JSON with status '
            'ready or blocked, summary, artifact (nonempty job-local file), candidate_name. '
            'Use blocked only for a concrete operational blocker and explain attempted remedies. '
            'Do not invent scores or force pointless trials just to consume time.\n')
        if phase == 'export':
            common += ('EXPORT ONLY: Stop new research, training and parameter search. Restore '
                       'your best validated checkpoint, verify/export its implementation, weights, '
                       'configuration and evidence, and provide the final artifact. Preserve failed '
                       'trials. Mark any interrupted unfinished fit failed in its journal; never '
                       'claim it completed. Restore the best COMPLETED validated checkpoint. '
                       'Shared final deployment benchmarks run separately after fitting stops.\n')
        elif task['kind'] in ('parent', 'research'):
            common += ('Use remaining research time to inspect failures and improve your ONE '
                       'candidate through evidence-backed hypotheses. Retain the best validated '
                       'version when a trial regresses. A valid first proposal is not the finish line.\n')
        else:
            common += ('Review only your assigned scope. You may finish once the required review '
                       'and evidence are complete; do not develop or change the candidate.\n')
        if task['kind'] == 'integrity_review':
            common += f'Your ONLY assigned candidate is {task["candidate_name"]}. This is a fresh context.\n'
        return common + '\n' + prompt

    def _events(self, task):
        # Identity comes from a supervisor-owned stream outside the writable job,
        # never from the coordinator-editable audit mirror.
        path = task['_actual_events_path']
        with path.open() as stream:
            stream.seek(task['_events_offset'])
            chunk = stream.read(65536)
            task['_events_offset'] = stream.tell()
        lines = (task['_events_tail'] + chunk).split('\n')
        task['_events_tail'] = lines.pop()[-262144:]
        for line in lines:
            try:
                event = json.loads(line)
            except ValueError:
                continue
            if event.get('type') == 'thread.started':
                identifier = event.get('thread_id')
                if not isinstance(identifier, str) or not identifier:
                    raise ValueError('Child did not identify its actual thread')
                previous = task['thread_id']
                if previous and identifier != previous:
                    raise ValueError('Resume changed child identity')
                if any(other is not task and other['thread_id'] == identifier
                       for other in self.tasks.values()):
                    raise ValueError('Independent tasks reused an actual child identity')
                task['thread_id'] = task['agent_id'] = identifier

    def _artifact(self, value):
        if not isinstance(value, str) or not value:
            raise ValueError('Child result requires a nonempty job-local artifact')
        path = Path(value)
        path = (path if path.is_absolute() else self.job / path).resolve(strict=True)
        if not path.is_relative_to(self.job) or not path.is_file() or not path.stat().st_size:
            raise ValueError('Child artifact must be nonempty and stay inside this job')
        return str(path)

    def _read_final(self, task):
        report = json.loads(Path(task['turns'][-1]['final_path']).read_text())
        if (set(report) != set(FINAL_SCHEMA['required']) or report['status'] not in ('ready', 'blocked')
                or not isinstance(report['summary'], str) or not report['summary'].strip()
                or not isinstance(report['candidate_name'], str)):
            raise ValueError('Child returned an invalid structured completion')
        artifact = self._artifact(report['artifact'])
        if report['status'] == 'ready' and task['kind'] != 'review' and not report['candidate_name'].strip():
            raise ValueError('Candidate task must identify its resulting candidate')
        if task['kind'] == 'integrity_review' and report['candidate_name'] != task['candidate_name']:
            raise ValueError('Reviewer reported a different assigned candidate')
        if not task['thread_id']:
            raise ValueError('Cannot continue a child without its actual thread identity')
        task.update(artifact=artifact, summary=report['summary'], candidate_name=report['candidate_name'])
        return report

    def _close_handles(self, task):
        for stream in task['_output_handles']:
            stream.close()
        task['_output_handles'] = []
        if task.get('_actual_events_path') and task['turns']:
            shutil.copyfile(task['_actual_events_path'], task['turns'][-1]['events_path'])

    def _signal(self, task, sig):
        process = task['_process']
        if process is not None:
            # Reap an exited CLI first. On macOS, killpg on an unreaped zombie
            # group may report EPERM instead of ESRCH. Still signal the group:
            # descendants can remain after the CLI exits.
            process.poll()
            try:
                self.killpg(process.pid, sig)
            except ProcessLookupError:
                pass

    def _observe_tree(self, task, records):
        process = task['_process']
        if process is None:
            return
        known = {item['pid']: item for item in task['owned_processes']}
        root = process.pid
        if root in records:
            identity = records[root][1]
            old = known.get(root)
            if old is not None and old['start_identity'] != identity:
                raise ValueError('Observed CLI PID was reused; refuse unsafe cleanup')
            known[root] = {'pid': root, 'start_identity': identity, 'depth': 0}
        # Previously observed children remain owned after reparenting. Identity
        # checks prevent a recycled PID from becoming a cleanup target.
        parents = {pid for pid, item in known.items()
                   if pid in records and records[pid][1] == item['start_identity']}
        changed = True
        while changed:
            changed = False
            for pid, (parent, identity) in records.items():
                if parent in parents and pid not in parents:
                    depth = known[parent]['depth'] + 1
                    known[pid] = {'pid': pid, 'start_identity': identity, 'depth': depth}
                    parents.add(pid)
                    changed = True
        task['owned_processes'] = list(known.values())

    def _signal_tree(self, task, sig, records=None):
        records = self.snapshot() if records is None else records
        self._observe_tree(task, records)
        root = task['_process'].pid
        for owned in sorted(task['owned_processes'], key=lambda item: -item['depth']):
            pid = owned['pid']
            if pid == root or pid not in records or records[pid][1] != owned['start_identity']:
                continue
            try:
                self.kill(pid, sig)
            except ProcessLookupError:
                pass
        self._signal(task, sig)

    def _stop(self, task, reason, terminal=None):
        if task.get('_stopping'):
            return
        self._signal_tree(task, signal.SIGTERM)
        task['_stopping'] = {'at': self.clock(), 'reason': reason, 'terminal': terminal}

    def _terminal(self, task, status, summary):
        task.update(status=status, phase='terminal', summary=summary)
        if task['cycles']:
            task['cycles'][-1]['ended_monotonic'] = self.clock()

    def tick(self):
        with self.lock:
            if self.stopping.is_set():
                return
            live = [task for task in self.tasks.values() if task['_process'] is not None]
            records = self.snapshot() if live else {}
            for task in live:
                self._observe_tree(task, records)
            now = self.clock()
            for task in self.tasks.values():
                process = task['_process']
                if process is None:
                    continue
                try:
                    self._events(task)
                except Exception as error:
                    self._stop(task, f'Unverifiable child identity/event stream: {error}', 'failed')
                cycle = task['cycles'][-1]
                if now >= cycle['deadline_monotonic']:
                    self._stop(task, 'Hard per-agent deadline reached', 'timed_out')
                elif (task['kind'] in ('parent', 'research') and task['phase'] == 'research'
                      and now >= cycle['export_monotonic']):
                    self._stop(task, 'Reserved export phase reached')
                stopping = task.get('_stopping')
                if stopping:
                    # Kill the process GROUP even if the CLI parent already exited,
                    # so its long-running commands cannot keep modifying checkpoints.
                    if now - stopping['at'] < 1.:
                        continue
                    self._signal_tree(task, signal.SIGKILL)
                    try:
                        process.wait(timeout=.1)
                    except subprocess.TimeoutExpired:
                        continue
                    task['turns'][-1].update(ended_monotonic=now, reason=stopping['reason'])
                    self._close_handles(task)
                    task['_process'], task['_stopping'] = None, None
                    if stopping['terminal'] or now >= cycle['deadline_monotonic']:
                        self._terminal(task, stopping['terminal'] or 'timed_out', stopping['reason'])
                    elif not task['thread_id']:
                        self._terminal(task, 'failed', 'Cannot enter export: no resumable child identity')
                    else:
                        self._launch(task, 'export', task['_prompt'])
                    continue
                if process.poll() is None:
                    continue
                # A normal exit is also followed by group cleanup: child commands
                # must not outlive their owning turn.
                self._signal_tree(task, signal.SIGKILL)
                task['turns'][-1].update(ended_monotonic=now, returncode=process.returncode)
                self._close_handles(task)
                task['_process'] = None
                if process.returncode != 0:
                    self._terminal(task, 'failed', 'Child process failed; no automatic identity replacement')
                    continue
                try:
                    report = self._read_final(task)
                except Exception as error:
                    self._terminal(task, 'failed', f'Invalid child result: {error}')
                    continue
                if report['status'] == 'blocked':
                    self._terminal(task, 'blocked', report['summary'])
                elif task['phase'] == 'research' and task['kind'] in ('parent', 'research'):
                    phase = 'export' if now >= cycle['export_monotonic'] else 'research'
                    task['followups'] += phase == 'research'
                    self._launch(task, phase,
                        task['_prompt'] + '\nContinue improving your current candidate within the ORIGINAL deadline. '
                        'Inspect the latest validation failures and trial journal; choose another '
                        'useful hypothesis, retain the best validated checkpoint, and do not '
                        'replace it with a worse trial. Previous report:\n' + report['summary'])
                else:
                    self._terminal(task, 'ready', report['summary'])
            active = sum(task['_process'] is not None for task in self.tasks.values())
            for task in self.tasks.values():
                if active >= self.concurrency:
                    break
                if task['status'] == 'queued':
                    phase = 'research' if task['kind'] in ('parent', 'research') else 'review'
                    self._launch(task, phase, task['_prompt'])
                    active += task['_process'] is not None
            self._persist()

    def get_agents(self, task_ids=None):
        with self.lock:
            self.tick()
            identifiers = list(self.tasks) if task_ids is None else task_ids
            if not isinstance(identifiers, list) or any(value not in self.tasks for value in identifiers):
                raise ValueError('Unknown supervised task IDs')
            return {'agents': [self._public(self.tasks[value]) for value in identifiers]}

    def wait_agents(self, task_ids=None, timeout_seconds=10):
        if type(timeout_seconds) not in (int, float) or not 0 <= timeout_seconds <= 30:
            raise ValueError('Wait timeout must be between zero and thirty seconds')
        until = monotonic() + timeout_seconds
        while True:
            snapshot = self.get_agents(task_ids)
            if (any(task['status'] in TERMINAL for task in snapshot['agents'])
                    or monotonic() >= until or self.stopping.is_set()):
                return snapshot
            self.stopping.wait(.2)

    def send_message(self, task_id, message, architecture_cycle=None):
        with self.lock:
            if self.stopping.is_set():
                raise ValueError('Agent supervisor has stopped; feedback cannot launch work')
            task = self.tasks[task_id]
            if not isinstance(message, str) or not message.strip():
                raise ValueError('Feedback must be nonempty')
            direction = self.settings.get('agent_prompt', '')
            if direction and direction not in message:
                message += '\nRound direction (verbatim):\n' + direction
            if architecture_cycle is not None:
                previous = task['cycles'][-1]['cycle'] if task['cycles'] else 0
                if (self.settings.get('family') != 'new_family' or task['kind'] not in ('research', 'review')
                        or task['status'] not in ('ready', 'blocked')
                        or type(architecture_cycle) is not int
                        or architecture_cycle != previous + 1 or architecture_cycle > 3):
                    raise ValueError('Only explicit New Family architecture cycles2/3 can renew a finished assignment')
                task['_queued_cycle'] = architecture_cycle
                task.update(status='queued', phase='queued', _prompt=message)
            else:
                if task['status'] != 'running':
                    raise ValueError('Ordinary feedback cannot renew a finished deadline')
                # Feedback is persisted immediately and included in the next supervised
                # continuation/export turn; it never cancels work or resets clocks.
                task['_prompt'] += '\nCoordinator feedback:\n' + message
                path = task['_folder'] / f'feedback-{len(task.get("feedback", [])) + 1:03d}.txt'
                path.write_text(message)
                task.setdefault('feedback', []).append({'path': str(path), 'received_monotonic': self.clock()})
            self.tick()
            return self._public(task)

    def close_agent(self, task_id):
        with self.lock:
            task = self.tasks[task_id]
            if task['_process'] is not None:
                self._stop(task, 'Coordinator explicitly closed task', 'closed')
            elif task['status'] not in TERMINAL:
                self._terminal(task, 'closed', 'Coordinator closed queued task')
            self._persist()
            return self._public(task)

    def shutdown(self):
        self.stopping.set()
        with self.lock:
            for task in self.tasks.values():
                if task['_process'] is not None:
                    self._signal_tree(task, signal.SIGKILL)
                    try:
                        task['_process'].wait(timeout=1)
                    except subprocess.TimeoutExpired:
                        pass
                    self._close_handles(task)
                    task['_process'] = None
                    self._terminal(task, 'closed', 'Supervisor shut down')
                elif task['status'] == 'queued':
                    self._terminal(task, 'closed', 'Supervisor shut down before task started')
            self._persist()


def tools():
    def spec(name, description, properties, required=()):
        return {'name': name, 'description': description,
                'inputSchema': {'type': 'object', 'additionalProperties': False,
                                'properties': properties, 'required': list(required)}}
    text = {'type': 'string'}
    ids = {'type': 'array', 'items': text}
    return [
        spec('start_agent', 'Start one independent bounded task; timing starts when its process runs.',
             {'kind': {'type': 'string', 'enum': list(KINDS)}, 'prompt': text,
              'parent': text, 'candidate_name': text}, ('kind', 'prompt')),
        spec('get_agents', 'Get actual supervised task IDs, states, artifacts and timing evidence.', {'task_ids': ids}),
        spec('wait_agents', 'Wait at most30 seconds for a selected task to finish; watchdog remains active.',
             {'task_ids': ids, 'timeout_seconds': {'type': 'number', 'minimum': 0, 'maximum': 30}}),
        spec('send_message', 'Send feedback without resetting the deadline. Only New Family architecture cycles2/3 renew allocations.',
             {'task_id': text, 'message': text, 'architecture_cycle': {'type': 'integer', 'minimum': 2, 'maximum': 3}},
             ('task_id', 'message')),
        spec('close_agent', 'Close a task; an unfinished closed task cannot count as completed evidence.', {'task_id': text}, ('task_id',)),
    ]


def serve(supervisor, stdin=sys.stdin, stdout=sys.stdout):
    def watchdog():
        try:
            while not supervisor.stopping.wait(.2):
                supervisor.tick()
        except Exception as error:
            print(f'Supervisor watchdog failed: {error}', file=sys.stderr, flush=True)
            supervisor.shutdown()
    watcher = Thread(target=watchdog, daemon=True)
    watcher.start()
    try:
        for line in stdin:
            request = json.loads(line)
            if 'id' not in request:
                continue
            method, params = request['method'], request.get('params', {})
            try:
                if method == 'initialize':
                    result = {'protocolVersion': params.get('protocolVersion', '2024-11-05'),
                              'capabilities': {'tools': {}},
                              'serverInfo': {'name': 'evolution-supervisor', 'version': PROTOCOL}}
                elif method == 'ping':
                    result = {}
                elif method == 'tools/list':
                    result = {'tools': tools()}
                elif method == 'tools/call':
                    name = params['name']
                    if name not in {tool['name'] for tool in tools()}:
                        raise ValueError('Unknown supervisor tool')
                    try:
                        value = getattr(supervisor, name)(**params.get('arguments', {}))
                        result = {'content': [{'type': 'text', 'text': json.dumps(value)}]}
                    except (KeyError, ValueError, OSError) as error:
                        result = {'isError': True, 'content': [{'type': 'text', 'text': str(error)}]}
                else:
                    raise ValueError('Unsupported MCP method')
                response = {'jsonrpc': '2.0', 'id': request['id'], 'result': result}
            except (KeyError, ValueError) as error:
                response = {'jsonrpc': '2.0', 'id': request['id'],
                            'error': {'code': -32602, 'message': str(error)}}
            stdout.write(json.dumps(response) + '\n')
            stdout.flush()
    finally:
        supervisor.shutdown()
        watcher.join(timeout=2)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--config', type=Path, required=True)
    args = parser.parse_args()
    previous = {}
    def stop_signal(signum, frame):
        raise KeyboardInterrupt
    for signum in (signal.SIGTERM, signal.SIGINT):
        previous[signum] = signal.signal(signum, stop_signal)
    try:
        serve(Supervisor(json.loads(args.config.read_text())))
    except KeyboardInterrupt:
        pass
    finally:
        for signum, handler in previous.items():
            signal.signal(signum, handler)


if __name__ == '__main__':
    main()

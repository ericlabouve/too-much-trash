"""Loopback dashboard with a single controlled background mutation job."""

import argparse
from hashlib import sha256
from datetime import datetime, timezone
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
import json
from math import isfinite, isclose
import os
from pathlib import Path
import subprocess
import sys
from threading import Lock
from urllib.parse import urlsplit
from uuid import uuid4

from dashboard_round import (DEFAULTS as BOUNDED_DEFAULTS, FAMILIES, WORK_ROOT, write_json,
                             available_families, candidate_catalog, candidate_family)
from dashboard_datasets import discover_datasets, validate_split_settings, common_frame_rate
from dashboard_agents import readiness, research_disclosure, verify_publication
from dashboard_metrics import LeaderHistory, leader_context
from dashboard_losses import load_training_histories, load_loss_diagnostics
from phone_benchmark import load_phone_timing
from deployment_benchmark import load_deployment_evaluation
from ml.evolution.training import PROTOCOL as TRAINING_PROTOCOL
from dashboard_selection import PROTOCOL as SELECTION_PROTOCOL, DEFAULTS as SELECTION_DEFAULTS, selection_parameters
from dashboard_agents import REPRODUCTION_PROTOCOL
from dashboard_integrity import REVIEW_PROTOCOL
from ml.evolution.agent_budgets import PROTOCOL as BUDGET_PROTOCOL
from ml.evolution.review_bundles import PROTOCOL as REVIEW_BUNDLE_PROTOCOL

DEFAULTS = BOUNDED_DEFAULTS | {
    "mode": "agent_guided", "target_basis": "validation",
    "pool_size": 8, "research_slots": 2, "agent_minutes": 20, "agent_concurrency": 3,
    "agent_prompt": "", "review_agents": 1, "review_protocol": REVIEW_PROTOCOL,
    "evaluation_protocol": "clip_replay-v1",
    "benchmark_protocol": "deployment-v1",
    "training_protocol": TRAINING_PROTOCOL,
    "selection_protocol": SELECTION_PROTOCOL,
    "reproduction_protocol": REPRODUCTION_PROTOCOL,
    "agent_budget_protocol": BUDGET_PROTOCOL,
    "agent_export_min_seconds": 60,
    "agent_export_completion": "finish-v1",
    "review_bundle_protocol": REVIEW_BUNDLE_PROTOCOL,
    **SELECTION_DEFAULTS,
    "target_fps": 60, "full_speed_frame_fraction": 0.25, "zero_speed_frame_fraction": 1.0,
}


HERE = Path(__file__).resolve().parent


def validate_settings(payload, families=FAMILIES):
    if isinstance(payload, dict) and 'evolution_agents' in payload:
        raise ValueError('evolution_agents is obsolete: every selected pool candidate now reproduces once per ordinary round')
    if not isinstance(payload, dict) or set(payload) - DEFAULTS.keys():
        raise ValueError('Unknown round settings')
    settings = DEFAULTS | payload
    available=discover_datasets()
    settings.update(validate_split_settings(settings,available))
    source_fps=common_frame_rate(settings['datasets'],available)
    if source_fps is not None:
        if 'target_fps' in payload and (type(payload['target_fps']) not in (int,float) or not isclose(payload['target_fps'],source_fps)):
            raise ValueError(f'Selected datasets share {source_fps} fps; the frame-rate basis is derived from their source cadence')
        settings['target_fps']=source_fps
    frame_controls = {'target_fps','full_speed_frame_fraction','zero_speed_frame_fraction'}
    derive_bounds=bool(frame_controls & payload.keys()) or (source_fps is not None and not {'full_speed_ms','frame_budget_ms'} & payload.keys())
    if derive_bounds:
        if any(type(settings[key]) not in (int,float) or not isfinite(settings[key]) for key in frame_controls):
            raise ValueError('Frame-rate and frame-fraction controls must be finite numbers')
        if not 1 <= settings['target_fps'] <= 240 or not 0 < settings['full_speed_frame_fraction'] < settings['zero_speed_frame_fraction']:
            raise ValueError('Use 1–240 fps and positive full-credit fraction below zero-credit fraction')
        interval = 1000 / settings['target_fps']
        for key,value in [('full_speed_ms',settings['full_speed_frame_fraction']*interval),
                          ('frame_budget_ms',settings['zero_speed_frame_fraction']*interval)]:
            if key in payload and (type(payload[key]) not in (int,float) or not isclose(payload[key],value,rel_tol=1e-9,abs_tol=1e-9)):
                raise ValueError('Millisecond bounds must match the frame fractions and target frame rate')
            settings[key] = value
    if not isinstance(settings['agent_prompt'], str) or len(settings['agent_prompt']) > 8000:
        raise ValueError('The round prompt must be text up to 8,000 characters')
    if settings['family'] not in ['all', 'new_family', *families]:
        raise ValueError('Select an available candidate family')
    for key, lower, upper in [('clip_limit', 0, sum(item['clip_count'] for item in available)), ('pool_size', 1, 10), ('seed', 0, 2147483647), ('research_slots', 1, 10), ('agent_minutes', 1, 120), ('agent_concurrency', 1, 5), ('review_agents', 1, 5)]:
        if type(settings[key]) is not int or not lower <= settings[key] <= upper:
            raise ValueError(f'{key} must be an integer between {lower} and {upper}')
    for key in ['jaw_weight', 'target_f1', 'match_seconds', 'full_speed_ms', 'frame_budget_ms']:
        value = settings[key]
        if type(value) not in (int, float) or not isfinite(value):
            raise ValueError(f'{key} must be a finite number')
    if not 0 <= settings['jaw_weight'] <= 1 or not 0 < settings['target_f1'] <= 1:
        raise ValueError('Use weights between zero and one and a positive F1 target')
    if not 0 < settings['match_seconds'] <= 10:
        raise ValueError('Event matching tolerance must be positive and at most 10 seconds')
    if not 0 < settings['full_speed_ms'] < settings['frame_budget_ms'] <= 1000:
        raise ValueError('Use 0 < full speed credit < frame budget <= 1000 ms')
    if not derive_bounds:
        settings['full_speed_frame_fraction'] = settings['full_speed_ms'] / (1000 / settings['target_fps'])
        settings['zero_speed_frame_fraction'] = settings['frame_budget_ms'] / (1000 / settings['target_fps'])
    if settings['mode'] not in ('agent_guided', 'bounded_mutations'):
        raise ValueError('Unknown execution mode')
    if settings['mode'] == 'bounded_mutations':
        raise ValueError('Bounded diagnostics cannot bypass the final integrity review gate; use their local diagnostic CLI')
    if settings['evaluation_protocol'] != 'clip_replay-v1':
        raise ValueError('Only clip_replay-v1 scoring is implemented; final integrity review does not establish continuous-stream F1')
    if settings['benchmark_protocol'] != 'deployment-v1':
        raise ValueError('Final F1 and latency must use the deployment-v1 artifact benchmark')
    if settings['training_protocol'] != TRAINING_PROTOCOL:
        raise ValueError('New rounds require validation checkpoints and training receipts')
    if settings['selection_protocol'] != SELECTION_PROTOCOL:
        raise ValueError('New rounds require independently verified portfolio selection')
    if settings['reproduction_protocol'] != REPRODUCTION_PROTOCOL:
        raise ValueError('New rounds require all-pool-v1 reproduction of every selected incumbent')
    if settings['review_protocol'] != REVIEW_PROTOCOL:
        raise ValueError('New rounds require fresh per-candidate-v1 final reviewers')
    if settings['agent_budget_protocol'] != BUDGET_PROTOCOL:
        raise ValueError('New rounds require supervised-v1 per-agent deadlines and continuation')
    if settings['agent_export_min_seconds'] != 60:
        raise ValueError('New rounds require the 60-second short-budget export minimum')
    if settings['agent_export_completion'] != 'finish-v1':
        raise ValueError('New rounds must allow an in-progress export to finish')
    if settings['review_bundle_protocol'] != REVIEW_BUNDLE_PROTOCOL:
        raise ValueError('New rounds require frozen-bundle-v1 preflight before reviewer dispatch')
    selection_parameters(settings)
    expected_basis = 'validation' if settings['mode'] == 'agent_guided' else 'development'
    if settings['target_basis'] != expected_basis:
        raise ValueError(f"{settings['mode']} requires {expected_basis} scoring")
    if settings['mode'] == 'agent_guided' and settings['validation_percent'] == 0:
        raise ValueError('Agent-guided selection requires a positive validation share')
    return settings


class RecoveredWorker:
    """Observe a worker left running across a dashboard-server restart."""
    def __init__(self, pid, job_dir):
        self.pid, self.job_dir = pid, job_dir

    def poll(self):
        status = self.job_dir / 'status.json'
        terminal = status.exists() and json.loads(status.read_text()).get('state') in ('completed', 'failed')
        try:
            os.kill(self.pid, 0)
        except ProcessLookupError:
            return 0 if terminal else 1
        except PermissionError:
            return None
        return None


class Jobs:
    def __init__(self, dashboard, prior, output):
        self.dashboard, self.prior, self.output = dashboard, prior, output
        self.lock = Lock()
        self.process = None
        self.job_dir = None
        self.prior_record = json.loads(prior.read_text())
        self.agent_readiness = readiness()
        self.leader_history = LeaderHistory(output)
        self.requires_integrity_review = False
        self.config_sha256 = None
        output.mkdir(parents=True, exist_ok=True)
        policy_path = output / '.integrity-policy.json'
        if output.exists() and not policy_path.exists():
            legacy = []
            for path in output.glob('dashboard-*/status.json'):
                try:
                    old_status = json.loads(path.read_text())
                    old_config = json.loads((path.parent / 'config.json').read_text())
                    if old_status.get('state') == 'completed' and 'review_agents' not in old_config.get('settings', {}):
                        legacy.append(path.parent.name)
                except (OSError, ValueError):
                    continue
            write_json(policy_path, {'policy_version': 'continuous-v1', 'legacy_jobs': sorted(legacy)})
        active = output / 'dashboard-active.json'
        if active.exists():
            record = json.loads(active.read_text())
            job_dir = Path(record['job_directory']).resolve(strict=True)
            if not job_dir.is_relative_to(output.resolve()) or type(record['pid']) is not int or record['pid'] <= 0:
                raise ValueError('Invalid persisted worker record')
            self.job_dir = job_dir
            self.process = RecoveredWorker(record['pid'], job_dir)
            self.requires_integrity_review = record.get('requires_integrity_review', False)
            self.config_sha256 = record.get('config_sha256')

    def snapshot(self):
        state = {'state': 'idle', 'progress': 0., 'message': 'Ready for one agent-guided round.'}
        if self.job_dir:
            path = self.job_dir / 'status.json'
            if path.exists():
                state.update(json.loads(path.read_text()))
            if self.process is not None and self.process.poll() is not None and state['state'] == 'running':
                state.update(state='failed', message='The round worker exited before publishing a result.')
            completed_settings = {}
            if state['state'] == 'completed':
                completed_settings = json.loads((self.job_dir / 'config.json').read_text())['settings']
            promote = (state['state'] == 'completed' and state.get('mode') == 'agent_guided'
                       and completed_settings.get('family') in ('all', 'new_family')
                       and completed_settings.get('clip_limit') == 0)
            if promote:
                verified_result = None
                required = self.requires_integrity_review or 'review_agents' in completed_settings
                if required and (self.process is None or self.process.poll() is None):
                    state.update(state='running', phase='integrity_review',
                                 message='Waiting for the independent outer-worker integrity audit to finish')
                    promote = False
                else:
                    try:
                        if self.config_sha256 and sha256((self.job_dir / 'config.json').read_bytes()).hexdigest() != self.config_sha256:
                            raise ValueError('Server-pinned job configuration changed')
                        next_prior, verified_result = verify_publication(self.job_dir, require_review=required)
                    except (OSError, ValueError, KeyError, TypeError) as error:
                        state.update(state='failed', phase='integrity_review',
                                     message=f'Final integrity publication blocked: {error}')
                        promote = False
            if promote:
                if self.prior != next_prior:
                    self.prior = next_prior
                    self.prior_record = verified_result
                    write_json(self.output / 'dashboard-current.json', {'results_path': str(next_prior)})
                    progress_path = self.dashboard / 'progress.json'
                    if progress_path.exists():
                        progress = json.loads(progress_path.read_text())
                        progress.update(step='selected', round=self.prior_record['round'], active_candidate=None,
                                        pool=self.prior_record['next_pool'], ranked=self.prior_record['ranked'],
                                        result=self.prior_record)
                        progress.pop('leader_trend', None)
                        write_json(progress_path, progress)
                state['result']['subset'] = False
        prior = self.prior_record
        datasets = discover_datasets()
        families = available_families(prior)
        catalog = candidate_catalog(prior)
        contexts = self.leader_history.snapshot()
        views = list(self.leader_history.views)
        deployment = load_deployment_evaluation(self.output, self.prior)
        if deployment:
            inputs=json.loads((self.prior.parent/'inputs.json').read_text())
            context=leader_context(deployment['native_result'],inputs,'deployment-benchmark',
                                   {'deployment':'deployment-v1','source':deployment['source_result_sha256']})
            context.update(label='Deployment CPU · '+context['label'],summary=deployment['summary'])
            contexts.append(context)
            view={key:value for key,value in deployment.items() if key not in ('native_result','evidence_sha256')}
            views.append({**view,'training_histories':load_training_histories(self.prior.parent, prior),
                          'context_id':context['id'],'snapshot':inputs['snapshot_sha256'],
                          'job':'deployment-benchmark'})
        loss_diagnostics = load_loss_diagnostics(self.output, self.prior, prior)
        for view in views:
            if view['job'] in (self.prior.parent.name, 'deployment-benchmark'):
                view['training_histories'] = {**view.get('training_histories', {}), **loss_diagnostics}
        completed_rounds = [point['round'] for context in contexts for point in context['points']]
        state.update(next_round=max([prior['round'], *completed_rounds]) + 1,
                     leader_contexts=contexts,
                     evaluation_views=views,
                     families=[{'value': 'all', 'label': 'All families'},
                               {'value': 'new_family', 'label': 'New Family'},
                               *[{'value': family, 'label': family} for family in families]],
                     defaults=DEFAULTS, mode='agent_guided', target_basis='validation',
                     retained_candidate_count=len(prior['next_pool']),
                     family_candidate_counts={family: sum(candidate_family(candidate, prior) == family
                                                         for candidate in catalog) for family in families},
                     datasets=datasets, agent_readiness=self.agent_readiness,
                     integrity_review=prior.get('integrity_review', {'status': 'legacy_unreviewed',
                         'candidate_status': {candidate['name']: 'legacy_unreviewed' for candidate in prior['next_pool']}}),
                     evaluation_protocol=prior.get('evaluation_protocol', 'clip_replay-v1'),
                     phone_timing=load_phone_timing(self.output, self.prior),
                     laptop_native_timing=load_phone_timing(self.output, self.prior, 'laptop-native'),
                     scope='Selected frozen collections with a pinned random episode split')
        return state

    def start(self, payload):
        with self.lock:
            if self.process is not None and self.process.poll() is None:
                raise RuntimeError('A round is already running')
            current = self.snapshot()
            settings = validate_settings(payload, available_families(self.prior_record))
            if settings['mode'] == 'agent_guided' and not self.agent_readiness['ready']:
                raise ValueError(self.agent_readiness['message'])
            if settings['mode'] == 'bounded_mutations' and settings['family'] == 'new_family':
                raise ValueError('New Family requires the agent-guided coordinator')
            stamp = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ')
            output = self.output / f'dashboard-{stamp}-{uuid4().hex[:8]}'
            output.mkdir(parents=True)
            write_json(output / 'config.json', {'settings': settings, 'prior': str(self.prior),
                                               'dashboard': str(self.dashboard), 'round_number': current['next_round']})
            config_sha256 = sha256((output / 'config.json').read_bytes()).hexdigest()
            registration = self.output / '.review-required' / f'{output.name}.json'
            registration.parent.mkdir(parents=True, exist_ok=True)
            write_json(registration, {'job': str(output.resolve()), 'config_sha256': config_sha256,
                                      'review_agents': settings['review_agents'], 'policy_version': 'continuous-v1'})
            write_json(output / 'status.json', {'state': 'running', 'progress': 0., 'message': 'Starting round worker'})
            with (output / 'worker.log').open('w') as log:
                worker = 'dashboard_agents.py' if settings['mode'] == 'agent_guided' else 'dashboard_round.py'
                self.process = subprocess.Popen([sys.executable, str(HERE / worker),
                                                 str(output / 'config.json')],
                                                stdout=log, stderr=subprocess.STDOUT, cwd=HERE,
                                                start_new_session=True, env=os.environ.copy())
            self.job_dir = output
            self.requires_integrity_review = True
            self.config_sha256 = config_sha256
            write_json(self.output / 'dashboard-active.json', {'pid': self.process.pid,
                                                               'job_directory': str(output),
                                                               'requires_integrity_review': True,
                                                               'config_sha256': config_sha256})
            return self.snapshot()


class DashboardHandler(SimpleHTTPRequestHandler):
    def __init__(self, request, client_address, server):
        super().__init__(request, client_address, server, directory=str(server.jobs.dashboard))

    def json_response(self, status, payload):
        raw = json.dumps(payload, allow_nan=False).encode()
        self.send_response(status)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Cache-Control', 'no-store')
        self.send_header('Content-Length', str(len(raw)))
        self.end_headers()
        self.wfile.write(raw)

    def do_GET(self):
        if urlsplit(self.path).path == '/api/round':
            with self.server.jobs.lock:
                self.json_response(200, self.server.jobs.snapshot())
            return
        super().do_GET()

    def do_POST(self):
        route = urlsplit(self.path).path
        if route not in ('/api/round', '/api/round/preview'):
            self.json_response(404, {'message': 'Endpoint not found'})
            return
        port = self.server.server_port
        permitted = {f'127.0.0.1:{port}', f'localhost:{port}'}
        host = self.headers.get('Host')
        origin = self.headers.get('Origin')
        if host not in permitted or (origin and origin != f'http://{host}') or self.headers.get('Sec-Fetch-Site') == 'cross-site':
            self.json_response(403, {'message': 'Start rounds from this local dashboard'})
            return
        if self.headers.get_content_type() != 'application/json':
            self.json_response(415, {'message': 'Use JSON round settings'})
            return
        try:
            length = int(self.headers.get('Content-Length', '0'))
            if not 0 < length <= 65536:
                raise ValueError('Round settings must fit in a small JSON request')
            payload = json.loads(self.rfile.read(length))
            if route == '/api/round/preview':
                with self.server.jobs.lock:
                    current = self.server.jobs.snapshot()
                    settings = validate_settings(payload, available_families(self.server.jobs.prior_record))
                    state = research_disclosure(settings, self.server.jobs.prior, current['next_round'])
            else:
                state = self.server.jobs.start(payload)
        except RuntimeError as error:
            self.json_response(409, {'message': str(error)})
        except (ValueError, OSError) as error:
            self.json_response(400, {'message': str(error)})
        else:
            self.json_response(200 if route == '/api/round/preview' else 202, state)

    def list_directory(self, path):
        self.send_error(403, 'Directory listings are disabled')
        return None


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--port', type=int, default=8787)
    parser.add_argument('--prior', type=Path)
    parser.add_argument('--output', type=Path, default=WORK_ROOT)
    args = parser.parse_args()
    prior = args.prior
    if prior is None:
        pointer = args.output / 'dashboard-current.json'
        if pointer.exists():
            prior = Path(json.loads(pointer.read_text())['results_path'])
        else:
            candidates = list(HERE.parents[1].glob('data/jaw-policy-*/joint-round-*.json'))
            if not candidates:
                parser.error('Provide the frozen prior round with --prior')
            prior = max(candidates, key=lambda path: int(path.stem.rsplit('-', 1)[1]))
    server = ThreadingHTTPServer(('127.0.0.1', args.port), DashboardHandler)
    server.jobs = Jobs(HERE / 'dashboard', prior.resolve(strict=True), args.output.resolve())
    print(f'RSI dashboard at http://127.0.0.1:{args.port}/', flush=True)
    server.serve_forever()


if __name__ == '__main__':
    main()

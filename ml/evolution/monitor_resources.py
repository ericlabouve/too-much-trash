"""Monitor one running job; private observations also pause new fits at critical pressure."""

import argparse
import json
import os
from pathlib import Path
import time

from .resources import memory_snapshot


def alive(pid):
    try:
        os.kill(pid, 0)
        return True
    except ProcessLookupError:
        return False
    except PermissionError:
        return True


def watch(job, worker_pid, interval=30):
    job = Path(job).resolve(strict=True)
    config = json.loads((job / 'config.json').read_text())
    ledger_path = job.parent / '.agent-runtime' / f'{job.name}.json'
    directory = job.parent / '.resource-monitor'
    directory.mkdir(exist_ok=True)
    state_path = directory / f'{job.name}.json'
    log_path = directory / f'{job.name}.jsonl'
    previous, samples, max_rss, max_pressure, max_swap = None, 0, 0, 0, 0
    while True:
        status = json.loads((job / 'status.json').read_text())
        ledger = json.loads(ledger_path.read_text()) if ledger_path.exists() else {'tasks': []}
        pids = {worker_pid, ledger.get('supervisor_pid', worker_pid)}
        for task in ledger['tasks']:
            if task['status'] == 'running':
                pids.update(record['pid'] for record in task.get('owned_processes', []))
                pids.update(turn['pid'] for turn in task['turns'][-1:] if 'pid' in turn)
        try:
            sample = memory_snapshot(pids)
            fits = []
            for path in (job / 'training').glob('*/fit-lease.json'):
                lease = json.loads(path.read_text())
                if lease['ended_monotonic'] is None and alive(lease['pid']):
                    fits.append({'trial': path.parent.name, 'pid': lease['pid'], 'slot': lease['slot']})
            sample.update(job=str(job), state=status['state'], phase=status.get('phase'),
                          running_agents=sum(t['status'] == 'running' for t in ledger['tasks']),
                          queued_agents=sum(t['status'] == 'queued' for t in ledger['tasks']),
                          active_fits=fits, fit_limit=config['settings']['fit_concurrency'])
            temporary = state_path.with_suffix('.pending')
            temporary.write_text(json.dumps(sample, indent=2))
            temporary.replace(state_path)
            with log_path.open('a') as stream:
                stream.write(json.dumps(sample) + '\n')
            samples += 1
            max_rss = max(max_rss, sample['owned_rss_bytes'])
            max_pressure = max(max_pressure, sample['pressure_level'])
            max_swap = max(max_swap, sample['swap_used_mib'])
            change = (sample['state'], sample['phase'], sample['running_agents'], len(fits), sample['pressure_level'])
            if change != previous:
                print(json.dumps({'state':sample['state'],'phase':sample['phase'],'running_agents':sample['running_agents'],
                                  'active_fits':len(fits),'pressure_level':sample['pressure_level'],
                                  'owned_rss_mib':round(sample['owned_rss_bytes']/1024**2),
                                  'swap_used_mib':sample['swap_used_mib']}), flush=True)
                previous = change
            if len(fits) > sample['fit_limit']:
                print('ERROR: observed fitting-slot limit exceeded; investigate before any publication.', flush=True)
            if sample['pressure_level'] >= 4:
                print('MEMORY WARNING: critical pressure; new fits wait, active fits may finish.', flush=True)
        except Exception as error:
            print(f'Memory observation failed: {error}', flush=True)
        if status['state'] != 'running' or not alive(worker_pid):
            summary = {'samples':samples,'max_owned_rss_mib':round(max_rss/1024**2),
                       'max_pressure_level':max_pressure,'max_swap_mib':max_swap,'state':status['state']}
            (directory / f'{job.name}-summary.json').write_text(json.dumps(summary, indent=2))
            print(json.dumps(summary), flush=True)
            return summary
        time.sleep(interval)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--job', type=Path, required=True)
    parser.add_argument('--worker-pid', type=int, required=True)
    parser.add_argument('--interval', type=float, default=30)
    options = parser.parse_args()
    if options.worker_pid <= 0 or not 1 <= options.interval <= 60:
        parser.error('Use a positive worker PID and a 1–60 second sampling interval')
    watch(options.job, options.worker_pid, options.interval)

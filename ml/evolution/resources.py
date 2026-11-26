"""Process-shared fitting slots and read-only Mac memory observations."""

import fcntl
import json
import os
from pathlib import Path
import re
import subprocess
import time
from hashlib import sha256

PROTOCOL = 'flock-v1'


def critical_memory(job):
    """A fresh trusted monitor observation pauses new fits, never active ones."""
    job = Path(job).resolve()
    path = job.parent / '.resource-monitor' / f'{job.name}.json'
    try:
        sample = json.loads(path.read_text())
        return 0 <= time.monotonic() - sample['monotonic'] <= 90 and sample.get('pressure_level', 0) >= 4
    except (OSError, ValueError, KeyError, TypeError):
        return False


def fitting_settings(job):
    path = Path(job) / 'config.json'
    settings = json.loads(path.read_text()).get('settings', {}) if path.exists() else {}
    if 'fit_slot_protocol' not in settings:
        return None  # Historical jobs retain their original policy.
    if settings['fit_slot_protocol'] != PROTOCOL:
        raise ValueError('Unknown fitting-slot protocol')
    limit = settings.get('fit_concurrency')
    if type(limit) is not int or not 1 <= limit <= 6:
        raise ValueError('Fitting concurrency must be between one and six')
    return limit


class FittingLease:
    """The kernel releases a slot even when its owning fit process is killed."""

    def __init__(self, job, directory, limit):
        self.job, self.directory, self.limit = Path(job).resolve(), Path(directory), limit
        self.stream, self.record = None, None

    def acquire(self):
        requested = time.monotonic()
        locks = self.job / '.fit-slots'
        locks.mkdir(exist_ok=True)
        while self.stream is None:
            if critical_memory(self.job):
                time.sleep(.25)
                continue
            for slot in range(self.limit):
                stream = (locks / f'{slot}.lock').open('a+')
                try:
                    fcntl.flock(stream, fcntl.LOCK_EX | fcntl.LOCK_NB)
                except BlockingIOError:
                    stream.close()
                    continue
                self.stream = stream
                started = time.monotonic()
                self.record = {'protocol': PROTOCOL, 'limit': self.limit, 'slot': slot,
                               'pid': os.getpid(), 'requested_monotonic': requested,
                               'started_monotonic': started, 'ended_monotonic': None,
                               'wait_seconds': started - requested}
                try:
                    self._save()
                except BaseException:
                    self.stream.close()
                    self.stream = None
                    raise
                break
            if self.stream is None:
                time.sleep(.1)
        return self

    def _save(self):
        path = self.directory / 'fit-lease.json'
        temporary = path.with_suffix('.pending')
        temporary.write_text(json.dumps(self.record, indent=2) + '\n')
        temporary.replace(path)

    def release(self):
        if self.stream is not None:
            try:
                self.record['ended_monotonic'] = time.monotonic()
                self._save()
            finally:
                fcntl.flock(self.stream, fcntl.LOCK_UN)
                self.stream.close()
                self.stream = None
        return self.directory / 'fit-lease.json'


def memory_snapshot(pids=()):
    """RSS sums can count shared pages twice; also record system compression/swap."""
    def command(*args):
        return subprocess.check_output(args, text=True, stderr=subprocess.DEVNULL, timeout=5)
    total = int(command('sysctl', '-n', 'hw.memsize'))
    pressure = int(command('sysctl', '-n', 'kern.memorystatus_vm_pressure_level'))
    vm = command('vm_stat')
    page_size = int(re.search(r'page size of (\d+)', vm).group(1))
    pages = {key.strip(): int(value) for key, value in re.findall(r'^([^:]+):\s+(\d+)\.', vm, re.M)}
    swap = command('sysctl', 'vm.swapusage')
    used = float(re.search(r'used\s*=\s*([\d.]+)M', swap).group(1))
    owned = set(pids)
    rows = []
    for line in command('ps', '-axo', 'pid=,rss=').splitlines():
        pid, rss = map(int, line.split())
        if pid in owned:
            rows.append({'pid': pid, 'rss_bytes': rss * 1024})
    return {'monotonic': time.monotonic(), 'physical_bytes': total,
            'pressure_level': pressure, 'swap_used_mib': used,
            'compressed_bytes': pages.get('Pages occupied by compressor', 0) * page_size,
            'free_bytes': pages.get('Pages free', 0) * page_size,
            'swapins_pages': pages.get('Swapins', 0), 'swapouts_pages': pages.get('Swapouts', 0),
            'processes': rows, 'owned_rss_bytes': sum(row['rss_bytes'] for row in rows),
            'rss_scope': 'Observed owned processes; shared pages may be counted multiple times.'}


def verify_fitting_slots(job):
    """Audit completed fit leases; intentional bypass still needs source review."""
    job = Path(job).resolve()
    limit = fitting_settings(job)
    if limit is None:
        return None
    events, count = [], 0
    journal = job / 'trials.jsonl'
    for line in journal.read_text().splitlines() if journal.exists() else []:
        event = json.loads(line)
        if event.get('status') != 'completed':
            continue
        receipt = json.loads((job / event['receipt']['path']).read_text())
        reference = receipt.get('fit_lease', {})
        path = (job / reference.get('path', '')).resolve(strict=True)
        if not path.is_relative_to(job) or not path.is_file() or sha256(path.read_bytes()).hexdigest() != reference.get('sha256'):
            raise ValueError('Every completed fit needs its unchanged fitting-slot lease')
        lease = json.loads(path.read_text())
        start, end = lease.get('started_monotonic'), lease.get('ended_monotonic')
        if (lease.get('protocol') != PROTOCOL or lease.get('limit') != limit
                or type(lease.get('slot')) is not int or not 0 <= lease['slot'] < limit
                or type(lease.get('pid')) is not int or lease['pid'] <= 0
                or type(start) not in (int, float) or type(end) not in (int, float)
                or not 0 <= start <= end or not end - start >= receipt['elapsed_seconds'] - .05):
            raise ValueError('Invalid completed fit lease or training outside its slot')
        events.extend(((start, 1, lease['slot']), (end, -1, lease['slot'])))
        count += 1
    active, peak, slots = 0, 0, set()
    for _, change, slot in sorted(events):
        if change > 0:
            if slot in slots:
                raise ValueError('Fitting leases overlap within the same kernel slot')
            slots.add(slot)
        else:
            if slot not in slots:
                raise ValueError('Fitting lease released an inactive slot')
            slots.remove(slot)
        active += change
        peak = max(peak, active)
        if active > limit:
            raise ValueError('Fitting concurrency exceeded its configured limit')
    return {'protocol': PROTOCOL, 'limit': limit, 'completed_fits': count,
            'observed_peak_completed_fits': peak}

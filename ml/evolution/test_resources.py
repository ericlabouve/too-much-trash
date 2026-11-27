"""Exercise actual kernel slots with harmless short-lived Python subprocesses."""

import json
from pathlib import Path
import subprocess
import sys
from tempfile import TemporaryDirectory
import time
import unittest
from unittest.mock import patch

from .resources import PROTOCOL, verify_fitting_slots
from .training import TrainingMonitor
from .monitor_resources import watch

ROOT = Path(__file__).resolve().parents[2]
CHILD = '''
from pathlib import Path
import sys,time
from ml.evolution.resources import FittingLease
lease=FittingLease(Path(sys.argv[1]),Path(sys.argv[2]),int(sys.argv[3])).acquire()
time.sleep(float(sys.argv[4]))
lease.release()
'''


class ResourceTests(unittest.TestCase):
    def start(self, root, directory, limit, seconds):
        directory.mkdir()
        process = subprocess.Popen([sys.executable, '-c', CHILD, str(root), str(directory), str(limit), str(seconds)], cwd=ROOT)
        def cleanup():
            if process.poll() is None:
                process.kill()
            process.wait(timeout=5)
        self.addCleanup(cleanup)
        return process

    def wait_for(self, path):
        deadline = time.monotonic() + 5
        while not path.exists() and time.monotonic() < deadline:
            time.sleep(.01)
        self.assertTrue(path.exists())

    def test_four_processes_never_use_more_than_two_slots(self):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            jobs = [(root / str(i)) for i in range(4)]
            processes = [self.start(root, p, 2, .2) for p in jobs]
            for process in processes:
                self.assertEqual(process.wait(timeout=10), 0)
            leases = [json.loads((p / 'fit-lease.json').read_text()) for p in jobs]
            events = sorted([(r['started_monotonic'], 1) for r in leases] + [(r['ended_monotonic'], -1) for r in leases])
            active, peak = 0, 0
            for _, delta in events:
                active += delta; peak = max(peak, active)
            self.assertEqual(peak, 2)
            self.assertGreater(max(r['wait_seconds'] for r in leases), .1)

    def test_process_exit_releases_kernel_slot_for_waiter(self):
        with TemporaryDirectory() as directory:
            root = Path(directory); a, b = root / 'a', root / 'b'
            first = self.start(root, a, 1, 30)
            self.wait_for(a / 'fit-lease.json')
            second = self.start(root, b, 1, .02)
            time.sleep(.15)
            self.assertFalse((b / 'fit-lease.json').exists())
            first.terminate(); first.wait(timeout=5)
            self.assertEqual(second.wait(timeout=5), 0)
            self.assertEqual(json.loads((b / 'fit-lease.json').read_text())['slot'], 0)

    def test_critical_pressure_pauses_new_fit_until_monitor_recovers(self):
        with TemporaryDirectory() as directory:
            base = Path(directory); root = base / 'job'; root.mkdir()
            monitor = base / '.resource-monitor'; monitor.mkdir()
            state = monitor / 'job.json'
            state.write_text(json.dumps({'monotonic':time.monotonic(),'pressure_level':4}))
            child = root / 'fit'; process = self.start(root, child, 2, .02)
            time.sleep(.2)
            self.assertFalse((child / 'fit-lease.json').exists())
            state.write_text(json.dumps({'monotonic':time.monotonic(),'pressure_level':1}))
            self.assertEqual(process.wait(timeout=5), 0)

    def test_terminal_job_memory_monitor_records_sample_and_exits(self):
        with TemporaryDirectory() as directory:
            root = Path(directory) / 'job'; root.mkdir()
            (root / 'config.json').write_text(json.dumps({'settings': {'fit_concurrency': 2}}))
            (root / 'status.json').write_text(json.dumps({'state':'cancelled'}))
            sample = {'monotonic':time.monotonic(),'owned_rss_bytes':1024,'pressure_level':1,'swap_used_mib':0}
            with patch('ml.evolution.monitor_resources.memory_snapshot',return_value=sample):
                summary = watch(root, 99999999)
            self.assertEqual(summary['samples'], 1)
            self.assertEqual(summary['state'], 'cancelled')

    def test_monitor_records_lease_and_fitting_audit_rejects_changed_evidence(self):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'config.json').write_text(json.dumps({'settings': {'fit_slot_protocol': PROTOCOL, 'fit_concurrency': 2}}))
            plan = {'candidate_name': 'Synthetic', 'kind': 'noniterative', 'seed': None,
                    'hypothesis': 'Synthetic test', 'objective': 'Synthetic loss', 'capacity': 'Scalar',
                    'regularization': 'No optimizer', 'resources': {'device': 'CPU', 'threads': 1}}
            with TrainingMonitor(root, 'one', plan, {'train_manifest_sha256': 'a'*64, 'validation_manifest_sha256': 'b'*64}) as trial:
                receipt = trial.finish(parameters={'weight': 1})
            audit = verify_fitting_slots(root)
            self.assertEqual((audit['limit'], audit['completed_fits'], audit['observed_peak_completed_fits']), (2, 1, 1))
            record = json.loads((root / receipt['path']).read_text())
            (root / record['fit_lease']['path']).write_text('{}')
            with self.assertRaises(ValueError):
                verify_fitting_slots(root)

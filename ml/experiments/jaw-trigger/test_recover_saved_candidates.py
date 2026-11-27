from copy import deepcopy
from hashlib import sha256
import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from ml.evolution.training import write
from recover_saved_candidates import recover, verify_recovery
import test_dashboard_training as training_tests


class RecoveryTests(unittest.TestCase):
    def snapshot(self, root):
        return {str(p.relative_to(root)): sha256(p.read_bytes()).hexdigest()
                for p in root.rglob('*') if p.is_file()}

    def fixture(self, job):
        settings, _, result, evaluation, eligible = training_tests.TrainingAuditTests().fixture(job)
        write(job / 'config.json', {'round_number': 60, 'settings': settings})
        write(job / 'status.json', {'state': 'failed', 'message': 'model binding collision'})
        write(job / 'agents.json', {'tasks': [{'kind': 'parent', 'status': 'completed'}]})
        write(job / 'model.json', result['feature_parameters']['state_model'])
        write(job / 'deployment-specs.json', [{'candidate': eligible['Model'], 'model_path': 'model.json',
            'metadata': {}, 'incumbent': False, 'learned': True,
            'receipt': evaluation['training_receipts']['Model'], 'artifacts': {'model.json': ['model']}}])

    def test_recovery_is_read_only_auditable_and_does_not_admit(self):
        with TemporaryDirectory() as directory:
            root = Path(directory); job = root / 'failed'; job.mkdir()
            self.fixture(job)
            before = self.snapshot(job)
            report = recover(job, root / 'recovered')
            self.assertEqual(before, self.snapshot(job))
            self.assertEqual(report['recovered_challengers'], 1)
            self.assertFalse(report['published'])
            self.assertFalse(report['test_evaluated'])
            self.assertEqual(verify_recovery(root / 'recovered'), report)
            with self.assertRaisesRegex(ValueError, 'never overwrite'):
                recover(job, root / 'recovered')
            (root / 'recovered/evidence/model.json').write_text('{}')
            with self.assertRaisesRegex(ValueError, 'Archived recovery'):
                verify_recovery(root / 'recovered')

    def test_recovery_fails_before_creation_for_wrong_weights_or_unfinished_author(self):
        for corruption in ('weights', 'author', 'duplicate'):
            with TemporaryDirectory() as directory:
                root = Path(directory); job = root / 'failed'; job.mkdir()
                self.fixture(job)
                if corruption == 'weights':
                    write(job / 'model.json', {'value': 3})
                elif corruption == 'author':
                    write(job / 'agents.json', {'tasks': [{'kind': 'parent', 'status': 'running'}]})
                else:
                    specs = json.loads((job / 'deployment-specs.json').read_text())
                    write(job / 'deployment-specs.json', specs + deepcopy(specs))
                with self.subTest(corruption=corruption), self.assertRaises(ValueError):
                    recover(job, root / 'recovered')
                self.assertFalse((root / 'recovered').exists())

    def test_original_evidence_changes_invalidate_recovery(self):
        with TemporaryDirectory() as directory:
            root = Path(directory); job = root / 'failed'; job.mkdir()
            self.fixture(job)
            recover(job, root / 'recovered')
            (job / 'status.json').write_text('{"state":"completed"}')
            with self.assertRaisesRegex(ValueError, 'hash changed'):
                verify_recovery(root / 'recovered')

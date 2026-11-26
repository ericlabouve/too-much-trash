"""Loss charts must show recorded evidence for the exact fitted model."""

from hashlib import sha256
import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from dashboard_losses import load_training_histories, load_loss_diagnostics, normalize_history


class LossHistoryTests(unittest.TestCase):
    def fixture(self, root):
        candidate = {'name': 'Model', 'method': 'mlp', 'threshold': .5}
        model = {'layers': [1, 2]}
        result = {'ranked': [{'candidate': candidate}], 'feature_parameters': {'mlp': model},
                  'candidate_metadata': {'Model': {}}}
        (root / 'model.json').write_text(json.dumps(model))
        return candidate, model, result

    def test_normalizes_both_series_without_filling_missing_validation(self):
        record = normalize_history({'metric': 'BCE', 'points': [
            {'epoch': 1, 'train_loss': .5},
            {'epoch': 2, 'train_loss': .3, 'validation_loss': .4}]})
        self.assertIsNone(record['points'][0]['validation_loss'])
        self.assertEqual(record['points'][1]['validation_loss'], .4)
        for points in ([{'epoch': 1, 'train_loss': float('nan')}],
                       [{'epoch': 1, 'train_loss': -1}],
                       [{'epoch': 1, 'train_loss': .2}, {'epoch': 1, 'train_loss': .1}],
                       [{'epoch': 1}]):
            with self.assertRaises(ValueError):
                normalize_history({'metric': 'BCE', 'points': points})

    def test_explicit_history_requires_matching_hashes_and_model(self):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            candidate, model, result = self.fixture(root)
            history = root / 'history.json'
            history.write_text(json.dumps({'metric': 'BCE', 'points': [
                {'epoch': 1, 'train_loss': .5, 'validation_loss': .6}]}))
            spec = {'path': 'history.json', 'sha256': sha256(history.read_bytes()).hexdigest(),
                    'model_path': 'model.json', 'model_sha256': sha256((root / 'model.json').read_bytes()).hexdigest()}
            result['candidate_metadata']['Model']['training_history'] = spec
            loaded = load_training_histories(root, result)
            self.assertEqual(loaded['Model']['candidate'], candidate)
            self.assertEqual(loaded['Model']['points'][0]['validation_loss'], .6)
            result['feature_parameters']['mlp'] = {'layers': [9]}
            self.assertEqual(load_training_histories(root, result), {})
            result['feature_parameters']['mlp'] = model
            history.write_text('{}')
            self.assertEqual(load_training_histories(root, result), {})

    def test_legacy_training_only_history_bound_by_evaluation_and_model(self):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            candidate, _, result = self.fixture(root)
            child = root / 'child'; child.mkdir()
            (child / 'fit-history.json').write_text(json.dumps([{'epoch': 1, 'weighted_bce': .7}]))
            evaluation = {'candidate': candidate, 'model_path': str(root / 'model.json')}
            (child / 'evaluation.json').write_text(json.dumps(evaluation))
            loaded = load_training_histories(root, result)
            self.assertEqual(loaded['Model']['points'][0]['train_loss'], .7)
            self.assertIsNone(loaded['Model']['points'][0]['validation_loss'])
            evaluation['candidate'] = {**candidate, 'threshold': .8}
            (child / 'evaluation.json').write_text(json.dumps(evaluation))
            self.assertEqual(load_training_histories(root, result), {})

    def test_outside_job_artifact_cannot_supply_a_curve(self):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            job = root / 'job'; job.mkdir()
            _, _, result = self.fixture(job)
            outside = root / 'history.json'
            outside.write_text(json.dumps({'metric': 'BCE', 'points': [{'epoch': 1, 'train_loss': .3}]}))
            result['candidate_metadata']['Model']['training_history'] = {
                'path': '../history.json', 'sha256': sha256(outside.read_bytes()).hexdigest(),
                'model_path': 'model.json', 'model_sha256': sha256((job / 'model.json').read_bytes()).hexdigest()}
            self.assertEqual(load_training_histories(job, result), {})

    def test_diagnostic_overlay_requires_exact_checkpoint_and_unchanged_evidence(self):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            candidate, _, result = self.fixture(root)
            prior = root / 'results.json'; prior.write_text(json.dumps(result))
            history = root / 'history.json'
            history.write_text(json.dumps({'metric': 'BCE', 'points': [
                {'epoch': 1, 'train_loss': .5, 'validation_loss': .6}]}))
            summary = {'status': 'exact_checkpoint_reproduction',
                       'source_result_sha256': sha256(prior.read_bytes()).hexdigest(),
                       'candidates': {'Model': {'candidate': candidate, 'exact_model_match': True,
                           'history_path': 'history.json', 'history_sha256': sha256(history.read_bytes()).hexdigest(),
                           'model_path': 'model.json', 'model_sha256': sha256((root / 'model.json').read_bytes()).hexdigest()}}}
            summary_path = root / 'summary.json'; summary_path.write_text(json.dumps(summary))
            pointer = {'source_result_sha256': summary['source_result_sha256'],
                       'summary_path': str(summary_path), 'summary_sha256': sha256(summary_path.read_bytes()).hexdigest()}
            (root / 'training-loss-current.json').write_text(json.dumps(pointer))
            self.assertTrue(load_loss_diagnostics(root, prior, result)['Model']['reproduced'])
            result['feature_parameters']['mlp'] = {'layers': [8]}
            self.assertEqual(load_loss_diagnostics(root, prior, result), {})
            history.write_text('{}')
            self.assertEqual(load_loss_diagnostics(root, prior, result), {})
            prior.write_text('{}')
            self.assertEqual(load_loss_diagnostics(root, prior, result), {})


if __name__ == '__main__':
    unittest.main()

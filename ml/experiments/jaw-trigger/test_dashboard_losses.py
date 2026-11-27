"""Loss charts must show recorded evidence for the exact fitted model."""

from hashlib import sha256
import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from dashboard_losses import load_training_histories, load_loss_diagnostics, normalize_history
from dashboard_event_curves import event_f1
from ml.evolution.model_parameters import bind_parameters


class LossHistoryTests(unittest.TestCase):
    def test_per_event_f1_counts_duplicate_predictions_and_wrong_event_kinds(self):
        rows = [{'clip': 'a', 'jaw_reference': {'close': 3., 'open': 5.}},
                {'clip': 'b', 'jaw_reference': {'close': 3., 'open': 5.}}]
        predictions = {'a': [['close', 3.], ['close', 3.1], ['open', 5.]], 'b': [['open', 3.]]}
        actual = event_f1(predictions, rows, .5)
        self.assertEqual(actual, {'squeeze': .5, 'release': .5})
        for bad in ({'test': []}, {'a': [], 'b': [['close', float('nan')]]}):
            with self.assertRaises(ValueError):
                event_f1(bad, rows, .5)

    def test_event_curves_are_bound_to_split_prediction_and_checkpoint_hashes(self):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            candidate, model, result = self.fixture(root)
            def save(name, value):
                path = root / name
                path.write_text(json.dumps(value))
                return {'path': name, 'sha256': sha256(path.read_bytes()).hexdigest()}
            manifests = {split: save(f'{split}.json', {'clips': [
                {'clip': split, 'jaw_reference': {'close': 3., 'open': 5.}}]})
                for split in ('train', 'validation')}
            save('plan.json', {'context': {f'{split}_manifest_sha256': ref['sha256']
                                          for split, ref in manifests.items()}})
            save('config.json', {'settings': {'match_seconds': .5}})
            val = save('validation-predictions.json', {'validation': [['close', 3.], ['open', 5.]]})
            train = save('train-predictions.json', {'train': [['close', 3.]]})
            history = save('history.json', {'metric': 'BCE', 'points': [
                {'epoch': 1, 'train_loss': .3, 'validation_loss': .4,
                 'predictions': val, 'training_predictions': train},
                {'epoch': 2, 'train_loss': .2, 'validation_loss': .5, 'predictions': val}]})
            checkpoint = save('selected-checkpoint.json', {'parameters': model})
            result['training_audit'] = {'candidates': {'Model': {
                'kind': 'iterative', 'history': history, 'checkpoint': checkpoint, 'selected_epoch': 1}}}
            loaded = load_training_histories(root, result)['Model']
            first, second = loaded['points']
            self.assertEqual(first['train_squeeze_f1'], 1.)
            self.assertEqual(first['train_release_f1'], 0.)
            self.assertEqual(second['validation_release_f1'], 1.)
            self.assertIsNone(second['train_squeeze_f1'])
            self.assertEqual(loaded['selected_epoch'], 1)
            # Tampered predictions must disappear rather than fabricate curves.
            save('train-predictions.json', {'test': []})
            loaded = load_training_histories(root, result)['Model']
            self.assertIsNone(loaded['points'][0]['validation_release_f1'])
            self.assertEqual(loaded['points'][0]['train_loss'], .3)

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

    def test_detailed_realistic_objectives_do_not_silently_drop_loss_curves(self):
        for length in (154, 186, 2048):
            prefix = 'Weighted binary cross-entropy; '
            objective = prefix + 'x' * (length - len(prefix))
            history = normalize_history({'metric': objective,
                                         'points': [{'epoch': 1, 'train_loss': .1, 'validation_loss': .3}]})
            self.assertEqual(history['metric'], objective)
            self.assertEqual(history['points'][0]['validation_loss'], .3)

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

    def test_same_method_loss_curves_bind_to_each_candidate(self):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            parent, model, result = self.fixture(root)
            child = {**parent, 'name': 'Child'}
            result['ranked'].append({'candidate': child})
            result.update(bind_parameters([(parent, model), (child, {'layers': [9]})]))
            for candidate, weights, loss in ((parent, model, .3), (child, {'layers': [9]}, .7)):
                name = candidate['name']
                history, checkpoint = root / f'{name}-history.json', root / f'{name}-checkpoint.json'
                history.write_text(json.dumps({'metric': 'BCE', 'points': [
                    {'epoch': 1, 'train_loss': loss, 'validation_loss': loss + .1}]}))
                checkpoint.write_text(json.dumps({'parameters': weights}))
                ref = lambda p: {'path': p.name, 'sha256': sha256(p.read_bytes()).hexdigest()}
                result.setdefault('training_audit', {}).setdefault('candidates', {})[name] = {
                    'kind': 'iterative', 'history': ref(history), 'checkpoint': ref(checkpoint), 'selected_epoch': 1}
            histories = load_training_histories(root, result)
            self.assertEqual(histories['Model']['points'][0]['train_loss'], .3)
            self.assertEqual(histories['Child']['points'][0]['train_loss'], .7)
            result['candidate_parameters']['Model'] = {'layers': [9]}
            self.assertEqual(set(load_training_histories(root, result)), {'Child'})

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

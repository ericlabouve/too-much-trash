"""Training admission must use honest validation checkpoints and complete trials."""

from copy import deepcopy
from hashlib import sha256
import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from ml.evolution.training import TrainingMonitor, PROTOCOL, evidence, policy_for, write
from dashboard_training import verify_training_records, preflight_training_trial, make_training_monitor


class TrainingAuditTests(unittest.TestCase):
    def test_early_display_contract_is_identical_to_final_contract(self):
        from dashboard_agents import validate_display_metadata
        good = {'family': 'Contrast', 'differentiator': 'Trimmed bilateral row consensus',
                'architecture': [['Data', 'Measured image appearance'], ['State', 'Causal hysteresis']]}
        validate_display_metadata(good)
        bad = dict(good, differentiator='Robust sorted-row bilateral appearance contrast with fixed ten-row tail removal and persistent visual hysteresis')
        with self.assertRaisesRegex(ValueError, 'display and architecture metadata'):
            validate_display_metadata(bad)

    def fixture(self, job, *, kind='iterative', epochs=3):
        settings = {'training_protocol': PROTOCOL, 'agent_minutes': 30, 'match_seconds': .5}
        train = job / 'train.json'
        validation = job / 'validation.json'
        write(train, {'clips': [{'clip': 'train', 'jaw_reference': {'close': 3., 'open': 5.}}]})
        write(validation, {'clips': [{'clip': 'validation', 'jaw_reference': {'close': 3., 'open': 5.}}]})
        manifests = {'train': train, 'validation': validation}
        context = {f'{split}_manifest_sha256': sha256(path.read_bytes()).hexdigest()
                   for split, path in manifests.items()}
        plan = {'candidate_name': 'Model', 'kind': kind, 'hypothesis': 'Test a smaller state model',
                'seed': 0,
                'objective': 'Weighted BCE', 'capacity': 'Two layers, eight units',
                'regularization': 'Weight decay 0.01', 'resources': {'device': 'CPU', 'threads': 2},
                'max_epochs': epochs, 'selection_decoder': {'threshold': .5}}
        clock = [0.]
        monitor = TrainingMonitor(job, 'trial-one', plan, context, policy=policy_for(settings), clock=lambda: clock[0])
        if kind == 'iterative':
            for epoch in range(1, epochs + 1):
                clock[0] = float(epoch)
                perfect = epoch == 2
                monitor.observe(train_loss=1 / epoch, validation_loss=.2 if perfect else .8,
                                validation_score=1. if perfect else 2 / 3,
                                validation_predictions={'validation': [['close', 3.], ['open', 5.]]
                                                        if perfect else [['close', 3.]]},
                                parameters={'value': epoch})
            record = monitor.finish()
            model = {'value': 2 if epochs >= 2 else 1}
        else:
            clock[0] = 2.
            record = monitor.finish(parameters={'value': 'closed-form'})
            model = {'value': 'closed-form'}
        candidate = {'name': 'Model', 'method': 'state_model'}
        result = {'feature_parameters': {'state_model': model}}
        evaluation = {'fitted_candidates': ['Model'], 'training_receipts': {'Model': record}}
        return settings, manifests, result, evaluation, {'Model': candidate}

    def audit(self, job, fixture):
        settings, manifests, result, evaluation, eligible = fixture
        return verify_training_records(job, result, evaluation, settings, manifests, eligible)

    def test_early_preflight_uses_canonical_checks_with_other_open_trials(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            fixture = self.fixture(job)
            write(job / 'config.json', {'settings': fixture[0]})
            # Another agent is actively fitting; that must not block this check.
            with (job / 'trials.jsonl').open('a') as stream:
                stream.write(json.dumps({'trial_id': 'another-fit', 'status': 'started'}) + '\n')
            before = {str(p): sha256(p.read_bytes()).hexdigest() for p in job.rglob('*') if p.is_file()}
            result = preflight_training_trial(job, 'trial-one')
            self.assertEqual(result['status'], 'passed')
            self.assertEqual(result['selected_epoch'], 2)
            self.assertEqual(result['candidate_names'], ['Model'])
            self.assertEqual(before, {str(p): sha256(p.read_bytes()).hexdigest()
                                      for p in job.rglob('*') if p.is_file()})
            with self.assertRaisesRegex(ValueError, 'started/completed'):
                preflight_training_trial(job, 'another-fit')

    def test_early_preflight_does_not_accept_handwritten_list_or_false_f1(self):
        for corruption in ('list', 'f1'):
            with self.subTest(corruption=corruption), TemporaryDirectory() as directory:
                job = Path(directory)
                fixture = self.fixture(job)
                write(job / 'config.json', {'settings': fixture[0]})
                def mutate(receipt):
                    history_path = job / receipt['history']['path']
                    history = json.loads(history_path.read_text())
                    first = history['points'][0]
                    if corruption == 'list':
                        path = job / first['predictions']['path']
                        predictions = json.loads(path.read_text())
                        write(path, list(predictions.values()))
                        first['predictions'] = evidence(job, path)
                    else:
                        first['validation_score'] = 1.
                    write(history_path, history)
                    receipt['history'] = evidence(job, history_path)
                self.republish(job, fixture, mutate)
                with self.assertRaisesRegex(ValueError, 'JSON object|must match'):
                    preflight_training_trial(job, 'trial-one')

    def test_domain_monitor_rejects_bad_ids_event_shapes_and_scores_before_saving(self):
        for predictions, score in (({'test': []}, 0.),
                                   ({'validation': [['close', float('inf')]]}, 0.),
                                   ({'validation': [['squeeze', 3.]]}, 0.),
                                   ({'validation': [['close', 3.]]}, 1.)):
            with self.subTest(predictions=predictions), TemporaryDirectory() as directory:
                job = Path(directory)
                fixture = self.fixture(job)
                write(job / 'config.json', {'settings': fixture[0]})
                plan = json.loads((job / 'training/trial-one/plan.json').read_text())['plan']
                plan['max_epochs'] = 1
                plan['measurement_note'] = 'Data BCE; equal fixed evaluation rules, penalty excluded.'
                with make_training_monitor(job, 'validated-trial', plan) as monitor:
                    with self.assertRaises(ValueError):
                        monitor.observe(train_loss=.1, validation_loss=.2, validation_score=score,
                                        validation_predictions=predictions, parameters={'value': 1})
                    self.assertEqual(monitor.points, [])
                    self.assertFalse((monitor.directory / 'selected-checkpoint.json').exists())
                    monitor.observe(train_loss=.1, validation_loss=.2, validation_score=1.,
                                    validation_predictions={'validation': [['close', 3.], ['open', 5.]]},
                                    parameters={'value': 1})
                    monitor.finish()
                checked = preflight_training_trial(job, 'validated-trial')
                self.assertEqual(checked['selected_validation_f1'], 1.)
                history = json.loads((job / checked['history']['path']).read_text())
                self.assertIn('penalty excluded', history['note'])

    def test_domain_monitor_checks_the_stored_json_representation(self):
        import numpy as np
        with TemporaryDirectory() as directory:
            job = Path(directory)
            fixture = self.fixture(job)
            write(job / 'config.json', {'settings': fixture[0]})
            plan = json.loads((job / 'training/trial-one/plan.json').read_text())['plan']
            plan['max_epochs'] = 1
            with make_training_monitor(job, 'tuple-events', plan) as monitor:
                monitor.observe(train_loss=.1, validation_loss=.2, validation_score=1.,
                                validation_predictions={'validation': [('close', np.float64(3.)), ('open', 5.)]},
                                parameters={'value': 1})
                monitor.finish()
            report = preflight_training_trial(job, 'tuple-events')
            self.assertEqual(report['selected_validation_f1'], 1.)
            prediction = json.loads((job / 'training/tuple-events/validation-0001.json').read_text())
            self.assertEqual(prediction['validation'], [['close', 3.], ['open', 5.]])

    def republish(self, job, fixture, mutate):
        """Refresh hashes after an adversarial edit so semantic checks must catch it."""
        settings, manifests, result, evaluation, eligible = fixture
        receipt_path = job / evaluation['training_receipts']['Model']['path']
        receipt = json.loads(receipt_path.read_text())
        mutate(receipt)
        write(receipt_path, receipt)
        record = evidence(job, receipt_path)
        evaluation['training_receipts']['Model'] = record
        journal = [json.loads(line) for line in (job / 'trials.jsonl').read_text().splitlines()]
        journal[-1]['receipt'] = record
        (job / 'trials.jsonl').write_text(''.join(json.dumps(row) + '\n' for row in journal))

    def test_best_checkpoint_survives_late_overfitting(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            fixture = self.fixture(job)
            summary = self.audit(job, fixture)
            model = summary['candidates']['Model']
            self.assertEqual(model['selected_epoch'], 2)
            self.assertEqual(model['trained_epochs'], 3)
            self.assertEqual(model['selected_validation_f1'], 1.)
            fixture[2]['feature_parameters']['state_model'] = {'value': 3}
            with self.assertRaisesRegex(ValueError, 'selected validation checkpoint'):
                self.audit(job, fixture)

    def test_noniterative_fit_has_no_fake_curve(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            fixture = self.fixture(job, kind='noniterative')
            summary = self.audit(job, fixture)
            self.assertEqual(summary['candidates']['Model']['kind'], 'noniterative')
            self.assertIsNone(summary['candidates']['Model']['history'])
            self.republish(job, fixture, lambda receipt: receipt.update(selected_epoch=1))
            with self.assertRaisesRegex(ValueError, 'must not invent epochs'):
                self.audit(job, fixture)

    def test_epoch_f1_cannot_be_invented_or_include_test(self):
        for corruption in ('score', 'test', 'epoch', 'loss', 'continue'):
            with self.subTest(case=corruption), TemporaryDirectory() as directory:
                job = Path(directory)
                fixture = self.fixture(job)
                def mutate(receipt):
                    path = job / receipt['history']['path']
                    history = json.loads(path.read_text())
                    if corruption == 'score':
                        history['points'][0]['validation_score'] = 1.
                    elif corruption == 'epoch':
                        history['points'][0]['epoch'] = 0
                    elif corruption == 'loss':
                        history['points'][0]['train_loss'] = float('nan')
                    elif corruption == 'continue':
                        receipt['stop_reason'] = 'patience'
                    else:
                        prediction = job / history['points'][0]['predictions']['path']
                        payload = json.loads(prediction.read_text()); payload['test'] = []
                        write(prediction, payload)
                        history['points'][0]['predictions'] = evidence(job, prediction)
                    # NaN intentionally written outside the trusted helper.
                    path.write_text(json.dumps(history))
                    receipt['history'] = evidence(job, path)
                self.republish(job, fixture, mutate)
                with self.assertRaises(ValueError):
                    self.audit(job, fixture)

    def test_stale_evidence_missing_receipts_and_changed_split_are_rejected(self):
        for corruption in ('stale', 'missing', 'split', 'time', 'plan'):
            with self.subTest(case=corruption), TemporaryDirectory() as directory:
                job = Path(directory)
                fixture = self.fixture(job)
                if corruption == 'stale':
                    (job / 'training/trial-one/selected-checkpoint.json').write_text('{}')
                elif corruption == 'missing':
                    fixture[3]['training_receipts'] = {}
                elif corruption == 'split':
                    fixture[1]['validation'].write_text('{}')
                elif corruption == 'time':
                    self.republish(job, fixture, lambda receipt: receipt.update(elapsed_seconds=500.))
                else:
                    plan = job / 'training/trial-one/plan.json'
                    payload = json.loads(plan.read_text()); payload['policy']['patience'] = 100
                    write(plan, payload)
                with self.assertRaises((ValueError, KeyError)):
                    self.audit(job, fixture)

    def test_journal_preserves_crashes_and_rejects_open_attempts(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            fixture = self.fixture(job)
            base_plan = json.loads((job / 'training/trial-one/plan.json').read_text())
            failed = TrainingMonitor(job, 'trial-crash', base_plan['plan'], base_plan['context'], policy=base_plan['policy'])
            failed.fail('CUDA out of memory')
            self.assertEqual(self.audit(job, fixture)['crashes'], 1)
            TrainingMonitor(job, 'trial-open', base_plan['plan'], base_plan['context'], policy=base_plan['policy'])
            with self.assertRaisesRegex(ValueError, 'Open training attempts'):
                self.audit(job, fixture)

    def test_chosen_epoch_and_stop_reason_cannot_be_self_stamped(self):
        for corruption in ('checkpoint', 'reason', 'budget'):
            with self.subTest(case=corruption), TemporaryDirectory() as directory:
                job = Path(directory)
                fixture = self.fixture(job)
                if corruption == 'checkpoint':
                    self.republish(job, fixture, lambda receipt: receipt.update(selected_epoch=3))
                elif corruption == 'reason':
                    self.republish(job, fixture, lambda receipt: receipt.update(stop_reason='manual'))
                else:
                    self.republish(job, fixture, lambda receipt: receipt.update(stop_reason='time_budget'))
                with self.assertRaises(ValueError):
                    self.audit(job, fixture)

    def test_predeclared_aliases_can_share_only_the_same_checkpoint(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            fixture = self.fixture(job)
            path = job / 'training/trial-one/plan.json'
            payload = json.loads(path.read_text())
            payload['plan']['candidate_names'] = ['Model', 'Decoder sibling']
            write(path, payload)
            plan_record = evidence(job, path)
            lines = [json.loads(line) for line in (job / 'trials.jsonl').read_text().splitlines()]
            lines[0]['plan'] = plan_record
            (job / 'trials.jsonl').write_text(''.join(json.dumps(row) + '\n' for row in lines))
            self.republish(job, fixture, lambda receipt: receipt.update(plan=plan_record))
            fixture[3]['fitted_candidates'].append('Decoder sibling')
            fixture[3]['training_receipts']['Decoder sibling'] = fixture[3]['training_receipts']['Model']
            fixture[4]['Decoder sibling'] = {'name': 'Decoder sibling', 'method': 'same_model'}
            fixture[2]['feature_parameters']['same_model'] = {'value': 2}
            self.assertEqual(len(self.audit(job, fixture)['candidates']), 2)
            fixture[2]['feature_parameters']['same_model'] = {'value': 3}
            with self.assertRaisesRegex(ValueError, 'selected validation checkpoint'):
                self.audit(job, fixture)

    def test_patience_stops_without_rejecting_rising_validation_loss(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            fixture = self.fixture(job)
            settings, manifests, result, evaluation, eligible = fixture
            plan_envelope = json.loads((job / 'training/trial-one/plan.json').read_text())
            plan = {**plan_envelope['plan'], 'max_epochs': 100}
            clock = [0.]
            monitor = TrainingMonitor(job, 'patience-trial', plan, plan_envelope['context'],
                                      policy=policy_for(settings), clock=lambda: clock[0])
            for epoch in range(1, 12):
                clock[0] = float(epoch)
                stop = monitor.observe(train_loss=1 / epoch, validation_loss=float(epoch),
                    validation_score=1. if epoch == 1 else 0.,
                    validation_predictions={'validation': [['close', 3.], ['open', 5.]] if epoch == 1 else []},
                    parameters={'value': epoch})
            self.assertTrue(stop)
            record = monitor.finish()
            evaluation['training_receipts']['Model'] = record
            result['feature_parameters']['state_model'] = {'value': 1}
            audited = self.audit(job, fixture)['candidates']['Model']
            self.assertEqual(audited['stop_reason'], 'patience')
            self.assertEqual(audited['selected_epoch'], 1)
            self.assertTrue(audited['possible_overfitting'])

    def test_time_budget_may_expire_between_epochs(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            fixture = self.fixture(job)
            settings, _, result, evaluation, _ = fixture
            envelope = json.loads((job / 'training/trial-one/plan.json').read_text())
            clock = [0.]
            monitor = TrainingMonitor(job, 'time-trial', {**envelope['plan'], 'max_epochs': 100},
                                      envelope['context'], policy=policy_for(settings), clock=lambda: clock[0])
            clock[0] = 1.
            monitor.observe(train_loss=.4, validation_loss=.5, validation_score=1.,
                validation_predictions={'validation': [['close', 3.], ['open', 5.]]}, parameters={'value': 9})
            clock[0] = 300.
            self.assertFalse(monitor.can_start_epoch())
            evaluation['training_receipts']['Model'] = monitor.finish()
            result['feature_parameters']['state_model'] = {'value': 9}
            self.assertEqual(self.audit(job, fixture)['candidates']['Model']['stop_reason'], 'time_budget')


if __name__ == '__main__':
    unittest.main()

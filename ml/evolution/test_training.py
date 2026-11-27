"""Synthetic training traces exercise selection/stopping without fitting real data."""

from dataclasses import asdict
import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest
from unittest.mock import patch

from .training import TrainingMonitor, TrainingPolicy, evidence, policy_for


class Clock:
    def __init__(self):
        self.now = 100.

    def __call__(self):
        return self.now


class TrainingMonitorTests(unittest.TestCase):
    def plan(self, *, epochs=3, kind='iterative'):
        return {'candidate_name': 'Synthetic model', 'kind': kind,
                'seed': 7,
                'hypothesis': 'Reduced capacity improves held-out jaw events.',
                'objective': 'Weighted binary cross-entropy',
                'capacity': 'Two features and a scalar readout.',
                'regularization': 'Declared small capacity; no extra penalty.',
                'resources': {'device': 'synthetic CPU', 'threads': 1},
                'max_epochs': epochs, 'selection_decoder': {'threshold': .5}}

    def monitor(self, directory, **kwargs):
        return TrainingMonitor(directory, 'trial', kwargs.pop('plan', self.plan()),
                               {'train_manifest_sha256': 'a' * 64,
                                'validation_manifest_sha256': 'b' * 64}, **kwargs)

    def record(self, monitor, score, loss=.5, value=1, artifacts=()):
        return monitor.observe(train_loss=.1, validation_loss=loss,
                               validation_score=score,
                               validation_predictions={'held-out-clip': [['close', 3.1], ['open', 5.1]]},
                               parameters={'weight': value}, artifacts=artifacts)

    def test_exports_validation_winner_instead_of_final_epoch(self):
        with TemporaryDirectory() as directory:
            with self.monitor(directory) as monitor:
                self.assertFalse(self.record(monitor, .5, value=1))
                self.assertFalse(self.record(monitor, .9, value=2))
                self.assertTrue(self.record(monitor, .7, value=3))
                record = monitor.finish()
                self.assertEqual(monitor.selected_checkpoint()['parameters'], {'weight': 2})
                receipt = json.loads((Path(directory) / record['path']).read_text())
                self.assertEqual(receipt['selected_epoch'], 2)
                self.assertEqual(receipt['trained_epochs'], 3)
                self.assertEqual(receipt['stop_reason'], 'max_epochs')
                history = json.loads((Path(directory) / receipt['history']['path']).read_text())
                self.assertEqual(len(history['points']), 3)
                self.assertEqual(evidence(directory, Path(directory) / record['path']), record)
                log = [json.loads(line) for line in (Path(directory) / 'trials.jsonl').read_text().splitlines()]
                self.assertEqual([row['status'] for row in log], ['started', 'completed'])

    def test_task_score_precedes_loss_and_earliest_epoch_breaks_exact_ties(self):
        with TemporaryDirectory() as directory:
            monitor = self.monitor(directory, plan=self.plan(epochs=4))
            self.record(monitor, .9, .8, value=1)
            self.record(monitor, .8, .1, value=2)
            self.record(monitor, .9, .7, value=3)
            self.record(monitor, .9, .7, value=4)
            monitor.finish()
            self.assertEqual(monitor.selected_checkpoint()['epoch'], 3)

    def test_invalid_prediction_shapes_fail_before_an_epoch_is_saved(self):
        for predictions in ([], [[['close', 3.1]]], None, 'events', {},
                            {'': []}, {'  ': []}, {1: []}):
            with self.subTest(predictions=predictions), TemporaryDirectory() as directory:
                with self.monitor(directory, plan=self.plan(epochs=1)) as monitor:
                    with self.assertRaisesRegex(ValueError, 'keyed by example/clip ID'):
                        monitor.observe(train_loss=.1, validation_loss=.2,
                                        validation_score=.8,
                                        validation_predictions=predictions,
                                        parameters={'weight': 1})
                    self.assertEqual(monitor.points, [])
                    self.assertIsNone(monitor.best)
                    self.assertFalse((monitor.directory / 'validation-0001.json').exists())
                    self.assertFalse((monitor.directory / 'history.json').exists())
                    self.assertFalse((monitor.directory / 'selected-checkpoint.json').exists())
                    # The author can correct the format in the same fit/allocation.
                    self.record(monitor, .8)
                    monitor.finish()

    def test_patience_ignores_loss_only_improvements_and_tiny_score_gains(self):
        with TemporaryDirectory() as directory:
            monitor = self.monitor(directory, plan=self.plan(epochs=100),
                                   policy=asdict(TrainingPolicy(patience=2, min_epochs=3)))
            self.assertFalse(self.record(monitor, .8, .5))
            self.assertFalse(self.record(monitor, .8001, .4))
            self.assertTrue(self.record(monitor, .8002, .3))
            receipt = json.loads((Path(directory) / monitor.finish()['path']).read_text())
            self.assertEqual(receipt['stop_reason'], 'patience')
            self.assertEqual(receipt['selected_epoch'], 3)
            self.assertFalse(monitor.can_start_epoch())
            with self.assertRaises(ValueError):
                self.record(monitor, .9)

    def test_time_budget_stops_at_epoch_boundary_or_before_next_epoch(self):
        for observed_after_budget in (True, False):
            with self.subTest(observed_after_budget=observed_after_budget), TemporaryDirectory() as directory:
                clock = Clock()
                monitor = self.monitor(directory, plan=self.plan(epochs=100), clock=clock,
                                       policy=asdict(TrainingPolicy(max_seconds=2)))
                self.assertTrue(monitor.can_start_epoch())
                if observed_after_budget:
                    clock.now += 2
                    self.assertTrue(self.record(monitor, .5))
                else:
                    self.record(monitor, .5)
                    clock.now += 2
                    self.assertFalse(monitor.can_start_epoch())
                receipt = json.loads((Path(directory) / monitor.finish()['path']).read_text())
                self.assertEqual(receipt['stop_reason'], 'time_budget')

    def test_long_epoch_lookahead_reserves_finalization_without_inventing_epochs(self):
        with TemporaryDirectory() as directory:
            clock = Clock()
            monitor = self.monitor(directory, plan=self.plan(epochs=100), clock=clock)
            # The first measurement includes substantial input preparation;
            # later epochs actually cost about sixteen seconds each.
            times = [217.878, 233.851, 250.129, 266.635, 283.215]
            for elapsed in times:
                self.assertTrue(monitor.can_start_epoch())
                clock.now = monitor.started + elapsed
                self.record(monitor, .5)
            self.assertFalse(monitor.can_start_epoch())
            self.assertEqual(monitor.stop_reason, 'epoch_budget')
            clock.now += .1
            receipt = json.loads((Path(directory) / monitor.finish()['path']).read_text())
            self.assertEqual(receipt['trained_epochs'], 5)
            self.assertLess(receipt['elapsed_seconds'], 300.)
            guard = receipt['epoch_admission_stop']
            self.assertEqual(len(guard['observed_epoch_intervals_seconds']), 3)
            self.assertLess(guard['predicted_epoch_seconds'], 22.)
            self.assertEqual(len(monitor.points), 5)
            with self.assertRaises(ValueError):
                self.record(monitor, .9)

    def test_lookahead_accounts_for_a_recent_slow_epoch(self):
        from .epoch_admission import budget_stop
        points = [{'elapsed_seconds': t} for t in (100., 110., 120., 180.)]
        guard = budget_stop(points, 230., 300.)
        self.assertEqual(guard['predicted_epoch_seconds'], 75.)
        self.assertIsNone(budget_stop(points, 200., 300.))
        self.assertIsNone(budget_stop(points[:1], 200., 300.))
        with self.assertRaises(ValueError):
            budget_stop(points, 170., 300.)

    def test_context_failure_and_unfinished_trial_preserve_failure_journal(self):
        for fail_explicitly in (True, False):
            with self.subTest(fail_explicitly=fail_explicitly), TemporaryDirectory() as directory:
                with self.assertRaises(RuntimeError):
                    with self.monitor(directory) as monitor:
                        self.record(monitor, .5)
                        if fail_explicitly:
                            raise RuntimeError('synthetic fitting failure')
                log = [json.loads(line) for line in (Path(directory) / 'trials.jsonl').read_text().splitlines()]
                self.assertEqual([row['status'] for row in log], ['started', 'crash'])
                self.assertTrue(monitor.closed)
                self.assertFalse(monitor.can_start_epoch())

    def test_noniterative_fits_have_checkpoint_without_fake_epochs(self):
        with TemporaryDirectory() as directory:
            monitor = self.monitor(directory, plan=self.plan(kind='noniterative'))
            with self.assertRaises(ValueError):
                self.record(monitor, .5)
            record = monitor.finish(parameters={'ridge_projection': [1, 2]})
            receipt = json.loads((Path(directory) / record['path']).read_text())
            self.assertIsNone(receipt['history'])
            self.assertIsNone(receipt['selected_epoch'])
            self.assertEqual(receipt['trained_epochs'], 0)
            self.assertEqual(receipt['stop_reason'], 'noniterative_complete')

    def test_empty_exception_messages_preserve_failure_type_and_partial_evidence(self):
        for error in (KeyboardInterrupt(), RuntimeError(), ValueError('  ')):
            with self.subTest(error=type(error).__name__), TemporaryDirectory() as directory:
                with self.assertRaises(type(error)):
                    with self.monitor(directory) as monitor:
                        self.record(monitor, .5)
                        raise error
                rows = [json.loads(line) for line in (Path(directory) / 'trials.jsonl').read_text().splitlines()]
                self.assertEqual([row['status'] for row in rows], ['started', 'crash'])
                self.assertIn(type(error).__name__, rows[-1]['reason'])
                self.assertTrue(rows[-1]['reason'].strip())
                self.assertTrue((monitor.directory / 'history.json').exists())
                self.assertTrue((monitor.directory / 'selected-checkpoint.json').exists())

    def test_keyboard_interrupt_while_waiting_for_fit_slot_is_not_a_blank_failure(self):
        with TemporaryDirectory() as directory:
            with patch('ml.evolution.training.fitting_settings', return_value=2), patch(
                    'ml.evolution.training.FittingLease.acquire', side_effect=KeyboardInterrupt()):
                with self.assertRaises(KeyboardInterrupt):
                    self.monitor(directory)
            row = json.loads((Path(directory) / 'trials.jsonl').read_text().splitlines()[-1])
            self.assertEqual(row['status'], 'crash')
            self.assertEqual(row['reason'], 'KeyboardInterrupt (no exception message)')

    def test_opaque_weights_preserved_and_mutation_or_escape_is_rejected(self):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            opaque = root / 'framework-weights.pt'
            opaque.write_bytes(b'synthetic opaque tensor checkpoint')
            monitor = self.monitor(root, plan=self.plan(epochs=1))
            self.record(monitor, .5, artifacts=['framework-weights.pt'])
            self.assertEqual(monitor.selected_checkpoint()['artifacts'], [evidence(root, opaque)])
            opaque.write_bytes(b'changed weights')
            with self.assertRaisesRegex(ValueError, 'changed'):
                monitor.finish()
            monitor.fail('Weights changed after validation selection')
            outside = root.parent / (root.name + '-outside.pt')
            outside.write_bytes(b'synthetic outside file')
            try:
                with self.assertRaisesRegex(ValueError, 'inside'):
                    evidence(root, outside)
            finally:
                outside.unlink()

    def test_invalid_policy_plan_context_and_measurements_are_rejected(self):
        for update in ({'max_seconds': float('inf')}, {'max_seconds': -1}, {'patience': True},
                       {'min_epochs': 0}, {'min_delta': 0}, {'min_delta': float('nan')}):
            with self.subTest(policy=update), self.assertRaises(ValueError):
                TrainingPolicy(**update)
        self.assertEqual(policy_for({'agent_minutes': 1})['max_seconds'], 60.)
        self.assertEqual(policy_for({'agent_minutes': 30})['max_seconds'], 300.)
        with self.assertRaises(ValueError):
            policy_for({'agent_minutes': True})
        for update in ({'kind': 'fake'}, {'hypothesis': ''}, {'resources': {'device': 'cpu', 'threads': 0}},
                       {'max_epochs': True}, {'selection_decoder': None}, {'seed': -1},
                       {'seed': True}, {'seed': None}):
            with self.subTest(plan=update), TemporaryDirectory() as directory:
                plan = self.plan(); plan.update(update)
                with self.assertRaises(ValueError):
                    self.monitor(directory, plan=plan)
        with TemporaryDirectory() as directory:
            with self.assertRaises(ValueError):
                TrainingMonitor(directory, '../escape', self.plan(), {})
            monitor = self.monitor(directory)
            for field, value in [('train_loss', float('nan')), ('validation_loss', -1),
                                 ('validation_score', 1.01), ('validation_score', True)]:
                kwargs = dict(train_loss=.1, validation_loss=.2, validation_score=.8,
                              validation_predictions={}, parameters={'weight': 1})
                kwargs[field] = value
                with self.subTest(field=field, value=value), self.assertRaises(ValueError):
                    monitor.observe(**kwargs)
            monitor.fail('Invalid values exercise')

    def test_frozen_plan_history_predictions_and_checkpoint_cannot_change_before_finish(self):
        for target in ('plan.json', 'history.json', 'validation-0001.json', 'selected-checkpoint.json'):
            with self.subTest(target=target), TemporaryDirectory() as directory:
                monitor = self.monitor(directory, plan=self.plan(epochs=1))
                self.record(monitor, .5)
                (monitor.directory / target).write_text('{}')
                with self.assertRaisesRegex(ValueError, 'changed'):
                    monitor.finish()
                monitor.fail('Mutated evidence exercise')

    def test_clock_must_be_finite_and_monotonic(self):
        with TemporaryDirectory() as directory:
            clock = Clock()
            monitor = self.monitor(directory, clock=clock)
            self.record(monitor, .5)
            clock.now -= 1
            with self.assertRaises(ValueError):
                monitor.can_start_epoch()
            clock.now = float('nan')
            with self.assertRaises(ValueError):
                self.record(monitor, .6)
            monitor.fail('Invalid clock exercise')

    def test_aliases_are_predeclared_unique_and_include_the_primary_candidate(self):
        for aliases in ([], ['another'], ['Synthetic model', 'Synthetic model'],
                        ['Synthetic model', ''], 'Synthetic model', [None]):
            with self.subTest(aliases=aliases), TemporaryDirectory() as directory:
                plan = self.plan(); plan['candidate_names'] = aliases
                with self.assertRaisesRegex(ValueError, 'aliases'):
                    self.monitor(directory, plan=plan)
        with TemporaryDirectory() as directory:
            plan = self.plan(kind='noniterative')
            plan['candidate_names'] = ['Synthetic model', 'Alternate decoder']
            monitor = self.monitor(directory, plan=plan)
            monitor.finish(parameters={'shared_model': [1, 2]})
            saved = json.loads((monitor.directory / 'plan.json').read_text())
            self.assertEqual(saved['plan']['candidate_names'], plan['candidate_names'])

    def test_seed_is_explicit_and_null_only_for_deterministic_noniterative_fits(self):
        with TemporaryDirectory() as directory:
            plan = self.plan(); del plan['seed']
            with self.assertRaisesRegex(ValueError, 'seed'):
                self.monitor(directory, plan=plan)
            plan = self.plan(kind='noniterative'); plan['seed'] = None
            monitor = self.monitor(directory, plan=plan)
            monitor.finish(parameters={'deterministic_fit': [1, 2]})


if __name__ == '__main__':
    unittest.main()

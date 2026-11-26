"""Portfolio knobs must affect real admission and resist forged clip coverage."""

from copy import deepcopy
from dataclasses import asdict
import unittest

from dashboard_selection import (PROTOCOL, portfolio_for_settings, selection_parameters,
                                 select_evaluated, verify_selection)
from run_joint_round import JointCandidate
import round_one


class SelectionTests(unittest.TestCase):
    def settings(self, **changes):
        return {'pool_size': 3, 'protected_slots': 3, 'mutation_attempts': 3, 'family_limit': 3,
                'selection_protocol': PROTOCOL, 'match_seconds': .5, **changes}

    def entry(self, name, fitness, *, method='imu', parent=None, f1=.8):
        return {'candidate': asdict(JointCandidate(name, method, .2, parent=parent)),
                'fitness': fitness, 'development': {'f1': f1, 'false_positives': 0, 'missed': 1},
                'clip_f1': [f1, f1], 'worst_clip_accuracy': f1, 'zero_jaw_clips': 0}

    def test_factory_applies_requested_settings_and_effective_bounds(self):
        settings = self.settings(pool_size=2, protected_slots=9, family_limit=10, mutation_attempts=7)
        policy = selection_parameters(settings)
        self.assertEqual(policy['requested']['protected_slots'], 9)
        self.assertEqual(policy['effective']['protected_slots'], 1)
        self.assertEqual(policy['effective']['family_limit'], 2)
        portfolio = portfolio_for_settings(settings)
        self.assertEqual((portfolio.protected_slots, portfolio.family_limit, portfolio.mutation_attempts), (1, 2, 7))
        for changes in ({'protected_slots': True}, {'protected_slots': 10},
                        {'mutation_attempts': 0}, {'family_limit': 0}):
            with self.subTest(changes=changes), self.assertRaises(ValueError):
                selection_parameters(self.settings(**changes))

    def test_disabled_reduced_or_expired_protection_does_not_pin_old_lanes(self):
        parents = [self.entry('champion', .9), self.entry('strong', .8), self.entry('weak', .1)]
        prior = {'protected': [{'name': 'weak', 'root': 'weak', 'attempts': 1}]}
        protected = select_evaluated(parents, [], prior, self.settings(pool_size=2))
        self.assertIn('weak', [candidate['name'] for candidate in protected['next_pool']])
        for changes in ({'protected_slots': 0}, {'mutation_attempts': 1}):
            actual = select_evaluated(parents, [], prior, self.settings(pool_size=2, **changes))
            self.assertEqual([candidate['name'] for candidate in actual['next_pool']], ['champion', 'strong'])
            self.assertEqual(actual['protected'], [])
        one = select_evaluated(parents, [], prior, self.settings(pool_size=1))
        self.assertEqual(len(one['next_pool']), 1)
        self.assertEqual(one['protected'], [])

    def test_available_count_and_trimmed_lanes_cannot_overfill_or_exhaust_pool(self):
        parents = [self.entry('champion', .9), self.entry('weak', .1)]
        prior = {'protected': [{'name': name, 'root': name, 'attempts': 0} for name in ('weak', 'champion')]}
        reduced = select_evaluated(parents, [], prior, self.settings(pool_size=1))
        self.assertEqual(len(reduced['next_pool']), 1)
        available = select_evaluated(parents, [], prior, self.settings(pool_size=10))
        self.assertEqual(len(available['next_pool']), 2)
        self.assertEqual(available['selection_policy']['effective']['pool_size'], 2)

    def test_reviewed_family_controls_new_protection_and_soft_cap(self):
        parents = [self.entry('champion', .9), self.entry('same-two', .8),
                   self.entry('same-three', .7), self.entry('other', .3)]
        metadata = {entry['candidate']['name']: {'family': 'MLP' if index < 3 else 'Geometry'}
                    for index, entry in enumerate(parents)}
        prior = {'candidate_metadata': metadata}
        diverse = select_evaluated(parents, [], prior, self.settings(protected_slots=0, family_limit=1))
        crowded = select_evaluated(parents, [], prior, self.settings(protected_slots=0, family_limit=3))
        self.assertIn('other', [candidate['name'] for candidate in diverse['next_pool']])
        self.assertNotIn('other', [candidate['name'] for candidate in crowded['next_pool']])
        ideas = [self.entry('familiar', .6, method='new_a'), self.entry('novel', .2, method='new_b')]
        new_meta = {'familiar': {'family': 'mlp'}, 'novel': {'family': 'Convolutional'}}
        chosen = select_evaluated(parents, ideas, prior, self.settings(), new_meta)
        self.assertEqual(chosen['protected'][0]['name'], 'novel')
        with self.assertRaisesRegex(ValueError, 'Incumbent family'):
            select_evaluated(parents, ideas, prior, self.settings(), {'champion': {'family': 'new'}})
        padded = select_evaluated(parents, ideas, prior, self.settings(),
                                 {'familiar': {'family': '  mLp  '}, 'novel': {'family': 'Convolutional'}})
        self.assertEqual(padded['protected'][0]['name'], 'novel')
        with self.assertRaisesRegex(ValueError, 'Incumbent family'):
            select_evaluated([parents[0]], [], {}, self.settings(), {'champion': {'family': 'invented'}})

    def fixture(self):
        rows = [{'clip': name, 'jaw_reference': {'close': 3., 'open': 5.}} for name in ('a', 'b')]
        predictions = {'champion': {name: [['close', 3.], ['open', 5.]] for name in ('a', 'b')},
                       'weaker': {name: [['close', 3.]] for name in ('a', 'b')}}
        entries = []
        for name in predictions:
            per = [round_one.accuracy([predictions[name][row['clip']]], [row['jaw_reference']]) for row in rows]
            metrics = round_one.accuracy([predictions[name][row['clip']] for row in rows], [row['jaw_reference'] for row in rows])
            entries.append({'candidate': asdict(JointCandidate(name, 'imu', .2)), 'fitness': metrics['f1'],
                            'development': metrics, 'clip_f1': [item['f1'] for item in per],
                            'worst_clip_accuracy': min(round_one.precision_weighted_accuracy(item) for item in per),
                            'zero_jaw_clips': sum(item['matched'] == 0 for item in per)})
        settings = self.settings(pool_size=1)
        result = {'incumbents': entries, 'challengers': [], **select_evaluated(entries, [], {}, settings)}
        return result, {}, settings, rows, predictions

    def test_independent_replay_accepts_measured_selection(self):
        audit = verify_selection(*self.fixture())
        self.assertTrue(audit['coverage_verified'])
        self.assertEqual(audit['candidates_evaluated'], 2)

    def test_forged_clip_metrics_and_admission_are_rejected(self):
        for field in ('clip_f1', 'worst_clip_accuracy', 'zero_jaw_clips', 'next_pool', 'protected', 'roles', 'selection_policy'):
            with self.subTest(field=field):
                result, prior, settings, rows, predictions = deepcopy(self.fixture())
                if field == 'clip_f1':
                    result['incumbents'][0][field] = [0., 0.]
                elif field == 'worst_clip_accuracy':
                    result['incumbents'][0][field] = 0.
                elif field == 'zero_jaw_clips':
                    result['incumbents'][0][field] = 2
                elif field == 'next_pool':
                    result[field] = [result['incumbents'][1]['candidate']]
                else:
                    result[field] = {} if field != 'protected' else [{'name': 'forged'}]
                with self.assertRaises(ValueError):
                    verify_selection(result, prior, settings, rows, predictions)


if __name__ == '__main__':
    unittest.main()

"""Comparable data-loss diagnostics must not change with arbitrary weight scale."""

import math
import unittest

from ml.evolution.losses import binary_data_loss


class ComparableLossTests(unittest.TestCase):
    def test_weighted_mean_and_mass_are_explicit_and_scale_invariant(self):
        a = binary_data_loss([0, 1], [.25, .5], [1, 3])
        b = binary_data_loss([0, 1], [.25, .5], [10, 30])
        self.assertAlmostEqual(a['value'], (-math.log(.75) - 3 * math.log(.5)) / 4)
        self.assertEqual(a['weight_sum'], 4.)
        self.assertEqual(a['examples'], 2)
        self.assertAlmostEqual(a['value'], b['value'])
        self.assertAlmostEqual(a['weighted_loss_sum'] * 10, b['weighted_loss_sum'])

    def test_split_length_and_zero_weight_do_not_change_identical_predictions(self):
        train = binary_data_loss([0, 1], [.2, .8], [1, 2])
        val = binary_data_loss([0, 1, 0, 1], [.2, .8, .2, .8], [7, 14, 7, 14])
        self.assertAlmostEqual(train['value'], val['value'])
        self.assertAlmostEqual(binary_data_loss([0, 1], [1, 1], [0, 1])['value'],
                               binary_data_loss([1], [1])['value'])

    def test_invalid_shapes_labels_probabilities_weights_and_epsilon_fail(self):
        for labels, probabilities, weights in (
                ([], [], None), ([0], [.5, .5], None), ([.2], [.5], None),
                ([0], [float('nan')], None), ([0], [1.1], None),
                ([0], [.5], [-1]), ([0], [.5], [0]), ([0], [.5], [float('inf')]),
                ([0], [.5], [1, 2])):
            with self.subTest(labels=labels, probabilities=probabilities, weights=weights):
                with self.assertRaises(ValueError):
                    binary_data_loss(labels, probabilities, weights)
        for epsilon in (0, .5, float('nan'), True):
            with self.subTest(epsilon=epsilon), self.assertRaises(ValueError):
                binary_data_loss([0], [.5], epsilon=epsilon)

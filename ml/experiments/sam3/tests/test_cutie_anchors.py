import unittest

import numpy as np

from sam3_lab.benchmark_cutie import anchor_gaps, choose_gap_mask, gap_seed_indices, one_second_samples, parse_args


class CutieAnchorTests(unittest.TestCase):
    def test_anchor_policy_default_and_override(self):
        base = ['reference.json', '--source', 'source', '--deps', 'deps', '--weights', 'weights', '--output', 'out']
        self.assertIsNone(parse_args(base).anchor_policy)  # Reviewed-seed control is unchanged.
        fresh = base + ['--sam-prompt', 'yarn']
        self.assertEqual(parse_args(fresh).anchor_policy, 'forward-after-first')
        self.assertEqual(parse_args(fresh + ['--anchor-policy', 'bidirectional']).anchor_policy, 'bidirectional')

    def test_samples_whole_source_seconds(self):
        self.assertEqual(one_second_samples(np.arange(249) / 30), list(range(0, 249, 30)))
        self.assertEqual(one_second_samples([0., .7, 1.1, 1.9, 2.2]), [0, 2, 4])

    def test_gaps_cover_nonanchors_once(self):
        gaps = [(left, right, list(frames)) for left, right, frames in anchor_gaps(10, [7, 3, 4])]
        self.assertEqual(gaps, [(None, 3, [0, 1, 2]), (4, 7, [5, 6]), (7, None, [8, 9])])
        self.assertEqual(list(anchor_gaps(3, [])), [(None, None, range(3))])

    def test_choose_nearer_mask_without_merging_disagreement(self):
        forward = np.array([[True, False]])
        backward = np.array([[False, True]])
        mask, direction, agreement = choose_gap_mask(2, 0, 4, forward, backward)
        np.testing.assert_array_equal(mask, forward)
        self.assertEqual((direction, agreement), ('forward', 0.0))
        mask, direction, _ = choose_gap_mask(3, 0, 4, forward, backward)
        np.testing.assert_array_equal(mask, backward)
        self.assertEqual(direction, 'backward')

    def test_single_direction_and_both_empty(self):
        empty = np.zeros((2, 2), dtype=bool)
        self.assertEqual(choose_gap_mask(0, None, 2, None, empty)[1:], ('backward', None))
        self.assertEqual(choose_gap_mask(1, 0, 2, empty, empty)[1:], ('forward', 1.0))

    def test_forward_after_first_backfills_only_prefix(self):
        policy = 'forward-after-first'
        self.assertEqual(gap_seed_indices(None, 30, policy), (None, 30))
        self.assertEqual(gap_seed_indices(30, 60, policy), (30, None))
        self.assertEqual(gap_seed_indices(180, None, policy), (180, None))
        self.assertEqual(gap_seed_indices(None, None, policy), (None, None))
        self.assertEqual(gap_seed_indices(30, 60, 'bidirectional'), (30, 60))


if __name__ == '__main__':
    unittest.main()

import unittest

import numpy as np
import torch

from sam3_lab.flow_experiment import consistency, dice, metrics, warp


class FlowTests(unittest.TestCase):
    def test_subpixel_motion_accumulates_without_thresholding(self):
        mask = torch.zeros((8, 8))
        mask[2:4, 2:4] = 1
        back = torch.zeros((2, 8, 8))
        back[0] = -.4
        first, _, _ = warp(mask, back, binary=False)
        second, _, _ = warp(first, back, binary=False)
        expected = torch.zeros((8, 8), dtype=torch.bool)
        expected[2:4, 3:5] = True
        self.assertTrue(torch.equal(second >= .5, expected))

    def test_pull_warp_direction(self):
        mask = torch.zeros((8, 8), dtype=torch.bool)
        mask[2:4, 2:4] = True
        back = torch.zeros((2, 8, 8))
        back[0] = -1
        moved, valid, _ = warp(mask, back)
        expected = torch.zeros_like(mask)
        expected[2:4, 3:5] = True
        self.assertTrue(torch.equal(moved, expected))
        self.assertFalse(valid[:, 0].any())

    def test_consistency_samples_backward_at_forward_endpoint(self):
        mask = torch.zeros((8, 8), dtype=torch.bool)
        mask[2:4, 2:4] = True
        forward = torch.zeros((2, 8, 8))
        forward[0] = 1
        back = -forward
        self.assertEqual(consistency(mask, forward, back, .1)['bad_fraction'], 0)
        self.assertEqual(consistency(mask, forward, torch.zeros_like(back), .1)['bad_fraction'], 1)

    def test_empty_masks_do_not_inflate_visible_dice(self):
        blank = np.zeros((8, 8), bool)
        self.assertIsNone(dice(blank, blank))
        result = metrics([{'dice': .5, 'reference_pixels': 10, 'predicted_pixels': 10},
                          {'dice': None, 'reference_pixels': 0, 'predicted_pixels': 0}])
        self.assertEqual(result['mean_visible_dice'], .5)
        self.assertEqual(result['empty_reference_false_positive_frames'], 0)


if __name__ == '__main__':
    unittest.main()

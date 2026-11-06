import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from sam3_lab import viewer


class ViewerTrackingTests(unittest.TestCase):
    def test_upload_uses_forward_policy_without_reference_masks(self):
        result = {'accepted_anchor_frames': [30], 'frames': [None] * 31,
                  'sam_attempts': [None] * 2, 'total_wall_seconds': 12.0}
        with tempfile.TemporaryDirectory() as directory, patch.object(viewer, 'OUTPUT_ROOT', Path(directory)), \
                patch('sam3_lab.benchmark_cutie.run', return_value=result) as run:
            video, report, status = viewer.predict_tracked_video('clip.mov', ' yarn ', .5, progress=None)
            args = run.call_args.args[0]
            self.assertIsNone(args.reference)
            self.assertEqual(args.video, Path('clip.mov'))
            self.assertEqual(args.sam_prompt, 'yarn')
            self.assertEqual(args.anchor_policy, 'forward-after-first')
            self.assertEqual(Path(video), args.output / 'segmented.mp4')
            self.assertEqual(Path(report), args.output / 'results.json')
            self.assertIn('1/2 usable anchors', status)

    def test_no_anchor_is_reported_as_needing_review(self):
        result = {'accepted_anchor_frames': [], 'frames': [None],
                  'sam_attempts': [None], 'total_wall_seconds': 2.0}
        with patch('sam3_lab.benchmark_cutie.run', return_value=result):
            _, _, status = viewer.predict_tracked_video('clip.mov', 'yarn', .5, progress=None)
            self.assertIn('No usable anchor', status)

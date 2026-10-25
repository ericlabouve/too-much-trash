import unittest

from sam3_lab.benchmark_tracker import summarize


class TrackerBenchmarkTests(unittest.TestCase):
    def test_seed_initialization_is_not_steady_state(self):
        frames = [
            {'seed_frame': True, 'model_seconds': 50, 'processed_frame_seconds': 60},
            {'seed_frame': False, 'model_seconds': 2, 'processed_frame_seconds': 3},
            {'seed_frame': False, 'model_seconds': 4, 'processed_frame_seconds': 5},
        ]
        result = summarize(frames)
        self.assertEqual(result['tracked_frames'], 2)
        self.assertEqual(result['model_seconds'], 6)
        self.assertAlmostEqual(result['model_fps'], 1 / 3)
        self.assertEqual(result['processed_frame_fps'], 0.25)
        self.assertEqual(result['median_model_seconds'], 3)

    def test_no_tracking_results_yet(self):
        self.assertEqual(summarize([]), {})
        self.assertEqual(summarize([{'seed_frame': True}]), {})


if __name__ == '__main__':
    unittest.main()

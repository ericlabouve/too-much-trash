"""A bounded diagnostic must never publish an unreviewed pool."""

from dataclasses import asdict
import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest
from unittest.mock import patch

from dashboard_round import DEFAULTS, execute
from run_joint_round import JointCandidate


class DiagnosticPublicationTests(unittest.TestCase):
    def test_full_scope_diagnostic_preserves_official_checkpoint(self):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            job, dashboard = root / 'job', root / 'dashboard'
            job.mkdir()
            dashboard.mkdir()
            progress = dashboard / 'progress.json'
            progress.write_text('{"round":50}')
            candidate = asdict(JointCandidate('baseline', 'imu', .2))
            prior = root / 'prior.json'
            prior.write_text(json.dumps({'round': 50, 'next_pool': [candidate],
                                         'feature_parameters': {}, 'seen': []}))
            settings = {**DEFAULTS, 'pool_size': 1}
            config = job / 'config.json'
            config.write_text(json.dumps({'settings': settings, 'prior': str(prior), 'dashboard': str(dashboard)}))
            imu = root / 'imu.jsonl'
            imu.write_text('')
            record = {'video': str(root / 'video.mp4'), 'imu': str(imu),
                      'poses': str(root / 'poses.jsonl'), 'episode_start': 0,
                      'jaw_reference': {'close': 3., 'open': 4.}}
            winner = {'candidate': candidate, 'fitness': .2, 'development': {'f1': 0.}, 'p95_ms': .1}
            with patch('dashboard_round.build_split_manifest', return_value={'counts': {'train': 1}, 'splits': {'train': [record]}}), \
                 patch('dashboard_round.load_frames', return_value=[]), \
                 patch('dashboard_round.motion_samples', return_value=[]), \
                 patch('dashboard_round.pose_samples', return_value=[]), \
                 patch('dashboard_round.run_round', return_value={'ranked': [winner], 'next_pool': [candidate]}):
                execute(config)
            self.assertEqual(progress.read_text(), '{"round":50}')
            self.assertFalse((root / 'dashboard-current.json').exists())
            self.assertTrue(json.loads((job / 'status.json').read_text())['result']['subset'])


if __name__ == '__main__':
    unittest.main()

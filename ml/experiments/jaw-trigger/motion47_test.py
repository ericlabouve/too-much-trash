import unittest

import cv2
import numpy as np

from motion47 import AR_TO_OPTICAL, foreground_weights, pose_at


class PoseCompensationTests(unittest.TestCase):
    def setUp(self):
        self.rng = np.random.default_rng(334)
        self.image = self.rng.uniform(25, 225, (240, 320)).astype(np.float32)
        self.camera = np.array([[210.0, 0, 160], [0, 210.0, 120], [0, 0, 1]])
        self.old_pose = np.eye(3), np.zeros(3), self.camera

    def test_camera_attached_texture_survives_world_translation(self):
        shift = np.float32([[1, 0, -10.5], [0, 1, 0]])
        current = cv2.warpAffine(self.image, shift, (320, 240))
        hardware = self.rng.uniform(25, 225, (40, 19)).astype(np.float32)
        self.image[135:175, 165:184] = current[135:175, 165:184] = hardware
        new_pose = np.eye(3), np.array([.05 / .75, 0, 0]), self.camera

        weights = foreground_weights(self.image, current, self.old_pose, new_pose)

        self.assertGreater(weights[38:63, 22:29].mean(), .9)
        self.assertLess(weights[3:17, 5:32].mean(), .45)

    def test_optical_yaw_agrees_with_arkit_convention(self):
        sine, cosine = np.sin(.05), np.cos(.05)
        yaw = np.array([[cosine, 0, sine], [0, 1, 0], [-sine, 0, cosine]])
        transform = self.camera @ yaw @ np.linalg.inv(self.camera)
        current = cv2.warpPerspective(self.image, transform, (320, 240),
                                      flags=cv2.INTER_LINEAR | cv2.WARP_INVERSE_MAP)
        new_pose = AR_TO_OPTICAL @ yaw @ AR_TO_OPTICAL, np.zeros(3), self.camera

        weights = foreground_weights(self.image, current, self.old_pose, new_pose)

        self.assertLess(weights[10:-10, 8:-8].mean(), .2)

    def test_pose_lookup_uses_past_samples_and_resizes_intrinsics(self):
        raw = {
            "tracking": "normal", "cameraToWorldColumns": np.eye(4).ravel().tolist(),
            "intrinsicsColumns": self.camera.T.ravel().tolist(), "imageWidth": 320, "imageHeight": 240,
        }
        times, records = (.1, .2), (raw, raw)

        self.assertIsNone(pose_at(times, records, .09, (120, 160)))
        self.assertIsNone(pose_at(times, records, .15, (120, 160)))
        _, _, scaled = pose_at(times, records, .11, (120, 160))
        np.testing.assert_array_equal(scaled, np.diag([.5, .5, 1]) @ self.camera)


if __name__ == "__main__":
    unittest.main()

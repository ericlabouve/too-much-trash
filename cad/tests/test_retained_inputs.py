"""Inventory must distinguish retained geometry inputs from routine job output."""
from pathlib import Path
import sys
import unittest

CAD = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(CAD))
import workspace_inventory as inventory


class RetainedInputClassificationTests(unittest.TestCase):
    def test_retained_geometry_inputs(self):
        paths = (
            'source/clip_current/clip.stl',
            'source/actuator_current/b-bracket.step',
            'source/actuator_current/b-plunger.step',
            'source/actuator_current/pulley_axle.step',
            'source/actuator_current/motion-paths.json',
            'print/jobs/2026-10-24-common-cuff-tpu-source/common-cuff.step',
            'print/jobs/2026-10-24-three-cuffs-thread-tpu/cuff-1-bed.stl',
            'print/jobs/2026-10-25-jaw-arm-slots-source/sliding_jaw.step',
            'print/jobs/2026-10-26-final-materials-source/shaft_cap.stl',
            'print/jobs/2026-10-26-ramped-fixed-hook-source/carrier.step',
            'print/jobs/2026-10-26-ramped-fixed-hook-source/carrier.stl',
            'print/jobs/2026-10-26-ramped-fixed-hook-source/shaft_cap.step',
            'print/jobs/2026-10-26-ramped-fixed-hook-source/shaft_cap.stl',
            'print/jobs/2026-10-30-straight-arm-clip-tpu/clip-source.stl',
            'print/sliding_jaw.stl',
            'review/concepts/closed-rail-sleeve-b/b-bracket.step',
            'review/concepts/open-mount-clear-handle-b/b-bracket.step',
            'review/concepts/open-mount-clear-handle-b/b-plunger.step',
            'review/concepts/uniform-rail-sleeve-b/b-bracket.step',
        )
        policy = inventory.load_policy()
        for relative in paths:
            with self.subTest(path=relative):
                self.assertEqual(inventory.classify('cad/versions/v3/' + relative, policy)[0],
                                 'source-geometry')

    def test_other_job_meshes_still_generated(self):
        policy = inventory.load_policy()
        for relative in (
            'print/jobs/example/model.stl',
            'print/jobs/2026-10-26-ramped-fixed-hook-source/unrelated.stl',
            'print/jobs/2026-10-24-three-cuffs-thread-tpu/other.stl',
        ):
            with self.subTest(path=relative):
                self.assertEqual(inventory.classify('cad/versions/v3/' + relative, policy)[0],
                                 'generated')


if __name__ == '__main__':
    unittest.main()

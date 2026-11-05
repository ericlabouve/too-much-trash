"""Check preview rendering against embedded 3MF geometry and placements."""
from collections import Counter
import os
from pathlib import Path
import sys
import tempfile
import unittest
from zipfile import ZipFile

import numpy as np
from PIL import Image

CAD = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(CAD))
from workspace.plate_preview import render_preview


def synthetic_plate(path, transform):
    # Asymmetric triangle makes both translation and X reflection observable.
    model = f'''<model xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02" unit="millimeter">
    <resources><object id="1" name="triangle" type="model"><mesh><vertices>
    <vertex x="10" y="10" z="1"/><vertex x="40" y="10" z="1"/>
    <vertex x="10" y="30" z="1"/></vertices><triangles>
    <triangle v1="0" v2="1" v3="2"/></triangles></mesh></object></resources>
    <build><item objectid="1" transform="{transform}"/></build></model>'''
    with ZipFile(path, 'w') as archive:
        archive.writestr('3D/3dmodel.model', model)


def colored_pixels(path, material):
    rgb = np.asarray(Image.open(path).convert('RGB')).astype(int)
    r, g, b = rgb[:, :, 0], rgb[:, :, 1], rgb[:, :, 2]
    return ((r > 1.5 * g) & (g > 1.4 * b)) if material == 'PETG' else ((g > 1.4 * r) & (b > 1.4 * r))


class PlatePreviewTests(unittest.TestCase):
    def test_embedded_transform_and_mesh_are_rendered(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            project, output = root / 'plate.3mf', root / 'preview.png'
            masks = []
            for transform in ('1 0 0 0 1 0 0 0 1 0 0 0',
                              '1 0 0 0 1 0 0 0 1 80 0 0',
                              '-1 0 0 0 1 0 0 0 1 80 0 0'):
                synthetic_plate(project, transform)
                self.assertEqual(render_preview(project, output, 'PETG'), Counter(triangle=1))
                with Image.open(output) as image:
                    self.assertEqual(image.size, (1000, 800))
                mask = colored_pixels(output, 'PETG')
                self.assertGreater(mask.sum(), 100)
                masks.append(mask)
            # Translation shifts the figure right; reflected mesh lands between
            # the first two and is visibly different from both.
            x = [np.nonzero(mask)[1].mean() for mask in masks]
            self.assertLess(x[0] + 100, x[2])
            self.assertLess(x[2] + 100, x[1])
            self.assertFalse(np.array_equal(masks[1], masks[2]))

    @unittest.skipUnless(os.environ.get('CAD_RELEASE_BUNDLE'), 'set CAD_RELEASE_BUNDLE for actual release')
    def test_actual_project_previews_have_expected_pieces_and_colors(self):
        from test_release_bundle import EXPECTED
        root = Path(os.environ['CAD_RELEASE_BUNDLE'])
        with tempfile.TemporaryDirectory() as tmp:
            for material, expected in EXPECTED.items():
                with self.subTest(material=material):
                    output = Path(tmp) / f'{material}.png'
                    self.assertEqual(render_preview(root / f'{material}.3mf', output, material), expected)
                    with Image.open(output) as image:
                        self.assertEqual(image.size, (1000, 800))
                    self.assertGreater(colored_pixels(output, material).sum(), 500)
                    bundled = root / f'{material}.png'
                    if bundled.exists():
                        # Verify the published image depicts this exact 3MF.
                        with Image.open(output) as generated, Image.open(bundled) as published:
                            np.testing.assert_array_equal(np.asarray(generated), np.asarray(published))


if __name__ == '__main__':
    unittest.main()

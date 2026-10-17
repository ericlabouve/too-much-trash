import json
from pathlib import Path
import struct
import sys
import tempfile
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from slice_review.build import export_toolpaths, validate_paths, write_page


class SliceReviewTests(unittest.TestCase):
    def test_two_parts_custom_bed_empty_roles_and_layer_ranges(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            objects = {n: dict(x=x, y=8, z=0, width=12, depth=9, height=2)
                       for n, x in [('pad-copy-1', 10), ('pad-copy-2', 50)]}
            segments = [(0.4, 'pad-copy-2', 'model', (50, 8), (60, 8)),
                        (0.2, 'pad-copy-1', 'support', (10, 8), (20, 8)),
                        (0.2, 'pad-copy-1', 'model', (10, 9), (20, 9))]
            data = export_toolpaths(root, segments, objects, [[0, 0], [256, 0], [256, 200], [0, 200]])
            validate_paths(data, root)
            self.assertEqual(data['heights'], [0.2, 0.4])
            self.assertEqual(data['paths']['model']['ends'], [2, 4])
            self.assertEqual(data['paths']['support']['ends'], [2, 2])
            self.assertEqual(data['paths']['interface']['ends'], [0, 0])
            self.assertEqual((root / 'interface.bin').stat().st_size, 0)
            values = struct.unpack('<12f', (root / 'model.bin').read_bytes())
            self.assertAlmostEqual(values[2], 0.2)
            self.assertAlmostEqual(values[8], 0.4)
            (root / 'review.json').write_text(json.dumps({'pieces': 2}))
            write_page(root, title='Two parts on a different bed')
            for name in ['index.html', 'viewer.js', 'viewer.css', 'viewer.json']:
                self.assertTrue((root / name).is_file())
            data['paths']['model']['ends'][-1] = 6
            with self.assertRaises(ValueError):
                validate_paths(data, root)

    def test_invalid_input(self):
        with tempfile.TemporaryDirectory() as tmp:
            with self.assertRaises(ValueError):
                export_toolpaths(tmp, [], {}, [])
            with self.assertRaises(ValueError):
                export_toolpaths(tmp, [(0.2, 'unknown', 'model', (0, 0), (1, 1))], {}, [])

    def test_recorded_plate_binary_integrity(self):
        job = Path(__file__).resolve().parents[1] / 'versions/v3/print/jobs/2026-10-14-actuator-bridge'
        data = json.loads((job / 'paths.json').read_text())
        validate_paths(data, job)
        segments = []
        for role, path in data['paths'].items():
            for x, y, h, nx, ny, nh in struct.iter_unpack('<6f', (job / path['file']).read_bytes()):
                self.assertEqual(h, nh)
                segments.append((h, 'all', role, (x, y), (nx, ny)))
        with tempfile.TemporaryDirectory() as tmp:
            export_toolpaths(tmp, segments, {'all': {}}, [[0, 0], [180, 0], [180, 180], [0, 180]])
            for role in data['paths']:
                self.assertEqual((Path(tmp) / f'{role}.bin').read_bytes(), (job / f'{role}.bin').read_bytes())


if __name__ == '__main__':
    unittest.main()

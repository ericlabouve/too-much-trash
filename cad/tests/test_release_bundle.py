"""Independent structural and geometry checks for the unsliced release.

Set CAD_RELEASE_BUNDLE to a generated release directory to exercise the real
bundle; ordinary test runs do not trigger a several-minute CAD rebuild.
"""
from collections import Counter
from itertools import combinations
import os
import hashlib
import json
import sys
import tempfile
from pathlib import Path
import unittest
from unittest.mock import patch
from xml.etree import ElementTree as ET
from zipfile import ZipFile

import numpy as np
import trimesh
from shapely.geometry import Polygon
from shapely.ops import unary_union

CAD = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(CAD))

NS = {'m': 'http://schemas.microsoft.com/3dmanufacturing/core/2015/02'}
EXPECTED_V3 = {
    'PETG': Counter({        'shaft_cap': 1, 'carrier': 1, 'sliding_jaw': 1,
        'actuator_bracket': 1, 'plunger': 1, 'pulley': 1, 'pulley_axle': 1,
    }),
    'TPU': Counter({
        'phone_cuff': 3, 'pulley_key': 1, 'collar_screw': 5,
        'thumb_nut': 5, 'clip_string_guide': 1,
    }),
}


EXPECTED = {
    'PETG': EXPECTED_V3['PETG'],
    'TPU': Counter(phone_cuff=3, pulley_key=2, collar_screw=5, thumb_nut=5, cap_liner=1, jaw_liner=1),
}


def read_plate(path):
    """Read embedded meshes and build items directly from the 3MF XML."""
    with ZipFile(path) as archive:
        bad = archive.testzip()
        assert bad is None, f'bad zip member: {bad}'
        model_files = [n for n in archive.namelist() if n.lower().endswith('.model')]
        assert len(model_files) == 1, model_files
        root = ET.fromstring(archive.read(model_files[0]))
    assert root.tag == '{%s}model' % NS['m'] and root.get('unit') == 'millimeter'
    objects = {}
    for obj in root.findall('./m:resources/m:object', NS):
        ident = obj.attrib['id']
        assert ident not in objects
        mesh = obj.find('m:mesh', NS)
        assert mesh is not None, f'object {ident} is not embedded mesh geometry'
        vertices = np.array([[float(v.attrib[a]) for a in 'xyz']
                             for v in mesh.findall('./m:vertices/m:vertex', NS)])
        faces = np.array([[int(t.attrib[a]) for a in ('v1', 'v2', 'v3')]
                          for t in mesh.findall('./m:triangles/m:triangle', NS)])
        assert vertices.ndim == 2 and vertices.shape[1] == 3 and len(vertices) >= 4
        assert faces.ndim == 2 and faces.shape[1] == 3 and len(faces) >= 4
        assert np.isfinite(vertices).all() and faces.min() >= 0 and faces.max() < len(vertices)
        # Check the encoded topology directly: reader-side vertex welding can
        # conceal a triangle soup that slicers treat as thousands of parts.
        model = trimesh.Trimesh(vertices=vertices, faces=faces, process=False)
        assert model.is_watertight and model.is_winding_consistent and model.volume > 0, ident
        assert not (model.area_faces <= 1e-12).any(), ident
        objects[ident] = (obj.get('name'), model)
    items = []
    for item in root.findall('./m:build/m:item', NS):
        ident = item.attrib['objectid']
        assert ident in objects, f'missing object {ident}'
        values = [float(x) for x in item.get('transform', '1 0 0 0 1 0 0 0 1 0 0 0').split()]
        assert len(values) == 12 and np.isfinite(values).all()
        # 3MF stores the linear matrix by rows, followed by the translation;
        # vertices are row vectors in its convention.
        rotation = np.array(values[:9]).reshape(3, 3)
        assert np.allclose(rotation @ rotation.T, np.eye(3), atol=1e-6)
        assert np.isclose(np.linalg.det(rotation), 1, atol=1e-6)
        name, model = objects[ident]
        vertices = model.vertices @ rotation + np.array(values[9:])
        items.append((name, vertices, model.faces))
    assert items and {i.attrib['objectid'] for i in root.findall('./m:build/m:item', NS)} == set(objects)
    return items


def projection(vertices, faces):
    triangles = vertices[faces, :2]
    # Ignore vertical triangles; their projections have zero area.
    polygons = [p for coords in triangles if (p := Polygon(coords)).area > 1e-10]
    return unary_union(polygons)


def triangle_fingerprint(vertices, faces):
    """Compare tessellations independently of vertex and face ordering."""
    triangles = np.round(vertices[faces], 4)
    # Sort the three vertices of each triangle and then the triangles.
    order = np.lexsort((triangles[:, :, 2], triangles[:, :, 1], triangles[:, :, 0]), axis=1)
    triangles = np.take_along_axis(triangles, order[:, :, None], axis=1).reshape(-1, 9)
    order = np.lexsort(tuple(triangles[:, i] for i in reversed(range(9))))
    return triangles[order]


def validate_plate(path, expected, clearance=2.0):
    items = read_plate(path)
    assert Counter(name for name, _, _ in items) == expected
    footprints = {}
    bounds = []
    for name, vertices, faces in items:
        low, high = vertices.min(axis=0), vertices.max(axis=0)
        assert np.all(low[:2] >= -1e-4) and np.all(high[:2] <= 180 + 1e-4), (name, low, high)
        assert abs(low[2]) < 1e-3 and high[2] <= 180 + 1e-4, (name, low, high)
        bounds.append((low, high))
    for i, j in combinations(range(len(items)), 2):
        lo1, hi1 = bounds[i]; lo2, hi2 = bounds[j]
        if np.any(np.maximum(lo1[:2], lo2[:2]) - np.minimum(hi1[:2], hi2[:2]) >= clearance - 1e-5):
            continue
        for k in (i, j):
            if k not in footprints:
                _, v, f = items[k]
                footprints[k] = projection(v, f)
        assert footprints[i].distance(footprints[j]) >= clearance - 1e-5, (items[i][0], items[j][0])
    return items


def synthetic_plate(path, *, second_x=3, bad_reference=False):
    """Small standalone core 3MF, with two instances of one tetrahedron."""
    model = f'''<?xml version="1.0" encoding="UTF-8"?>
    <model xmlns="{NS['m']}" unit="millimeter"><resources>
    <object id="1" name="sample" type="model"><mesh><vertices>
    <vertex x="0" y="0" z="0"/><vertex x="1" y="0" z="0"/>
    <vertex x="0" y="1" z="0"/><vertex x="0" y="0" z="1"/>
    </vertices><triangles><triangle v1="0" v2="2" v3="1"/>
    <triangle v1="0" v2="1" v3="3"/><triangle v1="1" v2="2" v3="3"/>
    <triangle v1="2" v2="0" v3="3"/></triangles></mesh></object>
    </resources><build><item objectid="1" transform="1 0 0 0 1 0 0 0 1 2 2 0"/>
    <item objectid="{2 if bad_reference else 1}" transform="1 0 0 0 1 0 0 0 1 {second_x} 2 0"/>
    </build></model>'''
    with ZipFile(path, 'w') as archive:
        archive.writestr('3D/3dmodel.model', model)


class ReleaseBundleTests(unittest.TestCase):
    def test_independent_geometry_checker(self):
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / 'plate.3mf'
            synthetic_plate(path, second_x=5)
            validate_plate(path, Counter(sample=2))
            synthetic_plate(path, second_x=2.25)
            with self.assertRaises(AssertionError):
                validate_plate(path, Counter(sample=2))
            synthetic_plate(path, second_x=180)
            with self.assertRaises(AssertionError):
                validate_plate(path, Counter(sample=2))
            # This tetrahedron has the same coordinates and triangles, but
            # duplicates every vertex by face; a repairing loader would hide it.
            synthetic_plate(path, second_x=5)
            with ZipFile(path) as archive:
                model = ET.fromstring(archive.read('3D/3dmodel.model'))
            vertices = model.find('.//m:vertices', NS)
            triangles = model.find('.//m:triangles', NS)
            coordinates = [dict(v.attrib) for v in vertices]
            faces = [dict(t.attrib) for t in triangles]
            vertices.clear()
            triangles.clear()
            for face in faces:
                indices = []
                for key in ('v1', 'v2', 'v3'):
                    indices.append(str(len(vertices)))
                    ET.SubElement(vertices, f"{{{NS['m']}}}vertex", coordinates[int(face[key])])
                ET.SubElement(triangles, f"{{{NS['m']}}}triangle", dict(zip(('v1', 'v2', 'v3'), indices)))
            with ZipFile(path, 'w') as archive:
                archive.writestr('3D/3dmodel.model', ET.tostring(model))
            with self.assertRaises(AssertionError):
                read_plate(path)
            synthetic_plate(path, bad_reference=True)
            with self.assertRaises(AssertionError):
                read_plate(path)

    def test_complete_manifest_must_match_material_layouts(self):
        from workspace import release
        parts = {name: {'name': name, 'quantity': quantity,
                        'material': 'PETG / PLA' if material == 'PETG' else 'ELEGOO TPU 95A'}
                 for material, counts in EXPECTED_V3.items()
                 for name, quantity in counts.items()}
        release.validate_layouts(parts)
        cases = {
            'new design': lambda rows: rows.append({'name': 'new_part', 'quantity': 1, 'material': 'PETG / PLA'}),
            'reduced quantity': lambda rows: next(r for r in rows if r['name'] == 'phone_cuff').update(quantity=2),
            'changed material': lambda rows: next(r for r in rows if r['name'] == 'carrier').update(material='ELEGOO TPU 95A'),
            'unsupported material': lambda rows: next(r for r in rows if r['name'] == 'carrier').update(material='Nylon'),
            'duplicate design': lambda rows: rows.append(dict(rows[0])),
        }
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            source = root / 'build/versions/v3/print'
            source.mkdir(parents=True)
            for label, mutate in cases.items():
                with self.subTest(label=label):
                    rows = [dict(row) for row in parts.values()]
                    mutate(rows)
                    (source / 'manifest.json').write_text(json.dumps({'parts': rows}))
                    # Stub provenance only; verify that package rejects the manifest
                    # before it tries to read any missing STL or create an output.
                    with patch.object(release, 'verify_build', return_value={}), \
                         patch.object(release, 'project') as project:
                        with self.assertRaises(ValueError):
                            release.package(root / 'build', root / 'output')
                        project.assert_not_called()
                        self.assertFalse((root / 'output').exists())

    def test_v4_layouts_cover_full_bom(self):
        from workspace import release
        layouts = []
        for material in ('petg', 'tpu'):
            raw = json.loads((CAD / f'workspace/layouts/v4-{material}.json').read_text())
            layouts.append({key: (*value[0], value[2]) for key, value in raw.items()})
        parts = {name: {'quantity': count, 'material': material}
                 for material, counts in EXPECTED.items() for name, count in counts.items()}
        release.validate_layouts(parts, *layouts)
        parts['pulley_key']['quantity'] = 1
        with self.assertRaises(ValueError):
            release.validate_layouts(parts, *layouts)

    def test_packager_uses_quantity_and_layout(self):
        from workspace import release
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            mesh = trimesh.creation.box(extents=(1, 1, 1))
            mesh.apply_translation((0, 0, .5))
            mesh.export(root / 'sample.stl')
            parts = {'sample': {'file': 'sample.stl', 'quantity': 2, 'material': 'PETG'}}
            layout = {'sample_1': (5, 5, 0), 'sample_2': (10, 5, 90)}
            contents, rels, model, _ = release.project(root, 'PETG', layout, parts)
            plate = root / 'test.3mf'
            with ZipFile(plate, 'w') as z:
                z.writestr('[Content_Types].xml', contents)
                z.writestr('_rels/.rels', rels)
                z.writestr('3D/3dmodel.model', model)
            validate_plate(plate, Counter(sample=2))
            with self.assertRaises(ValueError):
                release.project(root, 'PETG', {'sample_1': (5, 5, 0)}, parts)
            with self.assertRaises(ValueError):
                release.project(root, 'PETG', {'sample_1': (5, 5, 0), 'sample_2': (5, 5, 0)}, parts)

    def test_project_archive_is_reproducible_with_fixed_metadata(self):
        from workspace.release import write_project
        with tempfile.TemporaryDirectory() as directory:
            first, second = (Path(directory) / name for name in ('first.3mf', 'second.3mf'))
            write_project(first, b'types', b'rels', b'model')
            # The wall clock must never enter the archive.
            with patch('zipfile.time.localtime', return_value=(2035, 6, 7, 8, 9, 10, 0, 0, 0)):
                write_project(second, b'types', b'rels', b'model')
            self.assertEqual(first.read_bytes(), second.read_bytes())
            with ZipFile(first) as archive:
                self.assertEqual([archive.read(n) for n in archive.namelist()], [b'types', b'rels', b'model'])
                self.assertTrue(all(i.date_time == (1980, 1, 1, 0, 0, 0) for i in archive.infolist()))

    @unittest.skipUnless(os.environ.get('CAD_RELEASE_BUNDLE'), 'set CAD_RELEASE_BUNDLE for actual release')
    def test_current_release(self):
        root = Path(os.environ['CAD_RELEASE_BUNDLE'])
        self.assertEqual({p.name for p in root.iterdir()}, {'PETG.3mf', 'TPU.3mf', 'PETG.png', 'TPU.png', 'README.md', 'manifest.json'})
        manifest = json.loads((root / 'manifest.json').read_text())
        self.assertEqual(manifest['status'], 'unsliced')
        self.assertEqual(manifest['version'], 'v4')
        build = Path(os.environ['CAD_RELEASE_BUILD']) if os.environ.get('CAD_RELEASE_BUILD') else None
        if build:
            run = json.loads((build / 'workspace-run.json').read_text())
            self.assertEqual((run['version'], run['operation'], run['status'], run['returncode']), ('v4', 'build', 'completed', 0))
            self.assertEqual(manifest['source_sha256'], run['source_sha256'])
            self.assertEqual(manifest['environment_sha256'], run['environment_sha256'])
            for relative, expected_hash in run['source_sha256'].items():
                checkout = CAD / ('workspace/check.py' if relative == 'versions/v3/source/workspace_check.py' else relative)
                for source in (checkout, build / relative):
                    self.assertEqual(hashlib.sha256(source.read_bytes()).hexdigest(), expected_hash, str(source))
            for name, expected_hash in run['environment_sha256'].items():
                self.assertEqual(hashlib.sha256((CAD / name).read_bytes()).hexdigest(), expected_hash, name)
        for material, expected in EXPECTED.items():
            with self.subTest(material=material):
                plate = root / f'{material}.3mf'
                with ZipFile(plate) as archive:
                    types = ET.fromstring(archive.read('[Content_Types].xml'))
                    rels = ET.fromstring(archive.read('_rels/.rels'))
                    self.assertTrue(any(e.get('Extension') == 'model' and e.get('ContentType') == 'application/vnd.ms-package.3dmanufacturing-3dmodel+xml' for e in types))
                    self.assertTrue(any(e.get('Target') == '/3D/3dmodel.model' and e.get('Type') == 'http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel' for e in rels))
                    self.assertEqual(set(archive.namelist()), {'[Content_Types].xml', '_rels/.rels', '3D/3dmodel.model'})
                items = validate_plate(plate, expected, clearance=3.0)
                project = manifest['projects'][material]
                self.assertEqual(project['sha256'], hashlib.sha256(plate.read_bytes()).hexdigest())
                self.assertEqual(project['preview'], f'{material}.png')
                self.assertEqual(project['preview_sha256'], hashlib.sha256((root / project['preview']).read_bytes()).hexdigest())
                self.assertEqual(Counter(o['design'] for o in project['objects']), expected)
                if build:
                    source = build / 'manufacturing/source'
                    for row in project['objects']:
                        self.assertEqual(row['source_sha256'], hashlib.sha256((source / row['source_file']).read_bytes()).hexdigest())
                    # Reverse placements and compare every triangle with the source STL.
                    refs = {name: trimesh.load_mesh(source / f'{name}.stl', process=True) for name in expected}
                    for (name, vertices, faces), row in zip(items, project['objects']):
                        self.assertEqual(name, row['design'])
                        t = np.array([float(v) for v in row['transform'].split()])
                        original = (vertices - t[9:]) @ t[:9].reshape(3, 3).T
                        actual = triangle_fingerprint(original, faces)
                        ref = refs[name]
                        np.testing.assert_allclose(actual, triangle_fingerprint(ref.vertices, ref.faces), atol=1e-4)


if __name__ == '__main__':
    unittest.main()

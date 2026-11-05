"""Package a fresh isolated V3 build into portable, unsliced material projects."""
from __future__ import annotations

import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import xml.etree.ElementTree as ET
import zipfile

import numpy as np
import shapely
from shapely import affinity
import trimesh

try:
    from .plate_preview import render_preview
except ImportError:  # Direct invocation by the workspace task.
    from plate_preview import render_preview

CAD = Path(__file__).resolve().parents[1]
CORE = 'http://schemas.microsoft.com/3dmanufacturing/core/2015/02'
ET.register_namespace('', CORE)
Q = lambda name: f'{{{CORE}}}{name}'
# Existing compact arrangement is only a placement starting point. All meshes
# come from the fresh build and are checked again after placement.
RIGID = {
    'sliding_jaw': (113.031797, 159.311199, 90), 'carrier': (114.632047, 123.723709, 0),
    'shaft_cap': (118.179432, 54.403709, 270), 'pulley': (47.050201, 152.898294, 0),
    'actuator_bracket': (28.238743, 48.551745, 90), 'plunger': (159.162572, 155.268916, 180),
    'pulley_axle': (42.159763, 168.742589, 90),
}
FLEX = {
    **{f'phone_cuff_{i}': (40+40*(i-1), 120, 0) for i in range(1, 4)},
    **{f'collar_screw_{i}': (30+28*(i-1), 80, 0) for i in range(1, 6)},
    **{f'thumb_nut_{i}': (30+28*(i-1), 50, 0) for i in range(1, 6)},
    'pulley_key': (55, 25, 0), 'clip_string_guide': (100, 25, 0),
}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def verify_build(build):
    run = json.loads((build / 'workspace-run.json').read_text())
    if (run.get('version'), run.get('operation'), run.get('status'), run.get('returncode')) != ('v3', 'build', 'completed', 0):
        raise ValueError('requires a completed isolated V3 build')
    for rel, sha in run['source_sha256'].items():
        original = CAD / rel
        if rel == 'versions/v3/source/workspace_check.py':
            original = CAD / 'workspace/check.py'
        if not original.is_file() or digest(original) != sha or digest(build / rel) != sha:
            raise ValueError(f'build source differs from checkout: {rel}')
    # Detect added or removed files as well as changed recorded files.
    for source in ('source', 'versions/v3/source'):
        current = {str(p.relative_to(CAD)) for p in (CAD / source).rglob('*') if p.is_file() and '__pycache__' not in p.parts and not p.name.endswith('.pyc') and p.name != '.DS_Store'}
        recorded = {p for p in run['source_sha256'] if p.startswith(source + '/')}
        recorded.discard('versions/v3/source/workspace_check.py')
        if current != recorded:
            raise ValueError(f'build input inventory differs from checkout: {source}')
    for name, sha in run['environment_sha256'].items():
        if digest(CAD / name) != sha:
            raise ValueError(f'build environment differs from checkout: {name}')
    return run


def footprint(mesh):
    # Union the XY projection of every triangle, including overhangs. Checking
    # bounding boxes alone rejects valid nested placements; checking only the
    # first layer would miss collisions higher on the print.
    xy = mesh.vertices[mesh.faces][:, :, :2]
    ab, ac = xy[:, 1] - xy[:, 0], xy[:, 2] - xy[:, 0]
    area = np.abs(ab[:, 0] * ac[:, 1] - ab[:, 1] * ac[:, 0])
    triangles = xy[area > 1e-10]
    return shapely.union_all(shapely.polygons(triangles))


def validate_layouts(parts):
    """Reject any manifest design, material, or quantity not covered by layouts."""
    expected = {'PETG': Counter(), 'TPU': Counter()}
    for name, part in parts.items():
        quantity = part.get('quantity')
        if isinstance(quantity, bool) or not isinstance(quantity, int) or quantity <= 0:
            raise ValueError(f'invalid quantity for {name}: {quantity!r}')
        material = part.get('material')
        # PETG / PLA is the V3 rigid BOM label; this release selects PETG.
        if material == 'PETG / PLA':
            plate = 'PETG'
        elif material == 'ELEGOO TPU 95A':
            plate = 'TPU'
        else:
            raise ValueError(f'unsupported manufacturing material for {name}: {material!r}')
        expected[plate][name] = quantity
    for plate, layout in (('PETG', RIGID), ('TPU', FLEX)):
        actual = Counter(key.rsplit('_', 1)[0] if key.rsplit('_', 1)[-1].isdigit() else key
                         for key in layout)
        if actual != expected[plate]:
            raise ValueError(f'{plate} layout does not match manufacturing manifest: {actual} vs {expected[plate]}')


def project(path, material, layout, parts):
    model = ET.Element(Q('model'), {'unit': 'millimeter', '{http://www.w3.org/XML/1998/namespace}lang': 'en-US'})
    resources = ET.SubElement(model, Q('resources'))
    build_xml = ET.SubElement(model, Q('build'))
    meshes, objects, placed = {}, [], []
    for key, (x, y, angle) in layout.items():
        base = key.rsplit('_', 1)[0] if key.rsplit('_', 1)[-1].isdigit() else key
        if base not in parts:
            raise ValueError(f'missing design {base}')
        if base not in meshes:
            src = path / parts[base]['file']
            mesh = trimesh.load_mesh(src, process=True)
            if (not isinstance(mesh, trimesh.Trimesh) or mesh.is_empty
                    or not np.isfinite(mesh.vertices).all() or not mesh.is_watertight
                    or not mesh.is_winding_consistent or mesh.volume <= 0):
                raise ValueError(f'invalid mesh {src}')
            meshes[base] = (mesh, footprint(mesh), digest(src))
        mesh, shape, sha = meshes[base]
        shape = affinity.translate(affinity.rotate(shape, angle, origin=(0, 0)), xoff=x, yoff=y)
        bounds = shape.bounds
        if bounds[0] < -1e-4 or bounds[1] < -1e-4 or bounds[2] > 180.0001 or bounds[3] > 180.0001 or abs(float(mesh.bounds[0, 2])) > .001:
            raise ValueError(f'{key} exceeds 180 mm bed or is not on bed: {bounds}')
        for other, old in placed:
            if shape.distance(old) < 2.0 - 1e-5:
                raise ValueError(f'{key} and {other} have less than 2 mm projected clearance ({shape.distance(old):.3f} mm)')
        placed.append((key, shape))
        ident = len(objects) + 1
        obj = ET.SubElement(resources, Q('object'), {'id': str(ident), 'type': 'model', 'name': base})
        mesh_xml = ET.SubElement(obj, Q('mesh'))
        vertices = ET.SubElement(mesh_xml, Q('vertices'))
        for v in mesh.vertices:
            ET.SubElement(vertices, Q('vertex'), dict(zip(('x', 'y', 'z'), (f'{n:.9g}' for n in v))))
        triangles = ET.SubElement(mesh_xml, Q('triangles'))
        for face in mesh.faces:
            ET.SubElement(triangles, Q('triangle'), dict(zip(('v1', 'v2', 'v3'), (str(n) for n in face))))
        a = np.deg2rad(angle)
        c, s = round(float(np.cos(a))), round(float(np.sin(a)))
        transform = f'{c} {s} 0 {-s} {c} 0 0 0 1 {x:.9g} {y:.9g} 0'
        ET.SubElement(build_xml, Q('item'), {'objectid': str(ident), 'transform': transform})
        objects.append(dict(name=key, design=base, source_file=parts[base]['file'], source_sha256=sha, transform=transform, projected_bounds_mm=list(bounds)))
    expected = {n: p['quantity'] for n, p in parts.items() if ('TPU' in p['material']) == (material == 'TPU')}
    counts = {n: sum(o['design'] == n for o in objects) for n in expected}
    if counts != expected or set(o['design'] for o in objects) != set(expected):
        raise ValueError(f'{material} quantity mismatch: {counts} vs {expected}')
    contents = b'<?xml version="1.0" encoding="UTF-8"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/></Types>'
    rels = b'<?xml version="1.0" encoding="UTF-8"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Target="/3D/3dmodel.model" Id="rel0" Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/></Relationships>'
    return contents, rels, ET.tostring(model, encoding='utf-8', xml_declaration=True), objects


def package(build, output):
    build, output = Path(build).resolve(), Path(output).resolve()
    run = verify_build(build)
    if output.exists():
        raise ValueError(f'output exists: {output}')
    source = build / 'versions/v3/print'
    manifest = json.loads((source / 'manifest.json').read_text())
    parts = {p['name']: p for p in manifest['parts']}
    if len(parts) != len(manifest['parts']):
        raise ValueError('duplicate manufacturing design in manifest')
    validate_layouts(parts)
    projects = {}
    for material, layout in (('PETG', RIGID), ('TPU', FLEX)):
        contents, rels, model, objects = project(source, material, layout, parts)
        projects[material] = (contents, rels, model, objects)
    output.mkdir(parents=True)
    git_commit = subprocess.check_output(['git', '-C', str(CAD), 'rev-parse', 'HEAD'], text=True).strip()
    dirty = bool(subprocess.check_output(['git', '-C', str(CAD), 'status', '--porcelain', '--', 'source', 'versions/v3/source', 'workspace/check.py', 'pyproject.toml', 'uv.lock'], text=True).strip())
    result = {'git_commit': git_commit, 'source_dirty': dirty, 'version': 'v3', 'revision': manifest['revision'], 'status': 'unsliced', 'bed_mm': [180, 180], 'minimum_projected_clearance_mm': 2.0, 'source_sha256': run['source_sha256'], 'environment_sha256': run['environment_sha256'], 'projects': {}}
    for material, (contents, rels, model, objects) in projects.items():
        filename = f'{material}.3mf'
        with zipfile.ZipFile(output / filename, 'w', compression=zipfile.ZIP_DEFLATED) as z:
            z.writestr('[Content_Types].xml', contents)
            z.writestr('_rels/.rels', rels)
            z.writestr('3D/3dmodel.model', model)
        preview = f'{material}.png'
        counts = render_preview(output / filename, output / preview, material)
        if counts != Counter(o['design'] for o in objects):
            raise ValueError(f'{material} preview object counts differ from project')
        result['projects'][material] = {'file': filename, 'sha256': digest(output / filename), 'preview': preview, 'preview_sha256': digest(output / preview), 'objects': objects}
    (output / 'manifest.json').write_text(json.dumps(result, indent=2) + '\n')
    (output / 'README.md').write_text(f'''# Too Much Trash V3 — unsliced print projects

PETG.3mf contains seven rigid pieces; TPU.3mf contains fifteen ELEGOO TPU 95A pieces. The files embed the current V3 manufacturing meshes, in millimetres at 100% scale. Each project is an independent generic 3MF; no printer, filament, support, or process profile is embedded. They are not G-code and cannot be sent as ready-to-print jobs.

![PETG plate preview](PETG.png)

![TPU plate preview](TPU.png)

These previews show the embedded geometry and placement from above; they do not show slicer-generated supports or toolpaths.

Open each project in a slicer, select the actual printer, 0.4 mm nozzle, bed and filament, and slice and review each plate before printing. The layouts fit a 180 × 180 mm A1 mini bed in geometric projection, with at least 2 mm between projected models; supports, brims, bed exclusions and purge areas require separate slicer review. Keep the supplied bed-facing orientation unless deliberately reviewed. Use 0.12 mm layers for threaded parts; recent PETG review also used 0.12 mm. Supports and their removal must be reviewed per part. TPU cuff support was disabled in a prior successful cuff print; other current parts still require review.

These are research prototypes. Phone fit, grip, loaded fastener retention, friction, strength and real camera framing remain unvalidated. The current curved-foot actuator awaits physical assessment. The recorded 18 and 20 mm phone examples conflict with the pocket. Check the project documentation for assembly and current limitations. Outgoing twine intersects the carrier in some modeled configurations; routing still needs correction and physical checks. The bundle does not include twine or rubber bands.

For assembly, fit the sliding jaw into the fixed jaw track and fit the three flexible cuffs over their studs. Place the collar halves around the shaft, fit four screw/nut pairs, and hand-tighten evenly. Slide the actuator bracket onto the open rail end before its screw and cords; insert the plunger, then the pulley and axle, and retain the axle with the TPU key and keeper band. Fit the shaft clip and route the twine and bands, checking clearance and free return before attempting a phone fit. These are prototype assembly directions, not proof of safe operation.

[Version documentation and assembly context](https://github.com/ericlabouve/too-much-trash/blob/{git_commit}/cad/versions/v3/README.md) · Source commit `{git_commit}`. See manifest.json for input hashes and local source-change status.
''')
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', help='new release directory (default: unique cad/build/v3 directory)')
    args = parser.parse_args()
    sys.path.insert(0, str(CAD))
    from cad import output_path
    output = output_path('v3', 'release', args.output)
    # The snapshot is a sibling, so the released directory is self-contained.
    snapshot = output.with_name(output.name + '-build')
    subprocess.run([sys.executable, str(CAD / 'cad.py'), 'build', 'v3', '--output', str(snapshot)], check=True)
    package(snapshot, output)
    print(f'Unsliced release: {output}')


if __name__ == '__main__':
    main()

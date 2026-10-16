"""Reproducible offline actuator plate with optional subset; never contacts a printer."""
import argparse
import hashlib
import json
import subprocess
import zipfile
import xml.etree.ElementTree as ET
from pathlib import Path
import trimesh

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'print/jobs/2026-10-14-actuator-bridge'
APP = Path('/Applications/BambuStudio.app/Contents')
PARTS = {'actuator_bracket': (60, 105), 'plunger': (115, 150),
         'pulley': (120, 100), 'pulley_axle': (145, 100),
         'pulley_key': (145, 65), 'thumb_screw': (60, 50), 'thumb_nut': (95, 50)}
NS = 'http://schemas.microsoft.com/3dmanufacturing/core/2015/02'


def save(path, data):
    path.write_text(json.dumps(data, indent=2) + '\n')


def cli(args, label):
    run = subprocess.run([str(APP / 'MacOS/BambuStudio'), *args], cwd=OUT,
                         capture_output=True, text=True, timeout=240)
    (OUT / (label + '.log')).write_text(run.stdout + run.stderr)
    assert run.returncode == 0, (label, run.returncode, 'inspect log')


def prepare(support_axle=False):
    OUT.mkdir(parents=True, exist_ok=True)
    assert not (OUT / 'actuator.gcode.3mf').exists(), 'Preserve existing sliced job; use a new job directory.'
    manifest = json.loads((ROOT / 'print/manifest.json').read_text())
    assert manifest['revision'].endswith('-v3')
    # Reuse the recorded 0.12 mm thread starting recipe, not its old geometry.
    prior = ROOT.parent / 'v2/print/jobs/2026-10-04-combined-45'
    profiles = {k: json.loads((prior / (k + '.json')).read_text())
                for k in ('machine', 'process', 'filament')}
    profiles['process'].update(enable_support='0', support_on_build_plate_only='0',
        support_style='snug', support_type='normal(auto)', support_threshold_angle='30',
        support_top_z_distance='0.24', support_bottom_z_distance='0.24',
        support_object_xy_distance='0.4', support_interface_top_layers='2',
        support_interface_bottom_layers='2', support_interface_spacing='0.5',
        layer_height='0.12', initial_layer_print_height='0.2',
        print_sequence='by layer', enable_arc_fitting='0',
        curr_bed_type='Textured PEI Plate', brim_type='no_brim', brim_width='0', raft_layers='0')
    for kind, data in profiles.items():
        save(OUT / (kind + '.json'), data)
    model = ET.Element('model', {'unit': 'millimeter', 'xmlns': NS})
    resources = ET.SubElement(model, 'resources')
    build = ET.SubElement(model, 'build')
    rows = []
    for i, (name, (x, y)) in enumerate(PARTS.items(), 1):
        path = ROOT / 'print' / (name + '.stl')
        mesh = trimesh.load_mesh(path)
        assert mesh.is_watertight and mesh.volume > 0
        mesh.apply_translation([-mesh.bounds[:, 0].mean(), -mesh.bounds[:, 1].mean(), -mesh.bounds[0, 2]])
        obj = ET.SubElement(resources, 'object', {'id': str(i), 'type': 'model', 'name': name})
        node = ET.SubElement(obj, 'mesh')
        vertices = ET.SubElement(node, 'vertices')
        for v in mesh.vertices:
            ET.SubElement(vertices, 'vertex', dict(zip('xyz', (f'{q:.7f}' for q in v))))
        triangles = ET.SubElement(node, 'triangles')
        for f in mesh.faces:
            ET.SubElement(triangles, 'triangle', dict(zip(('v1', 'v2', 'v3'), map(str, f))))
        ET.SubElement(build, 'item', {'objectid': str(i), 'transform': f'1 0 0 0 1 0 0 0 1 {x} {y} 0'})
        rows.append({'name': name, 'quantity': 1, 'input_sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
                     'center_xy_mm': [x, y], 'bounds_mm': mesh.extents.tolist(),
                     'orientation': next(p['supports'] for p in manifest['parts'] if p['name'] == name)})
    with zipfile.ZipFile(OUT / 'raw-layout.3mf', 'w', zipfile.ZIP_DEFLATED) as z:
        z.writestr('3D/3dmodel.model', ET.tostring(model, encoding='utf-8', xml_declaration=True))
        z.writestr('[Content_Types].xml', '<?xml version="1.0"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/></Types>')
        z.writestr('_rels/.rels', '<?xml version="1.0"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Target="/3D/3dmodel.model" Id="rel0" Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/></Relationships>')
    cli(['--load-settings', str(OUT / 'machine.json') + ';' + str(OUT / 'process.json'),
         '--load-filaments', str(OUT / 'filament.json'), '--arrange', '0', '--orient', '0',
         '--export-3mf', 'normalized-layout.3mf', '--outputdir', str(OUT), str(OUT / 'raw-layout.3mf')], 'prepare')
    with zipfile.ZipFile(OUT / 'normalized-layout.3mf') as z:
        entries = {name: z.read(name) for name in z.namelist()}
    config = ET.fromstring(entries['Metadata/model_settings.config'])
    overrides = []
    for obj in config.findall('object'):
        name = next(m.get('value') for m in obj.findall('metadata') if m.get('key') == 'name')
        assert name in PARTS, name
        threaded = name in ('thumb_screw', 'thumb_nut')
        settings = {'wall_loops': '2' if threaded else '3',
                    'sparse_infill_pattern': 'grid' if threaded else 'gyroid',
                    'sparse_infill_density': '15%',
                    'enable_support': '0' if threaded or name == 'pulley_key' or (name == 'pulley_axle' and not support_axle) else '1'}
        for key, value in settings.items():
            old = next((m for m in obj.findall('metadata') if m.get('key') == key), None)
            if old is not None:
                obj.remove(old)
            ET.SubElement(obj, 'metadata', {'key': key, 'value': value})
        overrides.append({'id': obj.get('id'), 'name': name, **settings})
    assert len(overrides) == len(PARTS)
    entries['Metadata/model_settings.config'] = ET.tostring(config, encoding='utf-8', xml_declaration=True)
    with zipfile.ZipFile(OUT / 'actuator-input.3mf', 'w', zipfile.ZIP_DEFLATED) as z:
        for name, data in entries.items():
            z.writestr(name, data)
    save(OUT / 'inputs.json', {'revision': manifest['revision'], 'scale_percent': 100,
         'slice_recipe': 'supported-axle' if support_axle else 'bridged-axle-slot',
         'printer_contacted': False, 'slicer': 'BambuStudio-02.07.01.62', 'parts': rows,
         'profile_source': 'Recorded combined-45 0.12 mm starting recipe; current geometry and explicit support gaps',
         'material_status': 'Generic PLA reference recipe; loaded spool not verified',
         'object_settings': overrides})
    print(f'Prepared {len(PARTS)} separate objects at 100% scale', flush=True)


def slice_plate():
    assert not (OUT / 'actuator.gcode.3mf').exists(), 'Preserve reviewed toolpaths; revise in a new job directory.'
    cli(['--load-settings', str(OUT / 'machine.json') + ';' + str(OUT / 'process.json'),
         '--load-filaments', str(OUT / 'filament.json'), '--arrange', '0', '--orient', '0',
         '--slice', '0', '--export-3mf', 'actuator.gcode.3mf', '--outputdir', str(OUT),
         str(OUT / 'actuator-input.3mf')], 'slice')
    result = json.loads((OUT / 'result.json').read_text())
    assert result['return_code'] == 0 and len(result['sliced_plates']) == 1
    expected = json.loads((OUT / 'inputs.json').read_text())['parts']
    assert {o['name'] for o in result['sliced_plates'][0]['objects']} == {p['name'] for p in expected}
    print(json.dumps(result['sliced_plates'][0], indent=2), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('action', choices=['prepare', 'slice'])
    parser.add_argument('--output-dir', type=Path, default=OUT)
    parser.add_argument('--support-axle', action='store_true', help='Historical supported-slot recipe; default bridges the unchanged slot.')
    parser.add_argument('--parts', nargs='+', choices=list(PARTS), help='Optional subset, retaining recorded orientations and plate positions.')
    args = parser.parse_args()
    OUT = args.output_dir.resolve()
    if args.parts:
        PARTS = {n: PARTS[n] for n in args.parts}
    prepare(args.support_axle) if args.action == 'prepare' else slice_plate()

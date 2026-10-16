"""Audit the actual sliced plate and render its extrusion paths, not guessed supports."""
import hashlib
import argparse
from pathlib import Path
import itertools
import json
import math
import re
import zipfile
import sys
import xml.etree.ElementTree as ET
from collections import defaultdict
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.collections import LineCollection
from prepare_actuator_plate import OUT, save
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
from slice_review import export_toolpaths, write_page

COLORS = {'model': '#d78942', 'support': '#1786cf', 'interface': '#953bc2', 'adhesion': '#58a36c'}


def main():
    inputs = json.loads((OUT / 'inputs.json').read_text())
    result = json.loads((OUT / 'result.json').read_text())
    plate = result['sliced_plates'][0]
    gcode = (OUT / 'plate_1.gcode').read_bytes()
    text = gcode.decode()
    filament = json.loads((OUT / 'filament.json').read_text())
    bed_temp = int(filament['textured_plate_temp_initial_layer'][0])
    nozzle_temp = int(filament['nozzle_temperature_initial_layer'][0])
    assert re.search(rf'^M190 S{bed_temp}(?:\s|;|$)', text, re.M)
    assert re.search(rf'^\s*M109 S{nozzle_temp}(?:\s|;|$)', text, re.M)
    with zipfile.ZipFile(OUT / 'actuator.gcode.3mf') as z:
        assert z.read('Metadata/plate_1.gcode') == gcode
        settings = json.loads(z.read('Metadata/project_settings.config'))
        config = ET.fromstring(z.read('Metadata/model_settings.config'))
    for key in ('filament_type', 'nozzle_temperature', 'nozzle_temperature_initial_layer',
                'textured_plate_temp', 'filament_flow_ratio', 'filament_max_volumetric_speed',
                'fan_min_speed', 'fan_max_speed'):
        assert settings[key] == filament[key], (key, settings[key], filament[key])
    effective = []
    for obj in config.findall('object'):
        row = {m.get('key'): m.get('value') for m in obj.findall('metadata') if m.get('key')}
        expected = next(p for p in inputs['object_settings'] if p['name'] == row['name'])
        for k in ('wall_loops', 'enable_support', 'sparse_infill_density', 'sparse_infill_pattern'):
            assert row.get(k, settings.get(k)) == expected[k], (row, k, expected[k])
        effective.append(row)
    assert {r['name'] for r in effective} == {p['name'] for p in inputs['parts']}
    for k, v in {'layer_height': '0.12', 'curr_bed_type': 'Textured PEI Plate',
                 'support_top_z_distance': '0.24', 'support_bottom_z_distance': '0.24',
                 'support_object_xy_distance': '0.4', 'support_style': 'snug',
                 'print_sequence': 'by layer', 'enable_arc_fitting': '0'}.items():
        assert settings[k] == v, (k, settings[k])
    boxes = {o['name']: o['bbox'] for o in plate['objects']}
    for row in inputs['parts']:
        b = boxes[row['name']]
        assert np.allclose([b['width'], b['depth'], b['height']], row['bounds_mm'], atol=.002)
        assert np.allclose([b['x'] + b['width']/2, b['y'] + b['depth']/2], row['center_xy_mm'], atol=.002)
    x = y = e = 0.
    absolute = False
    height = None
    feature = ''
    label = None
    label_names = {}
    segments = []
    lengths = defaultdict(float)
    object_lengths = defaultdict(lambda: defaultdict(float))
    for line in text.splitlines():
        if line.startswith('; Z_HEIGHT:'):
            height = float(line.split(':')[1])
        elif line.startswith('; FEATURE:'):
            feature = line.split(':', 1)[1].strip()
        elif line.startswith('; start printing object, unique label id:'):
            label = line.rsplit(':', 1)[1].strip()
        elif line.startswith('; stop printing object'):
            label = None
        elif line.startswith('M82'):
            absolute = True
        elif line.startswith('M83'):
            absolute = False
        elif line.startswith('G92 E'):
            e = float(line.split(';')[0].split('E')[1].split()[0])
        elif line.startswith(('G0 ', 'G1 ', 'G2 ', 'G3 ')):
            v = {k: float(n) for k, n in re.findall(r'([XYE])(-?(?:\d+(?:\.\d*)?|\.\d+))', line.split(';')[0])}
            nx, ny = v.get('X', x), v.get('Y', y)
            ev = v.get('E', e if absolute else 0)
            de = ev-e if absolute else ev
            if height is not None and label and de > 0 and (nx != x or ny != y):
                assert not line.startswith(('G2 ', 'G3 ')), 'Arc fitting must stay disabled or parser must interpolate arcs.'
                if label not in label_names:
                    mx, my = (x+nx)/2, (y+ny)/2
                    candidates = [n for n, b in boxes.items() if b['x']-4 <= mx <= b['x']+b['width']+4 and b['y']-4 <= my <= b['y']+b['depth']+4]
                    assert len(candidates) == 1, (label, candidates, mx, my)
                    label_names[label] = candidates[0]
                name = label_names[label]
                kind = 'interface' if feature == 'Support interface' else 'support' if feature.startswith('Support') else 'adhesion' if feature in ('Skirt', 'Brim') else 'model'
                segments.append((height, name, kind, (x, y), (nx, ny)))
                lengths[kind] += de
                object_lengths[name][kind] += de
            x, y = nx, ny
            if 'E' in v:
                e = ev if absolute else e+ev
    assert set(label_names.values()) == set(boxes)
    density = float(settings['filament_density'][0])
    diameter = float(settings['filament_diameter'][0])
    factor = math.pi*(diameter/2)**2*density/1000
    object_report = {}
    for name in boxes:
        own = [s for s in segments if s[1] == name]
        pts = np.array([p for s in own for p in s[3:5]])
        support = [s for s in own if s[2] in ('support', 'interface')]
        bounds = [pts.min(axis=0).tolist(), pts.max(axis=0).tolist()]
        assert pts.min() > .3 and pts.max() < 179.7
        # Entire deposited footprint avoids the machine's top-right detection zone.
        assert not np.any((pts[:, 0] > 155.7) & (pts[:, 1] > 151.7))
        object_report[name] = {'deposited_g_by_role': {k: round(v*factor, 4) for k, v in object_lengths[name].items()},
            'deposited_xy_bounds': bounds, 'support_z_mm': [min(s[0] for s in support), max(s[0] for s in support)] if support else None}
    gaps = []
    for a, b in itertools.combinations(object_report, 2):
        aa, bb = np.array(object_report[a]['deposited_xy_bounds']), np.array(object_report[b]['deposited_xy_bounds'])
        gap = max(np.maximum(aa[0]-bb[1], bb[0]-aa[1]))-.6
        assert gap > 0, (a, b, gap)
        gaps.append({'objects': [a, b], 'bbox_gap_with_0_6mm_path_margin': float(gap)})
    for name in ('thumb_screw', 'thumb_nut', 'pulley_key'):
        if name in object_report:
            assert object_report[name]['support_z_mm'] is None
    bed = [[float(v) for v in point.split('x')] for point in settings['printable_area']]
    export_toolpaths(OUT, segments, boxes, bed)
    fig, ax = plt.subplots(figsize=(9, 9))
    for kind in COLORS:
        selected = [s for s in segments if s[2] == kind]
        ax.add_collection(LineCollection([(s[3], s[4]) for s in selected], colors=COLORS[kind], linewidths=.32, alpha=.65 if kind == 'model' else 1))
    for name, b in boxes.items():
        ax.text(b['x']+b['width']/2, b['y']-3, name.replace('_', ' '), ha='center', va='top', fontsize=9)
    ax.set(xlim=(0, 180), ylim=(0, 180), xlabel='Bed X (mm)', ylabel='Bed Y (mm)', title='V3 actuator · one plate · actual sliced paths\nOrange: model / Blue: support / Purple: support interface')
    ax.set_aspect('equal');ax.grid(alpha=.12);fig.tight_layout();fig.savefig(OUT / 'plate-overview.png', dpi=150);plt.close(fig)
    fig, axes = plt.subplots(2, 3, figsize=(15, 8))
    for row, name in enumerate(('actuator_bracket', 'plunger')):
        own = [s for s in segments if s[1] == name]
        for col, (a, b, title) in enumerate(((0, 1, 'top'), (0, 2, 'front'), (1, 2, 'side'))):
            ax = axes[row, col]
            for kind in COLORS:
                lines = []
                for h, _, k, start, end in own:
                    if k == kind:
                        p, q = (*start, h), (*end, h)
                        lines.append(((p[a], p[b]), (q[a], q[b])))
                ax.add_collection(LineCollection(lines, colors=COLORS[kind], linewidths=.4, alpha=.25 if kind == 'model' else 1))
            ax.autoscale();ax.set_aspect('equal');ax.set_title(name.replace('_', ' ')+' / '+title);ax.tick_params(labelsize=8)
    fig.suptitle('Actual supports: blue scaffold / purple interface; orange model shown faintly')
    fig.tight_layout();fig.savefig(OUT / 'support-details.png', dpi=150);plt.close(fig)
    keys = ['printer_model', 'nozzle_diameter', 'layer_height', 'initial_layer_print_height', 'curr_bed_type',
            'support_type', 'support_style', 'support_on_build_plate_only', 'support_threshold_angle',
            'support_top_z_distance', 'support_bottom_z_distance', 'support_object_xy_distance',
            'support_interface_top_layers', 'support_interface_bottom_layers', 'support_interface_spacing',
            'nozzle_temperature', 'nozzle_temperature_initial_layer', 'textured_plate_temp',
            'textured_plate_temp_initial_layer', 'print_sequence', 'brim_type', 'raft_layers']
    report = {'revision': inputs['revision'], 'reference_only': True, 'printer_contacted': False,
              'pieces': len(effective), 'plates': 1, 'total_g': plate['filaments'][0]['total_used_g'],
              'total_minutes': plate['total_predication']/60, 'warning': plate['warning_message'],
              'deposited_g_by_role': {k: round(v*factor, 4) for k, v in lengths.items()},
              'objects': object_report, 'gaps': gaps, 'effective_settings': {k: settings.get(k) for k in keys},
              'effective_object_settings': effective,
              'verified_gcode_heat_waits_c': {'bed': bed_temp, 'nozzle': nozzle_temp},
              'gcode_md5': hashlib.md5(gcode).hexdigest(),
              'hashes': {name: hashlib.sha256((OUT/name).read_bytes()).hexdigest() for name in
                         ('actuator-input.3mf', 'actuator.gcode.3mf', 'machine.json', 'process.json', 'filament.json')},
              'limits': ['Not sent to printer; loaded material/bed/nozzle not verified for a live job.',
                         'Support removal, fit, layer strength, retention and safe button force need physical checks.',
                         'Per-role masses sum positive moving extrusion within labeled objects; startup purge is excluded.',
                         'Preview shows extrusion centerlines, not simulated bead width or validated support removability.']}
    notes = ['Physical support cleanup, running clearance and guide surfaces need inspection.']
    integration = Path(__file__).resolve().parents[1] / 'review/plunger-integration.json'
    if integration.exists():
        route = json.loads(integration.read_text())
        if route.get('revision') == inputs['revision'] and not route.get('routing_clear', False):
            notes.append('Assembly routing check fails: recorded twine interference remains unresolved. This slice does not validate assembly routing or authorize printing; see the separate job authorization/start record.')
    report['limits'].extend(notes)
    save(OUT / 'review.json', report)
    write_page(OUT, title='V3 actuator · single-plate slice review',
               subtitle=f"{report['pieces']} separate pieces at 100% scale · {inputs['revision']}",
               notes=notes,
               links=[{'label': 'Sliced Bambu Studio project', 'href': 'actuator.gcode.3mf'},
                      {'label': 'Editable arranged plate', 'href': 'actuator-input.3mf'},
                      {'label': 'Source geometry and object settings', 'href': 'inputs.json'},
                      {'label': 'Static support projections', 'href': 'support-details.png'},
                      {'label': 'Whole plate overview', 'href': 'plate-overview.png'}])
    print(json.dumps(report, indent=2), flush=True)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--output-dir', type=Path, default=OUT)
    OUT = parser.parse_args().output_dir.resolve()
    main()

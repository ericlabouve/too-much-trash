"""Verify the selected support-off axle recipe against the preserved ramped plate."""
import hashlib
import json
import math
import re
from pathlib import Path
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.collections import LineCollection
from prepare_actuator_plate import ROOT, OUT, save

OLD = ROOT / 'print/jobs/2026-10-14-actuator-ramped'


def axle_paths(folder):
    report = json.loads((folder/'result.json').read_text())['sliced_plates'][0]
    b = next(o['bbox'] for o in report['objects'] if o['name'] == 'pulley_axle')
    x = y = e = 0.
    absolute = False
    height = None
    feature = ''
    printing = False
    rows = []
    for line in (folder/'plate_1.gcode').read_text().splitlines():
        if line.startswith('; Z_HEIGHT:'): height = float(line.split(':')[1])
        elif line.startswith('; FEATURE:'): feature = line.split(':',1)[1].strip()
        elif line.startswith('; start printing object'): printing = True
        elif line.startswith('; stop printing object'): printing = False
        elif line.startswith('M82'): absolute = True
        elif line.startswith('M83'): absolute = False
        elif line.startswith('G92 E'): e = float(line.split(';')[0].split('E')[1].split()[0])
        elif line.startswith(('G0 ', 'G1 ', 'G2 ', 'G3 ')):
            v = {k:float(n) for k,n in re.findall(r'([XYE])(-?(?:\d+(?:\.\d*)?|\.\d+))',line.split(';')[0])}
            nx,ny = v.get('X',x),v.get('Y',y)
            ev = v.get('E',e if absolute else 0)
            de = ev-e if absolute else ev
            mx,my = (x+nx)/2,(y+ny)/2
            if printing and height is not None and de>0 and (nx!=x or ny!=y) and b['x']<=mx<=b['x']+b['width'] and b['y']<=my<=b['y']+b['depth']:
                assert not line.startswith(('G2 ', 'G3 ')), 'Arc fitting must remain disabled.'
                rows.append((height,feature,round(x,5),round(y,5),round(nx,5),round(ny,5),round(de,6)))
            x,y = nx,ny
            if 'E' in v: e = ev if absolute else e+ev
    return rows


def main():
    read = lambda p,n: json.loads((p/n).read_text())
    a,b = read(OLD,'review.json'),read(OUT,'review.json')
    ai,bi = read(OLD,'inputs.json'),read(OUT,'inputs.json')
    assert ai['revision']==bi['revision']=='ramped-retainers-v3'
    assert ai['parts']==bi['parts'], 'Geometry, orientation, quantity or placement changed.'
    for p in bi['parts']:
        assert hashlib.sha256((ROOT/'print'/(p['name']+'.stl')).read_bytes()).hexdigest()==p['input_sha256']
    for name in ('machine.json','process.json','filament.json'):
        assert read(OLD,name)==read(OUT,name)
    for key in ('effective_object_settings','object_settings'):
        left,right = (a,b) if key.startswith('effective') else (ai,bi)
        rows = lambda r: {o['name']:{k:v for k,v in o.items() if k!='id'} for o in r[key]}
        x,y = rows(left),rows(right)
        assert x['pulley_axle']['enable_support']=='1' and y['pulley_axle']['enable_support']=='0'
        x['pulley_axle']['enable_support']='0'
        assert x==y, 'Unexpected object-setting change.'
    assert b['objects']['pulley_axle']['support_z_mm'] is None
    previous,current = axle_paths(OLD),axle_paths(OUT)
    bridges = sorted(r for r in current if r[1]=='Bridge')
    assert bridges and bridges==sorted(r for r in previous if r[1]=='Bridge')
    assert not any(r[1].startswith('Support') for r in current)
    # The head-down slot roof is at print Z18.4; other Bridge roles include
    # internal infill and head surfaces, not this functional opening.
    slot_bridges = [r for r in bridges if 18.4 < r[0] < 18.8]
    assert slot_bridges
    # Auto bridge direction can be slightly skewed (~1.6 degrees here), not
    # exactly parallel to X. Require paths anchored across both slot edges.
    assert any(min(r[2],r[4])<=143.3 and max(r[2],r[4])>=146.7 and abs(r[5]-r[3])<.05*abs(r[4]-r[2]) for r in slot_bridges)
    first = min(r[0] for r in slot_bridges)
    layer = [r for r in current if r[0]==first]
    fig,ax = plt.subplots(figsize=(7,5))
    for bridge,color,width in ((False,'#bd9b74',.65),(True,'#128060',1.4)):
        lines = [((r[2],r[3]),(r[4],r[5])) for r in layer if (r[1]=='Bridge')==bridge]
        ax.add_collection(LineCollection(lines,colors=color,linewidths=width))
    ax.autoscale();ax.set_aspect('equal')
    ax.set(title=f'Axle slot roof · first bridge layer Z{first:.2f} mm\nGreen: actual bridge extrusion / tan: other model paths',xlabel='Bed X (mm)',ylabel='Bed Y (mm)')
    fig.tight_layout();fig.savefig(OUT/'axle-bridge.png',dpi=160);plt.close(fig)
    support = lambda r: sum(r['deposited_g_by_role'].get(k,0) for k in ('support','interface'))
    before,after = support(a),support(b)
    report = {'cad_revision':bi['revision'],'slice_recipe':bi['slice_recipe'],
              'geometry_placement_orientation_profiles_unchanged':True,
              'only_setting_change':'pulley_axle enable_support 1 → 0',
              'mount_hole':'Round, unchanged. Teardrop rejected by user.',
              'support_before_g':before,'support_after_g':after,'support_saved_g':before-after,
              'total_before_g':a['total_g'],'total_after_g':b['total_g'],
              'minutes_before':a['total_minutes'],'minutes_after':b['total_minutes'],
              'axle_support_after_g':support(b['objects']['pulley_axle']),
              'bridge_paths_identical_to_supported_slice':True,'bridge_segments':len(bridges),
              'slot_roof_bridge_heights_mm':sorted(set(r[0] for r in slot_bridges)),
              'slot_roof_bridge_segments':len(slot_bridges), 'nominal_slot_span_mm':3.4,
              'longest_slot_bridge_segment_with_anchors_mm':max(math.hypot(r[4]-r[2],r[5]-r[3]) for r in slot_bridges),
              'bridge_paths_sha256':hashlib.sha256(json.dumps(bridges).encode()).hexdigest(),
              'limits':['No printer contacted. Bridging success and cross-key fit remain untested.',
                        'Check for sag inside the slot before inserting the key; do not force it.',
                        'Existing mechanical checks remain applicable to unchanged geometry; this is not new physical validation.']}
    save(OUT/'comparison.json',report)
    html = (OLD/'index.html').read_text()
    banner = (f'<h2>Axle slot: bridge instead of support</h2><p>Same geometry, orientations, placements and profiles; '
              f'only axle supports are disabled. Support/interface: <b>{before:.3f} → {after:.3f} g</b>. '
              'The mounting hole remains round. Square slot retention faces remain unchanged. '
              '<a href="comparison.json">Verification report</a> · <a href="../2026-10-14-actuator-ramped/">Previous supported-axle plate</a></p>')
    html = re.sub(r'<main>.*?<h2>Inspect the actual supports</h2>', '<main>'+banner+'<h2>Inspect the actual supports</h2>',html,count=1,flags=re.S)
    html = html.replace('Seven separate pieces at 100% scale ·','Seven separate pieces at 100% scale · bridged axle slot ·')
    html = html.replace('check the small groove/slot regions in the preview. Any support here must be accessible and removable without damaging the running surface or cross-key slot.',
                        'neither receives support in this slice. The axle slot roof uses the same bridge paths as the previous supported slice. Check for sag and free cross-key insertion after printing; do not force the key.')
    html = html.replace('<details open>', '<h2>Axle bridge close-up</h2><img src="axle-bridge.png" alt="Actual first bridge layer spanning the axle slot"><p>The bridge spans the nominal 3.4 mm slot, with longer paths including anchored ends. This view does not predict sag or printed fit.</p><details open>',1)
    (OUT/'index.html').write_text(html)
    (OUT/'README.md').write_text(
        '# V3 actuator — bridged axle-slot recipe\n\n'
        'CAD remains `ramped-retainers-v3`; no geometry changed. User declined the teardrop mounting-hole roof; bore remains round. '
        'The sole object-setting change versus `../2026-10-14-actuator-ramped/` is axle `enable_support: 1→0`. '
        'Seven separate parts, orientation, placement, source hashes and all machine/process/filament profiles match.\n\n'
        f'Support/interface {before:.4f}→{after:.4f} g; total {b["total_g"]:.4f} g; {b["total_minutes"]:.2f} minutes. '
        'No axle supports; actual bridge extrusion paths match the previous supported slice. See `comparison.json` and `axle-bridge.png`.\n\n'
        'Open `index.html` through the CAD server for layer inspection. Full input/sliced 3MFs, source hashes, profiles, settings, logs and G-code are retained. '
        'Regenerate only in a new directory with `prepare_actuator_plate.py`; `--support-axle` restores the historical setting for comparisons. '
        'Audit with `review_actuator_plate.py` then `review_axle_bridge.py`.\n\n'
        'No print sent. Sag, slot clearance, keeper retention and loaded strength need physical checks. Inspect the slot and test the cross-key gently before assembly. '
        'Prior geometric checks remain applicable because all source meshes are unchanged; physical validation is still outstanding.\n')
    print(json.dumps(report,indent=2))


if __name__=='__main__':
    main()

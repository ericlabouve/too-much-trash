"""Compare preserved cuff slices; never reslice or contact a printer."""
import json
from pathlib import Path
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.collections import LineCollection

ROOT = Path(__file__).resolve().parents[1]
JOBS = ROOT / 'print/jobs'
CASES = {
    'Original side-down': '2026-10-16-cuff-fit-petg',
    'Side-down / omit detected bridge supports': '2026-10-16-cuff-bridge-study',
    'Curved back down / automatic supports': '2026-10-16-cuff-back-study',
}


def main():
    out = ROOT / 'review/cuff-support-study'
    out.mkdir(exist_ok=True)
    report = {'printer_contacted': False, 'geometry_changed': False, 'cases': []}
    fig, axes = plt.subplots(1, 3, figsize=(14, 5))
    source_hashes = None
    for ax, (title, directory) in zip(axes, CASES.items()):
        job = JOBS / directory
        review = json.loads((job / 'review.json').read_text())
        inputs = json.loads((job / 'inputs.json').read_text())
        hashes = {p['name']: p['input_sha256'] for p in inputs['parts']}
        if source_hashes is None:
            source_hashes = hashes
        assert hashes == source_hashes, 'Matched geometry required'
        paths = json.loads((job / 'paths.json').read_text())
        lines = np.fromfile(job / 'model.bin', dtype='<f4').reshape(-1, 2, 3)
        b = paths['objects']['fit-cuff']
        center = [b['x']+b['width']/2, b['y']+b['depth']/2]
        selected = lines[(np.abs(lines[:, :, 2]-.2) < .001).all(axis=1)]
        selected = selected[((selected[:, :, 0] >= b['x']-.5) &
                             (selected[:, :, 0] <= b['x']+b['width']+.5)).all(axis=1)]
        assert len(selected)
        xy = selected[:, :, :2] - center
        span = np.ptp(xy.reshape(-1, 2), axis=0)
        ax.add_collection(LineCollection(xy, colors='#d78942', linewidths=2))
        ax.set(xlim=(-8, 8), ylim=(-8, 8), xlabel='Bed X relative to cuff (mm)',
               ylabel='Bed Y relative to cuff (mm)', title=title.replace(' / ', '\n'))
        ax.set_aspect('equal'); ax.grid(alpha=.15)
        masses = review['deposited_g_by_role']
        report['cases'].append({'name': title, 'job': directory,
            'total_g': review['total_g'], 'total_minutes': review['total_minutes'],
            'support_and_interface_g': masses.get('support', 0)+masses.get('interface', 0),
            'cuff_first_layer_centerline_span_mm': span.tolist(),
            'first_layer_z_mm': .2, 'warnings': review['warning'],
            'gcode_md5': review['gcode_md5']})
    fig.suptitle('Actual cuff first-layer extrusion paths · same scale\nCenterlines, not a predicted adhesion/contact-area measurement')
    fig.tight_layout(rect=(0, 0, 1, .88)); fig.savefig(out / 'first-layer-comparison.png', dpi=140); plt.close(fig)
    first, bridge = list(CASES.values())[:2]
    report['bridge_option_paths_identical_to_baseline'] = all(
        (JOBS/first/f'{role}.bin').read_bytes() == (JOBS/bridge/f'{role}.bin').read_bytes()
        for role in ('model', 'support', 'interface', 'adhesion'))
    report['source_sha256'] = source_hashes
    report['limits'] = ['No physical print; PETG fit, adhesion and curved-seat finish unqualified.',
        'Existing 2.95 mm friction gap vs 3 mm rigid stem may jam; orientation does not fix this.',
        'Cuff and shared 12.2 mm key CAD unchanged. No active-jaw or actuator promotion.',
        'A sloped opening was not built because the back-down orientation generates zero supports.',
        'Support masses exclude startup purge; total mass is slicer estimate for all three parts.']
    (out / 'comparison.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()

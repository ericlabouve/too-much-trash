"""Matched offline PETG cap slices; output must be a fresh ignored directory.

Run from cad: uv run python versions/v4/source/check_cap_string_guides.py build/cap-guides
No printer is contacted. Requires installed Bambu Studio.
"""
import json
import sys
from pathlib import Path
import cadquery as cq
import build_preview as b

CAD = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(CAD / 'versions/v3/source'))
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review


def main():
    out = Path(sys.argv[1]).resolve()
    out.mkdir(parents=True, exist_ok=False)
    p = b.Parameters(phone_thickness=8, button_from_screen=4)
    baseline = b.shorter_cap_rails(b.shorten_clamp(b.shaft_cap(p)))
    baseline = baseline.cut(b.box(-10, 6.6, -8.8, 8.8, -40, 70))
    guided = b.cap_string_passages(baseline)
    source = out / 'source'
    source.mkdir()
    for name, shape in [('baseline', baseline), ('guided', guided)]:
        assert shape.val().isValid() and len(shape.solids().vals()) == 1
        cq.exporters.export(shape, str(source / (name + '.stl')))
    (source / 'fit-attachment-check.json').write_text(json.dumps({
        'revision': 'v4-cap-string-passages-3x2',
        'guide_bounds_mm': [3, 2], 'inscribed_diameter_mm': 2,
        'cord_diameter_mm': 1, 'screw_bore_ligament_mm': 1.35,
        'limits': ['Unprinted: strength, threading and wear require physical checks.']
    }, indent=2))
    plate.ROOT = CAD
    plate.SOURCE = source
    reports = {}
    for name in ('baseline', 'guided'):
        job = out / name
        plate.PARTS = {name: ((90, 90), 'Y', 90, 'Exterior X12 face down')}
        sys.argv = ['slice', '--output-dir', str(job)]
        plate.main(process_overrides={'bridge_no_support': '0'})
        review.OUT = job
        review.main(project_stem='cuff-fit', title='V4 cap ' + name,
                    detail_parts=[name], notes=[
                        'Matched A1 mini PETG 0.12 mm slices. Automatic supports ON.',
                        'Bridge suppression OFF. No printer contacted.'])
        reports[name] = json.loads((job / 'review.json').read_text())
    (out / 'comparison.json').write_text(json.dumps(reports, indent=2))


if __name__ == '__main__':
    main()

"""User-highlighted print-plane cleanup; geometry checks, not slice qualification."""
import json
import cadquery as cq
from pathlib import Path
from build import REVISION, overlap
from plunger_design import cassette, box, local_shape, cyl, BACK_Y, KEY_OUTBOARD, PULLEY_U
from thread_profile import make_parts, thread, cylinder

parts = cassette()
bracket, plunger, key = (parts[n] for n in ('actuator_bracket', 'plunger', 'pulley_key'))
# Entire shoe, blended root and plain stem, excluding the deliberately capped cleat.
plain = plunger.intersect(box(-1, 48, -20, 20, -1, 17)).val().BoundingBox()
assert abs(plain.ymin + 2) < 1e-5 and abs(plain.ymax - 2) < 1e-5
shoe = plunger.intersect(box(0, 4.35, -10, 10, -1, 17)).val().BoundingBox()
assert abs(shoe.zmin) < 1e-5 and abs(shoe.zmax - 16) < 1e-5
kb = key.val().BoundingBox()
assert abs(kb.ylen - 3) < 1e-5
# Head remains broader than the stem in X; it is not cut into a plain rod.
assert abs(kb.xlen - 7) < 1e-5
# The former key pocket must be filled right to the common bed plane, except
# for the axle bore. Probe within the old rectangular pocket and main spine.
patch = local_shape(box(5, 23, 3, 13, 0, 2.2).cut(cyl(PULLEY_U, 8, -1, 5, 4.3)))
missing = patch.cut(bracket).val().Volume()
assert missing < 1e-5, missing
assert abs(bracket.val().BoundingBox().ymax - BACK_Y) < 1e-5
axle_bounds = parts['pulley_axle'].val().BoundingBox()
assert abs(axle_bounds.ylen - (18.4 + KEY_OUTBOARD)) < 1e-5
assert abs(kb.ymin - BACK_Y - .4) < 1e-5
tab = overlap(bracket, cq.Workplane('XY').newObject([
    cq.Solid.makeCylinder(9.3, 1, cq.Vector(73, -4.4, 26), cq.Vector(1, 0, 0))]))
assert tab < 1e-5
screw = make_parts()['thumb_screw']
sb = screw.val().BoundingBox()
assert abs(sb.zmin - 2) < 1e-5 and abs(sb.zmax - 24) < 1e-5
expected = thread().intersect(cylinder(4.5, 18, 2)).union(cylinder(7, 4, 20))
assert screw.cut(expected).val().Volume() < 1e-6
assert expected.cut(screw).val().Volume() < 1e-6
for name, shape in {**parts, 'thumb_screw': screw}.items():
    assert shape.val().isValid() and len(shape.val().Solids()) == 1, name
report = {
    'revision': REVISION, 'passed': True,
    'shoe_and_plain_stem_y_bounds_mm': [plain.ymin, plain.ymax],
    'shoe_z_span_mm': shoe.zlen,
    'key_thickness_mm': kb.ylen, 'key_retaining_head_width_mm': kb.xlen,
    'flush_pulley_back': {'plane_y_mm': BACK_Y, 'missing_fill_mm3': missing,
                         'key_clearance_to_back_mm': kb.ymin - BACK_Y,
                         'retention_outboard_shift_mm': KEY_OUTBOARD,
                         'axle_span_mm': axle_bounds.ylen},
    'removed_tab_region_remaining_mm3': tab,
    'rail_screw_z_bounds_mm': [sb.zmin, sb.zmax],
    'thread_and_head_stations_unchanged': True,
    'limits': ['No slicing or printing performed for this cleanup.',
               'Rounded corners, keeper-band retention and contact force remain physically unvalidated.',
               'Earlier flat-back slice results apply to their saved inputs, not these modified parts.']}
out = Path(__file__).resolve().parents[1] / 'review/print-cleanup.json'
out.write_text(json.dumps(report, indent=2) + '\n')
print(json.dumps(report, indent=2), flush=True)

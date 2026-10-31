"""Geometry audit for the four selected support reductions; not print validation."""
import json
import math
from pathlib import Path
from build import REVISION
from plunger_design import cassette, box, local_shape

parts = cassette()
for name, shape in parts.items():
    assert shape.val().isValid() and len(shape.solids().vals()) == 1, name
bracket = parts['actuator_bracket']
# Post-print revision removes the outer fork, superseding its bed extension.
foot = local_shape(box(23.5, 25.5, 4.5, 11.5, 0, 2.6))
assert bracket.intersect(local_shape(box(24.01,25.5,4.5,11.5,0,2.6))).val().Volume() < 1e-6
assert abs(bracket.val().BoundingBox().ymax - 5.4) < 1e-5
def width_at(name, bounds, w):
    a,b,c,d = bounds
    sample = parts[name].intersect(local_shape(box(a,b,c,d,w,w+.001)))
    return sample.val().BoundingBox().zlen
# The existing nut-turning relief clips the opposite end of this fixed lip.
# Sample the intact half instead of treating that intentional cut as a ramp error.
fixed = [width_at('actuator_bracket',(0,11,58.4,65.1),w) for w in (7.21,8.25,9.29)]
moving = [width_at('plunger',(-5,5,41,51),w) for w in (12.81,13.85,14.89)]
assert 8.5 < fixed[0] < 8.55 and 10.45 < fixed[-1] < 10.51, fixed
assert 5 < moving[0] < 5.1 and 8.9 < moving[-1] < 9.01, moving
assert fixed == sorted(fixed) and moving == sorted(moving)
wheel = parts['pulley'].val().BoundingBox()
assert abs(wheel.ylen-4) < 1e-5 and abs(wheel.xlen-18) < 1e-5
report = {'revision': REVISION, 'passed': True,
          'fixed_cap_intact_half_widths_mm': fixed, 'moving_cap_sample_widths_mm': moving,
          'maximum_cap_side_expansion_mm': 2, 'cap_rise_mm': 2.1,
          'nominal_cap_side_angle_degrees': math.degrees(math.atan2(2.1,2)),
          'pulley_groove_flanks': {'radial_change_mm': 1.1, 'axial_change_mm': 1.2,
                                   'angle_degrees': math.degrees(math.atan2(1.2,1.1)),
                                   'overall_diameter_mm': wheel.xlen, 'overall_width_mm': wheel.ylen},
          'outer_leg_removed': True, 'flat_back_local_y_mm': 5.4,
          'unchanged': ['Return band path', 'Mount bore and reinforced root',
                        'Axle, cross-key and fasteners', 'Print orientations'],
          'limits': ['Angles describe main ruled slopes, excluding small edge rounds.',
                     'See matched slice for generated support, integration/service checks for clearances.',
                     'Retainer security, abrasion, print strength and button force remain untested.']}
(Path(__file__).resolve().parents[1]/'review/support-refinements.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))

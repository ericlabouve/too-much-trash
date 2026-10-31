"""Literal screenshot refinements after first actuator print; no strength claim."""
import json
from pathlib import Path
from build import overlap, REVISION
from plunger_design import cassette, box, cyl, local_shape, PULLEY_U, BEARING_TOP, boot_blend_points

p = cassette()
b, s, wheel, axle = (p[n] for n in ('actuator_bracket', 'plunger', 'pulley', 'pulley_axle'))
neck = {}
for v in (2.5, 5, 9.5, 11, 25, 35):
    cut = s.intersect(local_shape(box(-10, 10, v-.005, v+.005, 3.9, 6.9)))
    neck[str(v)] = cut.val().BoundingBox().zlen
assert all(abs(w-8) < 1e-4 for w in neck.values()), neck
boot = {}
for v in (-3.5, -2.5, -1.5, -.1):
    boot[str(v)] = s.intersect(local_shape(box(-10, 10, v-.005, v+.005, 4, 6.8))).val().BoundingBox().zlen
assert list(boot.values()) == sorted(boot.values(), reverse=True), boot
removed_outer = overlap(b, local_shape(box(5, 26.1, 1.4, 14.6, 10.9, 15.1)))
removed_leg = overlap(b, local_shape(box(24.01, 26.1, 4, 12, 0, 14)))
assert max(removed_outer, removed_leg) < 1e-5
plinth = local_shape(box(4.4, 24.5, 2, 14, 3.001, 4.2).cut(cyl(PULLEY_U, 8, 2, 4, 6.01)))
assert overlap(b, plinth) < 1e-5
boss_top = b.intersect(local_shape(cyl(PULLEY_U, 8, 0, 9, 5.7))).val().BoundingBox().ymin
assert abs(5.4-boss_top-BEARING_TOP) < 1e-4
guide = local_shape(box(8.4, 8.7, 27, 30, 3.4, 8.9))
assert guide.cut(b).val().Volume() < 1e-5
long_lip = local_shape(box(3.6,4,26,41,8.1,9.2))
assert long_lip.cut(b).val().Volume() < 1e-5
long_wall = local_shape(box(4.6,8.5,26,41,3.4,9.1))
assert long_wall.cut(b).val().Volume() < 1e-5
# October 16: opposite wall/lip now guides the shoe-end span as well.
front_wall = local_shape(box(-7.4,-4.6,3,17.9,3.4,9.1))
front_lip = local_shape(box(-4,-3.6,3,17.9,8.1,9.2))
assert front_wall.cut(b).val().Volume() < 1e-5
assert front_lip.cut(b).val().Volume() < 1e-5
assert overlap(b,local_shape(box(-8.8,8.8,.1,2.49,.1,2.5))) < 1e-5
assert overlap(b,local_shape(box(-8.9,-7.81,2.5,23.84,.1,3.1))) < 1e-5
curve=boot_blend_points()
slopes=[(q[1]-p[1])/(q[0]-p[0]) for p,q in zip(curve,curve[1:])]
assert all(a < b < 0 for a,b in zip(slopes,slopes[1:])), slopes
# The independent return stop engages stem travel well before the band anchor.
assert overlap(s.translate((1.9, 0, 0)), b) < 1e-5
assert overlap(s.translate((2.4, 0, 0)), b) > .01
stroke = {str(d): {n: overlap(s.translate((-d, 0, 0)), p[n]) for n in p if n != 'plunger'} for d in (0, .325, .65)}
assert all(v < .01 for row in stroke.values() for v in row.values()), stroke
# Nominal axial cavity: boss w8.2 to underside of unchanged axle head w13.2.
axial_gap = 13.2-BEARING_TOP-wheel.val().BoundingBox().ylen
assert axial_gap >= 1-1e-6
# Full range of wheel float: w8.2..12.2 to w9.2..13.2. No solid intersections.
float_samples = {str(d): {'bracket': overlap(wheel.translate((0,-d,0)), b), 'axle': overlap(wheel.translate((0,-d,0)), axle)} for d in (-.4, 0, .6)}
assert all(v < .01 for row in float_samples.values() for v in row.values()), float_samples
# Head cannot fit through wheel bore, and key cannot fit through bracket bore.
assert overlap(axle.translate((0, 1, 0)), wheel) > .01
assert overlap(p['pulley_key'].translate((0, -2, 0)), b) > .01
for n, shape in p.items():
    assert shape.val().isValid() and len(shape.val().Solids()) == 1, n
report = {'revision': REVISION, 'passed': True, 'neck_width_samples_mm': neck,
          'shoe_end_guide': {'v_range_mm':[2.5,25.5], 'side_gap_mm':.3, 'lip_gap_mm':.4},
          'straight_corner': {'front_v_mm':2.5, 'side_u_mm':-7.8, 'rail_clearance_preserved':True},
          'boot_blend': {'kind':'Spline fit to rational quadratic hyperbola segment', 'weight':1.4,
                         'v_range_mm':[-4,2], 'radius_range_mm':[6.5,4],
                         'tangents':'Vertical at boot, horizontal at neck; no inflection',
                         'formula_samples_v_w_mm':curve},
          'extended_guide': {'constant_height_to_v_mm':42, 'top_w_mm':9.5,
                             'lip_inner_u_mm':3.3, 'vertical_slider_clearance_mm':.4,
                             'wall_side_clearance_mm':.3, 'taper_end_v_mm':55},
          'boot_width_samples_mm': boot, 'removed_outer_support_mm3': removed_outer,
          'removed_leg_mm3': removed_leg, 'removed_plinth_mm3': overlap(b, plinth),
          'boss_height_from_bed_mm': BEARING_TOP, 'boss_extension_mm': 2,
          'pulley_translation_mm': 2, 'nominal_wheel_axial_clearance_mm': axial_gap,
          'axle_diametral_clearance_mm': .6, 'additional_axle_key_float_mm': .4,
          'wheel_float_samples': float_samples, 'return_stop_stem_gap_mm': 2,
          'return_stop_separation_from_fixed_anchor_mm': 5,
          'nominal_stroke': stroke, 'volumes_mm3': {n: v.val().Volume() for n, v in p.items()},
          'limits': ['Single-bearing cantilever stiffness, wear and axle-head/key retention need physical testing.',
                     'The return stop protects the band anchor, not the phone button; inline compliance still needs testing.',
                     '1 mm is total axial wheel clearance, not radial wobble or a prediction of printed tolerances.',
                     'No new print sent; earlier physical approvals do not qualify the changed bracket/plunger.']}
out = Path(__file__).resolve().parents[1] / 'review/post-print-refinements.json'
out.write_text(json.dumps(report, indent=2)+'\n')
print(json.dumps(report, indent=2), flush=True)

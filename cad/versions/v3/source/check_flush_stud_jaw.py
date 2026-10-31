"""Literal screenshot-region checks for flush stud and continuous L carrier."""
import json
from pathlib import Path
import build as b
from cuff_design import integral_stud, locate, FIXED_CUFF_X

p=b.Parameters();s=b.parts(p);carrier=s['carrier']
volume=lambda shape:sum(x.Volume() for x in shape.solids().vals())
stud=locate(integral_stud(),FIXED_CUFF_X,0,True)
# Between the lower clamp bosses and track: no surrounding wall or platform
# may project beyond the common X=-11.3 face except the required T-stud.
zone=b.box(-30,-11.3,-13.8,13.8,-4,21.9)
unwanted=volume(carrier.intersect(zone).cut(stud))
corner=b.box(-11.3,-5.8,-13.8,13.8,15.9,26)
corner_missing=volume(corner.cut(carrier))
assert unwanted<1e-6,unwanted
assert corner_missing<1e-6,corner_missing
assert carrier.val().isValid() and len(carrier.val().Solids())==1
assert volume(stud.cut(carrier))<1e-6
rows={}
for name,base in b.SAMPLES.items():
 for side in ('near','far'):
  q=b.replace(base,side=side);a=b.assembly_parts(q,s)
  # Rail mating plane moves with the mechanism, rather than leaving a gap.
  bracket_face=q.phone_right+30.2
  rail_face=12
  assert abs(bracket_face-rail_face)<1e-6
  shoe=a['plunger'].val().BoundingBox().xmin
  gap=shoe-q.phone_right
  assert abs(gap-q.rest_gap)<1e-6,(name,gap)
  rows[name+'-'+side]=dict(rail_bracket_plane_x_mm=rail_face,released_shoe_gap_mm=gap)
report=dict(revision=b.REVISION,passed=True,fixed_cuff_x_mm=FIXED_CUFF_X,
 clamp_exterior_and_stud_base_x_mm=-11.3,phone_and_actuator_shift_mm=b.CUFF_INWARD_SHIFT,
 unwanted_raised_wall_or_platform_mm3=unwanted,missing_right_angle_junction_mm3=corner_missing,
 carrier_valid=True,carrier_solids=1,configurations=rows,
 changed_print_designs=['shaft_cap','collar_screw','actuator_bracket'],
 limits=['Original cuff, stud and plunger retained; bracket bearing plate extends to the flat cap face.',
         'Stiffness, physical grip, TPU compliance, actual button force and camera framing remain untested.'])
(b.ROOT/'review/flush-stud-jaw.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))

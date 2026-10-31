import sys,json
from pathlib import Path
from dataclasses import replace
sys.path.insert(0,str(Path(__file__).resolve().parent))
import cadquery as cq
from build import SAMPLES
import model as m
root=Path(__file__).resolve().parents[1]/'review/concepts/closed-rail-sleeve-b';b=cq.importers.importStep(str(root/'b-bracket.step'))
def local(s,p):return s.translate((-p.phone_right,-p.button_y,-p.height)).translate((-8.35,-5.4,-8)).rotate((0,0,0),(1,0,0),-90).rotate((0,0,0),(0,0,1),90)
head=m.cylinder((-18,11.65,9.8),(0,1,0),4,14)
passage=m.cylinder((-18,15.65,9.8),(0,1,0),14,8.4)
assert head.intersect(b).val().Volume()<1e-5
assert passage.intersect(b).val().Volume()<1e-5
cap=m.shaft_cap(m.Parameters());jaw=m.carrier(m.Parameters());rows={}
for n,pa in SAMPLES.items():
 for side in ['near','far']:
  p=replace(pa,side=side)
  rows[n+'-'+side]={name:head.intersect(local(shape,p)).val().Volume() for name,shape in [('cap',cap),('jaw',jaw)]}
  assert max(rows[n+'-'+side].values())<1e-5
report={'head_envelope_diameter_mm':14,'head_shift_v_mm':-2,'head_bracket_intersection_mm3':0,'diameter_8p4_passage_through_both_holes_mm3':0,'head_context_intersections_mm3':rows,'tip_v_mm':45.85,'nut_v_range_mm':[29.65,35.65],'nominal_full_nut_engagement_mm':6,'limits':['Threaded hardware shape unchanged; screw/nut turn to engage at new axial position. No torque or clamp-force validation.']}
(root/'sleeve-hardware-check.json').write_text(json.dumps(report,indent=2)+'\n')
print(report)

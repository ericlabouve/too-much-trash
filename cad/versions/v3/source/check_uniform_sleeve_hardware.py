import sys,json
from pathlib import Path
from dataclasses import replace
sys.path.insert(0,str(Path(__file__).resolve().parent))
import cadquery as cq
from build import SAMPLES
import model as m
root=Path(__file__).resolve().parents[1]/'review/concepts/uniform-rail-sleeve-b';b=cq.importers.importStep(str(root/'b-bracket.step'))
def local(s,p):return s.translate((-p.phone_right,-p.button_y,-p.height)).translate((-8.35,-5.4,-8)).rotate((0,0,0),(1,0,0),-90).rotate((0,0,0),(0,0,1),90)
head=m.cylinder((-18,11,9.8),(0,1,0),4,14)
passage=m.cylinder((-18,15,9.8),(0,1,0),14,8.4)
assert head.intersect(b).val().Volume()<1e-5
assert passage.intersect(b).val().Volume()<1e-5
cap=m.shaft_cap(m.Parameters());jaw=m.carrier(m.Parameters());rows={}
for n,pa in SAMPLES.items():
 for side in ['near','far']:
  p=replace(pa,side=side)
  rows[n+'-'+side]={name:head.intersect(local(shape,p)).val().Volume() for name,shape in [('cap',cap),('jaw',jaw)]}
  assert max(rows[n+'-'+side].values())<1e-5
# Full turning envelope around the moved nut, with0.3 mm radial margin.
nut=m.cylinder((-18,24.25,9.8),(0,1,0),6,18.6)
assert nut.intersect(b).val().Volume()<1e-5
plunger=cq.importers.importStep(str(root/'b-plunger.step'))
rigid={str(d):nut.intersect(plunger.translate((0,d,0))).val().Volume() for d in [-6,-3,-1.5,0,.39]}
assert max(rigid.values())<1e-5
# Conservative spherical caps along every0.1 mm on the band/string segments.
import numpy as np
route_gaps=[]
for f in json.loads((root/'motion-paths.json').read_text()):
 for key,margin in [('band',1.5),('attachment',.5),('lead',.5)]:
  points=np.array(f[key]);samples=[]
  for a,z in zip(points[:-1],points[1:]):
   count=int(np.ceil(np.linalg.norm(z-a)/.1))+1
   samples.extend(np.linspace(a,z,count))
  q=np.array(samples);rad=np.maximum(np.sqrt((q[:,0]+18)**2+(q[:,2]-9.8)**2)-9.3,0)
  axial=np.maximum(np.maximum(24.25-q[:,1],q[:,1]-30.25),0)
  gap=float(np.min(np.sqrt(rad**2+axial**2)))-margin-.05
  assert gap>0,(f['travel'],key,gap)
  route_gaps.append(gap)
report={'minimum_moved_nut_route_gap_mm':min(route_gaps),'nut_reserved_envelope_bracket_mm3':0,'nut_plunger_motion_mm3':rigid,'head_envelope_diameter_mm':14,'head_shift_v_mm':-2.65,'head_bracket_intersection_mm3':0,'diameter_8p4_passage_through_both_holes_mm3':0,'head_context_intersections_mm3':rows,'tip_v_mm':45.2,'nut_v_range_mm':[24.25,30.25],'nominal_full_nut_engagement_mm':6,'limits':['Threaded hardware shape unchanged; screw/nut turn to engage at new axial position. No torque or clamp-force validation.']}
(root/'sleeve-hardware-check.json').write_text(json.dumps(report,indent=2)+'\n')
print(report)

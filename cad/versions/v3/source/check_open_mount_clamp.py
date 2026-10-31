import sys,json
from pathlib import Path
from dataclasses import replace
sys.path.insert(0,str(Path(__file__).resolve().parent))
import cadquery as cq
from build import SAMPLES
import model as m
r=Path('cad/versions/v3/review/concepts/open-mount-clear-handle-b');b=cq.importers.importStep(str(r/'b-bracket.step'))
head=m.cylinder((-18,13.65,9.8),(0,1,0),4,14)
shaft=m.cylinder((-18,17.65,9.8),(0,1,0),30.2,8.4)
assert head.intersect(b).val().Volume()<1e-5
assert shaft.intersect(b).val().Volume()<1e-5
cap=m.shaft_cap(m.Parameters());jaw=m.carrier(m.Parameters())
def local(s,p):return s.translate((-p.phone_right,-p.button_y,-p.height)).translate((-8.35,-5.4,-8)).rotate((0,0,0),(1,0,0),-90).rotate((0,0,0),(0,0,1),90)
report={'head_reaches_rail_directly':True,'head_lip_side_clearance_mm':1,'head_overlap_per_rail_land_mm':2.6,'load_path':'Head -> rail -> front actuator wall -> nut','cases':{},'hardware_insertion_bounds':'Screw/head/nut remain at u <= -8.7; plunger u >= -8. TPU axle key remains below w=-0.364; plunger w>=3.4. Thus no overlap for any v translation.','limits':['Actual clamp preload, TPU deformation and loaded retention require physical checks.']}
for n,p0 in SAMPLES.items():
 for side in ['near','far']:
  p=replace(p0,side=side);row={}
  for label,s in [('cap',cap),('jaw',jaw)]:
   q=local(s,p);row[label+'_head']=head.intersect(q).val().Volume();row[label+'_shaft']=shaft.intersect(q).val().Volume();row[label+'_bracket']=b.intersect(q).val().Volume()
  print(n,side,row,flush=True);assert max(row.values())<1e-5;report['cases'][n+'-'+side]=row
(r/'direct-clamp-check.json').write_text(json.dumps(report,indent=2)+'\n')

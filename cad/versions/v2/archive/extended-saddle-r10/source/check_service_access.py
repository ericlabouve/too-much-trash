"""Near-side actuator service path for the extended collar.
Sampled rigid clearance, not finger access, friction or a force simulation.
Remove phone and release twine tension before following this sequence.
"""
import json
from pathlib import Path
from build import SAMPLES
import model as m
p=m.Parameters();s=m.parts(p)
def vol(v):return sum(t.Volume() for t in v.solids().vals())
def overlap(a,b):
 aa=a.val().BoundingBox();bb=b.val().BoundingBox()
 if any(getattr(aa,k+'max')<=getattr(bb,k+'min')+1e-7 or getattr(bb,k+'max')<=getattr(aa,k+'min')+1e-7 for k in 'xyz'):return 0.
 return vol(a.intersect(b))
module=['actuator_bracket','rocker','pivot_key','contact_screw','rail_screw_1','rail_screw_2','rail_nut_1','rail_nut_2']
fixed=['carrier','shaft_cap','sliding_jaw','clamp_screw_1','clamp_screw_2','clamp_nut_1','clamp_nut_2']
report={}
for name,p in SAMPLES.items():
 a=m.assembly_parts(p,s)
 # At least Y25 for the lower-Y screw. Large example is already Y41.
 dy=max(0,25-(p.button_y-24));hits=[]
 for i in range(int(dy)+1):
  for n in module:
   part=a[n].translate((0,i,0))
   for o in fixed:
    v=overlap(part,a[o])
    if v>.01:hits.append(['module-slide',i,n,o,round(v,4)])
 # Remove rail nuts toward +X, then lift the actuator module off the screws.
 for dx in range(25):
  for n in ('rail_nut_1','rail_nut_2'):
   y=p.button_y+(-24 if n.endswith('_1') else 24)+dy
   # Cylinder bounds every nut rotation. Mating thread engagement is excluded;
   # a real nut unscrews helically, not by straight translation through threads.
   moving=m.cylinder((28+dx,y,-14),(1,0,0),6,18)
   mate='rail_screw_'+n[-1]
   for o in fixed+[k for k in module if not k.startswith('rail_nut_') and k!=mate]:
    target=a[o].translate((0,dy,0)) if o in module else a[o]
    v=overlap(moving,target)
    if v>.01:hits.append(['rail-nut-removal',dx,n,o,round(v,4)])
 for dx in range(31):
  for n in ('actuator_bracket','rocker','pivot_key','contact_screw'):
   moving=a[n].translate((dx,dy,0))
   for o in fixed+['rail_screw_1','rail_screw_2']:
    target=a[o].translate((0,dy,0)) if o.startswith('rail_screw_') else a[o]
    v=overlap(moving,target)
    if v>.01:hits.append(['module-removal',dx,n,o,round(v,4)])
 # Nuts and module removed. Withdraw both screw envelopes -X.
 # Diameter8 entire shaft deliberately bounds thread crests (nose is smaller).
 for j,y in enumerate((p.button_y-24+dy,p.button_y+24+dy)):
  screw=m.cylinder((12,y,-14),(1,0,0),4,14).union(m.cylinder((16,y,-14),(1,0,0),20,8))
  for dx in range(25):
   moving=screw.translate((-dx,0,0))
   for o in fixed:
    v=overlap(moving,a[o])
    if v>.01:hits.append(['rail-screw-withdrawal',-dx,j+1,o,round(v,4)])
 report[name]={'near_service_dy_mm':dy,'rail_screw_centers_after_service_shift_y_mm':[p.button_y-24+dy,p.button_y+24+dy],'collisions':hits}
 print(name,json.dumps(report[name]),flush=True)
# Reproduce the straight-withdrawal defect: screw head meets cap after 2.7mm.
head=m.cylinder((12,5,-14),(1,0,0),4,14)
blocked_head=overlap(head.translate((-3,0,0)),s['shaft_cap'])
blocked_cap=overlap(s['shaft_cap'].translate((6,0,0)),head)
result={'revision':'extended-saddle-r10','configurations':report,'unshifted_defect_mm3':{'rail_head_withdrawal':blocked_head,'cap_with_rail_screw_installed':blocked_cap},'limits':['Near-side sampled rigid path; remove phone and release twine tension first.','Human finger access, support residue and print tolerances require physical checking.','Far-side module does not obstruct this cap; collar opening still a nominal fit target.'],'passed':all(not r['collisions'] for r in report.values())}
(Path(__file__).resolve().parents[1]/'review/service-access.json').write_text(json.dumps(result,indent=2)+'\n')
assert result['passed'],result
print('Service sequence passed',flush=True)

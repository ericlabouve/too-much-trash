"""Near-side actuator service path for the extended collar.
Sampled rigid clearance, not finger access, friction or a force simulation.
Remove phone and release twine tension before following this sequence.
"""
import json
from functools import lru_cache
from dataclasses import replace
from itertools import product
from pathlib import Path
from build import SAMPLES
import model as m
p=m.Parameters();s=m.parts(p)
def vol(v):return sum(t.Volume() for t in v.solids().vals())
@lru_cache(maxsize=4096)
def bounds(a):return a.val().BoundingBox()
def overlap(a,b):
 aa=bounds(a);bb=bounds(b)
 if any(getattr(aa,k+'max')<=getattr(bb,k+'min')+1e-7 or getattr(bb,k+'max')<=getattr(aa,k+'min')+1e-7 for k in 'xyz'):return 0.
 return vol(a.intersect(b))
module=['actuator_bracket','rocker','pivot_key','contact_screw','rail_screw_1','rail_screw_2','rail_nut_1','rail_nut_2']
fixed=['carrier','shaft_cap','sliding_jaw','clamp_screw_1','clamp_screw_2','clamp_screw_3','clamp_screw_4','clamp_nut_1','clamp_nut_2','clamp_nut_3','clamp_nut_4']
report={}
for (sample,base),side in product(SAMPLES.items(),('near','far')):
 name=sample+'-'+side;p=replace(base,side=side)
 a=m.assembly_parts(p,s)
 # Conservative crest/rotation envelopes avoid expensive repeated helix Booleans.
 # Mating thread engagement is not tested by this service-path audit.
 for j,y in enumerate((p.button_y-24,p.button_y+24),1):
  a[f'rail_screw_{j}']=m.cylinder((12,y,-14),(1,0,0),4,14).union(m.cylinder((16,y,-14),(1,0,0),20,8))
  a[f'rail_nut_{j}']=m.cylinder((28,y,-14),(1,0,0),6,18)
 for j,(y,z) in enumerate(m.CLAMP_STATIONS,1):
  a[f'clamp_screw_{j}']=m.cylinder((-16,y,z),(1,0,0),4,14).union(m.cylinder((-12,y,z),(1,0,0),20,8))
  a[f'clamp_nut_{j}']=m.cylinder((-14,y,z),(1,0,0),6,18)
 # Move the inner screw at least 25 mm from the rail center before withdrawal.
 dy=max(0,25-(p.button_y-24)) if side=='near' else min(0,-25-(p.button_y+24));hits=[]
 for step in range(int(abs(dy))+1):
  i=step if dy>=0 else -step
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
 # Nuts/module removed: move each screw independently beyond the upper ear.
 # The continuous rail slot allows this without disassembling the shaft clamp.
 withdrawal_y=50 if side=='near' else -50
 screw_ys=(p.button_y-24+dy,p.button_y+24+dy)
 for j,y in enumerate(screw_ys):
  screw=m.cylinder((12,y,-14),(1,0,0),4,14).union(m.cylinder((16,y,-14),(1,0,0),20,8))
  shift=withdrawal_y-y
  for step in range(int(abs(shift))+1):
   moved_y=step if shift>=0 else -step
   moving=screw.translate((0,moved_y,0))
   targets={o:a[o] for o in fixed}
   if j==0:
    remaining_y=screw_ys[1]
    targets['remaining_rail_screw']=m.cylinder((12,remaining_y,-14),(1,0,0),4,14).union(m.cylinder((16,remaining_y,-14),(1,0,0),20,8))
   for o,target in targets.items():
    v=overlap(moving,target)
    if v>.01:hits.append(['individual-rail-screw-slide',moved_y,j+1,o,round(v,4)])
  screw=screw.translate((0,shift,0))
  for dx in range(25):
   moving=screw.translate((-dx,0,0))
   for o in fixed:
    v=overlap(moving,a[o])
    if v>.01:hits.append(['rail-screw-withdrawal',-dx,j+1,o,round(v,4)])
 report[name]={'near_service_dy_mm':dy,'rail_screw_centers_after_service_shift_y_mm':list(screw_ys),'individual_screw_withdrawal_y_mm':withdrawal_y,'collisions':hits}
 print(name,json.dumps(report[name]),flush=True)
# Reproduce the straight-withdrawal defect: screw head meets cap after 2.7mm.
head=m.cylinder((12,5,-14),(1,0,0),4,14)
blocked_head=overlap(head.translate((-3,0,0)),s['shaft_cap'])
blocked_cap=overlap(s['shaft_cap'].translate((6,0,0)),head)
result={'revision':'compact-rails-r12','configurations':report,'unshifted_defect_mm3':{'rail_head_withdrawal':blocked_head,'cap_with_rail_screw_installed':blocked_cap},'limits':['Both orientations, sampled rigid path with conservative screw-crest and rotating-nut envelopes; remove phone and release twine tension first.','Human finger access, support residue and print tolerances require physical checking.','Both phone orientations use shaft-side actuator positions and require module removal for cap service.'],'passed':all(not r['collisions'] for r in report.values())}
(Path(__file__).resolve().parents[1]/'review/service-access.json').write_text(json.dumps(result,indent=2)+'\n')
assert result['passed'],result
print('Service sequence passed',flush=True)

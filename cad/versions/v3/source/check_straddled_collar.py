"""Four-bolt collar straddling the jaw; geometry and sampled service checks."""
import json
from collections import Counter
import build as b

p=b.SAMPLES['bare'];s=b.parts(p);a=b.assembly_parts(p,s)
assert Counter(z for y,z in b.CLAMP_STATIONS)=={-30:2,60:2}
assert b.CLAMP_TOP-b.CLAMP_BOTTOM==110
collars=('carrier','shaft_cap')
removed=b.box(-40,40,-40,40,-90,-40)
checks={}
for n in collars:
 shape=s[n]
 assert shape.val().isValid() and len(shape.val().Solids())==1
 old_tail=b.overlap(shape,removed)
 assert old_tail<1e-6,(n,old_tail)
 bores={}
 for y,z in b.CLAMP_STATIONS:
  v=b.overlap(shape,b.cylinder((-30,y,z),(1,0,0),60,8.8))
  assert v<1e-6,(n,y,z,v)
  bores[f'{y},{z}']=v
 checks[n]=dict(valid=True,solids=1,removed_tail_remaining_mm3=old_tail,bolt_bore_obstructions_mm3=bores)

# Remove phone, release twine and remove actuator first. Nut rotation uses
# its circumscribed cylinder. All four screws withdraw toward +X; nuts -X.
remaining=['carrier','shaft_cap','sliding_jaw','cuff_fixed','cuff_sliding_1','cuff_sliding_2']
hits=[]
for i,(y,z) in enumerate(b.CLAMP_STATIONS,1):
 for dx in range(0,41,2):
  screw=a[f'clamp_screw_{i}'].translate((dx,0,0))
  nut=b.cylinder((-20+b.CUFF_INWARD_SHIFT-dx,y,z),(1,0,0),6,18)
  for n in remaining:
   for kind,moving in [('screw',screw),('nut-rotation-envelope',nut)]:
    v=b.overlap(moving,a[n])
    if v>.01:hits.append([i,kind,dx,n,round(v,5)])
assert not hits,hits

# Accepted fit opening, not the historically larger stock proxy. Fasteners
# and actuator removed: cap must remain removable sideways without a loop.
neck=b.box(-p.collar_opening_x/2,p.collar_opening_x/2,-p.collar_opening_y/2,p.collar_opening_y/2,-100,115)
for n in collars:
 v=b.overlap(s[n],neck)
 assert v<1e-6,(n,v)
 checks[n]['accepted_neck_opening_obstruction_mm3']=v
cap_hits=[]
for dx in range(0,41,2):
 moving=s['shaft_cap'].translate((dx,0,0))
 for name,target in [('accepted-neck-envelope',neck),('carrier',s['carrier'])]:
  v=b.overlap(moving,target)
  if v>.01:cap_hits.append([dx,name,round(v,5)])
assert not cap_hits,cap_hits
stock=b.stock(p)
stock_hits={}
for n in collars:
 for name in ('stock_claws','stock_blue_brace'):
  v=b.overlap(s[n],stock[name])
  if v>.01:stock_hits[n+'/'+name]=v
assert not stock_hits,stock_hits
report=dict(revision=b.REVISION,passed=True,collar_body_z_mm=[b.CLAMP_BOTTOM,b.CLAMP_TOP],
 stations_yz_mm=b.CLAMP_STATIONS,axial_station_spacing_mm=90,fastener_pairs=4,
 left_pairs=2,right_pairs=2,collars=checks,fastener_removal_hits=hits,
 nominal_bore_to_neck_ligament_mm=15.5-4.4-p.collar_opening_y/2,
 rejected_candidate='Z+52 nuts hit the jaw-band cleat on axial withdrawal; use Z+60 with 3.5 mm vertical clearance.',
 sideways_cap_removal_hits=cap_hits,stock_claw_or_brace_hits=stock_hits,
 unchanged=['thumb_nut','phone_cuff','sliding_jaw'],
 limits=['Sampled rigid paths after phone, tension and actuator removal; not human hand access or strength proof.',
 'Stock proxy remains larger than the physically accepted opening; use a full printed fit test.',
 'No slicing or print authorization. Existing phone-fit and twine routing issues remain separate.'])
(b.ROOT/'review/straddled-collar.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2),flush=True)

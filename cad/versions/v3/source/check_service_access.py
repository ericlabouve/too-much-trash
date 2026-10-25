"""Slide outward before screw withdrawal; cuff integration service audit."""
import json
from pathlib import Path
from dataclasses import replace
from build import SAMPLES,shape_bounds,REVISION
from types import SimpleNamespace
translated_bounds={}
def shifted(s,delta):
 result=s.translate(delta);b=shape_bounds(s)
 translated_bounds[result]=SimpleNamespace(**{k+end:getattr(b,k+end)+delta[i] for i,k in enumerate('xyz') for end in ('min','max')})
 return result
def overlap(a,b):
 aa=translated_bounds.get(a) or shape_bounds(a);bb=translated_bounds.get(b) or shape_bounds(b)
 if any(getattr(aa,k+'max')<=getattr(bb,k+'min')+1e-7 or getattr(bb,k+'max')<=getattr(aa,k+'min')+1e-7 for k in 'xyz'):return 0.
 return sum(s.Volume() for s in a.intersect(b).vals())
import model as m
s=m.parts(m.Parameters());report={}
module=['actuator_bracket','plunger','pulley','pulley_axle','pulley_key']
fixed=['carrier','shaft_cap','sliding_jaw']+[f'clamp_{kind}_{i}' for kind in ('screw','nut') for i in range(1,5)]+[f'cuff_{station}' for station in ('fixed','sliding_1','sliding_2')]
samples={**SAMPLES,'inward-28.5':m.Parameters(phone_thickness=8,button_from_end=104.5)}
for name,base in samples.items():
 for side in ('near','far'):
  p=replace(base,side=side);a=m.assembly_parts(p,s);hits=[]
  # Keep evidence that the former direct withdrawal is obstructed.
  direct={n:round(v,5) for n in fixed if (v:=overlap(shifted(a['rail_screw_1'],(-14,0,0)),a[n]))>.01}
  # Loosen the nut, then slide the still-captured module toward the end of
  # its current wing. Slot center +/-50 remains inside the +/-54 endpoints.
  slot_y=50 if side=='near' else -50
  service_button_y=slot_y-m.MOUNT_Y
  delta_y=service_button_y-p.button_y
  travelling=module+['rail_screw_1','rail_nut_1']
  for i in range(21):
   dy=delta_y*i/20
   for n in travelling:
    moving=shifted(a[n],(0,dy,0))
    for other in fixed:
     v=overlap(moving,a[other])
     if v>.01:hits.append(['slide-outboard',dy,n,other,round(v,5)])
  a={n:shifted(part,(0,delta_y,0)) if n in travelling else part for n,part in a.items()}
  # Remove nut and screw completely before moving the module.
  # A cylindrical nut envelope includes its full rotation; exclude mating thread.
  for dx in range(21):
   nut=m.cylinder((p.phone_right+38+dx,slot_y,26),(1,0,0),6,18)
   for n in module+fixed:
    v=overlap(nut,a[n])
    if v>.01:hits.append(['nut-loosen',dx,n,round(v,5)])
  for dx in range(35):
   screw=shifted(a['rail_screw_1'],(-dx,0,0))
   for n in module+fixed:
    v=overlap(screw,a[n])
    if v>.01:hits.append(['screw-withdraw',dx,n,round(v,5)])
  targets={n:a[n] for n in fixed}
  moves=[('clearance',i/2,0) for i in range(10)]+[('lower',4.5,-i/5) for i in range(1,11)]+[('withdraw',4.5+dx,-2) for dx in range(1,41)]
  for stage,dx,dz in moves:
   for n in module:
    moving=shifted(a[n],(dx,0,dz))
    for other,part in targets.items():
     v=overlap(moving,part)
     if v>.01:hits.append([stage,dx,dz,n,other,round(v,5)])
  report[name+'-'+side]={'collisions':hits,'rail_slot_service_y_mm':slot_y,'slide_delta_y_mm':delta_y,'former_direct_screw_withdrawal_hits_at_14mm':direct}
  print(name+'-'+side,'collisions',len(hits),hits[:3],flush=True)
# Off the grabber, remove keeper band, withdraw cross-key -Z, then axle -Y.
axle_hits=[]
for dz in range(23):
 key=shifted(s['pulley_key'],(0,0,-dz))
 for n in ('actuator_bracket','pulley','pulley_axle','plunger'):
  v=overlap(key,s[n])
  if v>.01:axle_hits.append(['key',dz,n,round(v,5)])
for dy in range(23):
 axle=shifted(s['pulley_axle'],(0,-dy,0))
 for n in ('actuator_bracket','pulley','plunger'):
  v=overlap(axle,s[n])
  if v>.01:axle_hits.append(['axle',dy,n,round(v,5)])
retention={'head_obstruction_after_6mm_mm3':overlap(s['pulley_axle'].translate((0,6,0)),s['actuator_bracket']),'key_obstruction_mm3':overlap(s['pulley_key'].translate((0,-2,0)),s['actuator_bracket'])}
assert all(v>.01 for v in retention.values()),retention
result={'axial_retention':retention,'revision':REVISION,'configurations':report,'off_tool_axle_key_collisions':axle_hits,'passed':not axle_hits and all(not x['collisions'] for x in report.values()),'sequence':['Remove phone and release twine tension.','Loosen rail nut enough to slide, retaining screw and nut. Support the module.','Slide toward the OUTER end of its current rail wing, to screw center Y+50 near / Y-50 far. Do not cross the solid center.','Fully remove the rail nut toward +X, then withdraw the screw toward -X.','Pull complete module +X 4.5 mm along the conservative clearance path.','Lower module 2 mm along -Z, then continue withdrawal toward +X.','Off tool, remove keeper band, slide cross-key -Z, then pull axle -Y. Reverse for assembly.'],'limits':['Sampled rigid clearance only. Nut rotation uses a cylindrical envelope; thread engagement excluded.','Loosening/preload/friction and human access are not simulated. Verify the procedure on the printed assembly.','Former direct screw withdrawal is obstructed by the new fixed socket at near-side positions; do not force it.']}
(Path(__file__).resolve().parents[1]/'review/service-access.json').write_text(json.dumps(result,indent=2)+'\n')
assert result['passed'],result
print('Service and axle/key insertion paths passed',flush=True)

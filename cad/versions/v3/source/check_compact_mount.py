"""Check shortened-slot clearance and bearing land at both inner-window fasteners."""
import json
from dataclasses import replace
from pathlib import Path
import build as b
p=b.Parameters();parts=b.parts(p);rows={}
for name,base in b.SAMPLES.items():
 for side in ('near','far'):
  a=b.assembly_parts(replace(base,side=side),parts);r=[]
  for i in (1,2):
   nut=a[f'rail_nut_{i}'];screw=a[f'rail_screw_{i}']
   nut_land=b.overlap(nut.translate((-.1,0,0)),a['actuator_bracket'])/.1
   head_land=b.overlap(screw.translate((.1,0,0)),a['shaft_cap'])/.1
   collision=b.overlap(screw,a['shaft_cap'])
   assert nut_land>5 and head_land>5 and collision<.01,(name,side,i,nut_land,head_land,collision)
   r.append(dict(fastener=i,nut_bearing_area_estimate_mm2=nut_land,head_bearing_area_estimate_mm2=head_land,slot_intersection_mm3=collision))
  rows[name+'-'+side]=r
out={'passed':True,'configurations':rows,'limitations':['Bearing estimated using 0.1 mm virtual penetration; not a strength, preload, wear or printed tolerance calculation.','14 mm pocket fit conflicts are separate and remain unresolved for the recorded wallet/large envelopes.']}
(Path(__file__).resolve().parents[1]/'review/compact-mount.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out,indent=2))

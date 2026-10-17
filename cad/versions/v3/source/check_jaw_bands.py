"""Centered jaw-band geometric checks; no force/elasticity qualification."""
from pathlib import Path
import json
from dataclasses import replace
from build import SAMPLES,overlap
import model as m
solids=m.parts(m.Parameters());rows={}
for name,base in SAMPLES.items():
 p=base;a=m.assembly_parts(p,solids);_,bands,_=m.flexible_paths(p);hits={}
 for n in ('band_jaw_1','band_jaw_2'):
  band=m.polyline(bands[n],1.4)
  for target,part in a.items():
   v=overlap(band,part)
   if v>.01:hits[n+'/'+target]=round(v,4)
  v=overlap(band,m.stock(p)['phone_envelope'])
  if v>.01:hits[n+'/phone']=round(v,4)
 rows[name]={'band_levels_z_mm':list(m.JAW_BAND_LEVELS),'symmetric_force_center_y_mm':0,'post_span_x_mm':-27-(p.phone_left-1),'collisions':hits}
 print(name,rows[name],flush=True)
report={'revision':'t-jaw-compact-actuator-v3','configurations':rows,'passed':all(not x['collisions'] for x in rows.values()),'limitations':['1.4 mm circular band visualization is provisional; real width/thickness and stretched cross-section unknown.','Equal band tension is an assumption, not a measured force balance.','No claim of preload, jaw friction, fatigue or loaded retention.','Rounded rectangular paths wrap broad single cleats below retaining crossbars; actual band stacking and preload need physical validation.']}
(Path(__file__).resolve().parents[1]/'review/jaw-band-validation.json').write_text(json.dumps(report,indent=2)+'\n')
assert report['passed'],report

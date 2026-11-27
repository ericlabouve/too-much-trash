"""Sample common stop key against surrounding V4 rigid assembly and stock shaft."""
import json,sys
from pathlib import Path
from dataclasses import replace
from build_compact_mount_concept import geometry_compact
from build_preview import clamp_geometry
from build_travel_stops import overlap
from plunger_design import local_shape
import model,build
br,pl,key,context=geometry_compact()
p0=build.SAMPLES['wallet'];solids=model.parts(p0);cap,jaw,*_=clamp_geometry(p0)
solids.update(shaft_cap=cap,carrier=jaw,actuator_bracket=local_shape(br),plunger=local_shape(pl))
rows=[]
for sample,p in build.SAMPLES.items():
 for side in ('near','far'):
  p=replace(p,side=side);parts=model.assembly_parts(p,solids)
  for i in range(1,5):
   z=model.CLAMP_STATIONS[i-1][1]
   for stem in ('clamp_screw_','clamp_nut_'):parts[stem+str(i)]=parts[stem+str(i)].translate((0,0,5 if z<15 else -5))
  for n in parts:
   if n.startswith(('rail_screw_', 'rail_nut_')):parts[n]=parts[n].translate((0,1.4,0))
  targets={n:s for n,s in parts.items() if n in ('shaft_cap','carrier','sliding_jaw') or n.startswith(('clamp_screw_','clamp_nut_','rail_screw_','rail_nut_'))}
  targets['stock_neck']=model.stock(p)['stock_neck']
  for d in (0,3.15,6.3,9.45,12.6):
   k=model.placed(local_shape(key.translate((0,-d,0))),p)
   hits={n:overlap(k,s) for n,s in targets.items()};rows.append(dict(sample=sample,side=side,pull_mm=d,overlaps=hits))
   print(sample,side,d,max(hits.values()),flush=True)
Path(sys.argv[1]).write_text(json.dumps(rows,indent=2))
assert max(v for r in rows for v in r['overlaps'].values())<1e-5

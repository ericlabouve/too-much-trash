from pathlib import Path
import sys,json
from geometry_common_key import geometry_common_key
from build_travel_stops import overlap
from build import export
from shared_key_design import snap_key
out=Path(sys.argv[1]);out.mkdir(parents=True,exist_ok=True)
br,pl,key,ctx=geometry_common_key()
for n,s in {'bracket':br,'plunger':pl,'stop':snap_key(),**ctx}.items():
 assert s.val().isValid() and len(s.val().Solids())==1,n
 export(s,out/(n+'.stl'))
rows=[]
for d in sorted(set([i*.5 for i in range(107)]+[12.6])):
 m=pl.translate((0,-d,0));k=key.translate((0,-d,0))
 r={'d':d,'plunger_bracket':overlap(m,br),'plunger_context':sum(overlap(m,s) for s in ctx.values())}
 if d<=12.6:
  for lift in (0,.4,.8):
   floating=k.translate((0,0,lift))
   r.update({f'key_bracket_{lift}':overlap(floating,br),f'key_context_{lift}':sum(overlap(floating,s) for s in ctx.values())})
 rows.append(r)
 print(r,flush=True)
stops={'beyond_pull_mm3':overlap(key.translate((0,-12.8,0)),br),'upward_escape_mm3':overlap(key.translate((0,0,.9)),br)}
assert min(stops.values())>1e-5,stops
report={'positive_stop_checks':stops,'key_relaxed_span_mm':5,'plate_slot_width_mm':3.4,'nominal_each_side_retention_mm':.8,'seat_height_mm':1.8,'key_axial_play_mm':.8,'revision':'v4-common-key-seat-1p8','samples':rows,'limits':'Rigid insertion without key and operating sweep. TPU insertion deformation and retention need physical checks.'}
(out/'fit-attachment-check.json').write_text(json.dumps(report,indent=2))
assert max(v for r in rows for k,v in r.items() if k!='d')<1e-5

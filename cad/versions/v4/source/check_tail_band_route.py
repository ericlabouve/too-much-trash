"""Check schematic 1 mm cord and return band against the continuous tail-anchor surface."""
from pathlib import Path
import sys,json
sys.path.insert(0,str(Path(__file__).resolve().parents[2]/'v3/source'))
from build_steep_stop import prism
from plunger_design import _current_routes
from build_travel_stops import overlap
import cadquery as cq
from build_compact_mount_concept import geometry_compact
from plunger_design import box
lip=geometry_compact()[0].cut(geometry_compact(tail_anchor=False)[0])
r=min(_current_routes(),key=lambda f:abs(f['travel']))
def segment(a,b):
 d=cq.Vector(*b).sub(cq.Vector(*a));return cq.Workplane(obj=cq.Solid.makeCylinder(.5,d.Length,cq.Vector(*a),d.normalized()))
rows=[]
for i in range(21):
 d=12.6*i/20
 band=[(u,v+(8-d if 5<=j<=10 else 0),w) for j,(u,v,w) in enumerate(r['band'])]
 attachment=[(u,v+8-d,w) for u,v,w in r['attachment']]
 lead=[(r['lead'][0][0],r['lead'][0][1]+8-d,12.65),(r['lead'][1][0],r['lead'][1][1]+8-d,12.65)]
 hits={}
 for name,pts in [('band',band),('cord_wrap',attachment),('cord_lead',lead)]:
  hits[name]=sum(overlap(lip,segment(a,b)) for a,b in zip(pts,pts[1:]))
 rows.append({'travel_mm':d,**hits});print(rows[-1],flush=True)
Path(sys.argv[1]).write_text(json.dumps(rows,indent=2)+'\n')
assert max(max(r[k] for k in ('band','cord_wrap','cord_lead')) for r in rows)<1e-5

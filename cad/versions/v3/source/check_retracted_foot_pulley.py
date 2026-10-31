"""Check relocated pulley hardware against shortened bracket/plunger."""
import json
from pathlib import Path
import cadquery as cq
from plunger_design import cassette
r=Path(__file__).resolve().parents[1]/'review/concepts/retracted-foot-b'
b=cq.importers.importStep(str(r/'b-bracket.step'));p=cq.importers.importStep(str(r/'b-plunger.step'))
def inv(s):return s.translate((-8.35,-5.4,-8)).rotate((0,0,0),(1,0,0),-90).rotate((0,0,0),(0,0,1),90).translate((0,10.85,0))
parts=cassette();rows=[]
for name in ['pulley','pulley_axle','pulley_key']:
 s=inv(parts[name]);row={'part':name,'bracket_intersection_mm3':s.intersect(b).val().Volume(),'plunger_intersections_mm3':{str(d):s.intersect(p.translate((0,d,0))).val().Volume() for d in [-1.5,-.75,0]}}
 rows.append(row);print(row,flush=True)
assert all(q['bracket_intersection_mm3']<1e-5 and max(q['plunger_intersections_mm3'].values())<1e-5 for q in rows)
(r/'pulley-clearance.json').write_text(json.dumps(rows,indent=2)+'\n')

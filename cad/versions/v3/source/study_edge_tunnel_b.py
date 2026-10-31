"""Extend triangular capture to the front edge; preserve current plunger."""
import json,shutil
from pathlib import Path
import cadquery as cq
from build import export
from plunger_design import box
ROOT=Path(__file__).resolve().parents[1];src=ROOT/'review/concepts/seamless-lower-lip-b';out=ROOT/'review/concepts/edge-tunnel-b';out.mkdir(exist_ok=True)
for f in src.iterdir():
 if f.is_file():shutil.copy2(f,out/f.name)
b=cq.importers.importStep(str(src/'b-bracket.step'));p=cq.importers.importStep(str(src/'b-plunger.step'))
def prism(poly,v,length):
 w=cq.Wire.makePolygon([cq.Vector(u,v,z) for u,z in poly],close=True)
 return cq.Workplane('XY').newObject([cq.Solid.extrudeLinear(w,[],cq.Vector(0,length,0))])
inner=[(-4.965685,3),(4.965685,3),(1.1,6.865685),(-1.1,6.865685)]
outer=[(-6.2,0),(6.2,0),(6.2,4.3),(2.5,8),(-2.5,8),(-6.2,4.3)]
g=prism(outer,13.35,7.95).cut(prism(inner,13.3,8.1)).cut(box(-1.2,1.2,13.3,21.4,6,20))
# Continue shaft cross-section through the previously exposed transition; contact foot stays unchanged.
profile=[(-4,3.4),(4,3.4),(.8,6.6),(-.8,6.6)]
zone=box(-20,20,13.35,21.25,0,8)
p=p.cut(zone.cut(prism(profile,13.34,7.92))).clean()
# Round only convex exposed lip edges; keep the retaining root and main handle unchanged.
edges=[e for e in p.val().Edges() if e.BoundingBox().xmin < -3.5 and 9.5 < e.Center().z < 11.7 and 28.9 <= e.Center().y <= 33.1]
try:
 p=p.newObject(edges).fillet(.18).clean()
except Exception as ex:
 raise RuntimeError('Lip rounding failed') from ex
b=b.union(g).clean();assert b.val().isValid() and len(b.val().Solids())==1
rows=[]
for i in range(91):
 d=i*.5;v=p.translate((0,-d,0)).intersect(b).val().Volume();rows.append({'pull_mm':d,'overlap_mm3':v})
 if v>1e-5:print('COLLISION',d,v,flush=True)
print('MAX',max(r['overlap_mm3'] for r in rows),flush=True)
(out/'geometry-check.json').write_text(json.dumps({'revision':'edge-tunnel-b','guide_start_v_mm':13.35,'guide_end_v_mm':41.4,'length_mm':28.05,'extension_mm':7.9,'insertion':rows},indent=2))
assert max(r['overlap_mm3'] for r in rows)<1e-5
for ext in ['stl','step']:
 export(b,out/('b-bracket.'+ext));export(p,out/('b-plunger.'+ext))
shutil.copy2(out/'geometry-check.json',out/'fit-attachment-check.json')

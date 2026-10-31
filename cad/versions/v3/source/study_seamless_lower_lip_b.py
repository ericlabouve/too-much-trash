"""Lower retaining ledge per user's purple sketch; no upper red lip."""
import json,shutil
from pathlib import Path
import cadquery as cq
from build import export
ROOT=Path(__file__).resolve().parents[1];src=ROOT/'review/concepts/flat-handle-face-b';out=ROOT/'review/concepts/seamless-lower-lip-b';out.mkdir(exist_ok=True)
for name in ['b-bracket.step','b-bracket.stl','pulley.stl','pulley_axle.stl','pulley_axle.step','pulley_key.stl','shaft-cap.stl','rail-screw.stl','rail-nut.stl','anti-rotation-cheeks.stl','knot-envelope.stl','direct-clamp-check.json']:
 shutil.copy2(src/name,out/name)
p=cq.importers.importStep(str(src/'b-plunger.step'));b=cq.importers.importStep(str(src/'b-bracket.step'))
# Lower ledge: 1.1 mm beyond the handle flank, underside 35 degrees from bed.
poly=[(-0.8,9.64),(-3.6,11.6),(-0.8,11.6)]
wire=cq.Wire.makePolygon([cq.Vector(u,29.0,w) for u,w in poly],close=True)
lip=cq.Workplane('XY').newObject([cq.Solid.extrudeLinear(wire,[],cq.Vector(0,4.0,0))]);new=p.union(lip).clean();assert new.val().isValid() and len(new.val().Solids())==1
for ext in ['stl','step']:export(new,out/('b-plunger.'+ext))
added=new.cut(p).clean();export(added,out/'lower-lip.stl')
rows=[]
for i in range(91):
 d=i*.5;v=added.translate((0,-d,0)).intersect(b).val().Volume();assert v<1e-5,(d,v);rows.append({'pull_mm':d,'added_lip_bracket_overlap_mm3':v})
report={'revision':'seamless-lower-lip-b','lip_depth_mm':4.0,'lip_front_back_v':[29,33],'lip_top_w':11.6,'leftmost_u':-3.6,'flank_projection_mm':1.1,'underside_degrees_from_bed':34.992,'mount_gap_mm':1.8,'upper_red_lip_removed':True,'added_lip_insertion_samples':rows,'limits':['Wraps fitted after insertion; 45 mm is assembly travel, not operating stroke.','Band width and packed knot size unmeasured. Routes are schematic; physical seating and retention unverified.','Wheel and axle lie entirely right of added lip; screw/nut entirely left. Existing flat-face passage checks retained.']}
(out/'geometry-check.json').write_text(json.dumps(report,indent=2))
(out/'fit-attachment-check.json').write_text(json.dumps(report,indent=2))
frames=json.loads((src/'motion-paths.json').read_text())
for f in frames:
 f['band']=[[u,v,12.65 if abs(w-10.4)<.001 else w] for u,v,w in f['band']]
(out/'motion-paths.json').write_text(json.dumps(frames))
print('valid single solid; added lip insertion checks pass',flush=True)

"""Option A direct rail clamping and handle passage study; no active promotion."""
import json,shutil,math
from pathlib import Path
import cadquery as cq
from OCP.BRepExtrema import BRepExtrema_DistShapeShape
from build import export
from plunger_design import box
ROOT=Path(__file__).resolve().parents[1];src=ROOT/'review/concepts/aligned-pulley-b';out=ROOT/'review/concepts/open-mount-clear-handle-b';out.mkdir(exist_ok=True)
b=cq.importers.importStep(str(src/'b-bracket.step'));p=cq.importers.importStep(str(src/'b-plunger.step'))
# Full-height open rear strip, 16 mm between lips. Head bears directly at v17.65.
b=b.cut(box(-26,-10,13,17.401,-1,21)).clean()
# Compare a straight trim and a sloping trim; both remove only upper +u material.
# Retain full wrap neck below w13.1, and retain the large cap on the opposite side.
poly=[(1,9.8),(1,11.1),(2.5,12.2),(2.5,13.1),(1,14.2),(1,20),(20,20),(20,9.8)]
wire=cq.Wire.makePolygon([cq.Vector(u,24,w) for u,w in poly],close=True)
relief=cq.Workplane('XY').newObject([cq.Solid.extrudeLinear(wire,[],cq.Vector(0,12,0))])
p=p.cut(relief).clean()
for n,s in [('b-bracket',b),('b-plunger',p)]:
 assert s.val().isValid() and len(s.val().Solids())==1
 for ext in ['step','stl']:export(s,out/(n+'.'+ext))
for n in ['shaft-cap.stl','rail-nut.stl','pulley.stl','pulley_axle.stl','pulley_axle.step','pulley_key.stl','motion-paths.json','knot-envelope.stl']:
 shutil.copy2(src/n,out/n)
import trimesh
s=trimesh.load(src/'rail-screw.stl');s.apply_translation([0,2.65,0]);s.export(out/'rail-screw.stl')
export(b.intersect(box(-31,-5.4,14,24.251,-.01,20)),out/'anti-rotation-cheeks.stl')
U=10.475091906795965;V=16.3
wheel=cq.Workplane('XZ').polyline([(4.3,6.6),(9,6.6),(9,6.8),(6.8,8.4),(6.8,8.8),(9,10.4),(9,10.6),(4.3,10.6)]).close().revolve(360,(0,0),(0,1)).edges().fillet(.09).translate((U,V,4.05))
ax=cq.importers.importStep(str(src/'pulley_axle.step'))
def distance(a,z):
 q=BRepExtrema_DistShapeShape(a.val().wrapped,z.val().wrapped);q.Perform();return q.Value()
r={'revision':'open-mount-clear-handle-b-v1','rear_opening_mm':16,'screw_head_diameter_mm':14,'head_bearing_v_mm':17.65,'nut_bearing_v_mm':24.25,'rail_faces_v_mm':[17.65,21.85],'front_wall_mm':2.4,'positive_handle_limit_above_13p1_mm':1,'insertion':[],'limits':['Install band and string after rigid plunger insertion.','One-sided upper cap retention needs physical wrap testing.','No forward withdrawal stop; working stroke must retain triangle overlap.','No print or active V3 promotion.']}
# Tail v41 moves fully before channel front21.25 at pull20; extend to45 for complete clearance.
for d in range(46):
 pp=p.translate((0,-d,0));row={'pull_mm':d}
 for n,s in [('bracket',b),('wheel',wheel),('axle',ax)]:row[n+'_overlap_mm3']=pp.intersect(s).val().Volume()
 r['insertion'].append(row);print(row,flush=True)
 if max(v for k,v in row.items() if k!='pull_mm')>1e-5:
  (out/'fit-attachment-check.json').write_text(json.dumps(r,indent=2));raise RuntimeError(row)
r['minimum_wheel_gap_mm']=min(distance(p.translate((0,-d/2,0)),wheel) for d in range(91))
(out/'fit-attachment-check.json').write_text(json.dumps(r,indent=2)+'\n');print('DONE',r['minimum_wheel_gap_mm'],flush=True)

"""Join trimmed tail wall into mount and soften clipped anchor corners."""
import json,shutil
from pathlib import Path
import cadquery as cq
from plunger_design import box
from build import export
ROOT=Path(__file__).resolve().parents[1];src=ROOT/'review/concepts/symmetric-tail-b';out=ROOT/'review/concepts/braced-tail-b';out.mkdir(exist_ok=True)
for f in src.iterdir():
 if f.is_file():shutil.copy2(f,out/f.name)
b=cq.importers.importStep(str(src/'b-bracket.step'));p=cq.importers.importStep(str(src/'b-plunger.step'))
# Bed-grown constant-width wall joins the mount face to the existing tail wall.
brace=box(-9,-6.2,24.2,38.5,0,4.3)
new=b.union(brace).clean()
# Round the two plan-view corners of the clipped transverse anchor cap.
for y,cy in [(38.5,39.1),(44.4,44.4)]:
 corner=box(-9,-8.4,y,y+.6,7.2,10)
 keep=cq.Workplane('XY').center(-8.4,cy).circle(.6).extrude(11)
 new=new.cut(corner.cut(keep))
new=new.clean();assert new.val().isValid() and len(new.val().Solids())==1
rows=[]
for i in range(91):
 d=i*.5;v=p.translate((0,-d,0)).intersect(new).val().Volume();assert v<1e-5,(d,v);rows.append({'pull_mm':d,'overlap_mm3':v})
# Conservative circumscribed nut envelope, seated beyond the mount front face.
nut=cq.Workplane('XZ',origin=(-18,24.25,9.8)).circle(9).extrude(-6)
assert brace.intersect(nut).val().Volume()<1e-5
for ext in ['stl','step']:export(new,out/('b-bracket.'+ext))
r={'revision':'braced-tail-b','wall_u_mm':[-9,-6.2],'wall_v_mm':[24.2,38.5],'wall_height_mm':4.3,'anchor_corner_radius_mm':.6,'nut_envelope_overlap_mm3':0,'insertion':rows,'valid_single_solid':True,'limits':['Nominal nut envelope is tangent to outer wall plane; real turning clearance and strength need fit testing.','No print or active promotion.']}
for n in ['geometry-check.json','fit-attachment-check.json']:(out/n).write_text(json.dumps(r,indent=2))
print('Valid solid; 91 insertion checks and nut clearance pass')

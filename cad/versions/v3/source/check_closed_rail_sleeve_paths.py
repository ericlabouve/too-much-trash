"""Conservative bounds for new cheeks; unchanged prior mechanism checks remain separate."""
import json
from pathlib import Path
import numpy as np
import cadquery as cq
from build import export
from plunger_design import box
r=Path(__file__).resolve().parents[1]/'review/concepts/closed-rail-sleeve-b'
b=cq.importers.importStep(str(r/'b-bracket.step'));p=cq.importers.importStep(str(r/'b-plunger.step'))
# All new material lies inside this bounding box; relief only removes old material.
lo=np.array([-30.6,15.65,0]);hi=np.array([-5.4,24.45,19.8]);rows=[]
for f in json.loads((r/'motion-paths.json').read_text()):
 for name,margin in [('band',[.5,.5,1.5]),('attachment',[.5,.5,.5]),('lead',[.5,.5,.5])]:
  a=np.array(f[name]);gap=np.maximum(np.maximum(lo-(a.max(0)+margin),(a.min(0)-margin)-hi),0)
  assert gap.max()>0,(f['travel'],name)
  rows.append({'travel':f['travel'],'route':name,'aabb_separation_mm':float(np.linalg.norm(gap))})
 a=(-4.9,27.4+f['travel'],12.65);knot=cq.Workplane('XY').sphere(1.5).translate(a)
 gap=b.val().distance(knot.val());assert gap>0.05,(f['travel'],gap)
 rows.append({'travel':f['travel'],'route':'knot','solid_separation_mm':gap})
motion={str(d):p.translate((0,d,0)).intersect(b).val().Volume() for d in [-6,-3,-1.5,0,.39]}
assert max(motion.values())<1e-5
(r/'added-material-clearance.json').write_text(json.dumps({'method':'Conservative AABBs separate band/string from added cheeks; exact 1.5 mm-radius knot sphere measured against complete bracket where combined bounds overlap. Not elastic-band validation.','minimum_route_aabb_gap_mm':min(q.get('aabb_separation_mm',q.get('solid_separation_mm')) for q in rows),'rows':rows,'plunger_motion_mm3':motion},indent=2)+'\n')
# Cropped actual rail for close-up; full cap is also retained.
import trimesh
cap=trimesh.load(r/'shaft-cap.stl',force='mesh')
# Obtain exact cap shape again rather than crop triangles and leave open mesh edges.
from build import SAMPLES
import model as m
q=m.shaft_cap(m.Parameters());pa=SAMPLES['bare']
q=q.translate((-pa.phone_right,-pa.button_y,0)).translate((-8.35,-5.4,-8)).rotate((0,0,0),(1,0,0),-90).rotate((0,0,0),(0,0,1),90)
export(q.intersect(box(-33,-3,15,22,-5,25)),r/'rail-section.stl')
print('New cheeks clear all21 nominal path frames; plunger motion clear.',flush=True)

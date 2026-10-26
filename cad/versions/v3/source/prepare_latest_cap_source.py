"""Accepted tall-cap print geometry with current thicker rail-slot ends."""
import json
from pathlib import Path
import cadquery as cq
import model as m
root=Path(__file__).resolve().parents[1]
out=root/'print/jobs/2026-10-26-final-materials-source';out.mkdir(exist_ok=True)
cap=m.box(-4.8,12,-13.8,13.8,m.CLAMP_BOTTOM,m.CLAMP_TOP)
for y,z in m.CLAMP_STATIONS:
 cap=cap.union(m.cylinder((-4.8,y,z),(1,0,0),18.6,18))
 cap=cap.union(m.box(-4.8,13.8,min(y,11),max(y,-11),z-9,z+9))
 cap=cap.cut(m.cylinder((-15,y,z),(1,0,0),30,8.8))
cap=cap.cut(m.box(-5.8,5.8,-8.8,8.8,-41,71))
cap=cap.union(m.paired_neck_rail().translate((m.CUFF_INWARD_SHIFT,0,0)))
cap=cap.intersect(m.box(-20,12,-70,70,-38.5,68.5))
cap=cap.cut(m.box(-10,15,-5.5,5.5,-30,60).edges('|X').fillet(5.49)).clean()
assert cap.val().isValid() and len(cap.val().Solids())==1
assert abs(cap.val().BoundingBox().xmin+4.8)<1e-6
for y,z in m.CLAMP_STATIONS:assert cap.intersect(m.cylinder((-23,y,z),(1,0,0),40,8.79)).val().Volume()<1e-6
shape=cap.rotate((0,0,0),(0,1,0),90).rotate((0,0,0),(0,0,1),90)
for ext in ('step','stl'):cq.exporters.export(shape,str(out/('shaft_cap.'+ext)),**({'tolerance':.015,'angularTolerance':.1} if ext=='stl' else {}))
p=root/'review/compact-rigid/layout.json';r=json.loads(p.read_text());r['sources']['shaft_cap']=str((out/'shaft_cap.stl').relative_to(root));r['sources']['sliding_jaw']='print/sliding_jaw.stl';r['limits']=['Approved tall cap and ramped fixed jaw retained; current 4 mm sliding windows and 2.6 mm cap end ligaments. Actual paths require fresh slice audit.'];p.write_text(json.dumps(r,indent=2)+'\n')

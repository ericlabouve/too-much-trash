"""Measure available rigid travel; does not modify manufacturing geometry."""
import sys,json,math
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parent))
import cadquery as cq
from plunger_design import box
from OCP.BRepExtrema import BRepExtrema_DistShapeShape
root=Path(__file__).resolve().parents[1]/'review/concepts/aligned-pulley-b'
b=cq.importers.importStep(str(root/'b-bracket.step'));p=cq.importers.importStep(str(root/'b-plunger.step'));ax=cq.importers.importStep(str(root/'pulley_axle.step'))
U=10.475091906795965;V=16.3
wheel=cq.Workplane('XZ').polyline([(4.3,6.6),(9,6.6),(9,6.8),(6.8,8.4),(6.8,8.8),(9,10.4),(9,10.6),(4.3,10.6)]).close().revolve(360,(0,0),(0,1)).edges().fillet(.09).translate((U,V,4.05))
green=b.intersect(box(-31,-5.4,14,24.251,-.01,20))
handle=p.intersect(box(-10,10,26,36,7.7,20))
def dist(a,z):
 q=BRepExtrema_DistShapeShape(a.val().wrapped,z.val().wrapped);q.Perform();return q.Value()
def hit(s,t):return p.translate((0,-t,0)).intersect(s).val().Volume()>1e-6
r={'handle_center_v_mm':31,'cord_tangent_v_mm':16.3,'handle_center_to_tangent_mm':14.7,'cord_attachment_to_tangent_mm':11.6,'samples':[]}
for t in [0,6,7,8,10,11.6,14.7]:
 row={'pull_mm':t,'handle_wheel_gap_mm':dist(handle.translate((0,-t,0)),wheel),'handle_green_gap_mm':dist(handle.translate((0,-t,0)),green),'full_plunger_wheel_overlap_mm3':p.translate((0,-t,0)).intersect(wheel).val().Volume()};r['samples'].append(row);print(row,flush=True)
for n,s in [('wheel',wheel),('bracket',b),('axle',ax)]:
 first=None
 for t in range(1,21):
  if hit(s,t):first=t;break
 if first:
  lo,hi=first-1,first
  for _ in range(16):
   mid=(lo+hi)/2
   if hit(s,mid):hi=mid
   else:lo=mid
  r[n+'_first_contact_pull_mm']=(lo+hi)/2
 else:r[n+'_first_contact_pull_mm']=None
 print(n,r.get(n+'_first_contact_pull_mm'),flush=True)
r['guide_overlap_at_wheel_contact_mm']=19.75-r['wheel_first_contact_pull_mm']
r['limits']=['Rigid CAD contact threshold only; band, string, knot, phone/button and actual squeeze stroke may reduce usable travel.','Center-to-tangent distance is not the available mechanical stroke.']
(root/'travel-measurement.json').write_text(json.dumps(r,indent=2)+'\n')
print(json.dumps(r,indent=2),flush=True)

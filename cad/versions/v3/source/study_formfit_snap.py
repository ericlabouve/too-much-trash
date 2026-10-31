"""Form-fitting C clip with locally flat square press-stud ends."""
import json
from pathlib import Path
import cadquery as cq
from build import export
OUT=Path(__file__).resolve().parents[1]/'review/concepts/formfit-square-clip';OUT.mkdir(parents=True,exist_ok=True)
W,H=12.8,17.8
outer=cq.Workplane('XY').rect(W+3.2,H+3.2).extrude(6).edges('|Z').fillet(1.5)
inner=cq.Workplane('XY').rect(W,H).extrude(8).translate((0,0,-1)).edges('|Z').fillet(.4)
frame=outer.cut(inner).cut(cq.Workplane('XY').box(14,17.8,10).translate((13,0,3)))
frame=frame.union(cq.Workplane('XY').center(0,13.3).circle(4).extrude(6)).cut(cq.Workplane('XY').center(0,13.3).circle(2).extrude(8).translate((0,0,-1))).cut(inner)
# Latch lies outside neck; ends retain 6x1.6 cross-section locally.
x=9.4
male=cq.Workplane('XY').box(6,11.9,1.6,centered=(True,True,False)).translate((x,-2.95,0))
peg=cq.Workplane('XY').workplane(offset=1.6).center(x,0).rect(2.6,2.6).extrude(1.9)
lip=cq.Workplane('XY').workplane(offset=3.5).center(x,0).rect(2.6,2.6).workplane(offset=.45).rect(3.2,3.2).loft()
tip=cq.Workplane('XY').workplane(offset=3.95).center(x,0).rect(3.2,3.2).workplane(offset=.45).rect(2.4,2.4).loft()
male=male.union(peg).union(lip).union(tip)
receiver=cq.Workplane('XY').box(6,11.9,1.6,centered=(True,True,False)).translate((x,2.95,0)).cut(cq.Workplane('XY').center(x,0).rect(3,3).extrude(3))
pivot=(7.2,8.9,0)
opened=receiver.rotate(pivot,(7.2,8.9,1),55)
root=cq.Workplane('XY').center(7.2,8.9).circle(1.4).extrude(1.6)
frame=frame.union(root)
part=frame.union(male).union(opened).clean()
assert part.val().isValid() and len(part.val().Solids())==1
closed_receiver=receiver.translate((0,0,1.8))
assert male.intersect(closed_receiver).val().Volume()<1e-6
for n,s in [('clip',part),('frame',frame),('male',male),('receiver-seated',closed_receiver)]:export(s,OUT/(n+'.stl'))
export(part,OUT/'clip.step')
r={'revision':'formfit-square-snap-v1','nominal_inside_mm':[W,H],'body_depth_mm':6,'wall_mm':1.6,'closure_section_mm':[6,1.6],'hole_mm':3,'peg_mm':2.6,'lip_mm':3.2,'receiver_print_angle_deg':55,'assembly_twist_deg':0,'valid_single_solid':True,'seated_latch_intersection_mm3':0,'limits':['Closed receiver placement is schematic bending, not an elastic deformation simulation.','Local closure ends are flat 6x1.6 tabs outside the neck; body retains original C shape.','Fit, flex force, retention and creep untested. No print.']}
(OUT/'fit-attachment-check.json').write_text(json.dumps(r,indent=2)+'\n')
print(r)

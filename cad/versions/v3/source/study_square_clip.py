"""Constant-width TPU band, angled print arm and overlapping square snap."""
import json, math
from pathlib import Path
import cadquery as cq
from build import export
OUT=Path(__file__).resolve().parents[1]/'review/concepts/square-clip';OUT.mkdir(parents=True,exist_ok=True)
W,H=12.8,17.8
outer=cq.Workplane('XY').rect(W+3.2,H+3.2).extrude(6).edges('|Z').fillet(1.5)
inner=cq.Workplane('XY').rect(W,H).extrude(8).translate((0,0,-1)).edges('|Z').fillet(.4)
frame=outer.cut(inner).cut(cq.Workplane('XY').box(12,17.8,10).translate((12,0,3)))
frame=frame.union(cq.Workplane('XY').center(0,13.3).circle(4).extrude(6)).cut(cq.Workplane('XY').center(0,13.3).circle(2).extrude(8).translate((0,0,-1))).cut(inner)
# Same 6mm band width and 1.6mm wall. Closed arm is an illustrative bent pose.
male=cq.Workplane('XY').box(1.6,11.3,6).translate((7.2,-3.25,3))
female=cq.Workplane('XY').polyline([(6.4,8.9),(8,10.0),(9.8,7),(9.8,-2.4),(8.2,-2.4),(8.2,6.5)]).close().extrude(6)
# True square opening; receiver prints flat with its bore vertical.
hole=cq.Workplane('YZ').center(0,3).rect(3,3).extrude(5).translate((6,0,0))
female=female.cut(hole)
peg_profile=[(-1.3,1.7),(1.3,1.7),(1.3,4.3),(-1.3,4.3)]
lip_profile=[(-1.6,1.55),(1.6,1.55),(1.6,4.6),(-1.6,4.6)]
tip_profile=[(-1.1,2.0),(1.1,2.0),(1.1,4.05),(-1.1,4.05)]
peg=cq.Workplane('YZ').polyline(peg_profile).close().extrude(2.0).translate((8,0,0))
lip=cq.Workplane('YZ').workplane(offset=10).polyline(peg_profile).close().workplane(offset=.4).polyline(lip_profile).close().loft()
tip=cq.Workplane('YZ').workplane(offset=10.4).polyline(lip_profile).close().workplane(offset=.6).polyline(tip_profile).close().loft()
peg=peg.union(lip).union(tip)
# Trim lower face to a 35-degree ramp in print coordinates; stays inside mating opening.
cut=cq.Workplane('XZ').polyline([(7,-2),(12,-2),(12,1.5+4*math.tan(math.radians(35))),(8,1.5),(7,1.5)]).close().extrude(10,both=True)
peg=peg.cut(cut)
male=male.union(peg)
pivot=(7.2,8.9,0)
# Straight manufactured arm starts at the circular root; TPU flex supplies the lap offset.
straight_arm=cq.Workplane('XY').box(6,11.3,1.6).translate((7.2,3.25,.8))
vertical_hole=cq.Workplane('XY').center(7.2,0).rect(3,3).extrude(4).translate((0,0,-1))
straight_arm=straight_arm.cut(vertical_hole)
open_arm=straight_arm.rotate(pivot,(7.2,8.9,1),35)
# Integral flexible root keeps the rotated arm attached to the frame.
root=cq.Workplane('XY').center(7.2,8.9).circle(1.2).extrude(6)
frame=frame.union(root)
part=frame.union(male).union(open_arm).clean()
assert part.val().isValid() and len(part.val().Solids())==1
intersection=male.intersect(female).val().Volume()
assert intersection<1e-6,intersection
for n,s in [('clip',part),('frame',frame),('male',male),('female',open_arm),('female-seated',female),('closed',frame.union(male).union(female))]:export(s,OUT/(n+'.stl'))
export(part,OUT/'clip.step')
report={'revision':'flat-arm-square-clip-v3','nominal_frame_opening_mm':[W,H],'band_width_mm':6,'wall_mm':1.6,'eye_mm':4,'open_arm_angle_deg':35,'peg_width_mm':2.6,'hole_mm':3,'receiver_print_hole_axis':'Z','assembly_twist_deg':90,'lip_width_mm':3.2,'overlap_length_mm':4.8,'peg_underside_angle_deg_from_bed':35,'valid_single_solid':True,'closed_latch_intersection_mm3':intersection,'limits':['Closed pose schematically twists the flat arm90 degrees and bends it to the overlap; not an elastic simulation or exact deformation.','Root flexure, fit, force, creep and support-free print quality need physical validation.','No print requested.']}
(OUT/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n');print(report)

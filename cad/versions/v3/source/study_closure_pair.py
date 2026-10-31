"""Two bend-only, developed TPU straps. No printer actions."""
import json
from pathlib import Path
import cadquery as cq
from build import export
OUT=Path(__file__).resolve().parents[1]/'review/concepts/closure-pair';OUT.mkdir(parents=True,exist_ok=True)
# Neutral circumference for 12.8 x17.8 interior, 1.6 wall, rounded corners.
# Straight developed strap is intentionally longer by the short overlap.
L=73.6; T=1.6; B=6
base=cq.Workplane('XY').box(L,B,T,centered=(True,True,False))
eye=cq.Workplane('XY').center(0,5.5).circle(3.5).circle(2).extrude(T)
base=base.union(eye)
a=base.cut(cq.Workplane('XY').center(33.8,0).rect(3,3).extrude(4))
peg=cq.Workplane('XY').workplane(offset=T).center(-33.8,0).rect(2.6,2.6).extrude(1.9)
lip=cq.Workplane('XY').workplane(offset=3.5).center(-33.8,0).rect(2.6,2.6).workplane(offset=.45).rect(3.2,3.2).loft()
tip=cq.Workplane('XY').workplane(offset=3.95).center(-33.8,0).rect(3.2,3.2).workplane(offset=.45).rect(2.4,2.4).loft()
a=a.union(peg).union(lip).union(tip).clean()
# Short sleeve: 0.3mm vertical tongue clearance, 0.2mm each side.
# Sloped internal roof leaves a small release window over the bump.
x=33.8
sleeve=cq.Workplane('XY').box(6,8.8,6.3,centered=(True,True,False)).translate((x,0,0))
void=cq.Workplane('YZ').polyline([(-3.2,1.6),(3.2,1.6),(3.2,3.5),(0,5.74),(-3.2,3.5)]).close().extrude(8).translate((x-4,0,0))
sleeve=sleeve.cut(void).cut(cq.Workplane('XY').box(2.6,2.4,4,centered=(True,True,False)).translate((x,0,3.5)))
b=base.union(sleeve)
bump=cq.Workplane('XY').workplane(offset=1.6).center(-33.8,0).rect(2,2).workplane(offset=2.2).rect(1.6,1.6).loft()
b=b.union(bump).clean()
report={'revision':'bend-only-closure-pair-v2','nominal_inside_mm':[12.8,17.8],'band_mm':[6,1.6],'developed_length_mm':L,'assembly_twist_deg':0,'overlap_mm':6,'limits':['Developed-length target is provisional: TPU bend radius, tension, closure fit and retention need physical checks.','No print requested. Active guide unchanged.']}
for name,shape in [('option-a',a),('option-b',b)]:
 assert shape.val().isValid() and len(shape.val().Solids())==1
 export(shape,OUT/(name+'.stl'));export(shape,OUT/(name+'.step'))
 report[name]={'valid_single_solid':True,'volume_mm3':shape.val().Volume()}
(OUT/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
print(report)
# Exact rigid end sections in their seated relationship; wrapping remains untested.
for name,shape in [('option-a',a),('option-b',b)]:
 left=shape.intersect(cq.Workplane('XY').box(8,20,20).translate((-33.8,0,5)))
 right=shape.intersect(cq.Workplane('XY').box(8,20,20).translate((33.8,0,5)))
 if name=='option-a': right=right.translate((-67.6,0,1.8))
 else: left=left.translate((67.6,0,1.9))
 vol=left.intersect(right).val().Volume()
 report[name]['seated_intersection_mm3']=vol
 assert vol<1e-5,(name,vol)
 export(left,OUT/(name+'-latch-left.stl'));export(right,OUT/(name+'-latch-right.stl'))
(OUT/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')

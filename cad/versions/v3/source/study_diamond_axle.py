"""Diamond-slot axle review; preserve active assembly until print approval."""
import json, math
from pathlib import Path
import cadquery as cq
import plunger_design as p
from shared_key_design import snap_key, box
from build import overlap, export
OUT=Path(__file__).resolve().parents[1]/'review/concepts/diamond-axle'
OUT.mkdir(parents=True,exist_ok=True)
SHIFT=2.0
EXTEND=SHIFT+1.7*(math.sqrt(2)-1)
center=(0,8,.3-p.KEY_OUTBOARD)
def turn(s):return s.rotate(center,(1,8,.3-p.KEY_OUTBOARD),45).translate((0,0,-SHIFT))
blank=p.cyl(p.PULLEY_U,8,-3.6-p.KEY_OUTBOARD-EXTEND,16.8+p.KEY_OUTBOARD+EXTEND,4).union(p.cyl(p.PULLEY_U,8,13.2,1.6,5.5).edges().fillet(.2))
slot=turn(box(3,23,6.3,9.7,-1.4-p.KEY_OUTBOARD,2-p.KEY_OUTBOARD))
axle=blank.cut(slot)
key=turn(snap_key().translate((0,0,-p.KEY_OUTBOARD)))
parts=p.cassette();a=p.local_shape(axle);k=p.local_shape(key)
assert a.val().isValid() and len(a.val().Solids())==1
checks={name:overlap(k,parts[name]) for name in ('actuator_bracket','pulley','plunger')}
checks['axle']=overlap(k,a)
assert max(checks.values())<1e-6,checks
# Rotate the same ideal compressed envelope used by the original key check.
original=snap_key();tip=original.intersect(box(0,8.9,0,16,-2,3));rest=original.cut(box(0,8.9,0,16,-2,3))
mat=cq.Matrix([[1,0,0,0],[0,.6,0,3.2],[0,0,1,0],[0,0,0,1]])
compressed=cq.Workplane(obj=tip.val().transformGeometry(mat)).union(rest)
compressed=turn(compressed.translate((0,0,-p.KEY_OUTBOARD)))
path=[overlap(p.local_shape(compressed.translate((i*.5,0,0))),a) for i in range(29)]
assert max(path)<1e-5,path
reverse=overlap(p.local_shape(key.translate((2,0,0))),a);assert reverse>.01
# Head down: original conceptual +w points down toward build plate.
bed=axle.rotate((0,0,0),(1,0,0),180)
b=bed.val().BoundingBox();bed=bed.translate((-p.PULLEY_U,8,-b.zmin))
export(bed,OUT/'pulley_axle.stl');export(a,OUT/'pulley_axle.step')
export(axle,OUT/'axle-display.stl');export(key,OUT/'key-display.stl')
for n in ('actuator_bracket','pulley','plunger'):export(parts[n],OUT/(n+'.stl'))
export(a,OUT/'axle-assembly.stl');export(k,OUT/'key-assembly.stl')
# Show old and new in same head-down orientation.
old_blank=p.cyl(p.PULLEY_U,8,-3.6-p.KEY_OUTBOARD,16.8+p.KEY_OUTBOARD,4).union(p.cyl(p.PULLEY_U,8,13.2,1.6,5.5).edges().fillet(.2))
old=old_blank.cut(box(3,23,6.3,9.7,-1.4-p.KEY_OUTBOARD,2-p.KEY_OUTBOARD))
export(old,OUT/'old-display.stl')
report={'revision':'diamond-slot-axle-v3','study_only':True,'active_assembly_unchanged':True,'slot_square_side_mm':3.4,'slot_diagonal_mm':3.4*math.sqrt(2),'rotation_deg':45,'outboard_shift_mm':SHIFT,'tip_extension_mm':EXTEND,'roof_angle_to_bed_deg':45,'tip_ligament_mm':2.2,'old_tip_ligament_mm':2.2,'same_key_reused_rotated_deg':45,'seated_overlap_mm3':checks,'compressed_insertion_max_overlap_mm3':max(path),'reverse_2mm_interference_mm3':reverse,'limitations':['Ideal compressed key envelope; not elastic analysis.','Original flat-roof print physically failed per user; cause suspected, not proven.','Original tip ligament retained; rotated key/keeper access require physical check.','Keeper-band routing not qualified for rotated key. No print authorized.']}
(OUT/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))

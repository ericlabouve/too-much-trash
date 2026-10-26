"""Geometric envelope checks only; TPU spring-back/force are not simulated."""
import json
import cadquery as cq
import build as b
import plunger_design as p
from shared_key_design import snap_key,box
key=snap_key();parts=p.cassette();axle=parts['pulley_axle']
local=lambda s:p.local_shape(s.translate((0,0,-p.KEY_OUTBOARD)))
assert key.val().isValid() and len(key.val().Solids())==1
assert b.overlap(local(key),axle)<1e-6
for name in ('actuator_bracket','pulley','plunger'):
    assert b.overlap(local(key),parts[name])<1e-6,name
keeper=b.polyline(p.keeper_path(),1.2)
assert b.overlap(local(key),keeper)<1e-6
# Ideal compressed transverse envelope; NOT an elastic deformation analysis.
tip=key.intersect(box(0,8.9,0,16,-2,3))
rest=key.cut(box(0,8.9,0,16,-2,3))
matrix=cq.Matrix([[1,0,0,0],[0,.6,0,3.2],[0,0,1,0],[0,0,0,1]])
compressed=cq.Workplane(obj=tip.val().transformGeometry(matrix)).union(rest)
path=[]
for i in range(29):
    travel=i*.5
    v=b.overlap(local(compressed.translate((travel,0,0))),axle)
    assert v<1e-5,(travel,v)
    path.append(v)
withdraw=b.overlap(local(key.translate((2,0,0))),axle)
assert withdraw>.01
report=dict(revision=b.REVISION,passed=True,material='ELEGOO TPU95A',
 overall_length_mm=14.7,stem_width_mm=3,thickness_mm=3,axle_slot_mm=[3.4,3.4],
 relaxed_v_width_mm=5,ideal_compressed_v_width_mm=3,required_tip_deflection_per_side_mm=1,
 seated_overlap_mm3=0,compressed_envelope_max_axle_overlap_mm3=max(path),
 relaxed_reverse_2mm_interference_mm3=withdraw,keeper_clear=True,
 limits=['Ideal compressed envelope only; bending strain, insertion force and spring-back not calculated.',
 'Test snap reopening, pull-out, repeated removal, axle retention and TPU creep physically.',
 'Remove keeper, pinch V arms inward, then withdraw toward T-head; never force.',
 'Existing keeper retained until snap is physically qualified. No print sent.'])
(b.ROOT/'review/tpu-tv-key.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))

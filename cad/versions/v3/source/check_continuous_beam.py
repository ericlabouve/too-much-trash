"""Bounded sliding-beam change and exact rollback/interface checks."""
import json
import build as b
from cuff_design import CUFF_Z, SLIDING_CUFF_X, locate, integral_stud, cuff

p=b.Parameters()
old=b.sliding_jaw(p,continuous_beam=False)
new=b.sliding_jaw(p,flush_beam=False)
vol=lambda s:sum(v.Volume() for v in s.solids().vals())
diff=lambda a,c:vol(a.cut(c))+vol(c.cut(a))
assert new.val().isValid() and len(new.val().Solids())==1
# Previous plate source is an immutable exact rollback reference.
snapshot=b.cq.importers.importStep(str(b.ROOT/'print/jobs/2026-10-25-jaw-arm-slots-source/sliding_jaw.step'))
oriented=old.rotate((0,0,0),(0,1,0),-90).rotate((0,0,0),(0,0,1),90)
rollback_difference=diff(oriented,snapshot)
assert rollback_difference<1e-5
beam=b.box(-15.2,-7.2,-60.8,60.8,CUFF_Z-5.8,CUFF_Z+5.8)
assert vol(beam.cut(new))<1e-6
upper=b.box(-30,60,-70,70,24.01,60)
assert diff(old.intersect(upper),new.intersect(upper))<1e-6
for y in (-50,50):
    assert vol(locate(integral_stud(),SLIDING_CUFF_X,y).cut(new))<1e-6
    assert b.overlap(locate(cuff(),SLIDING_CUFF_X,y),new)<1e-6
report=dict(revision='continuous-beam-sliding-jaw-v3',passed=True,valid=True,solid_count=1,
 beam_mm=[8,121.6,11.6],stud_centers_y_mm=[-50,50],
 cuff_and_stud_positions_unchanged=True,tongue_and_cleat_unchanged=True,
 rollback_snapshot_difference_mm3=rollback_difference,
 previous_volume_mm3=vol(old),new_volume_mm3=vol(new),
 bed_plane_x_mm=-15.2,previous_bed_plane_x_mm=-10,
 limits=['Fresh slice required; existing jobs do not qualify new support requirements.',
         'Valid connected geometry is not strength or grip validation.'])
(b.ROOT/'review/continuous-beam.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))

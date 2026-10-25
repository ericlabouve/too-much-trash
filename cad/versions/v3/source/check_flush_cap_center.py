"""Literal green-to-blue face cleanup; preserve all functional rail geometry."""
import json
import build as b

p=b.Parameters()
old=b.shaft_clamp_half(p,True).union(b.paired_neck_rail().translate((b.CUFF_INWARD_SHIFT,0,0)))
new=b.shaft_cap(p)
volume=lambda s:sum(v.Volume() for v in s.solids().vals())
removed=old.cut(new)
added=volume(new.cut(old))
zone=b.box(12,14,-13.8,13.8,15.9,36.1)
assert added<1e-6
assert volume(removed.cut(zone))<1e-6
assert volume(new.intersect(zone))<1e-6
assert new.val().isValid() and len(new.val().Solids())==1
# A continuous planar face must span the former crossing and its neighbors.
faces=[]
for f in new.val().Faces():
 bb=f.BoundingBox()
 if f.geomType()=='PLANE' and abs(bb.xmin-12)<1e-6 and abs(bb.xmax-12)<1e-6:
  faces.append(dict(area_mm2=f.Area(),y=[bb.ymin,bb.ymax],z=[bb.zmin,bb.zmax]))
assert any(f['y'][0]<=-13.8+1e-6 and f['y'][1]>=13.8-1e-6 and f['z'][0]<16 and f['z'][1]>36 for f in faces),faces
neck=b.box(-5.8,5.8,-8.8,8.8,b.CLAMP_BOTTOM-1,b.CLAMP_TOP+1)
assert b.overlap(new,neck)<1e-6
report=dict(revision=b.REVISION,passed=True,common_face_x_mm=12,
 removed_step_height_mm=1.8,removed_volume_mm3=volume(removed),added_volume_mm3=added,
 continuous_faces=faces,solid_count=1,valid=True,
 slotted_wings_and_fastener_bosses_unchanged=True,
 validation_basis='Pure subtraction confined to central collar crossing; no new rigid collisions or service obstructions can be introduced. Rail slots, mounting faces and neck opening unchanged.',
 limits=['CAD continuity is not measured stiffness or print qualification. Existing phone-fit and twine-routing issues remain.'])
(b.ROOT/'review/flush-cap-center.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2),flush=True)

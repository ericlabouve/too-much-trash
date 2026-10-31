"""Cap-only material removal and preserved interfaces; not strength validation."""
import json
import build as b

p=b.Parameters()
cap=b.shaft_cap(p)
baseline=b.shaft_clamp_half(p,True).union(b.paired_neck_rail().translate((b.CUFF_INWARD_SHIFT,0,0))).cut(b.box(12,15,-70,70,-50,80)).clean()
volume=lambda s:sum(x.Volume() for x in s.solids().vals())
assert cap.val().isValid() and len(cap.val().Solids())==1
assert volume(cap.cut(baseline))<1e-6
ends=[]
for z in (-38.5,68.5):
    faces=[f for f in cap.val().Faces() if f.geomType()=='PLANE' and abs(f.BoundingBox().zmin-z)<1e-6 and abs(f.BoundingBox().zmax-z)<1e-6]
    assert len(faces)==1
    assert faces[0].BoundingBox().ylen>35
    ends.append(dict(z_mm=z,area_mm2=faces[0].Area()))
assert volume(cap.intersect(b.box(-1,15,-1,1,-24,54)))<1e-6
# Actuator wings and the remaining side rails are unchanged outside slot.
for y0,y1 in ((-70,-5.5),(5.5,70)):
    region=b.box(-20,20,y0,y1,-38.5,68.5)
    assert volume(baseline.intersect(region).cut(cap))<1e-6
for y,z in b.CLAMP_STATIONS:
    assert volume(cap.intersect(b.cylinder((-15,y,z),(1,0,0),30,8.8)))<1e-6
report=dict(revision=b.REVISION,passed=True,baseline_commit='9715c28',
    baseline_volume_mm3=volume(baseline),volume_mm3=volume(cap),
    removed_volume_mm3=volume(baseline)-volume(cap),
    solid_volume_reduction_percent=100*(1-volume(cap)/volume(baseline)),
    end_faces=ends,through_slot_width_mm=11,through_slot_length_mm=90,
    end_bridge_mm=8.5,side_rail_width_mm=8.3,minimum_end_bore_ligament_mm=4.1,
    unchanged=['fixed jaw','screw centers and bores','outer X12 print plane','actuator wings'],
    limits=['CAD volume is not sliced filament savings. No new slice or print.',
            'Central web removed: frame stiffness, trimmed bosses and loaded clamp strength require physical checks.'])
(b.ROOT/'review/pocketed-cap.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))

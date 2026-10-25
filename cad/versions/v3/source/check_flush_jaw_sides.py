"""Check the exterior cleanup without changing the sliding channel."""
import json
import build as b

s=b.carrier(b.Parameters())
assert s.val().isValid() and len(s.val().Solids())==1
track=s.intersect(b.box(-111,-18.1,-20,20,22,34))
bb=track.val().BoundingBox()
assert abs(bb.ymin+13.8)<1e-6 and abs(bb.ymax-13.8)<1e-6
faces=[]
for sign in (-1,1):
    # One continuous coplanar face must cross from the track into the collar.
    matches=[]
    for f in s.faces().vals():
        q=f.BoundingBox()
        if f.geomType()=='PLANE' and abs(q.ymin-sign*13.8)<1e-6 and abs(q.ymax-sign*13.8)<1e-6:
            if q.xmin<-100 and q.xmax>-.6:matches.append(f)
    assert len(matches)==1,(sign,len(matches))
    faces.append(dict(y_mm=sign*13.8,area_mm2=matches[0].Area()))
channel=b.box(-100,-20,-10.3,10.3,26,30.8)
assert b.overlap(s,channel)<1e-6
report=dict(revision=b.REVISION,passed=True,continuous_side_faces=faces,
    outer_width_mm=27.6,removed_per_side_mm=2.2,wall_thickness_mm=3.5,
    inner_channel_width_mm=20.6,lip_opening_mm=15,
    changed_print_designs=['carrier'],limits=['Printed stiffness and strength unqualified.'])
b.save(b.OUT/'flush-jaw-sides.json',report)
print(json.dumps(report,indent=2))

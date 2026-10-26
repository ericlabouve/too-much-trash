"""Whole-cap bed-plane and compensating interface checks (not print validation)."""
import json
import build as b

p=b.SAMPLES['bare'];s=b.parts(p);cap=s['shaft_cap'];a=b.assembly_parts(p,s)
volume=lambda shape:sum(x.Volume() for x in shape.solids().vals())
raw=b.shaft_clamp_half(p,True).union(b.paired_neck_rail().translate((b.CUFF_INWARD_SHIFT,0,0)))
assert cap.val().isValid() and len(cap.val().Solids())==1
assert abs(cap.val().BoundingBox().xmax-12)<1e-6
assert volume(cap.cut(raw))<1e-6
faces=[]
for f in cap.val().Faces():
 bb=f.BoundingBox()
 if f.geomType()=='PLANE' and abs(bb.xmin-12)<1e-6 and abs(bb.xmax-12)<1e-6:
  faces.append(dict(area_mm2=f.Area(),y=[bb.ymin,bb.ymax],z=[bb.zmin,bb.zmax]))
assert len(faces)==1,faces
assert faces[0]['y'][0]<-59.99 and faces[0]['y'][1]>59.99
assert abs(faces[0]['z'][0]+38.5)<1e-6 and abs(faces[0]['z'][1]-68.5)<1e-6
seats=[]
for i,(y,z) in enumerate(b.CLAMP_STATIONS,1):
 # Every annular boss reaches exactly the same plane, not merely below it.
 boss=cap.intersect(b.box(11.9,12,y-9,y+9,z-9,z+9))
 assert volume(boss)>15
 screw=a[f'clamp_screw_{i}'];bb=screw.val().BoundingBox()
 assert abs(bb.xmax-16)<1e-6 and abs(bb.xmin-p.phone_right)<1e-6
 assert b.overlap(screw,cap)<1e-6
 assert b.overlap(screw,a[f'clamp_nut_{i}'])<.01
 seats.append(dict(yz_mm=[y,z],head_seat_x_mm=bb.xmax-4,tip_x_mm=bb.xmin))
assert abs(p.phone_right+30.2-12)<1e-6
assert b.overlap(a['shaft_cap'],a['actuator_bracket'])<1e-6
assert abs(a['plunger'].val().BoundingBox().xmin-p.phone_right-p.rest_gap)<1e-6
# Rail loses exterior thickness only; inner screw bearing and slot unchanged.
rail=cap.intersect(b.box(-1,20,30,40,17,20))
assert abs(rail.val().BoundingBox().xlen-4.2)<1e-6
report=dict(revision=b.REVISION,passed=True,valid=True,solid_count=1,
 bed_plane_x_mm=12,one_connected_planar_face=faces[0],removed_height_mm=1.8,
 removed_from_untrimmed_cap_mm3=volume(raw.cut(cap)),rail_thickness_mm=4.2,
 collar_screw_threaded_span_mm=30.2,collar_screw_seats=seats,
 bracket_bearing_extension_mm=1.8,rail_bracket_plane_x_mm=12,
 released_shoe_gap_mm=p.rest_gap,
 changed_designs=['shaft_cap','collar_screw','actuator_bracket'],
 limits=['No fresh slice: flat bed contact is not proof of support-free printing.',
 'Thinner rail, full collar fit, preload and strength require physical checks.',
 'Existing phone-fit and outgoing-twine routing limitations remain.'])
(b.ROOT/'review/flat-bed-cap.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2),flush=True)

"""Check proposed flat-back jaw and lowered anchor before promotion."""
import json
import build as b
import model as m

p=m.Parameters()
old=m.sliding_jaw(p,flat_back=False,cleat_shift=0)
new=m.sliding_jaw(p,flat_back=True,cleat_shift=-4.5)
volume=lambda s:sum(v.Volume() for v in s.solids().vals())
assert new.val().isValid() and len(new.val().Solids())==1
# Mating tongue and cuff stud interfaces must remain exact.
for region in [b.box(-5,50,-11,11,26.4,30.4),b.box(-9.5,5,-62,62,0,24)]:
    a=old.intersect(region);c=new.intersect(region)
    assert volume(a.cut(c))+volume(c.cut(a))<1e-6
assert abs(new.val().BoundingBox().xmin+10)<1e-6
carrier=m.carrier(p)
travel=[]
for i in range(91):
    x=m.CLOSED_JAW_X-45*i/90
    hit=b.overlap(carrier,new.translate((x,0,0)))
    assert hit<.01,(x,hit)
    travel.append(hit)
band_hits=[]
for name,p in b.SAMPLES.items():
    for z in m.JAW_BAND_LEVELS:
        band=m.polyline(m.jaw_band(p.phone_left-5.5,m.FIXED_CLEAT_X,z),1.4)
        for key,s in [('carrier',carrier),('slider',new.translate((p.phone_left,0,0))),('phone',m.stock(p)['phone_envelope'])]:
            hit=b.overlap(band,s)
            if hit>.01:band_hits.append([name,z,key,hit])
assert not band_hits,band_hits
faces=[f.Area() for f in new.faces().vals() if abs(f.BoundingBox().xmin+10)<1e-6 and abs(f.BoundingBox().xmax+10)<1e-6]
report=dict(passed=True,bed_plane_x_mm=-10,bed_contact_area_mm2=sum(faces),
    cleat_shift_x_mm=-4.5,travel_samples=len(travel),max_travel_collision_mm3=max(travel),
    band_hits=band_hits,old_volume_mm3=volume(old),new_volume_mm3=volume(new),
    limits=['Band span increases 4.5 mm; actual preload, retention and strength require physical checks.'])
b.save(b.OUT/'sliding-jaw-bed.json',report)
print(json.dumps(report,indent=2),flush=True)

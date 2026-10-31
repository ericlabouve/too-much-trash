"""Candidate-only checks; not a promotion or physical qualification."""
import json
import build as b
import model as m
from sliding_jaw_angles import candidate

s=candidate();old=m.sliding_jaw(m.Parameters())
assert s.val().isValid() and len(s.val().Solids())==1
volume=lambda x:sum(v.Volume() for v in x.solids().vals())
for region in (m.box(-6,50,-11,11,26.4,30.4),m.box(-11,5,-62,62,0,24),m.box(-11,0,-11,11,45,48)):
    a=s.intersect(region);c=old.intersect(region)
    assert volume(a.cut(c))+volume(c.cut(a))<1e-6
carrier=m.carrier(m.Parameters())
for i in range(91):
    assert b.overlap(carrier,s.translate((m.CLOSED_JAW_X-45*i/90,0,0)))<.01
solids=m.parts(m.Parameters());solids['sliding_jaw']=s
hits=[]
for name,p in b.SAMPLES.items():
    for side in ('near','far'):
        q=b.replace(p,side=side);a=m.assembly_parts(q,solids)
        for key,target in a.items():
            if key.startswith('cuff_') or key=='sliding_jaw':continue
            v=b.overlap(a['sliding_jaw'],target)
            if v>.01:hits.append([name,side,key,v])
        _,bands,_=m.flexible_paths(q)
        for key in ('band_jaw_1','band_jaw_2'):
            v=b.overlap(a['sliding_jaw'],m.polyline(bands[key],1.4))
            if v>.01:hits.append([name,side,key,v])
assert not hits,hits
report=dict(candidate_only=True,passed=True,valid=True,solid_count=1,
    cleat_roof_angle_degrees=45,tongue_shoulder_angle_degrees=53.130102,
    tongue_and_studs_and_cleat_cap_unchanged=True,travel_samples=91,
    assembly_configurations=8,collisions=hits,
    minimum_cleat_stem_x_thickness_mm=3.75,
    limits=['Pitched stem has a smaller central section; strength, band seating and print quality require testing.',
            'Active V3 unchanged pending review; screw success is a starting point, not validation of these overhangs.'])
b.save(b.OUT/'sliding-jaw-angles.json',report)
print(json.dumps(report,indent=2),flush=True)

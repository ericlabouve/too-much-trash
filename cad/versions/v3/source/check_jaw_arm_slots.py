"""Matched support geometry, preserved jaw interfaces and subtractive safety."""
import json,hashlib
from collections import Counter
import numpy as np
import build as b

jobs=b.ROOT/'print/jobs'
base=jobs/'2026-10-25-jaw-arm-baseline';trial=jobs/'2026-10-25-jaw-arm-slots'
for name in ('process.json','machine.json','filament.json'):
    assert (base/name).read_bytes()==(trial/name).read_bytes()
def segments(path):
    return Counter(tuple(sorted((tuple(v[:3]),tuple(v[3:])))) for v in np.fromfile(path,dtype='<f4').reshape(-1,6))
for role in ('support','interface'):
    assert segments(base/(role+'.bin'))==segments(trial/(role+'.bin'))
old=json.loads((base/'review.json').read_text());new=json.loads((trial/'review.json').read_text())
volume=lambda s:sum(v.Volume() for v in s.solids().vals())
geo={};p=b.Parameters()
for name,fn in [('carrier',b.carrier),('sliding_jaw',b.sliding_jaw)]:
    options={'continuous_beam':False} if name=='sliding_jaw' else {}
    a=fn(p,arm_slots=False,**options);c=fn(p,**options)
    assert c.val().isValid() and len(c.val().Solids())==1
    assert volume(c.cut(a))<1e-6
    # STEP snapshots used to produce this exact trial plate are immutable.
    oriented=c.rotate((0,0,0),(0,1,0),90 if name=='carrier' else -90)
    if name=='sliding_jaw':oriented=oriented.rotate((0,0,0),(0,0,1),90)
    snapshot=b.cq.importers.importStep(str(jobs/'2026-10-25-jaw-arm-slots-source'/(name+'.step')))
    assert volume(oriented.cut(snapshot))+volume(snapshot.cut(oriented))<1e-5
    # All guide edges remain: cut is confined to the middle 6 mm.
    for y0,y1 in [(-70,-3),(3,70)]:
        assert volume(a.intersect(b.box(-150,100,y0,y1,-50,100)).cut(c))<1e-6
    if name=='carrier':
        # Root/stop and stud untouched; slot ends well before closing stop.
        for x0,x1 in [(-150,-60),(-32,20)]:
            assert volume(a.intersect(b.box(x0,x1,-70,70,-50,100)).cut(c))<1e-6
    else:
        for x0,x1 in [(-30,10),(42,70)]:
            assert volume(a.intersect(b.box(x0,x1,-70,70,-50,100)).cut(c))<1e-6
    geo[name]={'valid':True,'one_solid':True,'removed_mm3':volume(a)-volume(c),
        'no_added_material':True,'guide_edges_root_and_stop_preserved':True}
# Subtractive-only changes cannot create new rigid interference at any
# translation; full build separately checks original assembly samples.
report=dict(revision='support-neutral-jaw-slots-v3',passed=True,geometry=geo,
 identical_support_segments=True,identical_interface_segments=True,identical_profiles=True,
 baseline_total_g=old['total_g'],candidate_total_g=new['total_g'],
 saved_g=old['total_g']-new['total_g'],baseline_minutes=old['total_minutes'],candidate_minutes=new['total_minutes'],
 baseline_objects=old['objects'],candidate_objects=new['objects'],
 job_paths=[str(x.relative_to(b.ROOT)) for x in (base,trial)],
 hashes={str(x.relative_to(b.ROOT)):hashlib.sha256(x.read_bytes()).hexdigest() for d in (base,trial) for x in [d/'cuff-fit.gcode.3mf']},
 limits=['Existing supports remain; no additional supports is not support-free.',
 'Physical 35-degree roof quality, sliding catch/wear, bending and loaded retention unverified.',
 'Existing phone-fit and whole-route failures remain. No print sent.'])
(b.ROOT/'review/jaw-arm-slots.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))

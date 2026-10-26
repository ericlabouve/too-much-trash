"""Exact common-cuff equivalence and integral-stud integration checks."""
import json,hashlib
from pathlib import Path
from dataclasses import replace
import cadquery as cq
import build as b
from cuff_design import cuff, integral_stud, socket, locate, CUFF_WIDTH, FIXED_CUFF_Y, SLIDING_CUFF_X
root=Path(__file__).resolve().parents[1]
reference=root/'print/jobs/2026-10-24-common-cuff-tpu-source/common-cuff.step'
approved=cq.importers.importStep(str(reference)); c=cuff()
volume=lambda s:sum(v.Volume() for v in s.solids().vals())
difference=volume(c.cut(approved))+volume(approved.cut(c))
assert difference<1e-6
assert abs(c.val().BoundingBox().ylen-21.6)<1e-6
assert b.overlap(c,socket())<1e-6
assert b.overlap(c.translate((1,0,0)),socket())>0
solids=b.parts(b.Parameters());configs={}
for name,base in b.SAMPLES.items():
 for side in ('near','far'):
    p=replace(base,side=side);a=b.assembly_parts(p,solids)
    assert not any(n.startswith('cuff_key_') for n in a)
    neck=b.box(-7,7,-9.5,9.5,-105,85)
    stations=[('fixed',p.phone_right,0,True,'carrier'),
              ('sliding_1',p.phone_left+SLIDING_CUFF_X,-50,False,'sliding_jaw'),
              ('sliding_2',p.phone_left+SLIDING_CUFF_X,50,False,'sliding_jaw')]
    checks={}
    for label,x,y,fixed,jaw in stations:
        expected=locate(c,x,y,fixed);actual=a['cuff_'+label]
        stud=locate(integral_stud(),x,y,fixed)
        checks[label]=dict(cuff_difference_mm3=volume(actual.cut(expected))+volume(expected.cut(actual)),
            missing_integral_stud_mm3=volume(stud.cut(a[jaw])),
            cuff_jaw_overlap_mm3=b.overlap(actual,a[jaw]),
            stud_neck_overlap_mm3=b.overlap(stud,neck),
            cuff_neck_overlap_mm3=b.overlap(actual,neck))
        assert all(v<1e-6 for v in checks[label].values()),checks
    configs[name+'-'+side]=checks
    print(name+'-'+side,'identical cuffs/studs; seated fit clear',flush=True)
fixed=solids['carrier'].union(locate(c,b.FIXED_CUFF_X,0,True))
moving=solids['sliding_jaw']
for y in (-50,50):moving=moving.union(locate(c,SLIDING_CUFF_X+b.SLIDING_BEAM_SHIFT,y))
travel=[]
for i in range(91):
    x=b.CLOSED_JAW_X-45*i/90;v=b.overlap(fixed,moving.translate((x,0,0)))
    assert v<.01,(x,v)
    travel.append(v)
report=dict(revision=b.REVISION,passed=True,cuff_count=3,loose_cuff_keys=0,
    axle_key_count=1,cuff_width_mm=CUFF_WIDTH,fixed_contact_y_mm=FIXED_CUFF_Y,
    sliding_contact_y_mm=[-50,50],opening_mm=[6.8,6.8],head_recess_mm=[9.6,6.8],
    approved_cuff_symmetric_difference_mm3=difference,
    approved_source_sha256=hashlib.sha256(reference.read_bytes()).hexdigest(),
    max_sampled_jaw_travel_overlap_mm3=max(travel),configurations=configs,
    limits=['Local stud/TPU fit success is user reported; full-jaw strength and phone retention unqualified.',
            'Installation requires TPU deformation; rigid translation is intentionally blocked by the head, not a valid service test.',
            'Phone/camera/button and full actuator service checks are separate; no deformation or force simulation.'])
(root/'review/cuff-integration.json').write_text(json.dumps(report,indent=2)+'\n')
print('Common cuff/stud integration passed',flush=True)

"""Cuff integration evidence, including failures; no force/TPU simulation."""
import hashlib
import json
from pathlib import Path
from dataclasses import replace
import cadquery as cq
import trimesh
import build as b
from cuff_design import cuff_key, locate, CUFF_Z, FIXED_CUFF_Y, SLIDING_CUFF_X

root=Path(__file__).resolve().parents[1]
s=b.parts(b.Parameters())
reference=root/'print/jobs/2026-10-16-enlarged-cuff-petg/fit-cuff-source.stl'
mesh=trimesh.load(reference)
c=s['phone_cuff'];bb=c.val().BoundingBox()
# STL faceting loses ~0.041 mm3 on the printed 970.5 mm3 cuff. The exact
# STEP boolean comparison below is the decisive geometry-equivalence check.
assert abs(c.val().Volume()-mesh.volume)/c.val().Volume()<1e-4
assert all(abs(a-z)<.01 for a,z in zip((bb.xlen,bb.ylen,bb.zlen),mesh.extents))
step=cq.importers.importStep(str(root/'review/concepts/phone-clamps/rounded-cuff/fit-cuff.step'))
difference=c.cut(step).val().Volume()+step.cut(c).val().Volume()
assert difference<1e-6,difference
assert b.overlap(c,b.box(-6.72,-5.02,-1.7,1.7,-1.7,1.7))<1e-6
assert b.overlap(c,b.box(-5.02,-3.7,-3.7,3.7,-1.7,1.7))<1e-6
for y0,y1 in [(-3.7,-1.7),(1.7,3.7)]:
    shoulder=b.box(-6.72,-5.02,y0,y1,-1.7,1.7)
    assert shoulder.cut(c).val().Volume()<1e-6
configs={}
for name,base in b.SAMPLES.items():
 for side in ('near','far'):
    p=replace(base,side=side);a=b.assembly_parts(p,s)
    neck=b.box(-7,7,-9.5,9.5,-105,85)
    targets={**a,'stock_neck':neck}
    hits=[]
    for station in ('fixed','sliding_1','sliding_2'):
        direction=-1 if station=='fixed' else 1
        for i in range(41):
            moving=a['cuff_key_'+station].translate((direction*i*.5,0,0))
            for other,obj in targets.items():
                if other=='cuff_key_'+station:continue
                v=b.overlap(moving,obj)
                if v>.01:hits.append(['key',station,i,other,round(v,5)])
        # Remove key and phone first, then lift cuff toward the open phone space.
        for i in range(21):
            moving=a['cuff_'+station].translate((direction*i*.5,0,0))
            for other,obj in targets.items():
                if other in ('cuff_'+station,'cuff_key_'+station):continue
                v=b.overlap(moving,obj)
                if v>.01:hits.append(['cuff',station,i,other,round(v,5)])
    screen=b.box(p.phone_left+3,p.phone_right-3,p.phone_center_y-p.phone_length/2+3,p.phone_center_y+p.phone_length/2-3,-100,18-p.phone_thickness)
    screen_hits={n:round(v,5) for n,obj in a.items() if n.startswith('cuff_') and (v:=b.overlap(obj,screen))>.01}
    camera=b.stock(p)['camera_keepout']
    camera_hits={n:round(v,5) for n,obj in a.items() if n.startswith('cuff_') and (v:=b.overlap(obj,camera))>.01}
    neck_hits={n:round(v,5) for n,obj in a.items() if n.startswith('cuff_') and (v:=b.overlap(obj,neck))>.01}
    # Exact shared manufactured key, rigidly transformed into each socket.
    exact=locate(cuff_key(),p.phone_right,FIXED_CUFF_Y,True)
    mismatch=exact.cut(a['cuff_key_fixed']).val().Volume()+a['cuff_key_fixed'].cut(exact).val().Volume()
    assert mismatch<1e-6,mismatch
    configs[name+'-'+side]={'service_collisions':hits,'screen_hits_3mm_assumed_rim':screen_hits,'camera_hits':camera_hits,'neck_hits':neck_hits}
    print(name+'-'+side,configs[name+'-'+side],flush=True)
# Preserve tongue stop and whole jaw/cuff unit clearance over the original range.
fixed=s['carrier'].union(locate(c,-20,FIXED_CUFF_Y,True)).union(locate(cuff_key(),-20,FIXED_CUFF_Y,True))
moving=s['sliding_jaw']
for y in (-50,50):moving=moving.union(locate(c,SLIDING_CUFF_X,y)).union(locate(cuff_key(),SLIDING_CUFF_X,y))
travel=[]
for i in range(91):
    x=b.CLOSED_JAW_X-45*i/90;v=b.overlap(fixed,moving.translate((x,0,0)))
    assert v<.01,(x,v)
    travel.append(v)
stop=b.overlap(fixed,moving.translate((b.CLOSED_JAW_X+.2,0,0)))
assert stop>.01
passed=all(not v for cfg in configs.values() for v in cfg.values())
report={'revision':b.REVISION,'passed':passed,'approved_cuff_stl_sha256':hashlib.sha256(reference.read_bytes()).hexdigest(),
 'approved_cuff_symmetric_difference_mm3':difference,'approved_cuff_volume_mm3':c.val().Volume(),
 'cuff_count':3,'shared_key_count':4,'fixed_contact_y_mm':FIXED_CUFF_Y,'sliding_contact_y_mm':[-50,50],
 'sliding_socket_outward_shift_mm':.3,'cuff_center_z_mm':CUFF_Z,'head_shoulder_mm':1.7,
 'stem_hole_mm':[3.4,3.4],'head_recess_mm':[7.4,3.4],'jaw_travel_samples':91,
 'max_jaw_travel_collision_mm3':max(travel),'overtravel_stop_mm3':stop,'configurations':configs,
 'limits':['Key sockets are rib-free and have no positive pull-out latch.',
 'Screen check assumes a 3 mm non-screen rim; actual phones/cases may differ. Camera box is not optical framing.',
 'Phone dimensions unchanged. 18/20 mm examples remain too thick; thin-phone seating and TPU deformation are not simulated.',
 'Approved cuff printing does not qualify new sockets, jaw strength, key wear or loaded retention.',
 'Service paths are sampled rigid motions with phone removed, not ergonomic or force tests.']}
(root/'review/cuff-integration.json').write_text(json.dumps(report,indent=2)+'\n')
assert passed,report
print('Cuff integration checks passed',flush=True)

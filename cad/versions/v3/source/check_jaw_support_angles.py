"""Recipe-specific angle sweep and geometric retention, not physical validation."""
import json, math, hashlib
import numpy as np
import cadquery as cq
import build as b
import cuff_design as c

root=b.ROOT; jobs=root/'print/jobs'
rows=[]
for angle in (30,31,32,34,35,40):
    job=jobs/f'2026-10-25-sliding-jaw-angle-{angle}'
    r=json.loads((job/'review.json').read_text())
    rows.append(dict(angle_degrees=angle,support_g=r['deposited_g_by_role'].get('support',0),
        interface_g=r['deposited_g_by_role'].get('interface',0),total_g=r['total_g'],
        minutes=r['total_minutes'],hashes=r['hashes']))
assert rows[0]['support_g']+rows[0]['interface_g']>0
assert all(r['support_g']+r['interface_g']==0 for r in rows[1:])
for key in ('machine.json','process.json','filament.json'):
    assert len({r['hashes'][key] for r in rows})==1
stud=c.integral_stud();cuff=c.cuff()
assert b.overlap(stud,cuff)<1e-6
pullout=b.overlap(stud,cuff.translate((1,0,0)))
assert pullout>0
s=b.sliding_jaw(b.Parameters())
assert s.val().isValid() and len(s.val().Solids())==1
old=cq.importers.importStep(str(jobs/'2026-10-25-sliding-jaw-lowered-cleat-source/sliding-jaw.step'))
for region in (b.box(-6,50,-11,11,26.4,30.4),b.box(-11,0,-11,11,45,48)):
    a=s.intersect(region);d=old.intersect(region)
    assert sum(v.Volume() for v in a.cut(d).solids().vals())+sum(v.Volume() for v in d.cut(a).solids().vals())<1e-6
# Prove source STEP in each final slice matches active manufacturing geometry.
for part,shape,job in [('sliding-jaw',s,jobs/'2026-10-25-sliding-jaw-angle-35'),
                      ('fixed-jaw',b.carrier(b.Parameters()),jobs/'2026-10-25-sliding-jaw-fixed-angle-35')]:
    saved=cq.importers.importStep(str(job.parent/(job.name+'-source')/(part+'.step')))
    delta=sum(v.Volume() for v in saved.cut(shape).solids().vals())+sum(v.Volume() for v in shape.cut(saved).solids().vals())
    assert delta<1e-5,(part,delta)
job=jobs/'2026-10-25-sliding-jaw-fixed-angle-35'
inputs=json.loads((job/'inputs.json').read_text())['parts'][0]
q=c.locate(stud,c.FIXED_CUFF_X,0,True).val().BoundingBox()
corners=np.array([[x,y,z,1] for x in (q.xmin,q.xmax) for y in (q.ymin,q.ymax) for z in (q.zmin,q.zmax)])
points=(corners@np.array(inputs['rotation_matrix']).T)[:,:3]
points+=np.array(inputs['centering_translation_mm'])+np.array([90,90,0])
low=points.min(axis=0);high=points.max(axis=0)
# Support in the stem/head neighborhood (not the separate neck cavity below it).
counts={}
meta=json.loads((job/'paths.json').read_text())
for role in ('support','interface'):
    path=job/meta['paths'][role]['file']
    seg=np.fromfile(path,dtype='<f4').reshape(-1,2,3)
    hit=((seg.max(axis=1)>=low-.25)&(seg.min(axis=1)<=high+.25)).all(axis=1)
    counts[role]=int(hit.sum())
assert not any(counts.values()),counts
band_sweep={}
p=b.Parameters();_,bands,_=b.flexible_paths(p)
for angle in (31,32,33,34,35):
    shape=b.sliding_jaw(p,support_angle=angle).translate((p.phone_left,0,0))
    band_sweep[angle]=max(b.overlap(b.polyline(bands[k],1.4),shape) for k in ('band_jaw_1','band_jaw_2'))
assert band_sweep[33]>.01 and band_sweep[34]<1e-6
assert c.STUD_SUPPORT_ANGLE==35
report=dict(revision=b.REVISION,passed=True,selected_angle_degrees=35,
    selection_reason='User rounds tested 34-degree functional minimum up to 35 for memorability.',
    slicer_only_minimum_degrees=31,band_overlap_sweep_mm3=band_sweep,
    angle_reference='From horizontal print bed; 55 degrees from build axis',
    resolution_degrees=1,physical_minimum_known=False,slices=rows,
    fixed_stud_support_segment_counts=counts,fixed_stud_bed_bounds=[low.tolist(),high.tolist()],
    fixed_jaw_slice=json.loads((job/'review.json').read_text())['deposited_g_by_role'],
    head_width_mm=9.2,passage_width_mm=6.8,head_recess_width_mm=9.6,
    seated_stud_cuff_overlap_mm3=0,rigid_pullout_obstruction_at_1mm_mm3=pullout,
    minimum_cleat_stem_x_mm=7-3.25*math.tan(math.radians(35)),
    limits=['31 degrees is the minimum whole-degree slicer result, not a measured PETG capability.',
        'Supports enabled; exact recipe and mesh placement matter. No universal minimum is claimed.',
        'Ramped retaining shoulders may lower pull-out resistance. Test existing TPU cuffs before phone use.',
        'Full fixed jaw still requires unrelated neck-cavity and fixed-cleat supports.',
        'Cuffs, sliding tongue and square cleat cap unchanged; existing routing/phone-fit limits remain.'])
b.save(b.OUT/'jaw-support-angles.json',report)
print(json.dumps(report,indent=2))

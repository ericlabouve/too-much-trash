"""Flush beam faces, original contact stations and shifted engagement."""
import json
import build as b
from cuff_design import CUFF_Z, SLIDING_CUFF_X, locate, integral_stud, cuff
p=b.Parameters();new=b.sliding_jaw(p);old=b.sliding_jaw(p,flush_beam=False)
vol=lambda s:sum(v.Volume() for v in s.solids().vals())
diff=lambda a,c:vol(a.cut(c))+vol(c.cut(a))
assert new.val().isValid() and len(new.val().Solids())==1
beam=b.box(-10,-2,-60.8,60.8,CUFF_Z-5.8,CUFF_Z+5.8)
assert vol(beam.cut(new))<1e-6
upper=b.box(-30,60,-70,70,24.01,60)
assert diff(old.intersect(upper),new.intersect(upper))<1e-6
for y in (-50,50):
    x=SLIDING_CUFF_X+b.SLIDING_BEAM_SHIFT
    assert vol(locate(integral_stud(),x,y).cut(new))<1e-6
    assert b.overlap(locate(cuff(),x,y),new)<1e-6
rear=[f for f in new.val().Faces() if abs(f.BoundingBox().xmin+10)<1e-6 and abs(f.BoundingBox().xmax+10)<1e-6]
assert any(f.BoundingBox().ylen>121 and f.BoundingBox().zlen>32 for f in rear)
engagement={}
for name,p in b.SAMPLES.items():
    x=p.phone_left-b.SLIDING_BEAM_SHIFT
    overlap=min(-18,x+b.SLIDING_TONGUE_LENGTH)-max(-110.3,x-6)
    assert overlap>20
    moving=new.translate((x,0,0));fixed=b.carrier(p)
    assert b.overlap(moving,fixed)<1e-6
    # Check nominal moving/fixed band envelopes in assembled coordinates.
    for z in b.JAW_BAND_LEVELS:
        band=b.polyline(b.jaw_band(x-1+b.SLIDING_CLEAT_SHIFT,b.FIXED_CLEAT_X,z),1.4)
        assert b.overlap(band,moving)<.01
    engagement[name]=round(overlap,3)
report=dict(revision=b.REVISION,passed=True,valid=True,solid_count=1,
 beam_mm=[8,121.6,11.6],common_rear_plane_x_mm=-10,common_front_plane_x_mm=-2,
 local_beam_stud_shift_mm=5.2,assembly_jaw_shift_mm=-5.2,
 assembled_cuff_positions_unchanged=True,tongue_and_cleat_design_unchanged=True,
 tongue_track_axial_overlap_mm=engagement,nominal_moving_band_clear=True,band_envelope_diameter_mm=1.4,
 previous_volume_mm3=vol(old),new_volume_mm3=vol(new),
 limits=['Geometric engagement only, not stiffness or loaded retention.',
 'Jaw bands span5.2 mm farther; real preload/return need testing.',
 'Band clearance uses historical1.4 mm envelope; a1.5 mm envelope intersects the moving cleat by about0.034 mm3 and is not cleared.',
 'No print sent.'])
prior=b.ROOT/'print/jobs/2026-10-25-continuous-beam-petg'
trial=b.ROOT/'print/jobs/2026-10-25-flush-beam-petg'
if (trial/'review.json').exists():
    for name in ('machine.json','process.json','filament.json'):
        assert (prior/name).read_bytes()==(trial/name).read_bytes()
    source=b.cq.importers.importStep(str(trial.parent/(trial.name+'-source')/'sliding_jaw.step'))
    assert diff(new.rotate((0,0,0),(0,1,0),-90),source)<1e-5
    a=json.loads((prior/'review.json').read_text());c=json.loads((trial/'review.json').read_text())
    support=lambda r:sum(r['deposited_g_by_role'].get(k,0) for k in ('support','interface'))
    report['matched_slice']=dict(profiles_identical=True,source_matches=True,
        previous_support_g=support(a),new_support_g=support(c),
        reduction_percent=100*(1-support(c)/support(a)),
        previous_total_g=a['total_g'],new_total_g=c['total_g'],
        previous_minutes=a['total_minutes'],new_minutes=c['total_minutes'],
        warnings=c['warning'],hashes=c['hashes'])
(b.ROOT/'review/flush-beam.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))

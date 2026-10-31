"""Export this cap-only subtraction using an explicit prior-clearance proof.

Not a general incremental build: the baseline and removed region are asserted
by check_flush_cap_center. Prior collision values remain conservative bounds.
Run build.py for a fresh exhaustive collision report instead.
"""
import json
import check_flush_cap_center as audit
import build as b

prior=json.loads((b.OUT/'validation.json').read_text())
assert all(c['mechanical_passed'] for c in prior['configurations'].values())
assert audit.report['passed'] and audit.report['added_volume_mm3']<1e-6
solids=b.parts(b.Parameters())
for name,p in b.SAMPLES.items():
 for side in ('near','far'):
  key=name+'-'+side
  b.export_scene(b.replace(p,side=side),solids,b.OUT if key=='wallet-near' else b.OUT/key)
  print('Exported',key,flush=True)
b.manufacturing(solids);b.write_bom()
prior['revision']=b.REVISION
prior['validation_provenance']={
 'method':'Conservative inheritance after proven cap-only subtraction; not an exhaustive rerun.',
 'baseline_revision':'straddled-four-bolt-collar-v3',
 'proof':'flush-cap-center.json',
 'reason':'No added volume or placement change; removal is limited to the cap center, away from rail slots, mounting faces and neck opening. Prior collision-free rigid and service paths remain collision-free.',
 'collision_values':'Prior values retained as conservative bounds; known phone-fit and twine failures remain unresolved.'}
prior['solids']['shaft_cap']={'valid':audit.report['valid'],'solid_count':audit.report['solid_count']}
b.save(b.OUT/'validation.json',prior)
print('Cap-only subtraction exports complete; prior full checks explicitly inherited.',flush=True)

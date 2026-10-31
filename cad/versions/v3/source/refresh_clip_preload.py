"""Refresh only clip-preload refinement after the complete same-revision build."""
from build import *

solids=parts(Parameters())
report=json.loads((OUT/'validation.json').read_text())
audit={}
for name,base in SAMPLES.items():
 for side in ('near','far'):
  p=replace(base,side=side);key=name+'-'+side
  a=assembly_parts(p,solids)
  hits={n:v for n,s in a.items() if n!='guide_1' and (v:=overlap(a['guide_1'],s))>.01}
  assert not hits,(key,hits)
  assert not overlap(a['guide_1'],stock(p)['phone_envelope'])
  audit[key]=hits
  export_scene(p,solids,OUT if key=='wallet-near' else OUT/key)
report['clip_preload_refinement']={'cavity_mm':[13.8,18.8],'assembly_intersections_mm3':audit,'neck_interference':'Intentional TPU elastic fit; see tpu-clip-guide.json. Not simulated deformation.'}
save(OUT/'validation.json',report)
manufacturing(solids)
write_bom()
print('Final preloaded clip exports and assembly checks complete',flush=True)

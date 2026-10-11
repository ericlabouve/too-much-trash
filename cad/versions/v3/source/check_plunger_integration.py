"""Direct-cord cassette audit. Analytic collisions are not force/print validation."""
import json
from pathlib import Path
from dataclasses import replace
from build import overlap,SAMPLES
import model as m
from plunger_design import cassette,return_path,attachment_path,pulley_path,keeper_path,tube
s=cassette();solids=m.parts(m.Parameters())
report={'revision':'flat-back-mount-v3','routing':{},'stroke':{},'downstream_route':{},
 'limitations':['Nominal 0.65 mm motion is prescribed, not a physical phone-safe stop.','Band/cord dimensions, knots, button force, fleet-angle friction and printed retention need physical testing.','The 14 mm pocket still excludes the recorded 18/20 mm phones.']}
for d in (0,.325,.65):
 moving=s['plunger'].translate((-d,0,0))
 report['stroke'][str(d)]={n:round(overlap(moving,s[n]),5) for n in s if n!='plunger'}
 for name,path,r in [('return',return_path(d),.6),('attachment',attachment_path(d),1),('pulley',pulley_path(d),1),('keeper',keeper_path(),.6)]:
  cord=tube(path,r)
  report['routing'][f'{name}-{d}']={n:round(overlap(cord,moving if n=='plunger' else solid),5) for n,solid in s.items()}
for name,base in SAMPLES.items():
 for side in ('near','far'):
  p=replace(base,side=side);a=m.assembly_parts(p,solids);path,_,_=m.flexible_paths(p);hits=[]
  # Direct span and subsequent guides, including all four relocated clamp pairs.
  for i,(start,end) in enumerate(zip(path[33:],path[34:]),33):
   cord=m.rod(start,end,2)
   for n,part in a.items():
    v=overlap(cord,part)
    if v>.01:hits.append([i,n,round(v,5)])
  report['downstream_route'][name+'-'+side]=hits
  print(name+'-'+side,hits,flush=True)
report['rigid_motion_passed']=all(v<.01 for row in report['stroke'].values() for v in row.values())
report['cassette_routing_clear']=all(v<.01 for row in report['routing'].values() for v in row.values())
report['routing_clear']=report['cassette_routing_clear'] and not any(report['downstream_route'].values())
report['axial_retention']={
 'head_obstruction_mm3':round(overlap(s['pulley_axle'].translate((0,1,0)),s['actuator_bracket']),5),
 'key_obstruction_mm3':round(overlap(s['pulley_key'].translate((0,-2,0)),s['actuator_bracket']),5),
 'wheel_axial_clearance_mm':.8,'axle_diametral_clearance_mm':.6,
 'key_slot_clearance_per_side_mm':.2,'axle_end_ligament_mm':2.2,
 'axle_span_mm':18.4,'head_thickness_mm':1.6,'front_bearing_length_mm':2,'rear_bearing_length_mm':4,'keeper_envelope_diameter_mm':1.2,
 'meaning':'Head and installed key geometrically block axial escape. This does not test strength, wear or keeper-band failure.'}
report['volumes_mm3']={n:round(s.val().Volume(),2) for n,s in solids.items()}
report['previous_mesh_volumes_mm3']={'actuator_bracket':15773.76,'shaft_cap':38018.13,'carrier':65138.6,'dual_string_guide':5889.7}
out=Path(__file__).resolve().parents[1]/'review/plunger-integration.json'
out.write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2),flush=True)
assert report['rigid_motion_passed'] and report['routing_clear'],report

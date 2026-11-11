"""Validate tightened guide and slice the bracket alone; no printer contact."""
from pathlib import Path
import sys,json,hashlib
from build_compact_mount_concept import geometry_compact
from geometry_common_key import geometry_common_key
from build_travel_stops import overlap
from build import export
from prepare_material_plates import slice_plate
from dataclasses import replace
from build_preview import clamp_geometry
from plunger_design import local_shape
import model,build
out=Path(sys.argv[1]).resolve(); out.mkdir(parents=True,exist_ok=True)
b,p,k,ctx=geometry_compact(); _,original,_,_=geometry_common_key()
assert b.val().isValid() and len(b.val().Solids())==1
assert p.cut(original).val().Volume()<1e-6
assert p.val().isValid() and len(p.val().Solids())==1
assert abs(p.val().BoundingBox().xlen-16)<1e-5
source=out/'source';source.mkdir(exist_ok=True)
export(b,source/'bracket.stl',manufacturing=True)
export(p,source/'plunger.stl',manufacturing=True)
rows=[]
for d in sorted(set([i*.5 for i in range(107)]+[12.6])):
    m=p.translate((0,-d,0)); row={'travel_mm':d,'bracket_mm3':overlap(m,b),'context_mm3':sum(overlap(m,s) for s in ctx.values())}
    if d<=12.6:
        key=k.translate((0,-d,0))
        for lift in (0,.4,.8):
            floating=key.translate((0,0,lift))
            row[f'key_bracket_lift_{lift}_mm3']=overlap(floating,b)
            row[f'key_context_lift_{lift}_mm3']=sum(overlap(floating,s) for s in ctx.values())
    assert max(v for n,v in row.items() if n!='travel_mm')<1e-5,row
    rows.append(row)
    if d in (0,6,12.6,53):print('checked',d,flush=True)
stops={'beyond_pull_mm3':overlap(k.translate((0,-12.8,0)),b),'upward_escape_mm3':overlap(k.translate((0,0,.9)),b)}
assert min(stops.values())>1e-5,stops
(out/'validation.json').write_text(json.dumps({'revision':'v4-tail-recess-matched-guide','samples':rows,'positive_stops':stops,'plunger_shaft_base_width_mm':8,'plunger_shaft_top_width_mm':2*(4-3.2/(3**.5)),'nominal_guide_side_clearance_mm':0.2,'key_hole_width_mm':3.4,'key_hole_side_ligament_at_shaft_top_mm':4-3.2/(3**.5)-1.7,'rail_opening_mm':[20.4,20.9],'rail_screw_center_xz_mm':[-18,8.4],'bracket_stl_sha256':hashlib.sha256((source/'bracket.stl').read_bytes()).hexdigest(),'limits':['Sampled rigid translation, not loaded movement or TPU flexure.','Twist escape and physical fit remain unverified.']},indent=2)+'\n')
# Check the relocated hook against the actual cap and rail hardware in all
# recorded phone and side configurations.
solids=model.parts(build.SAMPLES['wallet'])
cap,jaw,*_=clamp_geometry(build.SAMPLES['wallet'])
solids.update(shaft_cap=cap,carrier=jaw,actuator_bracket=local_shape(b))
assemblies={}
for sample,params in build.SAMPLES.items():
    for side in ('near','far'):
        params=replace(params,side=side)
        parts=model.assembly_parts(params,solids)
        for name in parts:
            if name.startswith(('rail_screw_','rail_nut_')):
                parts[name]=parts[name].translate((0,1.4,0))
        hits={name:overlap(parts['actuator_bracket'],shape) for name,shape in parts.items()
              if name in ('shaft_cap','carrier') or name.startswith(('rail_screw_','rail_nut_'))}
        assert max(hits.values())<1e-5,(sample,side,hits)
        assemblies[sample+'-'+side]=hits
(out/'assembly-check.json').write_text(json.dumps(assemblies,indent=2)+'\n')
(source/'fit-attachment-check.json').write_text((out/'validation.json').read_text())
slice_plate(out/'slice',source,{'bracket':((60,80),'Z',0,'Bracket base down'),'plunger':((120,80),'Z',0,'Plunger base down')},'PETG')
review=json.loads((out/'slice'/'review.json').read_text())
assert all(not value for obj in review['objects'].values() for role,value in obj['deposited_g_by_role'].items() if role in ('support','interface'))

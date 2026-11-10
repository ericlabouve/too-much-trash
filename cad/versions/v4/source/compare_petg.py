"""Compare current canonical V3 and V4 PETG solids; write an ignored JSON report.

Run with V4 and V3 source directories on PYTHONPATH and an output filename.
"""
from pathlib import Path
import json,sys
from build_preview import clamp_geometry
from build_compact_mount_concept import geometry_compact
from plunger_design import local_shape
import model,build
p=build.SAMPLES['bare'];v3=model.parts(p);v4=dict(v3)
cap,jaw,*_=clamp_geometry(p);br,pl,*_=geometry_compact()
v4.update(shaft_cap=cap,carrier=jaw,actuator_bracket=local_shape(br),plunger=local_shape(pl))
rows=[]
for n in ['shaft_cap','carrier','sliding_jaw','actuator_bracket','plunger','pulley','pulley_axle']:
 a,b=v3[n],v4[n]
 removed=a.cut(b).val().Volume();added=b.cut(a).val().Volume()
 row=dict(name=n,v3_volume_mm3=a.val().Volume(),v4_volume_mm3=b.val().Volume(),removed_mm3=removed,added_mm3=added,changed=removed+added>1e-5)
 rows.append(row);print(row,flush=True)
Path(sys.argv[1]).write_text(json.dumps({'baseline':'Current canonical V3 model, including October 31 braced actuator and extended diamond axle','comparison':'Boolean solid difference in common model coordinates','parts':rows},indent=2)+'\n')

"""Single closed mounting bore and shoe coverage; not force validation."""
import json
from pathlib import Path
from dataclasses import replace
import build as b
p=b.Parameters();parts=b.parts(p);rows={}
for name,base in b.SAMPLES.items():
 for side in ('near','far'):
  p=replace(base,side=side);a=b.assembly_parts(p,parts);target=b.stock(p)['phone_volume_up'].val().BoundingBox()
  # Nominal seated reference; target buttons retain their physical proxy heights.
  assert p.height==0
  assert target.zmin>=0 and target.zmax<=16,(name,target.zmin,target.zmax)
  collisions={str(i):b.overlap(a[f'rail_screw_{i}'],a['actuator_bracket']) for i in (1,)}
  assert max(collisions.values())<.01,collisions
  rows[name+'-'+side]={'button_z_bounds_mm':[target.zmin,target.zmax],'module_depth_offset_mm':p.height,'screw_bracket_intersection_mm3':collisions}
out={'passed':True,'revision':'flat-back-mount-v3','shoe_y_width_mm':6,'shoe_z_height_mm':16,'shoe_z_bounds_mm':[0,16],'bracket_mount_seats':{'type':'closed bore with two locating lugs','width_mm':8.8,'centers_yz_mm':[[b.MOUNT_Y,26]],'lug_envelope_yz_mm':[16,8.2],'engagement_mm':4},'configurations':rows,'limitations':['Nominal seated bounding-envelope coverage only: seat play, rounded edges, case geometry, button force and released clearance need physical tests.','Existing 14 mm pocket conflict for recorded 18/20 mm phones remains.']}
(Path(__file__).resolve().parents[1]/'review/fixed-mount.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out,indent=2))

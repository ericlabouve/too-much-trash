"""Fixed-hole seating and perpendicular shoe coverage; not button force validation."""
import json
from pathlib import Path
from dataclasses import replace
import build as b
p=b.Parameters();parts=b.parts(p);rows={}
for name,base in b.SAMPLES.items():
 for side in ('near','far'):
  p=replace(base,side=side);a=b.assembly_parts(p,parts);target=b.stock(p)['phone_volume_up'].val().BoundingBox()
  # The round holes fix module depth; target buttons retain their original physical proxy heights.
  assert p.height==0
  assert target.zmin>=0 and target.zmax<=16,(name,target.zmin,target.zmax)
  collisions={str(i):b.overlap(a[f'rail_screw_{i}'],a['actuator_bracket']) for i in (1,2)}
  assert max(collisions.values())<.01,collisions
  rows[name+'-'+side]={'button_z_bounds_mm':[target.zmin,target.zmax],'module_depth_offset_mm':p.height,'screw_bracket_intersection_mm3':collisions}
out={'passed':True,'shoe_rotation_degrees_about_local_x':90,'shoe_y_width_mm':4,'shoe_z_height_mm':16,'shoe_z_bounds_mm':[0,16],'shoe_additional_z_translation_mm':2,'bracket_mount_holes':{'diameter_mm':8.8,'centers_yz_mm':[[-9.5,-14],[9.5,-14]],'spacing_mm':19},'configurations':rows,'limitations':['Nominal depth coverage only: rotation changes the contact trajectory; case geometry, button force and released clearance need physical tests.','Existing 14 mm pocket conflict for recorded 18/20 mm phones remains.','Remaining plate windows are lightening openings, not fastener adjustment slots.']}
(Path(__file__).resolve().parents[1]/'review/fixed-mount.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out,indent=2))

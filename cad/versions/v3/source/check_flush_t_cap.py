"""Option A plane/slot audit. This is not a slice or structural qualification."""
import json
from pathlib import Path
from dataclasses import replace
from build import SAMPLES, overlap
import model as m

s=m.parts(m.Parameters());cap=s['shaft_cap'];rail=m.paired_neck_rail()
assert cap.val().isValid() and len(cap.val().Solids())==1
assert abs(cap.val().BoundingBox().xmax-12)<1e-5
assert abs(rail.val().BoundingBox().xmax-12)<1e-5
center=m.cylinder((5,0,26),(1,0,0),8,8.8)
assert overlap(cap,center)>300, 'Middle must remain solid, not a through-slot'
rows={}
for name,base in SAMPLES.items():
 for side in ('near','far'):
  p=replace(base,side=side);ys=[p.button_y+m.MOUNT_Y]
  holes=[overlap(cap,m.cylinder((5,y,26),(1,0,0),8,8.8)) for y in ys]
  assert max(holes)<.01,(name,side,holes)
  rows[name+'-'+side]={'screw_centers_y_mm':ys,'shaft_passage_intersections_mm3':holes}
old={'shaft_cap':35643.95,'actuator_bracket':8482.12}
volumes={n:{'previous_mm3':v,'current_mm3':round(s[n].val().Volume(),2),'change_percent':round(100*(s[n].val().Volume()/v-1),2)} for n,v in old.items()}
out={'revision':'flat-back-mount-v3','passed':True,'choice':'A: coplanar rail, not perpendicular flange',
 'rail':{'outer_plane_x_mm':12,'thickness_mm':6,'span_y_mm':120,'span_z_mm':[16,36],'screw_z_mm':26,'old_screw_z_mm':-14,'solid_middle':True,'wing_slot_endpoint_centers_y_mm':[[-54,-18.5],[18.5,54]]},
 'adaptation':'Crossbar moved to cap end to clear the unchanged plunger and pulley; mounting bar moves inward 10 mm and upward 40 mm. Cap main face increased 0.7 mm to match existing ear faces.',
 'unchanged':['11.6 x 17.6 mm neck opening','102 mm collar mating length','Four collar fastener stations and all fastener designs','Phone, plunger, pulley and cord positions','V1 and V2'],
 'manufacturing_orientation':{'axis':'Y','degrees':90,'bed_face':'common X12 exterior','support_free_verified':False},
 'configurations':rows,'volumes':volumes,
 'limitations':['Solid volume is not sliced filament use. Support savings unmeasured.','Local bracket-to-wing nominal gap is 0.2 mm, not a qualified printed tolerance.','Root strength, clamping retention and new mounting sequence require physical validation.','14 mm pocket conflict and unqualified button force/overtravel remain.']}
(Path(__file__).resolve().parents[1]/'review/flush-t-cap.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2),flush=True)

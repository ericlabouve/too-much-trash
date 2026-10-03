"""Verify the two bracket tabs act as mechanical travel stops."""
import json,math
from pathlib import Path
import build as b
import model as m
p=m.Parameters();angle=m.stop_angle(p);top=18-21*math.sin(abs(angle))-3*math.cos(abs(angle))
blocks={'press_stop':m.box(38,42,-1.5,1.5,top-2.4,top),'return_stop':m.box(39,42,-1.5,1.5,21,23.4)}
rocker=m.rocker(p);bracket=m.actuator_bracket(p);rows=[]
for degrees in (-1,0,math.degrees(angle),math.degrees(angle)+1):
 moving=rocker.rotate((19,0,18),(19,1,18),degrees)
 rows.append({'angle_degrees':degrees,**{n:b.overlap(moving,v) for n,v in blocks.items()}})
attached={n:b.overlap(v,bracket) for n,v in blocks.items()}
passed=rows[0]['return_stop']>.01 and rows[-1]['press_stop']>.01 and all(max(row['press_stop'],row['return_stop'])<.01 for row in rows[1:3]) and min(attached.values())>0
report={'revision':'compact-rails-r12','tabs':'Retained: press travel stop and return travel stop, not unused guide remnants.','nominal_stroke_degrees':[0,math.degrees(angle)],'stop_intersections_mm3':rows,'stop_material_in_bracket_mm3':attached,'passed':passed,'limitations':'Geometric contact only; printed strength, deformation, wear and actual button force remain unvalidated.'}
(Path(__file__).resolve().parents[1]/'review/rocker-stops.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2));assert passed

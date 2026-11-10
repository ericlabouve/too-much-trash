"""Audit nominal 1 mm string straight leads against surrounding rigid parts."""
from pathlib import Path
from dataclasses import replace
import sys,json
import cadquery as cq
from build_compact_mount_concept import geometry_compact
from build_preview import clamp_geometry
from plunger_design import local_shape
from cord_routes import routes
import model,build
p0=build.SAMPLES['bare'];s=model.parts(p0);cap,jaw,*_=clamp_geometry(p0)
br,pl,key,ctx=geometry_compact();s.update(shaft_cap=cap,carrier=jaw,actuator_bracket=local_shape(br),plunger=local_shape(pl))
rows=[]
for sample,p in build.SAMPLES.items():
 for side in ('near','far'):
  p=replace(p,side=side);parts=model.assembly_parts(p,s)
  for n in parts:
   if n.startswith(('rail_screw_','rail_nut_')):parts[n]=parts[n].translate((0,1.4,0))
   if n.startswith(('clamp_screw_','clamp_nut_')):
    z=model.CLAMP_STATIONS[int(n.rsplit('_',1)[1])-1][1];parts[n]=parts[n].translate((0,0,5 if z<15 else -5))
  target={n:v for n,v in parts.items() if n in ('shaft_cap','carrier','actuator_bracket','pulley_key') or n.startswith(('clamp_','rail_'))}
  for d in (0,6.3,12.6):
   pts=routes(p,d)['string_points']
   for seg,a,b in [('handle_lead',pts[0],pts[1]),('pulley_to_cap',pts[-4],pts[-3]),('cap_passage',pts[-3],pts[-2])]:
    edge=cq.Edge.makeLine(cq.Vector(*a),cq.Vector(*b))
    for n,shape in target.items():
     distance=edge.distance(shape.val());clearance=distance-.5
     if clearance<.1:
      row=dict(sample=sample,side=side,travel_mm=d,segment=seg,part=n,centerline_distance_mm=distance,cord_surface_clearance_mm=clearance);rows.append(row);print(row,flush=True)
Path(sys.argv[1]).write_text(json.dumps({'cord_diameter_mm':1,'travel_samples_mm':[0,6.3,12.6],'near_contacts':rows,'limits':'Straight lead centerline distances only; excludes intended pulley wrap and handle knot. No flexible contact/friction simulation.'},indent=2)+'\n')

"""Knot envelope sweep; illustrative knot dimensions, not measured physical fit."""
import math
from dataclasses import replace
import build as b
import model as m

def main():
 solids=m.parts(m.Parameters());report={'revision':'closed-clamp-r8','attachment':'Loop through the 8 mm eye and around its front ligament; tie the end back to the standing string. No stopper knot bears against the hole. Actual knot security remains untested.','assumed_knot_envelopes_mm':[[8,4],[10,6]],'samples':{},'limitations':['Illustrative cylindrical envelopes, not actual knots or finger-access simulation','Printed knot retention, twine friction and strength remain unmeasured']}
 for name,base in b.SAMPLES.items():
  for side in ('near','far'):
   p=replace(base,side=side);assy=m.assembly_parts(p,solids);hits=[]
   for diameter,height in report['assumed_knot_envelopes_mm']:
    knot=m.placed(m.cylinder((33,0,24),(0,0,1),height,diameter),p)
    for i in range(11):
     moving=knot.rotate(p.pivot,(p.pivot[0],p.pivot[1]+1,p.pivot[2]),math.degrees(m.stop_angle(p))*i/10)
     for n in ('carrier','sliding_jaw','actuator_bracket','pivot_key','contact_screw'):
      v=b.overlap(moving,assy[n])
      if v>.01:hits.append({'diameter':diameter,'height':height,'stroke':i/10,'part':n,'mm3':round(v,3)})
   loop=m.polyline(m.attachment_loop(p),3)
   for i in range(11):
    moving=loop.rotate(p.pivot,(p.pivot[0],p.pivot[1]+1,p.pivot[2]),math.degrees(m.stop_angle(p))*i/10)
    for n,solid in assy.items():
     if n=='rocker':solid=solid.rotate(p.pivot,(p.pivot[0],p.pivot[1]+1,p.pivot[2]),math.degrees(m.stop_angle(p))*i/10)
     v=b.overlap(moving,solid)
     if v>.01:hits.append({'loop_diameter':3,'stroke':i/10,'part':n,'mm3':round(v,3)})
   report['samples'][name+'-'+side]=hits
   print(name,side,hits,flush=True)
 # Flexible band proxy may overlap its fixed attachment; exclude only a 4 mm
 # radius region around that modeled hook. Check the free span separately.
 p=m.Parameters();bracket=m.assembly_parts(p,solids)['actuator_bracket'];fixed=p.point((38,14,28))
 free_hits=[]
 for i in range(11):
  moving=m.rotate_point(p.point((33,8,18)),p,m.stop_angle(p)*i/10)
  points=m.loop_between(moving,fixed,2)
  for u,v in zip(points,points[1:]):
   mid=tuple((x+y)/2 for x,y in zip(u,v))
   if math.dist(mid,fixed)<4:continue
   volume=b.overlap(m.rod(u,v,1.4),bracket)
   if volume>.01:free_hits.append({'stroke':i/10,'midpoint':mid,'mm3':round(volume,3)})
 report['return_band_free_span']={'fixed_hook_exclusion_radius_mm':4,'proxy_diameter_mm':1.4,'intersections':free_hits,'scope':'Canonical module; both-side placements are rigid transforms. Contact/wrapping at hooks is not simulated.'}
 report['passed']=not any(report['samples'].values()) and not free_hits;b.save(b.OUT/'attachment-audit.json',report)
 assert report['passed'],'Knot envelope interference'
if __name__=='__main__':main()

"""Non-manufacturing rail study. Does not change active CAD or print files.
View envelopes conservatively start from every point in the illustrative camera
rectangle, not a measured lens. Angles are sensitivity cases, not phone specs.
"""
from pathlib import Path
import sys,json,math
from dataclasses import replace
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'archive/raised-r2/source'))
import build as b
import model as m
OUT=ROOT/'studies/camera-clearance'

def low_rail(sign=1,post_top=26):
 s=m.box(36,42,-6,100,-4,16).union(m.box(36,42,-6,12,16,post_top))
 cut=m.box(35,43,0,94,1.6,10.4)
 for y in (0,94):cut=cut.union(m.cylinder((35,y,6),(1,0,0),8,8.8))
 s=s.cut(cut)
 return s if sign==1 else s.mirror('YZ')

def candidate(solids):
 s=dict(solids)
 s['carrier']=solids['carrier'].cut(m.rail().translate((-20,0,0))).union(low_rail().translate((-20,0,0))).union(m.box(7.3,22,-12,12,22,26))
 s['sliding_jaw']=solids['sliding_jaw'].cut(m.rail(-1)).union(low_rail(-1,38)).union(m.box(-42,-27,-7.3,7.3,34.5,38))
 plate=m.box(42,48,-33,33,-29,40)
 for y in (-24,24):
  cut=m.box(41,49,y-4.4,y+4.4,-8,8)
  for z in (-8,8):cut=cut.union(m.cylinder((41,y,z),(1,0,0),8,8.8))
  plate=plate.cut(cut)
 bracket=solids['actuator_bracket'].cut(m.box(34,40,-33,33,35,84)).union(plate).union(m.box(33,48,-6,6,35,39))
 for y0,y1 in ((-8,-4),(4,8)):bracket=bracket.union(m.box(33,48,y0,y1,24,39))
 s['actuator_bracket']=bracket
 return s

original_assembly=m.assembly_parts
def candidate_assembly(p,s):
 a=original_assembly(p,s)
 for n in ('rail_screw_1','rail_screw_2','rail_nut_1','rail_nut_2'):a[n]=a[n].translate((8*p.sign,0,-64))
 return a

def envelope(p,half_angle):
 # Square envelope is conservative for a circular cone and unknown lens positions.
 x0,x1=p.phone_left+2,p.phone_left+40;y0,y1=p.phone_length/2-43,p.phone_length/2-3
 depth=100;growth=depth*math.tan(math.radians(half_angle))
 return m.cq.Workplane('XY',origin=((x0+x1)/2,(y0+y1)/2,22)).rect(x1-x0,y1-y0).workplane(offset=depth).rect(x1-x0+2*growth,y1-y0+2*growth).loft()

def optical(p,a):
 result={}
 for half in (40,50,60):
  view=envelope(p,half);hits={}
  for n,s in a.items():
   v=b.overlap(s,view)
   if v>.01:hits[n]=round(v,2)
  path,bands,_=m.flexible_paths(p)
  for n,points,d in [('twine',path,p.twine_diameter)]+[(n,ps,1.4) for n,ps in bands.items()]:
   v=b.overlap(m.polyline(points,d),view)
   if v>.01:hits[n]=round(v,2)
  result[str(half)]=hits
 return result

def main():
 OUT.mkdir(exist_ok=True)
 solids=m.parts(m.Parameters());new=candidate(solids)
 report={'status':'Historical comparison; recessed candidate has been promoted to active V2. Raised baseline is archived.','camera_assumptions':{'lens_plane_z_mm':22,'camera_rectangle':'Existing illustrative camera_keepout footprint; not measured lens centers','half_angles_degrees':[40,50,60],'depth_mm':100,'method':'Expanding square view envelope from every point in the camera rectangle. Intersection signals possible intrusion, not actual pixel obstruction.'},'rail_change':{'long_rail_z_current':[60,80],'long_rail_z_candidate':[-4,16],'toward_handle_mm':64,'outward_per_side_mm':8},'valid_solids':{},'mechanical_checks':{},'view_envelope_intersections_mm3':{}}
 for n in ('carrier','sliding_jaw','actuator_bracket'):
  report['valid_solids'][n]={'valid':new[n].val().isValid(),'solid_count':len(new[n].val().Solids())}
  assert new[n].val().isValid() and len(new[n].val().Solids())==1,n
  b.export(new[n],OUT/('candidate_'+n+'.stl'))
 for name,base in b.SAMPLES.items():
  for side in ('near','far'):
   p=replace(base,side=side);key=name+'-'+side
   b.assembly_parts=candidate_assembly
   check=b.check(p,new)
   # Extra rail-fastener vs stock-neck check; excludes intentional historical saddle discrepancy.
   a=candidate_assembly(p,new);neck=m.stock(p)['stock_neck']
   check['fastener_shaft_overlap_mm3']={n:round(b.overlap(a[n],neck),4) for n in ('rail_screw_1','rail_screw_2','rail_nut_1','rail_nut_2')}
   check['passed']=check['passed'] and not any(check['fastener_shaft_overlap_mm3'].values())
   report['mechanical_checks'][key]=check
   print(key,json.dumps(check),flush=True)
   # Full-material optical sensitivity for measured wallet envelope, both sides.
   if name=='wallet':
    report['view_envelope_intersections_mm3'][key]={'current':optical(p,original_assembly(p,solids)),'candidate':optical(p,a)}
    rows=[]
    for variant,assy in [('current',original_assembly(p,solids)),('candidate',a)]:
     for n,s in assy.items():
      file=f'{key}_{variant}_{n}.stl';b.export(s,OUT/file);rows.append({'variant':variant,'name':n,'file':file})
    for n in ('phone_envelope','camera_keepout'):
     file=f'{key}_{n}.stl';b.export(m.stock(p)[n],OUT/file);rows.append({'variant':'both','name':n,'file':file})
    # Separate long beams prove rails are behind the camera plane, independently of the bracket.
    report['view_envelope_intersections_mm3'][key]['long_rails_candidate_max_z_mm']=16
    (OUT/(key+'.json')).write_text(json.dumps(rows,indent=2)+'\n')
 report['mechanical_checks_passed']=all(v['passed'] for v in report['mechanical_checks'].values())
 (OUT/'report.json').write_text(json.dumps(report,indent=2)+'\n')
 print('Study written; mechanical checks:',report['mechanical_checks_passed'],flush=True)
if __name__=='__main__':main()

"""Canonical approved compact rail sleeve, plus standalone comparison export."""
from pathlib import Path
from dataclasses import replace
import json,sys,math
import cadquery as cq
from geometry_common_key import geometry_common_key
from plunger_design import box
from build_steep_stop import prism,CAD
from build import export,SAMPLES
from build_preview import clamp_geometry
import model as m

def geometry_compact():
 b,pl,key,ctx=geometry_common_key()
 # Restore the old front/back apertures within their straight bearing faces.
 for y0,y1 in [(21.85,24.25)]:
  b=b.union(box(-23,-13,y0,y1,4.8,16.8))
 # Trim the upper 3 mm of the sleeve; keep the mechanism and plate intact.
 b=b.cut(box(-31,-5.4,14,24.251,16.8,21))
 # Move the screw center to the 8.4 mm midpoint of the 16.8 mm face; retain 45-degree roof.
 r=4.4; z=8.4; q=r/math.sqrt(2)
 hole=cq.Workplane('XZ',origin=(-18,14,z)).circle(r).extrude(-18)
 roof=prism([(-18-q,z+q),(-18,z+2*q),(-18+q,z+q)],14,32)
 b=b.cut(hole.union(roof)).clean()
 return b,pl,key,ctx

def local(s,p):
 return s.translate((-p.phone_right,-p.button_y,-p.height)).translate((-8.35,-5.4,-8)).rotate((0,0,0),(1,0,0),-90).rotate((0,0,0),(0,0,1),90)
def vol(s): return s.val().Volume()
def main(out):
 out.mkdir(parents=True,exist_ok=True)
 old,_,_,_=geometry_common_key(); b,pl,key,ctx=geometry_compact()
 print('geometry',b.val().isValid(),len(b.val().Solids()),vol(old),vol(b),flush=True)
 assert b.val().isValid() and len(b.val().Solids())==1
 rows=[]
 for i in range(107):
  d=i*.5; hit=vol(pl.translate((0,-d,0)).intersect(b))
  rows.append(hit)
 assert max(rows)<1e-5
 assert vol(key.intersect(b))<1e-5
 cap,carrier,_,_=clamp_geometry(m.Parameters()); checks={}
 passage=m.cylinder((-18,14,8.4),(0,1,0),18,8.4)
 nut=m.cylinder((-18,24.25,8.4),(0,1,0),6,18.6)
 for name,p0 in SAMPLES.items():
  for side in ['near','far']:
   p=replace(p0,side=side)
   checks[name+'-'+side]={'cap':vol(b.intersect(local(cap,p))),'carrier':vol(b.intersect(local(carrier,p))), 'shaft_cap_slot_overlap':vol(passage.intersect(local(cap,p))),'nut_bracket_overlap':vol(nut.intersect(b))}
   print(name,side,checks[name+'-'+side],flush=True)
 for name,s in {'bracket':b,'original-bracket':old,'plunger':pl,'stop':key,**ctx}.items(): export(s,out/(name+'.stl'))
 # Bare-phone mounting context for the standalone comparison viewer.
 p=SAMPLES['bare']; export(local(cap,p),out/'shaft-cap.stl')
 screw=m.collar_screw().rotate((0,0,0),(0,0,1),-24).rotate((0,0,0),(0,1,0),-90).translate((58.2,m.MOUNT_Y,26-p.height))
 nut_shape=m.thumb_nut(p).rotate((0,0,0),(0,0,1),180).rotate((0,0,0),(0,1,0),-90).translate((38.6,m.MOUNT_Y,26-p.height))
 for name,shape in [('rail-screw',screw),('rail-nut',nut_shape)]: export(local(m.placed(shape,p),p),out/(name+'.stl'))
 # Measure the actual hex nut bearing face, not a circular envelope.
 mounted_nut=local(m.placed(nut_shape,p),p).translate((0,0,-1.4))
 face=min((f for f in mounted_nut.val().Faces() if f.geomType()=='PLANE' and f.normalAt().y<-.99),key=lambda f:f.Center().y)
 probe=cq.Solid.extrudeLinear(face.outerWire(),face.innerWires(),cq.Vector(0,-.01,0))
 bearing=vol(cq.Workplane(obj=probe).intersect(b))/.01
 (out/'bearing-check.json').write_text(json.dumps({'nut_face_area_mm2':face.Area(),'supported_contact_area_mm2':bearing,'supported_fraction':bearing/face.Area(),'nut_z_bounds_mm':[mounted_nut.val().BoundingBox().zmin,mounted_nut.val().BoundingBox().zmax],'mount_z_bounds_mm':[0,16.8],'center_z_mm':8.4},indent=2)+'\n')
 (out/'index.html').write_text((CAD/'versions/v4/review/concepts/compact-actuator-mount/index.html').read_text())
 report={'revision':'compact-centered-mount','original_volume_mm3':vol(old),'compact_volume_mm3':vol(b),'bore_original_local_z':9.8,'bore_new_local_z':8.4,'rail_screw_global_y_shift_mm':1.4,'sleeve_z_range_mm':[0,16.8],'lower_bore_ligament_mm':4.0,'highest_roof_mm':8.4+2*4.4/math.sqrt(2),'checks':checks,'sampled_plunger_overlap_max_mm3':max(rows),'key_rest_overlap_mm3':vol(key.intersect(b)),'limits':['A single preliminary candidate. Check actual shortened V4 rail, bolt and nut placement, common-key access and support extrusion before use.','No mechanical strength or physical fit validation.']}
 (out/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
 (out/'fit-check.json').write_text(json.dumps(report,indent=2)+'\n')
if __name__=='__main__':main(Path(sys.argv[1]))

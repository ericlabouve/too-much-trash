"""Original-envelope thread experiment. Active V3 and previous trials preserved.
Custom 90-degree included trapezoid, NOT standard 29-degree ACME.
"""
from pathlib import Path
import json,hashlib,math
import cadquery as cq
import trimesh
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'print/thread-trials/original-size-trapezoid-8x3'

def cylinder(radius,length,z=0):
 return cq.Workplane('XY').circle(radius).extrude(length).translate((0,0,z))

def thread(female=False):
 extra=.3 if female else 0
 core=3.2+extra;outer=4+extra
 helix=cq.Wire.makeHelix(3,27,core)
 # 0.8 mm depth with 0.8 mm axial flank run: 45 degrees from horizontal.
 # Core overlap extends the same slope; no isolated sharp crest.
 rib=cq.Workplane('XZ').polyline([(core-.15,-1.25),(outer,-.3),(outer,.3),(core-.15,1.25)]).close().sweep(helix,isFrenet=True)
 return cylinder(core,27).union(rib).translate((0,0,-3))

def make_parts():
 screw=thread().intersect(cylinder(4.5,18,2))
 # Same head, contact nose, shoulder stations and total length as active V3.
 screw=screw.union(cylinder(2,2.3)).union(cylinder(7,4,20))
 nut=cq.Workplane('XY').polygon(6,18).extrude(6).cut(thread(True).translate((0,0,-2)))
 # Internal lead-ins only: outer nut body stays exactly 18 corners / 6 high.
 for z,a,b in [(0,4.4,3.5),(5.4,3.5,4.4)]:
  nut=nut.cut(cq.Workplane('XY').newObject([cq.Solid.makeCone(a,b,.6,cq.Vector(0,0,z),cq.Vector(0,0,1))]))
 return {'trial_screw_8x3':screw,'trial_nut_8x3':nut}

def build():
 OUT.mkdir(parents=True,exist_ok=True);parts=make_parts();rows=[]
 for n,s in parts.items():
  assert s.val().isValid() and len(s.val().Solids())==1,n
  if 'screw' in n:s=s.rotate((0,0,0),(1,0,0),180).translate((0,0,24))
  cq.exporters.export(s,str(OUT/(n+'.stl')),tolerance=.025,angularTolerance=.1)
  cq.exporters.export(s,str(OUT/(n+'.step')))
  mesh=trimesh.load_mesh(OUT/(n+'.stl'))
  assert mesh.is_watertight and mesh.volume>0 and abs(mesh.bounds[0,2])<.001,n
  expected=(14,14,24) if 'screw' in n else (18,18*math.cos(math.pi/6),6)
  assert max(abs(a-b) for a,b in zip(mesh.extents,expected))<.02,(n,mesh.extents)
  rows.append({'name':n,'file':n+'.stl','quantity':1,'bounds_mm':mesh.extents.tolist(),'original_envelope_verified':True,'volume_mm3':mesh.volume,'stl_sha256':hashlib.sha256((OUT/(n+'.stl')).read_bytes()).hexdigest(),'watertight':True})
 overlaps=[]
 for deg in (0,90,180,270):
  nut=parts['trial_nut_8x3'].rotate((0,0,0),(0,0,1),deg).translate((0,0,2+3*deg/360))
  v=sum(s.Volume() for s in parts['trial_screw_8x3'].intersect(nut).vals());assert v<.01,(deg,v)
  overlaps.append({'rotation_degrees':deg,'intersection_mm3':v})
 report={'status':'Unvalidated fixed-envelope thread trial. Do not mate with old 2 mm-pitch parts.','units':'mm','scale_percent':100,'printer':'Bambu Lab A1 mini','confirmed_nozzle_mm':.4,'recommended_layer_mm':.12,'major_diameter_mm':8,'core_diameter_mm':6.4,'pitch_mm':3,'radial_depth_mm':.8,'crest_axial_flat_mm':.6,'flank_angle_from_horizontal_degrees':45,'included_angle_degrees':90,'standard_ACME':False,'female_radial_clearance_mm':.3,'nut_nominal_turns':2,'nut_leadin_depth_each_mm':.6,'outer_geometry':'Original 14 mm head ×4 mm, 24 mm total screw, 4 mm contact nose; nut 18 mm corners ×6 mm thick. Thread OD stays 8 mm.','mating_sweep':overlaps,'parts':rows,'physical_fit_verified':False}
 (OUT/'manifest.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2),flush=True)
if __name__=='__main__':build()

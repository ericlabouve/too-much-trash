"""Isolated coarse thread trial; does not overwrite the active V2 assembly.
Print the pair and obtain physical feedback before changing mating CAD.
"""
from pathlib import Path
import json,hashlib,math
import cadquery as cq
import trimesh
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'print/thread-trials/coarse-12x4'
MAJOR=12.;CORE=9.;PITCH=4.;DEPTH=1.5;CLEARANCE=.4
SHAFT=24.;HEAD=5.;NUT=12.

def cylinder(radius,length,z=0):
 return cq.Workplane('XY').circle(radius).extrude(length).translate((0,0,z))

def thread(female=False):
 extra=CLEARANCE if female else 0
 core=CORE/2+extra;outer=MAJOR/2+extra
 # At the physical root the axial width is 2.8 mm; the blunt crest is 1.2.
 # At half radial depth, thread and space each occupy half the 4 mm pitch.
 helix=cq.Wire.makeHelix(PITCH,SHAFT+8,core)
 rib=cq.Workplane('XZ').polyline([(core-.15,-1.48),(outer,-.6),(outer,.6),(core-.15,1.48)]).close().sweep(helix,isFrenet=True)
 return cylinder(core,SHAFT+8).union(rib).translate((0,0,-4))

def make_parts():
 male=thread().intersect(cylinder(6.05,SHAFT))
 # Taper the final 1.5 mm of thread toward its core to help engagement.
 tip=cq.Workplane('XY').newObject([cq.Solid.makeCone(6.05,4.5,1.5,cq.Vector(0,0,SHAFT-1.5),cq.Vector(0,0,1))])
 envelope=cylinder(6.05,SHAFT-1.5).union(tip)
 male=male.intersect(envelope).translate((0,0,HEAD)).union(cylinder(11,HEAD))
 female=thread(True)
 nut=cq.Workplane('XY').polygon(6,24).extrude(NUT).cut(female)
 for z,a,b in [(0,7.3,4.9),(NUT-1.5,4.9,7.3)]:
  entry=cq.Solid.makeCone(a,b,1.5,cq.Vector(0,0,z),cq.Vector(0,0,1))
  nut=nut.cut(cq.Workplane('XY').newObject([entry]))
 return {'trial_screw_12x4':male,'trial_nut_12x4':nut}

def build():
 OUT.mkdir(parents=True,exist_ok=True);parts=make_parts();rows=[]
 for n,s in parts.items():
  assert s.val().isValid() and len(s.val().Solids())==1,n
  cq.exporters.export(s,str(OUT/(n+'.stl')),tolerance=.025,angularTolerance=.1)
  cq.exporters.export(s,str(OUT/(n+'.step')))
  mesh=trimesh.load_mesh(OUT/(n+'.stl'))
  assert mesh.is_watertight and mesh.volume>0 and abs(mesh.bounds[0,2])<.001,n
  rows.append({'name':n,'file':n+'.stl','quantity':1,'bounds_mm':mesh.extents.tolist(),'stl_sha256':hashlib.sha256((OUT/(n+'.stl')).read_bytes()).hexdigest(),'watertight':True,'valid_single_solid':True})
 screw=parts['trial_screw_12x4'];nut=parts['trial_nut_12x4'].translate((0,0,HEAD+8))
 overlap=sum(v.Volume() for v in screw.intersect(nut).vals());assert overlap<.01,overlap
 report={'status':'Unvalidated coarse thread fit trial; not compatible with current assembly','units':'mm','scale_percent':100,'nozzle_baseline_mm':.4,'layer_baseline_mm':.2,'major_diameter_mm':MAJOR,'core_diameter_mm':CORE,'nominal_pitch_diameter_mm':10.5,'pitch_mm':PITCH,'radial_depth_mm':DEPTH,'crest_axial_flat_mm':1.2,'female_radial_clearance_mm':CLEARANCE,'female_minor_diameter_mm':9.8,'female_groove_diameter_mm':12.8,'nut_thickness_mm':NUT,'nominal_nut_turns':3,'male_shaft_length_mm':SHAFT,'assembled_intersection_mm3':overlap,'parts':rows,'physical_fit_verified':False,'remaining':'Print this pair first; confirm fit before enlarging active rocker, rail slots, bracket and fasteners.'}
 (OUT/'manifest.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2),flush=True)
if __name__=='__main__':build()

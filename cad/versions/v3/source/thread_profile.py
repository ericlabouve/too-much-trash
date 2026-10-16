"""Physically successful 8x3 thread profile with V3's unused contact nose removed.
Thread and nut copied from build_fixed_envelope_thread_trial.py.
The isolated trial stays preserved as the independent comparison reference.
"""
import cadquery as cq

def cylinder(radius,length,z=0):
 return cq.Workplane('XY').circle(radius).extrude(length).translate((0,0,z))

def thread(female=False,length=27):
 extra=.3 if female else 0
 core=3.2+extra;outer=4+extra
 helix=cq.Wire.makeHelix(3,length,core)
 # 0.8 mm depth with 0.8 mm axial flank run: 45 degrees from horizontal.
 # Core overlap extends the same slope; no isolated sharp crest.
 rib=cq.Workplane('XZ').polyline([(core-.15,-1.25),(outer,-.3),(outer,.3),(core-.15,1.25)]).close().sweep(helix,isFrenet=True)
 return cylinder(core,length).union(rib).translate((0,0,-3))

def make_parts():
 screw=thread().intersect(cylinder(4.5,18,2))
 # Keep head and thread stations unchanged; the former rocker contact nose
 # at Z0..2 is unused by the rail clamp. Do not shift the mating thread phase.
 screw=screw.union(cylinder(7,4,20))
 nut=cq.Workplane('XY').polygon(6,18).extrude(6).cut(thread(True).translate((0,0,-2)))
 # Internal lead-ins only: outer nut body stays exactly 18 corners / 6 high.
 for z,a,b in [(0,4.4,3.5),(5.4,3.5,4.4)]:
  nut=nut.cut(cq.Workplane('XY').newObject([cq.Solid.makeCone(a,b,.6,cq.Vector(0,0,z),cq.Vector(0,0,1))]))
 return {'thumb_screw':screw,'thumb_nut':nut}

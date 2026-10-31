"""B/C guide studies retaining the exact existing curved foot. Not active V3."""
import json
from pathlib import Path
import cadquery as cq
from plunger_design import cassette,box
from build import export
ROOT=Path(__file__).resolve().parents[1];OUT=ROOT/'review/concepts/triangle-tail';OUT.mkdir(exist_ok=True)
old=cassette()['plunger'].translate((-8.35,-5.4,-8)).rotate((0,0,0),(1,0,0),-90).rotate((0,0,0),(0,0,1),90)
foot=old.intersect(box(-30,30,-12,2,-20,30))
def wire(poly,v):return cq.Wire.makePolygon([cq.Vector(u,v,w) for u,w in poly],close=True)
def prism(poly,v,length):return cq.Workplane('XY').newObject([cq.Solid.extrudeLinear(wire(poly,v),[],cq.Vector(0,length,0))])
def loft(profiles):return cq.Workplane('XY').newObject([cq.Solid.makeLoft([wire(p,v) for v,p in profiles],ruled=False)])
profiles={'b':[(-4,3.4),(4,3.4),(.8,6.6),(-.8,6.6)],'c':[(-4,5.4),(0,1.4),(4,5.4),(.8,8.6),(-.8,8.6)]}
report={'revision':'triangle-tail-clearance-v1','scope':'Guide cartridge and plunger studies only; mount, pulley, return anchor and removable end-stop integration deferred until selection.','variants':{}}
for name,profile in [('b',profiles['b'])]:
 # Match each polygon perimeter to points on the original rectangular neck.
 start=[(-4,3.4),(4,3.4),(4,7.4),(-4,7.4)] if name=='b' else [(-4,5.4),(0,3.4),(4,5.4),(4,7.4),(-4,7.4)]
 # Several eased stations provide a curved transition, not an abrupt shoulder.
 stations=[]
 for v,t in [(1.9,0),(4,.12),(7,.67),(10,1)]:
  stations.append((v,[(a+(c-a)*t,b+(d-b)*t) for (a,b),(c,d) in zip(start,profile)]))
 neck=prism(profile,9.99,39.01)
 slider=foot.union(loft(stations)).union(neck)
 h=6.4 if name=='b' else 8.4
 # Preserve the current shared cleat and its band/string seating geometry.
 cleat=old.intersect(box(-20,20,40,52,7.5,30))
 slider=slider.union(box(-2.5,2.5,44,48,6.4,7.5)).union(cleat).clean()
 floor,top=(1.4,8.5) if name=='b' else (-.6,10.5)
 inner=[(-4.4,3),(4.4,3),(1.1,6.7),(-1.1,6.7)] if name=='b' else [(-4.4,5.4),(0,1),(4.4,5.4),(1.1,8.7),(-1.1,8.7)]
 guide=box(-5.8,5.8,12,40,floor,top).cut(prism(inner,11,30)).cut(box(-1.2,1.2,11,41,6 if name=='b' else 8,20)).clean()
 for n,s in [('plunger',slider),('guide',guide)]:
  assert s.val().isValid() and len(s.val().Solids())==1,(name,n)
  export(s,OUT/f'{name}-{n}.stl');export(s,OUT/f'{name}-{n}.step')
 overlap={str(d):slider.translate((0,d,0)).intersect(guide).val().Volume() for d in [-1.5,0,1.5]}
 assert max(overlap.values())<1e-5,overlap
 kept=slider.intersect(box(-30,30,-12,1.8,-20,30));ref=old.intersect(box(-30,30,-12,1.8,-20,30))
 diff=kept.cut(ref).val().Volume()+ref.cut(kept).val().Volume()
 assert diff<1e-5,diff
 report['variants'][name]={'foot_symmetric_difference_mm3':diff,'sampled_stroke_intersections_mm3':overlap,'guide_length_mm':28,'guide_slot_mm':2.4,'plunger_volume_mm3':slider.val().Volume(),'guide_volume_mm3':guide.val().Volume(),'limits':['No end stop yet; can slide out longitudinally.','Sampled ±1.5 mm travel is geometric only, not a safe button stroke.','Support and physical sliding/strength require verification.']}
export(foot,OUT/'existing-foot.stl')
(OUT/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n');print(report)

# Complete existing return-band and attachment routing, adapted to 1 mm string.
import math
from plunger_design import compound,tube,return_path,attachment_path,PULLEY_U,GROOVE_W

def inv(s):return s.translate((-8.35,-5.4,-8)).rotate((0,0,0),(1,0,0),-90).rotate((0,0,0),(0,0,1),90)
def points_local(points):return [(8-z,x-8.35,5.4-y) for x,y,z in points]
old_parts=cassette();old_bracket=inv(old_parts['actuator_bracket'])
retained=old_bracket.cut(box(-9,9,2.4,50.5,3,25)).cut(box(-5.8,5.8,12,40,-1,30))
boss=old_bracket.intersect(cq.Workplane('XY').center(13.5,8).circle(6.2).extrude(30).translate((0,0,-5)))
bracket=retained.union(boss).union(guide).clean()
assert bracket.val().isValid() and len(bracket.val().Solids())==1
# Existing band route uses 1 mm thickness. Width still provisional at 3 mm;
# sweep three adjacent 1 mm tubes across the band-width direction.
def routes(d):
 bp=[(u,v,9.4 if abs(w-10.1)<.001 else w) for u,v,w in points_local(return_path(-d))]
 band=tube(bp,.5)
 band_envelope=compound([tube([(u,v,w+z) for u,v,w in bp],.5) for z in [-1,0,1]])
 ap=points_local(attachment_path(-d));string=tube(ap,.5)
 # Exact planar tangent at the 1 mm cord seating radius (linear V flanks).
 # Deep groove radius 6.8, half-width 0.2, flank slope 1.6/2.2.
 r=6.8+(.5*math.sqrt(1+(1.6/2.2)**2)-.2)/(1.6/2.2)
 a=ap[-1];ang=math.atan2(a[1]-8,a[0]-13.5)+math.acos(r/math.hypot(a[0]-13.5,a[1]-8))
 arc=[(13.5+r*math.cos(t),8+r*math.sin(t),GROOVE_W) for t in [ang+(1.5*math.pi-ang)*i/40 for i in range(41)]]
 lead=tube([a]+arc+[(13.5, -12,GROOVE_W)],.5)
 knot=cq.Workplane('XY').sphere(1.5).translate((-4.9,42.4+d,11.65))
 return band,band_envelope,string,lead,knot
export(bracket,OUT/'b-bracket.stl')
export(bracket,OUT/'b-bracket.step')
checks=[]
for i in range(7):
 d=-1.5+3*i/6
 band,be,string,lead,knot=routes(d)
 row={'travel_mm':d}
 for label,shape in [('plunger',slider.translate((0,d,0))),('band',be),('string',string),('knot',knot),('lead',lead)]:
  row[label+'_bracket_intersection_mm3']=shape.intersect(bracket).val().Volume()
 for label,shape in [('band',be),('string',string),('knot',knot),('lead',lead)]:
  row[label+'_plunger_intersection_mm3']=shape.intersect(slider.translate((0,d,0))).val().Volume()
 checks.append(row)
 print(row,flush=True)
band,be,string,lead,knot=routes(0)
for n,s in [('band-envelope',be),('return-band',band),('string-envelope',string),('knot-envelope',knot),('string-lead',lead),('b-bracket',bracket),('current-bracket',old_bracket),('current-plunger',old)]:export(s,OUT/(n+'.stl'))
for n in ['pulley','pulley_axle','pulley_key']:export(inv(old_parts[n]),OUT/(n+'.stl'))
export(bracket,OUT/'b-bracket.step')
report['scope']='Selected B with original shared cleat, mount, pulley bearing and rear return stop/anchor.'
report['wrap_check']={'band_thickness_mm':1,'band_width_provisional_mm':3,'string_diameter_mm':1,'knot_envelope_diameter_mm':3,'samples':checks,'limits':['Band width provisional; tube sweep approximates flat elastic band.','Pulley approach is nominal: tension, knot, wear and slack need physical testing.']}
(OUT/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
print(report['wrap_check'])

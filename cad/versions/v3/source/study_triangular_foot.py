"""B/C guide studies retaining the exact existing curved foot. Not active V3."""
import json
from pathlib import Path
import cadquery as cq
from plunger_design import cassette,box
from build import export
ROOT=Path(__file__).resolve().parents[1];OUT=ROOT/'review/concepts/triangular-foot';OUT.mkdir(exist_ok=True)
old=cassette()['plunger'].translate((-8.35,-5.4,-8)).rotate((0,0,0),(1,0,0),-90).rotate((0,0,0),(0,0,1),90)
foot=old.intersect(box(-30,30,-12,2,-20,30))
def wire(poly,v):return cq.Wire.makePolygon([cq.Vector(u,v,w) for u,w in poly],close=True)
def prism(poly,v,length):return cq.Workplane('XY').newObject([cq.Solid.extrudeLinear(wire(poly,v),[],cq.Vector(0,length,0))])
def loft(profiles):return cq.Workplane('XY').newObject([cq.Solid.makeLoft([wire(p,v) for v,p in profiles],ruled=False)])
profiles={'b':[(-4,3.4),(4,3.4),(.8,6.6),(-.8,6.6)],'c':[(-4,5.4),(0,1.4),(4,5.4),(.8,8.6),(-.8,8.6)]}
report={'revision':'curved-foot-triangle-diamond-study-v1','scope':'Guide cartridge and plunger studies only; mount, pulley, return anchor and removable end-stop integration deferred until selection.','variants':{}}
for name,profile in profiles.items():
 # Match each polygon perimeter to points on the original rectangular neck.
 start=[(-4,3.4),(4,3.4),(4,7.4),(-4,7.4)] if name=='b' else [(-4,5.4),(0,3.4),(4,5.4),(4,7.4),(-4,7.4)]
 # Several eased stations provide a curved transition, not an abrupt shoulder.
 stations=[]
 for v,t in [(1.9,0),(4,.12),(7,.67),(10,1)]:
  stations.append((v,[(a+(c-a)*t,b+(d-b)*t) for (a,b),(c,d) in zip(start,profile)]))
 neck=prism(profile,9.99,39.01)
 slider=foot.union(loft(stations)).union(neck)
 h=6.4 if name=='b' else 8.4
 web=cq.Workplane('YZ').polyline([(30,h),(46,h),(46,15),(42,15),(36,h+3.8),(30,h+.2)]).close().extrude(1.6).translate((-.8,0,0))
 cap=loft([(36,[(-.8,h+3.4),(.8,h+3.4),(.8,h+3.8),(-.8,h+3.8)]),(42,[(-4,13.4),(4,13.4),(4,15),(-4,15)]),(46,[(-4,13.4),(4,13.4),(4,15),(-4,15)])])
 slider=slider.union(web).union(cap).clean()
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

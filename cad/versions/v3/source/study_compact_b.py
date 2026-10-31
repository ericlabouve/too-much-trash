"""Compact B tail study. Foot placement remains unchanged pending neck-face clarification."""
import json,math,shutil
from pathlib import Path
import cadquery as cq
from plunger_design import box,return_path,attachment_path,GROOVE_W
from build import export
ROOT=Path(__file__).resolve().parents[1];src=ROOT/'review/concepts/triangle-tail-flat';out=ROOT/'review/concepts/compact-b';out.mkdir(exist_ok=True)
def prism(poly,v,length):
 w=cq.Wire.makePolygon([cq.Vector(u,v,z) for u,z in poly],close=True)
 return cq.Workplane('XY').newObject([cq.Solid.extrudeLinear(w,[],cq.Vector(0,length,0))])
base=cq.importers.importStep(str(src/'b-bracket.step'));old=cq.importers.importStep(str(src/'b-plunger.step'))
# Mount stays fixed. Keep its bearing bore and original side connection, trim tail.
mount=base.intersect(box(-40,-6.2,18,46,-1,30))
# 45-degree top relief clears the band beside the nut; keep the mount bearing plate.
relief=cq.Workplane('YZ').polyline([(30,11.6),(38.6,3),(47,3),(47,30),(30,30)]).close().extrude(40).translate((-40,0,0))
mount=mount.cut(relief)
pulley_base=base.intersect(box(6.2,30,-1,18,-1,30))
anchor=base.intersect(box(-11,11,58,67,0,12)).translate((0,-20,0))
stop=base.intersect(box(-4,4,51,54,2.9,7.5)).translate((0,-14,0))
inner=[(-4.965685,3),(4.965685,3),(1.1,6.865685),(-1.1,6.865685)]
guide=box(-6.2,6.2,12,32,0,8).cut(prism(inner,11,22)).cut(box(-1.2,1.2,11,33,6,20))
bracket=box(-9,9,2.5,46,0,3).union(mount).union(pulley_base).union(anchor).union(stop).union(guide).clean()
profile=[(-4,3.4),(4,3.4),(.8,6.6),(-.8,6.6)]
# Upper cleat moves 14 mm forward, 1 mm upward for clearance over the guide.
tail=old.intersect(box(-10,10,40,51,6.6,20)).translate((0,-14,1))
slider=old.intersect(box(-20,20,-12,10,-5,20)).union(prism(profile,9.99,25.01)).union(box(-.8,.8,30,34,6.4,7.7)).union(tail).clean()
for n,s in [('b-bracket',bracket),('b-plunger',slider)]:
 assert s.val().isValid() and len(s.val().Solids())==1,n
 for ext in ['stl','step']:export(s,out/(n+'.'+ext))
for n in ['pulley','pulley_axle','pulley_key','current-bracket','current-plunger']:shutil.copy2(src/(n+'.stl'),out/(n+'.stl'))
frames=[]
for i in range(21):
 d=-1.5+i*.15
 bp=[]
 for x,y,z in return_path(-d):
  u,v,w=8-z,x-8.35,5.4-y
  if abs(w-10.1)<.001:v-=14;w=10.4
  elif abs(w-7)<.001:v-=18.2
  else:v-=20
  bp.append((u,v,w))
 ap=[(8-z,x-8.35-14,5.4-y+1) for x,y,z in attachment_path(-d)]
 r=6.8+(.5*math.sqrt(1+(1.6/2.2)**2)-.2)/(1.6/2.2);a=ap[-1]
 ang=math.atan2(a[1]-8,a[0]-13.5)+math.acos(r/math.hypot(a[0]-13.5,a[1]-8))
 arc=[(13.5+r*math.cos(t),8+r*math.sin(t),GROOVE_W) for t in [ang+(1.5*math.pi-ang)*j/40 for j in range(41)]]
 frames.append({'travel':d,'band':bp,'attachment':ap,'lead':[a]+arc+[(13.5,-12,GROOVE_W)]})
(out/'motion-paths.json').write_text(json.dumps(frames))
report={'revision':'compact-b-tail-v1','scope':'Tail shortened; foot unchanged pending neck-face clarification. Review only.','dimensions':{'bracket_length_before_mm':66,'bracket_length_after_mm':46,'plunger_length_before_mm':58,'plunger_length_after_mm':44,'cleat_forward_shift_mm':14,'anchor_forward_shift_mm':20,'cleat_height_increase_mm':1,'mount_hole_position_changed':False,'foot_position_changed':False},'motion':[],'insertion':[]}
for d in [-1.5,0,1.5]:
 v=slider.translate((0,d,0)).intersect(bracket).val().Volume();report['motion'].append({'travel':d,'intersection_mm3':v});print('motion',d,v,flush=True)
for d in [-26,-20,-12,-6,0]:
 v=slider.translate((0,d,0)).intersect(bracket).val().Volume();report['insertion'].append({'travel':d,'intersection_mm3':v});print('insertion',d,v,flush=True)
(out/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
assert max(q['intersection_mm3'] for q in report['motion']+report['insertion'])<1e-5

# Exact nominal route envelopes against the compact bracket.
from plunger_design import tube,compound
report['route_checks']=[]
for i in [0,10,20]:
 f=frames[i];d=f['travel'];bp=f['band']
 band=compound([tube([(u,v,w+z) for u,v,w in bp],.5) for z in [-1,0,1]])
 shapes={'band':band,'string':tube(f['attachment'],.5),'lead':tube(f['lead'],.5),'knot':cq.Workplane('XY').sphere(1.5).translate((-4.9,28.4+d,12.65))}
 row={'travel_mm':d}
 for n,shape in shapes.items():
  row[n+'_bracket_mm3']=shape.intersect(bracket).val().Volume()
  row[n+'_plunger_mm3']=shape.intersect(slider.translate((0,d,0))).val().Volume()
 report['route_checks'].append(row);print(row,flush=True)
 if i==10:export(shapes['knot'],out/'knot-envelope.stl')
(out/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')

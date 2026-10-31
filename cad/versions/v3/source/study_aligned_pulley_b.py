"""Review-only parallel cord approach; retain approved rail sleeve and curved foot."""
import json,math,shutil
from pathlib import Path
from dataclasses import replace
import cadquery as cq
from build import export,SAMPLES
import model as m
from plunger_design import box,cyl,cassette,tube,compound
ROOT=Path(__file__).resolve().parents[1]
src=ROOT/'review/concepts/uniform-rail-sleeve-b';out=ROOT/'review/concepts/aligned-pulley-b';out.mkdir(exist_ok=True)
r=6.8+(.5*math.sqrt(1+(1.6/2.2)**2)-.2)/(1.6/2.2)
U=3.1+r;V=16.3;LIFT=2.05;W=12.65
delta=(U-13.5,V-18.85,LIFT)
b=cq.importers.importStep(str(src/'b-bracket.step'));old=b
p=cq.importers.importStep(str(src/'b-plunger.step'))
# Remove only old outboard pulley platform/boss; restore the shared flat spine.
b=b.cut(box(6.2,31,9.849,28.851,-1,31)).union(box(6.2,9,13.35,28.851,0,3))
# A new bed-backed pad and taller cylindrical bearing support the unchanged wheel.
pad=box(U-7.5,U+7.5,V-7.5,V+7.5,0,3).edges('|Z').fillet(1)
b=b.union(pad).union(cyl(U,V,2.6,8.2+LIFT-2.6,6).edges().fillet(.25))
b=b.cut(cyl(U,V,-10,35,4.3)).clean()
# Shave just the +u cap overhang above the wrap neck, leaving the neck intact.
p=p.cut(box(2.5,20,24,36,13.1,20)).clean()
for n,s in [('b-bracket',b),('b-plunger',p)]:
 assert s.val().isValid() and len(s.val().Solids())==1,n
 for ext in ['stl','step']:export(s,out/(n+'.'+ext))
for name in ['shaft-cap.stl','rail-screw.stl','rail-nut.stl','anti-rotation-cheeks.stl','knot-envelope.stl']:
 shutil.copy2(src/name,out/name)
def inv(s):return s.translate((-8.35,-5.4,-8)).rotate((0,0,0),(1,0,0),-90).rotate((0,0,0),(0,0,1),90)
h={n:inv(s).translate((0,10.85,0)).translate(delta) for n,s in cassette().items() if n in ['pulley','pulley_axle','pulley_key']}
# Keep the tested diamond opening and key at their original height; extend only
# the smooth shaft below the raised wheel/head by LIFT.
ax=inv(cassette()['pulley_axle']).translate((U-13.5,10.85+V-18.85,0))
h['pulley_axle']=ax.intersect(box(-30,40,-10,60,-20,3)).union(ax.intersect(box(-30,40,-10,60,3,30)).translate((0,0,LIFT))).union(cyl(U,V,2.9,LIFT+.2,4)).clean()
h['pulley_key']=h['pulley_key'].translate((0,0,-LIFT))
for n,s in h.items():
 assert s.val().isValid() and len(s.val().Solids())==1,n
 export(s,out/(n+'.stl'))
 if n=='pulley_axle':export(s,out/(n+'.step'))
frames=json.loads((src/'motion-paths.json').read_text())
for f in frames:
 d=f['travel'];a=(3.1,27.9+d,W)
 arc=[(U+r*math.cos(math.pi+j*math.pi/80),V+r*math.sin(math.pi+j*math.pi/80),W) for j in range(41)]
 f['lead']=[a]+arc+[(U,-1.15,W)]
(out/'motion-paths.json').write_text(json.dumps(frames))
report={'revision':'aligned-pulley-b-v2','scope':'Review only. Curved foot, rail sleeve, wheel and key shapes unchanged. Smooth axle shaft extended2.05 mm; diamond opening unchanged.','pulley_shift_uvw_mm':delta,'pulley_center_uvw_mm':[U,V,W],'incoming_cord_angle_to_travel_degrees':0,'cord_offset_from_shaft_center_mm':3.1,'axle_shaft_extension_mm':LIFT,'handle_cap_trim_mm':2,'guide_length_mm':20.15,'rigid_motion':[],'route_checks':[],'assembly_context':{},'limits':['Parallel cord approach is offset3.1 mm from the shaft centerline, so a small eccentric moment remains.','Nominal cord/rubber-band envelopes do not establish tension, friction or printed performance.','Actual full-squeeze stroke remains unknown; 6 mm rigid sweep is not a qualified operating limit.','No print or active V3 promotion.']}
for d in [0,-.75,-1.5,-3,-4.5,-6]:
 pp=p.translate((0,d,0));row={'travel_mm':d,'bracket':b.intersect(pp).val().Volume()}
 for n,s in h.items():row[n]=s.intersect(pp).val().Volume()
 report['rigid_motion'].append(row);print('motion',row,flush=True)
 assert max(v for k,v in row.items() if k!='travel_mm')<1e-5
report['hardware_bracket']={n:s.intersect(b).val().Volume() for n,s in h.items()}
print('hardware',report['hardware_bracket'],flush=True)
assert max(report['hardware_bracket'].values())<1e-5
for i in [0,10,20]:
 f=frames[i];d=f['travel'];bp=f['band'];pp=p.translate((0,d,0))
 band=compound([tube([(u,v,w+z) for u,v,w in bp],.5) for z in [-1,0,1]])
 shapes={'band':band,'attachment':tube(f['attachment'],.5),'lead':tube(f['lead'],.5),'knot':cq.Workplane('XY').sphere(1.5).translate((-4.9,27.4+d,12.65))}
 row={'travel_mm':d}
 for n,s in shapes.items():
  row[n+'_bracket_mm3']=s.intersect(b).val().Volume();row[n+'_plunger_mm3']=s.intersect(pp).val().Volume()
  if n=='lead':row['lead_axle_mm3']=s.intersect(h['pulley_axle']).val().Volume()
 report['route_checks'].append(row);print('routes',row,flush=True)
 assert max(v for k,v in row.items() if k!='travel_mm')<1e-5
# Check changed bearing and translated hardware against the unchanged cap/jaw.
def local(s,pa):return inv(s.translate((-pa.phone_right,-pa.button_y,-pa.height)))
cap=m.shaft_cap(m.Parameters());jaw=m.carrier(m.Parameters())
for name,pa0 in SAMPLES.items():
 for side in ['near','far']:
  pa=replace(pa0,side=side);row={}
  for label,s in [('cap',cap),('jaw',jaw)]:
   context=local(s,pa)
   row[label+'_bracket_mm3']=b.intersect(context).val().Volume()
   for n,q in h.items():row[label+'_'+n+'_mm3']=q.intersect(context).val().Volume()
  report['assembly_context'][name+'-'+side]=row;print(name,side,row,flush=True)
  assert max(row.values())<1e-5
(out/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
print('done',flush=True)

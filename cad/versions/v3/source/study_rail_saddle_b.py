"""Single-bolt anti-rotation cheeks engaging the unchanged cap rail edges."""
import json,shutil
from dataclasses import replace
from pathlib import Path
import cadquery as cq
from build import export,SAMPLES
import model as m
from plunger_design import box
ROOT=Path(__file__).resolve().parents[1];src=ROOT/'review/concepts/forward-handle-b';out=ROOT/'review/concepts/rail-saddle-b';out.mkdir(exist_ok=True)
b=cq.importers.importStep(str(src/'b-bracket.step'))
old_b=b
# Existing study floor overlapped the cap rail by1 mm here; clear it for seating.
b=b.cut(box(-40,-7.8,-50,21.85,-1,3.01)).clean()
# Existing rail Z16..36 -> concept u-28..-8; 0.2 mm clearance per side.
# Reach2.5 mm into rail thickness; all cheeks grow from the original w0 bed plane.
cheeks=box(-30,-28.2,19.35,23.05,0,19.8).union(box(-7.8,-6,19.35,23.05,0,19.8))
cheeks=cheeks.union(box(-30,-25.8,21.85,23.05,0,19.8)).union(box(-10.2,-6,21.85,23.05,0,19.8))
new=b.union(cheeks).clean();assert new.val().isValid() and len(new.val().Solids())==1
for ext in ['stl','step']:export(new,out/('b-bracket.'+ext))
export(cheeks,out/'anti-rotation-cheeks.stl')
for p in src.iterdir():
 if p.suffix in ['.stl','.step','.json'] and p.name not in ['b-bracket.stl','b-bracket.step','slice-evidence.json']:
  shutil.copy2(p,out/p.name)
def local(s,p):
 return s.translate((-p.phone_right,-p.button_y,-p.height)).translate((-8.35,-5.4,-8)).rotate((0,0,0),(1,0,0),-90).rotate((0,0,0),(0,0,1),90)
cap=m.shaft_cap(m.Parameters());carrier=m.carrier(m.Parameters())
report={'revision':'rail-saddle-b-v1','single_existing_bolt':True,'cap_changed':False,'cheek_engagement_mm':2.5,'rail_width_mm':20,'cheek_inner_width_mm':20.4,'clearance_per_side_mm':.2,'added_volume_mm3':new.val().Volume()-old_b.val().Volume(),'existing_floor_relief_mm':1.2,'positions':{},'rotation_checks':[],'limits':['Positive edge restraint reduces rotation; 0.2 mm side clearance permits small angular play before edge contact.','Single bolt still supplies clamp preload and longitudinal sliding resistance.','Printed fit, TPU fastener preload, edge strength and loaded twist remain untested.','No full-squeeze stroke qualification or active V3 promotion.']}
for name,p0 in SAMPLES.items():
 for side in ['near','far']:
  p=replace(p0,side=side);rail=local(cap,p);jaw=local(carrier,p)
  row={'bracket_cap_mm3':new.intersect(rail).val().Volume(),'added_cheek_fixed_jaw_mm3':cheeks.intersect(jaw).val().Volume()}
  report['positions'][name+'-'+side]=row;print(name,side,row,flush=True)
  assert max(row.values())<1e-5
  if name=='bare':
   for angle in [-3,3]:
    turn=cheeks.rotate((-18,0,9.8),(-18,1,9.8),angle)
    hit=turn.intersect(rail).val().Volume();report['rotation_checks'].append({'side':side,'angle_deg':angle,'cheek_rail_intersection_mm3':hit});print('rotation',side,angle,hit,flush=True);assert hit>0
p=SAMPLES['bare'];rail=local(cap,p)
# Show the actual cap, existing screw/nut, and mating plane in concept coordinates.
export(rail,out/'shaft-cap.stl')
screw=m.collar_screw().rotate((0,0,0),(0,0,1),-24).rotate((0,0,0),(0,1,0),-90).translate((58.2,m.MOUNT_Y,26))
nut=m.thumb_nut(p).rotate((0,0,0),(0,1,0),-90).translate((44,m.MOUNT_Y,26))
for name,s in [('rail-screw',screw),('rail-nut',nut)]:
 q=local(m.placed(s,p),p);export(q,out/(name+'.stl'))
 # Boolean overlap with printed threads may be expensive; cheeks have no change at bore/nut face.
 assert cheeks.intersect(q).val().Volume()<1e-5,name
# Rigid outward service path clears cap; cheeks disengage after 2.5 mm pull.
report['outward_removal']=[{'distance_mm':d,'cap_overlap_mm3':new.translate((0,d,0)).intersect(rail).val().Volume()} for d in [0,1,2.6,5]]
assert max(r['cap_overlap_mm3'] for r in report['outward_removal'])<1e-5
(out/'mount-check.json').write_text(json.dumps(report,indent=2)+'\n')
print('complete',flush=True)

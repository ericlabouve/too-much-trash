"""Single-bolt anti-rotation cheeks engaging the unchanged cap rail edges."""
import json,shutil
from dataclasses import replace
from pathlib import Path
import cadquery as cq
from build import export,SAMPLES
import model as m
from plunger_design import box
ROOT=Path(__file__).resolve().parents[1];src=ROOT/'review/concepts/forward-handle-b';out=ROOT/'review/concepts/closed-rail-sleeve-b';out.mkdir(exist_ok=True)
b=cq.importers.importStep(str(src/'b-bracket.step'))
old_b=b
# Existing study floor overlapped the cap rail by1 mm here; clear it for seating.
b=b.cut(box(-40,-7.8,-50,21.85,-1,3.01)).clean()
# Existing rail Z16..36 -> concept u-28..-8; 0.2 mm clearance per side.
# Longer 19.8 mm bearing, 4.2 mm rail-edge engagement plus retaining lips, and 2.4 mm side walls.
# Kept 0.2 mm per-side fit clearance; all added material reaches w=0 bed.
cheeks=box(-30.6,-28.2,15.65,23.65,0,19.8).union(box(-7.8,-5.4,15.65,23.65,0,19.8))
cheeks=cheeks.union(box(-30.6,-25.8,21.85,23.65,0,19.8)).union(box(-10.2,-5.4,21.85,23.65,0,19.8)).clean()
# Back lips overlap each rail edge2 mm, with0.25 mm back-face clearance.
cheeks=cheeks.union(box(-30.6,-26,15.65,17.4,0,19.8)).union(box(-10,-5.4,15.65,17.4,0,19.8)).clean()
# Continuous back wall, drilled coaxially with the existing mounting hole.
# Its circular lower section keeps8.8 mm screw clearance; tangent45deg roof.
cheeks=cheeks.union(box(-30.6,-5.4,15.65,17.4,0,19.8)).clean()
import math
def prism(poly,v,length):
 wire=cq.Wire.makePolygon([cq.Vector(u,v,w) for u,w in poly],close=True)
 return cq.Workplane('XY').newObject([cq.Solid.extrudeLinear(wire,[],cq.Vector(0,length,0))])
bore=cq.Workplane('XZ',origin=(-18,14,9.8)).circle(4.4).extrude(-5)
r=4.4/math.sqrt(2)
roof=prism([(-18-r,9.8+r),(-18,9.8+2*r),(-18+r,9.8+r)],14,5)
cheeks=cheeks.cut(bore.union(roof)).clean()
# Round exposed longitudinal corners, keeping the inner rail-contact planes flat.
verts=[]
for e in cheeks.edges('|Z').vals():
 c=e.Center()
 if abs(c.x+30.6)<.01 or abs(c.x+5.4)<.01:
  verts.append(e)
cheeks=cheeks.newObject(verts).fillet(.7).clean()
# Top-only bevel removes material; no new underside overhang.
cheeks=cheeks.faces('>Z').edges().chamfer(.5).clean()
new=b.union(cheeks).clean()
# Constant-section concave root rounds, built explicitly to avoid filleting
# across the existing small base steps. Flat on the same bed plane.
for left in [True,False]:
 x0,x1=(-27,-26.2) if left else (-9.8,-9)
 cx=x1 if left else x0
 web=box(x0,x1,23.65,24.45,0,18.6)
 cutter=cq.Workplane('XY').center(cx,24.45).circle(.8).extrude(20)
 web=web.cut(cutter).clean()
 new=new.union(web).clean()
cheeks=new.cut(b).clean()
assert new.val().isValid() and len(new.val().Solids())==1
for ext in ['stl','step']:export(new,out/('b-bracket.'+ext))
export(cheeks,out/'anti-rotation-cheeks.stl')
for p in src.iterdir():
 if p.suffix in ['.stl','.step','.json'] and p.name not in ['b-bracket.stl','b-bracket.step','slice-evidence.json']:
  shutil.copy2(p,out/p.name)
def local(s,p):
 return s.translate((-p.phone_right,-p.button_y,-p.height)).translate((-8.35,-5.4,-8)).rotate((0,0,0),(1,0,0),-90).rotate((0,0,0),(0,0,1),90)
cap=m.shaft_cap(m.Parameters());carrier=m.carrier(m.Parameters())
report={'revision':'closed-rail-sleeve-b-v1','single_existing_bolt':True,'cap_changed':False,'cheek_engagement_mm':4.2,'rear_clearance_mm':.25,'closed_back_wall':True,'rear_bore_diameter_mm':8.8,'rear_bore_roof_deg':45,'screw_head_shift_mm':-2,'lip_thickness_mm':1.75,'bearing_length_mm':19.8,'wall_thickness_mm':2.4,'outer_corner_radius_mm':.7,'top_chamfer_mm':.5,'root_blend_radius_mm':.8,'rail_width_mm':20,'cheek_inner_width_mm':20.4,'clearance_per_side_mm':.2,'added_volume_mm3':new.val().Volume()-old_b.val().Volume(),'existing_floor_relief_mm':1.2,'positions':{},'rotation_checks':[],'limits':['Positive edge restraint reduces rotation; 0.2 mm side clearance permits small angular play before edge contact.','Single bolt still supplies clamp preload and longitudinal sliding resistance.','Printed fit, TPU fastener preload, edge strength and loaded twist remain untested.','No full-squeeze stroke qualification or active V3 promotion.']}
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
 q=local(m.placed(s,p),p)
 if name=='rail-screw':q=q.translate((0,-2,0))
 export(q,out/(name+'.stl'))
 # Boolean overlap with printed threads may be expensive; cheeks have no change at bore/nut face.
 assert cheeks.intersect(q).val().Volume()<1e-5,name
 if name=='rail-screw':
  bb=q.val().BoundingBox();report['screw_tip_v_mm']=bb.ymax
  report['nut_full_engagement_mm']=6
  assert bb.ymax>35.65
# Captured mounting must slide on/off a free rail end before bolt installation.
report['axial_assembly']=[]
for name,p0 in SAMPLES.items():
 for side in ['near','far']:
  pa=replace(p0,side=side);rail=local(cap,pa);jaw=local(carrier,pa)
  edge=5.4+pa.button_y-(60 if side=='near' else -60)
  start=edge-19.8-.5 if side=='near' else edge+.5
  rows=[]
  import numpy as np
  for d in np.linspace(start,0,25):
   pose=new.translate((0,0,float(d)))
   rc=pose.intersect(rail).val().Volume()
   # Check complete moving bracket against fixed jaw throughout insertion.
   jc=pose.intersect(jaw).val().Volume()
   rows.append({'shift_mm':float(d),'cap_overlap_mm3':rc,'jaw_overlap_mm3':jc})
  print('assembly',name,side,max(r['cap_overlap_mm3'] for r in rows),max(r['jaw_overlap_mm3'] for r in rows),flush=True)
  report['axial_assembly'].append({'sample':name+'-'+side,'start_offset_mm':start,'samples':rows})
  assert max(max(r['cap_overlap_mm3'],r['jaw_overlap_mm3']) for r in rows)<1e-5
# Demonstrate the lips obstruct straight pull-off after0.25 mm clearance.
rail=local(cap,SAMPLES['bare'])
report['outward_capture']=[{'distance_mm':d,'cap_overlap_mm3':new.translate((0,d,0)).intersect(rail).val().Volume()} for d in [0,.2,.5,1]]
assert report['outward_capture'][1]['cap_overlap_mm3']<1e-5
assert report['outward_capture'][-1]['cap_overlap_mm3']>1
report['limits'].append('Rigid wraparound lips require end-on sliding installation/removal; do not flex or snap PETG over the rail.')
(out/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
(out/'mount-check.json').write_text(json.dumps(report,indent=2)+'\n')
print('complete',flush=True)

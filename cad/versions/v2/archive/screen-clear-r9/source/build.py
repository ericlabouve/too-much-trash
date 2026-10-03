"""Build V2 only: reusable print set plus both-side assembly configurations."""
from dataclasses import asdict, replace
from pathlib import Path
from itertools import combinations
import json, math
import cadquery as cq
import trimesh
from model import *
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'review'
BOM=[
 dict(id=n,name=label,quantity=q,material='PLA / PLA+',note=note)
 for n,label,q,note in [
 ('shaft_cap','Rigid shaft clamp cap',1,'Closes the extended carrier collar with two printed screws and nuts; no shaft-retaining bands. Fit and loaded retention unvalidated.'),
 ('carrier','Fixed jaw, sliding track and shaft saddle',1,'Hard rear datum and near-side slotted actuator rail; two rear bands pull the sliding jaw inward.'),
 ('sliding_jaw','Sliding opposing jaw',1,'Far-side actuator rail moves with this jaw. Same print set for 66–86 mm width; range is geometric, not qualified.'),
 ('actuator_bracket','Reversible actuator bracket',1,'Either rail; slide along the phone and adjust depth in the two vertical slots before tightening printed nuts.'),
 ('rocker','Threaded-contact rocker',1,'Tie the twine directly around the 8 mm eye with a closed loop. Contact screw adjusts button gap; printed stops limit the illustrative stroke.'),
 ('pivot_key','Quarter-turn pivot key',1,'Printed 6 mm pivot; insert cross-lug through keyway, turn and seat head at index lug.'),
 ('thumb_screw','Coarse printed thumb screw',5,'Two shaft clamps, two rail clamps plus one button contact. 8 mm major / 3 mm pitch; matches successful original-size trial. Existing trial screws can be reused.'),
 ('thumb_nut','Printed clamp nut',4,'Matches successful 8×3 trial nut, including entry lead-ins. Hand-tighten only; loaded retention remains untested.'),
 ('string_guide','Captive shaft guide',3,'Band-held open saddle with reinforced D-shaped lug; 8 mm bore, 11 mm flared mouths. Smooth the twine-contact surfaces.')]]
BOM += [dict(id='twine',name='One continuous twine length',quantity=1,material='Twine',note='Route behind the phone through closed eyes; leave enough for knots. Display diameter 2 mm is provisional; passage check uses 3 mm, actual twine unknown.'),dict(id='rubber_bands',name='Rubber bands',quantity=7,material='Rubber',note='2 jaw closing + 3 guides + 1 return + 1 trigger overtravel. Actual preload and loop count need fitting.')]
SAMPLES={'wallet':Parameters(),'bare':Parameters(phone_thickness=8,button_from_screen=4),'small':Parameters(phone_width=66,phone_length=140,phone_thickness=7.5,button_from_end=99,button_from_screen=3.5),'large':Parameters(phone_width=86,phone_length=170,phone_thickness=20,button_from_end=150,button_from_screen=6)}

def overlap(a,b):return sum(s.Volume() for s in a.intersect(b).vals())
def save(path,data):path.write_text(json.dumps(data,indent=2)+'\n')
def export(s,path,manufacturing=False):
 from OCP.BRepTools import BRepTools
 BRepTools.Clean_s(s.val().wrapped)
 cq.exporters.export(s,str(path),tolerance=(.025 if path.stem in ('thumb_screw','thumb_nut') else .06) if manufacturing else .16,angularTolerance=(.1 if path.stem in ('thumb_screw','thumb_nut') else .12) if manufacturing else .25)

def check(p,solids):
 a=assembly_parts(p,solids);st=stock(p)
 r={'phone_overlap':{},'camera_overlap':{},'rigid_overlap':{},'sweep':[]}
 for n,s in a.items():
  for k,target in [('phone_overlap','phone_envelope'),('camera_overlap','camera_keepout')]:
   v=overlap(s,st[target])
   if v>.01:r[k][n]=round(v,4)
 for n,m in combinations(a,2):
  v=overlap(a[n],a[m])
  if v>.01:r['rigid_overlap'][n+'/'+m]=round(v,4)
 for i in range(11):
  ang=math.degrees(stop_angle(p))*i/10
  for n in ('rocker','contact_screw'):
   moving=a[n].rotate(p.pivot,(p.pivot[0],p.pivot[1]+1,p.pivot[2]),ang)
   for other in ('carrier','shaft_cap','clamp_screw_1','clamp_screw_2','clamp_nut_1','clamp_nut_2','sliding_jaw','actuator_bracket','pivot_key'):
    v=overlap(moving,a[other])
    if v>.01:r['sweep'].append([i/10,n,other,round(v,4)])
 r['pivot_turn']=[]
 for deg in range(0,91,15):
  pin=a['pivot_key'].translate((0,p.sign*3.4,0)).rotate(p.pivot,(p.pivot[0],p.pivot[1]+1,p.pivot[2]),deg)
  # Assemble the pivot on the loose bracket, then mount the completed module.
  for other in ('actuator_bracket',):
   v=overlap(pin,a[other])
   if v>.01:r['pivot_turn'].append([deg,other,round(v,4)])
 r['fastener_shaft_overlap_mm3']={}
 for n in ('rail_screw_1','rail_screw_2','rail_nut_1','rail_nut_2','clamp_screw_1','clamp_screw_2','clamp_nut_1','clamp_nut_2'):
  v=overlap(a[n],st['stock_neck'])
  if v>.01:r['fastener_shaft_overlap_mm3'][n]=round(v,4)
 # Orthographic screen-facing keepout includes the full phone face and the
 # space in front of it. Check added clamp parts, not intentional phone jaws.
 screen=box(p.phone_left,p.phone_right,-p.phone_length/2,p.phone_length/2,-180,18-p.phone_thickness)
 r['clamp_screen_obstruction_mm3']={}
 for n in ('shaft_cap','clamp_screw_1','clamp_screw_2','clamp_nut_1','clamp_nut_2'):
  v=overlap(a[n],screen)
  if v>.01:r['clamp_screen_obstruction_mm3'][n]=round(v,4)
 r['passed']=not any(r.values())
 return r

def export_scene(p,solids,out):
 out.mkdir(parents=True,exist_ok=True)
 manifest={'version':'v2','title':'Recessed adjustable band clamp','revision':'screen-clear-r9','status':'Recessed fit prototype; camera-view clearance and physical validation pending','parameters':asdict(p),'bom':BOM,'printed_designs':9,'printed_pieces':18,'purchased_hardware':0,'soft_padding':False,'parts':[],'assembly':[]}
 for n,s in solids.items():
  file=n+'.stl'
  if out==OUT:export(s,out/file)
  else:
   (out/file).unlink(missing_ok=True);file='../'+file
  manifest['parts'].append({'name':n,'file':file,'quantity':next(r['quantity'] for r in BOM if r['id']==n)})
 assy=cq.Assembly(name='V2_adjustable')
 for name,s,col,bid in rows(p,solids):
  file='assembly_'+name+'.stl'
  shared=name=='carrier' or name.startswith(('stock_','guide_','band_guide_','band_collar_'))
  if out!=OUT and shared:
   (out/file).unlink(missing_ok=True);file='../'+file
  else:export(s,out/file)
  manifest['assembly'].append(dict(name=name,file=file,color=col,bom_id=bid))
  if name not in ('actuator_context','stock_neck_context','twine_phone'):assy.add(s,name=name,color=cq.Color(*col))
 if out==OUT:assy.export(str(out/'assembly.step'))
 path,bands,motion=flexible_paths(p);angle=stop_angle(p)
 takeup=math.dist(p.string_eye,p.first_guide)-math.dist(rotate_point(p.string_eye,p,angle),p.first_guide)
 manifest['motion']={**motion,'pivot':p.pivot,'angle':angle,'string_eye':p.string_eye,'string_points':path,'band_paths':bands,'twine_to_stop':takeup,'return_fixed':p.point((38,14,28)),'return_moving':p.point((33,8,18)),'contact':p.contact,'side_sign':p.sign,'phone_point_count':10}
 save(out/'manifest.json',manifest)

def manufacturing(solids):
 out=ROOT/'print';out.mkdir(exist_ok=True)
 rotations={'shaft_cap':('Y',-90),'carrier':('Y',90),'sliding_jaw':('Y',-90),'actuator_bracket':('Y',90),'rocker':('Y',-90),'pivot_key':('X',90),'thumb_screw':('X',180),'thumb_nut':('X',0),'string_guide':('X',0)}
 notes={'shaft_cap':'Split face on bed; support removable inner roof and inspect bore/ear holes. New clamp fit is unvalidated.','carrier':'Outer rail face on bed. Supports required under rear bridge, collar, track roofs and jaw ledges. Keep slider channel support accessible from open left end; remove fully.', 'sliding_jaw':'Outer rail face toward bed. Supports required under tongue, rear ledge and hooks. Protect sliding faces when removing support.', 'actuator_bracket':'Broad outside plate toward bed. Support first fairlead, pivot ears and return hooks; remove through open sides.', 'rocker':'Contact bore vertical. Support offset arm and pivot boss; keep supports out of threaded bore.', 'pivot_key':'Large head toward bed; support cross-lug. Check layer adhesion and quarter-turn retention.', 'thumb_screw':'Head on bed; no support in threads. Fit trial first; do not force.', 'thumb_nut':'Flat on bed; no supports. Fit trial first.', 'string_guide':'Saddle end on bed; support eye underside/bridge if slicer requests.'}
 result=[]
 for n,s in solids.items():
  axis,deg=rotations[n];v=(1,0,0) if axis=='X' else (0,1,0)
  t=s.rotate((0,0,0),v,deg);b=t.val().BoundingBox();t=t.translate((-(b.xmin+b.xmax)/2,-(b.ymin+b.ymax)/2,-b.zmin))
  export(t,out/(n+'.stl'),manufacturing=True);cq.exporters.export(t,str(out/(n+'.step')))
  mesh=trimesh.load_mesh(out/(n+'.stl'))
  # Circular analytic bounds can extend a few microns below tessellated vertices.
  if abs(mesh.bounds[0,2])>1e-6:
   t=t.translate((0,0,-float(mesh.bounds[0,2])))
   export(t,out/(n+'.stl'),manufacturing=True);cq.exporters.export(t,str(out/(n+'.step')))
   mesh=trimesh.load_mesh(out/(n+'.stl'))
  assert mesh.is_watertight and mesh.volume>0 and abs(mesh.bounds[0,2])<.001,n
  result.append(dict(name=n,file=n+'.stl',quantity=next(r['quantity'] for r in BOM if r['id']==n),bounds_mm=mesh.extents.round(3).tolist(),bed_z_min_mm=float(mesh.bounds[0,2]),watertight=True,layer_mm=.12 if n in ('thumb_screw','thumb_nut','rocker') else .2,supports=notes[n]))
 save(out/'manifest.json',dict(units='mm',scale_percent=100,nozzle_mm=.4,layer_mm=.2,revision='screen-clear-r9',status='Recessed fit prototype; camera-view clearance and physical validation pending',parts=result))

def build():
 p=Parameters();solids=parts(p);OUT.mkdir(exist_ok=True)
 report={'solids':{},'configurations':{},'excluded':['Historical stock shaft overlaps accepted smaller collar opening','Intentional nominal button travel','Band force, twine friction/stretch, retention, real phone tolerances and physical rocker-to-screw fit; isolated screw/nut success does not validate the loaded assembly']}
 for n,s in solids.items():
  report['solids'][n]={'valid':s.val().isValid(),'solid_count':len(s.val().Solids())}
  assert s.val().isValid() and len(s.val().Solids())==1,(n,report['solids'][n])
 print('Solids valid',flush=True)
 for name,base in SAMPLES.items():
  for side in ('near','far'):
   p=replace(base,side=side);key=name+'-'+side
   report['configurations'][key]=check(p,solids)
   print(key,json.dumps(report['configurations'][key]),flush=True)
   export_scene(p,solids,OUT if key=='wallet-near' else OUT/key)
 report['checks_passed']=all(x['passed'] for x in report['configurations'].values())
 save(OUT/'validation.json',report)
 if not report['checks_passed']:raise SystemExit('Interferences: see review/validation.json')
 manufacturing(solids)
 lines=['# V2 adjustable-clamp BOM','','Generated from `source/build.py`. 9 designs, 18 printed pieces; zero metal hardware.','', '| Component | Quantity | Material | Role |','| --- | ---: | --- | --- |']
 for r in BOM:lines.append(f"| {r['name']} | {r['quantity']} | {r['material']} | {r['note']} |")
 (ROOT/'bom.md').write_text('\n'.join(lines)+'\n')
 print('Manufacturing exports complete',flush=True)
if __name__=='__main__':build()

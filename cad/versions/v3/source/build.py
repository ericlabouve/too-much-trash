"""Build V3 only: reusable print set plus both-side assembly configurations."""
from dataclasses import asdict, replace
from pathlib import Path
from itertools import combinations
from functools import lru_cache
import json, math
import cadquery as cq
import trimesh
from model import *
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'review'
REVISION='approved-square-clip-v3'
SLIDING_BEAM_PRINT_NOTE='Two 31 x 4 mm beam windows leave 3.8 mm edge rails; tongue slot and central/stud islands retained. Fresh slice required. Continuous beam and root share X-10 rear bed face (CAD Y-90) and X-2 front face. Beam/studs shift5.2 mm; assembly slides outward5.2 mm to preserve cuff contacts. See flush-beam PETG slice; physical strength, engagement and band preload unverified.'
BRACKET_PRINT_NOTE='Common flat Y5.4 back face down (-90 degrees about X). Outer pulley cheek/arm and raised plinth removed; remaining boss raised 2 mm. Extended curved guide and independent return stop. Fresh slice required; support savings and cantilever strength unqualified.'
JAW_SLOT_PRINT_NOTE='Approved upright orientation; 6 mm arm/tongue slot with 35-degree roof. Matched PETG 0.12 mm automatic-support slice adds no support geometry; existing supports remain. See 2026-10-25-jaw-arm-slots. Physical roof quality, sliding fit and loaded strength unverified.'
BOM=[
 dict(id=n,name=label,quantity=q,material='PETG / PLA',note=note)
 for n,label,q,note in [
 ('shaft_cap','Rigid shaft clamp cap',1,'Taller cap walls meet the flat fixed jaw across a 1 mm split gap; inner extent X-4.8. Slot end ligaments thickened 1.6 to 2.6 mm; slot width 8.8 mm unchanged. 110 mm collar spans Z-40..70; two screws on each axial side of the jaw at Z-30/+60. Entire outer side at X12: body, crossing, rail wings and four screw seats share one bed plane. Use 1.8 mm shorter collar screws and the extended bracket bearing plate. New full collar fit and loaded retention unvalidated.'),
 ('carrier','Centered fixed stud, sliding track and shaft saddle',1,'Flat collar underside at X-5.8 with approved ramp below the fixed band hook; guide-floor slot with35-degree roof. Four screw mounts, track edges/stops and centered cuff unchanged. End strips trimmed to cap planes Z -38.5 / 68.5; no reprint requested for this visual refinement.'),
 ('sliding_jaw','Sliding dual-stud jaw',1,'Two fins end flush with the fixed rails at Y +/-13.8 mm, with 0.4 mm top clearance; wraparound skirts removed. Two 31 x 4 mm beam openings with 3.8 mm edge rails. Continuous121.6 mm beam flush with central root at X-10/-2. Studs100 mm apart; jaw sits5.2 mm farther out to keep cuff contacts unchanged. Tongue design retained; engagement and band preload need physical checks. See flush-beam slice.'),
 ('phone_cuff','Interchangeable 21.6 mm TPU cuff',3,'One unchanged shape at all three contacts: 6.8 mm square passage, 9.6 x 6.8 mm head recess. Integral seating ribs. ELEGOO TPU95A; previous square-stud fit successful, new ramped-stud pull-out resistance and full phone grip unqualified.'),
('actuator_bracket','Flat-back plunger frame and offset rail bracket',1,'Smoothly blended reinforcement. Mount bore offset 4.4 mm for a common flat back, preserving 5.4 mm beside the bore. No rail locating lugs: one screw/nut clamps the flat face; friction alone resists sliding and rotation. Bearing plate extends inward 1.8 mm to the flat cap; phone/plunger positions and rail fasteners unchanged. Remove phone/release twine; loosen nut and slide module with captured fasteners to rail screw Y +50 near / -50 far. Remove nut/screw there, withdraw 4.5 mm, lower 2 mm, then withdraw. Strength and retention unqualified.'),
 ('plunger','Rounded-shoe sliding plunger',1,'Shoe and blended root share the stem thickness of 4 mm; contact span remains 16 mm. Shared capped band/twine cleat. Nominal stroke is illustrative, not a physical force limit.'),
 ('pulley','Deep-groove redirect pulley',1,'Groove depth 1.1 to 2.2 mm nominal, with 36-degree flanks. Same 18 mm diameter, 4 mm width and 8.6 mm bore; unchanged axle and bearing envelope. Minimum radial web 2.5 mm. PETG slice review required; physical string retention, strength and rotation untested.'),
 ('pulley_axle','Headed smooth pulley axle',1,'Approved printed diamond-slot axle: 23.304 mm overall span, 8 mm shaft, 45-degree passage shifted 2 mm outboard. User confirms successful print and TPU key fit. Loaded retention remains unmeasured.'),
 ('pulley_key','TPU T/V axle snap key',1,'T-head stop and split V tip;14.7 mm overall,3 mm stem/thickness,5 mm relaxed V span. Pinch arms for removal. User confirms key fits the diamond axle; loaded pull-out, wear and creep unmeasured; keeper band retained pending qualification. Cuffs use integral studs.'),
 ('collar_screw','Common long TPU screw',5,'One unchanged 30.2 mm threaded-span 8×3 design: four collar screws and one actuator rail screw. Rail screw projects 12.2 mm farther beyond its nut; head bearing stays unchanged. User selects TPU for tighter feel; loaded retention, creep and thread strength unverified.'),
 ('thumb_nut','Common TPU clamp nut',5,'Same 8×3 nut geometry at all five stations. ELEGOO TPU 95A selected by user for tighter feel; hand-tighten only. Sustained preload, creep and thread stripping remain untested.'),
 ('clip_string_guide','Reversible TPU clip guide',1,'Approved 45-degree square press-stud clip. 12.8 x 17.8 mm opening; original 6 mm band, 1.6 mm walls and straight 35-degree print arm. Only roof and matching stud reshaped. Zero supports in the reviewed TPU slice. Design approved; revised clip unprinted, physical fit and retention untested. Assembly shows open manufactured pose, not a closed deformation simulation.')]]
BOM += [dict(id='twine',name='Twine sections joined by inline band',quantity=2,material='Twine',note='Two lengths joined with a rubber band along the neck. Run directly from the pulley to the nearest shaft guide; there are no bracket guide holes; leave enough for knots. Cord-clearance checks use the provisional 2 mm diameter; actual twine, knots and larger diameters need qualification.'),dict(id='rubber_bands',name='Rubber bands',quantity=5,material='Rubber',note='2 jaw closing + 1 return + 1 inline overtravel + 1 axle-key keeper. Actual preload and loop count need fitting.')]
for row in BOM:
 if row['id'] in ('twine','rubber_bands'):continue
 row['approval']='Not approved' if row['id'] in ('actuator_bracket','plunger') else 'Approved'
 row['note']=row['approval']+' (user assessment 2026-10-30). '+row['note']
 if row['id'] in ('phone_cuff','collar_screw','thumb_nut','clip_string_guide','pulley_key'):row['material']='ELEGOO TPU 95A'
SAMPLES={'wallet':Parameters(),'bare':Parameters(phone_thickness=8,button_from_screen=4),'small':Parameters(phone_width=66,phone_length=140,phone_thickness=7.5,button_from_end=99,button_from_screen=3.5),'large':Parameters(phone_width=86,phone_length=170,phone_thickness=20,button_from_end=150,button_from_screen=6)}

@lru_cache(maxsize=8192)
def shape_bounds(s):
 return s.val().BoundingBox()
def overlap(a,b):
 aa=shape_bounds(a);bb=shape_bounds(b)
 if any(getattr(aa,k+'max')<=getattr(bb,k+'min')+1e-7 or getattr(bb,k+'max')<=getattr(aa,k+'min')+1e-7 for k in 'xyz'):return 0.
 return sum(s.Volume() for s in a.intersect(b).vals())
def save(path,data):path.write_text(json.dumps(data,indent=2)+'\n')
def export(s,path,manufacturing=False):
 from OCP.BRepTools import BRepTools
 BRepTools.Clean_s(s.val().wrapped)
 if path.suffix=='.stl':
  # Keep the approved fine manufacturing mesh, without burdening every
  # assembly view with print-resolution copies of each repeated cuff/key.
  fine=manufacturing and ('cuff' in path.stem or 'pulley_key' in path.stem)
  s.val().exportStl(str(path),tolerance=.0005 if fine else .025,angularTolerance=.08 if fine else .12,relative=False)
  mesh=trimesh.load(path,force='mesh')
  mesh.merge_vertices(digits_vertex=5)
  mesh.update_faces(mesh.unique_faces());mesh.update_faces(mesh.nondegenerate_faces());mesh.remove_unreferenced_vertices()
  mesh.export(path)
 else:cq.exporters.export(s,str(path))

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
  for n in ('plunger',):
   moving=a[n].translate((-(p.rest_gap+p.button_stroke)*i/10,0,0))
   for other in tuple(k for k in a if k!='plunger'):
    v=overlap(moving,a[other])
    if v>.01:r['sweep'].append([i/10,n,other,round(v,4)])
 r['pivot_turn']=[]  # No rotating rocker/pivot in active design.
 r['fastener_shaft_overlap_mm3']={}
 for n in (name for name in a if name.startswith(('rail_screw_','rail_nut_','clamp_screw_','clamp_nut_'))):
  v=overlap(a[n],st['stock_neck'])
  if v>.01:r['fastener_shaft_overlap_mm3'][n]=round(v,4)
 # Orthographic screen-facing keepout includes the full phone face and the
 # space in front of it. Check added clamp parts, not intentional phone jaws.
 screen=box(p.phone_left,p.phone_right,p.phone_center_y-p.phone_length/2,p.phone_center_y+p.phone_length/2,-180,18-p.phone_thickness)
 r['clamp_screen_obstruction_mm3']={}
 for n in ('shaft_cap','clamp_screw_1','clamp_screw_2','clamp_screw_3','clamp_screw_4','clamp_nut_1','clamp_nut_2','clamp_nut_3','clamp_nut_4'):
  v=overlap(a[n],screen)
  if v>.01:r['clamp_screen_obstruction_mm3'][n]=round(v,4)
 r['passed']=not any(r.values())
 r['mechanical_passed']=not any(r[k] for k in ('camera_overlap','rigid_overlap','sweep','pivot_turn','fastener_shaft_overlap_mm3','clamp_screen_obstruction_mm3'))
 # Cuffs remain undeformed: report all seat/contact intersections separately,
 # never treat an overlapping TPU envelope as a demonstrated working fit.
 r['mechanical_passed']=r['mechanical_passed'] and not any(n not in ('cuff_fixed','cuff_sliding_1','cuff_sliding_2') and (n not in ('carrier','sliding_jaw') or p.phone_thickness<=14) for n in r['phone_overlap'])
 r['pocket_fit']=dict(previous_rigid_pocket_mm=14,cuff_tip_opening_mm=13.44,phone_thickness_mm=p.phone_thickness,
     uncompressed_clearance_fit=not r['phone_overlap'],known_oversize=p.phone_thickness>13.44,
     limits='Scaled curved seats have a varying opening; TPU compression and thin-phone seating need physical tests. 18/20 mm examples remain incompatible.')
 return r

def export_scene(p,solids,out):
 out.mkdir(parents=True,exist_ok=True)
 manifest={'version':'v3','title':'Three interchangeable cuffs on integral studs','revision':REVISION,'phone_rotation_degrees':180 if p.side=='far' else 0,'phone_center_y_mm':p.phone_center_y,'status':'Local TPU/stud fit approved; full jaws and loaded phone retention unvalidated','parameters':asdict(p),'bom':BOM,'printed_designs':12,'printed_pieces':22,'purchased_hardware':0,'soft_padding':True,'parts':[],'assembly':[]}
 for n,s in solids.items():
  file=n+'.stl'
  if out==OUT:export(s,out/file)
  else:
   (out/file).unlink(missing_ok=True);file='../'+file
  manifest['parts'].append({'name':n,'file':file,'quantity':next(r['quantity'] for r in BOM if r['id']==n)})
 assy=cq.Assembly(name='V3_adjustable')
 for name,s,col,bid in rows(p,solids):
  file='assembly_'+name+'.stl'
  shared=name=='carrier' or name.startswith(('stock_','band_collar_'))
  if out!=OUT and shared:
   (out/file).unlink(missing_ok=True);file='../'+file
  else:export(s,out/file)
  manifest['assembly'].append(dict(name=name,file=file,color=col,bom_id=bid))
  if name not in ('actuator_context','stock_neck_context','twine_phone'):assy.add(s,name=name,color=cq.Color(*col))
 if out==OUT:assy.export(str(out/'assembly.step'))
 path,bands,motion=flexible_paths(p)
 stroke=p.rest_gap+p.button_stroke
 target=(p.first_guide[0]-p.phone_right,p.first_guide[1]-p.button_y,p.first_guide[2]-p.height)
 head_paths=[[p.point(q) for q in plunger_pulley_path(stroke*i/20,target)] for i in range(21)]
 length=lambda pts:sum(math.dist(a,b) for a,b in zip(pts,pts[1:]))
 takeup=length(head_paths[0])-length(head_paths[-1])
 manifest['motion']={**motion,'kind':'plunger','stroke_mm':stroke,'pivot':p.point((25,0,6)),'angle':0,'string_eye':p.string_eye,'string_points':path,'band_paths':bands,'twine_to_stop':takeup,'return_moving_indices':list(range(5,11)),'head_paths':head_paths,'head_point_count':len(head_paths[0]),'contact':p.point((p.rest_gap,0,6)),'side_sign':1,'phone_point_count':len(path)-len(p.guide_stations)}
 save(out/'manifest.json',manifest)
 # Only these two obsolete scene meshes belonged to the removed second clamp.
 # Historical designs are preserved in Git; keep all other review assets.
 for obsolete in ('assembly_rail_screw_2.stl','assembly_rail_nut_2.stl'):
  (out/obsolete).unlink(missing_ok=True)

def manufacturing(solids):
 out=ROOT/'print';out.mkdir(exist_ok=True)
 rotations={'clip_string_guide':('X',0),'shaft_cap':('Y',90),'carrier':('Y',90),'sliding_jaw':('Y',-90),'actuator_bracket':('X',-90),'plunger':('X',-90),'pulley':('X',90),'pulley_axle':('X',90),'pulley_key':('X',90),'collar_screw':('X',180),'thumb_screw':('X',180),'thumb_nut':('X',0),'string_guide':('X',0),'dual_string_guide':('X',0)}
 notes={'clip_string_guide':'Axial end flat on bed; vertical 4 mm hole and constant-section clip. TPU 95A. Fresh slice and physical snap-fit test required; no support-free claim before slicing.','dual_string_guide':'Both eyes translated to saddle edge without rotation; lower faces coplanar on bed, central band lane clear. Verify support-free slice.','shaft_cap':'Cap with integral rail; export orientation provisional. Compare end-on-bed and side orientations in fresh low-waste slice review; keep supports off the neck mating surface.','carrier':'Carrier without actuator rail; export orientation provisional. Compare cut-end-on-bed to protect neck mating surfaces; inspect track roofs and accessible support removal.', 'sliding_jaw':'Compact jaw; export orientation provisional. Inspect tongue, ledge and hooks for overhangs; protect sliding faces and minimize removable supports.', 'actuator_bracket':'Open frame, small mounting bar and two-cheek pulley fork. Orientation provisional; fresh slice review required.', 'pulley_axle':'No thread. Head-down orientation provisional; cross-key slot needs slice review.', 'pulley_key':'Flat cross-key; preserve square load faces and band seats. Orientation provisional.', 'plunger':'Rounded shoe and cleat need slice review; keep supports off guide surfaces.', 'pulley':'Axis vertical, flange on bed. Keep bore and cord groove clean; running clearance unvalidated.', 'collar_screw':'Head on bed; longer 8×3 profile, flush tip. New grip length requires fit and loaded tests.', 'thumb_screw':'Head on bed; no support in threads. Fit trial first; do not force.', 'thumb_nut':'Flat on bed; no supports. Fit trial first.', 'string_guide':'Eye translated to saddle edge; eye and saddle lower faces coplanar on bed. Verify support-free slice.'}
 notes['shaft_cap']='Approved taller cap: X-4.8 inner wall, 2.6 mm slot end ligaments. Single X12 outer face down (+90 degrees about Y), including body, rail wings and all four screw seats; 4.2 mm rail thickness. Slicer/support review still required; no support-free claim.'
 notes['actuator_bracket']=BRACKET_PRINT_NOTE
 notes['carrier']='Canonical +90-degree Y orientation. Mirrored 35-degree band slot without square cap; cuff stud unchanged. Previous fixed-angle-35 slice predates this cleat revision; reslice before printing. Band seating, TPU retention and strength need testing.'
 notes['sliding_jaw']='Rear X=-10 down (-90 degrees about Y). Uncapped 35-degree band slot; lower projection restored to its original extent. Tongue and cuff studs unchanged. Previous angle-35 zero-support slice predates this revision; reslice before printing. Strength and retention unqualified.'
 notes['carrier']='Approved flat X-5.8 collar underside down (CAD Y+90), lower hook ramp; matches final PETG plate. '+JAW_SLOT_PRINT_NOTE
 notes['sliding_jaw']=SLIDING_BEAM_PRINT_NOTE
 notes['pulley_key']='ELEGOO TPU95A T/V snap prototype, uniform3 mm thickness flat on bed. Fresh TPU slice and insertion/reopening/pull-out tests required. Keep channels open; retain keeper until qualified.'
 rotations['phone_cuff']=('Y',-90)
 notes['phone_cuff']='Common 21.6 mm TPU cuff, back down. User reports tiny first-layer supports unnecessary; cuff batch disables support. Not a complete-jaw qualification.'
 result=[]
 for n,s in solids.items():
  if n=='pulley_key':
   from shared_key_design import snap_key
   from plunger_design import local_shape,KEY_OUTBOARD
   s=local_shape(snap_key().translate((0,0,-KEY_OUTBOARD)))
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
  result.append(dict(name=n,file=n+'.stl',quantity=next(r['quantity'] for r in BOM if r['id']==n),material=next(r['material'] for r in BOM if r['id']==n),bounds_mm=mesh.extents.round(3).tolist(),bed_z_min_mm=float(mesh.bounds[0,2]),watertight=True,layer_mm=.12 if n in ('thumb_screw','thumb_nut','collar_screw') else .2,supports=notes[n]))
 save(out/'manifest.json',dict(units='mm',scale_percent=100,nozzle_mm=.4,layer_mm=.2,revision=REVISION,status='Review prototype: consult current validation and service reports; physical fit, strength and force unvalidated',parts=result))

def build():
 p=Parameters();solids=parts(p);OUT.mkdir(exist_ok=True)
 report={'solids':{},'configurations':{},'excluded':['Historical stock shaft overlaps accepted smaller collar opening','Intentional nominal button travel','Band force, twine friction/stretch, retention, real phone tolerances and physical pulley fit and safe phone-button travel; isolated screw/nut success does not validate the loaded assembly']}
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
 if not all(x['mechanical_passed'] for x in report['configurations'].values()):raise SystemExit('Mechanical interferences: see review/validation.json')
 if not report['checks_passed']:print('PHONE FIT CONFLICT: undeformed cuff/phone intersections retained; 18/20 mm examples incompatible. See validation.json.',flush=True)
 manufacturing(solids)
 write_bom()
 print('Manufacturing exports complete',flush=True)

def write_bom():
 lines=['# V3 adjustable-clamp BOM','','Generated from `source/build.py`. 12 designs, 22 printed pieces; zero metal hardware. Three identical 21.6 mm cuffs, three integral jaw studs, one axle key.','', '| Component | Quantity | Material | Role |','| --- | ---: | --- | --- |']
 for r in BOM:lines.append(f"| {r['name']} | {r['quantity']} | {r['material']} | {r['note']} |")
 (ROOT/'bom.md').write_text('\n'.join(lines)+'\n')
def refresh_metadata():
 """Refresh generated descriptions without repeating unchanged mesh exports."""
 for name in SAMPLES:
  for side in ('near','far'):
   path=(OUT if name=='wallet' and side=='near' else OUT/(name+'-'+side))/'manifest.json'
   data=json.loads(path.read_text());assert data['revision']==REVISION
   data['bom']=BOM;save(path,data)
 path=ROOT/'print/manifest.json';data=json.loads(path.read_text());assert data['revision']==REVISION
 for part in data['parts']:
  if part['name']=='actuator_bracket':part['supports']=BRACKET_PRINT_NOTE
  if part['name']=='carrier':part['supports']='Approved flat X-5.8 underside down (CAD Y+90), lower hook ramp; matches final PETG plate. '+JAW_SLOT_PRINT_NOTE
  if part['name']=='shaft_cap':part['supports']='Approved taller cap, X12 exterior down (CAD Y+90), 2.6 mm slot ends; matches final PETG plate.'
  if part['name']=='sliding_jaw':part['supports']=SLIDING_BEAM_PRINT_NOTE
 save(path,data);write_bom()
if __name__=='__main__':build()

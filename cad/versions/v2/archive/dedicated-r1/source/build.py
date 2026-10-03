"""Build only V2 review assets; never writes cad/print or V1 source."""
from dataclasses import asdict
from pathlib import Path
import json
import math
import cadquery as cq
import trimesh
from model import Parameters, parts, rows, stock, stop_angle, rotate_point, flexible_paths

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'review'
BOM=[
 {'id':'carrier','name':'Dedicated cradle + shaft saddle + actuator bracket','quantity':1,'material':'PLA / PLA+','note':'One rigid body; hard lips, end stops and first twine guide. New V2 print, not a modified V1 export.'},
 {'id':'end_gate','name':'Removable end gate','quantity':1,'material':'PLA / PLA+','note':'Square tongues locate the gate; a rear rubber band retains it. Slide phone in from this end.'},
 {'id':'rocker','name':'Button rocker','quantity':1,'material':'PLA / PLA+','note':'Integral hard rounded contact and twine tie hole. No padding, threaded contact screw or metal spring.'},
 {'id':'pivot_key','name':'Printed pivot key','quantity':1,'material':'PLA / PLA+','note':'6 mm axle, quarter-turn retaining lug. Retention and printing orientation need prototype review.'},
 {'id':'string_guide','name':'Repeated captive twine guide','quantity':3,'material':'PLA / PLA+','note':'Band-held open saddles; closed rounded eyes retain slack twine. Stations are provisional.'},
 {'id':'twine','name':'One continuous piece of twine','quantity':1,'material':'Twine','note':'Cut after routing, with extra for two end knots. 2 mm display diameter is provisional; measure yours.'},
 {'id':'rubber_bands','name':'Rubber bands','quantity':8,'material':'Rubber','note':'2 collar + 1 gate + 3 guides + 1 rocker return + 1 trigger overtravel. Loop counts/preload depend on the actual bands; eight is the modeled starting count.'},
]

def overlap(a,b):
 return sum(s.Volume() for s in a.intersect(b).vals())

def build():
 p=Parameters();OUT.mkdir(exist_ok=True)
 solids=parts(p);scene=rows(p,solids)
 manifest={'version':'v2','title':'Twine + rubber bands','status':'Design review concept — not print approved',
   'parameters':asdict(p),'bom':BOM,'parts':[],'assembly':[],
   'printed_designs':len(solids),'printed_pieces':sum(r['quantity'] for r in BOM if r['material']=='PLA / PLA+'),
   'purchased_hardware':0,'soft_padding':False}
 report={'status':'review concept','solid_checks':{},'nominal_phone_overlap_mm3':{},
         'rigid_part_overlaps_mm3':{},'rocker_sweep_overlap_mm3':[],
         'excluded':['Historical stock shaft versus accepted smaller collar opening',
                     'Prescribed button contact travel at hard nose',
                     'Flexible-material forces, knots, friction, wear, band retention, print supports'],
         'unvalidated':['All V2 physical fits and retention','Rubber-band force and installed preload',
                        'Twine diameter, fuzz, stretch and abrasion','Camera/case bezel and charging-port outlines',
                        'Pivot insertion and quarter-turn locking sequence','Hard-stop/button calibration']}
 phone=stock(p)['phone_envelope']
 camera=stock(p)['camera_keepout']
 report['camera_overlap_mm3']={n:round(overlap(s,camera),5) for n,s in solids.items() if n!='string_guide'}
 report['phone_shaft_overlap_mm3']=round(overlap(phone,stock(p)['stock_neck']),5)
 for name,s in solids.items():
  ok=s.val().isValid() and len(s.val().Solids())==1
  assert ok, (name,'not one valid solid',len(s.val().Solids()))
  path=OUT/f'{name}.stl'
  cq.exporters.export(s,str(path),tolerance=.08,angularTolerance=.16)
  mesh=trimesh.load_mesh(path)
  assert mesh.is_watertight and mesh.volume>0,name
  report['solid_checks'][name]={'valid_connected_solid':True,'watertight':True,'volume_mm3':round(mesh.volume,2)}
  if name!='string_guide': report['nominal_phone_overlap_mm3'][name]=round(overlap(s,phone),5)
  manifest['parts'].append({'name':name,'file':path.name,'quantity':next(r['quantity'] for r in BOM if r['id']==name),'bounds_mm':mesh.extents.round(2).tolist()})
 print('Exported',len(solids),'valid connected solids',flush=True)
 fixed={k:v for k,v in solids.items() if k!='string_guide'}
 from itertools import combinations
 for a,b in combinations(fixed,2):
  v=overlap(fixed[a],fixed[b])
  if v>.01: report['rigid_part_overlaps_mm3'][f'{a}/{b}']=round(v,5)
 angle=stop_angle(p)
 for i in range(11):
  a=angle*i/10
  moving=solids['rocker'].rotate(p.pivot,(p.pivot[0],p.pivot[1]+1,p.pivot[2]),math.degrees(a))
  report['rocker_sweep_overlap_mm3'].append({'fraction':i/10,'carrier':round(overlap(moving,solids['carrier']),5),'pivot_key':round(overlap(moving,solids['pivot_key']),5)})
 report['pivot_turn_overlap_mm3']=[]
 for deg in range(0,91,15):
  pin=solids['pivot_key'].translate((0,3.4,0)).rotate(p.pivot,(p.pivot[0],p.pivot[1]+1,p.pivot[2]),deg)
  report['pivot_turn_overlap_mm3'].append(round(overlap(pin,solids['carrier']),5))
 path,bands,motion=flexible_paths(p)
 rest=math.dist(p.string_eye,p.first_guide)
 cable=rest-math.dist(rotate_point(p.string_eye,p,angle),p.first_guide)
 report['kinematics']={'stop_angle_degrees':math.degrees(angle),'nominal_contact_advance_mm':p.rest_gap+p.button_stroke,
    'twine_to_stop_mm':cable,'design_allowance_at_assumed_40_mm_takeup_mm':40-cable,
    'note':'Length geometry only. No band spring constants or force prediction. Trigger pivot is illustrative.'}
 manifest['motion']={**motion,'pivot':p.pivot,'angle':angle,'string_eye':p.string_eye,'string_points':path,
                     'band_paths':bands,'twine_to_stop':cable,
                     'return_fixed':(5,p.button_y+9,50),'return_moving':(5,p.button_y+4,18)}
 assy=cq.Assembly(name='V2_review_concept')
 for name,s,color,bom_id in scene:
  file=f'assembly_{name}.stl'
  cq.exporters.export(s,str(OUT/file),tolerance=.16,angularTolerance=.25)
  manifest['assembly'].append({'name':name,'file':file,'color':color,'bom_id':bom_id})
  if name not in ('actuator_context','stock_neck_context','twine_phone'):
   assy.add(s,name=name,color=cq.Color(*color))
 assy.export(str(OUT/'assembly.step'))
 bom_lines=['# V2 bill of materials','', 'Generated from `source/build.py`. Review concept; no V2 parts have been physically validated.','', '| Component | Quantity | Material | Role / remaining work |', '| --- | ---: | --- | --- |']
 for row in BOM: bom_lines.append(f"| {row['name']} | {row['quantity']} | {row['material']} | {row['note']} |")
 bom_lines += ['', 'No padding, purchased fasteners, metal springs, cable housing, ferrules or separate strap. The stock reacher and phone are existing equipment, not additional purchases.', '', 'Band paths and twine thickness are illustrative. Eight bands is the modeled starting count; actual loop count, preload, knot security and durability remain to be established.', '', 'V2 meshes under `review/` are assembly-coordinate design references, not bed-oriented manufacturing files.']
 (ROOT/'bom.md').write_text('\n'.join(bom_lines)+'\n')
 report['checks_passed']=(not any(report['nominal_phone_overlap_mm3'].values()) and not any(report['camera_overlap_mm3'].values()) and report['phone_shaft_overlap_mm3']==0 and not any(report['pivot_turn_overlap_mm3']) and not report['rigid_part_overlaps_mm3'] and all(r['carrier']<=.01 and r['pivot_key']<=.01 for r in report['rocker_sweep_overlap_mm3']))
 (OUT/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
 (OUT/'validation.json').write_text(json.dumps(report,indent=2)+'\n')
 print(json.dumps(report,indent=2),flush=True)
 if not report['checks_passed']: raise SystemExit('Review geometry has interferences; see validation.json')

if __name__=='__main__':build()

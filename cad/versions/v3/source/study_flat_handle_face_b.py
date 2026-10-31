"""Flatten the wheel-side handle face; retain the selected open-back mount."""
import math,json,shutil
from pathlib import Path
import cadquery as cq
from build import export
from plunger_design import box,tube,compound
ROOT=Path(__file__).resolve().parents[1];src=ROOT/'review/concepts/open-mount-clear-handle-b';out=ROOT/'review/concepts/flat-handle-face-b';out.mkdir(exist_ok=True)
for name in ['b-bracket.step','b-bracket.stl','pulley.stl','pulley_axle.stl','pulley_axle.step','pulley_key.stl','shaft-cap.stl','rail-screw.stl','rail-nut.stl','anti-rotation-cheeks.stl','knot-envelope.stl','direct-clamp-check.json']:
 shutil.copy2(src/name,out/name)
old=cq.importers.importStep(str(src/'b-plunger.step'));p=old.cut(box(1,20,24,36,7.7,20)).clean();assert p.val().isValid() and len(p.val().Solids())==1
assert p.cut(old).val().Volume()<1e-6
for ext in ['stl','step']:export(p,out/('b-plunger.'+ext))
b=cq.importers.importStep(str(src/'b-bracket.step'));frames=json.loads((src/'motion-paths.json').read_text());U=10.475091906795965;V=16.3;W=12.65;r=7.375091906795965
report={'revision':'flat-handle-face-b-v1','wheel_side_face_u_mm':1,'geometry_change':'Plunger material removal only; bracket and hardware byte-identical to preceding candidate. Existing rigid insertion overlap checks remain valid at their sampled positions.','removed_volume_mm3':old.val().Volume()-p.val().Volume(),'route_checks':[],'limits':['Cord approach gains a small lateral angle because its wrap moves inward while the wheel stays clear of the flat face.','Wrap retention, full operating stroke and printed fit remain unverified.','Fit wraps after inserting the plunger. No print requested.']}
for f in frames:
 f['attachment']=[(u-1.5 if u>0 else u,v,w) for u,v,w in f['attachment']]
 f['band']=[(u-1.2 if 0<u<4 and w==10.4 else u,v,w) for u,v,w in f['band']]
 a=(1.6,27.9+f['travel'],W);ang=math.atan2(a[1]-V,a[0]-U)+math.acos(r/math.hypot(a[0]-U,a[1]-V))
 arc=[(U+r*math.cos(ang+(1.5*math.pi-ang)*j/40),V+r*math.sin(ang+(1.5*math.pi-ang)*j/40),W) for j in range(41)]
 f['lead']=[a]+arc+[(U,-1.15,W)];f['cord_angle_to_travel_deg']=abs(math.degrees(math.atan2(arc[0][0]-a[0],a[1]-arc[0][1])))
(out/'motion-paths.json').write_text(json.dumps(frames))
for i in [0,20]:
 f=frames[i];d=f['travel'];band=compound([tube([(u,v,w+z) for u,v,w in f['band']],.5) for z in [-1,0,1]])
 row={'travel_mm':d,'cord_angle_deg':f['cord_angle_to_travel_deg']}
 for n,s in [('band',band),('attachment',tube(f['attachment'],.5)),('lead',tube(f['lead'],.5))]:
  row[n+'_bracket_mm3']=s.intersect(b).val().Volume();row[n+'_plunger_mm3']=s.intersect(p.translate((0,d,0))).val().Volume()
 print(row,flush=True);assert max(v for k,v in row.items() if k.endswith('_mm3'))<1e-5;report['route_checks'].append(row)
report['rest_cord_angle_degrees']=frames[-1]['cord_angle_to_travel_deg']
(out/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n');print('done',flush=True)

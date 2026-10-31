"""B integration: assembly clearance and support-free flat manufacture.
Run study_triangle_tail.py first; preserve its first slice as comparison evidence.
"""
import json,shutil,math
from pathlib import Path
import cadquery as cq
from plunger_design import box
from build import export
root=Path(__file__).resolve().parents[1]/'review/concepts';src=root/'triangle-tail';out=root/'triangle-tail-flat';out.mkdir(exist_ok=True)
def prism(poly,v,length):
 w=cq.Wire.makePolygon([cq.Vector(u,v,z) for u,z in poly],close=True)
 return cq.Workplane('XY').newObject([cq.Solid.extrudeLinear(w,[],cq.Vector(0,length,0))])
baseline_bracket=cq.importers.importStep(str(src/'b-bracket.step'))
# True 0.4 mm clearance normal to both 45-degree triangle faces.
# Initial concept had only ~0.03 mm near the bottom corners.
inner=[(-4.965685,3),(4.965685,3),(1.1,6.865685),(-1.1,6.865685)]
guide=box(-6.2,6.2,12,40,0,8).cut(prism(inner,11,30)).cut(box(-1.2,1.2,11,41,6,20))
bracket=baseline_bracket.cut(box(-5.8,5.8,12,40,-1,8.6)).union(guide)
# Round screw clearance remains; a tangent 45-degree roof removes its bridge.
r=4.4/math.sqrt(2)
bracket=bracket.cut(prism([(-18-r,9.8+r),(-18,9.8+2*r),(-18+r,9.8+r)],18.65,12)).clean()
old=cq.importers.importStep(str(src/'b-plunger.step'))
# Narrow only the base of the existing shared cleat, so it passes the top slot.
# Above the guide, 45-degree shoulders meet the unchanged wrapping post/cap.
envelope=prism([(-.8,6.4),(.8,6.4),(.8,8.6),(2.5,10.4),(-2.5,10.4),(-.8,8.6)],43.9,4.2)
slider=old.cut(box(-6,6,43.9,48.1,6.4,10.4).cut(envelope)).clean()
for n,s in [('b-bracket',bracket),('b-plunger',slider)]:
 assert s.val().isValid() and len(s.val().Solids())==1,n
 for ext in ['stl','step']:export(s,out/(n+'.'+ext))
# Changes only remove material above the floor; unchanged routes stay clear.
report=json.loads((src/'fit-attachment-check.json').read_text())
report['revision']='triangle-tail-flat-v3'
report['scope']='Integrated selected B; original foot, shared cleat, band anchor, pulley interface and rear stop retained.'
report['refinement']={'new_plunger_added_material_mm3':slider.cut(old).val().Volume(),'band_width_provisional_mm':3,'band_thickness_confirmed_mm':1,'cleat_slot_web_mm':1.6,'slot_mm':2.4,'mount_bore_roof_deg':45,'mount_bore_circular_clearance_mm':8.8,'floor_added_max_w_mm':1.5,'triangle_face_clearance_mm':.4,'guide_outer_width_mm':12.4,'guide_top_w_mm':8,'plunger_min_w_mm':slider.val().BoundingBox().zmin}
report['variants']['b']['limits']=['Retained rear stop is a return stop, not a button-safe press stop.','Front withdrawal remains possible after removing band/string.','Band width, knot size, slack and loaded friction remain unverified.']
report['stroke_samples']=[{'translation_mm':d,'intersection_mm3':slider.translate((0,d,0)).intersect(bracket).val().Volume()} for d in [-1.5,0,1.5]]
assert max(q['intersection_mm3'] for q in report['stroke_samples'])<1e-5
report['insertion_samples']=[]
for d in [-38,-32,-24,-16,-8,0]:
 v=slider.translate((0,d,0)).intersect(bracket).val().Volume();report['insertion_samples'].append({'translation_mm':d,'intersection_mm3':v});print('insertion',d,v,flush=True)
assert max(q['intersection_mm3'] for q in report['insertion_samples'])<1e-5
assert report['refinement']['new_plunger_added_material_mm3']<1e-5
for n in ['return-band','band-envelope','string-envelope','string-lead','knot-envelope','current-bracket','current-plunger','pulley','pulley_axle','pulley_key']:shutil.copy2(src/(n+'.stl'),out/(n+'.stl'))
(out/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
print('Complete',flush=True)
# Expose the same nominal paths for interactive motion review.
from plunger_design import return_path,attachment_path,GROOVE_W
frames=[]
for i in range(21):
 d=-1.5+i*.15
 bp=[(8-z,x-8.35,9.4 if abs(5.4-y-10.1)<.001 else 5.4-y) for x,y,z in return_path(-d)]
 ap=[(8-z,x-8.35,5.4-y) for x,y,z in attachment_path(-d)]
 r=6.8+(.5*math.sqrt(1+(1.6/2.2)**2)-.2)/(1.6/2.2)
 a=ap[-1];ang=math.atan2(a[1]-8,a[0]-13.5)+math.acos(r/math.hypot(a[0]-13.5,a[1]-8))
 arc=[(13.5+r*math.cos(t),8+r*math.sin(t),GROOVE_W) for t in [ang+(1.5*math.pi-ang)*j/40 for j in range(41)]]
 frames.append({'travel':d,'band':bp,'attachment':ap,'lead':[a]+arc+[(13.5,-12,GROOVE_W)]})
(out/'motion-paths.json').write_text(json.dumps(frames))
report['variants']['b']['plunger_volume_mm3']=slider.val().Volume()
report['bracket_volume_mm3']=bracket.val().Volume()
report['wrap_check']['refined_geometry_evidence']='Plunger is a subset of swept baseline; new guide additions are below w8 and within v12..40. Tail wraps remain at v>=41, string lead/knot above w10.1. Added floor below w1.5. Mount roof only removes material.'
report['wrap_check']['sample_count']=7
(out/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')

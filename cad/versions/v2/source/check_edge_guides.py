"""Verify translated guide eyes, bore passage and the illustrative band clearance."""
import sys,json
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parent))
import model as m
p=m.Parameters();out={}
for name,make,centers in [('string_guide',m.guide,[(-18,0,-4)]),('dual_string_guide',m.dual_guide,[(0,-20,-4),(0,20,-4)])]:
 s=make(p);b=s.val().BoundingBox();band=m.polyline(m.rounded_band_xy(0),1.4);v=s.intersect(band).val().Volume();print(name,'band overlap',v,flush=True)
 assert s.val().isValid() and len(s.val().Solids())==1
 assert abs(b.zmin+7)<1e-5
 assert v<.01
 for c in centers:
  core=m.cylinder((c[0],c[1],-8),(0,0,1),16,7.9);assert s.intersect(core).val().Volume()<.01
 out[name]={'valid_single_solid':True,'eye_translation_mm':[0,0,-4],'eye_lower_face_z_mm':-7,'saddle_lower_face_z_mm':b.zmin,'bore_diameter_mm':8,'bore_axis':[0,0,1],'band_envelope_diameter_mm':1.4,'band_overlap_mm3':v,'eye_centers':centers}
(Path(__file__).resolve().parents[1]/'review/edge-guides.json').write_text(json.dumps({'parts':out,'limitations':'Illustrative 1.4 mm band envelope; actual band size, friction and strength unvalidated. No print requested.'},indent=2)+'\n')

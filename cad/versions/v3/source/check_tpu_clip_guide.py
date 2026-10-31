"""Geometric checks only: TPU deformation, grip and wear need a live test."""
import json
from pathlib import Path
from dataclasses import replace
from build import SAMPLES, REVISION, overlap
import model as m
from tpu_clip_guide import guide, placed, BORE, EYE_Y, WALL, MOUTH

s=guide()
assert s.val().isValid() and len(s.solids().vals())==1
neck=m.box(-7,7,-9.5,9.5,-200,-180)
rows={}
for name,base in SAMPLES.items():
 for side in ('near','far'):
  p=replace(base,side=side);g=placed(s,-190,side)
  string,bands,_=m.flexible_paths(p)
  assert not any(n.startswith('band_guide') for n in bands)
  assert len(bands)==5
  neck_overlap=overlap(g,neck)
  # Inspect the full incoming/outgoing nominal 2 mm cord, including oblique
  # traversal of the reduced-diameter eye; not only a vertical drill gauge.
  cord=m.polyline(string,p.twine_diameter)
  cord_overlap=overlap(g,cord)
  assert 0<neck_overlap<45,(name,side,neck_overlap)  # Intended elastic interference, not rigid clearance.
  assert cord_overlap<.01,(name,side,cord_overlap)
  rows[name+'-'+side]={'neck_overlap_mm3':neck_overlap,'cord_clip_overlap_mm3':cord_overlap,'eye_center_mm':p.first_guide,'guide_count':len(p.guide_stations),'band_count':len(bands)}
result={'revision':REVISION,'passed':True,'bore_mm':BORE,'former_bore_mm':8,'axial_thickness_mm':6,'wall_mm':WALL,'mouth_mm':MOUTH,'nominal_neck_mm':[14,19],'cavity_mm':[13.8,18.8],'nominal_interference_per_face_mm':.1,'volume_mm3':s.val().Volume(),'configurations':rows,'limitations':['Snap opening/deformation and sustained TPU grip are not simulated.','Intentional 0.1 mm per-face interference proposes preload; test axial sliding under actual cord pull.','Longer unsupported cord span, stock ribs and surface variation require physical checks.','Not sliced or printed. Existing upstream cord/carrier conflict is not resolved by this local check.']}
(Path(__file__).resolve().parents[1]/'review/tpu-clip-guide.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))

"""Geometric capture checks; no claim of a measured full squeeze or elastic retention."""
from pathlib import Path
import json
import cadquery as cq
r=Path(__file__).resolve().parents[1]/'review/concepts/forward-handle-b'
b=cq.importers.importStep(str(r/'b-bracket.step'));p=cq.importers.importStep(str(r/'b-plunger.step'))
rows=[]
for travel in [0,-1.5,-3,-6]:
 s=p.translate((0,travel,0));overlap=s.intersect(b).val().Volume();lift=s.translate((0,0,.8)).intersect(b).val().Volume()
 row={'pull_mm':-travel,'straight_motion_overlap_mm3':overlap,'captured_axial_overlap_mm':41+travel-21.25,'overlap_after_0_8mm_upward_lift_mm3':lift}
 rows.append(row);print(row,flush=True)
 assert overlap<1e-5 and lift>0
report={'guide_span_mm':[21.25,41.4],'guide_length_mm':20.15,'prior_main_guide_length_mm':9.15,'rows':rows,'limits':['Full grabber string travel is unknown.','An open assembly path remains; the guide does not impose a forward mechanical stop.','6 mm is an extra shaft-only capture check, not a verified operating stroke or force limit.','Physical clearance, tilt, bending, friction and band tension require a fit test.']}
(r/'retention-check.json').write_text(json.dumps(report,indent=2)+'\n')

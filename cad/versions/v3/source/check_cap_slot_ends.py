import sys,json
from pathlib import Path
sys.path.insert(0,'cad/versions/v3/source')
import model as m
s=m.shaft_cap(m.Parameters());assert s.val().isValid() and len(s.val().Solids())==1
# Preserve the existing service screw positions and full 8.8 mm bores at Y +/-50.
for y in (-50,50):
 bore=m.cylinder((-10,y,26),(1,0,0),30,8.8)
 assert sum(v.Volume() for v in s.intersect(bore).solids().vals())<1e-6
r={'revision':'thicker-cap-slot-ends-v3','previous_end_ligament_mm':1.6,'new_end_ligament_mm':2.6,'slot_width_mm':8.8,'outer_y_extent_mm':[-60,60],'service_centers_y_mm':[-50,50],'service_bores_clear':True,'valid_single_solid':True,'physical_strength_verified':False}
Path('cad/versions/v3/review/thicker-cap-slot-ends.json').write_text(json.dumps(r,indent=2)+'\n');print(r)

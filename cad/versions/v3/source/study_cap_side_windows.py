"""Slice paired cap side windows in the current bed orientation."""
import sys,json
from pathlib import Path
import cadquery as cq
import model as m
from cap_side_windows import refine
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
out=Path(sys.argv[sys.argv.index('--output-dir')+1]).resolve()
source=out.parent/(out.name+'-source');source.mkdir()
old=m.shaft_cap(m.Parameters(),side_windows=False);new=refine(old)
vol=lambda s:sum(v.Volume() for v in s.solids().vals())
assert new.val().isValid() and len(new.val().Solids())==1
assert vol(new.cut(old))<1e-6
# Retain the bed-side rail connection and screw-station neighborhoods.
removed=old.cut(new)
assert vol(removed.intersect(m.box(5.01,15,-70,70,-40,70)))<1e-6
for z in (-30,60):assert vol(removed.intersect(m.box(-10,15,-40,40,z-12,z+12)))<1e-6
r={'revision':'side-window-cap-trial','valid_single_solid':True,'side_window_length_mm':64,'visible_opening_height_mm':5,'roof_angle_from_bed_degrees':35,'minimum_split_edge_ligament_mm':4.8-2.5*__import__('math').tan(__import__('math').radians(35)),'old_volume_mm3':vol(old),'new_volume_mm3':vol(new),'limits':['Roof print quality and clamp stiffness require physical checks.']}
(source/'fit-attachment-check.json').write_text(json.dumps(r,indent=2)+'\n')
s=new.rotate((0,0,0),(0,1,0),90).rotate((0,0,0),(0,0,1),90)
for ext in ('step','stl'):cq.exporters.export(s,str(source/('shaft_cap.'+ext)),**({'tolerance':.015,'angularTolerance':.1} if ext=='stl' else {}))
plate.SOURCE=source;plate.PARTS={'shaft_cap':((117.7,74.2),'Z',270,'Approved X12 bed face; same XY placement as compact plate.')}
plate.main();review.OUT=out
review.main(project_stem='cuff-fit',title='Shaft cap · paired side windows',detail_parts=['shaft_cap'],notes=['Two 64 mm side-wall openings with 35-degree roofs across wall thickness. Automatic supports enabled; no printer contacted.'])

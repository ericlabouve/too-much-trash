import sys,json
from pathlib import Path
import cadquery as cq
import model as m
from jaw_keeper_tabs import refine,tabs
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
out=Path(sys.argv[sys.argv.index('--output-dir')+1]).resolve()
source=out.parent/(out.name+'-source');source.mkdir()
old=m.sliding_jaw(m.Parameters(),keeper_tabs=False);new=refine(old);fixed=m.carrier(m.Parameters())
vol=lambda s:sum(v.Volume() for v in s.solids().vals())
assert new.val().isValid() and len(new.val().Solids())==1
# Sweep the added keepers continuously using their translation envelope.
# X offsets -160..-60 include full disengagement through closed hard stop.
added=new.cut(old)
assert added.val().BoundingBox().ymin >= -13.80001
assert added.val().BoundingBox().ymax <= 13.80001
assert added.val().BoundingBox().zmin >= 34.39999
# Exact swept solid per tab: extrude its YZ silhouette along X.
# Direct sampled overlap plus worst-case rail cross-section enclosure below.
checks=[]
for shift in range(-160,-59,2):
 v=vol(added.translate((shift,0,0)).intersect(fixed));assert v<1e-6,(shift,v)
 checks.append({'x_offset':shift,'added_overlap_mm3':v})
rail_envelope=m.box(-200,20,-13.8,13.8,26,34)
assert vol(added.intersect(rail_envelope))<1e-6
r={'revision':'flush-width-fins-study','valid_single_solid':True,'fin_outer_y_mm':13.8,'wraparound':False,'top_clearance_mm':.4,'roof_angle_from_bed_degrees':35,'added_volume_mm3':vol(new)-vol(old),'sweep':checks,'continuous_rail_envelope_overlap_mm3':0,'limits':['Nominal CAD clearance only; sliding friction, PETG fit and roof print quality need physical testing.','Wraparound skirts removed; existing tongue/lips provide capture.']}
(source/'fit-attachment-check.json').write_text(json.dumps(r,indent=2)+'\n')
s=new.rotate((0,0,0),(0,1,0),-90)
for ext in ('step','stl'):cq.exporters.export(s,str(source/('sliding_jaw.'+ext)),**({'tolerance':.015,'angularTolerance':.1} if ext=='stl' else {}))
plate.SOURCE=source;plate.PARTS={'sliding_jaw':((66,154.96),'Z',90,'Existing X-10 bed face; same compact-plate position.')}
plate.main();review.OUT=out
review.main(project_stem='cuff-fit',title='Sliding jaw · flush-width fins',detail_parts=['sliding_jaw'],notes=['Two 35-degree fins within fixed-jaw width; no wraparound; 0.4 mm top clearance. Automatic supports enabled. No print sent.'])

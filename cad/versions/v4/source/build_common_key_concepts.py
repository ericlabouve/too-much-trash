"""Common-key design plus rejected stationary-fork comparison."""
from pathlib import Path
import sys,json
from build_steep_stop import geometry_stop,prism
import cadquery as cq
import math
from shared_key_design import snap_key
from plunger_design import box
from build_travel_stops import overlap
from build import export
out=Path(sys.argv[1]);out.mkdir(parents=True,exist_ok=True)
br,pl,_,context,*_=geometry_stop()
# Unchanged original key, upright. Native T underside is X18.
k=snap_key().translate((-18,-8,-.3))
up=k.rotate((0,0,0),(0,1,0),90).translate((0,20,0))
down=k.rotate((0,0,0),(0,1,0),-90).translate((0,20,9.2))
# Two vertical towers sit in the moving slot: visibly mark insertion obstruction.
fork=box(-1.5,1.5,16.7,18.2,2.9,9.2).union(box(-1.5,1.5,21.8,23.3,2.9,9.2))
# Reverse ownership: key moves with plunger; closed slot is in stationary plate.
upper=4-3.2/math.tan(math.radians(70))
filled=pl.union(prism([(-4,3.4),(4,3.4),(upper,6.6),(-upper,6.6)],15.35,35.0))
seat=cq.Workplane('YZ').polyline([(23,6.6),(26.5,9.2),(33.5,9.2),(37,6.6)]).close().extrude(3).translate((-1.5,0,0))
reverse_plunger=filled.union(seat).cut(box(-1.7,1.7,28.3,31.7,3,10)).clean()
reverse_bracket=br.cut(box(-1.7,1.7,15.7,31.7,-.1,3.1)).clean()
reverse_key=down.translate((0,10,0))
from geometry_common_key import geometry_common_key
reverse_bracket,reverse_plunger,reverse_key,_=geometry_common_key()
# Small TPU stem interference receiver, no new overhang. V is secondary capture only.
ring=box(-1.7,1.7,18.3,21.7,0,3).cut(box(-1.475,1.475,18.525,21.475,-.1,3.1))
for n,s in {'bracket':br,'plunger':pl,'top-key':down,'bottom-key':up,'fork':fork,'throat':ring,'reverse-bracket':reverse_bracket,'reverse-plunger':reverse_plunger,'reverse-key':reverse_key,**context}.items():export(s,out/(n+'.stl'))
report={'original_key_unchanged':True,'key_grip_mm':9.2,'plate_thickness_mm':3,'top_down':{'head_seat_z_mm':9.2,'problem':'Fixed fork towers block end-on plunger insertion; rejected as shown.','fork_plunger_rest_overlap_mm3':overlap(fork,pl),'fork_plunger_at_17mm_insertion_overlap_mm3':overlap(fork,pl.translate((0,-17,0)))},'underside_throat':{'opening_mm':2.95,'stem_mm':3,'nominal_interference_mm':.05,'problem':'Depends on untested TPU friction. If it slips, up to6.2mm axial movement before V catches. Not a positive snug lock.','key_bracket_overlap_mm3':overlap(up,br),'key_plunger_overlap_mm3':overlap(up,pl),'key_context_overlap_mm3':sum(overlap(up,s) for s in context.values())},'reverse_slot':{'key_moves_with_plunger':True,'plate_slot_y_mm':[15.9,31.7],'seat_top_z_mm':9.2,'nominal_pull_mm':12.6,'rest_key_bracket_overlap_mm3':overlap(reverse_key,reverse_bracket),'rest_plunger_bracket_overlap_mm3':overlap(reverse_plunger,reverse_bracket),'at_limit_plunger_bracket_overlap_mm3':overlap(reverse_plunger.translate((0,-12.6,0)),reverse_bracket),'at_limit_key_bracket_overlap_mm3':overlap(reverse_key.translate((0,-12.6,0)),reverse_bracket),'at_limit_key_context_overlap_mm3':sum(overlap(reverse_key.translate((0,-12.6,0)),s) for s in context.values()),'limits':'Sampled insertion and motion verified; physical TPU retention untested. See common-key-validation.json.'},'support_status':'Promoted reverse-slot PETG bracket/plunger and unchanged TPU key sliced with zero support/interface paths. Rejected fork/throat not qualified. No print.'}
(out/'review.json').write_text(json.dumps(report,indent=2));print(json.dumps(report))

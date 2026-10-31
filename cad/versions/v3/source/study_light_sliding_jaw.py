"""Two beam windows retain stud islands and the central tongue connection."""
import json,hashlib,os
from pathlib import Path
import cadquery as cq
import model as m
ROOT=Path(__file__).resolve().parents[1]
width=float(os.environ.get('WINDOW_WIDTH','5'))
OUT=ROOT/('review/light-sliding-jaw' if width==5 else 'review/light-sliding-jaw-wide');OUT.mkdir(exist_ok=True)
old=m.sliding_jaw(m.Parameters(),beam_window_width=0);new=old
for a,b in ((-43,-12),(12,43)):
    tool=m.box(-11,0,a,b,m.CUFF_Z-width/2,m.CUFF_Z+width/2).edges('|X').fillet(width/2-.01)
    new=new.cut(tool)
new=new.clean()
vol=lambda s:sum(v.Volume() for v in s.solids().vals())
assert new.val().isValid() and len(new.val().Solids())==1
assert vol(new.cut(old))<1e-6
removed=old.cut(new)
assert vol(removed.intersect(m.box(-20,55,-10,10,-5,50)))<1e-6
for y in (-50,50):assert vol(removed.intersect(m.box(-20,55,y-6,y+6,-5,50)))<1e-6
oriented=new.rotate((0,0,0),(0,1,0),-90)
for ext in ('stl','step'):cq.exporters.export(oriented,str(OUT/('sliding_jaw.'+ext)),**({'tolerance':.015,'angularTolerance':.1} if ext=='stl' else {}))
report={'revision':'light-sliding-jaw-study','old_volume_mm3':vol(old),'new_volume_mm3':vol(new),'removed_percent':100*vol(removed)/vol(old),'valid_single_solid':True,'window_dimensions_mm':[31,5],'minimum_beam_edge_rail_mm':3.3,'central_connection_and_stud_islands_unchanged':True,'source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),'limits':['Subtractive change preserves the existing collision envelope; bending stiffness and retention need physical testing.','Existing tongue slot retained; do not merge the windows through the central load connection.']}
report['window_dimensions_mm']=[31,width]
report['minimum_beam_edge_rail_mm']=(11.6-width)/2
(OUT/'geometry.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))

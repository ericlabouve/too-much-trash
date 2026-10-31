"""Flat-printable, one-piece TPU clip proposal; no live print."""
import json
from pathlib import Path
import cadquery as cq
from build import export
OUT=Path(__file__).resolve().parents[1]/'review/concepts/plug-clip';OUT.mkdir(parents=True,exist_ok=True)
W,H,T=12.8,17.8,6
# C-frame; smaller nominal internal envelope requested by user.
outer=cq.Workplane('XY').rect(W+3.2,H+3.2).extrude(T).edges('|Z').fillet(2)
inner=cq.Workplane('XY').rect(W,H).extrude(T+2).translate((0,0,-1)).edges('|Z').fillet(.4)
cut=cq.Workplane('XY').box(15,16,T+2).translate((13,0,T/2))
base=outer.cut(inner).cut(cut)
root=cq.Workplane('XY').box(8,5,T).translate((0,12.2,T/2))
eye=cq.Workplane('XY').center(0,14.7).circle(4).extrude(T)
hole=cq.Workplane('XY').center(0,14.7).circle(2).extrude(T+2).translate((0,0,-1))
base=base.union(root).union(eye).cut(hole).cut(inner)
# External closure center x9.5; all latch features stay outside neck envelope.
# Lower tongue with tapered mushroom plug, printed separated from upper socket.
def tongue(dy=0):
 pts=[(6.4,-9.5),(10.3,-9.5),(10.3,1),(11.3,1),(11.3,2.2),(9.5,4),(7.7,2.2),(7.7,1),(8.7,1),(8.7,-7.9),(6.4,-7.9)]
 pts=[(x,y+dy if y>=1 else y) for x,y in pts]
 return cq.Workplane('XY').polyline(pts).close().extrude(T)
socket=cq.Workplane('XY').box(6.8,6.8,T).translate((9.5,7.1,T/2))
# Open-bottom neck and wide internal cavity. Flexible cheeks open for plug.
cavity=cq.Workplane('XY').polyline([(8.5,3),(10.5,3),(10.5,5.4),(11.5,5.4),(11.5,7.1),(9.5,9.1),(7.5,7.1),(7.5,5.4),(8.5,5.4)]).close().extrude(T+2).translate((0,0,-1))
base=base.union(socket).cut(cavity)
part=base.union(tongue()).clean();assert part.val().isValid() and len(part.val().Solids())==1
export(part,OUT/'clip.stl');export(part,OUT/'clip.step');export(base,OUT/'frame.stl');export(tongue(),OUT/'tongue.stl');export(tongue(4.4),OUT/'tongue-closed.stl')
# Closed display is illustrative flexure: tongue flexes upward3.4mm, not a rigid fit proof.
report={'revision':'plug-clip-review-v3','opening_mm':[W,H],'thickness_mm':T,'eye_mm':4,'support_strategy':'Constant 6 mm extrusion, flat on bed; every cavity open through thickness.','closure':'External tapered mushroom plug, compressible socket cheeks; no loose fastener.','limits':['Closed pose illustrates tongue flex; not an elastic simulation.','Smaller neck fit, closing force, creep and pullout untested.','User explicitly declines printing this piece now.']}
(OUT/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
print(report)

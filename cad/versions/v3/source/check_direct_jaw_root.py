"""Verify the lowered full-depth jaw root replaces the thin connector."""
import json
import build as b
p=b.Parameters();s=b.carrier(p)
volume=lambda shape:sum(x.Volume() for x in shape.solids().vals())
# Both sides of the old gap and the clamp seam must be solid through the
# full track depth, not merely the old 4 mm floor.
root=b.box(-15.3,-11.2,-13.8,13.8,22,34)
missing=volume(root.cut(s))
assert missing<1e-6,missing
assert s.val().isValid() and len(s.val().Solids())==1
neck=b.box(-5.8,5.8,-8.8,8.8,b.CLAMP_BOTTOM,b.CLAMP_TOP)
assert b.overlap(s,neck)<1e-6
slider=b.sliding_jaw(p)
stop_overlap=b.overlap(s,slider.translate((b.CLOSED_JAW_X+.2,0,0)))
assert stop_overlap>.01,stop_overlap
# The stop-preserving wall addition must not change the separately checked
# cord route, even where older routing conflicts remain elsewhere.
wall=b.box(-18,-15.3,-16,16,26,34)
cord_hits=[]
for name,base in b.SAMPLES.items():
 for side in ('near','far'):
  q=b.replace(base,side=side);path,_,_=b.flexible_paths(q)
  for i,(start,end) in enumerate(zip(path,path[1:])):
   if start==end:continue
   hit=b.overlap(wall,b.rod(start,end,2))
   if hit>.01:cord_hits.append([name,side,i,hit])
assert not cord_hits,cord_hits
report=dict(revision=b.REVISION,passed=True,track_shift_x_mm=b.TRACK_ROOT_SHIFT,
 full_depth_root_mm=12,root_width_at_clamp_mm=27.6,missing_root_mm3=missing,
 fixed_cleat_x_mm=b.FIXED_CLEAT_X,closed_jaw_x_mm=b.CLOSED_JAW_X,
 stop_overtravel_0p2_overlap_mm3=stop_overlap,added_stop_wall_cord_hits=cord_hits,valid=True,solids=1,
 changed_print_designs=['carrier'],unchanged=['phone','all three cuffs','sliding jaw','shaft cap','actuator','fasteners'],
 limits=['Direct solid continuity is not a strength or preload qualification.','Fixed band anchor moves with track; real band tension needs physical fitting.'])
(b.ROOT/'review/direct-jaw-root.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2),flush=True)

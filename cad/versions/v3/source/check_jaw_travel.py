"""Verify empty closure and retained tongue engagement; not band-force validation."""
from pathlib import Path
import json
import model as m
p=m.Parameters();fixed=m.carrier(p);slider=m.sliding_jaw(p)
rows=[]
for i in range(91):
 x=m.CLOSED_JAW_X-45*i/90
 v=fixed.intersect(slider.translate((x,0,0))).val().Volume()
 assert v<.01,(x,v)
 rows.append({'head_x_mm':x,'overlap_mm3':v})
stop_overlap=fixed.intersect(slider.translate((m.CLOSED_JAW_X+.2,0,0))).val().Volume()
assert stop_overlap>.01,stop_overlap
assert m.CLOSED_JAW_X==(-113-20)/2
old_x=-18-66
out={'closed_head_x_mm':m.CLOSED_JAW_X,'fixed_span_x_mm':[-113,-20],'closed_position_fraction':.5,'closed_phone_gap_mm':p.phone_right-m.CLOSED_JAW_X,'old_closed_phone_gap_mm':p.phone_right-old_x,'additional_closing_travel_mm':m.CLOSED_JAW_X-old_x,'tongue_length_mm':m.SLIDING_TONGUE_LENGTH,'previous_tongue_length_mm':66,'samples':rows,'overtravel_0_2mm_collision_mm3':stop_overlap,'cleat':{'stem_xy_mm':[5,15],'cap_xy_mm':[9,20],'band_stack_height_mm':6.7},'limitations':['Band force/preload is not computed; unchanged loaded hook spacing does not increase force with identical bands.','Actual band width, thickness, quantity, creep and phone grip need physical tests.','Open-travel sampling does not model withdrawal beyond the tested range.']}
(Path(__file__).resolve().parents[1]/'review/jaw-travel.json').write_text(json.dumps(out,indent=2)+'\n');print({k:v for k,v in out.items() if k not in ['samples','limitations']})

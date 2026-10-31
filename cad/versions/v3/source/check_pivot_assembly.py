"""Loose-module pivot insertion, quarter-turn and seating; no force prediction."""
import json
from pathlib import Path
import build as b
import model as m

def main():
 p=m.Parameters();parts=m.parts(p);pin=parts['pivot_key'];axis=((19,0,18),(19,1,18));hits=[]
 stages=[('insert',y/10,90) for y in range(-350,35,5)]
 stages += [('turn',3.4,a) for a in range(90,-1,-5)]
 stages += [('seat',i/10,0) for i in range(34,-1,-1)]
 for stage,y,angle in stages:
  moving=pin.rotate(*axis,angle).translate((0,y,0))
  for target in ('rocker','actuator_bracket'):
   v=b.overlap(moving,parts[target])
   if v>.01:hits.append([stage,y,angle,target,round(v,5)])
 old_hole=m.cylinder((19,-4,18),(0,1,0),8,6.5)
 # Demonstrate the old obstruction using the cross-tab halfway through rocker.
 tab=m.box(18.2,19.8,8.4,10,13.8,22.2).rotate(*axis,90).translate((0,-9,0))
 old_obstruction=sum(v.Volume() for v in tab.cut(old_hole).solids().vals())
 retention={'straight_withdrawal_mm3':b.overlap(pin.translate((0,-1,0)),parts['actuator_bracket']), 'seated_turn_plus15_mm3':b.overlap(pin.rotate(*axis,15),parts['actuator_bracket']), 'seated_turn_minus15_mm3':b.overlap(pin.rotate(*axis,-15),parts['actuator_bracket'])}
 report={'retention_obstructions':retention,'head_across_flats_mm':7.4,'index_stop_clearance_mm':0.2,'revision':'t-jaw-compact-actuator-v3','pivot_tab_mm':[8.4,1.6],'rocker_keyway_mm':[9,2.2], 'rocker_boss_diameter_mm':12,'boss_lower_relief_z_mm':13.3,'nominal_slot_end_wall_mm':1.5,'old_round_bore_mm':6.5,'old_tab_outside_bore_mm3':old_obstruction,'sequence':'Assemble loose module: align tab with horizontal slots, insert to +3.4 mm beyond seated position, rotate 90 degrees, pull back to seated position. Reverse for removal.','samples':len(stages),'intersections':hits,'passed':not hits and min(retention.values())>.01,'limitations':['Finite geometric samples; print tolerances, key strength, tactile indexing and retention require physical checks.','Insertion is checked in the loose actuator module, before mounting to the cap rail.']}
 (Path(__file__).resolve().parents[1]/'review/pivot-assembly.json').write_text(json.dumps(report,indent=2)+'\n')
 print(json.dumps(report,indent=2));assert report['passed']
if __name__=='__main__':main()

"""Compare promoted solids to the preserved successful trial and sweep mating threads."""
import json
from pathlib import Path
import model as m
import build_fixed_envelope_thread_trial as trial

def volume(s): return sum(x.Volume() for x in s.solids().vals())
def overlap(a,b): return volume(a.intersect(b))
def main():
 p=m.Parameters(); screw=m.thumb_screw(p); nut=m.thumb_nut(p); rocker=m.rocker(p)
 reference=trial.make_parts()
 differences={n:volume(s.cut(reference['trial_'+n.replace('thumb_','')+'_8x3']))+volume(reference['trial_'+n.replace('thumb_','')+'_8x3'].cut(s)) for n,s in [('thumb_screw',screw),('thumb_nut',nut)]}
 nut_sweep={str(a):overlap(screw,nut.rotate((0,0,0),(0,0,1),a).translate((0,0,2+3*a/360))) for a in range(0,361,45)}
 rocker_sweep={}
 for offset in [-2,-1.5,-.75,0,.75,1.5,2]:
  placed=screw.rotate((0,0,0),(0,0,1),360*offset/3).rotate((0,0,0),(0,1,0),90).translate((.35+offset,0,6))
  rocker_sweep[str(offset)]=overlap(rocker,placed)
 report={'revision':'thread-8x3-r7','trial_symmetric_difference_mm3':differences,'nut_sweep_intersection_mm3':nut_sweep,'rocker_sweep_intersection_mm3':rocker_sweep,'thread':{'major_mm':8,'pitch_mm':3,'radial_depth_mm':.8,'female_radial_clearance_mm':.3,'included_angle_degrees':90,'standard_ACME':False},'rocker_min_nominal_radial_wall_mm':1.8,'limitations':['Rocker fit, strength and loaded assembly remain physically unvalidated.','Adjustment sweep is off-phone clearance, not safe button travel.']}
 report['passed']=max([*differences.values(),*nut_sweep.values(),*rocker_sweep.values()])<.01
 (Path(__file__).resolve().parents[1]/'review/thread-promotion.json').write_text(json.dumps(report,indent=2)+'\n')
 print(json.dumps(report,indent=2)); assert report['passed']
if __name__=='__main__': main()

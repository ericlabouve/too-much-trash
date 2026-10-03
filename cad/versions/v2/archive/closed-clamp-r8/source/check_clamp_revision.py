"""Audit closed-clamp dimensions and bracket material removal against r7."""
from pathlib import Path
import importlib.util,sys,json
import build as b
import model as m
root=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('r7_reference',root/'archive/thread-8x3-r7/source/model.py')
old=importlib.util.module_from_spec(spec);sys.modules[spec.name]=old;spec.loader.exec_module(old)
def volume(s):return sum(v.Volume() for v in s.solids().vals())
def main():
 p=m.Parameters();new=m.parts(p);prior=old.parts(old.Parameters())
 unchanged={n:volume(new[n].cut(prior[n]))+volume(prior[n].cut(new[n])) for n in ('sliding_jaw','rocker','pivot_key','thumb_screw','thumb_nut','string_guide')}
 before=volume(prior['actuator_bracket']);after=volume(new['actuator_bracket'])
 # Windows are removals only. Mechanism features away from the plate stay identical.
 added=volume(new['actuator_bracket'].cut(prior['actuator_bracket']))
 protected=m.box(-50,41,-100,100,-100,100)
 mechanism_delta=volume(new['actuator_bracket'].intersect(protected).cut(prior['actuator_bracket']))+volume(prior['actuator_bracket'].intersect(protected).cut(new['actuator_bracket']))
 # Accepted opening is a fit target, not the inconsistent historical stock proxy.
 opening=m.box(-5.8,5.8,-8.8,8.8,-86,-12)
 passage={n:volume(new[n].intersect(opening)) for n in ('carrier','shaft_cap')}
 # Lateral removal of cap after unscrewing; carrier stays fixed.
 withdrawal={str(dx):volume(new['shaft_cap'].translate((0,dx,0)).intersect(new['carrier'])) for dx in (0,.5,1,2,4,8,16,30)}
 stock_hits={}
 for name,solid in m.stock(p).items():
  if not name.startswith('stock_') or name=='stock_neck':continue
  for part in ('carrier','shaft_cap'):
   v=volume(new[part].intersect(solid))
   if v>.01:stock_hits[part+'/'+name]=v
 report={'stock_nonshaft_intersections_mm3':stock_hits,'revision':'closed-clamp-r8','unchanged_parts_symmetric_difference_mm3':unchanged,'bracket':{'before_mm3':before,'after_mm3':after,'solid_volume_reduction_percent':100*(before-after)/before,'added_volume_mm3':added,'mechanism_feature_difference_mm3':mechanism_delta,'plate_thickness_mm':6,'rounded_window_corner_radius_mm':3,'minimum_window_to_slot_ligament_mm':4.6,'strength':'Unvalidated; material removal retains interfaces but may reduce stiffness.'},'shaft_clamp':{'nominal_opening_mm':[11.6,17.6],'length_mm':74,'split_gap_mm':1,'screw_station_separation_mm':54,'screws':2,'nuts':2,'nut_engagement_mm':6,'opening_intrusion_mm3':passage,'cap_withdrawal_carrier_intersections_mm3':withdrawal,'limitations':['Shaft proxy mismatch remains excluded. New long collar must be fitted physically.','Closed capture does not prove friction, strength, fatigue or printed fastener preload retention.']} }
 report['passed']=not stock_hits and max([*unchanged.values(),added,mechanism_delta,*passage.values(),*withdrawal.values()])<.01
 (root/'review/clamp-revision.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2));assert report['passed']
if __name__=='__main__':main()

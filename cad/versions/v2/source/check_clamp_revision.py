"""Audit closed-clamp dimensions and bracket material removal against r7."""
from pathlib import Path
import importlib.util,sys,json
import build as b
import model as m
root=Path(__file__).resolve().parents[1]
# Historical baseline is pinned in Git; no duplicate archived source tree required.
import subprocess,types
BASELINE_COMMIT='f8f11822459f5e140ed34d06caa46a720999467c'
BASELINE_PATH='cad/versions/v2/archive/thread-8x3-r7/source/model.py'
old=types.ModuleType('r7_reference');sys.modules[old.__name__]=old
# Historical model imports V1 proxies relative to source/model.py.
old.__file__=str(root/'source/model.py')
baseline_source=subprocess.check_output(['git','show',BASELINE_COMMIT+':'+BASELINE_PATH],cwd=root,text=True)
exec(compile(baseline_source,BASELINE_PATH,'exec'),old.__dict__)
def volume(s):return sum(v.Volume() for v in s.solids().vals())
def main():
 p=m.Parameters();new=m.parts(p);prior=old.parts(old.Parameters())
 unchanged={n:volume(new[n].cut(prior[n]))+volume(prior[n].cut(new[n])) for n in ('rocker','pivot_key','thumb_screw','thumb_nut','string_guide')}
 before=volume(prior['actuator_bracket']);after=volume(new['actuator_bracket'])
 # Added lower twine guide is intentional; protect the upper mechanism interfaces.
 added=volume(new['actuator_bracket'].cut(prior['actuator_bracket']))
 protected=m.box(-50,41,-100,100,0,100)
 mechanism_delta=volume(new['actuator_bracket'].intersect(protected).cut(prior['actuator_bracket']))+volume(prior['actuator_bracket'].intersect(protected).cut(new['actuator_bracket']))
 # Accepted opening is a fit target, not the inconsistent historical stock proxy.
 opening=m.box(-5.8,5.8,-8.8,8.8,m.CLAMP_BOTTOM,m.CLAMP_TOP)
 passage={n:volume(new[n].intersect(opening)) for n in ('carrier','shaft_cap')}
 # Lateral removal of cap after unscrewing; carrier stays fixed.
 path=[(i*.5,0,0) for i in range(81)]
 withdrawal={str(q):volume(new['shaft_cap'].translate(q).intersect(new['carrier'])) for q in path}
 # Shaft fit uses accepted opening; the historical larger stock proxy is not a fit datum.
 shaft=m.box(-5.8,5.8,-8.8,8.8,-90,100)
 withdrawal_shaft={str(q):volume(new['shaft_cap'].translate(q).intersect(shaft)) for q in path}
 carrier_path=[(-i*.5,0,0) for i in range(81)]
 carrier_release={str(q):volume(new['carrier'].translate(q).intersect(shaft)) for q in carrier_path}
 stock_hits={}
 for name,solid in m.stock(p).items():
  if not name.startswith('stock_') or name=='stock_neck':continue
  for part in ('carrier','shaft_cap'):
   v=volume(new[part].intersect(solid))
   if v>.01:stock_hits[part+'/'+name]=v
 report={'stock_nonshaft_intersections_mm3':stock_hits,'revision':'compact-rails-r12','unchanged_parts_symmetric_difference_mm3':unchanged,'bracket':{'before_mm3':before,'after_mm3':after,'solid_volume_reduction_percent':100*(before-after)/before,'added_volume_mm3':added,'mechanism_feature_difference_mm3':mechanism_delta,'plate_thickness_mm':6,'rounded_window_corner_radius_mm':3,'minimum_window_to_slot_ligament_mm':4.6,'strength':'Unvalidated; material removal retains interfaces but may reduce stiffness.'},'shaft_clamp':{'nominal_opening_mm':[11.6,17.6],'length_mm':102,'split_gap_mm':1,'screw_station_separation_mm':44,'screws':4,'nuts':4,'nut_engagement_mm':6,'opening_intrusion_mm3':passage,'minimum_cap_wall_mm':3.5,'carrier_webs':{'count':2,'thickness_mm':5,'connection_span_y_mm':27.6},'cap_withdrawal_path_mm':[[0,0,0],[40,0,0]],'carrier_withdrawal_path_mm':[[0,0,0],[-40,0,0]],'carrier_withdrawal_nominal_shaft_max_mm3':max(carrier_release.values()),'cap_withdrawal_carrier_max_mm3':max(withdrawal.values()),'cap_withdrawal_nominal_shaft_max_mm3':max(withdrawal_shaft.values()),'limitations':['Shaft proxy mismatch remains excluded. New long collar must be fitted physically.','Closed capture does not prove friction, strength, fatigue or printed fastener preload retention.']} }
 report['passed']=not stock_hits and max([*unchanged.values(),mechanism_delta,*passage.values(),*withdrawal.values(),*withdrawal_shaft.values(),*carrier_release.values()])<.01
 (root/'review/clamp-revision.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2));assert report['passed']
if __name__=='__main__':main()

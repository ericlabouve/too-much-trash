"""70-degree captured guide with underside TPU T/V stop; isolated review."""
from build_tail_handle import geometry,CAD
from build_travel_stops import inv,overlap
from plunger_design import box,cassette
from build import export
import cadquery as cq
import math,json,sys
from pathlib import Path

def prism(points,y0,y1):
 return cq.Workplane('XZ').polyline(points).close().extrude(y1-y0).translate((0,y1,0))
def geometry_stop():
 br,pl,_=geometry();old=pl
 slope=math.tan(math.radians(70));top=4.966-3.766/slope
 cavity=prism([(-4.966,3),(4.966,3),(top,6.766),(top,10),(-top,10),(-top,6.766)],13.35,41.4)
 br=br.cut(cavity).clean()
 # Retain base, foot and handle; broaden the shaft above its existing base.
 upper=4-3.2/slope
 pl=pl.union(prism([(-4,3.4),(4,3.4),(upper,6.6),(-upper,6.6)],13.35,41)).clean()
 # Remove the raised shoulder with a tangent cubic transition to the shaft top.
 # This stays inside the accepted envelope and leaves the contact face intact.
 blend_cut=(cq.Workplane('YZ').moveTo(10.0,7.4)
  .bezier([(11.2,7.4),(12.15,6.6),(13.35,6.6)],includeCurrent=True)
  .lineTo(13.35,20).lineTo(10.0,20).close().extrude(30,both=True))
 pl=pl.cut(blend_cut).clean()
 # Closed-ended through window; key's V runs along the slot, keeping its width narrow.
 pl=pl.cut(box(-1.8,1.8,15.35,35.0,3,8)).clean()
 br=br.cut(box(-1.7,1.7,18.3,21.7,-1,3.1)).clean()
 # Same T/V retention principle, shortened to the 3 mm actuator plate.
 key=box(-3.5,3.5,18.5,21.5,-1.2,0)
 key=key.union(box(-1.5,1.5,18.5,21.5,-.1,2.9)).union(box(-.5,.5,18.5,21.5,2.8,7.5))
 arm=prism([(-2.5,3.2),(-1.5,3.2),(.25,7.2),(0,7.5),(-.3,7.2)],18.5,21.5)
 key=key.union(arm).union(arm.mirror('YZ')).clean()
 key=key.rotate((0,20,0),(0,20,1),90)
 context={k:inv(v) for k,v in cassette().items() if k not in ['actuator_bracket','plunger']}
 return br,pl,key,context,old,upper,top

def build(out):
 out.mkdir(parents=True,exist_ok=True)
 br,pl,key,context,old,upper,top=geometry_stop()
 for n,s in {'bracket':br,'plunger':pl,'stop':key}.items():
  assert s.val().isValid() and len(s.val().Solids())==1,n
 rows=[]
 for i in range(107):
  d=i*.5;m=pl.translate((0,-d,0));rows.append({'pull_mm':d,'bracket':overlap(m,br),'context':sum(overlap(m,s) for s in context.values()),'stop':overlap(m,key)})
 assert max(max(r['bracket'],r['context']) for r in rows)<1e-5
 assert overlap(key,br)<1e-5 and overlap(key,pl)<1e-5
 assert sum(overlap(key,s) for s in context.values())<1e-5
 for n,s in {'bracket':br,'plunger':pl,'stop':key,'previous-plunger':old,**context}.items(): export(s,out/(n+'.stl'))
 report={'revision':'v4-steep-stop-slot-to-handle','neck_foot_transition_length_mm':3.35,'neck_foot_transition_drop_mm':0.8,'key_rotation_deg':90,'slot_width_mm':3.6,'angle_from_bed_deg':70,'shaft_top_width_before_mm':1.6,'shaft_top_width_after_mm':2*upper,'guide_top_opening_mm':2*top,'slot_y_limits_mm':[15.35,35.0],'slot_length_mm':19.65,'foot_end_ligament_mm':2.0,'handle_end_ligament_mm':0.0,'stop_free_pull_mm':12.6,'stop_key':'Custom shortened TPU T/V key, not interchangeable with axle key','checks':rows,'limits':['TPU V arms intentionally flex through the plate opening; insertion force and retention untested.','12.6 mm is an escape limit, not a measured safe button stroke.','Key is installed after plunger; plate underside needs physical access.','Consult the separate support-status record for the exact sliced revision.']}
 (out/'fit-attachment-check.json').write_text(json.dumps(report,indent=2));print(report['shaft_top_width_after_mm'])
if __name__=='__main__':build(Path(sys.argv[1]))

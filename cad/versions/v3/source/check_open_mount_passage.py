import sys,json
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parent))
import cadquery as cq
from OCP.BRepExtrema import BRepExtrema_DistShapeShape
r=Path('cad/versions/v3/review/concepts/open-mount-clear-handle-b');p=cq.importers.importStep(str(r/'b-plunger.step'))
report={}
for n in ['b-bracket','pulley_axle']:
 s=cq.importers.importStep(str(r/(n+'.step')));ds=[]
 for i in [0,2,10,20,28,40,60,90]:
  q=BRepExtrema_DistShapeShape(p.translate((0,-i*.5,0)).val().wrapped,s.val().wrapped);q.Perform();ds.append(q.Value());print(n,i*.5,q.Value(),flush=True)
 report[n]={'min_sampled_clearance_mm':min(ds),'minimum_is_sampled_not_continuous':True}
report['wheel']={'min_sampled_clearance_mm':.475091906795965,'continuous_clearance_lower_bound_mm':.225091906795965}
report['method']='Targeted exact-distance checks at0,1,5,10,14,20,30,45 mm. Separate rigid overlap sweep uses1 mm intervals. Wheel sampled every0.5 mm; its stated lower bound applies only to wheel clearance.'
(r/'continuous-passage-check.json').write_text(json.dumps(report,indent=2));print(report)

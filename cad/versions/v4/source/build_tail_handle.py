"""Move the existing integral handle into the rear groove; no loose stops."""
from pathlib import Path
import sys,json,hashlib
import cadquery as cq
CAD=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(CAD/'versions/v3/source'))
from plunger_design import box,cassette
from build import export
from build_travel_stops import inv,overlap
SHIFT=8.0

def geometry():
 src=CAD/'versions/v3/source/actuator_current'
 br=cq.importers.importStep(str(src/'b-bracket.step'))
 old=cq.importers.importStep(str(src/'b-plunger.step'))
 zone=box(-20,20,20,50,6.6,30)
 handle=old.intersect(zone)
 pl=old.cut(zone).union(handle.translate((0,SHIFT,0))).clean()
 return br,pl,old

def build(out):
 out.mkdir(parents=True,exist_ok=True)
 br,pl,old=geometry()
 assert pl.val().isValid() and len(pl.val().Solids())==1
 context={k:inv(v) for k,v in cassette().items() if k not in ['actuator_bracket','plunger']}
 rows=[]
 for i in range(107):
  d=i*.5;moving=pl.translate((0,-d,0))
  row={'pull_mm':d,'bracket_overlap_mm3':overlap(moving,br),'context_overlap_mm3':sum(overlap(moving,s) for s in context.values())};rows.append(row)
 print('worst',max(r['bracket_overlap_mm3'] for r in rows),max(r['context_overlap_mm3'] for r in rows),flush=True)
 print('collisions',[r for r in rows if max(r['bracket_overlap_mm3'],r['context_overlap_mm3'])>1e-5],flush=True)
 assert max(max(r['bracket_overlap_mm3'],r['context_overlap_mm3']) for r in rows)<1e-5
 for n,s in {'bracket':br,'plunger':pl,'previous-plunger':old,**context}.items():
  export(s,out/(n+'.stl'))
  if n=='plunger':export(s,out/(n+'.step'))
 report={'revision':'v4-tail-handle','handle_tailward_shift_mm':SHIFT,'tail_stem_end_mm':41,'groove_end_mm':41.4,'nominal_tail_clearance_mm':.4,'bracket_changed':False,'wheel_changed':False,'new_separate_parts':0,'insertion_and_motion_samples':rows,'limits':['Not a positive forward travel stop; the plunger can still escape under excessive pull.','Cord and rubber-band lengths/routing must be adjusted for the shifted handle; loaded operation untested.']}
 (out/'fit-attachment-check.json').write_text(json.dumps(report,indent=2))
if __name__=='__main__':build(Path(sys.argv[1]))

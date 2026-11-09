"""Isolated removable travel-stop concepts. Does not modify official V4."""
from pathlib import Path
import sys,json,hashlib
import cadquery as cq
CAD=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(CAD/'versions/v3/source'))
from plunger_design import box,cassette
from build import export

def inv(s):
 return s.translate((-8.35,-5.4,-8)).rotate((0,0,0),(1,0,0),-90).rotate((0,0,0),(0,0,1),90)
def overlap(a,b):
 return a.intersect(b).val().Volume()
def build(out):
 out.mkdir(parents=True,exist_ok=True)
 src=CAD/'versions/v3/source/actuator_current'
 b=cq.importers.importStep(str(src/'b-bracket.step'));p=cq.importers.importStep(str(src/'b-plunger.step'))
 context={k:inv(v) for k,v in cassette().items() if k not in ['actuator_bracket','plunger']}
 # A: a closed-ended through slot in the slider, with a removable seated pin.
 slot=box(-1.2,1.2,19,25.8,2,18)
 for y in [19,25.8]:slot=slot.union(cq.Workplane('XY').center(0,y).circle(1.2).extrude(20))
 pa=p.cut(slot).clean()
 ba=b.cut(cq.Workplane('XY').center(0,20).circle(1.0).extrude(3.1)).clean()
 pin=cq.Workplane('XY').center(0,20).circle(1).extrude(5.8)
 pin=pin.union(cq.Workplane('XY').workplane(offset=-1.5).center(0,20).circle(2.2).extrude(1.5)).clean()
 # B: single-sided removable gate, outside the string/band lane.
 # Rectangular socket prevents rotation; gate prints on its broad crossbar.
 bb=b.cut(box(2.75,4.65,23.8,26,6.5,8.3)).clean()
 gate=box(-1.1,4.5,24,25.8,8.2,9.8).union(box(2.9,4.5,24,25.8,6.6,8.3)).clean()
 variants={'a':(ba,pa,pin),'b':(bb,p,gate)}
 report={'revision':'v4-travel-stop-concepts','official_design_changed':False,'concepts':{},'limits':['Removable-stop retention is provisional; printed fit and repeated pull tests are required.','The approximately 6 mm escape limit is illustrative, not a safe volume-button stroke.','Stops are inserted after the plunger; remove them before servicing.'],'source_sha256':{n:hashlib.sha256((src/(n+'.step')).read_bytes()).hexdigest() for n in ['b-bracket','b-plunger']}}
 for k,(br,pl,stop) in variants.items():
  for name,s in [('bracket',br),('plunger',pl),('stop',stop)]:
   assert s.val().isValid() and len(s.val().Solids())==1,(k,name)
   export(s,out/f'{k}-{name}.stl')
  insertion=[{'travel':d,'overlap':overlap(pl.translate((0,-d,0)),br)} for d in range(46)]
  assert max(r['overlap'] for r in insertion)<1e-5
  motion=[]
  for i in range(81):
   d=i*.1; motion.append({'travel':round(d,2),'stop_overlap':overlap(pl.translate((0,-d,0)),stop)})
  hit=next(r['travel'] for r in motion if r['stop_overlap']>1e-5)
  contexts={n:overlap(stop,s) for n,s in context.items()}
  assert max(contexts.values())<1e-5,contexts
  assert overlap(br,stop)<1e-5,(k,overlap(br,stop))
  installation=[]
  for lift in range(19):
   moved=stop.translate((0,0,-lift if k=='a' else lift))
   installation.append({'lift_mm':lift,'bracket_overlap':overlap(moved,br),'plunger_overlap':overlap(moved,pl),'context_overlap':sum(overlap(moved,c) for c in context.values())})
  assert max(max(r['bracket_overlap'],r['plunger_overlap'],r['context_overlap']) for r in installation)<1e-5,(k,[r for r in installation if max(r['bracket_overlap'],r['plunger_overlap'],r['context_overlap'])>1e-5])
  report['concepts'][k]={'first_sampled_stop_contact_mm':hit,'stop_installation':installation,'insertion_without_stop':insertion,'stop_motion':motion,'stop_context_intersections_mm3':contexts,'stop_bracket_overlap_mm3':overlap(br,stop)}
 for n,s in context.items():export(s,out/(n+'.stl'))
 (out/'fit-attachment-check.json').write_text(json.dumps(report,indent=2))
 print(json.dumps({k:v['first_sampled_stop_contact_mm'] for k,v in report['concepts'].items()}),flush=True)
if __name__=='__main__':build(Path(sys.argv[1]))

"""Matched PETG guide/plunger and TPU stop support screens."""
import sys,json
from pathlib import Path
CAD=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(CAD/'versions/v3/source'))
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
out=Path(sys.argv[1]).resolve();source=Path(sys.argv[2]).resolve();mode=sys.argv[3]
plate.ROOT=CAD;plate.SOURCE=source
plate.PRIOR=CAD/('versions/v3/print/jobs/2026-10-26-compact-petg' if mode=='petg' else 'versions/v3/print/jobs/2026-10-24-three-cuffs-thread-tpu')
plate.PARTS=({'bracket':((65,80),'Z',0,'Flat actuator base down'),'plunger':((110,80),'Z',0,'Plunger broad base down')} if mode=='petg' else {'stop':((90,90),'Z',0,'Unchanged original axle key broad face down')})
sys.argv=['slice','--output-dir',str(out)]
plate.main(process_overrides={'bridge_no_support':'0','enable_support':'1'})
review.OUT=out
review.main(project_stem='cuff-fit',title='V4 common moving stop key · '+mode,detail_parts=list(plate.PARTS),notes=['Automatic supports ON, bridge suppression OFF.','No print sent. Physical fit and retention untested.'])
r=json.loads((out/'review.json').read_text());print(r['objects'])
assert all(not v for o in r['objects'].values() for k,v in o['deposited_g_by_role'].items() if k in ('support','interface'))

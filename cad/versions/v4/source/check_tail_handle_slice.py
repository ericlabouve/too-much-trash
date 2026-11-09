"""Offline support check for the tail-positioned plunger."""
import sys,json
from pathlib import Path
CAD=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(CAD/'versions/v3/source'))
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
out=Path(sys.argv[1]).resolve();source=Path(sys.argv[2]).resolve()
plate.ROOT=CAD;plate.SOURCE=source
plate.PRIOR=CAD/'versions/v3/print/jobs/2026-10-26-compact-petg'
plate.PARTS={'plunger':((90,90),'Z',0,'Original triangular shaft base down; integral handle at tail')}
sys.argv=['slice','--output-dir',str(out)]
plate.main(process_overrides={'bridge_no_support':'0'})
review.OUT=out
review.main(project_stem='cuff-fit',title='V4 tail handle · PETG support check',detail_parts=['plunger'],notes=['Automatic supports ON; bridge suppression OFF.','No print sent. Handle relocation only; forward travel stop remains unresolved.'])
r=json.loads((out/'review.json').read_text());print(r['objects'])
assert all(not v for o in r['objects'].values() for k,v in o['deposited_g_by_role'].items() if k in ('support','interface'))

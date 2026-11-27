"""Offline automatic-support screen for removable stop studies; no printer access."""
import sys,json
from pathlib import Path
CAD=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(CAD/'versions/v3/source'))
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
out=Path(sys.argv[1]).resolve(); source=Path(sys.argv[2]).resolve()
plate.ROOT=CAD;plate.SOURCE=source
plate.PRIOR=CAD/'versions/v3/print/jobs/2026-10-26-compact-petg'
plate.PARTS={
 'a-bracket':((45,55),'Z',0,'Flat spine on bed'),
 'a-plunger':((80,55),'Z',0,'Triangular shaft base on bed; slot is through-open'),
 'a-stop':((100,55),'Z',0,'Round head on bed; pin upright'),
 'b-bracket':((45,115),'Z',0,'Flat spine on bed; gate pocket opens upward'),
 'b-plunger':((80,115),'Z',0,'Unchanged triangular shaft base on bed'),
 'b-stop':((110,115),'X',180,'Crossbar on bed; short locating leg upright')}
sys.argv=['slice','--output-dir',str(out)]
plate.main(process_overrides={'bridge_no_support':'0'})
review.OUT=out
review.main(project_stem='cuff-fit',title='V4 removable travel stops · support screen',detail_parts=list(plate.PARTS),notes=['Two independent concepts, not a production plate.','A1 mini 0.4 mm nozzle, PETG 0.12 mm layers; automatic supports ON, bridge suppression OFF.','No print requested. Stop retention and button-safe stroke remain untested.'])
r=json.loads((out/'review.json').read_text())
print(json.dumps(r.get('objects',{}),indent=2))

import json
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
plate.SOURCE=plate.ROOT/'review/concepts/plug-clip'
plate.PRIOR=plate.ROOT/'print/jobs/2026-10-26-material-tpu'
plate.PARTS={'clip':((90,90),'Z',0,'Flat 6 mm extrusion; closure open on bed.')}
saved=json.loads((plate.PRIOR/'process.json').read_text())
plate.main(process_overrides={k:v for k,v in saved.items() if 'speed' in k or 'acceleration' in k},material_status='ELEGOO TPU95A recipe; slice only, no print requested.')
review.OUT=plate.common.OUT
review.main(project_stem='cuff-fit',title='Smaller TPU plug clip',detail_parts=['clip'],notes=['Automatic supports enabled. Flat open clip; socket passes through thickness.','Unprinted fit and flexible closure; user declined a print now.'])

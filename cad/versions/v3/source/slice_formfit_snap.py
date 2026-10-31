import json
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
plate.SOURCE=plate.ROOT/'review/concepts/formfit-square-clip'
plate.PRIOR=plate.ROOT/'print/jobs/2026-10-26-material-tpu'
plate.PARTS={'clip':((90,90),'Z',0,'C body flat; local closure ends on bed, vertical square hole and stud.')}
saved=json.loads((plate.PRIOR/'process.json').read_text())
plate.main(process_overrides={k:v for k,v in saved.items() if 'speed' in k or 'acceleration' in k},material_status='ELEGOO TPU95A saved recipe; offline slice only. No print.')
review.OUT=plate.common.OUT
review.main(project_stem='cuff-fit',title='Square press-stud TPU clip',detail_parts=['clip'],notes=['Automatic supports enabled; form-fitting body, local square snap ends on bed.','New closure unprinted. User explicitly requests no print.'])

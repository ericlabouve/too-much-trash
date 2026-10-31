import json
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
plate.SOURCE=plate.ROOT/'review/concepts/closure-pair'
plate.PRIOR=plate.ROOT/'print/jobs/2026-10-26-material-tpu'
plate.PARTS={'option-a':((90,70),'Z',0,'Developed strap broad face on bed; vertical square hole and peg.'),'option-b':((90,100),'Z',0,'Developed strap broad face on bed; short sleeve with sloping internal roof.')}
saved=json.loads((plate.PRIOR/'process.json').read_text())
plate.main(process_overrides={**{k:v for k,v in saved.items() if 'speed' in k or 'acceleration' in k},'bridge_no_support':'0'},material_status='Saved ELEGOO TPU95A recipe. Offline only; no print.')
review.OUT=plate.common.OUT
review.main(project_stem='cuff-fit',title='Bend-only TPU closure options',detail_parts=['option-a','option-b'],notes=['Automatic supports enabled. Both straps bend around the neck without twisting.','Closure force, fit and retention untested. No print.'])

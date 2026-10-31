import json
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
plate.SOURCE=plate.ROOT/'review/concepts/clip-roof-only'
plate.PRIOR=plate.ROOT/'print/jobs/2026-10-26-material-tpu'
plate.PARTS={'roof-45':((65,90),'Z',0,'Unchanged original print orientation;45 degree hole roof.'),'roof-35':((110,90),'Z',0,'Unchanged original print orientation;35 degree hole roof.')}
saved=json.loads((plate.PRIOR/'process.json').read_text())
plate.main(process_overrides={**{k:v for k,v in saved.items() if 'speed' in k or 'acceleration' in k},'bridge_no_support':'0'},material_status='Offline TPU study; no print.')
review.OUT=plate.common.OUT
review.main(project_stem='cuff-fit',title='Local clip roof angles',detail_parts=['roof-45','roof-35'],notes=['Original arms and body unchanged. Only hole roof peak changed; stud unchanged to isolate support behavior.','Automatic supports enabled; no print.'])

"""PETG axle-only review, automatic supports enabled for an honest audit."""
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
plate.SOURCE=plate.ROOT/'review/concepts/diamond-axle'
plate.PRIOR=plate.ROOT/'print/jobs/2026-10-26-flush-fins-petg'
plate.PARTS={'pulley_axle':((90,90),'Z',0,'Head flat on bed; diamond roof 45 degrees.')}
plate.main()
review.OUT=plate.common.OUT
review.main(project_stem='cuff-fit',title='PETG smooth axle · diamond opening',detail_parts=['pulley_axle'],notes=['Existing TPU key reused, turned 45 degrees about insertion axis.','Automatic normal supports enabled; check actual generated paths.','Physical roof quality and key retention remain unverified. Preview only; not sent to printer.'])

import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
plate.SOURCE=plate.ROOT/'review/concepts/rail-saddle-b'
plate.PRIOR=plate.ROOT/'print/jobs/2026-10-26-compact-petg'
plate.PARTS={'b-bracket':((60,80),'Z',0,'Existing flat spine down; triangular guide apex open.'),'b-plunger':((110,80),'Z',0,'Foot and broad triangle base share the bed plane; existing cleat ramps upward.')}
plate.main(process_overrides={'bridge_no_support':'0'},material_status='Offline Bambu PETG Translucent recipe; no print.')
review.OUT=plate.common.OUT
review.main(project_stem='cuff-fit',title='Option B — single-bolt anti-rotation saddle',detail_parts=list(plate.PARTS),notes=['Automatic supports enabled; bridge suppression off.','Integral cheeks engage unchanged cap rail; one bolt. No print.'])

"""Offline support audit of changed bracket, plunger and extended axle."""
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
plate.SOURCE=plate.ROOT/'review/concepts/aligned-pulley-b'
plate.PRIOR=plate.ROOT/'print/jobs/2026-10-26-compact-petg'
plate.PARTS={'b-bracket':((55,80),'Z',0,'Flat spine down; open triangular guide.'),'b-plunger':((105,80),'Z',0,'Broad triangle base down; trimmed cleat ramps upward.'),'pulley_axle':((130,80),'X',180,'Axle head down; unchanged diamond roof, extended smooth shaft.')}
plate.main(process_overrides={'bridge_no_support':'0'},material_status='Offline Bambu PETG Translucent recipe; no print.')
review.OUT=plate.common.OUT
review.main(project_stem='cuff-fit',title='Aligned pulley B — bracket, plunger and axle',detail_parts=list(plate.PARTS),notes=['Automatic supports ON, bridge suppression OFF.','Existing pulley and TPU key are reused. No print sent.'])

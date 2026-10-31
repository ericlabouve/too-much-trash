import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
plate.SOURCE=plate.ROOT/'review/concepts/lower-lip-handle-b'
plate.PRIOR=plate.ROOT/'print/jobs/2026-10-26-compact-petg'
plate.PARTS={'b-bracket':((55,80),'Z',0,'Flat spine down; open rear strip and flat-backed lips.'),'b-plunger':((105,80),'Z',0,'Broad triangle base down; lower retaining ledge with sloped underside.'),'pulley_axle':((130,80),'X',180,'Head down; unchanged diamond roof, extended shaft.')}
plate.main(process_overrides={'bridge_no_support':'0'},material_status='Offline PETG recipe; no print requested.')
review.OUT=plate.common.OUT
review.main(project_stem='cuff-fit',title='Lower handle retaining lip — PETG',detail_parts=list(plate.PARTS),notes=['Automatic supports ON; bridge suppression OFF.','Insert plunger before fitting rubber band and string. No print sent.'])

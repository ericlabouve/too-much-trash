import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
plate.SOURCE=plate.ROOT/'review/concepts/triangle-tail'
plate.PRIOR=plate.ROOT/'print/jobs/2026-10-26-compact-petg'
plate.PARTS={
 'b-bracket':((50,75),'Z',0,'Flat existing spine on bed; guide apex open.'),
 'b-plunger':((110,65),'X',90,'Foot-first end orientation.'),
 'tail-first':((140,65),'X',-90,'Tail-first comparison; same plunger geometry.')}
plate.main(process_overrides={'bridge_no_support':'0'},material_status='Offline Bambu PETG Translucent recipe; no print.')
review.OUT=plate.common.OUT
review.main(project_stem='cuff-fit',title='Option B integrated actuator — support inspection',detail_parts=list(plate.PARTS),notes=['Automatic supports enabled; bridge suppression off.','Plunger appears twice to compare orientations; no printer contacted.'])

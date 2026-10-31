"""Complete four-piece rigid actuator plate; TPU hardware reused."""
import json
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
plate.SOURCE=plate.ROOT/'review/concepts/braced-tail-b'
plate.PRIOR=plate.ROOT/'print/jobs/2026-10-26-compact-petg'
plate.PARTS={
 'b-bracket':((65,85),'Z',0,'Flat spine on bed; open triangular guide upright.'),
 'b-plunger':((110,85),'Z',0,'Broad triangular shaft base on bed; curved foot and rounded handle.'),
 'pulley_axle':((137,76),'X',180,'Head down; extended shaft and diamond key passage.'),
 'pulley':((137,101),'Z',0,'Flat hub face down; axle axis vertical; sloped groove.')}
plate.main(process_overrides={'bridge_no_support':'0'},material_status='Bambu PETG Translucent Blue recipe; readiness must be verified before sending.')
review.OUT=plate.common.OUT
selected=[p['name'] for p in json.loads((review.OUT/'inputs.json').read_text())['parts']]
review.main(project_stem='cuff-fit',title='PETG actuator — '+str(len(selected))+' pieces',detail_parts=selected,notes=['Automatic supports ON; bridge suppression OFF.','Print selected changed parts. Reuse existing redirect pulley when omitted; axle is 2.05 mm longer than printed diamond axle. Reuse TPU screw, nut and key.','Insert plunger before fitting rubber band and string. No print sent.'])

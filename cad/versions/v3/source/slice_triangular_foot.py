import prepare_cuff_fit_plate as plate
import review_actuator_plate as review
plate.SOURCE=plate.ROOT/'review/concepts/triangular-foot'
plate.PRIOR=plate.ROOT/'print/jobs/2026-10-26-compact-petg'
plate.PARTS={f'{v}-{p}':((x,y),'X',90,'Longitudinal axis vertical, standing on end face; foot-first plunger.') for v,x in [('b',65),('c',115)] for p,y in [('guide',65),('plunger',110)]}
plate.main(process_overrides={'bridge_no_support':'0'},material_status='Offline Bambu PETG Translucent recipe; no print.')
review.OUT=plate.common.OUT
review.main(project_stem='cuff-fit',title='Curved-foot triangular plunger studies',detail_parts=list(plate.PARTS),notes=['Guide/plunger studies only, not complete mounting brackets.','Exact contact foot retained; automatic supports enabled; no print.'])

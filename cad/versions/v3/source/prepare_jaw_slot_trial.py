"""Matched two-jaw PETG baseline/candidate slices. No printer contact."""
import sys,json,hashlib
from pathlib import Path
import cadquery as cq
import model as m
from jaw_arm_slots import refine
import prepare_cuff_fit_plate as plate

candidate='--candidate' in sys.argv
if candidate:sys.argv.remove('--candidate')
out=Path(sys.argv[sys.argv.index('--output-dir')+1]).resolve()
assert not (out/'cuff-fit.gcode.3mf').exists()
source=out.parent/(out.name+'-source');source.mkdir(exist_ok='--resume-unsliced' in sys.argv)
records={}
for name,shape,angle in [('carrier',m.carrier(m.Parameters(),arm_slots=False),90),('sliding_jaw',m.sliding_jaw(m.Parameters(),arm_slots=False,continuous_beam=False),-90)]:
    before=shape
    if candidate:shape=refine(shape,name)
    assert shape.val().isValid() and len(shape.val().Solids())==1
    records[name]={'before_mm3':before.val().Volume(),'after_mm3':shape.val().Volume(),'valid':True,'solid_count':1}
    # Pre-rotate CAD to the exact approved bed orientation. Adapter centers it.
    shape=shape.rotate((0,0,0),(0,1,0),angle)
    if name=='sliding_jaw':shape=shape.rotate((0,0,0),(0,0,1),90)
    cq.exporters.export(shape,str(source/(name+'.stl')),tolerance=.015,angularTolerance=.1)
    cq.exporters.export(shape,str(source/(name+'.step')))
report={'revision':'jaw-arm-slot-candidate' if candidate else 'through-window-fixed-jaw-v3',
 'candidate':candidate,'parts':records,'roof_angle_from_bed_degrees':35,
 'source_sha256':{n:hashlib.sha256(Path(__file__).with_name(n).read_bytes()).hexdigest() for n in ('model.py','jaw_arm_slots.py')},
 'limits':['Slice comparison only. Not strength or retention validation.','Current printer and loaded spool not queried.']}
(source/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
plate.SOURCE=source
plate.PARTS={'carrier':((90,45),'Z',0,'Approved collar face down, arms upright; CAD Y+90.'),
 'sliding_jaw':((90,125),'Z',0,'Approved crossbar back down, tongue upright; CAD Y-90 then bed Z+90.')}
plate.main()
inputs=json.loads((out/'inputs.json').read_text());inputs['scope']='Two complete jaws; matched arm-slot comparison, approved orientations.'
(out/'inputs.json').write_text(json.dumps(inputs,indent=2)+'\n')
import review_actuator_plate as review
review.OUT=out
review.main(project_stem='cuff-fit',title='Jaw arm slots — '+('candidate' if candidate else 'baseline'),detail_parts=['carrier','sliding_jaw'],notes=[
 'Exact approved orientations; A1 mini0.4 / Bambu PETG Translucent /0.12 mm /Normal Snug automatic supports.',
 'Candidate has 6 mm-wide through-slots with 35-degree roofs.' if candidate else 'Current jaws without new arm/tongue slots.',
 'No printer contacted. Physical ramp quality, sliding fit and strength remain unverified.'])

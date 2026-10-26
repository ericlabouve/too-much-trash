"""Offline PETG preview of the reversible continuous sliding beam."""
import hashlib,json,sys
from pathlib import Path
import cadquery as cq
import build as b
import prepare_cuff_fit_plate as plate

out=Path(sys.argv[sys.argv.index('--output-dir')+1]).resolve()
source=out.parent/(out.name+'-source')
source.mkdir(exist_ok='--resume-unsliced' in sys.argv)
flush='--flush-beam' in sys.argv
if flush:sys.argv.remove('--flush-beam')
shape=b.sliding_jaw(b.Parameters(),flush_beam=flush)
assert shape.val().isValid() and len(shape.val().Solids())==1
shape=shape.rotate((0,0,0),(0,1,0),-90)
for ext in ('stl','step'):
    cq.exporters.export(shape,str(source/('sliding_jaw.'+ext)),**({'tolerance':.015,'angularTolerance':.1} if ext=='stl' else {}))
report=json.loads((b.ROOT/('review/flush-beam.json' if flush else 'review/continuous-beam.json')).read_text())
report['source_sha256']={n:hashlib.sha256(Path(__file__).with_name(n).read_bytes()).hexdigest() for n in ('model.py','cuff_design.py','jaw_support_angles.py','jaw_arm_slots.py')}
(source/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
plate.SOURCE=source
plate.PARTS={'sliding_jaw':((90,90),'Z',0,('Flush beam/root X-10 down' if flush else 'Continuous beam rear X-15.2 down')+'; CAD Y-90, tongue upright.')}
plate.main()
inputs=json.loads((out/'inputs.json').read_text())
inputs['scope']='One complete continuous-beam sliding jaw; PETG support review only.'
(out/'inputs.json').write_text(json.dumps(inputs,indent=2)+'\n')
import review_actuator_plate as review
review.OUT=out
review.main(project_stem='cuff-fit',title=('Flush-beam' if flush else 'Continuous-beam')+' sliding jaw · PETG support review',detail_parts=['sliding_jaw'],notes=[
 'One complete jaw. Beam rear face down; tongue upright. No automatic reorientation.',
 'A1 mini0.4 / Bambu PETG Translucent /0.12 mm /Normal Snug automatic supports enabled.',
 'Blue scaffold and purple interface are actual G-code paths. Inspect contacts under the raised tongue root/cleat and remove residue from sliding faces.',
 'Review only; printer not contacted. Physical strength, ramp quality and cuff retention unverified.'])

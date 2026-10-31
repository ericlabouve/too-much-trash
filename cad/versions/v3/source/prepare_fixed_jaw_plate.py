"""Slice the current bed-oriented fixed jaw in PETG; no printer contact."""
import hashlib
import json
import shutil
import sys
from pathlib import Path
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review

out = Path(sys.argv[sys.argv.index('--output-dir') + 1]).resolve()
source = out.parent / (out.name + '-source')
source.mkdir(exist_ok='--resume-unsliced' in sys.argv)
manifest = json.loads((plate.ROOT / 'print/manifest.json').read_text())
part = next(p for p in manifest['parts'] if p['name'] == 'carrier')
assert part['watertight'] and abs(part['bed_z_min_mm']) < .001
for ext in ('stl', 'step'):
    shutil.copy2(plate.ROOT / 'print' / ('carrier.' + ext), source / ('carrier.' + ext))
report = {'revision': manifest['revision'], 'part': part,
          'source_sha256': {n: hashlib.sha256(Path(__file__).with_name(n).read_bytes()).hexdigest()
                            for n in ('model.py', 'jaw_arm_slots.py', 'jaw_support_angles.py')},
          'limits': ['Slice only; physical fit, strength and 35-degree roof quality unverified.']}
(source / 'fit-attachment-check.json').write_text(json.dumps(report, indent=2) + '\n')
plate.SOURCE = source
plate.PARTS = {'carrier': ((90, 90), 'Z', 0,
                         'Approved CAD Y+90 export; collar face down, track upright.')}
plate.main()
inputs = json.loads((out / 'inputs.json').read_text())
inputs['scope'] = 'One complete current fixed jaw; PETG automatic-support measurement only.'
(out / 'inputs.json').write_text(json.dumps(inputs, indent=2) + '\n')
review.OUT = out
review.main(project_stem='cuff-fit', title='Fixed jaw · PETG support review', detail_parts=['carrier'], notes=[
    'Current fixed jaw, approved collar-face-down orientation; track upright. Scale 100%.',
    'A1 mini 0.4 / Bambu PETG Translucent / 0.12 mm / 3 walls / 15% gyroid; Normal Snug automatic supports.',
    'Blue scaffold and purple interface show actual extrusion. Inspect cleanup access and residue on mating faces.',
    'No printer contacted. Physical strength, sliding fit and support-free 35-degree roof quality remain unverified.'])

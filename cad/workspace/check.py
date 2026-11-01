"""Run the active V2/V3 build's geometry checks without exporting meshes."""
from dataclasses import replace
from pathlib import Path
import json
import sys
import build

version = sys.argv[1]
solids = build.parts(build.Parameters())
report = {'version': version, 'solids': {}, 'configurations': {},
          'limitations': ['Sampled geometry only; physical fit, strength, force and camera framing are not established.']}
for name, solid in solids.items():
    info = {'valid': solid.val().isValid(), 'solid_count': len(solid.val().Solids())}
    report['solids'][name] = info
    if not info['valid'] or info['solid_count'] != 1:
        raise SystemExit(f'Invalid solid: {name}: {info}')
for name, base in build.SAMPLES.items():
    for side in ('near', 'far'):
        key = f'{name}-{side}'
        report['configurations'][key] = build.check(replace(base, side=side), solids)
        print(key, json.dumps(report['configurations'][key]), flush=True)
report['checks_passed'] = all(x['passed'] for x in report['configurations'].values())
report['mechanical_passed'] = (all(x['mechanical_passed'] for x in report['configurations'].values())
                               if version == 'v3' else report['checks_passed'])
out = Path(__file__).resolve().parents[1] / 'review' / 'workspace-validation.json'
out.write_text(json.dumps(report, indent=2) + '\n')
if not report['mechanical_passed']:
    raise SystemExit(f'Mechanical interference; see {out}')
if not report['checks_passed']:
    print(f'Phone fit conflicts remain; see {out}', flush=True)
print(f'Geometric checks complete: {out}', flush=True)

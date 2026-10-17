"""Compare the new review-only plate to the exact user-printed bridge plate."""
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT.parents[1]))
from slice_review import write_page

old = ROOT / 'print/jobs/2026-10-14-actuator-bridge'
new = ROOT / 'print/jobs/2026-10-14-actuator-post-print'
read = lambda p, name: json.loads((p / name).read_text())
a, b = read(old, 'review.json'), read(new, 'review.json')
ai, bi = read(old, 'inputs.json'), read(new, 'inputs.json')
for filename in ('machine.json', 'process.json', 'filament.json'):
    assert read(old, filename) == read(new, filename), filename
by_name = lambda rows: {r['name']: {k:v for k,v in r.items() if k != 'id'} for r in rows}
assert by_name(a['effective_object_settings']) == by_name(b['effective_object_settings'])
assert by_name(ai['object_settings']) == by_name(bi['object_settings'])
assert ai['scale_percent'] == bi['scale_percent'] == 100
for x, y in zip(ai['parts'], bi['parts']):
    assert x['name'] == y['name'] and x['center_xy_mm'] == y['center_xy_mm']
support = lambda r: sum(r['deposited_g_by_role'].get(k, 0) for k in ('support', 'interface'))
before, after = support(a), support(b)
warning = ('REVIEW ONLY: the lifted pulley causes outgoing-twine/carrier interference in wallet-near, '
           'bare-near and small-near. Resolve routing before another print. Single-bearing axle strength '
           'and free rotation need physical checking. No printer was contacted.')
report = dict(baseline_revision=a['revision'], revision=b['revision'],
              matched_profiles_placement_scale_and_overrides=True,
              support_before_g=before, support_after_g=after,
              support_reduction_percent=100*(1-after/before),
              total_before_g=a['total_g'], total_after_g=b['total_g'],
              minutes_before=a['total_minutes'], minutes_after=b['total_minutes'],
              support_by_part={n:dict(before_g=support(a['objects'][n]),after_g=support(b['objects'][n])) for n in b['objects']},
              limits=[warning, 'Seven-piece comparison is not a request to reprint approved unchanged parts.'])
(new / 'comparison.json').write_text(json.dumps(report, indent=2)+'\n')
write_page(new, title='V3 post-print refinements · comparison slice', subtitle='Seven pieces · review only · not sent',
           notes=[warning, f'Same recipe: support/interface {before:.3f} → {after:.3f} g ({100*(1-after/before):.1f}% less). Only bracket and plunger designs changed; wheel assembly position moved.'],
           links=[dict(label='Matched comparison',href='comparison.json'),
                  dict(label='Preserved printed plate',href='../2026-10-14-actuator-bridge/'),
                  dict(label='Support projections',href='support-details.png'),
                  dict(label='Sliced comparison project — not approved to print',href='actuator.gcode.3mf'),
                  dict(label='Source hashes and settings',href='inputs.json')])
(new / 'README.md').write_text('# Post-print actuator review slice\n\n'+warning+'\n\n'
    +f'Support/interface {before:.4f} → {after:.4f} g; total {a["total_g"]:.2f} → {b["total_g"]:.2f} g. '
    +f'Estimated duration {b["total_minutes"]:.1f} min. All remaining support is on the bracket. '
    +'The seven pieces retain the baseline recipe, positions, scale and per-object settings. '
    +'Only bracket/plunger need consideration for later replacement; approved pulley, key and fasteners are not redesigned. '
    +'Run review_actuator_plate.py first, then review_post_print_slice.py to reproduce this report.\n')
print(json.dumps(report, indent=2))

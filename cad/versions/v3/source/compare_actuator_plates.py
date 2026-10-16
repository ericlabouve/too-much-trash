"""Matched support-refinement report; keeps both exact sliced jobs unchanged."""
import argparse
import json
from pathlib import Path


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('baseline', type=Path)
    parser.add_argument('revised', type=Path)
    args = parser.parse_args()
    old, new = args.baseline.resolve(), args.revised.resolve()
    read = lambda folder, name: json.loads((folder / name).read_text())
    a, b = read(old, 'review.json'), read(new, 'review.json')
    ai, bi = read(old, 'inputs.json'), read(new, 'inputs.json')
    for name in ('machine.json', 'process.json', 'filament.json'):
        assert read(old, name) == read(new, name), name
    # The slicer may reorder XML object entries; compare settings by identity.
    by_name = lambda rows: {r['name']: {k:v for k,v in r.items() if k != 'id'} for r in rows}
    assert by_name(a['effective_object_settings']) == by_name(b['effective_object_settings'])
    assert ai['scale_percent'] == bi['scale_percent'] == 100
    assert by_name(ai['object_settings']) == by_name(bi['object_settings'])
    changed = []
    for x, y in zip(ai['parts'], bi['parts']):
        assert x['name'] == y['name'] and x['center_xy_mm'] == y['center_xy_mm']
        if x['input_sha256'] != y['input_sha256']:
            changed.append(x['name'])
    assert set(changed) == {'actuator_bracket', 'plunger', 'pulley'}, changed
    def support(r):
        return sum(r['deposited_g_by_role'].get(k, 0) for k in ('support', 'interface'))
    rows = {n: {'before_g': support(a['objects'][n]), 'after_g': support(b['objects'][n])}
            for n in b['objects']}
    before, after = support(a), support(b)
    report = {'baseline_revision': a['revision'], 'revision': b['revision'],
              'matched_profiles_placement_scale_and_overrides': True,
              'changed_source_meshes': changed, 'support_by_part': rows,
              'support_before_g': before, 'support_after_g': after,
              'support_saved_g': before-after, 'support_reduction_percent': 100*(1-after/before),
              'total_before_g': a['total_g'], 'total_after_g': b['total_g'],
              'minutes_before': a['total_minutes'], 'minutes_after': b['total_minutes'],
              'limits': ['Reference slices only; no print sent.',
                         'Reduced support does not validate band security, strength, fit or button force.',
                         'The wheel cavity remains open; upper cheek, mounting bore and axle slot are not redesigned.']}
    (new / 'comparison.json').write_text(json.dumps(report, indent=2)+'\n')
    # This is a generated job-specific report, not another CAD source revision.
    html = (old / 'index.html').read_text().replace(a['revision'], b['revision'])
    comparison = (f'<h2>Four targeted refinements</h2><p>Same recipe, placements and orientations. '
                  f'Support + interface: <b>{before:.3f} → {after:.3f} g '
                  f'({report["support_reduction_percent"]:.1f}% less)</b>. '
                  f'Total filament: {a["total_g"]:.2f} → {b["total_g"]:.2f} g. '
                  'Ramped fixed-band lip, shared-cleat cap and pulley groove flanks; outer fork leg extended to the bed. '
                  'Band/string routes and all other part designs stay unchanged. '
                  '<a href="comparison.json">Matched comparison</a> · '
                  '<a href="../2026-10-14-actuator/">Preserved baseline</a></p>')
    html = html.replace('<main><h2>', '<main>'+comparison+'<h2>', 1)
    html = html.replace('check support inside the pulley fork and mounting screw bore, and under the guide/return-band lips.',
                        'check remaining support inside the pulley fork and mounting screw bore. The outer fork leg now reaches the bed and the fixed-band lip has a ramped underside.')
    html = html.replace('inspect the shared cleat’s overhanging cap.',
                        'inspect the shared cleat’s ramped cap; its broad retaining rim remains.')
    (new / 'index.html').write_text(html)
    (new / 'README.md').write_text(
        '# V3 ramped retainers — matched actuator plate\n\n'
        f'Revision `{b["revision"]}`. Seven separate pieces, same orientation, placement, scale, profiles and object overrides '
        'as `../2026-10-14-actuator/`; that baseline is preserved. Only bracket, plunger and pulley meshes change.\n\n'
        f'Support/interface: {before:.4f} → {after:.4f} g ({report["support_reduction_percent"]:.2f}% reduction). '
        f'Total: {a["total_g"]:.4f} → {b["total_g"]:.4f} g; time {a["total_minutes"]:.2f} → {b["total_minutes"]:.2f} min.\n\n'
        'Open `index.html` via the CAD server to inspect actual extrusion paths and layers. '
        '`comparison.json` verifies matched settings; `review.json` audits toolpaths, effective settings, heat waits and hashes. '
        '`inputs.json` records source hashes and placements; full profiles, arranged and sliced 3MFs, G-code and logs are retained.\n\n'
        'No printer contacted. Generic PLA reference recipe; actual spool and bed readiness not verified. '
        'Band/string clearances are geometric envelopes, not tested security. Support removal, bridging, fit, layer strength, '
        'clamp retention and safe button force remain physical checks. Remaining-support studies are not adopted.\n')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()

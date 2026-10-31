"""Check the moving rocker-to-fairlead cord envelope through the full lever stroke.

This is a finite geometric clearance check, not a string-contact or force simulation.
"""
import json
import math
from dataclasses import replace

import build as b
import model as m


def main():
    solids = m.parts(m.Parameters())
    result = {
        'revision': 't-jaw-compact-actuator-v3',
        'cord_diameter_mm': 3,
        'samples_per_configuration': 11,
        'intersection_threshold_mm3': 0.01,
        'scope': 'Moving first cord segment against rotated rocker, other rigid assembly parts, phone and all stock proxies.',
        'limitations': 'Finite rest-to-stop samples; no physical friction, abrasion, knot security, force or strength validation.',
        'configurations': {},
    }
    for name, base in b.SAMPLES.items():
        for side in ('near', 'far'):
            p = replace(base, side=side)
            assembly = m.assembly_parts(p, solids)
            targets = {**assembly, **m.stock(p)}
            bracket_hits = {}
            for component, solid in targets.items():
                if component == 'actuator_bracket':
                    continue
                volume = b.overlap(assembly['actuator_bracket'], solid)
                if volume > 0.01:
                    bracket_hits[component] = round(volume, 6)
            hits = {}
            for step in range(11):
                angle = m.stop_angle(p) * step / 10
                targets['rocker'] = assembly['rocker'].rotate(
                    p.pivot, (p.pivot[0], p.pivot[1] + 1, p.pivot[2]),
                    math.degrees(angle),
                )
                eye = m.rotate_point(p.string_eye, p, angle)
                cord = m.rod(eye, p.first_guide, 3)
                for component, solid in targets.items():
                    volume = b.overlap(cord, solid)
                    if volume > 0.01:
                        hits[f'{step}:{component}'] = round(volume, 6)
            result['configurations'][f'{name}-{side}'] = {'intersections_mm3': hits, 'bracket_intersections_mm3': bracket_hits}
            print(name, side, 'cord', json.dumps(hits), 'bracket', json.dumps(bracket_hits), flush=True)
    result['passed'] = all(not row['intersections_mm3'] and not row['bracket_intersections_mm3'] for row in result['configurations'].values())
    b.save(b.OUT / 'twine-stroke-validation.json', result)
    if not result['passed']:
        raise SystemExit('Twine stroke clearance failed')


if __name__ == '__main__':
    main()

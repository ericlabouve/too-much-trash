"""Check a generated V4 dashboard's BOM and mesh references.

Run: uv run python tests/check_v4_viewer.py build/<site>
This checks exported data consistency, not mechanical fit or printability.
"""
import json
from pathlib import Path
import sys


def check(site):
    review = site / 'versions/v4/review'
    expected = {'shaft_cap', 'carrier', 'cap_liner', 'jaw_liner', 'sliding_jaw',
                'phone_cuff', 'actuator_bracket', 'plunger', 'pulley', 'pulley_axle',
                'pulley_key', 'plunger_stop', 'collar_screw', 'thumb_nut'}
    for sample in ('wallet', 'bare', 'small', 'large'):
        for side in ('near', 'far'):
            folder = review if (sample, side) == ('wallet', 'near') else review / f'{sample}-{side}'
            data = json.loads((folder / 'manifest.json').read_text())
            assert data['version'] == 'v4'
            assert data['revision'] == 'v4-approved-travel-stop'
            assert {p['name'] for p in data['parts']} == expected
            assert sum(p['quantity'] for p in data['parts']) == data['printed_pieces'] == 24
            assert data['printed_designs'] == len(expected)
            names = {p['name'] for p in data['assembly']}
            assert {'cap_liner', 'jaw_liner', 'plunger', 'actuator_bracket'} <= names
            assert not any(name.startswith('guide_') for name in names)
            for part in data['parts'] + data['assembly']:
                assert (folder / part['file']).is_file(), part
            assert {b['id'] for b in data['bom']} == expected | {'twine', 'rubber_bands'}
    assert "../v3/viewer.html" in (site / 'versions/v4/viewer.html').read_text()
    assert (site / 'versions/v3/viewer.js').is_file()
    print('V4: eight configurations, 14 designs / 24 pieces, all mesh references present; shared app entry verified.')


if __name__ == '__main__':
    check(Path(sys.argv[1]).resolve())

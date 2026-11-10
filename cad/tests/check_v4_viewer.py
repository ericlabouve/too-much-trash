"""Check a generated V4 dashboard's BOM and mesh references.

Run: uv run python tests/check_v4_viewer.py build/<site>
This checks exported data consistency, not mechanical fit or printability.
"""
import json
import math
from pathlib import Path
import sys


def check(site):
    review = site / 'versions/v4/review'
    expected = {'shaft_cap', 'carrier', 'cap_liner', 'jaw_liner', 'sliding_jaw',
                'phone_cuff', 'actuator_bracket', 'plunger', 'pulley', 'pulley_axle',
                'pulley_key', 'collar_screw', 'thumb_nut'}
    for sample in ('wallet', 'bare', 'small', 'large'):
        for side in ('near', 'far'):
            folder = review if (sample, side) == ('wallet', 'near') else review / f'{sample}-{side}'
            data = json.loads((folder / 'manifest.json').read_text())
            assert data['version'] == 'v4'
            assert data['revision'] == 'v4-compact-centered-mount'
            frames=data['motion']['v4_routes']
            assert len(frames)==21
            assert frames[0]['string_points'][-1]==[-42.0,0.0,-417.0]
            for frame in frames:
                assert frame['string_points'][:-1]==frame['phone_points']
                assert frame['phone_points'][-2:]==[frame['cap_entry'],frame['cap_exit']]
                assert frame['string_points'][0]==frame['attachment_points'][1]
            assert abs(frames[-1]['attachment_points'][0][0]-frames[0]['attachment_points'][0][0]+12.6)<1e-6
            assert frames[-1]['return_points'][0]==frames[0]['return_points'][0]
            seat=data['phone_seating']
            assert abs(seat['fixed_edge_center_z_mm']-8.0)<1e-6
            assert abs(seat['sliding_edge_center_z_mm']-11.28)<1e-6
            assert abs(data['parameters']['phone_width']*math.sin(math.radians(seat['tilt_about_y_deg']))-3.28)<1e-6
            assert data['motion']['mechanical_travel_mm']==12.6
            assert data['motion']['plunger_stop_moves_with_plunger'] is True
            assert next(b for b in data['bom'] if b['id']=='pulley_key')['quantity']==2
            if seat['contact_solved']:
                assert max(seat['cuff_distance_mm'].values())<.0001
                assert max(seat['cuff_overlap_mm3'].values())<1e-5
                assert 0<seat['sliding_jaw_closure_mm']<10
            assert set(seat['cuff_overlap_mm3']) == {'cuff_fixed','cuff_sliding_1','cuff_sliding_2'}
            assert {p['name'] for p in data['parts']} == expected
            assert sum(p['quantity'] for p in data['parts']) == data['printed_pieces'] == 24
            assert data['printed_designs'] == len(expected)
            names = {p['name'] for p in data['assembly']}
            assert {'cap_liner', 'jaw_liner', 'plunger', 'actuator_bracket'} <= names
            assert not any(name.startswith('guide_') for name in names)
            assert not names & {'band_keeper','band_overtravel','band_jaw_2'}
            bands=next(b for b in data['bom'] if b['id']=='rubber_bands')
            assert bands['quantity']==2
            for part in data['parts'] + data['assembly']:
                assert (folder / part['file']).is_file(), part
            assert {b['id'] for b in data['bom']} == expected | {'twine', 'rubber_bands'}
    assert "../v3/viewer.html" in (site / 'versions/v4/viewer.html').read_text()
    assert (site / 'versions/v3/viewer.js').is_file()
    print('V4: eight configurations, 13 designs / 24 pieces, all mesh references present; shared app entry verified.')


if __name__ == '__main__':
    check(Path(sys.argv[1]).resolve())

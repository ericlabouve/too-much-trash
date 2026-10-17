"""Concept-only shared key; never overwrites production actuator exports."""
import hashlib
import json
from pathlib import Path
import sys
import cadquery as cq

HERE = Path(__file__).resolve().parent
SOURCE = HERE.parents[3] / 'source'
sys.path.insert(0, str(SOURCE))
from plunger_design import box, cassette, local_shape, KEY_OUTBOARD

# Retain the existing stem, shallow band seats, 7 mm head width and 3 mm
# print-plane thickness. Only shorten the head along the insertion axis.
from shared_key_design import key_blank
key = key_blank().translate((0,0,-KEY_OUTBOARD))
active = cassette()
candidate = local_shape(key)
def volume_overlap(a,b):
    return a.intersect(b).val().Volume()

# Check the unchanged axle slot through the same insertion direction. The
# head shoulder remains at u=18; thinning is on its outward/free face only.
collisions = []
for i in range(41):
    moved = local_shape(key.translate((i*.5,0,0)))
    collisions.append(volume_overlap(moved,active['pulley_axle']))
assert max(collisions) < 1e-6
assert volume_overlap(candidate,active['actuator_bracket']) < 1e-6
# Cross-key blocks axial withdrawal of the axle once the slot wall bears.
blocked = volume_overlap(candidate,active['pulley_axle'].translate((0,.5,0)))
assert blocked > .01
assert key.val().isValid() and len(key.solids().vals()) == 1

placement = (-22.82,-8,KEY_OUTBOARD-.3)
cq.exporters.export(key.translate(placement),str(HERE/'shared-key.stl'),tolerance=.025,angularTolerance=.1)
axle_uvw = (active['pulley_axle'].translate((-8.35,-5.4,-8))
            .rotate((0,0,0),(1,0,0),-90).rotate((0,0,0),(0,0,1),90))
cq.exporters.export(axle_uvw.translate(placement),str(HERE/'actuator-axle-reference.stl'),tolerance=.025,angularTolerance=.1)
report = {
    'revision':'single-shared-key-v1','scope':'Candidate only; production unchanged',
    'baseline_source_sha256':hashlib.sha256((SOURCE/'plunger_design.py').read_bytes()).hexdigest(),
    'key_mm':{'length':12.2,'head_width':7,'head_axial_depth':1.2,'stem_width':3,'thickness':3},
    'original_key_mm':{'length':14,'head_width':7,'head_axial_depth':3,'stem_width':3,'thickness':3},
    'valid_single_solid':True,'volume_mm3':key.val().Volume(),
    'actuator_insertion_samples':41,'max_axle_overlap_mm3':max(collisions),
    'bracket_overlap_mm3':volume_overlap(candidate,active['actuator_bracket']),
    'axle_withdrawal_obstruction_at_0_5mm_mm3':blocked,
    'head_bearing_station_u_mm':18,
    'limits':['Thinner head strength and keeper-band behavior untested',
              'Actuator-only check; cuff fit is reported separately in fit-attachment-check.json',
              'TPU creep, tear and actual phone grip untested','No production promotion or print authorization']
}
(HERE/'shared-key-check.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))

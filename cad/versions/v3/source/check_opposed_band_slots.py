"""Literal cap/projection removal and mirrored band-seat audit."""
import json
import cadquery as cq
from pathlib import Path
from build import REVISION, overlap
import model as m
from jaw_support_angles import band_slot_stem, JAW_SUPPORT_ANGLE

p=m.Parameters()
slider=m.sliding_jaw(p)
fixed=m.carrier(p)
stem=band_slot_stem()
mirrored=stem.mirror('YZ').translate((-32.5+m.TRACK_ROOT_SHIFT,0,0))
root=Path(__file__).resolve().parents[1]
prior=cq.importers.importStep(str(root/'print/jobs/2026-10-25-sliding-jaw-angle-35-source/sliding-jaw.step'))
expected=prior.cut(m.box(-11,0,-10.1,10.1,45,48))
delta=sum(s.Volume() for s in slider.cut(expected).solids().vals())+sum(s.Volume() for s in expected.cut(slider).solids().vals())
checks={
 'sliding_matches_prior_35_degree_jaw_except_top_cap':delta<1e-5,
 'sliding_single_valid_solid':slider.val().isValid() and len(slider.solids().vals())==1,
 'fixed_single_valid_solid':fixed.val().isValid() and len(fixed.solids().vals())==1,
 'sliding_cap_removed':overlap(slider,m.box(-11,0,-10.1,10.1,45.001,48))<1e-6,
 'fixed_cap_removed':overlap(fixed,m.box(-30,-19,-10.1,10.1,45.001,48))<1e-6,
 'lower_projection_restored':m.box(-3,-.5,-7.5,7.5,32,38.5).cut(slider).val().Volume()<1e-6,
 'sliding_slot_present':stem.cut(slider).val().Volume()<1e-6,
 'fixed_exact_mirrored_slot_present':mirrored.cut(fixed).val().Volume()<1e-6,
 'tongue_preserved':m.box(-6,m.SLIDING_TONGUE_LENGTH,-10,10,26.4,30.4).cut(slider).val().Volume()<1e-6,
}
report={'revision':REVISION,'angle_from_bed_degrees':JAW_SUPPORT_ANGLE,
 'checks':checks,'passed':all(checks.values()),
 'limitations':['No new slice or print: previous support estimates predate this revision.',
 'Band seating and escape resistance without square caps require physical testing.',
 'Lower projection restored to X=-0.5; structural tongue remains unchanged.']}
(Path(__file__).resolve().parents[1]/'review/opposed-band-slots.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))
assert report['passed']

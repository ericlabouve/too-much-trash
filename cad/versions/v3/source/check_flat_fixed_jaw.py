"""Check the requested rib removal without changing clamp/cuff interfaces."""
import json
from pathlib import Path
import cadquery as cq
from build import REVISION
import model as m
import argparse

p=m.Parameters()
after=m.carrier(p)
parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--baseline',required=True,help='Assembly-coordinate carrier STEP exported before this edit')
before=cq.importers.importStep(parser.parse_args().baseline)
volume=lambda shape:sum(s.Volume() for s in shape.vals())
removed=before.cut(after)
added=volume(after.cut(before))
web=cq.Workplane('XZ').polyline([(-11.3,-72),(-6,-72),(-6,22),(-20,22),(-20,-35)]).close().extrude(5)
allowed=web.translate((0,-8.8,0)).union(web.translate((0,13.8,0)))
outside=volume(removed.cut(allowed))
clamp=m.shaft_clamp_half(p,False)
missing_clamp=volume(before.intersect(clamp).cut(after))
report=dict(revision=REVISION,valid=after.val().isValid(),solid_count=len(after.val().Solids()),
    previous_volume_mm3=volume(before),current_volume_mm3=volume(after),removed_mm3=volume(removed),
    removed_percent=100*volume(removed)/volume(before),added_mm3=added,
    removal_outside_highlighted_rib_envelopes_mm3=outside,missing_clamp_wall_or_boss_mm3=missing_clamp,
    limits=['Geometric continuity is not measured stiffness or strength. Full fixed jaw remains unprinted.',
            'Historical sliced print jobs and current TPU plate are unchanged.'])
report['passed']=report['valid'] and report['solid_count']==1 and added<1e-5 and outside<1e-5 and missing_clamp<1e-5
(Path(__file__).resolve().parents[1]/'review/flat-fixed-jaw.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2),flush=True)
assert report['passed']

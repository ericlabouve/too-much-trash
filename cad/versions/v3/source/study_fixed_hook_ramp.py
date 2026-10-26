"""Reduced-support hook-root candidates; exact band seat retained."""
import sys, json, hashlib, math, shutil
from pathlib import Path
import cadquery as cq
import model as m
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review

braced='--braced' in sys.argv
if braced:sys.argv.remove('--braced')
out=Path(sys.argv[sys.argv.index('--output-dir')+1]).resolve()
source=out.parent/(out.name+'-source')
source.mkdir(exist_ok='--resume-unsliced' in sys.argv)
fixed=m.carrier(m.Parameters()).cut(m.box(-5.8,30,-80,80,-50,80)).clean()
angle=35
# Fill only below the band seat. Print height runs toward negative CAD X.
start=-19.35+4.55*math.tan(math.radians(angle))
ramp=(cq.Workplane('XZ').polyline([(start,33.95),(-19.35,38.5),(-19.35,33.95)])
      .close().extrude(10,both=True))
revised=fixed.union(ramp).clean()
if braced:
    # Return brace above both band lanes; retain the V contact faces.
    upper=(cq.Workplane('XZ').polyline([
        (-19.85,44.95),(-11.25,44.95),
        (-11.25,44.95+8.6/math.tan(math.radians(angle)))])
        .close().extrude(7.5,both=True))
    revised=revised.union(upper).clean()
volume=lambda s:sum(v.Volume() for v in s.solids().vals())
assert revised.val().isValid() and len(revised.val().Solids())==1
added=revised.cut(fixed)
assert volume(fixed.cut(revised))<1e-6
assert volume(added.intersect(m.box(-120,20,-30,30,38.5,44.9)))<1e-6
# New material must clear the sliding jaw throughout its modeled travel.
slider=m.sliding_jaw(m.Parameters())
for i in range(91):
    assert volume(added.intersect(slider.translate((m.CLOSED_JAW_X-45*i/90,0,0))))<.01
# Same two band paths: all new material stays below their envelopes.
for z in m.JAW_BAND_LEVELS:
    assert volume(added.intersect(m.box(-120,20,-30,30,z-.7,z+.7)))<1e-6
report={'revision':'fixed-hook-braced-study' if braced else 'fixed-hook-ramp-study','valid_single_solid':True,'angle_from_bed_degrees':angle,
        'added_mm3':volume(added),'band_seat_unchanged':True,'travel_samples_clear':91,
        'source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'limits':['35-degree print quality and loaded band-anchor strength still require physical tests.']}
(source/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
shape=revised.rotate((0,0,0),(0,1,0),90)
for ext in ('stl','step'):
    cq.exporters.export(shape,str(source/('carrier.'+ext)),**({'tolerance':.015,'angularTolerance':.1} if ext=='stl' else {}))
prior=plate.ROOT/'print/jobs/2026-10-26-flat-fixed-tall-cap-source'
for ext in ('stl','step'):shutil.copy2(prior/('shaft_cap.'+ext),source/('shaft_cap.'+ext))
plate.SOURCE=source
plate.PARTS={'carrier':((90,35),'Z',0,'Flat collar underside down; CAD Y+90.'),
             'shaft_cap':((90,120),'Z',0,'Unchanged taller cap, exterior down.')}
plate.main()
inputs=json.loads((out/'inputs.json').read_text());inputs['scope']='Full fixed jaw with ramped hook root and unchanged taller cap; comparison only.'
(out/'inputs.json').write_text(json.dumps(inputs,indent=2)+'\n')
review.OUT=out
review.main(project_stem='cuff-fit',title=('Braced' if braced else 'Ramped')+' fixed hook + taller cap · PETG',detail_parts=['carrier','shaft_cap'],notes=[
 '35-degree ramp below the unchanged fixed band seat. Tongue travel and band paths preserved.',
 'Same two-part placement and PETG recipe as the accepted flat-fixed/taller-cap study. Automatic supports enabled.',
    'Upper return brace leaves the V seat and modeled band lanes clear; physical band installation access needs checking.' if braced else 'Lower root ramp only; unchanged upper lip.',
 'No printer contact. Actual ramp quality, clamping and band-anchor strength require physical tests.'])

"""Reversible split-plane study, with matched two-part PETG plates."""
import sys, json, hashlib
from pathlib import Path
import cadquery as cq
import model as m
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review

candidate = '--candidate' in sys.argv
if candidate: sys.argv.remove('--candidate')
out = Path(sys.argv[sys.argv.index('--output-dir') + 1]).resolve()
source = out.parent / (out.name + '-source')
source.mkdir(exist_ok='--resume-unsliced' in sys.argv)
p = m.Parameters()
fixed, cap = m.carrier(p,flat_ramped=False), m.shaft_cap(p,tall=False)
original_fixed, original_cap = fixed, cap
if candidate:
    # Move the split to the neck's negative-X face. Maintain the 1 mm gap.
    fixed = fixed.cut(m.box(-5.8,30,-80,80,-50,80)).clean()
    cap = m.box(-4.8,12,-13.8,13.8,m.CLAMP_BOTTOM,m.CLAMP_TOP)
    for y,z in m.CLAMP_STATIONS:
        cap = cap.union(m.cylinder((-4.8,y,z),(1,0,0),18.6,18))
        cap = cap.union(m.box(-4.8,13.8,min(y,11),max(y,-11),z-9,z+9))
        cap = cap.cut(m.cylinder((-15,y,z),(1,0,0),30,8.8))
    cap = cap.cut(m.box(-5.8,5.8,-8.8,8.8,-41,71))
    cap = cap.union(m.paired_neck_rail().translate((m.CUFF_INWARD_SHIFT,0,0)))
    cap = cap.intersect(m.box(-20,12,-70,70,-38.5,68.5))
    cap = cap.cut(m.box(-10,15,-5.5,5.5,-30,60).edges('|X').fillet(5.49)).clean()
    assert abs(fixed.val().BoundingBox().xmax+5.8)<1e-6
    assert abs(cap.val().BoundingBox().xmin+4.8)<1e-6
volume=lambda s:sum(v.Volume() for v in s.solids().vals())
assert volume(fixed.intersect(cap))<1e-6
report={'revision':'flat-fixed-tall-cap-study' if candidate else 'current-fixed-cap-baseline',
        'candidate':candidate,'split_gap_mm':1,'neck_opening_mm':[11.6,17.6],
        'parts':{},'source_sha256':{n:hashlib.sha256(Path(__file__).with_name(n).read_bytes()).hexdigest() for n in ('model.py','study_flat_fixed_pair.py')},
        'limits':['Study only; active assembly unchanged. Taller cap walls and thinner fixed collar require physical strength and clamping checks.']}
for name,shape,old in [('carrier',fixed,original_fixed),('shaft_cap',cap,original_cap)]:
    assert shape.val().isValid() and len(shape.val().Solids())==1
    # All four bores and bearing planes remain at their original positions.
    for y,z in m.CLAMP_STATIONS:
        assert volume(shape.intersect(m.cylinder((-23,y,z),(1,0,0),40,8.79)))<1e-6
    report['parts'][name]={'valid':True,'solids':1,'volume_mm3':volume(shape),'baseline_mm3':volume(old)}
    oriented=shape.rotate((0,0,0),(0,1,0),90)
    if name=='shaft_cap':oriented=oriented.rotate((0,0,0),(0,0,1),90)
    cq.exporters.export(oriented,str(source/(name+'.stl')),tolerance=.015,angularTolerance=.1)
    cq.exporters.export(oriented,str(source/(name+'.step')))
(source/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
plate.SOURCE=source
plate.PARTS={'carrier':((90,35),'Z',0,'Collar underside down, track upright; CAD Y+90.'),
             'shaft_cap':((90,120),'Z',0,'Existing flat exterior down; CAD Y+90 then bed Z+90.')}
plate.main()
inputs=json.loads((out/'inputs.json').read_text())
inputs['scope']='Matched fixed-jaw and shaft-cap study; active geometry unchanged.'
(out/'inputs.json').write_text(json.dumps(inputs,indent=2)+'\n')
review.OUT=out
review.main(project_stem='cuff-fit',title=('Flat fixed jaw + taller cap' if candidate else 'Current fixed jaw + cap')+' · PETG comparison',detail_parts=['carrier','shaft_cap'],notes=[
 'Two complete parts, same profiles and plate positions in both trials. Automatic Snug supports enabled.',
 'Candidate transfers 5.3 mm of split depth to the cap, preserving neck opening, 1 mm split gap, screw axes and bearing planes.' if candidate else 'Unchanged current fixed jaw and cap baseline.',
 'Study only; not promoted into the assembly or sent to the printer. Physical stiffness and clamp fit remain unverified.'])

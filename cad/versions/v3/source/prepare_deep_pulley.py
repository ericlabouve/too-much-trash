"""Offline PETG support check of deeper pulley; no printer contact."""
import sys, json, hashlib
from pathlib import Path
import cadquery as cq
from plunger_design import cassette
import prepare_cuff_fit_plate as plate

out=Path(sys.argv[sys.argv.index('--output-dir')+1]).resolve()
assert not (out/'cuff-fit.gcode.3mf').exists(), 'Preserve completed slices'
source=out.parent/(out.name+'-source');source.mkdir(exist_ok='--resume-unsliced' in sys.argv)
s=cassette()['pulley']
assert s.val().isValid() and len(s.solids().vals())==1
cq.exporters.export(s,str(source/'pulley.stl'),tolerance=.015,angularTolerance=.1)
cq.exporters.export(s,str(source/'pulley.step'))
report={'revision':'deep-groove-pulley-v3','nominal_groove_depth_mm':2.2,'previous_depth_mm':1.1,'outer_diameter_mm':18,'bore_mm':8.6,'axial_width_mm':4,'flank_angle_from_bed_degrees':36.027,'minimum_radial_web_mm':2.5,'valid':True,'source_sha256':hashlib.sha256(Path(__file__).with_name('plunger_design.py').read_bytes()).hexdigest(),'limits':['Digital fit and slice only; retention, wear and print quality require physical checks.','Only pulley changes; axle/bracket bearing envelope preserved.']}
(source/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
plate.SOURCE=source
plate.PARTS={'pulley':((90,90),'X',90,'Axis vertical; existing flange face on bed. Automatic supports enabled to check deeper 36-degree groove.')}
plate.main()
import review_actuator_plate as review
inputs=json.loads((out/'inputs.json').read_text());inputs['scope']='One complete deeper-groove pulley; offline PETG support check.'
(out/'inputs.json').write_text(json.dumps(inputs,indent=2)+'\n')
review.OUT=out
review.main(project_stem='cuff-fit',title='Deeper redirect pulley',detail_parts=['pulley'],notes=['Bambu PETG Translucent / A1 mini / 0.4 mm nozzle / 0.12 mm layers.','Automatic Normal Snug supports enabled. Groove depth doubled to 2.2 mm with 36-degree sides.','No printer contacted. String retention and support-free print quality remain physical checks.'])

"""Matched PETG slices: original, flush backing, then lowered band cleat.

Immutable study inputs; no printer communication. Uses actual slicer paths.
"""
import argparse
import json
import sys
from pathlib import Path
import cadquery as cq
import model as m
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('variant')
    parser.add_argument('--angle',type=float)
    parser.add_argument('--fixed',action='store_true')
    parser.add_argument('--resume-unsliced',action='store_true')
    args=parser.parse_args()
    variant=args.variant
    out=plate.ROOT/'print/jobs'/('2026-10-25-sliding-jaw-'+variant)
    source=out.parent/(out.name+'-source')
    if args.resume_unsliced:
        assert not (out/'cuff-fit.gcode.3mf').exists(),'Preserve sliced experiments'
    else:
        assert not out.exists() and not source.exists(),'Preserve existing experiments'
    source.mkdir(exist_ok=args.resume_unsliced)
    shift=-4.5 if variant in ('lowered-cleat','angled-undersides') or args.angle is not None else 0
    import cuff_design
    cuff_design.STUD_SUPPORT_ANGLE=args.angle
    s=m.sliding_jaw(m.Parameters(),flat_back=variant!='baseline',cleat_shift=shift,support_angle=None)
    if variant=='angled-undersides':
        from sliding_jaw_angles import candidate
        s=candidate()
    if args.angle is not None:
        from jaw_support_angles import refine
        s=refine(s,args.angle)
    part='sliding-jaw'
    if args.fixed:
        s=m.carrier(m.Parameters())
        part='fixed-jaw'
    assert s.val().isValid() and len(s.val().Solids())==1
    cq.exporters.export(s,str(source/(part+'.stl')),tolerance=.015,angularTolerance=.1)
    cq.exporters.export(s,str(source/(part+'.step')))
    (source/'fit-attachment-check.json').write_text(json.dumps(dict(
        revision='sliding-jaw-'+variant,valid=True,solid_count=1,
        bed_plane_x_mm=-10 if not args.fixed else None,cleat_shift_x_mm=shift,angle_degrees=args.angle,
        limits=['Offline PETG design study; strength and band preload unqualified.']),indent=2)+'\n')
    plate.SOURCE=source
    plate.PARTS={part:((90,90),'Y',90 if args.fixed else -90,'Canonical bed orientation. No scaling.')}
    sys.argv=[sys.argv[0],'--output-dir',str(out)]
    if args.resume_unsliced:sys.argv.append('--resume-unsliced')
    plate.main()
    # Replace the legacy adapter's fit-coupon description for this full part.
    inputs=json.loads((out/'inputs.json').read_text())
    inputs['scope']='One complete '+part+', matched support comparison. Offline only.'
    (out/'inputs.json').write_text(json.dumps(inputs,indent=2)+'\n')
    review.OUT=out
    review.main(project_stem='cuff-fit',title='Sliding jaw · '+variant,
        detail_parts=[part],notes=[
        'Bambu PETG Translucent Blue comparison; A1 mini / 0.4 mm / 0.12 mm layers.',
        'Normal Snug supports remain enabled, including non-bed-only supports; same settings for all variants.',
        'Crossbar rear face on bed. Inspect stud-head underside and band-anchor support access.',
        'No printer contacted. Physical strength, retention, bridge quality and sliding fit remain unqualified.'])

if __name__=='__main__':main()

"""PETG-only integral-stud coupon; offline slice, never printer control.

Retains the concept's exact stud and full cuff backing, omitting the carrier.
Usage: python prepare_stud_coupon.py --output-dir <new job directory>
"""
import hashlib
import json
from pathlib import Path
import sys
import cadquery as cq
import prepare_cuff_fit_plate as plate

CONCEPT = plate.ROOT/'review/concepts/phone-clamps/centered-wide-cuff'
sys.path.insert(0, str(CONCEPT))
import build_fixed_retention as retention

def main():
    side_flush = '--side-flush' in sys.argv
    if side_flush:
        sys.argv.remove('--side-flush')
    # Preserve the existing plate CLI, profiles, validation and immutable-job guards.
    out = Path(sys.argv[sys.argv.index('--output-dir')+1]).resolve()
    assert not out.exists(), 'Use a new job directory'
    source = out.parent/(out.name+'-source')
    source.mkdir(exist_ok=False)
    b = retention.b
    shell, seats, backing, _ = b.retention('c', 21.6, True)
    stud = retention.integral_stud()
    coupon = backing.union(stud)
    if side_flush:
        coupon = coupon.cut(b.box(-20,0,-20,20,-10,-3.2))
        assert retention.volume(stud.cut(coupon)) < 1e-6, 'Never trim the stud'
    cuff = shell.union(seats)
    assert coupon.val().isValid() and len(coupon.solids().vals()) == 1
    assert retention.overlap(coupon,cuff) < 1e-5
    assert retention.overlap(coupon,cuff.translate((1,0,0))) > 0
    cq.exporters.export(coupon,str(source/'integral-stud.stl'),tolerance=.015,angularTolerance=.1)
    cq.exporters.export(coupon,str(source/'integral-stud.step'))
    report = dict(revision='integral-stud-side-flush-v1' if side_flush else 'integral-stud-coupon-v1',valid=True,solids=1,
        cuff_width_mm=21.6,head_width_mm=9.2,cuff_opening_width_mm=6.8,
        backing_dimensions_mm=[2.3,21.6,9.0 if side_flush else 11.6],
        backing_edge_trim_mm=2.6 if side_flush else 0,
        stud_unchanged=True,
        volume_mm3=retention.volume(coupon),
        seated_cuff_overlap_mm3=retention.overlap(coupon,cuff),
        pullout_after_1mm_obstruction_mm3=retention.overlap(coupon,cuff.translate((1,0,0))),
        source_sha256={str(p.relative_to(plate.ROOT)):hashlib.sha256(p.read_bytes()).hexdigest()
                       for p in [CONCEPT/'build_fixed_retention.py',CONCEPT/'build_concepts.py']},
        limits=['Exact concept stud; side-flush option trims only one backing edge. Not a complete jaw or structural test.',
                'Mate only with the common 21.6 mm TPU cuff; do not force a rigid PETG cuff over the stud.',
                'Support residue under the retaining head must be removed before testing.'])
    (source/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
    plate.SOURCE=source
    plate.PARTS={'integral-stud':((90,90),'Y',-90,
        'Flat rear backing on bed; stud points up. Automatic supports retained under head overhangs.')}
    if side_flush:
        plate.PARTS={'integral-stud':((90,90),'Z',0,
            'Backing trimmed at local Z=-3.2 to align with stud side; both lie on bed. Automatic supports remain enabled.')}
    plate.main()

if __name__=='__main__':main()

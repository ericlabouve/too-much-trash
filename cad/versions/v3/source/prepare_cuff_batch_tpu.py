"""Three identical TPU cuffs and one unchanged screw/nut experimental pair."""
import sys,json,shutil,hashlib
from pathlib import Path
import cadquery as cq
import prepare_cuff_fit_plate as plate
from cuff_design import cuff

def main():
    out=Path(sys.argv[sys.argv.index('--output-dir')+1]).resolve()
    assert not out.exists()
    source=out.parent/(out.name+'-source');source.mkdir(exist_ok=False)
    prior=plate.ROOT/'print/jobs/2026-10-24-common-cuff-tpu'
    approved=cq.importers.importStep(str(prior.parent/(prior.name+'-source')/'common-cuff.step'))
    current=cuff()
    difference=sum(s.Volume() for s in current.cut(approved).vals())+sum(s.Volume() for s in approved.cut(current).vals())
    assert difference<1e-6,difference
    for i in range(1,4):shutil.copy2(prior/'common-cuff-source.stl',source/f'cuff-{i}.stl')
    for name in ('thumb_screw','thumb_nut'):
        shutil.copy2(plate.ROOT/'print'/f'{name}.stl',source/f'{name}.stl')
    report=dict(revision='integral-stud-cuff-batch-tpu-v1',cuff_width_mm=21.6,
        same_cuff_quantity=3,approved_cuff_symmetric_difference_mm3=difference,
        source_hashes={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in source.glob('*.stl')},
        limits=['Supports disabled at user request after physical cuff feedback.',
                'Thumb screw and nut unchanged in size/thread; TPU experiment only, not structural fastener qualification.'])
    (source/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
    plate.SOURCE=source;plate.PRIOR=prior
    plate.PARTS={f'cuff-{i}':((50+35*(i-1),95),'Y',-90,'Exact successful cuff back-down orientation') for i in range(1,4)}
    plate.PARTS.update(thumb_screw=((65,55),'Z',0,'Existing bed-oriented screw: head down'),
                       thumb_nut=((105,55),'Z',0,'Existing bed-oriented nut: flat down'))
    plate.main(process_overrides={'enable_support':'0'},
        material_status='ELEGOO TPU95A white; same filament and speed recipe as successful single cuff. Threads are a new TPU trial.')

if __name__=='__main__':main()

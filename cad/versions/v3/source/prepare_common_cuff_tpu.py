"""Offline ELEGOO TPU95A trial of the exact common 21.6 mm concept cuff."""
import sys, json, hashlib, shutil
from pathlib import Path
import cadquery as cq
import prepare_cuff_fit_plate as plate

CONCEPT=plate.ROOT/'review/concepts/phone-clamps/centered-wide-cuff'
sys.path.insert(0,str(CONCEPT))
import build_fixed_retention as design

def main():
    out=Path(sys.argv[sys.argv.index('--output-dir')+1]).resolve()
    assert not out.exists()
    source=out.parent/(out.name+'-source');source.mkdir(exist_ok=False)
    shell,seats,backing,_=design.b.retention('c',21.6,True)
    cuff=shell.union(seats)
    assert cuff.val().isValid() and len(cuff.solids().vals())==1
    assert design.overlap(cuff,backing.union(design.integral_stud()))<1e-5
    cq.exporters.export(cuff,str(source/'common-cuff.stl'),tolerance=.015,angularTolerance=.1)
    cq.exporters.export(cuff,str(source/'common-cuff.step'))
    report=dict(revision='common-cuff-21p6-tpu-trial-v1',width_mm=21.6,
        opening_mm=6.8,head_recess_mm=9.6,valid=True,solids=1,
        unchanged_concept_geometry=True,volume_mm3=design.volume(cuff),
        source_sha256=hashlib.sha256((CONCEPT/'build_concepts.py').read_bytes()).hexdigest(),
        limits=['First TPU material/fit trial; no grip or pull-off force qualification.',
                'One-piece cuff includes both adaptable seats; do not use the obsolete 12 mm cuff.'])
    (source/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
    root=Path('/Applications/BambuStudio.app/Contents/Resources/profiles/BBL')
    index={}
    for path in root.rglob('*.json'):
        data=json.loads(path.read_text())
        if 'name' in data:index[data['name']]=(data,path)
    provenance=[]
    def resolve(name):
        data,path=index[name];data=data.copy();parent=data.pop('inherits',None)
        result=resolve(parent) if parent else {};result.update(data)
        provenance.append(dict(name=name,sha256=hashlib.sha256(path.read_bytes()).hexdigest(),path=str(path)))
        return result
    filament=resolve('Generic TPU @BBL A1M')
    # Trial values, not a calibrated ELEGOO preset. Avoid PETG flow/retraction inheritance.
    filament.update(filament_colour=['#FFFFFF'],nozzle_temperature=['230'],
        nozzle_temperature_initial_layer=['230'],textured_plate_temp=['35'],
        textured_plate_temp_initial_layer=['35'],filament_max_volumetric_speed=['2'])
    for kind in ('machine','process'):
        shutil.copy2(plate.PRIOR/(kind+'.json'),source/(kind+'.json'))
    (source/'filament.json').write_text(json.dumps(filament,indent=2)+'\n')
    (source/'profile-provenance.json').write_text(json.dumps(dict(inheritance=provenance,
        manufacturer_reference='https://us.elegoo.com/products/tpu-filament-1-75mm-colored-1kg',
        note='Generic TPU A1 mini base, conservative uncalibrated ELEGOO95A trial: 230C nozzle/35C bed, 2 mm3/s limit.'),indent=2)+'\n')
    plate.PRIOR=source;plate.SOURCE=source
    plate.PARTS={'common-cuff':((90,90),'Y',-90,'C back down; central T opening vertical; shape unmodified')}
    speeds={k:'25' for k in ('outer_wall_speed','inner_wall_speed','sparse_infill_speed',
        'internal_solid_infill_speed','top_surface_speed','gap_infill_speed','support_speed','support_interface_speed')}
    speeds.update(initial_layer_speed='15',initial_layer_infill_speed='15',
        normal_acceleration='500',outer_wall_acceleration='500',inner_wall_acceleration='500')
    plate.main(process_overrides=speeds,material_status='ELEGOO TPU95A white trial based on Generic TPU A1 mini; user reports TPU loaded; not calibrated')

if __name__=='__main__':main()

"""Offline three-piece PETG cuff fit slice; preserves all prior print jobs."""
import argparse
import hashlib
import json
import math
import shutil
import xml.etree.ElementTree as ET
import zipfile
from pathlib import Path
import trimesh
import prepare_actuator_plate as common

ROOT=Path(__file__).resolve().parents[1]
SOURCE=ROOT/'review/concepts/phone-clamps/rounded-cuff'
PRIOR=ROOT/'print/jobs/2026-10-15-actuator-petg'
PARTS={
    'fit-cuff':((65,85),'X',90,'C profile on its flat side; extrusion axis vertical'),
    'fit-jaw':((90,85),'Y',90,'Socket axis vertical; no friction ribs for PETG clearance test'),
    'fit-key':((115,85),'Z',0,'Uniform 3 mm thickness flat; T head and stem on bed')}

def main(process_overrides=None, material_status='Bambu PETG Translucent Blue recipe; current loaded spool not queried'):
    parser=argparse.ArgumentParser()
    parser.add_argument('--output-dir',type=Path,required=True)
    parser.add_argument('--parts',nargs='+',choices=list(PARTS),default=list(PARTS),help='Print only the selected fit-test pieces, without changing their placement or scale.')
    parser.add_argument('--resume-unsliced',action='store_true',help='Retry an interrupted preparation only; never overwrite sliced output.')
    parser.add_argument('--cuff-orientation',choices=['side','back'],default='side')
    parser.add_argument('--bridge-no-support',action='store_true',help='Keep automatic supports, but omit supports under detected bridges.')
    args=parser.parse_args(); out=args.output_dir.resolve()
    if args.resume_unsliced:
        assert not (out/'cuff-fit.gcode.3mf').exists(), 'Preserve existing sliced output'
        assert not (out/'review.json').exists(), 'Preserve existing review'
    out.mkdir(parents=True,exist_ok=args.resume_unsliced)
    common.OUT=out
    shutil.copy2(SOURCE/'fit-attachment-check.json',out/'geometry-check.json')
    assert len(args.parts)==len(set(args.parts)), 'Do not duplicate part selections'
    parts={name:PARTS[name] for name in args.parts}
    if args.cuff_orientation=='back' and 'fit-cuff' in parts:
        parts['fit-cuff']=((65,85),'Y',-90,'C back down; key passage axis vertical; use geometry-check.json for the revision-specific bed face')
    rows=[]
    profiles={k:json.loads((PRIOR/(k+'.json')).read_text()) for k in ('machine','process','filament')}
    profiles['process'].update(wall_loops='3',sparse_infill_density='15%',
        sparse_infill_pattern='gyroid',enable_support='1',support_type='normal(auto)',
        support_style='snug',support_on_build_plate_only='0',support_threshold_angle='30',
        support_top_z_distance='0.24',support_bottom_z_distance='0.24',
        support_object_xy_distance='0.4',support_interface_top_layers='2',
        support_interface_bottom_layers='2',support_interface_spacing='0.5',
        layer_height='0.12',initial_layer_print_height='0.2',
        print_sequence='by layer',enable_arc_fitting='0',
        curr_bed_type='Textured PEI Plate',brim_type='no_brim',brim_width='0',raft_layers='0')
    if args.bridge_no_support:
        profiles['process']['bridge_no_support']='1'
    profiles['process'].update(process_overrides or {})
    for kind,data in profiles.items():common.save(out/(kind+'.json'),data)
    model=ET.Element('model',{'unit':'millimeter','xmlns':common.NS})
    resources=ET.SubElement(model,'resources');build=ET.SubElement(model,'build')
    for i,(name,((x,y),axis,angle,orientation)) in enumerate(parts.items(),1):
        path=SOURCE/(name+'.stl');mesh=trimesh.load_mesh(path)
        assert mesh.is_watertight and mesh.is_winding_consistent and mesh.volume>0
        vector={'X':[1,0,0],'Y':[0,1,0],'Z':[0,0,1]}[axis]
        rotation=trimesh.transformations.rotation_matrix(math.radians(angle),vector)
        mesh.apply_transform(rotation)
        shift=[-mesh.bounds[:,0].mean(),-mesh.bounds[:,1].mean(),-mesh.bounds[0,2]]
        mesh.apply_translation(shift)
        mesh.export(out/(name+'-bed.stl'))
        shutil.copy2(path,out/(name+'-source.stl'))
        obj=ET.SubElement(resources,'object',{'id':str(i),'type':'model','name':name})
        node=ET.SubElement(obj,'mesh'); vertices=ET.SubElement(node,'vertices');triangles=ET.SubElement(node,'triangles')
        for v in mesh.vertices:ET.SubElement(vertices,'vertex',dict(zip('xyz',(f'{q:.7f}' for q in v))))
        for f in mesh.faces:ET.SubElement(triangles,'triangle',dict(zip(('v1','v2','v3'),map(str,f))))
        ET.SubElement(build,'item',{'objectid':str(i),'transform':f'1 0 0 0 1 0 0 0 1 {x} {y} 0'})
        rows.append({'name':name,'quantity':1,'source':str(path.relative_to(ROOT)),
            'input_sha256':hashlib.sha256(path.read_bytes()).hexdigest(),'center_xy_mm':[x,y],
            'bounds_mm':mesh.extents.tolist(),'orientation':orientation,
            'rotation_matrix':rotation.tolist(),'centering_translation_mm':shift})
    with zipfile.ZipFile(out/'raw-layout.3mf','w',zipfile.ZIP_DEFLATED) as z:
        z.writestr('3D/3dmodel.model',ET.tostring(model,encoding='utf-8',xml_declaration=True))
        z.writestr('[Content_Types].xml','<?xml version="1.0"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/></Types>')
        z.writestr('_rels/.rels','<?xml version="1.0"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Target="/3D/3dmodel.model" Id="rel0" Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/></Relationships>')
    common.cli(['--load-settings',str(out/'machine.json')+';'+str(out/'process.json'),
        '--load-filaments',str(out/'filament.json'),'--arrange','0','--orient','0',
        '--export-3mf','cuff-fit-input.3mf','--outputdir',str(out),str(out/'raw-layout.3mf')],'prepare-retry' if args.resume_unsliced else 'prepare')
    settings=[dict(name=n,**{k:profiles['process'][k] for k in
               ('wall_loops','sparse_infill_density','sparse_infill_pattern','enable_support')}) for n in parts]
    common.save(out/'inputs.json',{'revision':json.loads((SOURCE/'fit-attachment-check.json').read_text())['revision'],
        'scale_percent':100,'parts':rows,'object_settings':settings,'printer_contacted':False,
        'slicer':'BambuStudio-02.07.01.62','profile_source':str(PRIOR.relative_to(ROOT)),
        'profile_source_sha256':{k:hashlib.sha256((PRIOR/(k+'.json')).read_bytes()).hexdigest() for k in profiles},
        'material_status':material_status,
        'geometry_check_sha256':hashlib.sha256((out/'geometry-check.json').read_bytes()).hexdigest(),
        'scope':'Selected standalone fit-test pieces: '+', '.join(parts)+'. NOT complete jaws; consult geometry check for retention limitations.'})
    common.cli(['--load-settings',str(out/'machine.json')+';'+str(out/'process.json'),
        '--load-filaments',str(out/'filament.json'),'--arrange','0','--orient','0',
        '--slice','0','--export-3mf','cuff-fit.gcode.3mf','--outputdir',str(out),str(out/'cuff-fit-input.3mf')],'slice')
    result=json.loads((out/'result.json').read_text())
    assert result['return_code']==0 and len(result['sliced_plates'])==1
    assert {o['name'] for o in result['sliced_plates'][0]['objects']}==set(parts)
    print(json.dumps(result['sliced_plates'][0],indent=2))

if __name__=='__main__':main()

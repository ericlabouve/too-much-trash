"""Single contact fit-development CAD. PETG first, TPU cuff later; no print job.

Assembly coordinates match model.js. The PETG test omits friction ribs:
0.2 mm nominal clearance per side, not a pull-out retention claim.
"""
import json
import hashlib
from pathlib import Path
import cadquery as cq
import trimesh
from build_shared_key import key, placement, box, volume_overlap

HERE = Path(__file__).resolve().parent
from cuff_design import SCALE, cuff_components, cuff as make_cuff, socket as make_socket

shell,ribs = cuff_components()
cuff = make_cuff()
socket_clear = make_socket()
socket = socket_clear
placed_key = key.translate(placement)

def export(shape,name):
    path=HERE/(name+'.stl')
    shape.val().exportStl(str(path),tolerance=.0005,angularTolerance=.08,relative=False)
    # OCC fillet poles can emit zero-area triangles with coincident vertices.
    # Weld only at 0.00001 mm and remove degenerate/duplicate faces; never fill
    # holes or change dimensions to make a broken solid pass.
    mesh=trimesh.load(path)
    before=len(mesh.faces)
    mesh.merge_vertices(digits_vertex=5)
    mesh.update_faces(mesh.nondegenerate_faces())
    mesh.update_faces(mesh.unique_faces())
    mesh.remove_unreferenced_vertices()
    assert mesh.is_watertight and mesh.is_winding_consistent, name
    mesh.export(path)
    return {'watertight':True,'winding_consistent':True,
            'removed_degenerate_or_duplicate_faces':before-len(mesh.faces),
            'absolute_mesh_tolerance_mm':.0005,'weld_precision_mm':.00001,
            'bounds_mm':mesh.extents.tolist()}

parts={'fit-cuff':cuff,'fit-jaw':socket,'fit-key':placed_key}
checks={}
for name,part in parts.items():
    assert part.val().isValid() and len(part.solids().vals())==1, name
    mesh_check=export(part,name)
    cq.exporters.export(part,str(HERE/(name+'.step')))
    b=part.val().BoundingBox()
    checks[name]={'valid_single_solid':True,'volume_mm3':part.val().Volume(),
                  'bounds_mm':[b.xlen,b.ylen,b.zlen],'mesh':mesh_check}
# Display the very same source surfaces; green remains one piece with cyan.
export(shell,'fit-cuff-shell')
export(ribs,'fit-cuff-seats')

assert volume_overlap(placed_key,cuff)<1e-6
assert volume_overlap(cuff,socket)<1e-6
for y0,y1 in [(-3.7,-1.7),(1.7,3.7)]:
    shoulder = box(-6.72,-5.02,y0,y1,-1.7,1.7)
    assert shoulder.cut(cuff).val().Volume()<1e-6
intentional = volume_overlap(placed_key,socket)
assert intentional < 1e-6
assert volume_overlap(placed_key,socket_clear)<1e-6
samples=[]
for i in range(41):
    moved=placed_key.translate((i*.5,0,0))
    outside=volume_overlap(moved,socket_clear)+volume_overlap(moved,cuff)
    assert outside<1e-6, (i,outside)
    samples.append(volume_overlap(moved,socket))

# Export a buildable single-contact study, not the complete fixed/sliding jaws.
assembly=cq.Assembly(name='single-contact-fit-development')
for name,part in parts.items(): assembly.add(part,name=name)
assembly.save(str(HERE/'fit-attachment.step'))
report={
    'revision':'enlarged-cuff-v1','parts':checks,
    'cuff_scale':SCALE,'back_wall_behind_head_mm':1.7,
    'flat_bed_face_yz_mm':[12,8.88],
    'unchanged_interface_mm':{'stem':[3.4,3.4],'head':[7.4,3.4]},
    'assembly_translation_mm':{'key':[-.6,0,0],'jaw':[-1.6,0,0]},
    'materials':{'current_prototype':'All three parts PETG; no TPU grip qualification',
                 'intended_cuff':'ELEGOO TPU 95A White 1.75 mm, user-specified',
                 'intended_jaw_key':'Rigid printed material; PETG prototype'},
    'source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    'key_geometry_changed_from_shared_candidate':False,
    'socket':{'clear_passage_mm':3.4,'friction_gap_mm':None,
              'key_stem_mm':3,'nominal_total_interference_mm':0,
              'nominal_clearance_per_side_mm':.2,'rib_count':0,
              'positive_axial_latch':False},
    'key_cuff_overlap_mm3':volume_overlap(placed_key,cuff),
    'cuff_jaw_overlap_mm3':volume_overlap(cuff,socket),
    'seated_intentional_rib_overlap_mm3':intentional,
    'insertion_samples':41,'max_intentional_rib_overlap_mm3':max(samples),
    'non_rib_insertion_overlap_mm3':0,
    'second_key':False,'production_geometry_changed':False,
    'limits':['Clearance-fit test only; no designed friction grip or positive pull-out latch',
              'Printed tolerances remain unqualified; never force a jammed key',
              'PETG cuff is rigid and does not demonstrate TPU grip or safe phone contact',
              'Use a dummy edge for first fit checks; no phone suspension trial',
              'Enlarged cuff and reinforced shoulder are unprinted; strength needs physical review',
              'CAD build only; separate job record governs slicing, no active jaw integration']}
(HERE/'fit-attachment-check.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))

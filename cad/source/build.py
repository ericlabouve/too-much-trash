"""Reproduce R3 bed-oriented STLs, STEP assembly, metadata and drawings."""
from pathlib import Path
import json
import cadquery as cq
import trimesh
from parameters import Parameters
from parts import all_parts
from assembly import scene,stop_angle
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'print'

def print_orientation(name,s):
    if name=='rocker':s=s.rotate((0,0,0),(1,0,0),90)
    if name=='actuator_bracket':s=s.rotate((0,0,0),(0,1,0),-90)
    bb=s.val().BoundingBox()
    return s.translate((-bb.xmin,-bb.ymin,-bb.zmin))

def export_step(s,path):
    cq.exporters.export(s,str(path))
    path.write_text('\n'.join(line.rstrip() for line in path.read_text().splitlines())+'\n')

def main():
    p=Parameters();p.validate();parts=all_parts(p);OUT.mkdir(exist_ok=True)
    view=OUT/'assembly_meshes';view.mkdir(exist_ok=True)
    manifest={'revision':'R3','parameters':p.__dict__,'parts':[],'assembly':[],'pressed_angle_radians':stop_angle(p)}
    for name,s in parts.items():
        assert len(s.val().Solids())==1 and s.val().isValid(),name
        dest=OUT/f'{name}.stl'
        cq.exporters.export(print_orientation(name,s),str(dest),tolerance=.045,angularTolerance=.12)
        export_step(s,OUT/f'{name}.step')
        m=trimesh.load_mesh(dest);assert m.is_watertight and m.volume>0,name
        item={'name':name,'quantity':2 if name=='neck_cap' else 1,'volume_mm3':round(s.val().Volume(),2),'bounds_mm':m.extents.round(2).tolist(),'file':dest.name}
        manifest['parts'].append(item);print(item,flush=True)
    assy=cq.Assembly(name='Too_Much_Trash_R3_fit_prototype')
    for name,s,c in scene(parts,p):
        assy.add(s,name=name,color=cq.Color(*c))
        cq.exporters.export(s,str(view/f'{name}.stl'),tolerance=.12,angularTolerance=.15)
        manifest['assembly'].append({'name':name,'color':c,'file':f'assembly_meshes/{name}.stl','printable':name in parts or name=='handle_cap'})
    assy.export(str(OUT/'assembly.step'))
    manifest['total_printed_solid_cm3']=round(sum(x['volume_mm3']*x['quantity'] for x in manifest['parts'])/1000,2)
    (OUT/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
    from render import render_all
    render_all(parts,p,OUT)
if __name__=='__main__':main()

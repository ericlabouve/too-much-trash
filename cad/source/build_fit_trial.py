"""Export versioned collar fit trials; preserve baseline and earlier exports."""
import argparse
import json
import cadquery as cq
import trimesh
from build import ROOT, print_orientation, export_step
from parameters import Parameters
from parts import collar, handle_anchor, box


def main():
    p = Parameters()
    parser=argparse.ArgumentParser()
    parser.add_argument("--trial", choices=("v1","v2"), default="v2")
    trial=parser.parse_args().trial
    # Photo left/right is local Y; photo height across the split is local X.
    reduction = (3.0,3.0) if trial=="v1" else (3.0,2.0)
    suffix = "minus_3mm" if trial=="v1" else "fit_v2"
    folder = "neck-minus-3mm" if trial=="v1" else "neck-fit-v2"
    opening = (p.neck_x+p.neck_clearance-reduction[0],
               p.neck_y+p.neck_clearance-reduction[1])
    out = ROOT/"print"/"fit-trials"/folder
    out.mkdir(parents=True, exist_ok=True)
    shapes = {f'neck_cap_{suffix}': collar(p, True, reduction),
              f'handle_anchor_{suffix}': handle_anchor(p, reduction)}
    cap = shapes[f'neck_cap_{suffix}'].rotate(
        (p.neck_cx,p.neck_cy,0), (p.neck_cx,p.neck_cy,1), 180)
    pair = shapes[f'handle_anchor_{suffix}'].union(cap)
    # Probe the clear opening and both sets of opposing walls away from the split.
    cx,cy=p.neck_cx,p.neck_cy
    ix,iy=opening[0]/2,opening[1]/2
    clear=box(cx-ix+.01,cx+ix-.01,cy-iy+.01,cy+iy-.01,-11,11)
    assert pair.intersect(clear).val().Volume() < 1e-6
    for x,y in ((cx-ix-.1,cy),(cx+ix+.1,cy),
                (cx-2,cy-iy-.1),(cx-2,cy+iy+.1)):
        assert pair.intersect(box(x-.04,x+.04,y-.04,y+.04,-1,1)).val().Volume()>0
    records=[]
    for name,shape in shapes.items():
        assert shape.val().isValid() and len(shape.val().Solids())==1
        path=out/f'{name}.stl'
        cq.exporters.export(print_orientation(name,shape),str(path),
                            tolerance=.045,angularTolerance=.12)
        export_step(shape,out/f'{name}.step')
        mesh=trimesh.load_mesh(path)
        assert mesh.is_watertight and mesh.volume>0
        records.append({'file':path.name,'quantity':1,'watertight':True,
                        'bounds_mm':mesh.extents.round(3).tolist()})
    report={'opening_mm_local_xy':opening,
            'photo_opening_width_height_mm':[opening[1],opening[0]],
            'reduction_per_axis_mm_local_xy':reduction,
            'outer_faces_and_bolt_centers':'unchanged',
            'status':'fit trial; conflicts with earlier 14 x 19 mm shaft measurement',
            'opening_and_wall_probes':'passed','parts':records}
    (out/'manifest.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(report,indent=2))


if __name__=='__main__':
    main()

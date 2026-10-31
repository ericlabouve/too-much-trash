"""Reversible single-eye TPU neck clip; physical snap/retention unqualified."""
import cadquery as cq

BORE = 4.0  # Half the former 8 mm diameter, not half its area.
EYE_Y = 13.3
THICKNESS = 6.0
OPENING_X, OPENING_Y = 12.8, 17.8
WALL = 1.6
MOUTH = 13.0

def guide():
    """Exact approved mesh as a faceted solid; local roof edits are reproducible
    with study_clip_roof45_fit.py. Do not substitute the earlier loose clip."""
    from pathlib import Path
    import trimesh
    from OCP.BRepBuilderAPI import BRepBuilderAPI_Sewing
    mesh = trimesh.load_mesh(Path(__file__).resolve().parents[1] / 'review/concepts/straight-arm-clip-45/clip.stl')
    sew = BRepBuilderAPI_Sewing(1e-5)
    for tri in mesh.triangles:
        wire = cq.Wire.makePolygon([cq.Vector(*v) for v in tri], close=True)
        sew.Add(cq.Face.makeFromWires(wire).wrapped)
    sew.Perform()
    shell = cq.Shape.cast(sew.SewedShape())
    solid = cq.Solid.makeSolid(shell)
    assert solid.isValid()
    return cq.Workplane('XY').newObject([solid]).translate((0,0,-THICKNESS/2))

def placed(shape, z, side='near'):
    # Flip end-for-end around X: same snap mouth, eye on the opposite side.
    if side == 'far': shape = shape.rotate((0,0,0),(1,0,0),180)
    return shape.translate((0,0,z))

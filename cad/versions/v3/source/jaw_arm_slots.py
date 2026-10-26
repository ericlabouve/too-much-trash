"""Candidate arm slots with 35-degree roofs in approved bed orientations."""
import math
import cadquery as cq

def refine(shape,name):
    # XY polygons extruded through the 4 mm plate thickness (CAD Z).
    # Fixed builds toward -X; sliding builds toward +X.
    rise=3*math.tan(math.radians(35))
    if name=='carrier':
        points=[(-36,-3),(-56,-3),(-56-rise,0),(-56,3),(-36,3),(-34,0)]
        z0,z1=21.5,26.5
    elif name=='sliding_jaw':
        points=[(12,0),(14,-3),(38,-3),(38+rise,0),(38,3),(14,3)]
        z0,z1=26,31
    else:raise ValueError(name)
    cutter=cq.Workplane('XY').polyline(points).close().extrude(z1-z0).translate((0,0,z0))
    return shape.cut(cutter).clean()

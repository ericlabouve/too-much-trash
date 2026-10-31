"""Paired wall windows with 35-degree roofs across the wall thickness."""
import math
import cadquery as cq

def refine(shape):
    # CAD X decreases with print height; X12 is the approved bed plane.
    # The roof closes across 5 mm wall thickness, not the 64 mm slot length.
    peak=-2.5*math.tan(math.radians(35))
    outside=math.tan(math.radians(35))
    cutter=(cq.Workplane('XY').polyline([(5,7.8),(5,14.8),(outside,14.8),(peak,11.3),(outside,7.8)])
            .close().extrude(64).translate((0,0,-17)))
    return shape.cut(cutter).cut(cutter.mirror('XZ')).clean()

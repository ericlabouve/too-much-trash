"""Optional flush-width fins; CAD +X is sliding-jaw print height."""
import math
import cadquery as cq

def tabs():
    from model import box
    k=math.tan(math.radians(35))
    # No wraparound skirt. Ends share the fixed rail's Y +/-13.8 edges.
    # Retain 0.4 mm clearance above rail top Z34.
    wing=box(-10,-.5,7,13.8,34.4,36.4)
    ramp=(cq.Workplane('XY').polyline([
        (-10,7),(-10,7.5),(-10+6.3*k,13.8),(-.5,13.8),(-.5,7)])
        .close().extrude(50))
    wing=wing.intersect(ramp).clean()
    return wing.union(wing.mirror('XZ')).clean()

def refine(shape):return shape.union(tabs()).clean()

"""Bed-referenced ramps; X increases with sliding-jaw build height."""
import math
import cadquery as cq

JAW_SUPPORT_ANGLE = 35.0  # User-selected memorable angle, measured from print bed.

def band_slot_stem(angle=JAW_SUPPORT_ANGLE):
    """Uncapped sliding post; mirror about YZ for the fixed band anchor."""
    rise=math.tan(math.radians(angle))
    return (cq.Workplane('XZ').polyline([
        (-10,38.5),(-10+3.25*rise,41.75),(-10,45),(-3,45),(-3,38.5)])
        .close().extrude(7.5,both=True))

def refine(s, angle):
    from model import box
    rise=math.tan(math.radians(angle))
    s=s.cut(box(-11,0,-10.1,10.1,38.5,48))
    stem=band_slot_stem(angle)
    # Restore the original lower projection; only the top cap is removed.
    s=s.union(stem).union(box(-10,-.5,-7.5,7.5,32,38.5))
    for sign in (-1,1):
        wedge=(cq.Workplane('XY').polyline([
            (-6-3*rise,sign*7),(-6,sign*10),(-6,sign*7)])
            .close().extrude(4).translate((0,0,26.4)))
        s=s.union(wedge)
    return s.clean()

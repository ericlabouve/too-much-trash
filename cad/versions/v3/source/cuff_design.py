"""Physically tested common 21.6 mm TPU cuff and revised ramped rigid stud.

Local +X opens toward the phone; Y runs along its edge; Z is thickness.
The integrated assembly retains a fixed rear datum, not phone-specific cuffs.
"""
from functools import lru_cache
import math
from jaw_support_angles import JAW_SUPPORT_ANGLE
import cadquery as cq
from shared_key_design import box, key_blank

SCALE=1.2
CUFF_Z=11.28
CUFF_WIDTH=21.6
FIXED_CUFF_Y=0.0  # Centered: integral stud has no rear key to hit the neck.
FIXED_CUFF_X=-18.2  # Flush backing plane at X -11.3; formerly -20/-13.1.
CUFF_INWARD_SHIFT=1.8
SLIDING_CUFF_Y=(-50.,50.)
SLIDING_CUFF_X=-.3  # Keep enlarged return tips outside the camera proxy at X+2.
STUD_SUPPORT_ANGLE = JAW_SUPPORT_ANGLE

@lru_cache(None)
def cuff_components():
    profile=(cq.Workplane('XZ').moveTo(1.7,7.05)
        .bezier([(-.3,7.7),(-5.6,7.2),(-5.6,3.7)],includeCurrent=True)
        .lineTo(-5.6,-3.7)
        .bezier([(-5.6,-7.2),(-.3,-7.7),(1.7,-7.05)],includeCurrent=True)
        .bezier([(2,-6.15),(1.7,-5.6)],includeCurrent=True)
        .bezier([(.3,-5.55),(-2.3,-5.6),(-2.65,-3.5)],includeCurrent=True)
        .bezier([(-3.1,-1.3),(-3.1,1.3),(-2.65,3.5)],includeCurrent=True)
        .bezier([(-2.3,5.6),(.3,5.55),(1.7,5.6)],includeCurrent=True)
        .bezier([(2,6.15),(1.7,7.05)],includeCurrent=True).close())
    shell=cq.Workplane(obj=profile.extrude(CUFF_WIDTH/2/SCALE,both=True).val().scale(SCALE))
    shell=shell.cut(box(-20,3,-3.4,3.4,-3.4,3.4))
    shell=shell.cut(box(-5.42,3,-4.8,4.8,-3.4,3.4))
    rib=(cq.Workplane('XZ').moveTo(-3,2.7)
        .bezier([(-1.7,3),(-.7,4.05)],includeCurrent=True)
        .lineTo(.25,5).bezier([(.45,5.2),(.2,5.42)],includeCurrent=True)
        .bezier([(-.4,5.8),(-2.3,5.3),(-3,4.2)],includeCurrent=True)
        .close().extrude((CUFF_WIDTH-.48)/2/SCALE,both=True))
    seats=cq.Workplane(obj=rib.union(rib.mirror('XY')).val().scale(SCALE))
    return shell,seats

@lru_cache(None)
def cuff():
    shell,seats=cuff_components()
    return shell.union(seats)

def cuff_key():
    return key_blank().translate((-22.82,-8,-.3))

def socket():
    return box(-9.2,-6.9,-CUFF_WIDTH/2,CUFF_WIDTH/2,-5.8,5.8).union(integral_stud())

def integral_stud():
    """Common stud; optional support-free ramp stays inside the cuff recess."""
    if STUD_SUPPORT_ANGLE is not None:
        peak = -5.42 + 1.4 * math.tan(math.radians(STUD_SUPPORT_ANGLE))
        assert peak < -3.9
        head=(cq.Workplane('XY').polyline([
            (-5.42,-3.2),(peak,-4.6),(-3.9,-4.6),
            (-3.9,4.6),(peak,4.6),(-5.42,3.2)])
            .close().extrude(3.2,both=True))
        return box(-7.4,-5.42,-3.2,3.2,-3.2,3.2).union(head)
    head=(cq.Workplane('XY').polyline([(-5.42,-4.6),(-4.65,-4.6),(-3.9,-3.2),
                                     (-3.9,3.2),(-4.65,4.6),(-5.42,4.6)])
          .close().extrude(3.2,both=True))
    stem=box(-7.4,-4.8,-3.2,3.2,-3.2,3.2).edges().fillet(.25)
    return stem.union(head)

def locate(shape,edge_x,y,fixed=False):
    if fixed:shape=shape.rotate((0,0,0),(0,0,1),180)
    return shape.translate((edge_x,y,CUFF_Z))

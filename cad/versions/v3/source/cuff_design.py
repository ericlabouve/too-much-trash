"""Approved enlarged cuff, reused without resizing its key interface.

Local +X opens toward the phone; Y runs along its edge; Z is thickness.
The integrated assembly retains a fixed rear datum, not phone-specific cuffs.
"""
from functools import lru_cache
import cadquery as cq
from shared_key_design import box, key_blank

SCALE=1.2
CUFF_Z=11.28
FIXED_CUFF_Y=16.0  # User-approved offset clears the stock neck from key tip.
SLIDING_CUFF_Y=(-50.,50.)
SLIDING_CUFF_X=-.3  # Keep enlarged return tips outside the camera proxy at X+2.

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
    shell=cq.Workplane(obj=profile.extrude(5,both=True).val().scale(SCALE))
    shell=shell.cut(box(-12,3,-1.7,1.7,-1.7,1.7))
    shell=shell.cut(box(-5.02,3,-3.7,3.7,-1.7,1.7))
    rib=(cq.Workplane('XZ').moveTo(-3,2.7)
        .bezier([(-1.7,3),(-.7,4.05)],includeCurrent=True)
        .lineTo(.25,5).bezier([(.45,5.2),(.2,5.42)],includeCurrent=True)
        .bezier([(-.4,5.8),(-2.3,5.3),(-3,4.2)],includeCurrent=True)
        .close().extrude(4.8,both=True))
    seats=cq.Workplane(obj=rib.union(rib.mirror('XY')).val().scale(SCALE))
    return shell,seats

@lru_cache(None)
def cuff():
    shell,seats=cuff_components()
    return shell.union(seats)

def cuff_key():
    return key_blank().translate((-22.82,-8,-.3))

def socket():
    return (box(-10.8,-6.8,-5.4,5.4,-4.1,4.1).edges('|X').fillet(.5)
            .cut(box(-16,-6,-1.7,1.7,-1.7,1.7)))

def locate(shape,edge_x,y,fixed=False):
    if fixed:shape=shape.rotate((0,0,0),(0,0,1),180)
    return shape.translate((edge_x,y,CUFF_Z))

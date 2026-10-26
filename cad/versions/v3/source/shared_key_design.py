"""Axle TPU T/V snap key; historical cuff keys use the original blank."""
from functools import lru_cache
import cadquery as cq

def box(a,b,c,d,e,f):
    return cq.Workplane('XY').box(b-a,d-c,f-e).translate(((a+b)/2,(c+d)/2,(e+f)/2))

@lru_cache(None)
def key_blank():
    key=box(7,18.6,6.5,9.5,-1.2,1.8).edges().fillet(.2)
    key=key.union(box(18,19.2,4.5,11.5,-1.2,1.8).edges().fillet(.2))
    return key.cut(box(8,9,6.4,7.1,-1.3,1.9)).cut(box(8,9,8.9,9.6,-1.3,1.9))

@lru_cache(None)
def snap_key():
    """Prototype95A flex arms. Flat3 mm thickness; no elastic-force claim.

    Insert toward decreasing u. The V apex leads, free arms trail outside
    the axle. Pinch both free arms inward to remove; do not pull forcibly.
    """
    stem=box(8.9,18.6,6.5,9.5,-1.2,1.8).edges('|Z').fillet(.15)
    spine=box(4.8,9.3,7.5,8.5,-1.2,1.8)
    head=box(18,19.2,4.5,11.5,-1.2,1.8).edges('|Z').fillet(.2)
    # Open channels separate the return arms from the central spine.
    arm=(cq.Workplane('XY').polyline([(4.5,7.8),(4.8,7.5),
          (8.8,5.5),(8.8,6.5),(5.3,8.2)]).close().extrude(3).translate((0,0,-1.2)))
    other=arm.mirror('XZ').translate((0,16,0))
    return stem.union(spine).union(head).union(arm).union(other).clean()

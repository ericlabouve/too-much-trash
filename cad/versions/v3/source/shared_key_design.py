"""One 12.2 mm T-key for both cuff sockets and pulley axle; mm in u/v/w."""
from functools import lru_cache
import cadquery as cq

def box(a,b,c,d,e,f):
    return cq.Workplane('XY').box(b-a,d-c,f-e).translate(((a+b)/2,(c+d)/2,(e+f)/2))

@lru_cache(None)
def key_blank():
    key=box(7,18.6,6.5,9.5,-1.2,1.8).edges().fillet(.2)
    key=key.union(box(18,19.2,4.5,11.5,-1.2,1.8).edges().fillet(.2))
    return key.cut(box(8,9,6.4,7.1,-1.3,1.9)).cut(box(8,9,8.9,9.6,-1.3,1.9))

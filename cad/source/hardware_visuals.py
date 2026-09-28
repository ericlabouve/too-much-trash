"""Recognizable purchased-hardware references; not supplier drawings or printable parts.

Circumferential thread marks are cosmetic, not a manufacturing thread form.
"""
import math
from functools import lru_cache
import cadquery as cq


def orient(s,origin,direction):
    axis=cq.Vector(*direction).normalized();cross=cq.Vector(0,0,1).cross(axis)
    if cross.Length>1e-8:s=s.rotate((0,0,0),cross.toTuple(),math.degrees(math.acos(max(-1,min(1,axis.z)))))
    elif axis.z<0:s=s.rotate((0,0,0),(1,0,0),180)
    return s.translate(origin)


def compound(*shapes):
    return cq.Workplane('XY').newObject([cq.Compound.makeCompound([s.val() for s in shapes])])


@lru_cache(maxsize=128)
def threaded_local(d,length):
    # Shallow rings make threaded versus smooth shanks legible without huge B-reps.
    r=d/2
    outline=[(0,0),(r,0)]
    for i in range(1,int(length/1.4)):
        z=i*1.4
        outline.extend([(r,z-.12),(r-.12,z),(r,z+.12)])
    outline.extend([(r,length),(0,length)])
    return cq.Workplane('XZ').polyline(outline).close().revolve(360,(0,0),(0,1))



def threaded(a,b,d):
    axis=cq.Vector(*b).sub(cq.Vector(*a))
    return orient(threaded_local(d,round(axis.Length,6)),a,axis.toTuple())


@lru_cache(maxsize=128)
def ring(origin,direction,od,id,length):
    return orient(cq.Workplane('XY').circle(od/2).circle(id/2).extrude(length),origin,direction)


@lru_cache(maxsize=128)
def nut(origin,direction,af,bore,length):
    s=cq.Workplane('XY').polygon(6,af/math.cos(math.pi/6)).extrude(length)
    s=s.edges('|Z').chamfer(.15).cut(cq.Workplane('XY').circle(bore/2).extrude(length))
    return orient(s,origin,direction)


@lru_cache(maxsize=128)
def socket_head(origin,direction,d,length,key):
    s=cq.Workplane('XY').circle(d/2).extrude(length).edges('%Circle').fillet(.25)
    s=s.cut(cq.Workplane('XY').polygon(6,key/math.cos(math.pi/6)).extrude(length*.65))
    return orient(s,origin,direction)


@lru_cache(maxsize=128)
def bolt_set(a,b,d,washer_positions,nut_position):
    axis=cq.Vector(*b).sub(cq.Vector(*a)).normalized();v=axis.toTuple()
    headstart=cq.Vector(*a).sub(axis.multiply(d)).toTuple()
    pieces=[threaded(a,b,d),socket_head(headstart,v,5.5 if d==3 else d*1.75,d,2.5 if d==3 else d*.75)]
    for pos in washer_positions:pieces.append(ring(pos,v,6 if d==3 else d*2.2,d+.2,.5 if d==3 else .8))
    pieces.append(nut(nut_position,v,7 if d==4 else 5.5,d+.1,3.2 if d==4 else 2.4))
    return compound(*pieces)


@lru_cache(maxsize=128)
def thumbwheel():
    s=cq.Workplane('YZ').circle(8).extrude(5).translate((13,40,-4))
    for i in range(20):
        a=i*2*math.pi/20
        cutter=cq.Solid.makeCylinder(.55,7,cq.Vector(12,40+8*math.cos(a),-4+8*math.sin(a)),cq.Vector(1,0,0))
        s=s.cut(cutter)
    return s


def hollow_strap(attach):
    # Hook-and-loop band wrapping the trigger, including overlap tab. No texture claims.
    x,y,z=attach
    outer=cq.Workplane('XY').box(14,28,16).edges('|X').fillet(3)
    inner=cq.Workplane('XY').box(16,24,12).edges('|X').fillet(2)
    loop=outer.cut(inner).translate((x,y,z))
    tab=cq.Workplane('XY').box(10,14,1).edges('|Z').fillet(1).translate((x,y,z+8.5))
    return loop.union(tab)


def stranded(a,b,d=1.6):
    """Seven parallel strand envelopes; strand lay is deliberately simplified."""
    axis=cq.Vector(*b).sub(cq.Vector(*a));length=axis.Length
    wires=[cq.Workplane('XY').circle(d/6).extrude(length)]
    for i in range(6):
        t=i*math.pi/3
        wires.append(cq.Workplane('XY').center(d/3*math.cos(t),d/3*math.sin(t)).circle(d/6).extrude(length))
    return orient(compound(*wires),a,axis.toTuple())

"""Six editable printable designs; the shared neck cap is printed twice."""
import cadquery as cq
from parameters import Parameters


def box(x0,x1,y0,y1,z0,z1):
    return cq.Workplane('XY').box(x1-x0,y1-y0,z1-z0).translate(((x0+x1)/2,(y0+y1)/2,(z0+z1)/2))


def bore(origin, direction, length, diameter):
    return cq.Solid.makeCylinder(diameter/2,length,cq.Vector(*origin),cq.Vector(*direction))


def xz_profile(points,y0,y1):
    return cq.Workplane('XZ').polyline(points).close().extrude(y1-y0).translate((0,y1,0))


def slot_y(x,y0,y1,z0,z1,d):
    return (box(x-d/2,x+d/2,y0,y1,z0,z1)
            .union(bore((x,y0,z0),(0,0,1),z1-z0,d))
            .union(bore((x,y1,z0),(0,0,1),z1-z0,d)))


def slot_z_x(x0,x1,y,z0,z1,d):
    return (box(x0,x1,y-d/2,y+d/2,z0,z1)
            .union(bore((x0,y,z0),(1,0,0),x1-x0,d))
            .union(bore((x0,y,z1),(1,0,0),x1-x0,d)))


def collar(p,cap=False):
    cx,cy=p.neck_cx,p.neck_cy
    gx,gy=(p.neck_x+p.neck_clearance)/2,(p.neck_y+p.neck_clearance)/2
    outer_x=gx+4
    outer_y=gy+4
    x0,x1=(-outer_x,-0.3) if cap else (0.3,outer_x)
    s=box(x0,x1,-outer_y,outer_y,-12,12)
    s=s.cut(box(-gx,gx,-gy,gy,-13,13))
    for yy in (-outer_y-5,outer_y+5):
        ear=box(x0,x1,yy-5.5,yy+5.5,-4.5,4.5).edges('|X').fillet(1.5)
        s=s.union(ear).cut(bore((x0-1,yy,0),(1,0,0),x1-x0+2,p.m4))
    return s.translate((cx,cy,0))


def carrier(p):
    # Light ladder bridge supports the jaw slide; open middle saves material.
    s=box(8,94,20,60,-12,-8.4).edges('|Z').fillet(2)
    for xx in (39,66):
        s=s.cut(box(xx,xx+19,31,49,-13,-8))
    # Two open-ended guides, .4 mm vertical/.3 mm lateral running clearance.
    for ya,yb in ((20,24.7),(55.3,60)):
        s=s.union(box(8,94,ya,yb,-8.4,0.4))
    for ya,yb in ((20,27),(53,60)):
        s=s.union(box(8,94,ya,yb,0.4,2.0))
    # Flat padded side face, rear ledge, and narrow front escape-catch lip.
    # Assembly rotates this source: low source Z is the phone camera/back face.
    profile=[(8,0),(24,0),(24,2),(14,2),(14,24),(16,24),(16,25),(8,25)]
    s=s.union(xz_profile(profile,28,52))
    # Draw screw reacts on fixed boss; head/washer remain accessible on left.
    s=s.union(box(8,15,28,52,-8.4,2))
    s=s.cut(bore((7,40,-4),(1,0,0),10,p.m4))
    # Near-side module rail, behind phone in assembled orientation.
    s=s.union(box(-8,0,22,117,-12,-2))
    s=s.union(box(-8,10,27,53,-12,-2))
    rail_slot=box(-9,1,57,113,-7.7,-4.3)
    for yy in (57,113):
        rail_slot=rail_slot.union(bore((-9,yy,-6),(1,0,0),10,p.m3))
    s=s.cut(rail_slot)
    # Tether eye stays outside screen/phone outline; no length-specific end stop.
    s=s.cut(bore((-4,24,-13),(0,0,1),12,3))
    # Thumb-wheel recess before translating the grip clear of collar lugs.
    s=s.cut(box(-5,8,31.5,48.5,-12.5,4.5))
    s=s.cut(bore((7,40,-4),(1,0,0),10,p.m4))
    s=s.translate((10,0,0))
    # Clear far-side carriage fasteners on narrow/thin phones; retain the long guide lands.
    s=s.cut(box(96,105,53,61,-13,3).edges('|Z').fillet(1))
    # Integral neck saddle and short bridge; both actuator sides clear its lugs.
    s=s.union(collar(p))
    s=s.union(box(-16,20,27,53,-12,-8.4))
    for yy in (27,49):
        s=s.union(xz_profile([(-13,8),(19,0),(-13,-8)],yy,yy+4))
    s=s.cut(box(5,18,31.5,48.5,-12.5,4.5))
    return s


def sliding_jaw(p):
    # Valley at X=0; translate to jaw_x during assembly.
    s=box(-65,6,25,55,-8,0).edges('|Z').fillet(1)
    profile=[(6,0),(-10,0),(-10,2),(0,2),(0,24),(-2,24),(-2,25),(6,25)]
    s=s.union(xz_profile(profile,28,52))
    # Matching far-side interface lets the same actuator move to this jaw.
    s=s.union(box(0,22,28,52,-8,0))
    s=s.union(box(14,22,28,117,-12,-2))
    rail_slot=box(13,23,57,113,-7.7,-4.3)
    for yy in (57,113):
        rail_slot=rail_slot.union(bore((13,yy,-6),(1,0,0),10,p.m3))
    s=s.cut(rail_slot)
    # Continuous axial clearance for M4 draw screw, plus top-loading nut pocket.
    s=s.cut(bore((-66,40,-4),(1,0,0),73,p.m4))
    s=s.cut(box(-60.3,-56,36.25,43.75,-7.7,0.5))
    # Remove unloaded middle while keeping longitudinal guide lands and nut boss.
    s=s.cut(box(-50,-18,31,35,-9,1))
    s=s.cut(box(-50,-18,45,49,-9,1))
    return s


def actuator_bracket(p):
    # Plate slides along Y on carrier; paired vertical slots set depth.
    s=box(-6,-0.4,-12,12,-22,24)
    s=s.cut(box(-7,0,-4.7,4.7,10,25))  # swing window
    for yy in (-8,8):
        s=s.cut(slot_z_x(-7,1,yy,-18,3,p.m3))
    for ya,yb in ((-10,-5),(5,10)):
        s=s.union(box(-6,17,ya,yb,13,24))
    s=s.cut(bore((11,-11,19),(0,1,0),22,3.2))
    # Fixed housing reaction: ferrule shoulder + inner-wire-only exit.
    s=s.union(box(-13,-1,-4.8,4.8,-6,3))
    # Continue the entry relief through the lower plate so housing/ferrule clear it.
    # The shoulder at Z=0 and inner-wire-only exit are unchanged.
    s=s.cut(bore((-7,0,-23),(0,0,1),23,p.ferrule))
    s=s.cut(bore((-7,0,-1),(0,0,1),5,p.wire))
    # M3 adjustable positive stop, top-loading square nut pocket.
    s=s.union(box(-3,4,-4,4,2,9))
    s=s.cut(bore((0,0,1),(0,0,1),9,p.m3))
    s=s.cut(box(-2.9,2.9,-2.9,2.9,3,5.6))
    s=s.cut(box(-3.5,0,-2.9,2.9,3,5.6))  # side insertion
    # Return-spring fixed leg seat (torsion spring on metal pivot).
    s=s.cut(bore((14,4,15),(0,1,0),7,1.4))
    # Positive released position: ledge above the input arm.
    s=s.union(box(-4,2,-10,-5,22,26))
    s=s.union(box(-4,2,-5,3,22,26))
    return s


def rocker(p):
    # Metal pivot on Y. Cable pulls -Z at x=-7; clockwise swing pushes tip +X.
    pts=[(-11,16),(-11,22),(12,22),(15,19),(15,4),(7,4),(7,16)]
    s=xz_profile(pts,-2,2)
    s=s.union(cq.Workplane('XZ').center(11,19).circle(5).extrude(4).translate((0,2,0)))
    s=s.cut(bore((11,-3,19),(0,1,0),6,3.2))
    # M3 contact screw + ordinary nut/jam nut; short padded contact, no printed pin.
    s=s.cut(bore((6,0,7),(1,0,0),10,p.m3))
    # Cable passes through arm; screw-on cable barrel above it takes tension.
    s=s.cut(bore((-7,0,15),(0,0,1),8,p.wire))
    s=s.cut(bore((7,-3,19),(0,1,0),6,1.4))  # moving spring leg seat
    return s


def handle_anchor(p):
    # Trigger-facing -X neck face; housing centered across its Y width.
    s=collar(p,True)
    x,y=p.cable_face_x,p.neck_cy
    s=s.union(box(x-6,x+6,y-7,y+7,-12,12))
    s=s.cut(bore((x,y,3),(0,0,1),10,p.ferrule))
    s=s.cut(bore((x,y,-13),(0,0,1),17,p.wire))
    return s


def all_parts(p):
    return {'carrier':carrier(p),'sliding_jaw':sliding_jaw(p),
            'neck_cap':collar(p,True),'actuator_bracket':actuator_bracket(p),
            'rocker':rocker(p),'handle_anchor':handle_anchor(p)}

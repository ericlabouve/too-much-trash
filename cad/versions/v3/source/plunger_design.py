"""Active V3 plunger cassette. Concept coordinates (u,v,w), mm.
Rigid transform: local X=v+8.35, Y=5.4-w, Z=8-u.
The shoe alone turns 90 degrees about the press axis to keep its broad face
across phone thickness after integration. No independent export side effects.
"""
import math
from functools import lru_cache
import cadquery as cq
from shared_key_design import snap_key
PULLEY_U=13.5
PULLEY_V=8
PULLEY_LIFT=2.0
BEARING_TOP=8.2
GROOVE_W=8.6+PULLEY_LIFT
MOUNT_Y=-4.4
BACK_Y=5.4
SHOE_WIDTH=4
KEY_OUTBOARD=2.2
def boot_blend_points(sign=1, count=33):
    """Hyperbolic rational quadratic: vertical at boot, horizontal at neck.

    Weight > 1 selects a hyperbola segment, without the inflection of the old
    cubic S blend. Points are (v,w) before the shoe's 90-degree rotation.
    A spline fits these samples with explicit endpoint tangents in cassette().
    """
    weight=1.4
    points=[]
    for i in range(count):
        t=i/(count-1);a=(1-t)**2;b=2*weight*t*(1-t);c=t*t
        v=(-4*a-4*b+2*c)/(a+b+c)
        radius=(6.5*a+4*b+4*c)/(a+b+c)
        points.append((v,5.4+sign*radius))
    return points
def box(x0,x1,y0,y1,z0,z1):
    return cq.Workplane('XY').box(x1-x0,y1-y0,z1-z0).translate(((x0+x1)/2,(y0+y1)/2,(z0+z1)/2))
def cyl(x,y,z,h,r):
    return cq.Workplane('XY').circle(r).extrude(h).translate((x,y,z))
def ramped_cap(bottom, top, z0, shoulder, z1, radius0, radius1):
    """Rounded retaining rim with a ruled underside, rather than a flat ledge."""
    def wire(bounds,z,r):
        a,b,c,d=bounds
        return box(a,b,c,d,z-1,z).edges('|Z').fillet(r).faces('>Z').wires().val()
    ramp=cq.Workplane('XY').add(wire(bottom,z0,radius0)).add(wire(top,shoulder,radius1)).toPending().loft(ruled=True)
    a,b,c,d=top
    rim=box(a,b,c,d,shoulder,z1).edges('|Z').fillet(radius1)
    return ramp.union(rim).faces('>Z').edges().fillet(.12)
def compound(shapes):
    return cq.Workplane('XY').newObject([cq.Compound.makeCompound([s.val() for s in shapes])])
def tube(points,r):
    pieces=[]
    for a,b in zip(points,points[1:]):
        va,vb=cq.Vector(*a),cq.Vector(*b);d=vb.sub(va)
        if d.Length>1e-8:pieces.append(cq.Workplane('XY').newObject([cq.Solid.makeCylinder(r,d.Length,va,d.normalized())]))
    for a in points:pieces.append(cq.Workplane('XY').sphere(r).translate(a))
    return compound(pieces)


def local_point(q):
    u,v,w=q
    return (v+8.35,5.4-w,8-u)

def local_shape(s):
    return s.rotate((0,0,0),(0,0,1),-90).rotate((0,0,0),(1,0,0),90).translate((8.35,5.4,8))

@lru_cache(None)
def cassette():
    # Open spine replaces deep tray and full cover. Pulley moves to button end.
    body=box(-9,9,0,66,0,3).union(box(0,24,0,18,0,3)).edges('|Z').fillet(1.2).edges('not |Z').fillet(.35)
    body=body.union(box(-8.5,8.5,59,63,2.3,8).edges().fillet(.6))
    # Broad front flange traps the return loop between it and the back spine.
    band_lip=ramped_cap((-8.5,8.5,59,63),(-10.5,10.5,58.5,65),7.2,9.3,9.6,.6,.8)
    body=body.union(band_lip)
    # User's post-print revision: remove the complete outer cheek and fork arm.
    # The remaining boss is 2 mm taller; the approved axle head retains the wheel.
    # No raised rectangular plinth: the surrounding platform stays at w=3.
    body=body.union(cyl(PULLEY_U,8,2.6,BEARING_TOP-2.6,6).edges().fillet(.25))
    body=body.cut(cyl(PULLEY_U,8,-4,20,4.3))
    # No recessed key pocket on the bed face. Move the removable retention
    # features outboard instead; the axle bore remains open through this face.
    # Straight front edge replaces the small rectangular shoe-root notch.
    # Trim the spine back to the former relief depth, leaving the pulley pad.
    body=body.cut(box(-10,9,-1,2.5,-1,3.3))
    # Retain one guide/stop pair immediately before pulley (wheel ends at Y17).
    # Open center lets the raised twine eye pass; shallow lips retain slider edges.
    for a,b,c,d,start,end in [(-7.8,-4.3,-5.5,-3.3,2.5,25.5),(4.3,9,3.3,5.5,18,42)]:
        guide=box(a,b,start,end,2.6,9.5).union(box(c,d,start,end,7.8,9.5)).edges().fillet(.25)
        body=body.union(guide)
    # The highlighted +u guide is flush with the spine edge, then extends
    # toward the band end. A smooth taper clears the existing return-band path.
    support=(cq.Workplane('YZ').moveTo(41,2.6).lineTo(55,2.6)
             .lineTo(55,3.25).bezier([(50,3.25),(47,9.5),(42,9.5)],includeCurrent=True)
             .lineTo(41,9.5).close().extrude(4.7).translate((4.3,0,0)))
    body=body.union(support.edges('|X').fillet(.2))
    # Fill the highlighted long guide to the existing guide height. Continue
    # its inward lip above the slider, leaving 0.4 mm vertical running space.
    # Independent return stop: the plain stem hits it before the fixed band
    # anchor. It is not a button-safe press stop or trigger overtravel device.
    body=body.union(box(-3.8,3.8,51,54,2.6,7.4).edges().fillet(.3))
    # Shared cleat removes the unused separate band yoke.
    slider=box(-4,4,10,49,3.4,7.4)
    # Shoe/root share the slider's 4 mm print-plane thickness. The perpendicular
    # 16 mm contact span and 4 mm press-axis depth remain unchanged.
    # Curved haunches extend below the frame, avoiding its back and the low pulley.
    slider=slider.union(box(-4,4,0,10,3.4,7.4))
    shoe=box(-SHOE_WIDTH/2,SHOE_WIDTH/2,-8,-4,-2.6,13.4).edges('|Y').fillet(1.5)
    # Before rotation, the neck's 8 mm width is represented by w=1.4..9.4.
    # Each concave sweep meets the boot's straight rear face at its rounded
    # corner tangent (radius 6.5), and reaches the 8 mm neck at v=2.
    upper=boot_blend_points(1);lower=boot_blend_points(-1)
    root=(cq.Workplane('YZ').moveTo(*upper[0])
          .spline(upper[1:],includeCurrent=True,tangents=[(0,-1),(1,0)])
          .lineTo(*lower[-1])
          .spline(list(reversed(lower[:-1])),includeCurrent=True,tangents=[(-1,0),(0,-1)])
          .close().extrude(SHOE_WIDTH).translate((-SHOE_WIDTH/2,0,0)))
    root=root.rotate((0,0,5.4),(0,1,5.4),90)
    shoe=shoe.rotate((0,0,5.4),(0,1,5.4),90)
    slider=slider.union(root).union(shoe)
    slider=slider.edges().fillet(.3)
    # Solid wrap cleat near the T: broad root, rounded cap, no through-hole.
    cleat_stem=box(-2.5,2.5,44,48,7.1,13.1).edges('|Z').fillet(.7).edges('not |Z').fillet(.25)
    cleat_cap=ramped_cap((-2.5,2.5,44,48),(-4.5,4.5,42,50),12.8,14.9,15.3,.7,1)
    slider=slider.union(cleat_stem).union(cleat_cap)
    # Pulley prints opposite the bracket's w direction. Taper both groove
    # flanks at atan(1.6/2.2)=36.0 degrees to the bed. Double groove depth
    # from 1.1 to 2.2 mm, preserving diameter, width, bore and bearing faces.
    pulley=cq.Workplane('XZ').polyline([(4.3,6.6),(9,6.6),(9,6.8),(6.8,8.4),(6.8,8.8),(9,10.4),(9,10.6),(4.3,10.6)]).close().revolve(360,(0,0),(0,1)).edges().fillet(.09).translate((PULLEY_U,8,PULLEY_LIFT))
    axle=cyl(PULLEY_U,8,-3.6-KEY_OUTBOARD,16.8+KEY_OUTBOARD,4).union(cyl(PULLEY_U,8,13.2,1.6,5.5).edges().fillet(.2))
    axle=axle.cut(box(3,23,6.3,9.7,-1.4-KEY_OUTBOARD,2-KEY_OUTBOARD))
    # TPU T stop plus flexible leading V; axle and seated T stop unchanged.
    # Keeper remains pending physical snap/creep qualification.
    key=snap_key().translate((0,0,-KEY_OUTBOARD))
    
    # Flush-T cap: move mount bar 10 mm inward; keep the mechanism/shoe fixed.
    # One closed screw bore; user removed the rail locating lugs.
    # Clamp preload and surface friction alone resist sliding and rotation.
    # Offset the mount, not the mechanism, to put the plate and spine on one
    # flat Y5.4 print face. Keep 5.4 mm beside the 8.8 mm bore on this side.
    # Flat cap face is now 1.8 mm lower. Extend only the bearing plate;
    # mechanism, shoe, bore, screw and nut keep their assembly positions.
    plate=box(30.2,38,MOUNT_Y-10,BACK_Y,17,35).edges('|X').fillet(1.2)
    plate=plate.union(box(32,48,2.4,5.4,12,17.8).edges('|X').fillet(.6))
    bracket=local_shape(body).union(plate)
    # Broad tapered haunch replaces the narrow mounting-foot load path.
    # Its end eases into the spine in height and width, rather than ending in
    # a raised lip. The blend ends below the existing rounded spine edge.
    haunch=(cq.Workplane('XY').moveTo(32.2,-6.2).lineTo(38,-6.2)
             .bezier([(48,-6.2),(56,2.4),(64,2.4)],includeCurrent=True)
             .lineTo(64,5.4).lineTo(32.2,5.4).close().extrude(8)
             .translate((0,0,12.5)).edges('|Z').fillet(1.2)
             .edges('not |Z').fillet(.6))
    easing=(cq.Workplane('XZ').moveTo(30,0).lineTo(66,0)
            .lineTo(66,16.65).lineTo(64,16.65)
            .bezier([(58,16.65),(52,20.5),(46,20.5)],includeCurrent=True)
            .lineTo(30,20.5).close().extrude(30,both=True))
    haunch=haunch.intersect(easing)
    bracket=bracket.union(haunch)
    # Small edge relief where the flush wing passes the back spine. Retain the
    # guide lips and full plunger channel; 0.2 mm nominal clearance to the wing.
    # Carry the rail-clearance edge all the way to the front: one straight
    # side meets the straight front, rather than two rectangular edge notches.
    bracket=bracket.cut(box(7.3,32.2,2.2,5.6,15.8,17.1))
    # Preserve the full 18 mm nut turning/withdrawal envelope with 0.3 mm
    # radial margin. Its curved relief removes less support than a deep box.
    bracket=bracket.cut(cq.Workplane('XY').newObject([
        cq.Solid.makeCylinder(9.3,40,cq.Vector(38,MOUNT_Y,26),cq.Vector(1,0,0))]))
    # No bracket fairleads, no lower tray: cord leaves directly for the shaft guide.
    # Open travel channel through the mounting plate; rail bearing lands stay
    # below it. Cut holes last so added support never refills their bores.
    # Do not carry the old broad opening through the new +u guide/lip: its
    # minimum Z=5 now clears the central channel without erasing that wall.
    bracket=bracket.cut(box(31,49,-7.4,2.4,5,11))
    bracket=bracket.cut(cq.Workplane('XY').newObject([cq.Solid.makeCylinder(4.4,12,cq.Vector(27,MOUNT_Y,26),cq.Vector(1,0,0))]))
    return {'actuator_bracket':bracket,'plunger':local_shape(slider),'pulley':local_shape(pulley),'pulley_axle':local_shape(axle),'pulley_key':local_shape(key)}

def return_path(d=0):
    points=[(0,64,5.4),(7.8,64,5.4),(9.214,63.414,5.4),(9.8,62,5.4),(9.8,56,7),
       (3.6,48-d,10.1),(3.6,44.5-d,10.1),(2,43-d,10.1),(-2,43-d,10.1),
       (-3.6,44.5-d,10.1),(-3.6,48-d,10.1),(-9.8,56,7),(-9.8,62,5.4),
       (-9.214,63.414,5.4),(-7.8,64,5.4),(0,64,5.4)]
    return [local_point(q) for q in points]

def attachment_path(d=0):
    points=[(0,42.9,11.65),(3.1,42.9,11.65),(3.6,43.4,11.65),(3.6,48.6,11.65),
       (3.1,49.1,11.65),(-3.1,49.1,11.65),(-3.6,48.6,11.65),(-3.6,43.4,11.65),
       (-3.1,42.9,11.65),(-4.5,42.4,11.65),(-4.5,41.4,11.4)]
    return [local_point((u,v-d,w)) for u,v,w in points]

def pulley_path(d=0, target=None):
    # Nominal 2 mm cord sits in the deeper V groove; update both tangencies.
    # Exact tangent avoids a kink/intersection at the entry to the wheel.
    a=(-4.5,41.4-d);c=(PULLEY_U,8);r=8.35
    dx,dy=a[0]-c[0],a[1]-c[1]
    angle=math.atan2(dy,dx)+math.acos(r/math.hypot(dx,dy))
    # Pick the outgoing tangent to the first shaft guide, not an air-bend waypoint.
    end=1.5*math.pi
    if target is not None:
        tx,ty,tz=target;u,v=8-tz,tx-8.35
        end=math.atan2(v-c[1],u-c[0])-math.acos(r/math.hypot(u-c[0],v-c[1]))
        while end<angle:end+=2*math.pi
    pts=[(a[0],a[1],11.4)]
    for i in range(33):
        t=angle+(end-angle)*i/32
        pts.append((c[0]+r*math.cos(t),c[1]+r*math.sin(t),GROOVE_W))
    return [local_point(q) for q in pts]

def keeper_path():
    # Convex taut-loop envelope around key ends and axle, not unsupported bends.
    points=[(17.2,3.7),(17.2,12.3),(21.8,3.7),(21.8,12.3),
            (3.7,7.2),(3.7,8.8),(8.8,4.7),(8.8,11.3)]
    points += [(PULLEY_U+4.8*math.cos(i*math.pi/32),8+4.8*math.sin(i*math.pi/32)) for i in range(64)]
    points=sorted(set(points))
    def cross(a,b,c):return (b[0]-a[0])*(c[1]-a[1])-(b[1]-a[1])*(c[0]-a[0])
    halves=[]
    for ordered in (points,points[::-1]):
        half=[]
        for q in ordered:
            while len(half)>1 and cross(half[-2],half[-1],q)<=0:half.pop()
            half.append(q)
        halves.extend(half[:-1])
    return [local_point((u,v,.3-KEY_OUTBOARD)) for u,v in halves+[halves[0]]]

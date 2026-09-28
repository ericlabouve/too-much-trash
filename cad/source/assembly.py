"""R4 assembly. A rigid installation rotation puts the bridge behind the phone."""
import math
from functools import lru_cache
import hardware_visuals as hv
import cadquery as cq
from parts import box, bore
ORANGE=(.96,.36,.08)
BLUE=(.035,.27,.75)
METAL=(.63,.68,.72)
DARK=(.13,.16,.19)

def phone_transform(s,p):
    return s.rotate((p.neck_cx,0,p.phone_mid_z),(p.neck_cx,1,p.phone_mid_z),180)

def module_raw(s,p):
    if p.actuator_side=='far':
        return s.rotate((0,0,0),(0,0,1),180).translate((p.phone_x_sum-p.module_x_offset,p.button_y,p.actuator_shift))
    return s.translate((p.module_x_offset,p.button_y,p.actuator_shift))

def module(s,p):return phone_transform(module_raw(s,p),p)

def moving(s,p,angle):
    return module(s.rotate((11,0,19),(11,1,19),-math.degrees(angle)),p)

def place(name,s,p,angle=0):
    if name=='handle_anchor':return s.translate((0,0,p.handle_z))
    if name=='handle_cap':
        return s.rotate((p.neck_cx,p.neck_cy,0),(p.neck_cx,p.neck_cy,1),180).translate((0,0,p.handle_z))
    if name=='sliding_jaw':s=s.translate((p.jaw_x,0,0))
    if name=='actuator_bracket':return module(s,p)
    if name=='rocker':return moving(s,p,angle)
    return phone_transform(s,p)

def contact_x(p):return p.phone_left-p.module_x_offset-p.rest_gap

def tip_advance(p,a):return (contact_x(p)-11)*(math.cos(a)-1)+12*math.sin(a)

def stop_angle(p):
    lo,hi=0,.15
    for _ in range(50):
        mid=(lo+hi)/2
        if tip_advance(p,mid)<p.rest_gap+p.safe_button_stroke:lo=mid
        else:hi=mid
    return (lo+hi)/2

def rod(a,b,d):
    v=cq.Vector(*b).sub(cq.Vector(*a))
    return cq.Workplane('XY').newObject([bore(a,v.normalized().toTuple(),v.Length,d)])

@lru_cache(maxsize=32)
def helical_wire(radius,wire_d,height,turns):
    """Round wire along a real helix, centered on local Z."""
    pitch=height/turns
    path=cq.Wire.makeHelix(pitch,height,radius)
    plane=cq.Plane(origin=(radius,0,0),xDir=(1,0,0),
                   normal=(0,1,pitch/(2*math.pi*radius)))
    return cq.Workplane(plane).circle(wire_d/2).sweep(path,isFrenet=True)

@lru_cache(maxsize=16)
def extension_spring(a,b,od):
    # Illustrative purchased spring: coil pitch and eyes are not sourcing specs.
    axis=cq.Vector(*b).sub(cq.Vector(*a));length=axis.Length
    wire=.8;radius=(od-wire)/2;eye=2.5;lead=6
    coil=helical_wire(radius,wire,length-2*lead,24).translate((0,0,lead))
    pieces=[coil.val(),cq.Solid.makeTorus(eye,wire/2,(0,0,eye),(0,1,0)),
            cq.Solid.makeTorus(eye,wire/2,(0,0,length-eye),(0,1,0)),
            rod((eye,0,eye),(radius,0,lead),wire).val(),
            rod((radius,0,length-lead),(eye,0,length-eye),wire).val()]
    shape=cq.Workplane('XY').newObject([cq.Compound.makeCompound(pieces)])
    direction=axis.normalized();cross=cq.Vector(0,0,1).cross(direction)
    if cross.Length>1e-8:
        shape=shape.rotate((0,0,0),cross.toTuple(),math.degrees(math.acos(direction.z)))
    elif direction.z<0:shape=shape.rotate((0,0,0),(1,0,0),180)
    return shape.translate(a)

def phone(p):
    z=2*p.phone_mid_z-p.rear_face_z
    return phone_transform(box(p.phone_left,p.phone_left+p.phone_w,p.phone_y0,p.phone_y0+p.phone_l,z,z+p.phone_t),p)

def trigger_pivot(p):
    return (-27, p.neck_cy, p.handle_z-46)

def trigger_attach(p):
    return (-65, p.neck_cy, p.handle_z-47)

def trigger_shape(p):
    # Stock part envelope, not a printable retrofit. Pivot and contour provisional.
    profile=[(-27,-40),(-39,-41),(-107,-43),(-112,-48),
             (-109,-54),(-99,-55),(-37,-51),(-27,-51)]
    return (cq.Workplane('XZ').polyline([(x,p.handle_z+z) for x,z in profile])
            .close().extrude(14).edges('|Y').fillet(2).translate((0,p.neck_cy+7,0)))

def proxies(p):
    z=2*p.phone_mid_z-p.rear_face_z
    camx=p.phone_left+2 if p.actuator_side=='far' else p.phone_left+p.phone_w-40
    s={'stock_neck':box(p.neck_cx-p.neck_x/2,p.neck_cx+p.neck_x/2,p.neck_cy-p.neck_y/2,p.neck_cy+p.neck_y/2,p.handle_z-30,115),
       'stock_blue_brace':box(-36,-10,26,54,-115,-90),
       'phone_envelope':phone(p),
       'camera_keepout':phone_transform(box(camx,camx+38,p.phone_y0+p.phone_l-43,p.phone_y0+p.phone_l-3,z-4,z),p),
       'stock_blue_handle':box(-30,-8,28,52,p.handle_z-96,p.handle_z-30),
       'stock_blue_grip':rod((-23,40,p.handle_z-88),(-110,40,p.handle_z-108),23),
       'stock_black_trigger':trigger_shape(p),
       'stock_trigger_pivot':rod((-27,31,p.handle_z-46),(-27,49,p.handle_z-46),5)}
    # Illustrative button markers; measured center and depth, provisional size.
    # Outer dimensions remain the fit datum, including the selected case.
    edge=p.phone_left if p.actuator_side=='near' else p.phone_left+p.phone_w
    x0,x1=(edge-.15,edge+.15)
    bz=2*p.phone_mid_z-p.button_z
    for name,yy in (('phone_volume_up',p.button_y),('phone_volume_down',p.button_y-14)):
        s[name]=phone_transform(box(x0,x1,yy-3.5,yy+3.5,bz-1.3,bz+1.3),p)
    arms=[]
    for sign in (-1,1):
        pts=[(-23+sign*x,40,z) for x,z in ((0,110),(25,138),(52,188),(65,230))]
        arms += [rod(a,b,5).val() for a,b in zip(pts,pts[1:])]
        s[f'stock_black_foot_{sign}']=box(-23+sign*65-8,-23+sign*65+8,31,49,227,246)
    s['stock_claws']=cq.Workplane('XY').newObject([cq.Compound.makeCompound(arms)])
    return s

def hardware(p,angle=0):
    raw={'draw_screw_M4':hv.threaded((13,40,-4),(98,40,-4),4),
       'draw_screw_head':hv.thumbwheel(),
       'jaw_nut':box(p.jaw_x-60,p.jaw_x-56.3,36.5,43.5,-7.5,-.5).edges('|X').chamfer(.2).cut(bore((p.jaw_x-61,40,-4),(1,0,0),6,4))}
    # Flat pads contact the two sides and rear ledges. Phone front remains open.
    z0=2*p.phone_mid_z-p.rear_face_z
    for side in ('left','right'):
        x=p.groove_x if side=='left' else p.phone_left+p.phone_w
        raw[f'soft_side_pad_{side}']=box(x,x+p.pad_x_allowance,28,52,z0,z0+p.phone_t).edges('|X').fillet(.6)
        x=p.phone_left if side=='left' else p.phone_left+p.phone_w-9
        raw[f'soft_rear_pad_{side}']=box(x,x+9,28,52,2,z0).edges('|Z').fillet(.6)
    h={n:phone_transform(s,p) for n,s in raw.items()}
    fixed={'pivot_M3':hv.compound(rod((11,-13,19),(11,13,19),3),hv.ring((11,-11.5,19),(0,1,0),6,3.2,.8),hv.ring((11,10.7,19),(0,1,0),6,3.2,.8),hv.ring((11,-13,19),(0,1,0),4.5,3,1.5),hv.ring((11,11.5,19),(0,1,0),4.5,3,1.5)),
       'return_spring_coil':helical_wire(2.6,.4,2.3,5.5).rotate((0,0,0),(0,0,1),180).rotate((0,0,0),(1,0,0),-90).translate((11,2.3,19)),
       'return_spring_fixed_leg':rod((13.6,4.6,19),(14,7,15),.4)}
    a=stop_angle(p);top=19-3/math.cos(a)-12.5*math.tan(a)
    fixed['travel_stop_M3']=hv.compound(hv.threaded((0,0,2),(0,0,top),3),hv.socket_head((0,0,-1),(0,0,1),5.5,3,2.5),hv.nut((0,0,9),(0,0,1),5.5,3.1,2.4))
    fixed['travel_stop_nut']=box(-2.75,2.75,-2.75,2.75,3,5.4).cut(bore((0,0,2),(0,0,1),5,3))
    for yy in (-8,8):
        # Screw passes crossed rail/height slots; washer and nut required outside.
        fixed[f'carriage_M3_{yy}']=hv.bolt_set((-6.5,yy,-6-p.actuator_shift),(13.5,yy,-6-p.actuator_shift),3,((-6.5,yy,-6-p.actuator_shift),(8,yy,-6-p.actuator_shift)),(8.5,yy,-6-p.actuator_shift))
    h.update({n:module(s,p) for n,s in fixed.items()})
    tip=contact_x(p)
    movable={'contact_M3':hv.threaded((5,0,7),(tip-.7,0,7),3),
             'soft_button_tip':rod((tip-1.5,0,7),(tip,0,7),4).edges('%Circle').fillet(.2).cut(bore((tip-1.6,0,7),(1,0,0),.9,3.05)),
             'contact_rear_locknut':hv.nut((4.6,0,7),(1,0,0),5.5,3.1,2.3),
             'contact_locknut':hv.nut((15.1,0,7),(1,0,0),5.5,3.1,2.3),
             'cable_pinch_barrel':rod((-7,0,22),(-7,0,26),5).cut(bore((-7,0,21),(0,0,1),6,1.8)).cut(bore((-9.6,0,24),(1,0,0),.7,2.2)),
             'return_spring_moving_leg':rod((8.4,2.3,19),(7,1,19),.4)}
    h.update({n:moving(s,p,angle) for n,s in movable.items()})
    h['phone_inner_wire']=module(hv.stranded((-7,0,0),(11-18*math.cos(angle),0,22-18*math.sin(angle))),p)
    # Schematic U route: axial rise, transverse leg, axial run down shaft.
    # Two 90-degree corners communicate routing, not physical bend radii.
    start=module(cq.Workplane('XY').sphere(.1).translate((-7,0,-6)),p).val().Center().toTuple()
    points=[start,(start[0],start[1],70),(p.cable_face_x,p.neck_cy,70),
            (p.cable_face_x,p.neck_cy,p.handle_z+12)]
    for i,(a,b) in enumerate(zip(points,points[1:])):h[f'housing_route_{i}']=rod(a,b,5).cut(rod(a,b,2))
    h['phone_ferrule']=module(hv.compound(hv.ring((-7,0,-9),(0,0,1),5.5,5.1,8.5),hv.ring((-7,0,-.5),(0,0,1),5.5,2,.5)),p)
    h['handle_ferrule']=hv.compound(hv.ring((p.cable_face_x,p.neck_cy,p.handle_z+3.5),(0,0,1),5.5,5.1,11.5),hv.ring((p.cable_face_x,p.neck_cy,p.handle_z+3),(0,0,1),5.5,2,.5))
    anchor=(p.cable_face_x,p.neck_cy,p.handle_z-12)
    attach=trigger_attach(p)
    axis=cq.Vector(*anchor).sub(cq.Vector(*attach)).normalized()
    start=cq.Vector(*attach).add(axis.multiply(p.spring_free_eye_mm)).toTuple()
    h['handle_inner_wire']=hv.stranded(anchor,start)
    h['series_extension_spring_envelope']=extension_spring(start,attach,p.spring_od)
    h['trigger_strap_envelope']=hv.hollow_strap(attach)
    oy=(p.neck_y+p.neck_clearance)/2+9
    for yy in (p.neck_cy-oy,p.neck_cy+oy):
        h[f'collar_M4_phone_{yy}']=phone_transform(hv.bolt_set((-35.1,yy,0),(-.1,yy,0),4,((-35.1,yy,0),(-11.7,yy,0)),(-10.9,yy,0)),p)
        h[f'collar_M4_handle_{yy}']=hv.bolt_set((-35.1,yy,p.handle_z),(-.1,yy,p.handle_z),4,((-35.1,yy,p.handle_z),(-11.7,yy,p.handle_z)),(-10.9,yy,p.handle_z))
    return h

def scene(parts,p,angle=0,stock=True,metal=True):
    rows=[(n,place(n,s,p,angle),ORANGE) for n,s in parts.items()]
    rows.append(('handle_cap',place('handle_cap',parts['neck_cap'],p),ORANGE))
    if stock:
        for n,s in proxies(p).items():
            c=BLUE if 'blue' in n else DARK if 'black' in n or 'camera' in n or 'volume' in n else (.43,.48,.53) if 'phone' in n else METAL
            rows.append((n,s,c))
    if metal:
        for n,s in hardware(p,angle).items():rows.append((n,s,DARK if any(t in n for t in ('housing','soft','strap')) else METAL))
    return rows

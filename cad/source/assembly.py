"""R4 assembly. A rigid installation rotation puts the bridge behind the phone."""
import math
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

def phone(p):
    z=2*p.phone_mid_z-p.rear_face_z
    return phone_transform(box(p.phone_left,p.phone_left+p.phone_w,p.phone_y0,p.phone_y0+p.phone_l,z,z+p.phone_t),p)

def proxies(p):
    z=2*p.phone_mid_z-p.rear_face_z
    camx=p.phone_left+2 if p.actuator_side=='far' else p.phone_left+p.phone_w-40
    s={'stock_neck':box(p.neck_cx-p.neck_x/2,p.neck_cx+p.neck_x/2,p.neck_cy-p.neck_y/2,p.neck_cy+p.neck_y/2,p.handle_z-30,115),
       'stock_blue_brace':box(-36,-10,26,54,-115,-90),
       'phone_envelope':phone(p),
       'camera_keepout':phone_transform(box(camx,camx+38,p.phone_y0+p.phone_l-43,p.phone_y0+p.phone_l-3,z-4,z),p),
       'stock_blue_handle':box(-30,-8,28,52,p.handle_z-96,p.handle_z-30),
       'stock_blue_grip':rod((-23,40,p.handle_z-88),(-65,40,p.handle_z-153),23),
       'stock_black_trigger':rod((p.cable_face_x,40,p.handle_z-100),(-43,40,p.handle_z-145),10)}
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
    raw={'draw_screw_M4':rod((13,40,-4),(98,40,-4),4),
       'draw_screw_head':rod((13,40,-4),(18,40,-4),16),
       'jaw_nut':box(p.jaw_x-60,p.jaw_x-56.3,36.5,43.5,-7.5,-.5).cut(bore((p.jaw_x-61,40,-4),(1,0,0),6,4))}
    # Flat pads contact the two sides and rear ledges. Phone front remains open.
    z0=2*p.phone_mid_z-p.rear_face_z
    for side in ('left','right'):
        x=p.groove_x if side=='left' else p.phone_left+p.phone_w
        raw[f'soft_side_pad_{side}']=box(x,x+p.pad_x_allowance,28,52,z0,z0+p.phone_t)
        x=p.phone_left if side=='left' else p.phone_left+p.phone_w-9
        raw[f'soft_rear_pad_{side}']=box(x,x+9,28,52,2,z0)
    h={n:phone_transform(s,p) for n,s in raw.items()}
    fixed={'pivot_M3':rod((11,-13,19),(11,13,19),3),
       'return_spring_coil':cq.Workplane('XZ').center(11,19).circle(3).circle(1.7).extrude(2.7).translate((0,4.8,0)),
       'return_spring_fixed_leg':rod((13,4.4,18),(14,7,15),.7)}
    a=stop_angle(p);top=19-3/math.cos(a)-12.5*math.tan(a)
    fixed['travel_stop_M3']=rod((0,0,2),(0,0,top),3)
    fixed['travel_stop_nut']=box(-2.75,2.75,-2.75,2.75,3,5.4).cut(bore((0,0,2),(0,0,1),5,3))
    for yy in (-8,8):
        # Screw passes crossed rail/height slots; washer and nut required outside.
        fixed[f'carriage_M3_{yy}']=rod((-10,yy,-6-p.actuator_shift),(12,yy,-6-p.actuator_shift),3)
    h.update({n:module(s,p) for n,s in fixed.items()})
    tip=contact_x(p)
    movable={'contact_M3':rod((5,0,7),(tip-.7,0,7),3),
             'soft_button_tip':rod((tip-.7,0,7),(tip,0,7),4),
             'contact_rear_locknut':box(4.6,6.9,-2.75,2.75,4.25,9.75).cut(bore((4,0,7),(1,0,0),4,3)),
             'contact_locknut':box(15.1,17.4,-2.75,2.75,4.25,9.75).cut(bore((14,0,7),(1,0,0),5,3)),
             'cable_pinch_barrel':rod((-7,0,22),(-7,0,26),5),
             'return_spring_moving_leg':rod((9,4,19),(7,1,19),.7)}
    h.update({n:moving(s,p,angle) for n,s in movable.items()})
    h['phone_inner_wire']=module(rod((-7,0,0),(11-18*math.cos(angle),0,22-18*math.sin(angle)),1.6),p)
    # Routing envelope: leave ferrule axially, pass beyond the phone end, then
    # descend on the trigger-facing shaft surface. Actual housing uses smooth bends.
    route_raw=[(-7,0,-6),(-7,0,-42),(-7,75,-42)]
    points=[]
    for point in route_raw:
        marker=module(cq.Workplane('XY').sphere(.1).translate(point),p).val().Center()
        points.append(marker.toTuple())
    points += [(p.cable_face_x,p.phone_y0+p.phone_l+30,70),(p.cable_face_x,p.neck_cy,70),
               (p.cable_face_x,p.neck_cy,p.handle_z+12)]
    for i,(a,b) in enumerate(zip(points,points[1:])):h[f'housing_route_{i}']=rod(a,b,5)
    anchor=(p.cable_face_x,p.neck_cy,p.handle_z-12)
    attach=(p.cable_face_x,p.neck_cy,p.handle_z-100)
    start=(attach[0],attach[1],attach[2]+p.spring_free_eye_mm)
    h['handle_inner_wire']=rod(anchor,start,1.6)
    h['series_extension_spring_envelope']=rod(start,attach,p.spring_od)
    h['trigger_strap_envelope']=box(attach[0]-7,attach[0]+7,26,54,attach[2]-7,attach[2]+7)
    oy=(p.neck_y+p.neck_clearance)/2+9
    for yy in (p.neck_cy-oy,p.neck_cy+oy):
        h[f'collar_M4_phone_{yy}']=phone_transform(rod((-39,yy,0),(-7,yy,0),4),p)
        h[f'collar_M4_handle_{yy}']=rod((-39,yy,p.handle_z),(-7,yy,p.handle_z),4)
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

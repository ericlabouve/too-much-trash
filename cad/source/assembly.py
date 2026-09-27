"""Shared CAD assembly and analytic rocker kinematics. Dimensions in mm."""
import math
import cadquery as cq
from parts import box, bore, xz_profile
ORANGE=(.96,.36,.08)
BLUE=(.035,.27,.75)
METAL=(.63,.68,.72)
DARK=(.13,.16,.19)

def place(name,s,p,angle=0):
    if name=='sliding_jaw':return s.translate((p.jaw_x,0,0))
    if name in ('actuator_bracket','rocker'):
        if name=='rocker':s=s.rotate((11,0,19),(11,1,19),-math.degrees(angle))
        return s.translate((0,p.button_from_end,p.actuator_shift))
    if name in ('handle_anchor','handle_cap'):return s.translate((0,0,p.handle_z))
    return s

def contact_x(p):return p.phone_left-p.rest_gap

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

def phone(p):return box(p.phone_left,p.phone_left+p.phone_w,0,p.phone_l,p.phone_bottom,p.phone_bottom+p.phone_t)

def proxies(p):
    s={'stock_neck':box(p.neck_cx-p.neck_x/2,p.neck_cx+p.neck_x/2,p.neck_cy-p.neck_y/2,p.neck_cy+p.neck_y/2,p.handle_z-30,115),
       'stock_blue_brace':box(-36,-10,26,54,-115,-90),
       'phone_envelope':phone(p),
       'camera_keepout':box(p.phone_left+2,p.phone_left+40,p.phone_l-43,p.phone_l-3,p.phone_bottom+p.phone_t,p.phone_bottom+p.phone_t+4),
       'stock_blue_handle':box(-38,-8,28,52,p.handle_z-96,p.handle_z-30),
       'stock_blue_grip':rod((-23,40,p.handle_z-88),(-77,40,p.handle_z-153),23),
       'stock_black_trigger':rod((-48,40,p.handle_z-75),(-83,40,p.handle_z-95),10)}
    arms=[]
    for sign in (-1,1):
        pts=[(-23+sign*x,40,z) for x,z in ((0,110),(25,138),(52,188),(65,230))]
        arms += [rod(a,b,5).val() for a,b in zip(pts,pts[1:])]
        s[f'stock_black_foot_{sign}']=box(-23+sign*65-8,-23+sign*65+8,31,49,227,246)
    s['stock_claws']=cq.Workplane('XY').newObject([cq.Compound.makeCompound(arms)])
    return s

def hardware(p,angle=0):
    y,z=p.button_from_end,p.actuator_shift
    h={'draw_screw_M4':rod((3,40,-4),(88,40,-4),4),
       'draw_screw_head':rod((3,40,-4),(8,40,-4),16),
       'jaw_nut':box(p.jaw_x-60,p.jaw_x-56.3,36.5,43.5,-7.5,-.5).cut(bore((p.jaw_x-61,40,-4),(1,0,0),6,4)),
       'pivot_M3':rod((11,y-13,19+z),(11,y+13,19+z),3),
       'return_spring_coil':cq.Workplane('XZ').center(11,19+z).circle(3).circle(1.7).extrude(2.7).translate((0,y+4.8,0)),
       'return_spring_fixed_leg':rod((13,y+4.4,18+z),(14,y+7,15+z),.7),
       'return_spring_moving_leg':rod((9,y+4,19+z),(7,y+1,19+z),.7)}
    tip=contact_x(p)
    for name,s in [('contact_M3',rod((5,0,7),(tip-.7,0,7),3)),
                   ('soft_button_tip',rod((tip-.7,0,7),(tip,0,7),4)),
                   ('contact_rear_locknut',box(4.6,6.9,-2.75,2.75,4.25,9.75).cut(bore((4,0,7),(1,0,0),4,3))),
                   ('contact_locknut',box(15.1,17.4,-2.75,2.75,4.25,9.75).cut(bore((14,0,7),(1,0,0),5,3)))]:
        h[name]=s.rotate((11,0,19),(11,1,19),-math.degrees(angle)).translate((0,y,z))
    a=stop_angle(p);top=19-3/math.cos(a)-12.5*math.tan(a)
    # Replaceable 0.8 mm pads shown at nominal uncompressed thickness.
    for upper in (False,True):
        za,zb=(14,26) if upper else (2,14)
        xa,xb=(14,26) if upper else (26,14)
        pts=[(xa,za),(xb,zb),(xb+p.pad_x_allowance,zb),(xa+p.pad_x_allowance,za)]
        left=xz_profile(pts,28,52)
        right=xz_profile([(p.jaw_x+14-x,zz) for x,zz in pts],28,52)
        h[f'soft_jaw_pad_left_{upper}']=left
        h[f'soft_jaw_pad_right_{upper}']=right
    h['travel_stop_M3']=rod((0,y,2+z),(0,y,top+z),3)
    h['travel_stop_nut']=box(-2.75,2.75,y-2.75,y+2.75,3+z,5.4+z).cut(bore((0,y,2+z),(0,0,1),5,3))
    h['cable_pinch_barrel']=rod((-7,0,22),(-7,0,26),5).rotate((11,0,19),(11,1,19),-math.degrees(angle)).translate((0,y,z))
    h['phone_inner_wire']=rod((-7,y,z),(11-18*math.cos(angle),y,22-18*math.sin(angle)+z),1.6)
    route=[(-7,y,z-6),(-7,y,z-45),(-13,19,-85),(-13,19,p.handle_z+12)]
    for i,(a,b) in enumerate(zip(route,route[1:])):h[f'housing_route_{i}']=rod(a,b,5)
    anchor=(-13,19,p.handle_z-12);attach=(-78,19,p.handle_z-107)
    delta=cq.Vector(*attach).sub(cq.Vector(*anchor));axis=delta.normalized()
    end=cq.Vector(*attach);start=end.sub(axis.multiply(p.spring_free_eye_mm))
    h['handle_inner_wire']=rod(anchor,start.toTuple(),1.6)
    h['series_extension_spring_envelope']=rod(start.toTuple(),end.toTuple(),p.spring_od)
    h['trigger_strap_envelope']=box(-85,-71,17,49,p.handle_z-114,p.handle_z-100)
    oy=(p.neck_y+p.neck_clearance)/2+9
    for station in (0,p.handle_z):
        for yy in (p.neck_cy-oy,p.neck_cy+oy):h[f'collar_M4_{station}_{yy}']=rod((-39,yy,station),(-7,yy,station),4)
    for yy in (-8,8):h[f'carriage_M3_{yy}']=rod((-10,y+yy,-6),(12,y+yy,-6),3)
    return h

def scene(parts,p,angle=0,stock=True,metal=True):
    rows=[(n,place(n,s,p,angle),ORANGE) for n,s in parts.items()]
    rows.append(('handle_cap',place('handle_cap',parts['neck_cap'],p),ORANGE))
    if stock:
        for n,s in proxies(p).items():
            c=BLUE if 'blue' in n else DARK if 'black' in n or 'camera' in n else (.43,.48,.53) if 'phone' in n else METAL
            rows.append((n,s,c))
    if metal:
        for n,s in hardware(p,angle).items():rows.append((n,s,DARK if any(t in n for t in ('housing','soft','strap')) else METAL))
    return rows

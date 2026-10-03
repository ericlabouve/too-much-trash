"""V2 dedicated-case review concept. mm; (X,Y,Z) -> project (X,Z,-Y).

Z points along the shaft toward the claws. Phone back faces +Z.
Only stock proxies are borrowed from V1; no V1 solids or exports are modified.
"""
from dataclasses import dataclass, asdict
from pathlib import Path
import math
import sys
import cadquery as cq

V1_SOURCE = Path(__file__).resolve().parents[3] / 'source'
sys.path.insert(0, str(V1_SOURCE))
from parameters import Parameters as V1Parameters
from assembly import proxies as v1_proxies

@dataclass(frozen=True)
class Parameters:
    phone_width: float = 76
    phone_length: float = 152
    phone_thickness: float = 18
    button_from_end: float = 105
    button_from_screen: float = 6
    phone_right: float = -20
    case_clearance: float = .4
    collar_opening_x: float = 11.6
    collar_opening_y: float = 17.6
    twine_diameter: float = 2.0  # PROVISIONAL; not a user measurement
    guide_bore: float = 6.0
    pivot_diameter: float = 6.0
    pivot_clearance: float = .5
    rest_gap: float = .35
    button_stroke: float = .30  # provisional, not a safe-phone specification
    band_radius_display: float = 25  # user reports roughly 20–30 mm radius
    series_span_rest: float = 80  # schematic installed span, not free length
    guide_stations: tuple = (-50, -175, -300)
    @property
    def phone_left(self): return self.phone_right-self.phone_width
    @property
    def button_y(self): return self.button_from_end-self.phone_length/2
    @property
    def pivot(self): return (-9, self.button_y, 18)
    @property
    def string_eye(self): return (5, self.button_y, 18)
    @property
    def first_guide(self): return (5, self.button_y, -8)
    @property
    def contact(self): return (self.phone_right+self.rest_gap, self.button_y, self.button_from_screen)

ORANGE=(.96,.36,.08)
TWINE=(.62,.42,.19)
BAND=(.57,.29,.68)


def box(x0,x1,y0,y1,z0,z1):
    return cq.Workplane('XY').box(x1-x0,y1-y0,z1-z0).translate(((x0+x1)/2,(y0+y1)/2,(z0+z1)/2))


def cylinder(a, direction, length, diameter):
    return cq.Workplane('XY').newObject([cq.Solid.makeCylinder(diameter/2,length,cq.Vector(*a),cq.Vector(*direction))])


def rod(a,b,d):
    v=cq.Vector(*b).sub(cq.Vector(*a))
    return cylinder(a,v.normalized().toTuple(),v.Length,d)


def torus(center, normal=(0,0,1), major=4.5, minor=1.5):
    return cq.Workplane('XY').newObject([cq.Solid.makeTorus(major,minor,center,normal)])


def hook(x,y,z):
    # Mushroom hook: a band sits below a broad rounded head.
    return cylinder((x,y,z),(0,0,1),5,5).union(cylinder((x,y,z+4),(0,0,1),2,9))


def saddle(z0,z1,p):
    # Rigid open U, no flexing snap fingers. Bands close the open +X side.
    ix,iy=p.collar_opening_x/2,p.collar_opening_y/2
    s=box(-11.3,7.3,-13.8,13.8,z0,z1)
    s=s.cut(box(-ix,9,-iy,iy,z0-1,z1+1))
    return s


def carrier(p):
    xl,xr=p.phone_left,p.phone_right
    ya,yb=-p.phone_length/2-p.case_clearance,p.phone_length/2+p.case_clearance
    s=box(xl-6,xl-.4,ya,yb,-2,22.4)
    s=s.union(box(xr+.4,xr+6,ya,yb,-2,22.4))
    # Open screen, hard side lips; keep the known volume-button area open.
    for y0,y1 in ((-64,-44),(-10,10)):
        s=s.union(box(xl-.5,xl+1.6,y0,y1,-2,-.4))
        s=s.union(box(xr-1.6,xr+.5,y0,y1,-2,-.4))
    for y0,y1 in ((-64,-56),(-12,12)):
        s=s.union(box(xl-6,xr+6,y0,y1,18.4,22.4))
    # Relieve the side walls while preserving rails and hard contact lands.
    for x0,x1 in ((xl-7,xl+.2),(xr-.2,xr+7)):
        for y0,y1 in ((-42,-14),(14,50)):
            s=s.cut(box(x0,x1,y0,y1,1.5,16.5).edges('|X').fillet(2))
    # Charging-end corner stops leave the central port region open.
    for x0,x1 in ((xl-6,xl+13),(xr-13,xr+6)):
        s=s.union(box(x0,x1,ya-4,ya+.1,-2,22.4))
    # Gate sockets behind the phone; square tongues insert axially.
    for x0 in (xl-6,xr-4):
        s=s.union(box(x0,x0+10,64,yb,22.4,33))
        s=s.cut(box(x0+2.7,x0+7.3,63.8,yb+1,25.7,30.3))
    # Two collar-band lanes, clear of the rear bridge.
    s=s.union(box(xr+5,-8,-12,12,18.4,24.5))
    s=s.union(saddle(23.5,49,p))
    for z in (31,41):
        outer=box(-12,8,-15,15,z-1.8,z+1.8)
        inner=box(-10.4,6.4,-12.9,12.9,z-2,z+2)
        s=s.cut(outer.cut(inner))
    # Gate-band anchor alternatives. No band crosses the screen.
    for y in (-60,-7,7): s=s.union(hook((xl+xr)/2,y,22.2))
    by=p.button_y
    s=s.cut(box(xr-.2,xr+7,by-4,by+4,2.5,10))
    # Integral actuator bracket, large printed axle in double shear.
    s=s.union(box(-15,13,by-12,by+14,23,27))
    s=s.union(box(-17,-14,by-12,by+14,18.4,27))
    for y0,y1 in ((by-8,by-4),(by+8,by+12)):
        s=s.union(box(-15,-2,y0,y1,12,27))
    s=s.cut(cylinder((-9,by-13,18),(0,1,0),26,p.pivot_diameter+p.pivot_clearance))
    # Bayonet insertion keyway in far bearing; axle turns 90 degrees to retain.
    s=s.cut(box(-13.5,-4.5,by-13,by+13,16.9,19.1))
    # Return-band anchors, selected by actual band preload, all outside phone.
    s=s.union(box(2,8,by+11,by+15,25,62))
    for z in (42,50,58):
        s=s.union(cylinder((5,by+8,z),(0,1,0),5,4))
        s=s.union(cylinder((5,by+7,z),(0,1,0),1.5,7))
    # Closed, round first fairlead: no removable wheel or loose axle.
    s=s.union(box(9.3,13,by-3,by+3,-8,25))
    s=s.union(torus(p.first_guide))
    # Stop rails flank the string bore. Heights calculated from the rocker arc.
    a=stop_angle(p)
    stop_top=18-2*math.cos(a)-18*math.sin(a)
    for y0,y1 in ((by-2.5,by-1.2),(by+1.2,by+2.5)):
        s=s.union(box(7,13,y0,y1,stop_top-3,stop_top))
        s=s.union(box(7,13,y0,y1,20,23.1))
    # Axle-head indexing lug: prevents spontaneous quarter-turn unlocking.
    s=s.union(box(-15.5,-14,by-16,by-11,23,26))
    s=s.union(box(-15.5,-11,by-16,by-13,21.5,25))
    return s


def gate(p):
    xl,xr=p.phone_left,p.phone_right
    y=p.phone_length/2+p.case_clearance
    s=box(xl-6,xr+6,y+.4,y+4.4,-2,33)
    # Open middle; end retention stays at the two case corners.
    s=s.cut(box(xl+13,xr-13,y,y+5,-3,23))
    for x0 in (xl-6,xr-4):
        s=s.union(box(x0+3,x0+7,y-12,y+.5,26,30))
    s=s.union(hook((xl+xr)/2,y+2.4,32.8))
    return s


def rocker(p):
    by=p.button_y
    s=box(-11,9,by-2.5,by+2.5,16,20)
    # Integral bearing boss replaces washers and limits axial float to 0.6 mm.
    s=s.union(cylinder((-9,by-3.7,18),(0,1,0),11.4,9.4))
    s=s.union(box(-11,-6,by-2.5,by+2.5,4,18))
    # Rounded hard nose. Separate from phone by rest_gap at the nominal datum.
    nose=box(p.contact[0],-6,by-2,by+2,4,8).edges('|X').fillet(.8)
    s=s.union(nose)
    s=s.cut(cylinder((-9,by-4,18),(0,1,0),12,p.pivot_diameter+p.pivot_clearance))
    s=s.cut(cylinder((5,by,15),(0,0,1),7,4))
    # Integral band hook; no contact screw, no soft cap, no metal spring.
    s=s.union(cylinder((5,by+2,18),(0,1,0),4,4))
    s=s.union(cylinder((5,by+5,18),(0,1,0),1.5,7))
    return s


def axle(p):
    by=p.button_y
    s=cylinder((-9,by-13,18),(0,1,0),27,p.pivot_diameter)
    head=cylinder((-9,by-16,18),(0,1,0),3,9.6)
    head=head.cut(box(-16,-10.8,by-17,by-12,21.3,26))
    s=s.union(head)
    # Rendered in its locked position, with cross-lug vertical in XZ.
    s=s.union(box(-9.8,-8.2,by+12.4,by+14,13.8,22.2))
    return s


def guide(p):
    s=saddle(-7,7,p)
    # Shared guide lives on trigger-facing neck surface; band sits between lips.
    s=s.union(box(-17,-10,-3,3,-2,2))
    s=s.union(torus((-18,0,0)))
    outer=box(-12,8,-15,15,-2,2)
    inner=box(-10.4,6.4,-12.9,12.9,-3,3)
    # Do not cut the guide bridge in the band lane.
    lane=outer.cut(inner).cut(box(-30,-10,-4,4,-3,3))
    return s.cut(lane).cut(cylinder((-18,0,-8),(0,0,1),16,p.guide_bore))


def parts(p):
    return {'carrier':carrier(p),'end_gate':gate(p),'rocker':rocker(p),
            'pivot_key':axle(p),'string_guide':guide(p)}


def rotate_point(point,p,angle):
    x,y,z=point;px,py,pz=p.pivot
    dx,dz=x-px,z-pz
    return (px+dx*math.cos(angle)+dz*math.sin(angle),y,pz-dx*math.sin(angle)+dz*math.cos(angle))


def stop_angle(p):
    lo,hi=0,.15
    for _ in range(50):
        mid=(lo+hi)/2
        advance=p.contact[0]-rotate_point(p.contact,p,mid)[0]
        if advance<p.rest_gap+p.button_stroke: lo=mid
        else: hi=mid
    return (lo+hi)/2


def stock(p):
    orig=V1Parameters()
    rows={n:s.translate((23,-40,0)) for n,s in v1_proxies(orig).items() if n.startswith('stock_')}
    rows['phone_envelope']=box(p.phone_left,p.phone_right,-76,76,0,18)
    rows['camera_keepout']=box(p.phone_left+2,p.phone_left+40,33,73,18,22)
    rows['phone_volume_up']=box(p.phone_right,p.phone_right+.12,p.button_y-3.5,p.button_y+3.5,4.7,7.3)
    return rows


def polyline(points,d):
    # Illustration only; segmented flexible materials are not manufacturing parts.
    return cq.Workplane('XY').newObject([cq.Compound.makeCompound([rod(a,b,d).val() for a,b in zip(points,points[1:])])])


def loop_between(a,b,width=4):
    # Two legs plus curved ends: rubber-band centerline, not a force model.
    av,bv=cq.Vector(*a),cq.Vector(*b)
    direction=bv.sub(av).normalized()
    side=direction.cross(cq.Vector(1,0,0))
    if side.Length<.01: side=direction.cross(cq.Vector(0,1,0))
    side=side.normalized()
    pts=[]
    for i in range(49):
        t=2*math.pi*i/48
        c=av.add(bv).multiply(.5).add(direction.multiply(av.sub(bv).Length/2*math.cos(t))).add(side.multiply(width*math.sin(t)))
        pts.append(c.toTuple())
    return pts


def rounded_band_xy(z, left=-9):
    # Rounded rectangular loop seated in the U-saddle band lane.
    pts=[]
    for cx,cy,start in ((5,10,0),(left,10,90),(left,-10,180),(5,-10,270)):
        for i in range(9):
            a=math.radians(start+i*90/8)
            pts.append((cx+3*math.cos(a),cy+3*math.sin(a),z))
    return pts+[pts[0]]


def flexible_paths(p):
    trigger=(-42,0,-417)
    last=(-18,0,p.guide_stations[-1])
    v=cq.Vector(*trigger).sub(cq.Vector(*last));distance=v.Length
    tail=distance-p.series_span_rest
    knot=cq.Vector(*last).add(v.normalized().multiply(tail)).toTuple()
    string=[p.string_eye,p.first_guide]+[(-18,0,z) for z in p.guide_stations]+[knot]
    bands={
        'band_collar_1':rounded_band_xy(31),'band_collar_2':rounded_band_xy(41),
        'band_gate':loop_between((-58,-7,26),(-58,78.8,36),3),
        'band_return':loop_between((5,p.button_y+4,18),(5,p.button_y+9,50),2),
        'band_overtravel':loop_between(knot,trigger,5),
    }
    for i,z in enumerate(p.guide_stations): bands[f'band_guide_{i+1}']=rounded_band_xy(z,left=-22)
    return string,bands,{'trigger_pivot':(-4,0,-416),'trigger_attach':trigger,
                        'trigger_angle':-.48,'tail_length':tail,'series_span_rest':p.series_span_rest}


def rows(p,solids):
    out=[]
    for name,s in solids.items():
        if name=='string_guide':
            for i,z in enumerate(p.guide_stations): out.append((f'guide_{i+1}',s.translate((0,0,z)),ORANGE,name))
        else: out.append((name,s,ORANGE,name))
    for n,s in stock(p).items():
        color=(.035,.27,.75) if 'blue' in n else (.12,.14,.17) if any(x in n for x in ('black','camera','volume')) else (.6,.65,.69)
        out.append((n,s,color,None))
    out.append(('actuator_context',solids['carrier'].intersect(box(-22,15,p.button_y-15,p.button_y+17,-15,65)),ORANGE,'carrier'))
    out.append(('stock_neck_context',box(-7,7,-9.5,9.5,-65,85),(.6,.65,.69),None))
    string,bands,motion=flexible_paths(p)
    out.append(('twine_phone',polyline(string[:3],p.twine_diameter),TWINE,'twine'))
    out.append(('twine',polyline(string,p.twine_diameter),TWINE,'twine'))
    for n,path in bands.items(): out.append((n,polyline(path,1.4),BAND,'rubber_bands'))
    return out

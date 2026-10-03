"""V2 adjustable band-clamped prototype. mm; (X,Y,Z) -> project (X,Z,-Y).

Z points along the shaft toward the claws. Phone back faces +Z.
Only stock proxies are borrowed from V1; no V1 solids or exports are modified.
"""
from dataclasses import dataclass, asdict
from pathlib import Path
import math
import sys
import cadquery as cq

V1_SOURCE = next(x/'source' for x in Path(__file__).resolve().parents if (x/'source/parameters.py').exists())
sys.path.insert(0, str(V1_SOURCE))
from parameters import Parameters as V1Parameters
from assembly import proxies as v1_proxies


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




def rotate_point(point,p,angle):
    x,y,z=point;px,py,pz=p.pivot
    dx,dz=x-px,z-pz
    return (px+dx*math.cos(angle)+dz*math.sin(angle),y,pz-dx*math.sin(angle)+dz*math.cos(angle))




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



# Adjustable revision: all rigid part designs are independent of phone dimensions.
from functools import lru_cache

@dataclass(frozen=True)
class Parameters:
    phone_width: float=76
    phone_length: float=152
    phone_thickness: float=18
    button_from_end: float=105
    button_from_screen: float=6
    side: str='near'
    phone_right: float=-20
    collar_opening_x: float=11.6
    collar_opening_y: float=17.6
    twine_diameter: float=2
    guide_bore: float=8
    pivot_diameter: float=6
    pivot_clearance: float=.5
    rest_gap: float=.35
    button_stroke: float=.30
    series_span_rest: float=80
    guide_stations: tuple=(-130,-175,-300)
    @property
    def phone_left(self): return self.phone_right-self.phone_width
    @property
    def button_y(self): return self.button_from_end-self.phone_length/2
    @property
    def sign(self): return 1 if self.side=='near' else -1
    @property
    def height(self): return 18-self.phone_thickness+self.button_from_screen-6
    def point(self,q):
        x,y,z=q
        return ((self.phone_right if self.side=='near' else self.phone_left)+self.sign*x,self.button_y+self.sign*y,z+self.height)
    @property
    def pivot(self): return self.point((19,0,18))
    @property
    def string_eye(self): return self.point((33,1.5,24))
    @property
    def first_guide(self): return self.point((34,0,7))
    @property
    def contact(self): return self.point((self.rest_gap,0,6))




from thread_profile import thread as successful_thread, make_parts as successful_fasteners

@lru_cache(None)
def thread(female=False):
    return successful_thread(female)

@lru_cache(None)
def _fasteners():
    return successful_fasteners()

def thumb_screw(p):
    return _fasteners()['thumb_screw']

def thumb_nut(p):
    return _fasteners()['thumb_nut']


def placed(s,p):
    if p.side=='far':s=s.rotate((0,0,0),(0,0,1),180)
    return s.translate(((p.phone_right if p.side=='near' else p.phone_left),p.button_y,p.height))


def assembly_parts(p,solids):
    out={'shaft_cap':solids['shaft_cap'],'carrier':solids['carrier'],'sliding_jaw':solids['sliding_jaw'].translate((p.phone_left,0,0))}
    for n in ('actuator_bracket','rocker','pivot_key'):out[n]=placed(solids[n],p)
    out['contact_screw']=placed(solids['thumb_screw'].rotate((0,0,0),(0,1,0),90).translate((.35,0,6)),p)
    for i,y in enumerate((-24,24)):
        # Recessed rail screw centers remain at global Z−14 as bracket height changes.
        s=solids['thumb_screw'].rotate((0,0,0),(0,1,0),-90).translate((56,y,-14-p.height))
        out[f'rail_screw_{i+1}']=placed(s,p)
        # Match thread phase: the nut occupies screw-local Z2..8.
        nut=solids['thumb_nut'].rotate((0,0,0),(0,1,0),-90).translate((54,y,-14-p.height))
        out[f'rail_nut_{i+1}']=placed(nut,p)
    for i,(y,z) in enumerate(CLAMP_STATIONS):
        out[f'clamp_screw_{i+1}']=solids['thumb_screw'].rotate((0,0,0),(0,1,0),90).translate((-16,y,z))
        out[f'clamp_nut_{i+1}']=solids['thumb_nut'].rotate((0,0,0),(0,1,0),90).translate((-14,y,z))
    for i,z in enumerate(p.guide_stations):out[f'guide_{i+1}']=solids['string_guide'].translate((0,0,z))
    return out


def stop_angle(p):
    lo,hi=0,.15
    for _ in range(50):
        mid=(lo+hi)/2
        advance=p.sign*(p.contact[0]-rotate_point(p.contact,p,p.sign*mid)[0])
        if advance<p.rest_gap+p.button_stroke:lo=mid
        else:hi=mid
    return p.sign*(lo+hi)/2


def stock(p):
    out={n:s.translate((23,-40,0)) for n,s in v1_proxies(V1Parameters()).items() if n.startswith('stock_')}
    out['phone_envelope']=box(p.phone_left,p.phone_right,-p.phone_length/2,p.phone_length/2,18-p.phone_thickness,18)
    out['camera_keepout']=box(p.phone_left+2,p.phone_left+40,p.phone_length/2-43,p.phone_length/2-3,18,22)
    out['phone_volume_up']=placed(box(-.01,.12,-3.5,3.5,4.7,7.3),p)
    return out


def flexible_paths(p):
    trigger=(-42,0,-417);last=(-18,0,p.guide_stations[-1])
    v=cq.Vector(*trigger).sub(cq.Vector(*last));tail=v.Length-p.series_span_rest
    knot=cq.Vector(*last).add(v.normalized().multiply(tail)).toTuple()
    face=p.phone_right if p.side=='near' else p.phone_left
    side_eye=(face+25*p.sign,-48,26)
    side_entry=(face+33*p.sign,-48,26)
    # Thread through the first eye and wrap beneath its radiused outside edge.
    # These fixed waypoints keep the line clear of the lug; they are kinematic,
    # not a tension/contact solution. Side-eye entry is aligned with its bore.
    under=p.point((34,0,2))
    under_out=p.point((34,-11*p.sign,2))
    exit_out=p.point((34,-11*p.sign,7))
    string=[p.string_eye,p.first_guide,under,under_out,exit_out,side_entry,side_eye,(-15,-48,34),(-15,-48,26)]+[(-18,0,z) for z in p.guide_stations]+[knot]
    bands={'band_return':loop_between(p.point((33,8,18)),p.point((38,14,28)),2),
        'band_overtravel':loop_between(knot,trigger,5)}
    for i,y in enumerate((-18,-34)):bands[f'band_jaw_{i+1}']=loop_between((p.phone_left-1,y,41),(-27,y,41),2)
    for i,z in enumerate(p.guide_stations):bands[f'band_guide_{i+1}']=rounded_band_xy(z,left=-28)
    return string,bands,{'trigger_pivot':(-4,0,-416),'trigger_attach':trigger,'trigger_angle':-.48,'tail_length':tail,'series_span_rest':p.series_span_rest}


def attachment_loop(p):
    # Closed loop through the eye and around its front ligament. Knot topology
    # is schematic; the actual end is tied back onto the standing string.
    return [p.point(q) for q in [(33,1.5,24),(33,-9,24),(33,-9,13),(31.5,-1.7,13),(31.5,-1.7,24),(33,1.5,24)]]


def rows(p,solids):
    out=[('twine_attachment',polyline(attachment_loop(p),p.twine_diameter),TWINE,'twine')]
    for n,s in assembly_parts(p,solids).items():
        bid='thumb_screw' if 'screw' in n else 'thumb_nut' if 'nut' in n else 'string_guide' if n.startswith('guide_') else n
        out.append((n,s,ORANGE,bid))
    for n,s in stock(p).items():
        color=(.035,.27,.75) if 'blue' in n else (.12,.14,.17) if any(x in n for x in ('black','camera','volume')) else (.6,.65,.69)
        out.append((n,s,color,None))
    out.append(('actuator_context',placed(solids['actuator_bracket'],p),ORANGE,'actuator_bracket'))
    out.append(('stock_neck_context',box(-7,7,-9.5,9.5,-105,85),(.6,.65,.69),None))
    string,bands,motion=flexible_paths(p)
    out.extend([('twine_phone',polyline(string[:10],p.twine_diameter),TWINE,'twine'),('twine',polyline(string,p.twine_diameter),TWINE,'twine')])
    for n,path in bands.items():out.append((n,polyline(path,1.4),BAND,'rubber_bands'))
    return out


# Promote the tested recessed study without changing its constructive geometry.
# Raised construction helpers retain the shared jaws and actuator features.




# R4: supported D-shaped guide lugs. 8 mm throat, 11 mm flared entrances,
# 6 mm axial thickness and 5 mm radial wall at the straight bore.
def guide_hole(center,p):
    x,y,z=center;r=p.guide_bore/2
    cut=cylinder((x,y,z-4),(0,0,1),8,p.guide_bore)
    for pos,ra,rb in [(z-3,r+1.5,r),(z+1.5,r,r+1.5)]:
        cone=cq.Solid.makeCone(ra,rb,1.5,cq.Vector(x,y,pos),cq.Vector(0,0,1))
        cut=cut.union(cq.Workplane('XY').newObject([cone]))
    return cut

def guide_lug(center,p,back=1):
    # Semicircular exposed end; flat attachment face on the opposite side.
    x,y,z=center;radius=p.guide_bore/2+5
    s=cylinder((x,y,z-3),(0,0,1),6,2*radius)
    s=s.union(box(x if back==1 else x-radius,x+radius if back==1 else x,y-radius,y+radius,z-3,z+3))
    s=s.edges('>Z or <Z').fillet(1)
    return s.cut(guide_hole(center,p))

def side_lug(center,p):
    plane=cq.Plane(origin=center,xDir=(0,1,0),normal=(1,0,0))
    return cq.Workplane('XY').newObject([guide_lug((0,0,0),p).val().located(cq.Location(plane))])

def side_hole(center,p):
    plane=cq.Plane(origin=center,xDir=(0,1,0),normal=(1,0,0))
    return cq.Workplane('XY').newObject([guide_hole((0,0,0),p).val().located(cq.Location(plane))])

def low_rail(sign=1,post_top=26):
    s=box(36,42,-6,100,-24,-4).union(box(36,42,-6,12 if sign==1 else 6,-4,post_top))
    cut=box(35,43,0,94,-18.4,-9.6)
    for y in (0,94):cut=cut.union(cylinder((35,y,-14),(1,0,0),8,8.8))
    s=s.cut(cut)
    return s if sign==1 else s.mirror('YZ')

# Split opens toward +X after actuator removal; both fasteners stay off the screen.
# Opposed flanges, with stations 40 mm apart along the shaft.
CLAMP_STATIONS=((-25,-36),(25,-76))
def shaft_clamp_half(p,cap=False):
    x0,x1=(.5,11.3) if cap else (-11.3,-.5)
    s=box(x0,x1,-13.8,13.8,-86,-26)
    s=s.cut(box(-p.collar_opening_x/2,p.collar_opening_x/2,-p.collar_opening_y/2,p.collar_opening_y/2,-87,-25))
    ex0,ex1=(.5,4) if cap else (-8,-.5)
    for y,z in CLAMP_STATIONS:
        s=s.union(cylinder((ex0,y,z),(1,0,0),ex1-ex0,20))
        s=s.union(box(ex0,ex1,min(y,11),max(y,-11),z-10,z+10))
        s=s.cut(cylinder((-15,y,z),(1,0,0),30,8.8))
    return s

def shaft_cap(p): return shaft_clamp_half(p,True)

def carrier(p):
    s=box(-20,-14,-12,12,-2.4,26).union(box(-28,-14,-12,12,18,26))
    s=s.union(box(-22,-14,-12,12,-4,-2)).union(box(-113,-8,-16,16,22,26))
    for y0,y1,li,lj in ((-16,-10.3,-16,-7.5),(10.3,16,7.5,16)):
        s=s.union(box(-113,-18,y0,y1,26,34)).union(box(-113,-18,li,lj,30.8,34))
    s=s.union(box(-18,-14,-16,16,26,34))
    s=s.union(low_rail().translate((-20,0,0))).union(box(-14,22,-12,12,22,26))
    s=s.union(shaft_clamp_half(p,False)).union(box(-20,-6,-13.8,-6,-28,26))
    for y in (-18,-34):
        s=s.union(box(-32,-22,min(y-3,-16),-12,32,38.5)).union(hook(-27,y,38.3))
    s=s.cut(box(-16,-7,12,17,21,39)).cut(box(-119,-83,-10.2,10.2,21.9,26.1)).cut(box(-5.8,5.8,-8.8,8.8,21,61))
    # Both side and neck crossover stay below the former elevated fairlead.
    s=s.union(box(2,8,-48,-12,20,26)).union(side_lug((5,-48,26),p))
    s=s.union(box(-9,-6,-48,-10,20,26)).union(guide_lug((-15,-48,26),p))
    s=s.cut(side_hole((5,-48,26),p)).cut(guide_hole((-15,-48,26),p))
    s=s.cut(box(-5.8,5.8,-8.8,8.8,-39,65))
    s=s.cut(box(-11.5,11.5,-.5,15,19,45))
    return s

def sliding_jaw(p):
    s=box(-6,0,-7.3,7.3,-2.4,33).union(box(-6,8,-7.3,7.3,18,22)).union(box(-6,2,-7.3,7.3,-4,-2))
    s=s.union(box(-6,66,-10,10,26.4,30.4)).union(low_rail(-1,33)).union(box(-42,-5,-7.3,7.3,29.8,33))
    for y in (-18,-34):s=s.union(box(-6,4,min(y-3,-7),-5,34.5,38.5)).union(box(-6,0,-7.3,-5,32,38.5)).union(hook(-1,y,38.3))
    s=s.union(box(-28,-22,-48,-35,26,38.5)).union(box(-28,-5,-48,-5,34.5,38.5)).union(side_lug((-25,-48,26),p))
    return s.cut(side_hole((-25,-48,26),p))

def guide(p):
    s=saddle(-7,7,p).union(box(-17,-10,-5,5,-3,3)).union(guide_lug((-18,0,0),p))
    lane=box(-12,8,-15,15,-2,2).cut(box(-10.4,6.4,-12.9,12.9,-3,3)).cut(box(-30,-10,-6,6,-3,3))
    return s.cut(lane).cut(guide_hole((-18,0,0),p))

def rocker(p):
    s=box(17,35,-3.5,3.5,16,20).union(cylinder((33,0,15),(0,0,1),6,14))
    s=s.union(cylinder((19,-3.7,18),(0,1,0),7.4,9.4)).union(box(12,18,-3.5,3.5,6,18))
    s=s.union(cylinder((6,0,6),(1,0,0),12,12.4))
    s=s.cut(thread(True).rotate((0,0,0),(0,1,0),90).translate((.35,0,6)))
    # Match the proven nut's 0.6 mm entry lead-ins without enlarging the boss.
    for x,r0,r1 in ((6,4.4,3.5),(17.4,3.5,4.4)):
        s=s.cut(cq.Workplane('XY').newObject([cq.Solid.makeCone(r0,r1,.6,cq.Vector(x,0,6),cq.Vector(1,0,0))]))
    s=s.cut(cylinder((19,-4,18),(0,1,0),12,6.5)).cut(cylinder((33,0,14),(0,0,1),8,8))
    s=s.union(cylinder((33,6,18),(0,1,0),4,4)).union(cylinder((33,9,18),(0,1,0),1.5,7))
    return s

def actuator_bracket(p):
    s=box(42,48,-33,33,-49,27)
    # Two rounded windows leave a perimeter frame, a central spine and full slot lands.
    for y0,y1,z0,z1 in [(-15,-4,-41,15),(4,15,-41,15)]:
        radius=3
        cut=box(41,49,y0+radius,y1-radius,z0,z1).union(box(41,49,y0,y1,z0+radius,z1-radius))
        for y in (y0+radius,y1-radius):
            for z in (z0+radius,z1-radius):cut=cut.union(cylinder((41,y,z),(1,0,0),8,2*radius))
        s=s.cut(cut)
    for y in (-24,24):
        cut=box(41,49,y-4.4,y+4.4,-28,-12)
        for z in (-28,-12):cut=cut.union(cylinder((41,y,z),(1,0,0),8,8.8))
        s=s.cut(cut)
    for y0,y1 in ((-8,-4),(4,8)):
        s=s.union(box(14,24,y0,y1,12,23)).union(box(23,26,y0,y1,21,27))
        s=s.union(box(24,48,y0,y1,21 if y0<0 else 23,27))
    # Open fork above the tie pad: side beams support the pivot without roofing the knot.
    for y0,y1 in ((-14,-10),(4,8)):
        s=s.union(box(24,48,y0,y1,21 if y0<0 else 23,27))
    s=s.union(box(23,27,-14,-4,21,27)).union(box(40,48,-6.5,6.5,23,27))
    s=s.cut(cylinder((33,0,20.9),(0,0,1),12,12))
    s=s.cut(cylinder((19,-13,18),(0,1,0),26,6.5)).cut(box(14.5,23.5,-13,13,16.9,19.1))
    s=s.union(box(40.4,44,-5,5,4,27)).union(guide_lug((34,0,7),p))
    s=s.cut(guide_hole((34,0,7),p))
    a=abs(stop_angle(Parameters()));stop=18-21*math.sin(a)-3*math.cos(a)
    s=s.union(box(38,42,-1.5,1.5,stop-2.4,stop)).union(box(39,42,-1.5,1.5,21,23.4))
    s=s.union(box(38,42,8,21,18,21)).union(box(35,41,17,21,18,31))
    for z in (28,):s=s.union(cylinder((38,14,z),(0,1,0),5,4)).union(cylinder((38,13,z),(0,1,0),1.5,6))
    s=s.union(box(24,25.5,-15,-6,10,13)).union(box(21,25.5,-15,-12,11,14.5))
    # Clearance for the loop around the front of the tie eye.
    s=s.cut(box(30.5,35.5,-11,-3.5,20.8,28))
    return s

def axle(p):
    s=cylinder((19,-12,18),(0,1,0),22,6)
    head=cylinder((19,-15,18),(0,1,0),3,9.6).cut(box(20.8,26,-16,-11,10,14.7))
    return s.union(head).union(box(18.2,19.8,8.4,10,13.8,22.2))

def parts(p):
    return dict(shaft_cap=shaft_cap(p),carrier=carrier(p),sliding_jaw=sliding_jaw(p),actuator_bracket=actuator_bracket(p),rocker=rocker(p),pivot_key=axle(p),thumb_screw=thumb_screw(p),thumb_nut=thumb_nut(p),string_guide=guide(p))

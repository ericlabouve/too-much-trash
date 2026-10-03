"""V2 adjustable band-clamped prototype. mm; (X,Y,Z) -> project (X,Z,-Y).

Z points along the shaft toward the claws. Phone back faces +Z.
Only stock proxies are borrowed from V1; no V1 solids or exports are modified.
"""
from dataclasses import dataclass, asdict
from pathlib import Path
import math
import sys
import cadquery as cq

V1_SOURCE = next(parent / 'source' for parent in Path(__file__).resolve().parents if (parent / 'source/parameters.py').is_file())
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
    guide_bore: float=6
    pivot_diameter: float=6
    pivot_clearance: float=.5
    rest_gap: float=.35
    button_stroke: float=.30
    series_span_rest: float=80
    guide_stations: tuple=(-50,-175,-300)
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
    def pivot(self): return self.point((11,0,30))
    @property
    def string_eye(self): return self.point((-3,0,30))
    @property
    def first_guide(self): return self.point((-3,0,52))
    @property
    def contact(self): return self.point((self.rest_gap,0,6))


def rail(sign=1):
    s=box(28,34,-6,100,60,80).union(box(28,34,-6,12,22,60))
    slot=box(27,35,0,94,65.6,74.4)
    for y in (0,94):slot=slot.union(cylinder((27,y,70),(1,0,0),8,8.8))
    s=s.cut(slot)
    return s if sign==1 else s.mirror('YZ')


def carrier(p):
    s=box(-20,-14,-12,12,-2.4,26).union(box(-28,-14,-12,12,18,26))
    s=s.union(box(-22,-14,-12,12,-4,-2))
    s=s.union(box(-113,-8,-16,16,22,26))
    for y0,y1,li,lj in ((-16,-10.3,-16,-7.5),(10.3,16,7.5,16)):
        s=s.union(box(-113,-18,y0,y1,26,34)).union(box(-113,-18,li,lj,30.8,34))
    s=s.union(box(-18,-14,-16,16,26,34))
    s=s.union(rail().translate((-20,0,0))).union(box(-14,14,-12,12,22,26))
    s=s.union(saddle(23.5,49,p))
    for z in (31,41):
        s=s.cut(box(-12,8,-15,15,z-1.8,z+1.8).cut(box(-10.4,6.4,-12.9,12.9,z-2,z+2)))
    # Rear hooks align outside the tongue guides; no elastic crosses the screen.
    for y in (-17,17):
        s=s.union(box(-32,-22,min(y,14 if y>0 else -14),max(y,14 if y>0 else -14),22,38)).union(hook(-27,y,37.8))
    s=s.union(box(-19,-10,-3,3,44,56)).union(torus((-18,0,56)))
    s=s.cut(cylinder((-18,0,43),(0,0,1),18,6.2))
    return s.cut(box(-16,-7,12,17,21,39)).cut(box(-119,-83,-10.2,10.2,21.9,26.1)).cut(box(-5.8,5.8,-8.8,8.8,21,61))


def sliding_jaw(p):
    s=box(-6,0,-7.3,7.3,-2.4,38).union(box(-6,8,-7.3,7.3,18,22))
    s=s.union(box(-6,2,-7.3,7.3,-4,-2))
    s=s.union(box(-6,66,-10,10,26.4,30.4)).union(rail(-1))
    s=s.union(box(-34,-5,-7.3,7.3,34.5,38))
    for y in (-17,17):
        s=s.union(box(-6,4,min(y,-7),max(y,7),34.5,38)).union(hook(-1,y,37.8))
    return s


@lru_cache(None)
def thread(female=False):
    # 2 mm pitch, blunt trapezoidal crest, radial running clearance 0.30 mm.
    extra=.30 if female else 0
    core=3.2+extra; outer=4+extra
    helix=cq.Wire.makeHelix(2,18,core)
    rib=cq.Workplane('XZ').polyline([(core-.15,-.65),(outer,-.25),(outer,.25),(core-.15,.65)]).close().sweep(helix,isFrenet=True)
    return cylinder((0,0,0),(0,0,1),20,2*core).union(rib.translate((0,0,1)))


def thumb_screw(p):
    s=thread().intersect(cylinder((0,0,2),(0,0,1),18,9))
    s=s.union(cylinder((0,0,0),(0,0,1),2.3,4)).union(cylinder((0,0,20),(0,0,1),4,14))
    return s


def thumb_nut(p):
    s=cq.Workplane('XY').polygon(6,18).extrude(6)
    return s.cut(thread(True).translate((0,0,-2)))


def rocker(p):
    s=box(-7,15,-3.5,3.5,28,32)
    s=s.union(cylinder((11,-3.7,30),(0,1,0),7.4,9.4))
    s=s.union(box(8,14,-3.5,3.5,6,30)).union(cylinder((6,0,6),(1,0,0),12,12.4))
    cutter=thread(True).rotate((0,0,0),(0,1,0),90).translate((.35,0,6))
    s=s.cut(cutter).cut(cylinder((11,-4,30),(0,1,0),12,6.5))
    s=s.cut(cylinder((-3,0,27),(0,0,1),7,4))
    s=s.union(cylinder((-3,3,30),(0,1,0),4,4)).union(cylinder((-3,6,30),(0,1,0),1.5,7))
    return s


def actuator_bracket(p):
    s=box(34,40,-33,33,35,84)
    for y in (-24,24):
        cut=box(33,41,y-4.4,y+4.4,56,72)
        for z in (56,72):cut=cut.union(cylinder((33,y,z),(1,0,0),7,8.8))
        s=s.cut(cut)
    for y0,y1 in ((-8,-4),(4,8)):
        s=s.union(box(5,40,y0,y1,24,39))
    s=s.union(box(-10,40,-6,6,35,39)).union(box(-10,-7.4,-6,6,25,52))
    s=s.union(torus((-3,0,52))).cut(cylinder((-3,0,33),(0,0,1),19,6))
    s=s.cut(cylinder((11,-13,30),(0,1,0),26,6.5)).cut(box(6.5,15.5,-13,13,28.9,31.1))
    a=abs(stop_angle(Parameters()))
    top=30+18*math.sin(a)+2*math.cos(a)
    # Broad stop at the end of the input arm, clear of the twine bore at X=-3.
    s=s.union(box(-8,-5,-3.5,3.5,25,28)).union(box(-8,-5,-3.5,3.5,top,top+2.4))
    s=s.union(box(16.4,22.4,8,21,10,13).union(box(19,22.4,8,12,10,39))).union(box(16,22.4,17,21,-10,13))
    for z in (-5,3,11):
        s=s.union(cylinder((19,14,z),(0,1,0),5,4)).union(cylinder((19,13,z),(0,1,0),1.5,6))
    # Head-index lug, copied from the previously checked bayonet principle.
    s=s.union(box(4.5,6,-15,-6,35,38)).union(box(4.5,9,-15,-12,33.5,37))
    return s


def axle(p):
    s=cylinder((11,-12,30),(0,1,0),22,6)
    head=cylinder((11,-15,30),(0,1,0),3,9.6).cut(box(4,9.2,-16,-11,33.3,38))
    return s.union(head).union(box(10.2,11.8,8.4,10,25.8,34.2))


def parts(p):
    return dict(carrier=carrier(p),sliding_jaw=sliding_jaw(p),actuator_bracket=actuator_bracket(p),rocker=rocker(p),pivot_key=axle(p),thumb_screw=thumb_screw(p),thumb_nut=thumb_nut(p),string_guide=guide(p))


def placed(s,p):
    if p.side=='far':s=s.rotate((0,0,0),(0,0,1),180)
    return s.translate(((p.phone_right if p.side=='near' else p.phone_left),p.button_y,p.height))


def assembly_parts(p,solids):
    out={'carrier':solids['carrier'],'sliding_jaw':solids['sliding_jaw'].translate((p.phone_left,0,0))}
    for n in ('actuator_bracket','rocker','pivot_key'):out[n]=placed(solids[n],p)
    out['contact_screw']=placed(solids['thumb_screw'].rotate((0,0,0),(0,1,0),90).translate((.35,0,6)),p)
    for i,y in enumerate((-24,24)):
        # Rail screws remain at global Z30 as bracket height changes.
        s=solids['thumb_screw'].rotate((0,0,0),(0,1,0),-90).translate((48,y,70-p.height))
        out[f'rail_screw_{i+1}']=placed(s,p)
        # Match thread phase to screw: source female occupied screw-local z6..12.
        nut=solids['thumb_nut'].rotate((0,0,0),(0,1,0),-90).translate((46,y,70-p.height))
        out[f'rail_nut_{i+1}']=placed(nut,p)
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
    string=[p.string_eye,p.first_guide,(-18,0,56)]+[(-18,0,z) for z in p.guide_stations]+[knot]
    bands={'band_collar_1':rounded_band_xy(31),'band_collar_2':rounded_band_xy(41),
        'band_return':loop_between(p.point((-3,5,30)),p.point((19,14,3)),2),
        'band_overtravel':loop_between(knot,trigger,5)}
    for i,y in enumerate((-17,17)):bands[f'band_jaw_{i+1}']=loop_between((p.phone_left-1,y,41),(-27,y,41),2)
    for i,z in enumerate(p.guide_stations):bands[f'band_guide_{i+1}']=rounded_band_xy(z,left=-22)
    return string,bands,{'trigger_pivot':(-4,0,-416),'trigger_attach':trigger,'trigger_angle':-.48,'tail_length':tail,'series_span_rest':p.series_span_rest}


def rows(p,solids):
    out=[]
    for n,s in assembly_parts(p,solids).items():
        bid='thumb_screw' if 'screw' in n else 'thumb_nut' if 'nut' in n else 'string_guide' if n.startswith('guide_') else n
        out.append((n,s,ORANGE,bid))
    for n,s in stock(p).items():
        color=(.035,.27,.75) if 'blue' in n else (.12,.14,.17) if any(x in n for x in ('black','camera','volume')) else (.6,.65,.69)
        out.append((n,s,color,None))
    out.append(('actuator_context',placed(solids['actuator_bracket'],p),ORANGE,'actuator_bracket'))
    out.append(('stock_neck_context',box(-7,7,-9.5,9.5,-65,85),(.6,.65,.69),None))
    string,bands,motion=flexible_paths(p)
    out.extend([('twine_phone',polyline(string[:4],p.twine_diameter),TWINE,'twine'),('twine',polyline(string,p.twine_diameter),TWINE,'twine')])
    for n,path in bands.items():out.append((n,polyline(path,1.4),BAND,'rubber_bands'))
    return out

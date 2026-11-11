"""V4 schematic cords anchored to the accepted tail handle and cap passages.

Dimensions follow the approved solids; knots, elastic force and loaded routing
are not simulated. The old V3 inline-band split is deliberately not used.
"""
import math
from plunger_design import _current_routes,local_point
from build_tail_handle import SHIFT


def routes(p,travel=0):
    rest=min(_current_routes(),key=lambda f:abs(f['travel']))
    def world(q):return list(p.point(local_point(q)))
    attachment=[world((u,v+SHIFT-travel,w)) for u,v,w in rest['attachment']]
    band=[world((u,v+(SHIFT-travel if 5<=i<=10 else 0),w)) for i,(u,v,w) in enumerate(rest['band'])]
    # The lead starts on the front-right corner of the handle's string wrap.
    a=(rest['lead'][0][0],rest['lead'][0][1]+SHIFT-travel,12.65)
    u,v=10.475091906795965,16.3
    radius=6.8+(.5*math.sqrt(1+(1.6/2.2)**2)-.2)/(1.6/2.2)
    sign=1 if p.side=='near' else -1
    entry=[-1.,sign*22.25,-13.]
    exit=[-1.,sign*22.25,-37.]
    tu,tv=8-(entry[2]-p.height),entry[0]-p.phone_right-8.35
    start=math.atan2(a[1]-v,a[0]-u)+math.acos(radius/math.hypot(a[0]-u,a[1]-v))
    end=math.atan2(tv-v,tu-u)-math.acos(radius/math.hypot(tu-u,tv-v))
    while end<start:end+=2*math.pi
    arc=[world((u+radius*math.cos(start+(end-start)*i/40),v+radius*math.sin(start+(end-start)*i/40),12.65)) for i in range(41)]
    head=[world(a)]+arc+[entry,exit]
    trigger=[-42.,0.,-417.]
    return dict(travel_mm=travel,string_points=head+[trigger],phone_points=head,
                attachment_points=attachment,return_points=band,
                cap_entry=entry,cap_exit=exit,trigger=trigger)


def motion(p):
    frames=[routes(p,12.6*i/20) for i in range(21)]
    return dict(v4_routes=frames,return_moving_indices=list(range(5,11)),
      schematic_warning='V4 continuous string: tail-handle wrap, pulley, cap passage, stock trigger. No inline band. Return band follows actual shifted handle. Knots, elastic deformation, force and guide friction are not modeled.')

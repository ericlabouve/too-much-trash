"""One unchanged axle key travels with the plunger in a stationary closed slot."""
import math
import cadquery as cq
from build_steep_stop import geometry_stop, prism
from plunger_design import box
from shared_key_design import snap_key

def geometry_common_key():
    br,pl,_,context,*_=geometry_stop()
    upper=4-3.2/math.tan(math.radians(70))
    pl=pl.union(prism([(-4,3.4),(4,3.4),(upper,6.6),(-upper,6.6)],15.35,35))
    seat=cq.Workplane('YZ').polyline([(23,6.6),(26.5,9.2),(33.5,9.2),(37,6.6)]).close().extrude(7).translate((-3.5,0,0))
    seat=seat.intersect(prism([(-upper,6.6),(upper,6.6),(3.5,7.6),(3.5,9.2),(-3.5,9.2),(-3.5,7.6)],23,37))
    # Keep the established ramp slopes; trim only the top of the seat.
    seat=seat.intersect(box(-10,10,20,40,6.6,8.4))
    # Trim the top while preserving the existing printable ramp angles.
    seat=seat.intersect(box(-10,10,20,40,6.6,8.4))
    pl=pl.union(seat).cut(box(-1.7,1.7,28.3,31.7,3,10)).clean()
    br=br.cut(box(-1.7,1.7,15.9,31.7,-.1,3.1)).clean()
    key=snap_key().translate((-18,-8,-.3)).rotate((0,0,0),(0,1,0),-90).rotate((0,0,0),(0,0,1),90).translate((0,30,8.4))
    return br,pl,key,context

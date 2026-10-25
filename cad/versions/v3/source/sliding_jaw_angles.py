"""45-degree underside study; active V3 and approved cuff studs unchanged."""
import cadquery as cq
import model as m

def candidate():
    s=m.sliding_jaw(m.Parameters(),support_angle=None)
    # Replace only the cleat stem underside with a pitched 45-degree roof.
    # X is build height; original square cap at Z45..47.5 is retained.
    s=s.cut(m.box(-11,0,-10.1,10.1,38.5,45))
    stem=(cq.Workplane('XZ').polyline([(-10,38.5),(-6.75,41.75),
        (-10,45),(-3,45),(-3,38.5)]).close().extrude(7.5,both=True))
    s=s.union(stem).union(m.box(-10,-.5,-7.5,7.5,32,38.5))
    # Support the tongue's lateral shoulders without altering the tongue
    # itself: four mm rise for three mm run (53.1 degrees from the bed).
    for sign in (-1,1):
        wedge=(cq.Workplane('XY').polyline([(-10,sign*7),(-6,sign*10),(-6,sign*7)])
            .close().extrude(4).translate((0,0,26.4)))
        s=s.union(wedge)
    return s.clean()

"""Reversible single-eye TPU neck clip; physical snap/retention unqualified."""
import cadquery as cq

BORE = 4.0  # Half the former 8 mm diameter, not half its area.
EYE_Y = 15.2
THICKNESS = 6.0
OPENING_X, OPENING_Y = 13.8, 18.8
WALL = 1.6
MOUTH = 13.0

def guide():
    # End-on-bed extrusion: no band grooves, raised back block or second eye.
    # 0.1 mm nominal interference per face proposes light TPU preload.
    # Rounded corners flex around the measured 14 x 19 neck, not the rigid
    # collar's empirically undersized 11.6 x 17.6 opening.
    outer = cq.Workplane('XY').rect(OPENING_X+2*WALL, OPENING_Y+2*WALL).extrude(THICKNESS).edges('|Z').fillet(2)
    inner = cq.Workplane('XY').rect(OPENING_X, OPENING_Y).extrude(THICKNESS+2).translate((0,0,-1)).edges('|Z').fillet(.4)
    mouth = cq.Workplane('XY').box(12,MOUTH,THICKNESS+2).translate((10,0,THICKNESS/2))
    clip = outer.cut(inner).cut(mouth)
    root = cq.Workplane('XY').box(8,5,THICKNESS).translate((0,12.7,THICKNESS/2))
    eye = cq.Workplane('XY').center(0,EYE_Y).circle(4).extrude(THICKNESS)
    hole = cq.Workplane('XY').center(0,EYE_Y).circle(BORE/2).extrude(THICKNESS+2).translate((0,0,-1))
    return clip.union(root).union(eye).cut(inner).cut(hole).translate((0,0,-THICKNESS/2))

def placed(shape, z, side='near'):
    # Flip end-for-end around X: same snap mouth, eye on the opposite side.
    if side == 'far': shape = shape.rotate((0,0,0),(1,0,0),180)
    return shape.translate((0,0,z))

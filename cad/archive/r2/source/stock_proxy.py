"""Unmeasured stock-tool silhouettes for the full assembly drawing.

Only the square neck cross-section and front-view relationships are known from
the reference image. These non-printable solids are visual envelopes, not
reverse-engineered factory geometry or claw-sweep clearance evidence.
"""

import cadquery as cq

from parameters import Parameters
from parts import box, round_post


def rod_between(a, b, radius):
    start = cq.Vector(*a)
    direction = cq.Vector(*b).sub(start)
    return cq.Solid.makeCylinder(radius, direction.Length,
                                 start, direction.normalized())


def compound(solids):
    return cq.Workplane("XY").newObject([cq.Compound.makeCompound(solids)])


def stock_shapes(p: Parameters):
    y = p.neck_center_y
    neck = box(-p.neck_width/2, p.neck_width/2,
               y-p.neck_width/2, y+p.neck_width/2,
               p.shaft_visible_low_z, p.shaft_visible_high_z)
    # The front photo constrains this V silhouette, but provides no scale or
    # measured side depth. Segment cylinders represent the two curved jaws.
    arms = []
    braces = []
    feet = []
    for side in (-1, 1):
        points = [(side*x, y, z) for x, z in
                  ((7, 75), (21, 92), (40, 118), (53, 146), (61, 172))]
        arms.extend(rod_between(a, b, 3.1) for a, b in zip(points, points[1:]))
        braces.append(rod_between((side*5, y, 75),
                                   (side*61, y, 172), 1.25))
        foot = box(side*61-7, side*61+7, y-9, y+9, 167, 188)
        feet.append(foot.edges("|Y").fillet(2).val())
    center_brace = box(-17, 17, y-12, y+12, -163, -139)
    # Blue handle/head and black moving trigger: front-silhouette proxies.
    handle_head = (cq.Workplane("XZ")
                   .polyline([(-13, -404), (14, -404), (30, -437),
                              (28, -469), (5, -481), (-17, -458)])
                   .close().extrude(12, both=True).translate((0, y, 0)))
    handle_grip = (cq.Workplane("XZ")
                   .polyline([(-10, -445), (8, -465), (-10, -482),
                              (-48, -563), (-73, -566), (-76, -530),
                              (-35, -466)])
                   .close().extrude(11, both=True).translate((0, y, 0)))
    handle = handle_head.union(handle_grip)
    trigger = (cq.Workplane("XZ")
               .polyline([(-16, -435), (-73, -439), (-78, -451),
                          (-33, -451), (-15, -445)])
               .close().extrude(6, both=True).translate((0, y, 0)))
    phone = box(p.phone_left, p.phone_left+p.phone_width,
                -p.phone_length, 0, p.phone_bottom_z,
                p.phone_bottom_z+p.phone_thickness)
    lenses = compound([round_post(x, yy,
                                  p.phone_bottom_z+p.phone_thickness,
                                  p.phone_bottom_z+p.phone_thickness+2.2, 4.2).val()
                       for x, yy in ((p.phone_left+14, -p.phone_length+15),
                                     (p.phone_left+27, -p.phone_length+15),
                                     (p.phone_left+14, -p.phone_length+28))])
    return {
        "stock_square_neck_envelope": neck,
        "stock_claw_arms_proxy": compound(arms+braces),
        "stock_claw_feet_proxy": compound(feet),
        "stock_blue_center_brace_proxy": center_brace,
        "stock_blue_handle_proxy": handle,
        "stock_black_trigger_proxy": trigger,
        "phone_envelope_only": phone,
        "phone_camera_markers_proxy": lenses,
    }

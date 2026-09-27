"""Printable reacher retrofit parts, made with CadQuery 2.6.1."""

import cadquery as cq

from parameters import Parameters


def box(x0, x1, y0, y1, z0, z1):
    return cq.Workplane("XY").box(x1-x0, y1-y0, z1-z0).translate(
        ((x0+x1)/2, (y0+y1)/2, (z0+z1)/2))


def hole_x(x0, x1, y, z, radius):
    return cq.Solid.makeCylinder(radius, x1-x0, cq.Vector(x0, y, z), cq.Vector(1, 0, 0))


def hole_z(x, y, z0, z1, radius):
    return cq.Solid.makeCylinder(radius, z1-z0, cq.Vector(x, y, z0), cq.Vector(0, 0, 1))


def round_post(x, y, z0, z1, radius):
    return cq.Workplane("XY").circle(radius).extrude(z1-z0).translate((x, y, z0))


def carrier_frame(p: Parameters):
    """Open screen-side cradle; only short edge pads and left spine touch phone."""
    left = p.rail_x
    right = p.right_rail_x
    end = -p.phone_length
    part = box(left, left+7, end-6, 6, -4.5, 0)
    for y0, y1 in ((end-6, end+9), (-9, 6)):
        part = part.union(box(left, right+7, y0, y1, -4.5, 0))
    # Edge-contact lands leave the screen and rear camera area open.
    for y0, y1 in ((end-5, end+11), (-11, 5)):
        part = part.union(box(left, left+7, y0, y1, 0, p.pad_height))
        part = part.union(box(left, left+7, y0, y1, p.pad_height, p.pad_height+p.phone_thickness+1.3))
        part = part.union(box(left+6, left+7+p.lip_overlap, y0, y1,
                              p.pad_height+p.phone_thickness, p.pad_height+p.phone_thickness+1.3))
    # End walls retain the phone lengthwise; charging-port center stays open.
    for x0, x1 in ((left, left+11), (right-4, right+7)):
        part = part.union(box(x0, x1, end-3, end-p.phone_end_clearance, 0, 8))
        part = part.union(box(x0, x1, p.phone_end_clearance, 3, 0, 8))
    # Four slotted right-rail mounts, reached from below with M3 screws.
    for y in (end+1, end+7, -7, -1):
        part = part.cut(box(right-p.rail_adjustment-1.7,
                            right+p.rail_adjustment+1.7,
                            y-1.7, y+1.7, -5, 0.5))
    # Outboard lugs keep clamp bolt heads away from the phone underside.
    for y in (p.neck_center_y-13, p.neck_center_y+13):
        part = part.union(box(12, left, y-5, y+5, -4.5, 0))
        part = part.cut(hole_z(16, y, -5, 2, p.m4_clearance/2))
        part = part.cut(cq.Solid.makeCone(2.2, 4.2, 2.1,
                        cq.Vector(16, y, -2.1), cq.Vector(0, 0, 1)))
    # Lever pivot and a low guard around the reachable lever region.
    part = part.union(box(0, left, -72, -58, -4.5, 0))
    part = part.union(round_post(10, -65, 0, 4, 5.0))
    part = part.cut(hole_z(10, -65, -5, 10, p.pivot_clearance/2))
    part = part.cut(hole_z(18, -62, -1, 5, 0.7))  # torsion spring fixed leg
    # Cable ferrule is reacted by the fixed frame; only inner wire continues.
    part = part.union(box(-13, 1, -49, -39, -4.5, 14))
    part = part.union(box(0, left, -50, -45, -4.5, 0))
    part = part.cut(hole_x(-14, -2, -44, 7, (p.cable_housing_od+0.35)/2))
    part = part.cut(hole_x(-2, 2, -44, 7, (p.cable_wire_od+0.5)/2))
    # Adjustable stop screw in a fixed ear limits cable-arm sweep.
    part = part.union(box(-2, 4, -59, -50, -4.5, 11))
    part = part.cut(hole_x(-3, 5, -54, 7, p.m3_clearance/2))
    part = part.cut(box(-2.1, 0.8, -56.9, -51.1, 4.1, 9.9))  # M3 nut trap
    return part


def movable_rail(p: Parameters):
    x = p.right_rail_x
    end = -p.phone_length
    part = box(x, x+7, end-6, 6, 0, 4)
    for y0, y1 in ((end-5, end+11), (-11, 5)):
        part = part.union(box(x, x+7, y0, y1, 4, p.pad_height+p.phone_thickness+1.3))
        part = part.union(box(x-p.lip_overlap, x+1, y0, y1,
                              p.pad_height+p.phone_thickness, p.pad_height+p.phone_thickness+1.3))
    for y in (end+1, end+7, -7, -1):
        part = part.cut(hole_z(x+3.5, y, -1, 15, p.m3_clearance/2))
    return part


def neck_half(p: Parameters, side: str, handle: bool = False):
    """Flat-faced split square collar. Handle version has a braced outrigger."""
    half_gap = 0.3
    x0, x1 = (-14, -half_gap) if side == "cap" else (half_gap, 14)
    z0, z1 = (-11, 11) if handle else (-p.neck_clamp_length/2, p.neck_clamp_length/2)
    part = box(x0, x1, -14, 14, z0, z1)
    groove = (p.neck_width+p.neck_clearance)/2
    part = part.cut(box(-groove, groove, -groove, groove, z0-1, z1+1))
    for y in (-20, 20):
        for z in ((-13, 13) if not handle else (0,)):
            part = part.union(box(x0, x1, y-7, y+7, z-5, z+5))
            part = part.cut(hole_x(x0-1, x1+1, y, z, p.m4_clearance/2))
    if side == "saddle" and not handle:
        # Wing under carrier's left rail. Two M4 screws join the modules.
        part = part.union(box(9, 28, -20, 20, -12, -4))
        for y in (-13, 13):
            part = part.cut(hole_z(16, y, -13, -3, p.m4_clearance/2))
    if side == "cap" and handle:
        # Fixed outrigger positions housing stop beyond the moving trigger tab.
        reach = p.handle_anchor_reach
        part = part.union(box(-reach, -13, -5, 5, -11, -1))
        part = part.union(box(-reach-5, -reach+5, -9, 9, -11, 11))
        part = part.cut(hole_x(-reach-6, -reach+4, 0, 0, (p.cable_housing_od+0.35)/2))
        part = part.cut(hole_x(-reach+4, -reach+7, 0, 0, (p.cable_wire_od+0.5)/2))
    return part


def button_lever(p: Parameters):
    """Pinned two-arm bell crank: leftward cable pull rotates tip toward phone."""
    # Print flat. A 3 mm metal pivot and washer take wear; polymer is not a pin.
    part = round_post(10, -65, 4.3, 9, 6)
    part = part.union(box(7, 13, -65, -39, 4.3, 9))
    arm = (cq.Workplane("XY").polyline([(8, -66), (14, -66), (21, -80),
                                         (19, -84), (13, -74), (8, -70)])
           .close().extrude(4.7).translate((0, 0, 4.3)))
    part = part.union(arm)
    part = part.union(box(16, 22, p.button_y-4, p.button_y+4, 4.3, 9))
    part = part.cut(hole_z(10, -65, 4, 10, p.pivot_clearance/2))
    part = part.cut(hole_z(10, -57, 4, 10, 0.7))  # torsion spring moving leg
    # Cable nipple keyhole: 6 mm barrel sits vertically, wire enters from left.
    part = part.union(round_post(10, -43, 4.3, 11, 5))
    part = part.union(round_post(16, -43, 4.3, 9, 3.5))
    part = part.cut(hole_z(10, -43, 6, 12, 3.1))
    part = part.cut(box(4, 10, -44, -42, 7, 9))
    part = part.cut(hole_z(16, -43, 4, 10, 1.1))  # M2 + wide washer keeper
    # Horizontal M3 screw + captured nut / silicone tip set the rest gap.
    part = part.cut(hole_x(15, 23, p.button_y, p.pad_height+p.button_z, p.m3_clearance/2))
    return part


def trigger_tab(p: Parameters):
    """Cable-tied saddle for the stock moving trigger, sized after measurement."""
    part = box(-18, 18, -10, 10, 0, 4)
    part = part.union(box(-18, -14, -10, 10, 0, 11))
    part = part.union(box(14, 18, -10, 10, 0, 11))
    # Cable-tie windows; two ties resist rocking on the tapered trigger.
    for x in (-10, 10):
        for y in (-6, 6):
            part = part.cut(box(x-2, x+2, y-2, y+2, -1, 5))
    # Inner wire pinches under an M3 washer/nut atop the central tongue.
    part = part.union(box(-5, 5, -5, 5, 4, 10))
    part = part.cut(hole_z(0, 0, 3, 11, p.m3_clearance/2))
    return part


def all_parts(p: Parameters):
    return {
        "carrier_frame": carrier_frame(p),
        "movable_rail": movable_rail(p),
        "neck_saddle": neck_half(p, "saddle"),
        "neck_cap": neck_half(p, "cap"),
        "button_lever": button_lever(p),
        "handle_anchor_saddle": neck_half(p, "saddle", handle=True),
        "handle_anchor_cap": neck_half(p, "cap", handle=True),
        "trigger_tab": trigger_tab(p),
    }

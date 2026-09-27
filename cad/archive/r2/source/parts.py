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
    """Fixed side and charging edge, with guides for three independent slides."""
    left = p.rail_x
    bottom = -p.phone_length_max-8
    part = box(left, left+11, bottom, 6, -4.5, 4)
    # External spine carries the removable actuator without occupying the
    # phone's volume-button edge. It also reinforces the camera-shoe slot.
    part = part.union(box(12, left, bottom, 6, -4.5, 0))
    for y0, y1 in ((bottom, bottom+9), (-85, -77), (-9, 6)):
        part = part.union(box(left, p.right_rail_x_max+11, y0, y1, -4.5, 0))
    # Fixed charging-end corner: the port/microphone center stays open.
    part = part.union(box(left, left+7, -11, 5, 4, p.lip_bottom_z+1.3))
    part = part.union(box(left+6, left+7+p.lip_overlap, -11, 5,
                          p.lip_bottom_z, p.lip_bottom_z+1.3))
    part = part.union(box(left, left+15, p.phone_end_clearance, 3, 4, 13))
    # Right rail slides in X; the two camera shoes slide in Y. All adjustments
    # use common M3 through-bolts and remain outside the phone body.
    for y in (bottom+3, -81, -5):
        part = part.cut(box(p.right_rail_x_min+7-1.7,
                            p.right_rail_x_max+7+1.7,
                            y-1.7, y+1.7, -5, 0.5))
    camera_slot_y0 = -p.phone_length_max-1
    camera_slot_y1 = -p.phone_length_min+10
    part = part.cut(box(left+3.5-1.7, left+3.5+1.7,
                        camera_slot_y0, camera_slot_y1, -5, 4.5))
    part = part.cut(box(16-1.7, 16+1.7,
                        p.button_y_min-47, p.button_y_max-3, -5, 0.5))
    # Outboard M4 lugs connect to the unchanged square-neck split clamp.
    for y in (p.neck_center_y-13, p.neck_center_y+13):
        part = part.cut(hole_z(16, y, -5, 2, p.m4_clearance/2))
        part = part.cut(cq.Solid.makeCone(2.2, 4.2, 2.1,
                        cq.Vector(16, y, -2.1), cq.Vector(0, 0, 1)))
    return part


def movable_rail(p: Parameters):
    bottom = -p.phone_length_max-8
    part = box(-4, 11, bottom, 6, 0, 4)
    part = part.union(box(0, 7, -11, 5, 4, p.lip_bottom_z+1.3))
    part = part.union(box(-p.lip_overlap, 1, -11, 5,
                          p.lip_bottom_z, p.lip_bottom_z+1.3))
    part = part.union(box(-8, 11, p.phone_end_clearance, 3, 4, 13))
    for y in (bottom+3, -81, -5):
        part = part.cut(hole_z(7, y, -1, 4.5, p.m3_clearance/2))
    part = part.cut(box(7-1.7, 7+1.7,
                        -p.phone_length_max-1, -p.phone_length_min+10,
                        -1, 4.5))
    return part


def camera_end_shoe(p: Parameters, side: str):
    """Two bolt-locked corner shoes set the phone length without reprinting."""
    if side == "left":
        x0, x1, bolt_x = p.rail_x, p.rail_x+7, p.rail_x+3.5
        lip0, lip1 = x1-1, x1+p.lip_overlap
        stop0, stop1 = x0, x1+8
    else:
        x0, x1, bolt_x = 0, 11, 7
        lip0, lip1 = -p.lip_overlap, 1
        stop0, stop1 = -8, x1
    part = box(x0, x1, -5, 15, 4, p.lip_bottom_z+1.3)
    part = part.union(box(lip0, lip1, -5, 15,
                          p.lip_bottom_z, p.lip_bottom_z+1.3))
    part = part.union(box(stop0, stop1, -3, -p.phone_end_clearance, 4, 13))
    for y in (2, 8):
        part = part.cut(hole_z(bolt_x, y, 3, p.lip_bottom_z+2, p.m3_clearance/2))
    return part


def actuator_carriage(p: Parameters):
    """Sliding cable stop/pivot unit; both cable reactions move with button Y."""
    part = box(0, 20, -49, 3, -9, -4.5)
    for y in (-45, -5):
        part = part.cut(hole_z(16, y, -10, -3, p.m3_clearance/2))
    part = part.union(round_post(6, -16, -4.5, 4.7, 5))
    part = part.cut(hole_z(6, -16, -10, 12, p.pivot_clearance/2))
    part = part.union(round_post(0, -19, -4.5, 4.7, 2.5))
    part = part.cut(hole_z(0, -19, -5, 6, 0.7))
    # The housing ferrule seats against this fixed block; only wire passes.
    part = part.union(box(-4, 2, -42, -32, -9, -4.5))
    part = part.union(box(-17, -3, -42, -32, -9, 14))
    part = part.cut(hole_x(-18, -6, -37, 8.2, (p.cable_housing_od+0.35)/2))
    part = part.cut(hole_x(-6, -2, -37, 8.2, (p.cable_wire_od+0.5)/2))
    # Captive M3 stop nut sets positive overtravel limit.
    part = part.union(box(-6, 2, -29, -21, -9, 15))
    part = part.cut(hole_x(-7, 3, -26, 8.2, p.m3_clearance/2))
    part = part.cut(box(-6.1, -3.2, -28.9, -23.1, 5.3, 11.1))
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
    """Local bell crank with a vertical contact slot for differing button heights."""
    # Print flat. A 3 mm metal pivot and washer take wear; polymer is not a pin.
    part = round_post(6, -16, 5, 9.7, 6)
    part = part.union(box(3, 9, -42, -16, 5, 9.7))
    arm = (cq.Workplane("XY").polyline([(4, -16), (10, -16), (21, -2),
                                         (19, 4), (11, -6), (4, -12)])
           .close().extrude(4.7).translate((0, 0, 5)))
    part = part.union(arm)
    part = part.union(box(16, 22, -4, 4, 5, 18))
    part = part.cut(hole_z(6, -16, 4.7, 11, p.pivot_clearance/2))
    part = part.cut(hole_z(6, -24, 4.7, 11, 0.7))  # torsion spring moving leg
    # Cable nipple keyhole: 6 mm barrel sits vertically, wire enters from left.
    part = part.union(round_post(6, -38, 5, 12, 5))
    part = part.union(round_post(12, -38, 5, 9.7, 3.5))
    part = part.cut(hole_z(6, -38, 6.7, 13, 3.1))
    part = part.cut(box(0, 6, -39, -37, 7.7, 9.7))
    part = part.cut(hole_z(12, -38, 4.7, 11, 1.1))  # M2 + wide washer keeper
    # M3 contact screw slides in Z and locks with opposed washers/jam nuts.
    part = part.cut(box(15, 23, -1.7, 1.7, 7.2, 16.2))
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
        "camera_end_left": camera_end_shoe(p, "left"),
        "camera_end_right": camera_end_shoe(p, "right"),
        "actuator_carriage": actuator_carriage(p),
        "neck_saddle": neck_half(p, "saddle"),
        "neck_cap": neck_half(p, "cap"),
        "button_lever": button_lever(p),
        "handle_anchor_saddle": neck_half(p, "saddle", handle=True),
        "handle_anchor_cap": neck_half(p, "cap", handle=True),
        "trigger_tab": trigger_tab(p),
    }

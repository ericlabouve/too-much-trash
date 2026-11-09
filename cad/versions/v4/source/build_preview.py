"""Export assembly-coordinate meshes for the V4 broad, flush shaft liners."""
from pathlib import Path
import json
import math
import sys
import cadquery as cq

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / 'v3' / 'source'))
from model import Parameters, box, cylinder, carrier, shaft_cap, parts, assembly_parts, flexible_paths, polyline
from cuff_design import CUFF_Z, FIXED_CUFF_X, FIXED_CUFF_Y, integral_stud, locate

FIXED_CUFF_DROP = CUFF_Z - 8.0
JAW_WINDOW_END = 4.0 - FIXED_CUFF_DROP
RAIL_TIP = 13.8 + (60.0 - 13.8) * 0.7


def shorter_cap_rails(shape):
    # Replace just the projecting wings, preserving their root and slot width.
    for y0, y1 in ((-100, -13.8), (13.8, 100)):
        shape = shape.cut(box(-30, 30, y0, y1, 16, 36))
    rail = box(7.8, 12, -RAIL_TIP, RAIL_TIP, 16, 36).edges('|X').fillet(1.2)
    for sign in (-1, 1):
        ends = sorted((sign * 18.5, sign * (RAIL_TIP - 7)))
        slot = box(7, 13, ends[0], ends[1], 21.6, 30.4)
        for y in ends:
            slot = slot.union(cylinder((7, y, 26), (1, 0, 0), 6, 8.8))
        rail = rail.cut(slot)
    for y0, y1 in ((-100, -13.8), (13.8, 100)):
        shape = shape.union(rail.intersect(box(-30, 30, y0, y1, 16, 36)))
    return shape.clean()


def aligned_fixed_jaw(params):
    jaw = carrier(params)
    stud = locate(integral_stud(), FIXED_CUFF_X, FIXED_CUFF_Y, True)
    # Remove only the exposed stud, leaving the jaw backing intact.
    jaw = jaw.cut(stud.intersect(box(-100, -11.3, -20, 20, -20, 40)))
    jaw = jaw.union(stud.translate((0, 0, -FIXED_CUFF_DROP)))
    # Preserve the original ligament below the lowered stud root.
    old_window = box(-11.3, -5.8, -5.5, 5.5, -30, 4).edges('|X').fillet(5.49)
    new_window = box(-12, -0.4, -5.5, 5.5, -30, JAW_WINDOW_END).edges('|X').fillet(5.49)
    jaw = jaw.union(old_window).cut(new_window).clean()
    # Extend the arm opening toward the clamp, retaining its 6 mm width
    # and the existing 35-degree roof at the far end in the print pose.
    rise = 3 * math.tan(math.radians(35))
    points = [(-22, -3), (-56, -3), (-56-rise, 0),
              (-56, 3), (-22, 3), (-20, 0)]
    cutter = cq.Workplane('XY').polyline(points).close().extrude(5).translate((0, 0, 21.5))
    extended = jaw.cut(cutter).clean()
    print(f'Fixed-jaw arm opening saves {jaw.val().Volume() - extended.val().Volume():.1f} mm³ of solid CAD volume')
    return extended


def shorten_clamp(shape):
    """Move each screw-bearing end inward 5 mm across plain wall sections."""
    lower = shape.intersect(box(-200, 200, -100, 100, -100, -15))
    middle = shape.intersect(box(-200, 200, -100, 100, -10, 44))
    upper = shape.intersect(box(-200, 200, -100, 100, 49, 100))
    return middle.union(lower.translate((0, 0, 5))).union(upper.translate((0, 0, -5))).clean()


def liner(seat, face: float, half_width: float, windows: tuple[tuple[float, float], ...]):
    """Replace the actual contact skin with TPU, preserving its open windows."""
    direction = 1 if face > 0 else -1
    low, high = sorted((face, face + direction * 0.8))
    skin = seat.intersect(box(low, high, -half_width, half_width, -40, 70))

    # Continuous return lips register in the rigid windows. Start behind the
    # contact face so the shaft-facing surface retains the full openings.
    low, high = sorted((face + direction * 0.2, face + direction * 2.4))
    wall = 0.8
    for z_min, z_max in windows:
        outer = box(low, high, -5.5, 5.5, z_min, z_max).edges('|X').fillet(5.49)
        inner = box(low - 0.1, high + 0.1, -5.5 + wall, 5.5 - wall,
                    z_min + wall, z_max - wall).edges('|X').fillet(5.49 - wall)
        skin = skin.union(outer.cut(inner))
    return skin


def build(output: Path) -> None:
    params = Parameters(phone_thickness=8, button_from_screen=4)
    original_cap = shorter_cap_rails(shorten_clamp(shaft_cap(params)))
    original_jaw = shorten_clamp(aligned_fixed_jaw(params))
    face = params.collar_opening_x / 2
    half_width = params.collar_opening_y / 2
    cap_liner = liner(original_cap, face, half_width, ((-25, 55),))
    jaw_liner = liner(original_jaw, -face, half_width, ((-25, JAW_WINDOW_END), (38, 55)))

    # Cap seat opens away from the bed. The jaw's entire bed face steps back
    # as a plane, so the liner does not introduce a blind pocket over the bed.
    cap = original_cap.cut(box(-10, face + 0.8, -half_width, half_width, -40, 70))
    jaw = original_jaw.cut(box(-face - 0.8, 30, -80, 80, -50, 80))
    for pad, seat, side in ((cap_liner, cap, 1), (jaw_liner, jaw, -1)):
        overlap = sum(s.Volume() for s in pad.intersect(seat).solids().vals())
        if overlap > 1e-5:
            raise ValueError(f'Liner intersects the rigid seat by {overlap:.3f} mm³')
        bounds = pad.val().BoundingBox()
        contact_face = bounds.xmin if side == 1 else bounds.xmax
        if abs(contact_face - side * face) > 1e-5:
            raise ValueError('Liner must be flush with the original shaft-contact face')
        for surface in pad.faces('|X').vals():
            if abs(surface.Center().x - side * face) < 1e-5:
                print(f'{"Cap" if side == 1 else "Fixed jaw"} TPU contact area: {surface.Area():.1f} mm²')

    shaft = box(-face, face, -half_width, half_width, -54, 83)
    output.mkdir(parents=True, exist_ok=True)
    shapes = {'cap': cap, 'jaw': jaw, 'cap-liner': cap_liner,
              'jaw-liner': jaw_liner, 'shaft': shaft}
    for name, shape in shapes.items():
        solid = shape.val()
        if len(shape.solids().vals()) != 1 or not solid.isValid():
            raise ValueError(f'Invalid preview solid: {name}')
        solid.exportStl(str(output / f'{name}.stl'), tolerance=0.025,
                        angularTolerance=0.12, relative=False)

    context = []
    surrounding = assembly_parts(params, parts(params))
    for name, shape in surrounding.items():
        if name in ('shaft_cap', 'carrier') or name.startswith('guide_'):
            continue
        if name.startswith('clamp_'):
            shape = shape.translate((0, 0, 5 if shape.val().Center().z < 15 else -5))
        if name == 'cuff_fixed':
            shape = shape.translate((0, 0, -FIXED_CUFF_DROP))
        soft = name.startswith('cuff_') or 'screw' in name or 'nut' in name or name == 'pulley_key'
        shape.val().exportStl(str(output / f'{name}.stl'), tolerance=0.025,
                             angularTolerance=0.12, relative=False)
        context.append({'name': name, 'color': '#16aebd' if soft else '#e68b37'})
    _, bands, _ = flexible_paths(params)
    for name, path in bands.items():
        if name == 'band_overtravel':
            continue
        polyline(path, 1).val().exportStl(str(output / f'{name}.stl'), tolerance=0.025)
        context.append({'name': name, 'color': '#a052b4'})
    (output / 'context.json').write_text(json.dumps(context, indent=2) + '\n')


if __name__ == '__main__':
    build(Path(sys.argv[1]))

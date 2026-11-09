"""Export assembly-coordinate meshes for the V4 broad, flush shaft liners."""
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / 'v3' / 'source'))
from model import Parameters, box, carrier, shaft_cap


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
    params = Parameters()
    original_cap = shaft_cap(params)
    original_jaw = carrier(params)
    face = params.collar_opening_x / 2
    half_width = params.collar_opening_y / 2
    cap_liner = liner(original_cap, face, half_width, ((-30, 60),))
    jaw_liner = liner(original_jaw, -face, half_width, ((-30, 4), (38, 60)))

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


if __name__ == '__main__':
    build(Path(sys.argv[1]))

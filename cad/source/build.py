"""Regenerate printable STLs, editable STEP assembly, and CAD-derived drawing.

Run from cad/: uv run python source/build.py
"""

from pathlib import Path

import cadquery as cq
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.art3d import Poly3DCollection
import numpy as np
import trimesh

from parameters import Parameters
from parts import all_parts, box


ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "print"
P = Parameters()
ORANGE = (0.96, 0.35, 0.07)


def location(x=0, y=0, z=0):
    return cq.Location(cq.Vector(x, y, z))


def make_assembly(parts):
    assembly = cq.Assembly(name="reacher_retrofit_prototype")
    # All eight printable pieces remain individually editable in the STEP tree.
    for name, shape in parts.items():
        if name.startswith("neck_"):
            loc = location(y=P.neck_center_y)
        elif name.startswith("handle_"):
            loc = location(y=P.neck_center_y, z=P.handle_station_z)
        elif name == "trigger_tab":
            loc = location(x=P.trigger_tab_x, y=P.neck_center_y, z=P.handle_station_z)
        else:
            loc = location()
        assembly.add(shape, name=name, loc=loc, color=cq.Color(*ORANGE))
    # Transparent-looking stock/phone proxies in the drawing; these are NOT
    # claims about the unknown factory contours and are not printable exports.
    neck = box(-P.neck_width/2, P.neck_width/2,
               P.neck_center_y-P.neck_width/2,
               P.neck_center_y+P.neck_width/2,
               P.shaft_visible_low_z, P.shaft_visible_high_z)
    phone = box(P.phone_left, P.phone_left+P.phone_width,
                -P.phone_length, 0, P.pad_height,
                P.pad_height+P.phone_thickness)
    assembly.add(neck, name="stock_square_neck_envelope", color=cq.Color(.68, .72, .76))
    assembly.add(phone, name="phone_envelope_only", color=cq.Color(.16, .20, .25))
    return assembly, neck, phone


def plot_shape(ax, shape, color, alpha=1, stride=1):
    # Use CadQuery's actual triangles, keeping drawing independent of STL viewer.
    vertices, faces = shape.val().tessellate(0.7, 0.15)
    verts = np.array([[v.x, v.y, v.z] for v in vertices])
    triangles = verts[np.array(faces[::stride])]
    normals = np.cross(triangles[:, 1]-triangles[:, 0], triangles[:, 2]-triangles[:, 0])
    normals /= np.maximum(np.linalg.norm(normals, axis=1)[:, None], 1e-9)
    light = np.array([.35, -.45, .82])
    lighting = .62 + .38*np.maximum(0, normals @ light)
    colors = np.clip(np.array(color)[None, :]*lighting[:, None], 0, 1)
    collection = Poly3DCollection(triangles, facecolors=colors,
                                  edgecolors=(.15, .11, .09, .12), linewidths=.06,
                                  alpha=alpha, zsort="average")
    ax.add_collection3d(collection)


def drawing(parts, neck, phone):
    fig = plt.figure(figsize=(15, 8), facecolor="white")
    ax = fig.add_subplot(121, projection="3d", proj_type="ortho")
    for name in ("carrier_frame", "movable_rail", "button_lever"):
        plot_shape(ax, parts[name], ORANGE)
    for name in ("neck_saddle", "neck_cap"):
        plot_shape(ax, parts[name].translate((0, P.neck_center_y, 0)), ORANGE)
    plot_shape(ax, neck, (.72, .75, .78), .32, 3)
    plot_shape(ax, phone, (.18, .23, .29), .25, 2)
    # Cable path is a diagrammatic line; geometry of the ferrule and lever is CAD.
    ax.plot([-55, -13, -2, 10], [-75, -75, -44, -44],
            [-105, -20, 7, 12], color="#202a32", linewidth=2.5)
    ax.set(xlim=(-35, 115), ylim=(-165, 20), zlim=(-65, 85))
    ax.set_box_aspect((150, 185, 150))
    ax.view_init(elev=24, azim=-63)
    ax.set_xlabel("+X → phone")
    ax.set_ylabel("+local Y → charging edge")
    ax.set_zlabel("+local Z → cameras / stock shaft")
    ax.set_title("Carrier and square-neck clamp", fontsize=13, pad=16)
    ax.grid(False)
    detail = box(-16, 36, -98, -30, -8, 20)
    bx = fig.add_subplot(122, projection="3d", proj_type="ortho")
    plot_shape(bx, parts["carrier_frame"].intersect(detail), ORANGE)
    plot_shape(bx, parts["button_lever"], ORANGE)
    plot_shape(bx, phone.intersect(detail), (.18, .23, .29), .18)
    bx.set(xlim=(-16, 36), ylim=(-98, -30), zlim=(-8, 20))
    bx.set_box_aspect((52, 68, 28))
    bx.view_init(elev=70, azim=-85)
    bx.set_title("Ferrule stop → nipple → pinned lever → rocker", fontsize=13, pad=16)
    bx.set_xlabel("+X → button")
    bx.set_ylabel("phone edge")
    bx.set_zlabel("camera face")
    bx.grid(False)
    fig.text(.09, .035, "Orange: printed CAD  ·  silver/dark: stock-neck and phone envelopes  ·  local Z aligns with shaft and points toward cameras.\n"
             "Unmeasured fit and trigger motion remain provisional; see cad/README.md.",
             fontsize=10, color="#34414b")
    fig.savefig(OUT / "assembly-cad.png", dpi=190, bbox_inches="tight")
    plt.close(fig)


def main():
    OUT.mkdir(exist_ok=True)
    parts = all_parts(P)
    for name, part in parts.items():
        if part.val().Volume() <= 0 or not part.val().isValid() or len(part.val().Solids()) != 1:
            raise RuntimeError(f"Part must be one valid connected solid: {name}")
        cq.exporters.export(part, str(OUT / f"{name}.stl"),
                            exportType="STL", tolerance=0.06, angularTolerance=0.2)
        cq.exporters.export(part, str(OUT / f"{name}.step"), exportType="STEP")
    assembly, neck, phone = make_assembly(parts)
    # These CAD envelope checks catch gross parameter or placement mistakes.
    checked = [
        ("carrier vs phone", parts["carrier_frame"], phone),
        ("right rail vs phone", parts["movable_rail"], phone),
        ("lever vs phone", parts["button_lever"], phone),
        ("lever vs frame", parts["button_lever"], parts["carrier_frame"]),
        ("lever vs neck saddle", parts["button_lever"],
         parts["neck_saddle"].translate((0, P.neck_center_y, 0))),
        ("lever vs neck cap", parts["button_lever"],
         parts["neck_cap"].translate((0, P.neck_center_y, 0))),
    ]
    for label, a, b in checked:
        if a.intersect(b).val().Volume() > 0.01:
            raise RuntimeError(f"Envelope collision: {label}")
    assembly.export(str(OUT / "assembly.step"))
    drawing(parts, neck, phone)
    for name in parts:
        mesh = trimesh.load_mesh(OUT / f"{name}.stl")
        print(f"{name:22} volume={mesh.volume:8.1f} mm³ "
              f"watertight={mesh.is_watertight} bounds={mesh.extents.round(1)}")
        if not mesh.is_watertight or mesh.volume <= 0:
            raise RuntimeError(f"Invalid STL: {name}")


if __name__ == "__main__":
    main()

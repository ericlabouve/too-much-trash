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
from stock_proxy import stock_shapes


ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "print"
P = Parameters()
ORANGE = (0.96, 0.35, 0.07)


def normalize_step(path):
    """Remove OCCT's line-end spaces so generated STEP diffs stay reviewable."""
    path = Path(path)
    path.write_text("\n".join(line.rstrip() for line in path.read_text().splitlines()) + "\n")


def location(x=0, y=0, z=0):
    return cq.Location(cq.Vector(x, y, z))


def part_location(name):
    if name.startswith("neck_"):
        return location(y=P.neck_center_y)
    if name.startswith("handle_"):
        return location(y=P.neck_center_y, z=P.handle_station_z)
    if name == "trigger_tab":
        return location(x=P.trigger_tab_x, y=P.neck_center_y, z=P.trigger_tab_z)
    return location()


def placed_part(name, part):
    if name.startswith("neck_"):
        return part.translate((0, P.neck_center_y, 0))
    if name.startswith("handle_"):
        return part.translate((0, P.neck_center_y, P.handle_station_z))
    if name == "trigger_tab":
        return part.translate((P.trigger_tab_x, P.neck_center_y, P.trigger_tab_z))
    return part


def make_assembly(parts):
    assembly = cq.Assembly(name="reacher_retrofit_prototype")
    # All eight printable pieces remain individually editable in the STEP tree.
    for name, shape in parts.items():
        assembly.add(shape, name=name, loc=part_location(name), color=cq.Color(*ORANGE))
    proxies = stock_shapes(P)
    for name, shape in proxies.items():
        if "blue" in name:
            color = cq.Color(.04, .30, .88)
        elif "black" in name or "feet" in name or "camera" in name:
            color = cq.Color(.08, .09, .11)
        elif "phone" in name:
            color = cq.Color(.64, .68, .71)
        else:
            color = cq.Color(.67, .71, .75)
        assembly.add(shape, name=name, color=color)
    return assembly, proxies


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


def full_drawing(parts, proxies):
    """One coherent full-tool view plus details, all driven by CAD solids."""
    fig = plt.figure(figsize=(12, 15), facecolor="white")
    colors = {
        "stock_square_neck_envelope": (.70, .74, .78),
        "stock_claw_arms_proxy": (.70, .74, .78),
        "stock_claw_feet_proxy": (.09, .10, .12),
        "stock_blue_center_brace_proxy": (.04, .30, .88),
        "stock_blue_handle_proxy": (.04, .30, .88),
        "stock_black_trigger_proxy": (.09, .10, .12),
        "phone_envelope_only": (.63, .68, .72),
        "phone_camera_markers_proxy": (.08, .09, .11),
    }

    def panel(ax, names, proxy_names, limits, aspect, elev, azim):
        for name in proxy_names:
            plot_shape(ax, proxies[name], colors[name], stride=2 if "claw" in name else 1)
        for name in names:
            plot_shape(ax, placed_part(name, parts[name]), ORANGE)
        ax.set(xlim=limits[0], ylim=limits[1], zlim=limits[2])
        ax.set_box_aspect(aspect)
        ax.view_init(elev=elev, azim=azim)
        ax.set_axis_off()

    all_names = list(parts)
    all_proxies = list(proxies)
    ax = fig.add_axes([.03, .08, .57, .84], projection="3d", proj_type="ortho")
    panel(ax, all_names, all_proxies,
          ((-115, 120), (-165, 35), (-585, 205)),
          (235, 200, 790), 9, -79)
    cable = [(-13, -44, 7), (-24, -34, -20), (-24, -10, -100),
             (-24, -10, -290), (-58, -10, -344), (-77, -10, P.handle_station_z)]
    ax.plot(*zip(*cable), color="#17222a", linewidth=2.2)
    ax.plot([-65, P.trigger_tab_x], [P.neck_center_y]*2,
            [P.handle_station_z, P.trigger_tab_z], color="#71808c", linewidth=1.5)

    phone_ax = fig.add_axes([.58, .51, .39, .35], projection="3d", proj_type="ortho")
    panel(phone_ax,
          ["carrier_frame", "movable_rail", "neck_saddle", "neck_cap", "button_lever"],
          ["stock_square_neck_envelope", "phone_envelope_only", "phone_camera_markers_proxy"],
          ((-35, 116), (-162, 20), (-47, 82)), (151, 182, 129), 26, -64)
    phone_ax.set_title("Phone / claw-end mount", fontsize=13)

    handle_ax = fig.add_axes([.58, .13, .39, .34], projection="3d", proj_type="ortho")
    panel(handle_ax,
          ["handle_anchor_saddle", "handle_anchor_cap", "trigger_tab"],
          ["stock_square_neck_envelope", "stock_blue_handle_proxy", "stock_black_trigger_proxy"],
          ((-115, 55), (-60, 38), (-578, -333)), (170, 98, 245), 12, -76)
    handle_ax.plot([-65, P.trigger_tab_x], [P.neck_center_y]*2,
                   [P.handle_station_z, P.trigger_tab_z], color="#71808c", linewidth=1.5)
    handle_ax.set_title("Fixed stop / moving trigger tab", fontsize=13)

    fig.text(.05, .95, "Too Much Trash — R1 full retrofit assembly", fontsize=19,
             weight="bold", color="#263340")
    fig.text(.05, .925, "All eight orange printable parts are placed in one CAD coordinate system.",
             fontsize=11, color="#465563")
    fig.text(.05, .035,
             "Blue/black/silver stock shapes and phone are unmeasured visual proxies from the front photo.\n"
             "Cable lines are route diagrams. Fit, claw clearance, and trigger travel require physical measurement.",
             fontsize=9.5, color="#465563")
    fig.savefig(OUT / "full-assembly-cad.png", dpi=190, bbox_inches="tight")
    plt.close(fig)


def main():
    OUT.mkdir(exist_ok=True)
    parts = all_parts(P)
    for name, part in parts.items():
        if part.val().Volume() <= 0 or not part.val().isValid() or len(part.val().Solids()) != 1:
            raise RuntimeError(f"Part must be one valid connected solid: {name}")
        cq.exporters.export(part, str(OUT / f"{name}.stl"),
                            exportType="STL", tolerance=0.06, angularTolerance=0.2)
        step_path = OUT / f"{name}.step"
        cq.exporters.export(part, str(step_path), exportType="STEP")
        normalize_step(step_path)
    assembly, proxies = make_assembly(parts)
    neck = proxies["stock_square_neck_envelope"]
    phone = proxies["phone_envelope_only"]
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
    normalize_step(OUT / "assembly.step")
    drawing(parts, neck, phone)
    full_drawing(parts, proxies)
    for name in parts:
        mesh = trimesh.load_mesh(OUT / f"{name}.stl")
        print(f"{name:22} volume={mesh.volume:8.1f} mm³ "
              f"watertight={mesh.is_watertight} bounds={mesh.extents.round(1)}")
        if not mesh.is_watertight or mesh.volume <= 0:
            raise RuntimeError(f"Invalid STL: {name}")


if __name__ == "__main__":
    main()

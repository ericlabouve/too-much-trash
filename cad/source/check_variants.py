"""Verify one STL set serves different phone dimensions and button positions.

Run from cad/: uv run --frozen python source/check_variants.py
"""

from dataclasses import replace
from hashlib import sha256
from pathlib import Path
from tempfile import TemporaryDirectory

import cadquery as cq

import build
from parameters import Parameters
from parts import all_parts
from stock_proxy import stock_shapes


BASE = Parameters()
VARIANTS = (
    BASE,
    replace(BASE, phone_width=66, phone_length=135, phone_thickness=7,
            button_y=-110),
    replace(BASE, phone_width=82, phone_length=165, phone_thickness=12,
            button_y=-55),
    replace(BASE, phone_width=82, phone_length=135, phone_thickness=7,
            button_y=-55),
    replace(BASE, phone_width=66, phone_length=165, phone_thickness=12,
            button_y=-110),
)


def digest(shape, path: Path):
    cq.exporters.export(shape, str(path), exportType="STL",
                        tolerance=0.06, angularTolerance=0.2)
    return sha256(path.read_bytes()).hexdigest()


def check_layout(p, parts):
    build.P = p
    phone = stock_shapes(p)["phone_envelope_only"]
    names = ("carrier_frame", "movable_rail", "camera_end_left",
             "camera_end_right", "actuator_carriage", "button_lever")
    for name in names:
        overlap = build.placed_part(name, parts[name]).intersect(phone).val().Volume()
        if overlap > 0.01:
            raise AssertionError(f"{name} penetrates phone for {p}")
    for name in ("actuator_carriage", "button_lever"):
        overlap = build.placed_part(name, parts[name]).intersect(parts["carrier_frame"]).val().Volume()
        if overlap > 0.01:
            raise AssertionError(f"{name} penetrates frame for {p}")
    overlap = (build.placed_part("button_lever", parts["button_lever"])
               .intersect(build.placed_part("actuator_carriage", parts["actuator_carriage"]))
               .val().Volume())
    if overlap > 0.01:
        raise AssertionError(f"Lever penetrates its carriage for {p}")
    for moving in ("actuator_carriage", "button_lever"):
        for shoe in ("camera_end_left", "camera_end_right"):
            overlap = (build.placed_part(moving, parts[moving])
                       .intersect(build.placed_part(shoe, parts[shoe])).val().Volume())
            if overlap > 0.01:
                raise AssertionError(f"{moving} penetrates {shoe} for {p}")


def main():
    reference = None
    with TemporaryDirectory() as scratch:
        for index, p in enumerate(VARIANTS):
            p.validate()
            parts = all_parts(p)
            check_layout(p, parts)
            hashes = {name: digest(shape, Path(scratch) / f"{index}-{name}.stl")
                      for name, shape in parts.items()}
            if reference is not None and hashes != reference:
                changed = [name for name in hashes if hashes[name] != reference[name]]
                raise AssertionError(f"Phone setting changed printable geometry: {changed}")
            reference = hashes
            print(f"Variant {index}: {p.phone_width}×{p.phone_length}×{p.phone_thickness} mm, "
                  f"button Y={p.button_y}: fit clear, same STL hashes")


if __name__ == "__main__":
    main()

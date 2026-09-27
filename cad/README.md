# Reacher retrofit CAD — prototype R1

This is an editable, dimensioned **prototype** for the blue-handled grabber in [the stock photo](reference/reacher-grabber.png). The [earlier renders](renders/README.md) remain concept references. R1 uses a narrow open phone frame, a separate adjustable rail, a split square-neck clamp, and a pinned bell crank. Those structures intentionally replace the illustrated corner harness and unconstrained button linkage. The [CAD assembly drawing](print/assembly-cad.png) and [STEP assembly](print/assembly.step) are derived from one common model. Silver neck and dark phone in the assembly are **envelopes**, not reverse-engineered factory solids. The concept sheets' front and side phone positions differ; this CAD uses one consistent offset to positive X and negative project Z.

## What to measure before final printing

Edit [`source/parameters.py`](source/parameters.py). All current values in this table are **provisional**, in millimetres. Phone is modeled *without a case*.

| Parameter | R1 value | Measure on the actual hardware |
| --- | ---: | --- |
| `phone_width`, `phone_length`, `phone_thickness` | 72 × 147 × 9 | Full envelope including buttons, camera bump, and chosen protective liner/case. The frame only accommodates width by about ±3; length/thickness require regeneration. |
| `phone_fit_clearance`, `phone_end_clearance` | 0.7, 0.8 | Side fit allowance and clearance at **each** short end before pads. Tune from a gauge print. |
| `button_y`, `button_z`, `button_travel` | −81, 5, 0.45 | Volume-up center relative to charging edge and supported underside; force and safe stroke through a compliant tip. |
| `neck_width`, `neck_clearance` | 16, 0.5 | Maximum width across all four flats/ribs at the chosen mounting site, plus shim thickness. Do not infer this from photo pixels. |
| `neck_center_y`, `claw_clearance` | −10, 25 | Lateral/depth offset of the neck clamp and minimum verified claw gap. Choose the *axial* mounting station below the fork on the physical tool; the sketch cannot establish that station. |
| `handle_station_z`, `handle_anchor_reach`, `trigger_tab_x` | −310, 72, −42 | Handle clamp station relative to phone mount, fixed-stop reach, and moving tab location. Check actual trigger motion before selecting reach. |
| `cable_housing_od`, `cable_wire_od` | 5, 1.6 | Actual ferrule, housing, and stainless inner wire. |
| Trigger paddle and motion | model only | Paddle section, available attachment area, direction and travel of a point on it relative to the stationary shaft. Verify it moves **away** from the outboard housing stop on squeeze. |

Model coordinates: +X goes from square shaft to phone, +local Y goes toward the charging edge, +local Z points from screen to rear cameras and along the shaft. For the repository's illustration convention, local X = project X, local Z = project Y, and local Y = project Z. The phone rear cameras face toward the claw end (+project Y). The charging edge points toward +project Z. Added parts are orange; stock metal is silver, and the stock handle/brace are blue in reference art only.

## Mechanism and assembly

The phone sits on edge pads, between fixed left lips and a movable right rail. Remove the right rail, place soft non-adhesive silicone/TPU pads at the four support zones and clip contact points, set the bare phone beneath the left lips, then bolt on and adjust the right rail. The outer back camera area stays open. The short-edge stops touch only corners so the charging port and adjacent microphones stay accessible. Check the exact phone's camera, mic and button locations before loading it. The phone must not rattle, and the lips must not load the camera bump or glass. A wrist tether on the phone is recommended for field trials.

Join the two neck halves around the silver square shaft with four M4 through-bolts and broad washers. Use thin removable TPU or rubber shim strips on the four flats; tighten only until the mount cannot rotate or slip by hand. Two countersunk M4 bolts through the outboard frame lugs attach the carrier to the clamp wing. No stock hole or permanent modification is used. Position the carrier below the claw fork, outside its complete moving envelope, and clear of the blue center brace.

At the phone, the **outer** brake housing seats in the printed stepped 5.35 mm ferrule stop. Only the inner wire passes to the barrel-nipple pocket on the lever's long arm. A metal M3 pivot pin/screw and washers constrain lever rotation; a small M3-pivot torsion spring returns it, with its legs in the 1.4 mm frame/lever holes. A retained washer over the cable nipple pocket prevents the nipple escaping upward. Leftward wire pull rotates the short arm toward the volume button. An M3 contact screw with a soft silicone/TPU cap and jam nut adjusts the initial button gap; an M3 screw in the fixed stop ear limits lever sweep. Set roughly 0.5 mm **rest gap** and no more than the measured safe button stroke at the hard stop, using a dummy gauge before fitting the phone. Confirm full release on every cycle. No load should reach the phone from cable housing flex.

At the handle, the second square-neck clamp holds a braced outrigger and stationary housing stop. Two cable ties and a thin pad secure `trigger_tab` to the moving black paddle; an M3 screw and washer clamp the inner wire. The stop is deliberately outboard so a trigger point moving inward can increase exposed wire length. The true trigger trajectory is unknown: if squeeze reduces this distance, relocate or reverse the housing/tab geometry **before** connecting the phone. Keep the wire clear of the grip and fingers and use wide housing curves, about 50 mm minimum radius. A bicycle barrel adjuster inline near the handle may remove slack. The stock trigger must still fully open and close the claws.

## Bill of materials

| Printed, one each | Suggested filament / orientation in Bambu Studio |
| --- | --- |
| `carrier_frame.stl` | PETG or ASA, underside on bed; 4 walls, 35% gyroid, 0.2 mm layer. The 2 mm lips bridge without support. |
| `movable_rail.stl` | PETG or ASA, long flat underside on bed; 4 walls. |
| `neck_saddle.stl`, `neck_cap.stl` | PETG or ASA, split mating face on bed; 5 walls, 40% infill. Keep bolt ears in plane; inspect first layer. |
| `button_lever.stl` | PETG, flat lower face on bed; 5 walls, 100% infill around pivot/nipple. No brittle PLA at the pivot. |
| `handle_anchor_saddle.stl`, `handle_anchor_cap.stl` | PETG or ASA, long flat Z-end face on bed; 5 walls, 40% infill. The cap's outrigger lies on the bed in this orientation. |
| `trigger_tab.stl` | PETG, broad bottom on bed; 4 walls. |

| Purchased, approximate quantity | Purpose |
| --- | --- |
| Bicycle brake housing + ferrules, about 1–1.5 m; 1.6 mm stainless inner with barrel nipple; optional inline adjuster | Bowden transmission. Cut to the measured route. |
| M4 screws/nuts/washers: 8 sets, two countersunk for frame lugs | Four phone-collar bolts, two handle-collar bolts, plus two frame-to-wing bolts. Select length after print fit. |
| M3 screws/nuts/washers: about 8 sets; one M2 screw/washer/nut | Four movable rail slots, lever pivot/contact/stop, trigger wire pinch; use a metal pivot. The M2 wide washer retains the cable nipple. |
| Small M3 torsion spring, leg span to fit 8 mm radius | Positive lever return; choose torque after button-force measurement. |
| Two small cable ties; thin TPU/rubber strip; soft contact cap/pads | Reversible trigger attachment and phone/neck protection. Pads may be cut from sheet rather than printed. |

## Regenerate

The project-local [uv lockfile](uv.lock) pins Python dependencies and the exact [CadQuery upstream Git revision](https://github.com/CadQuery/cadquery/tree/v2.6.1). From this directory:

```sh
uv sync --frozen
uv run --frozen python source/build.py
```

`source/parts.py` defines every printable solid. `source/build.py` exports all eight STL and STEP parts, `print/assembly.step`, and `print/assembly-cad.png`. This was generated on Python 3.12 / CadQuery 2.6.1. Open an STL in Bambu Studio; orient as above and inspect bridges, holes, and support preview. Do a low-cost fit print of the collars, a rail corner, and actuator first. The [design review](design-review.md) records unresolved risks and validation steps.

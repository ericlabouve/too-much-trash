# Reacher retrofit CAD — adjustable prototype R2

> **Redesign inputs:** The confirmed [measurement and decision record](reference/measurements.md) supersedes R2 assumptions, including the square neck and phone thickness range. The source and exports below are still the prior R2 prototype pending redesign.

This is an editable, dimensioned **prototype** for the blue-handled grabber in [the stock photo](reference/reacher-grabber.png). The [earlier renders](renders/README.md) remain concept references. R2 uses one open carrier for multiple phone envelopes: a sliding side rail sets width, two corner shoes set length, and a sliding cable-stop/lever carriage aligns with the volume button. Replaceable soft pads set thickness. The split square-neck clamps remain removable. The [full product rendering](print/full-assembly-cad.png), [phone-end drawing](print/assembly-cad.png), and [STEP assembly](print/assembly.step) are derived from one common model. Every orange part is printable CAD geometry. The silver/blue/black stock tool and gray phone are **unmeasured visual envelopes** inferred from the single front photo, not reverse-engineered factory solids. The concept sheets' front and side phone positions differ; this CAD uses one consistent offset to positive X and negative project Z.

## What to measure before final printing

The same eleven printed pieces adjust over the **provisional** range of **66–82 mm width, 135–165 mm length, and 7–12 mm body thickness**. The volume-button center may be **55–110 mm from the charging edge**. These are design envelopes, not a claim that every iPhone or case fits: check camera bumps, port/mic placement, button force and side geometry. The example assembled phone is 72 × 147 × 9 mm. A protective case can be included in the measured envelope if its volume button remains mechanically accessible.

Edit [`source/parameters.py`](source/parameters.py) to visualize a target phone in STEP and PNG; changing only `phone_width`, `phone_length`, `phone_thickness`, and `button_y` **does not change any printable STL** within this range. All values below are millimetres and provisional.

| Parameter | R2 provisional value | Measure on the actual hardware |
| --- | ---: | --- |
| `phone_width`, `phone_length`, `phone_thickness` | 72 × 147 × 9 | Target phone/case body envelope; measure actual long/short sides and thickness. Camera bump is a separate keep-out check. |
| `phone_width_min/max`, `phone_length_min/max`, `phone_thickness_min/max` | 66–82, 135–165, 7–12 | Limits built into the slots, lips and support rails. Revising these limits requires new prints. |
| `phone_fit_clearance`, `phone_end_clearance` | 0.7, 0.8 | Side fit allowance and clearance at **each** short end before pads. Tune from a gauge print. |
| `button_y`, `button_y_min/max`, `button_z`, `button_travel` | −81, −110 to −55, 5, 0.45 | Button center relative to charging edge and phone underside; measure force and safe stroke. The carriage slides along Y; contact screw slides vertically in the lever tip. |
| `neck_width`, `neck_clearance` | 16, 0.5 | Maximum width across all four flats/ribs at the chosen mounting site, plus shim thickness. Do not infer this from photo pixels. |
| `neck_center_y`, `claw_clearance` | −10, 25 | Lateral/depth offset of the neck clamp and minimum verified claw gap. Choose the *axial* mounting station below the fork on the physical tool; the sketch cannot establish that station. |
| `handle_station_z`, `trigger_tab_z`, `handle_anchor_reach`, `trigger_tab_x` | −380, −435, 72, −42 | Handle clamp and tab stations relative to phone mount, fixed-stop reach, and moving tab location. Check actual trigger motion before selecting reach. |
| `cable_housing_od`, `cable_wire_od` | 5, 1.6 | Actual ferrule, housing, and stainless inner wire. |
| Trigger paddle and motion | model only | Paddle section, available attachment area, direction and travel of a point on it relative to the stationary shaft. Verify it moves **away** from the outboard housing stop on squeeze. |

Model coordinates: +X goes from square shaft to phone, +local Y goes toward the charging edge, +local Z points from screen to rear cameras and along the shaft. For the repository's illustration convention, local X = project X, local Z = project Y, and local Y = project Z. The phone rear cameras face toward the claw end (+project Y). The charging edge points toward +project Z. Added parts are orange; stock metal is silver, and the stock handle/brace are blue in reference art only.

## Mechanism and assembly

Remove the right rail and both camera-end shoes. Put soft TPU/rubber pads along the screen-side support strips at **0.5 mm + (12 mm − measured phone thickness)**; use equal pads on left and right so the phone back face reaches the fixed-height retaining lips. Add thin compliant pads beneath the lips. Seat the phone against the fixed charging-end corner stops, install the right rail at the measured width with about 0.7 mm total side allowance, and lock its three M3 bolts. Slide the two camera-end shoes against the far short edge with about 0.8 mm end clearance, then lock two M3 bolts in each shoe. The shoes and lips touch edges/corners only; camera lenses, microphones, and charging-port center remain open **only after verifying their actual positions**. Shake/inversion-test retention with a tether before field use.

Join the two neck halves around the silver square shaft with four M4 through-bolts and broad washers. Use thin removable TPU or rubber shim strips on the four flats; tighten only until the mount cannot rotate or slip by hand. Two countersunk M4 bolts through the outboard frame lugs attach the carrier to the clamp wing. No stock hole or permanent modification is used. Position the carrier below the claw fork, outside its complete moving envelope, and clear of the blue center brace.

Slide `actuator_carriage` along the outboard frame slot until the lever contact aligns with the measured volume button; lock its two M3 mounting bolts. The **outer** brake housing seats in the carriage's stepped 5.35 mm ferrule stop. Only the inner wire passes to the barrel-nipple pocket on the lever's long arm. A metal M3 pivot and washers constrain rotation; a torsion spring returns it, with legs in the carriage/lever holes. An M2 screw and wide washer retain the nipple vertically. Leftward wire pull rotates the short arm toward the volume button. Set the M3 contact screw's **vertical position** in the lever's 7.2–16.2 mm slot, then its horizontal rest gap with a compliant tip and locknuts. An M3 screw in the carriage stop ear limits sweep. Set roughly 0.5 mm rest gap and no more than the measured safe button stroke at the hard stop, using a dummy gauge before fitting the phone. Confirm full release on every cycle. The housing reaction point, pivot and stop move together when the carriage is adjusted.

At the handle, the second square-neck clamp holds a braced outrigger and stationary housing stop. Two cable ties and a thin pad secure `trigger_tab` to the moving black paddle; an M3 screw and washer clamp the inner wire. The stop is deliberately outboard so a trigger point moving inward can increase exposed wire length. The true trigger trajectory is unknown: if squeeze reduces this distance, relocate or reverse the housing/tab geometry **before** connecting the phone. Keep the wire clear of the grip and fingers and use wide housing curves, about 50 mm minimum radius. A bicycle barrel adjuster inline near the handle may remove slack. The stock trigger must still fully open and close the claws.

## Bill of materials

| Printed, one each | Suggested filament / orientation in Bambu Studio |
| --- | --- |
| `carrier_frame.stl` | PETG or ASA, flat underside on bed; 4 walls, 35% gyroid, 0.2 mm layer. Three width bridges and external actuator slot are integral. |
| `movable_rail.stl` | PETG or ASA, long flat underside on bed; 4 walls. |
| `camera_end_left.stl`, `camera_end_right.stl` | PETG or ASA, broad base on bed; 4 walls. Retaining lips bridge about 2 mm. |
| `actuator_carriage.stl` | PETG or ASA, flat underside on bed; 5 walls, 40% infill. Inspect ferrule-stop bore. |
| `neck_saddle.stl`, `neck_cap.stl` | PETG or ASA, split mating face on bed; 5 walls, 40% infill. Keep bolt ears in plane; inspect first layer. |
| `button_lever.stl` | PETG, flat lower face on bed; 5 walls, 100% infill around pivot/nipple and vertical contact slot. No brittle PLA at the pivot. |
| `handle_anchor_saddle.stl`, `handle_anchor_cap.stl` | PETG or ASA, long flat Z-end face on bed; 5 walls, 40% infill. The cap's outrigger lies on the bed in this orientation. |
| `trigger_tab.stl` | PETG, broad bottom on bed; 4 walls. |

| Purchased, approximate quantity | Purpose |
| --- | --- |
| Bicycle brake housing + ferrules, about 1–1.5 m; 1.6 mm stainless inner with barrel nipple; optional inline adjuster | Bowden transmission. Cut to the measured route. |
| M4 screws/nuts/washers: 8 sets, two countersunk for frame lugs | Four phone-collar bolts, two handle-collar bolts, plus two frame-to-wing bolts. Select length after print fit. |
| M3 screws/nuts/washers: about 13 sets; one M2 screw/washer/nut | Three rail bolts, four camera-shoe bolts, two carriage bolts, lever pivot/contact/stop, trigger wire pinch; use a metal pivot. The M2 wide washer retains the cable nipple. |
| Small M3 torsion spring, leg span to fit 8 mm radius | Positive lever return; choose torque after button-force measurement. |
| Two small cable ties; TPU/rubber pad sheet about 0.5–5.5 mm; soft contact cap | Reversible trigger attachment and replaceable thickness/neck shims. Equal phone support pads distribute load. |

## Regenerate

The project-local [uv lockfile](uv.lock) pins Python dependencies and the exact [CadQuery upstream Git revision](https://github.com/CadQuery/cadquery/tree/v2.6.1). From this directory:

```sh
uv sync --frozen
uv run --frozen python source/build.py
uv run --frozen python source/check_variants.py
```

`source/parts.py` defines every printable solid; `source/stock_proxy.py` defines the non-printable grabber and phone visual envelopes. `source/build.py` exports all eleven STL and STEP parts, `print/assembly.step`, `print/assembly-cad.png`, and `print/full-assembly-cad.png`. `source/check_variants.py` verifies that five target-phone settings give identical STL hashes and no modeled phone intrusion. This was generated on Python 3.12 / CadQuery 2.6.1. Open an STL in Bambu Studio; orient as above and inspect bridges, holes, and support preview. Do a low-cost fit print of the collars, corner shoes, and actuator first. The [design review](design-review.md) records unresolved risks and validation steps.

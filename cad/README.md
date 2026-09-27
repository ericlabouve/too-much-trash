# R3 — adjustable reacher phone retrofit

Editable **fit prototype**, based on the [confirmed measurements](reference/measurements.md). Six unique printed designs make seven pieces, down from eleven in R2. One carrier integrates the fixed jaw, rectangular shaft saddle, charging-end stop, and actuator rail. One sliding jaw accommodates different phone widths and thicknesses; a separate compact rocker module adjusts to the volume-up button. The source and exports are real CadQuery solids. Physical reliability remains to be established.

![R3 CAD assembly](print/assembly-cad.png)

## Fit and operation

The same print set covers a provisional **66–86 mm outside width, 7.5–20 mm thickness**, and volume-button location **80–125 mm from the charging edge**. Both the bare 15 Pro sample (70.6 × 146.6 × 8.25 mm) and wallet-case sample (76 × 152 × 18 mm) are modeled. This is an envelope, **not a verified iPhone 14–18 compatibility list**. Camera bumps, rounded sides, cases and button force must be checked individually.

Opposing 45° V jaws use four replaceable 0.8 mm compliant strips. Tightening a metal M4 draw screw pulls the sliding jaw inward; upper/lower faces capture the side edges without a full back plate. The phone centers through its thickness, so no thick filler pads are needed for the wallet case. A small charging-end corner stop blocks sliding in one direction; clamping friction resists sliding toward the camera end. Use a separate phone safety tether and validate axial retention. Place pads on case/bezel edges, never on exposed display glass. The jaw band occupies 28–52 mm from the charging end; confirm it misses every control on the actual phone.

The phone rear faces the claws, with its charging edge facing project +Z and its body extending into −Z. Local CAD axes map **(X, Y, Z) → project (X, Z, −Y)**. The measured shaft is **14 mm project X × 19 mm project Z**. Mount within the measured 200 mm straight region above the blue brace, with clearance from the complete claw sweep.

## Button mechanism

![Released and pressed CAD mechanism](print/actuator-cad.png)

The outer housing seats in a stepped ferrule bore on the adjustable bracket. The inner wire passes through the rocker input arm and terminates in a purchased screw-on cable barrel above it. Cable pull rotates the rocker on a metal pivot. A padded M3 contact screw presses volume up; two opposed nuts lock the contact setting. A torsion spring returns the rocker to its released ledge. An adjustable M3 stop limits rotation and transfers excess load into the bracket.

A **purchased extension spring in series between the handle-end cable loop and trigger strap** absorbs the rest of the squeeze stroke after the rocker reaches its stop. It is necessary: a brake cable directly linking 20–40 mm trigger travel to a sub-millimetre phone button would otherwise bind or overload something. The button remains pressed until the trigger is released.

The [generated calculation](print/validation.json) uses provisional 0.35 mm rest gap and 0.30 mm button stroke: about **3.2° rotation and 1.0 mm cable travel**. An illustrative 100 mm axial / 65 mm transverse cable span produces about 17–35 mm take-up for 20–40 mm trigger movement. The proposed series spring extends approximately 34 mm at full stroke. These anchor coordinates and button travel are **not measured specifications**. See [design review](design-review.md) for force assumptions and calibration.

## Assembly

1. Deburr prints, check slider movement and ream metal-pivot/fastener holes as needed. Apply thin removable shaft shims and jaw pads. Install the M4 square nut in the jaw's top-loading pocket; insert the jaw from the open right end of the guide.
2. Insert the M4×80 draw screw from the fixed-jaw side into the jaw nut. Use a purchased thumb head no larger than 16 mm diameter / 5 mm thick; the carrier has a finger recess. Backing off permits manually spreading the jaws. Install the phone against the small charging-end stop and tighten only enough to resist slipping.
3. Bolt the integrated saddle and one `neck_cap` around the rectangular neck. Fit the second cap to `handle_anchor` above the handle. Each collar uses two M4 through-bolts and washers. Do not crush the fluted tube; physical shim fit controls friction.
4. Attach the bracket to the long carrier slot using two M3 bolts and washers. Slide it along the phone and adjust its height through the paired vertical slots, then lock both bolts. Wallet-case button center is 6 mm from the screen side; the V jaws center the 18 mm case. Leave the camera keep-out area unobstructed.
5. Install the pivot, torsion spring and rocker with axial washers. Set spring legs in their provided holes, with preload toward the released stop; ensure no coil/leg rubbing. Install the contact screw with a soft tip and opposed locknuts, and the stop screw with its square nut plus locking nut.
6. Seat housing/ferrules at both reaction stops. Route along the shaft with smooth bends (provisional minimum 50 mm radius; follow housing supplier limits), away from claws and fingers. Secure with removable ties. The CAD route is a diagram with straight segments, not a cut/bend template.
7. Secure the handle inner wire to the series spring with a rated clamp/loop termination. Connect the spring's closed eye to a hook-and-loop strap on the **moving trigger**. Keep all metal ends covered and clear of the hand. Do not attach it to the stationary grip. Verify strap security through the full squeeze.
8. Calibrate first on a dummy block: eliminate unintended preload, set a small release gap, then limit the rocker stroke with its stop. Adjust cable slack so it releases reliably after every squeeze. Confirm full claw closure still occurs as the series spring extends. Only then approach the actual phone button with a conservative stop setting. Do not assume 0.30 mm is safe for a particular phone/case.

## Print and materials

STLs in `print/` are **already oriented and translated onto the bed**, in mm. Import the six files into Bambu Studio as separate objects and make two copies of `neck_cap`. The largest bounding box fits a 180 mm consumer bed. STEP parts retain assembly coordinates.

| Part | Qty | Material / orientation / support |
| --- | ---: | --- |
| `carrier` | 1 | PETG; broad bridge/rail underside down. Four walls, 25–35% infill. Local support below collar bolt ears; 2.3 mm guide lips and 45° jaw faces need inspection in preview. |
| `sliding_jaw` | 1 | PETG; tongue underside down. Four walls, 30% infill; six walls around nut and draw-screw web. V faces are 45°. |
| `neck_cap` | 2 | PETG; shaft axis vertical. Four/five walls; support beneath bolt ears. |
| `actuator_bracket` | 1 | PETG; exported on cable-stop outer face. Paint support beneath raised back plate/pivot ears, keep slots and ferrule bore clear. Five walls. |
| `rocker` | 1 | PETG or tough nylon; exported flat on its broad face, pivot axis vertical. Five walls / solid small part; no support. |
| `handle_anchor` | 1 | PETG; shaft axis vertical. Five walls; local ear support. |

Start with 0.4 mm nozzle, 0.2 mm layers. ASA is an alternative for outdoor heat/UV if the printer can control warping. TPU/rubber is for pads and the contact cap; metal carries pivot wear, cable tension and threads. Avoid brittle or heat-softened structural prints. Slide clearances are 0.3 mm per side / 0.4 mm vertically; collar adds 0.6 mm total per axis before shims. Fit depends on printer and material. Slice previews and actual print times/mass have **not** been validated in Bambu Studio. Manifest volumes are solid CAD volumes, not slicer material estimates.

## Files and regeneration

- `source/parameters.py`: measured samples and clearly marked provisional settings.
- `source/parts.py`: individual editable printable solids; `assembly.py`: shared placement and mechanism math.
- `source/build.py`, `render.py`: exports and actual-CAD illustrations.
- `source/check_design.py`: static/swept collision and analytic travel checks.
- `print/`: current STL/STEP files, assembly meshes, drawings, manifest and validation report.
- [BOM](bom.md), [design review](design-review.md), [measurement record](reference/measurements.md).
- `archive/r2/`: superseded prior CAD and exports. `renders/`: original concept art, unchanged.

The project-local workflow uses Python 3.12, [CadQuery 2.6.1](https://github.com/CadQuery/cadquery/tree/v2.6.1), and exact dependencies in `uv.lock`. CadQuery's Git commit is pinned in the lockfile. With `uv` installed, from `cad/`:

```sh
uv sync --frozen
uv run --frozen python source/check_design.py
uv run --frozen python source/build.py
uv run --frozen python serve_viewer.py
# Open http://localhost:8765/viewer.html in Chrome
```

Only `cad/.venv` is used; no global Python packages are required. Export behavior follows [CadQuery's export documentation](https://cadquery.readthedocs.io/en/latest/importexport.html). Edit the sample settings to visualize another phone; the same printable geometry remains unchanged inside the stated envelope. Revising the mechanism/fit envelope itself requires reviewing the associated geometry and repeating validation.

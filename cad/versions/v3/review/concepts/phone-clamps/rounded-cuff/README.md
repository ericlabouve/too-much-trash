# Rounded C cuff with one shared T-key

**Integrated into V3:** the enlarged cuff and 12.2 mm shared key now come from the canonical `source/cuff_design.py` and `source/shared_key_design.py`. Active V3 uses three cuffs and four keys; earlier concept reports are historical fit-study evidence, not current assembly validation. New jaw sockets, TPU grip and key pull-out retention are not physically qualified.

Current concept: `enlarged-cuff-v1`. Open `index.html?detail=exploded&revision=enlarged-cuff-v1` through the CAD server.

Three pieces per contact: rigid jaw, one cyan/green cuff, and one rigid T-key candidate. For the first fit trial, all three are PETG. The intended later cuff material is user-selected ELEGOO TPU 95A White 1.75 mm; cyan/green are feature colors, not separate pieces. The custom pink TPU T and second transverse pin are removed. The same revised key is shown in the actuator-fit view; there is no cuff-only key geometry.

## Geometry

The C-shaped pocket, arms and green seating ribs are scaled 1.2×; width is 12 mm along the phone edge. Additional outward reinforcement makes the back flat at X−6.72 and leaves a verified 1.7 mm shoulder behind the recessed head (previous center wall 0.605 mm). The 12 × 8.88 mm flat bed face is interrupted only by the unchanged stem opening. Its outer transitions are tangent to the C arms. A 7.4 × 3.4 mm recess in the central back wall surrounds the 3.4 mm square stem passage. The flat key face is recessed to X−3.62, behind the enlarged inner curve, not filling the pocket.

The key retains the actuator's 7 mm head width, 3 × 3 mm stem, and shallow band seats. Head depth along insertion changes 3 → 1.2 mm and total length changes 14 → 12.2 mm. Print-plane thickness stays 3 mm. Its actuator bearing station stays at u18. This is a proposed shared revision, not an unchanged copy of the printed key.

## Evidence and limits

`build_shared_key.py` generates the single-solid key and unchanged axle reference, with `shared-key-check.json` recording actuator insertion, bracket clearance and axle-withdrawal obstruction. `render.cjs` checks the displayed cuff passage, enlarged C cavity, illustrative screen/camera keepouts, and both navigation cubes; outputs are in `review.json`.

**PETG clearance-fit test, not a pull-out lock.** User requested removing the two jaw friction ribs. The remaining 3.4 mm square passage around the 3 mm stem has 0.2 mm nominal clearance per side. No designed friction grip remains; the key can slide out. No hook, second key or hidden latch is added. Printed tolerances still need checking; do not force a jammed key. The recessed head keeps the cuff from moving past the key toward the phone, but the entire key can still withdraw toward the phone. Thinner-head strength, TPU tearing/creep and revised keeper-band behavior remain untested.

The phone is an illustrative 76 × 154 × 11 mm case with a 3 mm rim. Keepouts are not optical validation. Active 14 mm jaw pocket and 18/20 mm proxy conflicts remain unchanged. `build_fit_attachment.py` now creates valid single-solid cuff, local jaw socket and key, each exported as STL/STEP plus `fit-attachment.step`. These are a single-contact test article, not integrated production jaws. `fit-attachment-check.json` checks 41 insertion samples without solid overlap. The inner curves and seating ribs are scaled uniformly; only the outer back gains additional thickness. The local jaw socket moves 1.6 mm outward and the unchanged key moves 0.6 mm outward to accommodate this; neither is resized. The STEP solids preserve smooth C curves; STL export uses 0.0005 mm absolute deflection and removes only degenerate/duplicate triangles after 0.00001 mm vertex welding. Watertightness is checked. The new rib-free PETG slice is recorded separately at `print/jobs/2026-10-16-cuff-clearance-petg/`; historical ribbed slices remain unchanged. Production actuator, jaws, V1/V2 and historical print geometry are untouched. This enlarged revision is sliced separately at `print/jobs/2026-10-16-enlarged-cuff-petg/` (one cuff, 19.78 minutes / 1.073 g / zero supports). Its start record governs live status; physical result remains pending.

## Reproduce

Run `cad/.venv/bin/python cad/versions/v3/review/concepts/phone-clamps/rounded-cuff/build_fit_attachment.py`, serve `cad/`, then run `render.cjs` with the configured Playwright module and Chrome executable. Both independent cubes retain snapping, projection toggle, and drag-only rotation arrows.

## Material and first-fit limits

TPU 95A is the filament's nominal Shore grade, not a printer-calibrated softness setting. Walls, infill and geometry alter the compliance of a printed part. See [Prusa's flexible-filament guide](https://blog.prusa3d.com/how-to-print-with-flexible-filament_29672/).

PETG tests key insertion/removal and dimensional assembly only. It cannot establish the intended TPU grip, elastic seating or cushioning; use a dummy phone edge first, not a suspended phone. Begin by fitting key to socket without the cuff; stop if it jams or damages the head/socket. Inspect repeated-fit loosening before drawing any retention conclusion. When TPU arrives, repeat fit and pull/peel checks with the actual cuff; do not infer its behavior from the PETG surrogate.

The user reports the cuff-only retry succeeded, but its bed-facing wall was too thin and jaws too small. See the separate retry outcome record. The earlier failure cause remains unknown. The enlarged cuff has a fresh separate slice; historical job files still contain the smaller cuff. Keep active 14 mm pocket/18–20 mm phone conflicts visible.

# V3 — removable rounded cuffs and guided plunger

Viewer controls (October 25): select a BOM model or row, then use **Hide other items / Show all items** inside the viewport (also available fullscreen). Isolation follows a newly selected row and resets when changing views or using Show all. Cube arrow buttons rotate 90° per click; dragging remains continuous without an additional release step. Geometry and print exports are unchanged by this UI revision.

Viewer layout (October 25): the main 3D viewport spans the page width. Descriptions, warnings, actuator close-up and audit links are below it. Use **Full screen** at the lower right of the view; exit with the button or Escape. Embedded browsers that block native fullscreen use an expanded in-app view. CAD and print files are unchanged by this UI update.

## Current review revision — tpu-tv-axle-key-v3 (2026-10-25)

Current full-print review (2026-10-26): both material plates pass slicing/spacing and preview checks: PETG7 pieces,78.7478 g,549.27 min,0.3764 g supports; TPU15 pieces,18.9223 g,256.54 min,zero supports. A fresh focused audit confirms outgoing2 mm twine intersects the fixed jaw by33.82838 mm³ in wallet-near/bare-near/small-near (`review/current-twine-clearance.json`). Resolve before recommending a full functional print; plates can serve as fit-test prototypes. The broader earlier cassette audit is historical, not rerun to completion. 18/20 mm phones remain incompatible;35° ramps, jaw fit/strength and newTPU key/guide/long-fastener retention still need physical qualification. No printer contacted.

Sliding-jaw flush fins (2026-10-26): user removed the wraparound ends from both keeper tabs. Active `flush-width-fins-v3` retains the upper 35-degree fins only, cropped to Y±13.8 mm (the fixed jaw’s 27.6 mm width). Lower skirt geometry is gone; Z34.4 underside retains 0.4 mm clearance above the rail. Existing tongue/lips remain the retention mechanism. Physical sliding fit and print quality remain untested. Prior keeper slices are historical. New isolated PETG slice `2026-10-26-flush-fins` has unchanged0.0292 g support/interface,13.0126 g model; nominal sweep and fin-envelope checks pass (`review/flush-width-fins.json`).

Sliding-jaw external keepers (2026-10-26): `keeper-tabs-v3` adds two short tabs outside the fixed rails. Nominal clearance 0.4 mm above/outside the rails; existing tongue/lip capture retained. The initial trial added supports and was rejected; revised compound skirt ramps preserve matched 0.0292 g support/interface, add 0.3139 g model material. See `review/keeper-tabs.json` and `print/jobs/2026-10-26-keeper-tabs-v2/`. Protected rail-envelope and sampled insertion/withdrawal checks pass; physical sliding, stiffness and roof quality remain unverified. Revert using `keeper_tabs=False` and regenerated exports; previous slice jobs remain intact. Shaft-cap side windows stay removed. Final seven-piece PETG plate `2026-10-26-keeper-petg-spaced` passes deposited-path spacing after moving the plunger +6 mm in plate X; total 78.8424 g / 550.96 min and unchanged 0.3764 g support/interface. TPU plate unchanged.

Shaft-cap side windows reverted at user request (2026-10-26): active `side-windows-reverted-v3` restores the solid side walls. The taller cap, original central through-window and 2.6 mm wing-slot ends remain. BOM and manufacturing exports regenerated; material overview returns to `2026-10-26-final-petg`. Side-window studies remain historical records only.

BOM/plate alignment (2026-10-26): `plate-matched-bom-v3` promotes the accepted taller shaft cap and flat fixed jaw with lower hook ramp into canonical `model.py`, the BOM meshes, all assembly configurations and manufacturing exports. Boolean symmetric-difference checks against the exact STEP solids used for `2026-10-26-final-petg` are zero for both parts (`review/plate-bom-match.json`). This supersedes earlier statements that those two parts remain studies outside the active assembly. Existing 4 mm sliding-jaw windows and 2.6 mm cap end ligaments retained. Rigid BOM material labels now read PETG / PLA; the reviewed plate recipe is PETG. Historical slice files are unchanged. Physical fit, clamp strength and ramp quality remain unverified.

Latest material plates (2026-10-26): `review/material-plates/` now selects `2026-10-26-final-petg` with all seven rigid parts, including the 4 mm sliding-jaw windows and 2.6 mm cap slot ends. The approved tall-cap/flat-fixed/ramped-hook manufacturing geometry is retained. One A1 mini plate, 78.5316 g / 547.57 min, no slicer warnings; actual projected extrusion/support clearances pass. TPU remains the unchanged reviewed 15-piece plate (`2026-10-26-material-tpu`), 18.9223 g / 256.54 min / zero supports. Sorted tables updated. No printer contacted.

Shaft-cap slot ends (2026-10-26): user retained the solid sliding-jaw center (no T-window) and requested thicker highlighted cap slot ends. `thicker-cap-slot-ends-v3` moves the two outer slot-end centers from Y±54 to ±53 mm, increasing end ligaments from 1.6 to 2.6 mm. Outer cap/rail dimensions, 8.8 mm slot width and inner slot ends remain unchanged. Existing Y±50 service positions retain full 8.8 mm bore clearance. Manufacturing and BOM/assembly meshes regenerated. Historical sliced plates remain immutable; reslice before printing this revision.

Active sliding jaw, 4 mm openings (2026-10-26): user selected narrower holes and explicitly requested the BOM viewer update. Canonical `sliding_jaw()` now has two 31×4 mm through-openings, leaving 3.8 mm beam edge rails. Existing 6 mm tongue slot is retained; center and cuff-stud islands are unchanged. Viewer/BOM meshes, assembly configurations and manufacturing exports regenerated as `four-mm-jaw-windows-v3`. Subtraction-only and valid-single-solid checks pass (`review/four-mm-jaw-windows.json`). Existing compact plate jobs are immutable 5/7 mm studies, not slices of this 4 mm revision; reslice before printing this updated jaw. Strength remains unverified.

Selected narrower sliding-jaw windows (2026-10-26): user clarified narrower holes to leave thicker edge rails. Material overview now selects the existing audited `2026-10-26-compact-petg` plate: two 31×5 mm beam openings, 3.3 mm edge rails, solid central connection/stud bases, and existing 6 mm tongue slot with 35-degree roof retained. All seven PETG pieces fit one plate (78.319 g / 550.06 min / 0.3764 g supports). Sliding-jaw model mass is 12.7005 g; this favors thicker rails over filament savings. No reslice needed: exact requested geometry and layout were already sliced and checked. Active assembly remains unchanged; this is the selected manufacturing study. Physical stiffness remains unverified.

Compact PETG plate and sliding-jaw windows (2026-10-26): `review/material-plates/` now shows **two plates total**: all seven PETG parts nested on one A1 mini plate, and all 15 TPU parts on the other. Approved bed faces and 100% scale are retained. The final job is `print/jobs/2026-10-26-compact-petg-wide/`; actual deposited paths, including supports, pass exact silhouette separation checks where bounding boxes overlap. Two 31×7 mm beam openings preserve the center connection and stud bases; existing tongue slot retained. They remove 18.1% CAD solid volume but only **0.1697 g / 1.39% model filament** in matched standalone slices (12.2099→12.0402 g), because opening perimeters replace infill. Support is identical at 0.0292 g in both matched slices. Narrow 5 mm openings increased filament and were rejected. Remaining edge rails are 2.3 mm; stiffness requires physical testing. Manufacturing study only, active assembly source unchanged. No print sent.

Earlier material-separated print review (superseded by compact layout below, 2026-10-26): `review/material-plates/` provides plate selection and descending support/model-mass tables, ranked per piece with quantities and all-copy totals. The full 22-piece set uses approved ramped fixed-jaw/taller-cap study exports plus current remaining parts. Bambu Studio auto-arrange requires two rigid plates in the tested orientations; reviewed split is Plate 1A fixed jaw+cap (54.143 g / 396.99 min), Plate 1B five remaining rigid parts (23.947 g / 194.01 min), Plate 2 all 15 TPU parts (18.922 g / 256.54 min). PETG support total 0.3713 g; TPU zero support paths. Cuffs deliberately retain their physically successful support-disabled recipe; smooth axle slot is bridged. Other parts were sliced with automatic supports enabled. All quantities match the BOM, effective recipes and deposited clearances pass, no slicer warnings. PETG is the rigid recipe, not a PLA-ready G-code substitute. No print sent; current assembly source has not yet incorporated the approved study geometry.

Fixed-hook concepts (2026-10-26): after the user accepted the flat-fixed/taller-cap direction, tested a lower tapered root and a lower root plus upper return brace as separate studies. Both preserve the V seat and modeled band lanes; 91 travel samples and added-material assembly collision checks pass (`review/fixed-hook-clearance.json`). Matched two-part automatic-support PETG slices: flat-root baseline **0.5418 g supports / 54.305 g total**; lower ramp **0.2379 g / 54.143 g**; upper-braced variant **0.4077 g / 54.973 g**. Recommend the lower ramp: 56.1% less support than the flat-fixed study, 90.8% less than the original pair. It remains supported at the upper notch lip and small base ledge. Lowered-hook and separate TPU-anchor concepts were considered but not built because they alter band path/preload or add a retention interface. The original lower-ramp trial includes a 0.05 mm fusion overlap, making the nominal 35-degree ramp slightly steeper; subsequent source uses exact 35 degrees. Actual print quality, strength and band installation remain unverified. These studies are not promoted into the active assembly; no print sent. See `print/jobs/2026-10-26-ramped-fixed-hook/` and `2026-10-26-braced-fixed-hook/`.

Separate split-plane study (2026-10-26): `source/study_flat_fixed_pair.py` trims the fixed collar underside to X−5.8 and extends the cap walls to X−4.8, transferring 5.3 mm while retaining the 1 mm split gap, neck opening, screw bores and external bearing planes. Fixed collar body becomes 5.5 mm thick. Both are valid single solids with clear screw bores. Active assembly remains unchanged pending review; stiffness, loaded clamping and installation require physical checks. Matched two-part PETG plates (`2026-10-26-fixed-cap-baseline` and `2026-10-26-flat-fixed-tall-cap`) reduce support/interface **2.5835→0.5418 g (79.0%)**, total **56.366→54.305 g**, time **408.73→396.69 minutes**. Cap remains support-free in the slice; remaining fixed-jaw support reaches 15.2 mm. No warnings; deposited-path clearance between pieces is 6.823 mm after margin. See `review/flat-fixed-tall-cap-comparison.json`. No print sent.

Fixed-jaw PETG slice (2026-10-26): `print/jobs/2026-10-26-fixed-jaw-petg/` contains one current fixed jaw in the approved collar-face-down orientation (CAD Y+90), track upright. A1 mini 0.4 mm nozzle, 0.12 mm layers, three walls, 15% gyroid and Normal Snug automatic supports: **35.607 g total, 280.33 minutes; 2.1334 g scaffold + 0.4501 g interface = 2.5835 g supports**, at bed heights 0.20–20.60 mm. No slicer warnings. Actual toolpaths and source hashes are in the interactive review. Preview only; no printer contacted. Support removal, strength and live 35-degree roof quality remain unverified.

Replace the rigid axle T-key with an ELEGOO TPU95A T/V snap-key prototype. Retain the T-head stop and3 mm stem/thickness through the unchanged3.4×3.4 mm axle slot. Extend the leading end to14.7 mm overall, with an open V and two free arms spanning5 mm relaxed. A narrow1 mm central spine leaves room for the arms to squeeze inward. Keep the tested common cuffs and integral jaw studs unchanged; this loose key is now used only at the pulley axle.

The V apex enters first; the arms must compress through the slot and spring outward beyond the far side. Remove the keeper and pinch both exposed arms inward before withdrawing toward the T-head. Retain the existing keeper band during qualification; its illustrative path expands around the new tip. No claim of self-locking reliability until physical insertion, spring-back, pull-out, axle loading, wear and creep tests pass. Geometry checks use an ideal3 mm compressed envelope, not an elastic simulation. See `review/tpu-tv-key.json`. Fresh TPU slicing is required; no print sent.

### Preceding flush-beam-sliding-jaw-v3 (2026-10-25)

Move the continuous beam and its studs5.2 mm to share the central root's X−10 rear face and X−2 front face. The beam remains8×11.6 mm in section and121.6 mm long. This removes the offset ledge beneath the central root when printed rear-face-down. Retain35° studs, band slot and tongue-slot roof.

Slide the assembled jaw5.2 mm outward along the existing track so all three cuff contact positions remain unchanged. Tongue geometry and fixed jaw are unchanged; the band span grows5.2 mm and must be checked physically for preload/return. Exact engagement and nominal1.4 mm band-envelope checks are in `review/flush-beam.json`. This is not a strength qualification. Previous continuous-beam slice is historical; use the new flush-beam slice for support estimates.

Matched PETG slice `print/jobs/2026-10-25-flush-beam-petg/`: same machine/process/filament and orientation as the preceding single-jaw plate, automatic supports enabled. Support/interface0.6447→0.0271 g (95.8% reduction); total13.340→12.422 g; time133.13→125.21 minutes. Remaining support paths are at0.20–1.40 mm bed height. No warnings. All eight rigid configurations and common-cuff/travel checks pass; known phone-fit and whole-route issues remain. No print sent;35° quality and loaded strength remain physical checks.

For scoped reversal, set `SLIDING_BEAM_SHIFT=0` in `model.py`, use `sliding_jaw(...,flush_beam=False)`, restore preceding metadata and regenerate. This restores the preceding continuous beam and its assembly position without touching the fixed jaw/cap.

### Preceding continuous-beam-sliding-jaw-v3 (2026-10-25)

Reversible sliding-jaw study: replace both thin raised end plates and the stepped crossbar with one 121.6 mm-long, 8 mm-deep, 11.6 mm-high rectangular beam. Both integral T-studs now emerge directly from this beam. Preserve their exact original positions, 100 mm spacing and all three interchangeable TPU cuffs, rather than moving the phone contacts. Tongue, slot, cleat and fixed jaw remain unchanged.

Keeping the cuff backing face at X−7.2 places the beam rear at X−15.2, 5.2 mm behind the previous bed plane. This is a geometry review, not a support-neutral manufacturing promotion: the tongue root/cleat need a fresh support review before printing. Earlier slice files remain immutable and do not represent this sliding jaw. Physical strength and grip remain unqualified. For a scoped geometry reversal, use `sliding_jaw(..., continuous_beam=False)` and regenerate; do not revert the cap, fixed-jaw windows or other accepted work.

Verification: one valid solid, exact original cuff/stud positions, unchanged tongue/cleat, 91 sampled travel positions clear, and all eight rigid assembly configurations pass. The rollback construction matches the previous immutable STEP exactly. CAD volume increases 14,927.86→18,641.82 mm³ (24.9%); this is a shape simplification, not material savings. See `review/continuous-beam.json` and `review/cuff-integration.json`. Known phone-fit and whole-route limitations remain.

PETG preview `print/jobs/2026-10-25-continuous-beam-petg/`: one jaw, rear beam face down, A1 mini0.4 /0.12 mm /3 walls /15% gyroid /Normal Snug automatic supports. Estimated133.13 minutes,13.340 g total; scaffold0.5433 g + interface0.1014 g =0.6447 g, at bed heights0.20–6.68 mm under the raised central root/cleat. No slicer warnings. Prior jaw's0.0292 g support is lower; this design is not support-neutral. Inspect removal and sliding-face residue physically. Preview only, no printer contact or print sent.

### Preceding support-neutral-jaw-slots-v3 (2026-10-25)

User approved the displayed print orientations and conditioned new arm/tongue slots on no extra support. Add narrow 6 mm-wide through-slots with 35° peaked roofs to the fixed guide floor and sliding tongue. Preserve guide edges, roots, cleats, cuff studs and travel stops. Fixed jaw prints collar face down (+90° CAD Y); sliding jaw prints flat crossbar back down (−90° CAD Y), rotated 90° on the plate for spacing. The approved collar windows and cap slot are retained.

Matched A1 mini0.4 / Bambu PETG Translucent /0.12 mm /Normal Snug automatic-support plates: **support and interface segment geometry is identical**, not merely rounded mass totals. Existing fixed-jaw support/interface is 2.5835 g and sliding-jaw support/interface is0.0292 g. These parts are not support-free. Total filament47.401→46.876 g (0.525 g saved); time351.31→352.12 min. No slicer warnings; deposited paths retain35.56 mm separation after0.6 mm margin. Profiles, quantities and placements match exactly. See `review/jaw-arm-slots.json` and immutable `print/jobs/2026-10-25-jaw-arm-baseline/` / `2026-10-25-jaw-arm-slots/`.

Current source shapes match the candidate geometry. Valid single solids, subtractive-only changes and intact guide edges/roots/stops establish no new rigid collision geometry through travel, not physical catch/wear or bending performance. Ask after a future print whether the35° roofs printed cleanly without added supports. No print sent. Loaded retention, real sliding fit, phone-fit and whole-route limitations remain unresolved.

### Preceding through-window-fixed-jaw-v3 (2026-10-25)

Apply the cap's through-opening approach to the highlighted fixed-jaw collar wall. Two rounded 11 mm-wide windows span Z−30..4 and Z38..60. Unlike the cap, retain a central bridge at Z4..38: a continuous slot would undermine the cuff stud base and direct sliding-track root. Both interfaces, the interlock, stop, band cleat and all four screw bosses remain unchanged. Side rails are 8.3 mm wide. Approved through-slot cap remains unchanged.

CAD checks confirm one valid solid and unchanged interface geometry. Fixed-jaw solid volume falls 6.92% (44,849→41,746 mm³), not a sliced filament estimate. See `review/lightened-fixed-jaw.json`. No new slice or print. Frame stiffness, neck contact and loaded retention still need physical testing; existing phone-fit and cord-routing limitations remain.

### Preceding through-slot-shaft-cap-v3 (2026-10-25)

User approves the flush axial ends and requests the highlighted central strip punched completely through. Replace both shallow pockets and their intervening web with one 11 × 90 mm rounded through-slot (Y±5.5, Z−30..60). Preserve the approved Z−38.5/+68.5 end planes, four screw mounts and flat X12 bed face around the opening. Side rails are 8.3 mm wide, joined by 8.5 mm end bridges. The actuator wings retain their interfaces but now transfer load through this perimeter frame rather than a solid central web; stiffness and loaded retention require physical testing.

Valid single solid; CAD volume 27,002 mm³, 19.96% below the original solid cap and 14.72% below the preceding pocketed cap. This is not a sliced filament estimate. No new slice or print. See `review/pocketed-cap.json` (current cap audit) and `review/flat-bed-cap.json`. Existing phone-fit and cord-routing failures remain unresolved.

### Preceding pocketed-flush-end-cap-v3 (2026-10-25)

Reversible shaft-cap refinement requested for visual review. Two neck-facing rounded pockets remove material while leaving a 3 mm outer floor and solid central actuator-rail root. Both axial ends are trimmed into one planar face across the bosses and connecting wall, at Z−38.5/+68.5. Screw centers, 8.8 mm bores, rail interfaces and X12 flat print face remain unchanged. The minimum end ligament outside each screw bore is 4.1 mm. Fixed jaw is unchanged.

CAD solid volume falls 6.14% (33,737→31,664 mm³); this is **not** a sliced filament-saving estimate. No new slice or print. Strength, preload and printed pocket/boss quality remain unvalidated. See `review/pocketed-cap.json` and `review/flat-bed-cap.json`. The exact pre-change source and exports are recoverable from Git commit `9715c28`; revert only this cap refinement if the highlighted-face interpretation is rejected. Existing phone-fit and routing issues below remain unresolved.

### Preceding deep-groove-pulley-v3 (2026-10-25)

Deepen the redirect pulley groove from 1.1 to 2.2 mm nominal radial depth. Keep its 18 mm diameter, 4 mm axial width, 8.6 mm bore and existing bearing faces; axle, bracket and key are unchanged. The groove root radius is 6.8 mm, leaving a 2.5 mm radial web outside the bore. Both tapered sides are 36.03° from the print bed, with a 0.4 mm root flat and 0.09 mm edge rounds. The nominal 2 mm cord path is updated to an 8.35 mm centerline radius, with recalculated entry/exit tangents.

This is intended to make string escape less likely, not guarantee retention under slack or sideways pull. Test groove finish, cord wear, free rotation and actual string tracking physically. No print sent. The PETG support-check job is `print/jobs/2026-10-25-deep-groove-pulley/`; historical slices remain unchanged.

Actual-toolpath result: automatic Normal Snug supports enabled, zero support/interface paths, no slicer warnings. A1 mini / 0.4 mm nozzle / Bambu PETG Translucent / 0.12 mm layers / textured PEI: 0.7315 g, 13.25 minutes. This is slicer evidence, not physical support-free validation.

Verification: eight rigid configurations, local cassette cord/return/keeper paths and three sampled stroke positions pass. The complete routing audit intentionally remains failing: wallet/bare/small-near outgoing cord intersects the carrier, and large-far has 0.0922 mm³ nominal cord/pulley exit contact. The 20 mm large phone is already incompatible with the cuffs, but this new exit contact is retained explicitly, not waived as a passing clearance. See `review/plunger-integration.json`. Do not treat this pulley-only slice as qualification of the assembled routing. Viewer and actual-toolpath preview tests pass.

### Preceding single-tpu-clip-guide-v3 (2026-10-25)

Replace both old guide designs with **one reversible TPU 95A clip nearest the phone**. Remove the two lower guides and all three guide-retaining rubber bands. One 4 mm hole (half the former 8 mm diameter) is offset to one side; rotate the clip 180° about X to put the eye on the other side without changing the snap-mouth direction. Remove band grooves, the raised backing block and the second eye. The constant-section body is 6 mm axially wide, versus the former 14 mm saddle, and prints end-on-bed with a vertical eye bore; a fresh slice is still required.

Proposed clip: 1.6 mm walls, 13 mm snap mouth, 13.8 × 18.8 mm cavity around the measured 14 × 19 mm neck (0.1 mm nominal elastic interference per face). This is deliberately not the rigid collar's smaller accepted opening. TPU deformation, insertion force, axial grip, creep and cord wear require a physical fit test. The longer free cord span now runs from this one guide toward the inline band/trigger; inspect rubbing and snagging. Do not infer that the existing upstream routing issue is resolved.

Current BOM: 12 printed designs / 22 pieces, five rubber bands (two jaws, return, inline compliance, axle-key keeper). All five common screws/nuts remain TPU; jaw/cuff geometry is unchanged. No slice or print sent.

Verification: valid single solid, eight assembly configurations checked, and the nominal 2 mm cord clears the 4 mm eye at its actual incoming/outgoing angles in both orientations. See `review/tpu-clip-guide.json`; nominal neck interference is recorded explicitly as an intended elastic fit, not rigid clearance. Full-build geometry checks and the final preload refinement are in `review/validation.json`. Manufacturing exports and assembly instructions reflect the single guide. Earlier service checks apply to the unchanged clamp/actuator; no new service-path claim is made for TPU deformation.

### Preceding common-tpu-fasteners-v3 (2026-10-25)

Use five identical long collar screws: four in the neck clamp and one securing the actuator to its rail. All five screws and five nuts are ELEGOO TPU 95A at the user's request. The existing 8×3 thread geometry and long screw length are unchanged. At the actuator, preserve the head bearing face and extend the free tip 12.2 mm beyond the previous short screw; index the thread phase to match the unchanged nut. The active BOM now has 13 designs / 24 pieces.

The user reports TPU tightens better; this does not establish loaded clamp retention, thread strength or long-term creep resistance. Hand-tighten and physically check the long TPU screws and actuator retention before using a phone. No new slice or print. Existing phone-fit and outgoing-twine limitations remain unresolved. Historical short-screw jobs are not current manufacturing instructions.

Verification: all eight rigid configurations and plunger sweeps pass; all ten sampled service configurations pass the outboard-slide, nut removal and screw withdrawal sequence (`review/service-access.json`). Mount-bore checks pass (`review/fixed-mount.json`), manufacturing meshes regenerate successfully, and the viewer smoke test verifies five screws/five nuts in TPU, no separate short-screw design and no browser errors. These are digital checks, not load or creep testing.

### Preceding opposed-slots-restored-base-v3 (2026-10-25)

Mirror the sliding jaw's 35° V-shaped band seat onto the fixed jaw and remove both square top caps. The user reversed removal of the sliding post's lower square projection: restore its original extent to X−0.5, preserving the tongue beneath it. The two opposed slots use the same profile reflected across X; cuff studs, three identical TPU cuffs, tongue and band paths remain unchanged. See `review/opposed-band-slots.json`. Actual band seating and escape resistance without the caps require physical checks. No new slice or print: the earlier support estimates below do not qualify this revision.

### Preceding ramped-jaw-35-v3 (2026-10-25)

Use **35° from the bed (55° from the build axis)** on the sliding cleat underside (the blue-highlighted notch), tongue shoulders and all three integral cuff T-studs. The user rounds the tested 34° functional minimum up to 35° for memorability. One source constant controls these slopes. This does not alter the actuator axle key, actuator cleat or fixed-jaw band cleat. The successful screw's 45° flank was the starting point. A matched 0.12 mm PETG sweep finds 31° is the shallowest zero-support slice at 1° resolution (30° still generates 0.1119 g), but 31–33° crowd the modeled band. Neither the selected angle nor the boundary is a measured physical PETG overhang limit. After the next relevant print, ask whether the 35° features printed successfully without supports.

The complete sliding jaw has zero support/interface paths with automatic supports still enabled. The fixed stud also has none; the full fixed jaw still needs support under its neck cavity and existing fixed cleat. Exact immutable slices: `print/jobs/2026-10-25-sliding-jaw-angle-35/` and `print/jobs/2026-10-25-sliding-jaw-fixed-angle-35/`. The earlier 34° jobs are preserved. See `review/jaw-support-angles.json` for recipe hashes, sweep, source equivalence and local fixed-stud path checks.

The three 21.6 mm TPU cuffs remain exactly unchanged and interchangeable. Studs keep the 9.2 mm head width, 6.4 mm stem and existing envelope; the 6.8 mm passage / 9.6 mm recess still clear in CAD. The retaining shoulders are now ramps, not the physically tested square shoulders. Rigid pull-out remains obstructed, but compliant TPU may release more easily: re-test retention with a dummy edge before trusting a phone. Tongue, stop, square cleat cap and band routing are unchanged. Both jaw designs require new prints; no printer contacted. Existing phone-fit and outgoing-cord issues remain unresolved.

### Preceding flat-bed-sliding-jaw-v3

**Angle study (not yet promoted):** `source/sliding_jaw_angles.py` uses the successful screw's 45° flank as a starting point: a 45° pitched cleat underside and 53.1° tongue-shoulder ramps. The exact cuff studs, tongue and square cleat cap remain unchanged. Matched automatic-support PETG slice `print/jobs/2026-10-25-sliding-jaw-angled-undersides/` produces no scaffold and only 0.0123 g interface under the original stud heads, versus 0.1543 g in the lowered-cleat slice (92% reduction). Total 11.711 g / 119.21 min, no slicer warnings. The cleat's minimum central stem thickness becomes 3.75 mm; strength and actual band seating remain untested. This is a separate review candidate, not an active assembly or print authorization. See `review/sliding-jaw-angles.json`.

The sliding jaw's crossbar and both cuff-pad backs share X−10 as the bed plane (Y−90° print orientation). Extend the pad backs 0.5 mm, then lower the band cleat 4.5 mm toward this plane. Preserve the tongue, closing stop and exact cuff/stud interfaces. Update the moving band path; actual tension needs rechecking because the anchor span increases 4.5 mm. Only the sliding jaw manufacturing shape changes.

One refinement/review round after flattening, using matched Bambu PETG Translucent Blue / A1 mini / 0.4 mm nozzle / 0.12 mm layers / 3 walls / 15% gyroid / Textured PEI / Normal Snug automatic supports:

| Slice | Support + interface | Total filament | Time |
| --- | ---: | ---: | ---: |
| Original | 0.5140 g | 12.130 g | 121.01 min |
| Flat pad backs | 0.4354 g | 12.192 g | 120.72 min |
| Lowered cleat (selected) | 0.1543 g | 11.742 g | 119.65 min |

Final support is 70% below baseline, not zero or a proven global minimum. Small supports remain below cleat retention features and stud heads; inspect/remove residue without damaging retaining faces. All settings and scale match; supports were not disabled. Actual toolpaths and immutable inputs are in `print/jobs/2026-10-25-sliding-jaw-{baseline,flush-back,lowered-cleat}/`. `review/sliding-jaw-bed.json` checks planar bed contact, unchanged interfaces, 91 travel samples and modeled band clearance. No printer contacted. Printed strength, tall tongue stability, retention and band preload remain physical checks; existing phone-fit/twine limitations remain unresolved.

Full rebuild passes all eight rigid assembly configurations and produces watertight manufacturing meshes. Exact common-cuff integration/travel, band-clearance checks and the interactive support-preview test pass. The original service-path audit is not a fresh rerun; the actuator/cap and fasteners are unchanged.

### Preceding flush-side-fixed-jaw-v3 (2026-10-25)

Trim the track's two exterior side faces from Y±16 to Y±13.8, matching the adjacent collar sides as requested. Track width becomes 27.6 mm; channel-side walls are 3.5 mm thick. Inner channel, retaining lip edges, full-depth right-angle root, closing stop, cleat and cuff positions are unchanged. Only the carrier manufacturing shape changes. Physical strength remains unqualified; no slice or print requested.

Verification: `review/flush-jaw-sides.json` confirms one continuous planar side face on each side (1965.6 mm² each) and the unchanged 20.6 mm channel / 15 mm lip opening. Full rebuild passes all eight rigid configurations; root/stop and common-cuff/travel checks pass. Manufacturing meshes are watertight. Earlier phone-fit and downstream-twine limitations remain unresolved; the prior service audit is not a fresh rerun for this exterior-only material removal.

### Preceding direct-root-fixed-jaw-v3

The upper fixed-jaw track and its band cleat move 2.7 mm toward the collar (+X, downward in the user's side view). Its formerly offset end now meets the X−11.3 clamp face through its full 12 mm depth and 27.6 mm collar width, forming a direct right angle rather than hanging from a 4 mm floor tab. The redundant central connector is removed. The closing stop, sliding jaw, phone, three cuffs and stud positions stay unchanged; only the carrier manufacturing shape changes. Band routing follows the moved fixed cleat, so real band preload needs rechecking. See `review/direct-jaw-root.json`. No slicing or printing requested; strength remains unqualified.

Verification: direct root is a valid single solid with zero missing material across the full-depth seam. The original stop blocks 0.2 mm overtravel; 91 sampled jaw positions are clear. Three cuffs remain exactly identical to the approved part. All eight standard rigid assembly checks, band-clearance checks, collar removal checks and the viewer smoke test pass; manufacturing mesh is watertight. The downstream twine audit retains the same three carrier conflicts (10.56603 mm³ each). Its final stop-wall addition is independently cord-clear in `direct-jaw-root.json`; see the routing report's explicit provenance.

### Preceding flat-bed-shaft-cap-v3

The entire cap exterior now lies on X12: collar body, central crossing, both slotted rail wings and all four screw bearing seats. The former center-only edit did not meet the user's flat-bed requirement. All raised areas are trimmed 1.8 mm; the rail is now 4.2 mm thick. The manufacturing orientation puts this common face directly on Z0.

To preserve assembly alignment, the bracket bearing plate extends inward 1.8 mm, while its bore, mechanism, plunger and phone remain in place. The four collar screws shorten only at the head end (32 to 30.2 mm threaded span), keeping their tips, nut positions and thread phase unchanged. New manufacturing shapes: shaft cap, actuator bracket and collar screw; cuffs, fixed jaw, nuts and remaining actuator parts stay unchanged. See `review/flat-bed-cap.json`. No new slice or print; thinner-rail strength, full collar fit, preload and existing phone-fit/twine-routing limitations remain unqualified.

Verification: a single connected CAD face spans both wings and all four seats at X12. The watertight bed-oriented STL has 4524.29 mm² on Z0. All eight standard rigid assembly checks, flush-stud/alignment checks, collar removal checks, ten actuator service configurations, axle/key paths and the viewer smoke test pass. The local actuator motion/cord audit passes, but its downstream-routing check still fails on the same three carrier intersections (10.56603 mm³ each); no routing fix is claimed.

### Superseded center-only flattening

The green-highlighted central rail crossing is trimmed 1.8 mm to the surrounding blue-highlighted collar face at X12. CAD reports one connected planar face across the full collar length. Only the shaft cap changes: 993.6 mm³ removed, no added material, with both slotted wings/mounting faces at X13.8, all four fastener bosses and the neck opening unchanged. See `review/flush-cap-center.json`. The prior full rigid/service checks are explicitly inherited through this bounded subtraction, not reported as freshly rerun; see `validation_provenance` in `review/validation.json`. Historical print jobs remain untouched. No slice or print is requested; full collar strength/fit and prior phone-fit/twine-routing issues remain unqualified.

### Preceding straddled-four-bolt-collar revision

The user's green-highlighted left tail and its two fasteners are removed. The pair nearest the jaw remains at Z−30; a matching pair moves to the new right extension at Z+60. Both carrier and shaft cap now span Z−40..70 (110 mm body length), with 90 mm between axial fastener stations. Four screw/nut pairs total, two on each axial side of the fixed contact; matching bores remain at Y±15.5. The existing screw/nut designs, bearing planes, accepted 11.6 × 17.6 mm opening, cuff/stud dimensions, jaw track and actuator alignment are unchanged. Boss roots are recut after union so they do not intrude into the accepted neck opening. The Z+52 candidate was rejected because nuts hit the jaw-band cleat during removal; Z+60 leaves 3.5 mm nominal vertical clearance. Only carrier and cap manufacturing geometry changes. This is a review prototype, not measured clamp-strength or full-neck-fit validation. No new slice or print is requested. See `review/straddled-collar.json` and current service/assembly checks.

Verification: both collar halves are valid single solids and their manufacturing meshes are watertight. All eight standard rigid assembly checks, common-cuff equivalence/travel, collar fastener and cap removal paths, actuator service/axle insertion checks and the viewer smoke test pass. The separate outgoing-twine audit still reports carrier intersections in wallet-near, bare-near and small-near (10.56603 mm³ each); do not treat this as a print-ready complete mechanism. Recorded 18/20 mm phone incompatibility remains.

### Preceding flush-stud-fixed-jaw revision

The former blue tray walls and red raised stud pedestal are removed. The tested integral T-stud emerges directly from the X−11.3 clamp exterior. The neck wall extends to the track as one continuous right-angle junction. The fixed cuff and phone move +1.8 mm X toward the neck; the actuator and its cap-mounted rail follow to retain the nominal 0.35 mm released gap and exact mating faces. Both collar bearing planes and the unchanged screws/nuts move +1.8 mm X to preserve grip length and clear the screen. Only the fixed carrier and shaft cap require new prints; all three approved 21.6 mm cuffs, sliding jaw, actuator and fastener shapes are unchanged. Physical assembly, strength and grip remain unqualified. See `review/flush-stud-jaw.json`.

Verification: literal wall/pedestal removal and solid corner checks pass; all eight standard configurations pass rigid mechanical and common-cuff integration checks. Service/axle insertion checks and the viewer smoke test pass. The plunger routing audit still fails for the inherited outgoing-twine/carrier intersections in wallet-near, bare-near and small-near (10.74514 mm³ each); this revision is not print-qualified and does not resolve that routing issue. Recorded 18/20 mm phone incompatibility remains.

### Preceding flat-fixed-jaw revision

The two highlighted longitudinal ribs on the fixed carrier's shaft saddle are removed. The underlying clamp wall, four round fastener bosses, nut bearing faces, central jaw-root connection and integral cuff stud remain. See `review/flat-fixed-jaw.json` for the before/after volume and continuity audit. This is material removal, not a stiffness qualification. Current TPU print files are unchanged.

The user reports successful fit of the PETG integral T-stud and TPU cuff and selects this retention method for **all three contacts**. All cuffs are the exact same 21.6 mm-wide shape, including the 6.8 mm square passage and 9.6 × 6.8 mm head recess. The fixed cuff is centered at Y0; sliding cuffs remain at Y±50 mm. The fixed carrier and sliding jaw now incorporate the tested stud geometry; no loose cuff keys remain. The single axle key and approved actuator geometry are unchanged.

`source/cuff_design.py` is canonical. `review/cuff-integration.json` checks exact shape equivalence against the successful TPU cuff, all three stud/cuff interfaces in eight configurations, neck clearance and sampled jaw travel. The rebuilt BOM contains **14 designs / 24 pieces**, with 37 assembly steps. Complete new jaws remain unprinted; local fit success is not loaded phone-retention or strength qualification. Recorded phone envelopes and known outgoing-cord/carrier conflicts are retained.

The five-piece TPU preview at `print/jobs/2026-10-24-three-cuffs-thread-tpu/` contains three identical cuffs and the unchanged 8×3 thumb screw/nut pair. Supports are disabled following user feedback that the previous cuff's tiny support was unnecessary. Estimate: **111.7 minutes / 7.344 g / zero supports**. The user subsequently authorized printing; the correct job was observed RUNNING. Completion and physical results remain pending. TPU threads are an experimental fit comparison, not a structural fastener promotion.

Service remains: remove phone/release twine, loosen rail nut, slide the supported actuator to screw-center Y+50 near or Y−50 far before withdrawal; do not cross the solid rail center. Consult current service-access and validation reports. TPU deformation is required to install/remove cuffs over the studs; rigid translation is not an installation simulation.

### Preceding straight-corner bracket revision

The user has approved both the sliding plunger and this bracket design. Full rebuild and eight rigid-assembly checks, local guide/stroke/wheel checks, fixed-mount checks, service paths and viewer smoke test pass. The known 14 mm pocket conflicts and three outgoing-twine/carrier intersections remain explicitly reported. Bracket approval does not establish physical printing or loaded qualification of this latest revision.

`straight-corner-guide-v3` preserves the user-approved sliding plunger unchanged. The bracket's front spine edge is trimmed to v=2.5 and its rail-clearance side continues at u=-7.8 to the mounting root, replacing the two stepped notches with a single straight-sided corner. The opposite (-u) guide wall and retaining lip extend forward from v=18 to v=2.5, preserving 0.3 mm side and 0.4 mm under-lip clearance. The pulley, axle, mount bore, return stop and prior long guide are unchanged. No new slice or print is requested by this revision; historical jobs retain their original geometry. Existing phone-fit and outgoing-twine routing failures remain reported.

The user approved the plunger on October 16. The preceding PLA job ran out of filament according to the user; a dry Bambu PETG Translucent Blue reprint was started October 15 (see `print/jobs/2026-10-15-actuator-petg/`). Startup is not telemetry-verified completion, and approval is not a measured strength qualification.

### Preceding concave boot / long guide

`concave-boot-guide-v3` supersedes the boot blend and long-guide shape below. Both boot roots now use a non-inflecting hyperbola-like sweep: a spline fit to a rational quadratic with weight 1.4, tangent to the boot rear edge and straight neck, spanning v=-4..2 mm. The straight neck remains 8 mm wide; shoe/stem thickness remains 4 mm and contact span 16 mm.

The highlighted guide is full height through v=42 mm, including its inner retaining lip. The former broad channel cut no longer erases this extended guide. Nominal side clearance is 0.3 mm and clearance under the lip is 0.4 mm. Its far end curves down over v=42..55 mm to leave the return-band route clear. The independent return stop and pulley stack stay unchanged. The two-piece review slice is in `print/jobs/2026-10-14-concave-boot-guide/`: **9.69 g / 78.3 minutes / 0.0863 g support**, all support in the round bracket mounting hole. The plunger and extended guide generate no supports. No print is authorized. The previously documented outgoing-twine/carrier collision remains an unresolved assembly issue.

### Preceding open-pulley changes

`post-print-open-pulley-v3` applies the six highlighted post-print requests:

- Plunger neck is a uniform 8 mm wide, with tangent curved transitions into the 16 mm boot. Its print-plane thickness remains 4 mm.
- Outer pulley cheek, ring and connecting arm are removed. The remaining bearing boss extends 2 mm farther from the base, to 8.2 mm from the flat back; the unchanged wheel translates 2 mm with it.
- The existing axle head and cross-key remain. Boss-to-head spacing is 5 mm around the 4 mm wheel, providing **1 mm total nominal axial clearance**, not 1 mm radial wobble. The nominal wheel position leaves 0.4 mm at the boss and 0.6 mm at the head. The axle/key also has 0.4 mm independent float; printed tolerances and loaded rotation need checking.
- The rectangular raised plinth around the boss is removed to the 3 mm main base plane.
- The highlighted +u guide widens to the spine edge at u=9, extends toward v=55 and eases down with a curved taper, keeping the return-band route clear.
- A separate rounded block at v=51..54 stops the stem after 2 mm of extra return travel, 5 mm before the fixed band anchor. This is a return stop, **not** a phone-safe press/overtravel limit.

The user reports all actuator parts printed and approves the pulley, screw/nut and cross-key. The detailed bracket changes supersede its initial general approval. The prior exact print job and source hashes remain untouched at `print/jobs/2026-10-14-actuator-bridge/`; see `physical-feedback.json`. New bracket and plunger geometry remains unprinted. The axle, key, screw/nut and pulley shapes are retained; only the wheel's assembled position changes.

Removing the outer bearing makes the axle a cantilever. CAD checks establish clearances and geometric retention, not bending stiffness, fatigue, friction or band security. `review/post-print-refinements.json` records literal region checks, neck sections, the return stop, wheel float and nominal plunger motion. V1/V2, harness and phone envelopes are unchanged; the 14 mm pocket conflict remains.

**Routing regression — not ready to print:** raising the wheel changes the direct outgoing twine span. Its modeled envelope now intersects the carrier in wallet-near, bare-near and small-near configurations (about 10.78 mm³ each). Local cassette motion and all eight rigid mechanical checks pass, but this separate routing check fails. See `review/plunger-integration.json`. Harness guides and phone positions have not been silently moved to clear it; a routing adjustment needs review before another print.

The matched seven-piece comparison slice is `print/jobs/2026-10-14-actuator-post-print/`: support/interface **0.4500 → 0.0863 g (80.8% less)**, total **13.75 → 13.16 g**, estimated duration **107.2 → 104.9 minutes**. All remaining support is inside the round mounting bore; none is generated on the plunger. Profiles, placement, scale and per-object settings match the preserved printed bridge plate. Only bracket/plunger designs need replacement consideration; this full-plate comparison is not a request to reprint approved parts. No printer was contacted.

## Earlier support-refinement checkpoint (superseded where noted above)

`ramped-retainers-v3` implements four selected refinements: sloped undersides on the fixed-band lip and shared plunger cleat, steeper pulley-groove flanks, and a 2.6 mm extension of the outer fork leg to the existing bed plane. Both pulley flanks are tapered because its print orientation is flipped relative to the bracket. Rounded edges and retaining rims remain; band/string paths, mount, axle/key, print orientations and assembly positions are unchanged. The wheel cavity stays open. See `review/support-refinements.json`.

The matched seven-piece slice at `print/jobs/2026-10-14-actuator-ramped/index.html` uses unchanged A1 mini / 0.4 mm / Generic PLA reference settings, 0.12 mm layers and Normal Snug. **Support/interface falls 0.810→0.480 g (40.7%); total filament 14.15→13.78 g; time 1 h 52→1 h 48 min.** No support is generated on the plunger or pulley. Bracket support remains ~0.450 g, axle slot ~0.030 g. The exact earlier plate is preserved at `print/jobs/2026-10-14-actuator/`. No job was sent; support-free slicing of these two parts does not establish print quality or retainer security.

The user declined the teardrop mounting-hole roof and selected the unsupported axle-slot bridge. The mounting hole remains round; all CAD geometry, square retaining faces and print orientations are unchanged. The current plate is `print/jobs/2026-10-14-actuator-bridge/index.html`, with only the axle's support override disabled: **13.75 g / ~1 h 47 min / 0.450 g support**, all on the bracket. Actual axle bridge paths match the preceding supported slice. That ramped plate is preserved. Inspect bridge sag and cross-key fit before assembly; do not force the key.

The earlier independent investigation is recorded at `review/remaining-support-studies/`. The rejected teardrop roof saved ~0.097 g in isolated slices but reduced the opposite ligament to 3.78 mm. A ramp under the upper pulley cheek collides with the wheel/axle; further removal there requires a separate design choice.

`plain-clamp-mount-v3` removes both rail locating lugs at the user's request. The closed 8.8 mm mounting bore, offset plate, 5.4 mm bore-side ligament, reinforced root and common flat back are unchanged. The single screw/nut now relies on preload and surface friction alone to resist both rail sliding and rotation; loaded retention is not validated. The separate pulley cross-key and keeper band remain. The sampled removal path remains conservative rather than claiming a newly simplified insertion path.

`flush-pulley-back-v3` fills the 2.2 mm rear pulley-cheek recess up to the existing Y5.4 bed-contact plane, keeping the 8.6 mm axle bore open. The axle's retaining end and slot extend 2.2 mm outward: overall axle span is now **20.6 mm**, with the same 1.6 mm recessed head, 8 mm shaft and 0.8 mm wheel axial clearance. The rear bearing land is 6.2 mm rather than 4 mm. The unchanged option-B cross-key and its keeper-band envelope translate 2.2 mm outward; the nominal key-to-back gap remains 0.4 mm. Pulley, plunger, rail, phone and twine positions do not move. Print the bracket alone; axle, key and band are installed afterward. No fresh slicing or support-free claim.

Tradeoff: the longer axle intersects the carrier by about 47.4 mm³ at the former synthetic far-side Y−24 mm candidate. This failed position is retained in `review/compact-keyed-plunger.json`, not moved or omitted to make the check pass. All eight original phone/side examples remain mechanically clear. The near Y29 and farther-out far Y−28.5 candidates are checked separately; this does not establish a continuous adjustment range.

`uniform-width-cleanup-v3` removes the small residual tab beyond the nut-clearance cut, narrows the shoe/root from 6 to 4 mm to match the stem (16 mm contact span unchanged), removes the rail screw's obsolete contact nose without moving its threads/head, and shows BOM printed parts at common source-millimetre scale. Twine/band BOM icons remain schematic.

**Cross-key option B is selected:** retain the 7 mm-wide T-head and reduce its thickness to the stem's 3 mm. This preserves the broad insertion stop and keeper-band seat while eliminating the thicker head lip. Option A in `review/concepts/cross-key-options.png` is an unselected clarification study, not active CAD. Printed retention remains untested.

The user accepts the flat-back bracket apart from the requested tab cleanup and sees no issue with the displayed string route. Routing is unchanged; this visual acceptance does not erase the recorded interference at additional inward test positions. The prior flat-back slice comparison below is historical and has not been repeated for these modified parts.

## Preceding flat-back revision (2026-10-09; superseded where noted above)

The plunger replaces the rocker. All actuator-bracket twine holes and the projecting lower base are removed: the cord runs from the pulley directly to the nearest shaft guide. No extra unsupported zig-zag waypoints are used. The rounded plunger shoe, curved root and shared capped band/twine cleat are retained.

### Reinforced mounting junction

Revision `flat-back-mount-v3` retains the reinforced joint and smooths the highlighted end: the haunch now eases into the spine in both width and height, ending at X64 with horizontal curve tangents and below the spine's rounded edge. The root remains Y−6.2..5.4 mm. A curved 9.3 mm-radius relief preserves the nominal 9 mm nut-turning envelope. It does not restore the deep tray or a cover.

The measured section immediately below the mounting plate remains approximately **67 mm²**, versus the earlier 17.4 mm² neck. This is a geometric section comparison, **not a strength multiplier**. See `review/mount-reinforcement.json` for dimensions and volume. Screw/nut designs, plunger and cap rail are unchanged; the mounting features are repositioned as described below. Strength and printed fit remain unqualified.

### Common flat back for printing

The user approved offsetting the mount rather than simply cutting off the right-hand green projection. A direct flush cut would leave only 1 mm beside the bore. The plate is Y−14.4..5.4; the bore is at Y−4.4. This preserves **5.4 mm of material between the 8.8 mm bore and the flat back**. The opposite projection remains to carry the screw load. The rail screw/nut shift with the bore; the phone, plunger and rail do not move. The former locating lugs are now removed.

The bracket's maximum Y is 5.4 mm, shared by the plate and spine. The existing −90° X export orientation now puts this common back on the bed, rather than holding the spine 4.6 mm above it. Print the bracket separately, not with the axle/key or other assembled parts attached. This geometry does not eliminate every overhang: pulley cheeks, guide lips and the key pocket still need support/removal review. The matched offline Normal Snug reference comparison is in `review/flat-back-slice/comparison.json`; it is not a print authorization or a qualified PLA+ job.

The matched A1 mini / Generic PLA reference slice estimates support at **2.73 → 0.90 g (about 67% less)** and total filament at **10.75 → 9.09 g (about 15% less)**, using 0.2 mm layers, 3 walls and 15% gyroid. Broad underside support is removed; local pulley, key-pocket and guide support remains. The saved 3MFs, resolved profiles, hashes and layer previews document the comparison. Reduced support mass is not proof of clean removal, surface quality or print strength.

### Mount and collar

- User-selected **Option A**: the 120 mm rail has two coplanar slotted wings and a solid middle. The offset bridge and its ribs are gone. Wings, cap exterior and ear faces share X12; rail thickness is 6 mm.
- A direct inward translation at the former Z−14 station collided with the pulley and frame. The flush crossbar instead sits at the cap end, Z16..36, with screw centers at Z26 (40 mm above the old station). The collar mating length and all four collar fastener stations are unchanged. This placement adaptation is explicit, not an exact translation of the earlier mount.
- The actuator uses **one screw and nut**, through a closed 8.8 mm bore in a 19.8 mm-wide mounting bar, offset 4.4 mm from the plunger centerline. The rail locating lugs are removed. Screw preload and friction must prevent sliding and rotation; tightened play and stiffness are not measured. The plunger, pulley, shoe and existing phone proxy positions are unchanged.
- To remove the module: remove the phone and release twine tension, remove the nut toward +X and screw toward −X, pull the module outward 4.5 mm, lower it 2 mm along −Z, then continue outward. This is the conservative sampled clearance path, not a claim that locating lugs still need disengagement. Do not use the former two-fastener/open-top-seat sequence. See the sampled service report.
- Wing slot endpoint centers are Y±18.5 and ±54. Screws cannot cross the solid center. The outer-face-down cap export puts wings and the cap on a common bed plane, but support reduction has not been measured in a slicer.
- The cap is unchanged from the flush-T revision: 37,638.67 mm³. Current bracket volume is recorded in `review/plunger-integration.json`. These are solid volumes, not sliced filament use or measured support savings.
- The neck opening remains 11.6 × 17.6 mm; collar length remains 102 mm.
- Both collar halves have narrower, thicker ears: screw stations (Y,Z)=(±15.5,−30/−76), 46 mm axial spacing. Ear radius is 9 mm, versus the earlier 10 mm at Y±25.
- Four **new long-grip collar screws** keep the successful 8×3 profile and 14 mm head, but use a 32 mm threaded span and flush tip. The original screw length is too short for these ears. One original screw secures the rail; all five nuts retain the successful profile. Longer screws are not physically qualified.
- Nut-clearance reliefs and bolt passages are cut after the carrier webs so the webs cannot obstruct fasteners.
- The nearest dual shaft guide now has eyes at Y±28, still 8 mm bores with flared mouths. The two lower centered guides and their stations are unchanged.

### Pulley retention

A smooth 8 mm headed axle is supported by two cheeks; the wheel has an 8.6 mm bore and 0.8 mm total axial running clearance. A removable cross-key blocks axial withdrawal. A separate small keeper band encircles the key and axle to resist key drift. There is **no pulley nut** and no thin snap finger.

The axle head and key are geometric retention features, not proof of loaded strength. The band is not a substitute for the key and is not fail-safe: loss, wear or excessive stretch of the keeper band must be checked. Remove the band and cross-key before withdrawing the axle. The axle-end ligament is 2.2 mm; cross-key fit has 0.2 mm clearance per side. New parts need a physical fit/retention trial.

The selected compact study is now active: axle span is **18.4 mm instead of 23 mm**, with a recessed 1.6 mm head and shorter rear cross-key. The front bearing land is 2 mm, rear land 4 mm. Remove the key along local −Z, then the axle along −Y, off the grabber. The 1.2 mm keeper-band envelope is schematic, not a specified real band size. Thinner-head strength and bearing wear are untested.

The earlier centered-mount study's Y±24 mm rigid limit does **not** carry over unchanged to the offset mount. Current slot position equals plunger center Y−4.4 mm, so the available travel is asymmetric. All original phone examples retain their dimensions and positions. Consult `review/compact-keyed-plunger.json` for current sampled mount and cord clearances. Clamping is essential and no zero-wiggle claim is made. The old locating-key rotation test is removed from the active audit because those lugs no longer exist.

The outgoing cord is unchanged: near-side centers +24 through +28 mm intersect the carrier; +29 mm clears. The former far-side −24 mm candidate is no longer usable because the longer axle intersects the carrier. These are sampled clearances, not a continuous or tolerance-qualified reach range. Additional inward gain still needs a geometry refinement before use.

Generic threaded fasteners can self-loosen under dynamic loading; this does not predict failure of a particular printed nut. The original free-nut arrangement was not validated. Background: [Nord-Lock explanation](https://www.nord-lock.com/learnings/knowledge/2018/why-do-bolts-loosen/); [igus clevis retention examples](https://www.igus.com/igubal/clevis-joints). These sources do not qualify the printed design.

### Pre-integration jaw requirements (superseded contact lips)

T-jaw contacts are 100 mm apart, with 8 mm pads, 6 mm contact walls, 108 mm overall span, 4 mm retaining lips and a 14 mm pocket. Empty closure is X−66.5 with a 48.5 mm tongue. Each jaw has one broad angular band cleat. The actual 18 mm wallet and 20 mm large-phone proxies remain incompatible with the requested 14 mm pocket; they were not shrunk to pass checks.

## Checks and limits

- `review/validation.json`: eight phone/side configurations, rigid intersections, nominal 0.65 mm plunger sweep, neck/fastener and orthographic screen checks.
- `review/plunger-integration.json`: band/cord envelopes, direct downstream routing, and part volumes.
- `review/service-access.json`: nut/screw removal and conservative complete-module outward/lower/withdraw sequence, including Y±28.5 mm; off-tool axle/key paths and geometric retention obstructions.
- `review/compact-keyed-plunger.json`: active inward-position and routing audit (historical filename). No rail locating-key rotation test remains. Earlier concept reports remain historical evidence, not current generators.
- `review/flush-t-cap.json`: common plane, solid center, wing slots and material-volume comparison.
- `review/fixed-mount.json`: seated mount and button-height envelope coverage.
- `review/mount-reinforcement.json`: mounting-foot section and solid-volume comparison; no structural strength claim.
- `review/print-cleanup.json`: uniform shoe/root and key thickness, cleared tab region, flush rear-cheek fill, longer axle and key-to-back gap, unchanged screw thread/head stations.
- `print/manifest.json`: valid bed-oriented manufacturing exports, not approved toolpaths.

The animation prescribes 0.35 mm gap plus 0.30 mm nominal button depression; it does not model forces or a phone-safe mechanical stop. The separate inline band between two twine sections can provide compliance, but its stiffness, preload, maximum extension and resulting button force are unknown. The small return band does not establish overtravel safety.

The earlier actuator plate was printed according to the user; the newly revised bracket/plunger have not been printed and no new print is authorized. New collar closure, long screws, pulley friction/fleet angle, key/band retention, adjacent-button clearance, case interference, support residue, jaw strength, real camera framing and revised assembly fit require physical checks. CAD collision clearance is not structural qualification.

## Files and boundaries

`source/plunger_design.py` owns the actuator; `source/model.py` owns the harness; `source/cuff_design.py` and `source/shared_key_design.py` own the shared cuff/key geometry. `source/build.py` regenerates the viewer meshes, STEP, BOM and provisional manufacturing exports. Current BOM: **14 printed designs, 27 pieces, 8 bands, 2 twine sections, no metal hardware**. The viewer contains 40 staged assembly states, not continuous insertion animations.

V1 and V2 remain unchanged. Historical rocker reports and helper checks do not validate this plunger revision; earlier geometry is recoverable through Git, not duplicate source snapshots. Existing V2 print-job files retain the geometry and outcomes actually recorded.


### Diamond-slot axle review — 2026-10-30

User reports the upper section above the square key hole failed to print. This supersedes the earlier support-disabled bridge assumption; the cause is suspected, not proven. The isolated `review/concepts/diamond-axle/` candidate rotates the 3.4 mm square passage and existing TPU key 45 degrees. It moves the passage 2 mm outboard for bracket clearance and extends the tip 2.704 mm, preserving 2.2 mm end ligament. Head and bearing interface are unchanged. Seated key interference is zero; ideal compressed insertion and relaxed retention checks pass. Keeper-band fit, real spring-back and roof quality remain physical checks. Active assembly is unchanged pending review.

PETG axle-only slice `print/jobs/2026-10-30-diamond-axle-petg/`: automatic normal supports enabled, zero support/interface paths, 1.100 g total and 38.06 minutes at 0.12 mm layers. No warnings. No print sent; user explicitly requires approval first.


### October 30 physical review and active promotion

`verified-diamond-axle-v3` promotes the successfully printed diamond axle and 45-degree key placement. The user confirms key fit. The unchanged TPU key keeps its original flat manufacturing orientation. Fixed-jaw end strips are trimmed to match the shaft-cap end planes at Z -38.5 and 68.5; the user explicitly waives reprinting this visual refinement for V3 verification. See `review/physical-assessment-2026-10-30.json` for approvals and rejected parts. All eight mechanical assembly checks pass; existing phone-envelope conflicts remain. Historical sliced plates remain unchanged.


### Smaller plug-in TPU clip proposal — October 30

`review/concepts/plug-clip/` has a 12.8 x 17.8 mm nominal frame opening, 6 mm flat extrusion, reversible 4 mm eye and integral tapered plug/socket outside the neck. Open pose is one valid printable solid. Closed pose is schematic tongue extension, not elastic validation. External latch sits beyond nominal frame; continuous contact and closing force are not established. Automatic-support TPU slice generates no support/interface paths (1.402 g,28.22 minutes). Source `study_plug_clip.py`; immutable preview `print/jobs/2026-10-30-plug-clip-tpu`. Kept as an unprinted review design pending fit; user explicitly declines printing now.

### Square press-stud clip review — October 30

User rejected the earlier tapered in-plane plug and selected option A: a square peg through a square hole in slightly overlapping TPU tabs. `review/concepts/square-clip/` contains the one-piece open print geometry and a separate seated latch detail. Nominal frame opening12.8 ×17.8 mm, eye4 mm, square stem2.6 mm, hole3 mm, lip3.4 mm, tab thickness1.8 mm. The lip grows at45 degrees. Valid single solid; rigid seated end geometry has zero intersection. This does not validate wrapping, closing force, retention or creep. Active V3 guide remains unchanged pending review. User explicitly requests no print.

The later seamless-band refinement supersedes the paddle tabs: both arms use the6 mm band width and1.6 mm wall; upper arm prints35° outward and flexes inward for4.8 mm overlap. The lower peg has a35° underside ramp. Closed pose is an illustrative arm rotation, not elastic analysis. Default automatic supports add0.0068 g under the square roof. A rotated-square trial increased support and was rejected; retained source uses square faces.

Final review geometry `angled-arm-peaked-roof-clip-v3` keeps the user-requested angled arm and uniform6 mm band. A55° peaked receiving roof and matching peg chamfers remove the remaining support. Job `2026-10-30-angled-clip-peaked-roof-tpu`: automatic normal supports enabled, bridge_no_support=0, zero support/interface paths,1.1793 g total,24.72 minutes, no warnings. A1 mini0.4 mm nozzle/0.12 mm layers, saved ELEGOO TPU95A230°C/35°C recipe. G-code MD5 ed2a46692892c044462b2ba2e6365fc9. No printer contacted. Closed pose remains illustrative; no physical bending/retention validation. Ask about support-free roof/peg quality if this design is printed later.

User requested a straight manufactured arm from the circular root, without the dogleg. `straight-arm-peaked-roof-clip-v3` replaces only the open arm with a straight1.6×6 mm section at35°. Closed display schematically bends it to the overlap; it is not a physical deformation result. New immutable job `2026-10-30-straight-arm-clip-tpu` confirms zero support/interface paths with automatic supports on and bridge suppression off:1.1699 g/24.79 minutes, no warnings. No print.

Simplified triangular closure study `straight-arm-triangle-clip-v3` replaces the house-shaped opening and peg with triangular profiles and a small retaining ridge, keeping the straight35° printed arm. Hole base3 mm, sides60° from bed; peg2.3 mm wide, ridge3.1 mm wide. Job `2026-10-30-triangle-clip-tpu`: zero support/interface paths with automatic supports on/bridge suppression off,1.1693 g/24.45 minutes, no warnings. Seated CAD fit is clear; flexible retention and print quality remain unverified. No print sent.

User rejected the triangle and requested a square focus, emphasizing TPU flexibility. `straight-arm-chamfered-square-clip-v3` uses3 mm square envelope with small upper corner chamfers,2.6 mm peg and3.2 mm retaining lip intended to flex through. Straight arm preserved. Job `2026-10-30-chamfered-square-clip-tpu` generates0.0036 g support +0.0018 g interface,1.1757 g total/24.91 minutes. It is NOT support-free; do not reuse the triangle's zero-support claim. No print.


User requires absolutely zero supports and prefers square closure faces. `flat-arm-square-clip-v3` prints the straight receiver arm flat (6 mm wide × 1.6 mm thick), with a vertical 3 mm square through-hole. Assembly requires a 90° twist and inward bending; closed display remains schematic, not an elastic simulation. Square peg retains its 35° underside ramp. Job `2026-10-30-flat-arm-square-clip-tpu` confirms zero support/interface paths with automatic supports enabled and bridge suppression off: 1.17972 g / 24.746 minutes, no warnings. Valid single CAD solid and zero seated latch intersection. Fit, twist force, retention and creep untested. Review only; active guide unchanged. No printer contacted.


### Bend-only closure pair — October 30

User rejected the quarter-twist receiver and requested both agreed mechanisms. `review/concepts/closure-pair/` shows A square press-stud (3 mm hole, 2.6 mm peg, 3.2 mm lip) and B tongue/6 mm short sleeve with release window. Both developed straps print flat, then bend without axial twisting; band6×1.6 mm, developed length73.6 mm targets12.8×17.8 mm inside with6 mm overlap. Real bend radius and stretch may require length adjustment. Single4 mm reversible eye. Both valid single solids; exact seated end sections have zero intersection. No active guide promotion or print. First B roof generated0.0212 g support/interface; revised peaked internal roof retains rectangular outer sleeve. Job `2026-10-30-bend-only-closures-roof-tpu`: auto supports enabled, bridge suppression off; zero support/interface for both. Model-only deposited A0.9326 g, B1.1121 g; whole plate2.11552 g /36.36 min, no warnings. Insertion, wrapping, retention and creep remain untested.


### Form-fitting square snap — October 30

User requests original C body12.8×17.8 mm opening with option A closure, superseding the developed flat straps. `review/concepts/formfit-square-clip/` retains1.6 mm walls,6 mm depth and4 mm eye. Local closure ends lie outside the neck in6×1.6 mm tabs; receiver prints55° splayed outward then bends inward and lifts1.8 mm to overlap by6 mm, with no twist. Hole3 mm, peg2.6 mm, lip3.2 mm. Valid single solid and zero seated latch intersection. Closed view is schematic bending, not elastic validation. Job `2026-10-30-formfit-square-snap-tpu`: automatic supports on, bridge suppression off; zero support/interface paths,1.18838 g /24.59 min. No warnings. No print or active guide promotion; bending force, fit, retention and creep remain untested.


October30: user rejects changed arm planes and asks to reproduce the previous straight-arm screenshot. `review/concepts/straight-arm-clip/` restores the exact immutable `2026-10-30-straight-arm-clip-tpu/clip-source.stl`, with original35° straight arm,6 mm band/1.6 mm wall and12.8×17.8 opening. Existing peaked stud/hole unchanged; future scope restricted to their fit. Historical auto-support slice remains applicable because mesh is byte-identical: zero supports,1.1699 g/24.79 min. No print.


### 45-degree clip roof and matched stud — October30

User selected45° from bed after isolated45/35° roof trials generated zero support. `source/study_clip_roof45_fit.py` makes only local edits to exact restored straight-arm mesh: hole apex lowered from5.4422 to4.8 mm (roof rise2.1422→1.5 mm), upper stem shoulders trimmed to clear it. Body/arm coordinates outside those local vertices are unchanged. Original retaining lip and35° underside retained, avoiding support introduced by the earlier global stud-height scaling trial. Watertight mesh, nominal minimum stem-to-roof clearance0.35 mm. No physical fit claim. `review/concepts/straight-arm-clip-45/` is current review. Job `2026-10-30-clip-roof45-fit-tpu` confirms zero support/interface with automatic support on/bridge suppression off:1.17004 g/24.76 min, no warnings. No print or active-guide promotion.


October30 approval update: user approves the `straight-arm-roof45-fit-v1` clip guide design. This revised guide remains unprinted; approval does not establish physical fit or retention. Actuator bracket and sliding plunger remain not approved. See `review/physical-assessment-2026-10-30.json`.


October30 viewer promotion `approved-square-clip-v3`: approved45° clip replaces the old guide in BOM mesh and all eight assembly scenes. Source guide loads the exact approved mesh as a valid faceted CAD solid for future builds. Guide eye routing updated15.2→13.3 mm. BOM shows design approval and unprinted status; bracket/plunger remain not approved. Assembly shows open print pose. Viewer-only refresh leaves historical print jobs and assembly STEP unchanged; STEP link is labeled older clip. Reproduce via `source/promote_clip_viewer.py`.


### Triangular plunger interpretations — October30

User requests smaller bracket/plunger with triangular neck in an open-top triangular guide, retaining a continuous path for the raised tail handle. `review/concepts/triangular-plunger/` presents schematic A point-down V cradle (not lift-retaining), B point-up captured triangle with apex slot, and C captured diamond with top slot. User will select before CAD regeneration. Proposed end-face printing remains unsliced; zero supports mandatory. Current V3 bracket/plunger unchanged and not approved. Paired existing meshes are available in `current.html`.


### B/C curved-foot candidates — October30

User keeps both B and C undecided and requires existing curved button foot with a support-free transition. `source/study_triangular_foot.py` preserves the exact prior foot through concept v1.8 mm (symmetric difference0), then smoothly lofts to triangular B or diamond C neck byv10. Both valid single solids; sampled ±1.5 mm sliding positions have zero overlap with28 mm slotted guides. Ramped tail handle preserves longitudinal slot passage. These are isolated guide/plunger candidates: mount, pulley support, return anchor and end stop remain to integrate. No active V3 replacement. PETG job `2026-10-30-triangular-foot-petg` verifies zero support/interface on all four pieces with automatic supports enabled, end-face orientation,0.12 mm layers. Model-only mass B3.5403 g versus C5.2529 g, excluding purge. No physical sliding/strength/adhesion qualification or print. Viewer: `review/concepts/triangular-foot/`.


### Selected B actuator with shared tail cleat — October 30

User selected captured triangular B and confirmed a 1 mm-thick return band and 1 mm string. `review/concepts/triangle-tail-flat/` integrates the guide with the existing mount, pulley interface, return anchor and rear stop, keeping the exact curved foot and upper shared cleat. Band width remains provisional at 3 mm. Preserve the opposing loads: band loops back to the fixed anchor; string wraps the tail above the band and leads tangentially toward the pulley. This remains a review candidate; active V3 bracket/plunger are not replaced or approved.

The guide has 0.4 mm normal clearance on both triangular faces and a 2.4 mm apex slot. Narrow the cleat base to 1.6 mm so it can enter from the foot end, then flare it above the guide. Fit band/string after insertion. Retain the rear return stop; it is not a safe button press limit. Seven nominal ±1.5 mm motion samples clear the bracket for the plunger, band envelope, 1 mm string, 3 mm knot envelope and pulley approach; six insertion samples clear. The final plunger only removes material from that checked wrap geometry. New guide additions stay below w8 and ahead of the wraps. Nominal paths are not elastic/slack simulations or physical proof against snagging.

Flat printing requires a bed-reaching guide floor and a tangent 45° roof above the mount's unchanged 8.8 mm circular screw clearance. New immutable job `2026-10-30-triangle-tail-clearance-petg` has automatic Normal Snug supports enabled and bridge suppression off: **zero support/interface paths**, 8.7677 g total / 70.68 min; model-only bracket 7.2659 g and plunger 1.4304 g. Exact source hashes match the shown meshes. Earlier end-on and round-roof slices are retained as failed support comparisons. No printer contacted. Source: `study_triangle_tail.py`, `refine_triangle_tail.py`, `slice_triangle_tail_flat.py`, `check_triangle_routes.py`. Live fit, band width, knot size, retention, strength, friction, button force and the pre-existing outgoing-string/jaw conflict remain unqualified.

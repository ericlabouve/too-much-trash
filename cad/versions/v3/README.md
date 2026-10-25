# V3 — removable rounded cuffs and guided plunger

Viewer controls (October 25): select a BOM model or row, then use **Hide other items / Show all items** inside the viewport (also available fullscreen). Isolation follows a newly selected row and resets when changing views or using Show all. Cube arrow buttons rotate 90° per click; dragging remains continuous without an additional release step. Geometry and print exports are unchanged by this UI revision.

Viewer layout (October 25): the main 3D viewport spans the page width. Descriptions, warnings, actuator close-up and audit links are below it. Use **Full screen** at the lower right of the view; exit with the button or Escape. Embedded browsers that block native fullscreen use an expanded in-app view. CAD and print files are unchanged by this UI update.

## Current review revision — deep-groove-pulley-v3 (2026-10-25)

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

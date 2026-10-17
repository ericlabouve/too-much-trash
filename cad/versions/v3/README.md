# V3 — removable rounded cuffs and guided plunger

## Current review revision (2026-10-16)

**New design direction (October 17):** the user revoked the 16 mm fixed-cuff offset and the 40 mm width that crowds the volume buttons. Current C in `review/concepts/phone-clamps/centered-wide-cuff/` limits the fixed cuff to 21.6 mm, leaves its attachment unresolved, and retains one crossed-T assembly on each opposite cuff. All three concept cuffs are now the same 21.6 mm part, including the T opening. The current production assembly remains the comparison baseline, not the approved final jaw layout. No concept has been promoted to manufacturing.

**Next validation:** `review/concepts/phone-clamps/centered-wide-cuff/fixed-retention.html` compares an integral T-stud and a short removable T with the shared sideways keeper. Both remain unselected. Await ELEGOO TPU 95A to validate compliant installation and retention; PETG fit success does not qualify TPU grip. Do not force the PETG cuff over the integral stud. No new print is authorized by this checkpoint.

`integrated-cuffs-v3` integrates the user-approved enlarged cuff without changing its shape or key openings. Three identical 12 mm-wide cuffs replace the hard contact lips: two on the sliding jaw at Y±50 mm, one on the fixed jaw at **Y+16 mm**, explicitly approved to clear the shared key tip from the stock neck. Sliding sockets sit 0.3 mm outward so the enlarged return tips clear the existing camera-module proxy. Overall contact span is now 112 mm. The 48.5 mm tongue, X−66.5 empty closure, 100 mm contact spacing, closing cleats and shaft-cap geometry remain unchanged.

`source/cuff_design.py` owns the approved 1.2× C curves/seats, 1.7 mm flat-backed head shoulder, 3.4 mm stem passage and 7.4×3.4 mm head recess. `source/shared_key_design.py` owns **one 12.2 mm T-key** used four times: three cuffs and the pulley axle. It retains the 7 mm-wide head and 3 mm stem/thickness, with the approved 1.2 mm head depth. No second cuff-specific key, TPU T, friction ribs or hidden latch is added. The actuator bracket, plunger, wheel and axle shapes are unchanged; only its key adopts the shared candidate. The axle keeper band remains.

The fixed carrier and sliding jaw have integral sockets and recessed former hard lips, not cuffs stacked inside the old pocket. Cuffs are cyan in the viewer to distinguish intended **ELEGOO TPU 95A** from rigid parts; current physical approval is for the PETG cuff shape only. New sockets/jaws are unprinted. The nominal rear return opening is 13.44 mm; curved seats reduce it locally. Original phone dimensions and placement remain unchanged: undeformed cuff/phone overlaps are explicitly reported, including the incompatible 18/20 mm examples. No TPU compression or loaded grip is simulated, and thin-phone seating is not qualified.

**Service prerequisite:** remove the phone, release twine tension, loosen the rail nut, then slide the supported actuator toward the outer end of its existing wing to screw-center Y+50 (near) or Y−50 (far) before removing nut/screw. Do not cross the solid rail center. The former straight screw withdrawal can hit the new fixed socket/cuff. See current `review/service-access.json` for sampled-path results; these are not ergonomic or force tests.

`review/cuff-integration.json` records approved-shape equivalence, unchanged openings, cuff/key removal, neck/camera/assumed-screen clearance and complete jaw travel. `review/validation.json` retains all eight phone-fit results separately from rigid assembly checks. `review/plunger-integration.json` retains the known outgoing-cord/carrier conflicts; this change does not resolve routing. Manufacturing exports and 40 staged assembly views include **14 printed designs / 27 pieces**. No new slicing or print was requested for the integrated jaws. Preserve every historical print job and V1/V2 unchanged.

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

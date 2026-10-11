# V3 — blended reinforcement and flat-back offset mount

## Current review revision (2026-10-09)

The plunger replaces the rocker. All actuator-bracket twine holes and the projecting lower base are removed: the cord runs from the pulley directly to the nearest shaft guide. No extra unsupported zig-zag waypoints are used. The rounded plunger shoe, curved root and shared capped band/twine cleat are retained.

### Reinforced mounting junction

Revision `flat-back-mount-v3` retains the reinforced joint and smooths the highlighted end: the haunch now eases into the spine in both width and height, ending at X64 with horizontal curve tangents and below the spine's rounded edge. The root remains Y−6.2..5.4 mm. A curved 9.3 mm-radius relief preserves the nominal 9 mm nut-turning envelope. It does not restore the deep tray or a cover.

The measured section immediately below the mounting plate remains approximately **67 mm²**, versus the earlier 17.4 mm² neck. This is a geometric section comparison, **not a strength multiplier**. See `review/mount-reinforcement.json` for dimensions and volume. Screw/nut designs, plunger and cap rail are unchanged; the mounting features are repositioned as described below. Strength and printed fit remain unqualified.

### Common flat back for printing

The user approved offsetting the mount rather than simply cutting off the right-hand green projection. A direct flush cut would leave only 1 mm beside the bore and truncate a locating lug. The plate is now Y−14.4..5.4; the bore and full 16 mm locating-lug envelope move to Y−4.4. This preserves **5.4 mm of material between the 8.8 mm bore and the flat back**. The opposite projection remains to carry the screw and lug loads. The rail screw/nut shift with the bore; the phone, plunger and rail do not move.

The bracket's maximum Y is 5.4 mm, shared by the plate and spine. The existing −90° X export orientation now puts this common back on the bed, rather than holding the spine 4.6 mm above it. Print the bracket separately, not with the axle/key or other assembled parts attached. This geometry does not eliminate every overhang: pulley cheeks, guide lips and the key pocket still need support/removal review. The matched offline Normal Snug reference comparison is in `review/flat-back-slice/comparison.json`; it is not a print authorization or a qualified PLA+ job.

The matched A1 mini / Generic PLA reference slice estimates support at **2.73 → 0.90 g (about 67% less)** and total filament at **10.75 → 9.09 g (about 15% less)**, using 0.2 mm layers, 3 walls and 15% gyroid. Broad underside support is removed; local pulley, key-pocket and guide support remains. The saved 3MFs, resolved profiles, hashes and layer previews document the comparison. Reduced support mass is not proof of clean removal, surface quality or print strength.

### Mount and collar

- User-selected **Option A**: the 120 mm rail has two coplanar slotted wings and a solid middle. The offset bridge and its ribs are gone. Wings, cap exterior and ear faces share X12; rail thickness is 6 mm.
- A direct inward translation at the former Z−14 station collided with the pulley and frame. The flush crossbar instead sits at the cap end, Z16..36, with screw centers at Z26 (40 mm above the old station). The collar mating length and all four collar fastener stations are unchanged. This placement adaptation is explicit, not an exact translation of the earlier mount.
- The actuator uses **one screw and nut**, through a closed 8.8 mm bore in a 19.8 mm-wide mounting bar, offset 4.4 mm from the plunger centerline. Two integral locating lugs engage 4 mm into the slot; their combined envelope is 16 mm long × 8.2 mm wide in the 8.8 mm slot. Screw preload must prevent sliding. Nominal lug clearance is 0.3 mm per side; tightened play and stiffness are not measured. The plunger, pulley, shoe and existing phone proxy positions are unchanged.
- To remove the module: remove the phone and release twine tension, remove the nut toward +X and screw toward −X, pull the module outward 4.5 mm to disengage the lugs, lower it 2 mm along −Z, then continue outward. Do not use the former two-fastener/open-top-seat sequence. See the sampled service report.
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

The earlier centered-mount study's Y±24 mm rigid limit does **not** carry over unchanged to the offset mount. Current slot position equals plunger center Y−4.4 mm, so the available travel is asymmetric. All original phone examples retain their dimensions and positions. Consult `review/compact-keyed-plunger.json` for current sampled mount and cord clearances. Clamping is essential and no zero-wiggle claim is made; the isolated mid-wing locating-key test is not tightened assembly play.

The outgoing cord is unchanged: near-side centers +24 through +28 mm intersect the carrier; +29 mm clears. Far-side −24 mm remains a tested candidate. These are sampled clearances, not a continuous or tolerance-qualified reach range. The near-side inward gain still needs a routing/geometry refinement before use.

Generic threaded fasteners can self-loosen under dynamic loading; this does not predict failure of a particular printed nut. The original free-nut arrangement was not validated. Background: [Nord-Lock explanation](https://www.nord-lock.com/learnings/knowledge/2018/why-do-bolts-loosen/); [igus clevis retention examples](https://www.igus.com/igubal/clevis-joints). These sources do not qualify the printed design.

### Preserved jaw requirements

T-jaw contacts are 100 mm apart, with 8 mm pads, 6 mm contact walls, 108 mm overall span, 4 mm retaining lips and a 14 mm pocket. Empty closure is X−66.5 with a 48.5 mm tongue. Each jaw has one broad angular band cleat. The actual 18 mm wallet and 20 mm large-phone proxies remain incompatible with the requested 14 mm pocket; they were not shrunk to pass checks.

## Checks and limits

- `review/validation.json`: eight phone/side configurations, rigid intersections, nominal 0.65 mm plunger sweep, neck/fastener and orthographic screen checks.
- `review/plunger-integration.json`: band/cord envelopes, direct downstream routing, and part volumes.
- `review/service-access.json`: nut/screw removal, lug disengagement and complete-module lower/withdraw sequence, including Y±28.5 mm; off-tool axle/key paths and geometric retention obstructions.
- `review/compact-keyed-plunger.json`: active inward-position and locating-key audit. Earlier concept reports remain historical evidence, not current generators.
- `review/flush-t-cap.json`: common plane, solid center, wing slots and material-volume comparison.
- `review/fixed-mount.json`: seated mount and button-height envelope coverage.
- `review/mount-reinforcement.json`: mounting-foot section and solid-volume comparison; no structural strength claim.
- `print/manifest.json`: valid bed-oriented manufacturing exports, not approved toolpaths.

The animation prescribes 0.35 mm gap plus 0.30 mm nominal button depression; it does not model forces or a phone-safe mechanical stop. The separate inline band between two twine sections can provide compliance, but its stiffness, preload, maximum extension and resulting button force are unknown. The small return band does not establish overtravel safety.

No V3 print is authorized or has been sent. New collar closure, long screws, pulley friction/fleet angle, key/band retention, adjacent-button clearance, case interference, support residue, jaw strength, real camera framing and printed assembly fit require physical checks. CAD collision clearance is not structural qualification.

## Files and boundaries

`source/plunger_design.py` owns the actuator; `source/model.py` owns the harness; `source/build.py` regenerates the viewer meshes, STEP, BOM and provisional manufacturing exports. Current BOM: **13 printed designs, 21 pieces, 8 bands, 2 twine sections, no metal hardware**. The viewer contains 34 staged assembly states, not continuous insertion animations.

V1 and V2 remain unchanged. Historical rocker reports and helper checks do not validate this plunger revision; earlier geometry is recoverable through Git, not duplicate source snapshots. Existing V2 print-job files retain the geometry and outcomes actually recorded.

# Version 2 — adjustable band-clamped phone mount

This PLA/PLA+ fit prototype replaces the dedicated cradle with opposing hard jaws and a sliding track inspired by V1. Two rubber bands behind the phone close the jaws. There is no padding, metal hardware, adhesive, TPU or additional string strap. Eight printed designs make thirteen pieces; one continuous twine length and nine rubber bands complete the starting BOM. Restoring adjustment increases printed piece count compared with the earlier dedicated concept.

Open [the viewer](../../viewer.html?version=v2). V1 and the [earlier dedicated V2](archive/dedicated-r1/viewer.html) remain available in the version selector. V1's checkpoint is `printed-prototype-checkpoint` (`ade5b54b246ed41e6fefb4f4fcfecef211164ca3`). Original V1 CAD, manufacturing files, hardware BOM and concept renders are unchanged.

## What adjusts

- **Phone width:** the far jaw slides in the carrier track. Two rear bands pull it toward the fixed jaw. The modeled width range is 66–86 mm. Hard rear ledges provide a datum; small front lips retain the thickest modeled envelope. Thin phones have more clearance at these lips, so this is not positive retention in every direction. Grip and resistance to sliding along the phone depend on actual contact and band preload.
- **Either button side:** both jaws carry the same slotted rail interface. Move the same bracket, rocker and contact screw to the other rail and reverse the module; no mirrored print set is required. The far-side actuator follows the sliding jaw. Both string routes remain behind the phone, with the screen open.
- **Position along the phone:** loosen the two printed rail nuts and slide the actuator to the button. The checked button centers are 29–65 mm toward the camera end from the middle gripping band. This is a checked envelope, not universal phone compatibility.
- **Button depth:** vertical slots in the bracket allow movement across the phone's thickness. Four envelopes are displayed: wallet 76 × 152 × 18, illustrative bare 76 × 152 × 8, small 66 × 140 × 7.5, large 86 × 170 × 20 mm. Only the wallet dimensions came from the measured case; the others are geometric examples. Camera protrusions and unusual cases require separate review.
- **Fine contact gap:** the third printed screw is the rocker’s hard button contact. A nominal 8 mm major diameter, 2 mm pitch coarse thread advances 0.125 mm per 1/16 turn geometrically; this is not a printed accuracy claim. Set a small released gap, then check release and the stop with the actual mechanism. It is a pivoting contact, not a guided linear piston. Do not preload the phone button merely to compensate for a loose clamp.

The open U-saddle borrows the accepted 11.6 × 17.6 mm cutout, but its rubber-band closure is **new and unvalidated**, unlike the accepted V1 bolted collar. The historical 14 × 19 mm shaft proxy still overlaps the smaller opening; that discrepancy is excluded explicitly from clearance checks. V1's successful prints need no reprint for V1.

## Assembly and motion

Slide the moving jaw into the open track end. Fit two jaw-closing bands onto the paired rear mushroom hooks. Fit two bands in the carrier saddle lanes and one at each of three shaft guides. The bands described by the user as roughly 2–3 cm radius have no measured force specification; wrapping, installed span and preload must be fitted to the actual bands.

Assemble the actuator **off the rail first**. Insert the printed pivot key through the bearing/keyways, rotate its cross-lug and seat its indexed head. Check that it cannot migrate back to the insertion angle. Then clamp the completed actuator to the chosen rail with two printed screws/nuts. Pivot insertion/turning in the installed far-side assembly can hit the carrier track; remove the module before servicing its pivot. Thread the contact screw into the rocker; all three screws use the same print design. Fit the return band between the rocker hook and a fixed hook that gives reliable release.

Tie one end of the continuous twine to the rocker eye. Route it through the bracket's closed upper eye, carrier crossover eye and three shaft guides. Tie the lower end to the overtravel band around the moving black trigger. No pulley, gear, cable housing or metal cable stop is required in this first arrangement. Smooth eye surfaces and remove support remnants; actual twine diameter/fuzz and drag are not known. A 2 mm line is illustrative, not a measured input.

The **Lever stroke** slider and **Animate squeeze** show squeeze, hold and release in both actuator-side configurations, with a synchronized close-up. The rocker stops after the nominal button press; continued handle motion stretches the separate trigger band. The animation conserves the modeled twine centerline length. It prescribes motion and illustrates slack take-up; it does not predict rubber-band force, twine stretch, friction or real trigger travel. The provisional 0.30 mm button travel is not a safe-force specification.

## Prototype printing

Use the bed-oriented **manufacturing STLs in `print/`**, in millimetres at **100% scale**. `review/` meshes use assembly coordinates and are not print files. The same print set serves both actuator sides and every displayed phone envelope. Individual STEP files in `print/` use the matching bed orientation.

| STL | Copies | Starting PLA+ settings | Support review |
| --- | ---: | --- | --- |
| `carrier.stl` | 1 | 5 walls, 35% infill | Supports under rear bridge, track roof and jaw ledges; remove through the open track end. |
| `sliding_jaw.stl` | 1 | 5 walls, 35% infill | Support tongue/ledges/hooks. Inspect sliding faces after removal. |
| `actuator_bracket.stl` | 1 | 5 walls, 40% infill | Support upper eye, pivot ears and return hooks. Keep bores and slots open. |
| `rocker.stl` | 1 | 5 walls, 60% infill | Thread axis vertical; support the offset arm/pivot boss. Use a 20° support threshold in the reference profile to keep the bore clear; inspect your slice. |
| `pivot_key.stl` | 1 | 6 walls, 100% infill | Head toward bed; support cross-lug. Inspect axle layer bonding. |
| `thumb_screw.stl` | 3 | 6 walls, 100% infill | Head flat on bed, no supports in threads. |
| `thumb_nut.stl` | 2 | 6 walls, 100% infill | Flat on bed, no supports. |
| `string_guide.stl` | 3 | 5 walls, 40% infill | Support eye underside/bridge where needed. |

Baseline: 0.4 mm nozzle, 0.2 mm layers. For 100% infill in Bambu Studio, select Zig-zag rather than Grid. Print **one screw and one nut first**, then check smooth hand engagement without forcing. Female thread radial clearance is 0.30 mm. Check the same screw in the rocker before printing duplicates. This is a hardware fit check, not a dummy-phone test. PLA/PLA+ threads are not equivalent to steel fasteners; hand-tighten only. No V2 part has been physically printed or qualified yet.

Support removal must leave the sliding track, eyes and bearing surfaces clear. Inspect actual sliced layers before printing the larger parts. All eight designs were sliced individually with Bambu Studio 02.07.01.62 using an **A1 / 0.4 mm / Generic PLA reference profile**, with zero slicer warnings. This is not a confirmed user printer or a qualified PLA+ preset. Sampled extrusion-layer images were inspected for bed contact, supports and open passages. The rocker uses a 20° support threshold; the default 30° generated unwanted supports inside its threaded bore. Other supported designs use 30°. See [the hash-linked slice record](print/slicer-review.json) and the per-part `*-slice-review.png` images. No G-code or machine-specific print job is supplied. Successful slicing still does not verify support removal or physical performance. No dummy-phone testing is required or claimed. Test return, stop engagement and full trigger overtravel off the phone first, then conservatively calibrate the actual phone contact. Phone grip, collar slip, thread loosening, pivot retention and band/twine wear remain unresolved physical checks.

## Reproducibility and scope of checks

From repository root: `cad/.venv/bin/python cad/versions/v2/source/build.py`. This writes only active V2 assets. `source/model.py` contains the parametric geometry; `source/build.py` is the BOM/export/check source. Do not rebuild V1 for a V2 edit or regenerate CAD for a viewer-only change.

`review/validation.json` records connected-solid checks, rigid intersections, phone/camera keepout clearance and eleven rocker positions for four phone envelopes on both sides. Printed threads are real helical geometry. Manufacturing meshes are checked for watertightness, positive volume and bed Z=0. These checks do not establish adequate force, strength, fatigue, glass safety, retention or physical fit. The wallet camera keepout is still a simplified envelope.

## Research and history

The user initially selected dedicated fit, then explicitly superseded that choice with adjustable opposing jaws and either-side actuator mounting on 2026-09-30. The first V2 remains under `archive/dedicated-r1/` with its source, review assets, BOM and working viewer.

Prior research: [Samson rope guidance](https://www.samsonrope.com/warning-statement) motivates smooth rounded guides, [Alliance band terminology](https://www.rubberband.com/about-us/common-rubber-band-terminology/) distinguishes elongation/permanent set, and [Vernier's experiment](https://www.vernier.com/vernier-ideas/elastic-hysteresis-of-a-rubber-band/) shows elastic hysteresis. These do not qualify unknown twine or bands for this assembly. The user's [printed screw example](https://makerworld.com/en/models/1055250-screw-generator-parametric-screws-nuts-washer#profileId-1042636) motivated coarse printed fasteners; its geometry was not copied. [BOSL2 threading documentation](https://github.com/BelfrySCAD/BOSL2/wiki/threading.scad) informed earlier research, not strength qualification.

## Camera-view follow-up

The [recessed rail study](studies/camera-clearance/README.md) checks moving the rails toward the handle. The current manufacturing files have not changed. Previous camera checks protected the bump envelope, not the camera field of view; the current assembly is not qualified as absent from the recorded image. The study preserves adjustment and passes mechanical clearance checks, but other raised features still need optical review.

On 2026-09-30 the user selected the recessed layout as superior to the raised-rail layout. Continue future V2 refinement from the recessed candidate. The comparison viewer defaults to that selection and preserves the raised rails for reference. This design preference does not establish optical or physical validation; manufacturing exports still describe the earlier layout.

# Version 2 — adjustable band-clamped phone mount

This recessed-rail PLA/PLA+ fit prototype replaces the dedicated cradle with opposing hard jaws and a sliding track inspired by V1. Two rubber bands behind the phone close the jaws. There is no padding, metal hardware, adhesive, TPU or additional string strap. Eight printed designs make thirteen pieces; one continuous twine length and nine rubber bands complete the starting BOM. Restoring adjustment increases printed piece count compared with the earlier dedicated concept.

Open [the viewer](../../viewer.html?version=v2); its official V2 is now the recessed layout. V1 and the [earlier dedicated V2](archive/dedicated-r1/viewer.html) remain available in the version selector. V1's checkpoint is `printed-prototype-checkpoint` (`ade5b54b246ed41e6fefb4f4fcfecef211164ca3`). Original V1 CAD, manufacturing files, hardware BOM and concept renders are unchanged.

## What adjusts

- **Phone width:** the far jaw slides in the carrier track. Two rear bands pull it toward the fixed jaw. The modeled width range is 66–86 mm. Hard rear ledges provide a datum; small front lips retain the thickest modeled envelope. Thin phones have more clearance at these lips, so this is not positive retention in every direction. Grip and resistance to sliding along the phone depend on actual contact and band preload.
- **Either button side:** both jaws carry the same slotted rail interface. Move the same bracket, rocker and contact screw to the other rail and reverse the module; no mirrored print set is required. The far-side actuator follows the sliding jaw. Both string routes remain behind the phone, with the screen open.
- **Position along the phone:** loosen the two printed rail nuts and slide the actuator to the button. The checked button centers are 29–65 mm toward the camera end from the middle gripping band. This is a checked envelope, not universal phone compatibility.
- **Button depth:** vertical slots in the bracket allow movement across the phone's thickness. Four envelopes are displayed: wallet 76 × 152 × 18, illustrative bare 76 × 152 × 8, small 66 × 140 × 7.5, large 86 × 170 × 20 mm. Only the wallet dimensions came from the measured case; the others are geometric examples. Camera protrusions and unusual cases require separate review.
- **Fine contact gap:** the third printed screw is the rocker’s hard button contact. A nominal 8 mm major diameter, 2 mm pitch coarse thread advances 0.125 mm per 1/16 turn geometrically; this is not a printed accuracy claim. Set a small released gap, then check release and the stop with the actual mechanism. It is a pivoting contact, not a guided linear piston. Do not preload the phone button merely to compensate for a loose clamp.

The open U-saddle borrows the accepted 11.6 × 17.6 mm cutout, but its rubber-band closure is **new and unvalidated**, unlike the accepted V1 bolted collar. The historical 14 × 19 mm shaft proxy still overlaps the smaller opening; that discrepancy is excluded explicitly from clearance checks. V1's successful prints need no reprint for V1.

## Assembly and motion

Slide the moving jaw into the open track end. Fit two jaw-closing bands onto the paired rear mushroom hooks. Fit two bands in the carrier saddle lanes and one at each of three shaft guides. The bands described by the user as roughly 2–3 cm radius have no measured force specification; wrapping, installed span and preload must be fitted to the actual bands.

Assemble the actuator **off the rail first**. Insert the printed pivot key through the bearing/keyways, rotate its cross-lug and seat its indexed head. Check that it cannot migrate back to the insertion angle. Then clamp the completed actuator to the chosen rail with two printed screws/nuts. Pivot insertion/turning in the installed far-side assembly can hit the carrier track; remove the module before servicing its pivot. Thread the contact screw into the rocker; all three screws use the same print design. Fit the return band between the rocker hook and the fixed return hook; choose a band/preload that gives reliable release.

The twine terminates at the 6 mm hole in the moving rocker pad, not at the pivot or contact screw. Feed the free end upward through the pad and secure it with a stopper knot above the pad, larger than the hole. The knot is accessible through the open bracket fork. Tie and inspect it before mounting the actuator on the rail; check that it cannot pull through. Knot choice, size and security depend on the actual twine. Pass it downward through the bracket's guide, around its rounded underside toward the side guide, through that guide and the neck crossover, then down the three shaft guides. Follow the viewer route for the chosen actuator side. Tie the lower end to the overtravel band around the moving black trigger. No pulley, gear, cable housing or metal cable stop is required in this first arrangement. Smooth eye surfaces and remove support remnants; actual twine diameter/fuzz and drag are not known. A 2 mm line is illustrative, not a measured input.

The **Lever stroke** slider and **Animate squeeze** show squeeze, hold and release in both actuator-side configurations, with a synchronized close-up. The rocker stops after the nominal button press; continued handle motion stretches the separate trigger band. The animation conserves the modeled twine centerline length. It prescribes motion and illustrates slack take-up; it does not predict rubber-band force, twine stretch, friction or real trigger travel. The provisional 0.30 mm button travel is not a safe-force specification.

## Prototype printing

Use the bed-oriented **manufacturing STLs in `print/`**, in millimetres at **100% scale**. `review/` meshes use assembly coordinates and are not print files. The same print set serves both actuator sides and every displayed phone envelope. Individual STEP files in `print/` use the matching bed orientation.

| STL | Copies | Starting PLA+ settings | Support review |
| --- | ---: | --- | --- |
| `carrier.stl` | 1 | 5 walls, 35% infill | Supports under rear bridge, track roof and jaw ledges; remove through the open track end. |
| `sliding_jaw.stl` | 1 | 5 walls, 35% infill | Support tongue/ledges/hooks. Inspect sliding faces after removal. |
| `actuator_bracket.stl` | 1 | 5 walls, 40% infill | Support guide lug, pivot ears and return hooks. Keep bores and slots open. |
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

## Reinforced guides and lower routing — reinforced-r4

The active V2 uses solid D-shaped lugs: a flat attachment side, a semicircular exposed end and a circular **8 mm through-hole**. Both entrances flare to **11 mm**. The lug is **6 mm thick**, with a nominal **5 mm radial wall at the straight bore**, reduced at the flared and rounded edges. This replaces the former 6 mm bore / 3 mm round-section eyes. The rocker tie hole is separate: 6 mm diameter in a 14 mm diameter, 6 mm thick pad. These dimensions improve access and add material; strength remains untested.

The user's twine diameter and fuzz remain unmeasured. Passage checks provisionally use **3 mm twine**; the viewer displays 2 mm. Remove support remnants and smooth the bores before threading. Thread a free end, not a pre-tied knot. The guides are captive once threaded; no snap-open slit is introduced.

The input arm now pulls downward toward the handle, with its return band above it. The string wraps under the first guide, then crosses behind the phone through supported side and neck guides. The neck support is outside the outgoing passage. Jaw-band hooks move away from the camera region. Rails move a further 20 mm toward the handle compared with recessed-r3. These changes preserve either-side mounting and the BOM count, but change six printable designs: carrier, sliding jaw, actuator bracket, rocker, pivot key and shaft guide. The printed screw and nut designs are unchanged.

The previous recessed-r3 source, viewer and exports are preserved in `archive/recessed-r3/` and in the version selector. Raised-r2 and dedicated-r1 remain preserved. The [earlier camera comparison](studies/camera-clearance/viewer.html) describes those historical layouts, not reinforced-r4.

[Current routing and camera sensitivity checks](review/route-validation.json) use 3 mm cylindrical string segments and conservative expanding square view envelopes from an illustrative camera rectangle at Z=22 mm. These are geometric checks, not a solution for tension-dependent string contact or friction. They do not establish actual camera framing: carrier geometry still enters some wider illustrative viewing envelopes. Actual lens position, selected lens and crop remain unknown. Do not call this a camera-clear or mechanically validated print release.

Run `cad/.venv/bin/python cad/versions/v2/source/check_routes.py` after the normal build to reproduce the routing and optical report. Reference slicing remains separate in `source/check_slices.py`.

## Knot access and physical validation — knot-access-r5

An assembly audit found that reinforced-r4 left only 2 mm between the rocker tie pad and the bracket roof. Illustrative stopper knots collided with that roof; the earlier clear-centerline test had not included a knot. That revision is preserved in `archive/reinforced-r4/`. The active bracket now has an open fork above the attachment. The return-band support also moves below the free band span, with a single fixed return hook instead of three choices. Only `actuator_bracket.stl` changes from reinforced-r4; use the matching current assembly. No additional printed part or hardware is introduced.

`source/check_attachment.py` checks 8 × 4 mm and 10 × 6 mm cylindrical knot envelopes at eleven stroke positions in all eight configurations. These are assumed envelopes, not measured knots. The audit also checks the illustrative return-band free span through the stroke, excluding a 4 mm radius around its intentional fixed-hook attachment. Band deformation and wrapping are not simulated. The viewer line still represents the string centerline and does not model a real knot. The attachment is intended to be tied while the actuator is off the phone and rail; finger access and actual threading remain physical checks.

Assembly order: put the contact screw into the rocker; thread and tie the rocker end of the twine; assemble the pivot in the loose bracket; fit the return band; thread the free long end down through the first guide, the side guide, neck guide and three shaft guides; mount the actuator and guide saddles; tie the remaining end to the trigger overtravel band and set slack. The fixed-guide turns and two independently adjusted bands make this moderately fiddly, not yet an established easy-assembly design. Do not tighten the contact screw against a phone during off-phone checks.

Physical validation is pending. The following is a short exploratory procedure, not strength certification or a dummy-phone test:

1. **Twine and knot, off the phone:** record approximate twine diameter/material, print material and settings. Check that a free end threads without tools, that the knot is secure and stays above the pad, and that the rocker reaches both stops without snagging. Do not assume the modeled 2 mm line or the 3 mm clearance-check diameter describes the real twine.
2. **Friction and return:** pull the actual twine through one finished guide in both directions, then through the complete route. Compare drag and look for fuzz or sharp support remnants. Fit the actual bands and perform 20 slow squeeze/hold/release cycles off the phone, including full intended trigger overtravel. Record any sticking, delayed return, lost knot tension, guide movement or newly abraded fibers. Twenty cycles is an initial screen, not fatigue qualification. The free twine may take a different path from the prescribed animation; observe its real contact points.
3. **Printed structure:** during those normal-use cycles inspect guide-to-support junctions, pivot ears/key, band hooks and rail clamps for cracking, whitening, layer separation, loosening or permanent deflection. Do not infer a load rating from passing CAD or slicing. A quantitative strength margin requires actual loads and representative material/print measurements; neither is available. Do not perform destructive loading with the phone fitted.
4. **Camera framing:** first use the actual phone/case and intended video lens/crop while supporting the assembly over a table. Keep the contact screw backed away from the button during this framing check. Inspect all four image edges at rest and while opening/closing the claws and changing normal working angle. Record whether any rail, carrier, guide, band, twine or actuator appears. Repeat only for camera modes you intend to use. The simplified camera footprint and Z=22 mm lens plane do not establish real framing.

The current optical audit has no mount intersections at the assumed 40° half-angle. The small phone envelope intersects the carrier at 50° and 60°; the wallet/bare envelopes intersect it at 60°. The large example is clear in these assumed cases. These are sensitivity results, not measured phone fields of view or a promise of clear footage.

Twine friction cannot be assigned from diameter alone: fiber and construction affect it ([Samson guidance](https://www.samsonrope.com/warning-statement)). Actual PLA layer bonding also depends on print conditions ([Prusa layer-separation guidance](https://help.prusa3d.com/article/layer-separation-and-splitting-fdm_1806)). No generic coefficient or filament strength is substituted for your actual parts here.

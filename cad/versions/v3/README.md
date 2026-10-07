# Version 3 — T-jaw and compact actuator

V3 contains the twelve requests starting with deeper jaw closure and ending with the slimmer actuator bracket. V2 is preserved at the preceding boundary, including the captive-guide eye translation requested earlier. Source, viewer, assembly, BOM and manufacturing exports are independent of V2. No V3 print has been sent.

| # | Requested change | Final V3 implementation |
| --- | --- | --- |
| 1 | Deeper sliding-jaw closure | Empty head closes at the fixed track midpoint, X−66.5; tongue48.5 mm. |
| 2 | One robust angular band hook per jaw | Broad rectangular cleats with6.7 mm stack space for multiple bands. |
| 3 | Two moving contacts plus one fixed contact; initial Y shape | Three-point contact retained; final shape follows request8. |
| 4 | Lighting-aware annotations, colors, shapes and arrows | Lit surface brush, color picker, drag rectangles, ellipses and arrows. |
| 5 | Double retaining lips | Inward projection2→4 mm on both jaws. |
| 6 | Reduce available phone depth30% | Final pocket follows the explicit14 mm decision in request7. |
| 7 | Confirm14 mm pocket | Rear datumZ18, lip inner faceZ4. Recorded phone dimensions unchanged. |
| 8 | T instead of Y, with10 cm contact spacing | Contact centersY±50 mm;8 mm pads,108 mm overall crossbar. |
| 9 | Triple actuator rotation | Free travel3.248°→9.745°, revised press stop and knot clearance. |
| 10 | Rethink slipping/misaligned contact screw | Integral rounded shoe, now4 mm along the button ×16 mm across phone thickness; contact screw removed. |
| 11 | Shorten cap rail20 mm per side |160→120 mm overall. |
| 12 | Slim bracket and mount through inner openings | Plate66→38 mm; mounting screws atY±9.5 mm; the subsequent fixed-mount refinement replaces slot adjustment with round holes. |

Later choices supersede earlier alternatives; the intermediate Y shape is not an additional product version. The PEI-bed confirmation is a V2 print-operation record, not a V3 design change.

## Review limits

The14 mm pocket conflicts with the unchanged18 mm wallet-case and20 mm large-phone proxies. Bare/small depth envelopes fit. The viewer and validation report explicitly retain these conflicts.

The rigid shoe eliminates contact-screw loosening but has no independent fine gap adjustment or compliance. Its full free travel advances the reference contact1.762 mm versus the old nominal gap-plus-button budget0.650 mm. The extra1.112 mm is not validated button travel. Check actual released clearance, case geometry, neighboring buttons, force and return before loaded use. The trigger overtravel band does not qualify this larger button stroke.

The large-phone example shifts21 mm along the jaw to keep mounting screws inside the shortened rail. After module removal, service the outer rail screw before the inner; move each toY±50 for withdrawal. See service-access.json. Strength, preload, creep, grip and real camera framing remain physical checks.

## Files and validation

- `source/build.py`: regenerates V3 only; exports under this directory.
- `review/validation.json`: geometry checks and explicit pocket-fit conflicts.
- `review/compact-actuator-redesign.json`: dimensions and contact-travel limits.
- `review/compact-mount.json`: slot clearance and nut/head bearing-land checks.
- `review/rocker-stops.json`, `pivot-assembly.json`, `attachment-audit.json`, `service-access.json`: mechanism checks.
- `print/`: current meshes/STEP exports, requiring fresh slicing and support review.
- [V2 print jobs](../v2/print/jobs/): historical recipes and physical outcomes; not V3 print qualification.

Rebuild from the repository root with `cad/.venv/bin/python cad/versions/v3/source/build.py`. Ten designs,21 printed pieces: six screws and six nuts. Successful V2 fasteners retain their geometry; their print history stays in V2.

## Perpendicular shoe and fixed bracket mount — 2026-10-04

Rotate the contact shoe90° about local X, so its long direction runs across the phone thickness rather than along the button. Its4×16 mm contact face is offset2 mm toward the back datum, spanning localZ0..16, to cover the unchanged modeled button-height range (centersZ4..14) without shifting the bracket. Rounded edges and the integral stem remain. This is nominal coverage, not validated button force or travel.

The bracket now has exactly two8.8 mm round mounting holes centered at (Y,Z)=(-9.5,-14),(9.5,-14),19 mm apart. A solid mounting crossbar separates upper/lower lightening windows, which provide no adjustment at the mounting centers. Module depth is fixed at local offset0 for all phone examples; the actual phone-button proxy heights remain unchanged. The cap rail still selects longitudinal position and the actuator side. See `review/fixed-mount.json` and `review/compact-mount.json`. V2 is unchanged.

## Slim sliding-jaw contacts — 2026-10-04

Remove the central projection below the T crossbar (formerly localZ3.6..12). Keep the tongue, cleat and their connecting root above the crossbar. Narrow each outer contact pad12→8 mm alongY and reduce its contact-wall thickness10→6 mm alongX. Centers remainY±50 mm; the crossbar now spans108 mm overall. Retaining-lip projection4 mm and pocket depth14 mm remain unchanged. See `review/slim-contact-pads.json`; CAD volume savings do not predict sliced filament usage or establish printed stiffness.

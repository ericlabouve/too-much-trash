# Version 2 — dedicated cradle, twine and rubber bands

**First design-review concept, not a print-approved or physically validated assembly.** This version explores the user's minimal-material constraint: PLA/PLA+, one continuous length of twine and ordinary rubber bands. No metal hardware, padding, TPU, adhesive or separate textile strap is specified. Five printed designs make seven pieces. This reduces hardware variety, not the number of printed pieces versus V1.

Open [the versioned viewer](../../viewer.html?version=v2). The selector returns to **Version 1**, the checkpointed R4 printed prototype. Product versions V1/V2 are distinct from the earlier CAD revision names R2/R3/R4. V1 source, manufacturing files, BOM, accepted fit and original concepts are unchanged. Its exact checkpoint is `printed-prototype-checkpoint` (`ade5b54`). The original viewer is preserved byte-for-byte as `../../viewer-v1.html`.

## Confirmed inputs and provisional choices

On 2026-09-30 the user selected a dedicated fit for the existing wallet-case phone, twine of any required length, and available rubber bands described as roughly 2–3 cm in radius. The previously measured case envelope is 76 × 152 × 18 mm; volume-up center is 105 mm from the charging edge and 6 mm from the screen-side face. Phone remains beside the shaft on negative X, rear support behind the camera-side face, screen open. This first V2 uses the near-shaft button position only; it does not claim V1's universal adjustment or interchangeable actuator sides.

The reported band radius is **not** a measured flat length, wall thickness, force curve, or allowable working extension. If interpreted as a circular loop it would imply approximately 126–188 mm circumference (63–94 mm flattened length); this is only a sizing interpretation. Hook choices and wrapping a band more than once allow adjustment, but no particular band/loop count is qualified. Twine diameter is unknown: the model uses a provisional 2 mm line and 6 mm guide eyes. Knots, fuzz and friction require checking with the actual twine.

The new open U-saddle uses the negative-X and Y surfaces derived from the accepted 11.6 × 17.6 mm collar cutout. Its positive-X side is open and rubber bands retain the shaft. **This is a new attachment, not the accepted two-half collar fit or a validated replacement for its bolts.** V1's successful cap/anchor prints need no reprint for V1. The stock proxy still uses the historical 14 × 19 mm measurement; its overlap with this smaller cutout is explicitly excluded from clearance claims.

## Mechanical arrangement

- **Dedicated slide-in cradle:** hard side rails, narrow screen-side retaining lips, two rear crossbars and charging-end corner stops. Side-wall windows remove unused material. There are no friction pads and no width screw. Case clearance is provisionally 0.4 mm per side. Retaining lips must contact the case rim rather than display glass; the exact rim and corner shapes have not been measured.
- **Removable end gate:** two square tongues enter sockets behind the case. A rubber band from one of the three rear cradle hooks to the gate hook holds it closed. The gate, lips and end stops provide geometric capture rather than relying on squeezing friction. Gate retention still depends on a sound band and sound printed sockets.
- **Integral actuator support:** the cradle includes both pivot bearings, released/pressed stops, three return-band hook heights and the first closed twine eye. The rocker has an integral bearing boss with 0.3 mm axial clearance per side, replacing separate washers. The hard rounded rocker nose replaces the contact screw and soft tip. Its nominal stroke is deliberately provisional; changing actual contact gap/travel may require revising the dedicated part. There is no concealed metal adjustment hardware. The nominal case clearance allows movement comparable to the proposed button stroke; loaded case position and hard-contact calibration must be resolved before operation. No guaranteed button activation is implied.
- **Printed pivot key:** a 6 mm axle passes both bearings and the rocker. A cross-lug enters through matching keyways; quarter-turning it prevents axial withdrawal. The notched head indexes against the cradle. The CAD provides axial room to disengage the index before turning. Actual insertion, accidental unlocking, fit and wear remain unvalidated; a CAD-clearance result is not a retention test.
- **One continuous twine:** tie at the rocker's through-hole, thread the integrated rounded eye and three repeated shaft guides, then tie the other end to the trigger's overtravel band. Leave the knot outside the sliding guide path. Adjust the lower knot to set installed length; knot tails are not additional string pieces. No bicycle housing, ferrules, cable stops, gears or pulleys are included.
- **Two elastic functions:** the return band acts on the rocker; a separate band connects the twine to the moving black trigger and stretches after the rocker meets its stop. The trigger band wraps the stock trigger directly; its engagement and hand clearance must be checked. Return-band tension must overcome twine drag and any residual pull from the overtravel band at release. The overtravel band must then develop enough force to actuate without exceeding the printed stop's capability.
- **Captive routing:** closed guide eyes retain a slack line. Light operating preload limits sag between them; guides alone cannot eliminate sag or snags. Three guide stations are provisional, and their band retention is untested. Rounded fixed guides minimize loose parts; if twine drag prevents return, change the route or substitute a captive plain-bearing pulley at the offending turn. A printed pulley adds its own axle friction and parts.

The modeled starting count is **eight bands**: two at the cradle saddle, one end gate, three shaft guides, one return and one overtravel. They need not all be the same size or tension. Band paths are illustrations, not measured cross sections, installation templates or a promise that eight arbitrary bands will work. See [BOM](bom.md).

## Motion and checks

Use **Animate squeeze** to play a repeating squeeze–hold–release cycle. Starting from Phone assembly opens Full tool so the handle is visible. The synchronized actuator close-up stays visible beside the assembly, with a gray released-position outline and green nominal button contact. The cycle spends extra time on the initial rocker movement without increasing its angle. **Pause animation** freezes the current pose; dragging **Lever stroke** takes manual control; **Release** returns to zero. BOM view pauses and disables playback.

The viewer rotates the illustrative stock trigger, then moves the rocker to its printed stop. It keeps the modeled continuous twine centerline length constant by moving the lower knot as the rocker takes up line. The trigger band then lengthens with further squeeze. This is prescribed kinematics, **not a force simulation** and not a measured trigger trajectory.

At the nominal case/button datum, approximately 3.18° of rocker rotation produces 0.65 mm inward nose travel: 0.35 mm release gap plus the provisional 0.30 mm press. The guide-to-rocker segment shortens by about 0.78 mm. An assumed 40 mm line take-up would therefore require about **39.22 mm of additional band span** after the stop. This is a geometric allowance, not a band rating; the illustrative trigger rotation does not itself establish 40 mm take-up. The previous metal spring's rate is not reused.

`review/validation.json` records connected-solid and watertight-mesh checks, nominal phone clearance, rigid-part intersections and eleven rocker positions. It excludes historical shaft/saddle overlap, intentional nominal button contact, flexible-material forces, knots, printing supports and physical retention. It does not establish general phone compatibility, glass contact safety, fatigue, adequate band force or field readiness. Dummy-phone testing remains declined; no such testing has been performed or added as a requirement.

Before manufacturing exports are promoted, review the actual case rim/camera envelope, sliding insertion, bayonet retention, support access and print orientation. Check twine drag/knots, band preload and return off the phone. Inspect the actual parts for gate/collar slip and stop deformation. There is no successful V2 print or loaded test yet.

## Files

- `source/model.py`: parameterized CadQuery geometry, stock references and flexible-material paths.
- `source/build.py`: V2-only review export, BOM source and geometry checks.
- `review/*.stl`: **assembly-coordinate review meshes, not bed-oriented manufacturing files**.
- `review/assembly.step`: editable review assembly.
- `review/manifest.json`, `validation.json`: viewer data and explicit check scope.
- `viewer.html`, `viewer.js`, `viewer.css`: isolated V2 viewer; V1 keeps its own behavior/material controls.

From the repository root: `cad/.venv/bin/python cad/versions/v2/source/build.py`. This command writes only this version's review assets and generated BOM. Do not run the V1 standard build for a V2 or viewer-only edit. Add future versions through `cad/versions.json` with their own asset paths. The selector supports `?version=v1`/`?version=v2` and remembers the last selection.

## Research rationale

[Samson's rope guidance](https://www.samsonrope.com/warning-statement) supports smooth, rounded guides and avoiding pinching V-grooves; its rope guidance is not a qualified specification for unknown twine on FDM PLA. [Alliance's band terminology](https://www.rubberband.com/about-us/common-rubber-band-terminology/) distinguishes elongation and permanent set. [Vernier's measured band experiment](https://www.vernier.com/vernier-ideas/elastic-hysteresis-of-a-rubber-band/) demonstrates different loading/unloading behavior, so no linear spring model is assigned to these bands.

The user's [printed screw generator reference](https://makerworld.com/en/models/1055250-screw-generator-parametric-screws-nuts-washer#profileId-1042636) prompted consideration of large printed screws. The direct page could not be retrieved during research. [BOSL2's primary threading documentation](https://github.com/BelfrySCAD/BOSL2/wiki/threading.scad) documents standard and trapezoidal thread geometry, not strength qualification. This dedicated-fit concept eliminates the adjustment screws entirely. If band retention proves insufficient, a large coarse printed screw is a future alternative; it is not an uncounted part of this BOM.

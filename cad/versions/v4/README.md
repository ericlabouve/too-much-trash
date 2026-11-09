# V4 clamp and liner study

The accepted full-face TPU pads and perimeter lips are checkpointed at
c9603da. Each pad replaces 0.8 mm of rigid contact material.

The current preview moves both screw-bearing ends inward 5 mm. Clamp body
length drops from 107 to 97 mm and screw-pair spacing from 90 to 80 mm.
Both pads and all three return lips follow the shortened windows. Each
result is one valid solid and each pad has zero solid overlap with its seat.

The clearance study includes the translated cap/jaw ends and their screws
and nuts. It samples phone widths 66, 76 and 86 mm, actuator positions
at Y ±29 and ±44 mm, and the corresponding sliding-jaw positions.
Minimum clearances for the 5 mm candidate are 5.200 mm to the pulley,
6.531 mm to the actuator bracket and 28.087 mm to the whole sliding jaw.
These are distances from the moved end sections, not minimum gaps
throughout the whole assembly. Full travel, flexible cords/bands, service
access and physical retention remain to be checked. Contact area reduces
to 853.1 mm² on the cap and 1289.0 mm² on the fixed jaw.
The cap has since passed the matched slice below. The revised fixed jaw
and pads still need fresh slicing.

Run source/check_clamp_end_clearance.py with the CAD uv environment to
compare 0, 5, 8 and 10 mm inward moves. At 10 mm the lower end is only
0.556 mm from the pulley in the sampled configurations.

The fixed cuff and its integral T stud move down 3.28 mm, from Z11.28
to Z8.00, matching the contact-end center of the current plunger foot.
The lower jaw window ends at Z0.72 instead of Z4 to preserve the
original stud-root ligament. Its TPU pad and return lip match this opening.
The cuff and jaw have zero solid overlap. Actual phone button centering
and the resulting phone tilt require physical verification.

The fixed-jaw arm slot now ends at X−20 rather than X−34, extending
14 mm toward the collar. Its width is 6 mm and its far roof keeps the
35° profile. The exact CAD volume reduction is 336 mm³; this is not
a sliced filament estimate. The jaw passes the single-solid validity check.
Slicing and printed strength remain unverified for this extension.

Each exposed cap rail is shortened 30%, measured from the Y±13.8 cap
side to the original Y±60 tip. New tips are Y±46.14, giving 32.34 mm
projections. Slots retain 8.8 mm width and 2.6 mm outer-end ligaments;
outer slot end centers are Y±39.14. Nominal 8 mm screws have an outer
center limit of about ±39.54 mm. The displayed bare near-side screw
center is Y24.6 and the bracket has zero solid overlap with the cap.
Large-phone far-side screw center Y−48.4 is beyond the shortened rail.
The cap remains one valid solid and saves 1303.95 mm³ of solid CAD
volume. The complete shortened cap passes the zero-support slice below;
rail-specific filament savings and printed strength remain unverified.

## Mirrored cap string passages — 2026-11-09

Checkpoint before this study: `1a68c2f`. Two elongated hexagonal passages run along Z
through the handle-end cap bosses, centered at X−1, Y±22.25. Each has
3 × 2 mm overall dimensions (2 mm inscribed diameter) for the nominal 1 mm cord.
The roof closes at 45° in the exterior-X12-face-down print orientation.
The passages do not intersect the screw bores; minimum bore ligament is
1.35 mm. Both remain within the existing cap envelope. The geometry is
one valid solid. Pads and screw interfaces are unchanged.

Matched A1 mini / 0.4 mm / Bambu PETG Translucent / 0.12 mm slices used
automatic supports ON and bridge suppression OFF. Both baseline and
modified cap produced zero support/interface extrusion. Total slicer
material changes 24.0822 → 24.0973 g and time 162.71 → 163.43 minutes.
Hole perimeters can increase filament use despite removing solid CAD volume.
See `review/cap-string-guides.json` for exact job hashes and settings.
Reproduce with `uv run python versions/v4/source/check_cap_string_guides.py
build/NEW-cap-guides` from cad, using a fresh output directory.

Guide placement targets the displayed bare-phone actuator. Other actuator
rail positions, threading clearance, string abrasion, local strength and
loaded derailment prevention remain physical/routing checks. No print sent.

## Remaining agreed V4 work

- String tension: make initial adjustment and maintaining tension easier.
- Actuator: add a positive plunger travel stop and move its handle to meet
  the end rail. Verify volume-button centering with the lowered fixed cuff.
- Validate the liner grip against harness movement toward the handle,
  including whether clamping loosens in use.
- Validate the integrated cap guides prevent pulley derailment and do not
  abrade the string; review routing across intended actuator positions.
- Verify cuff/button alignment and upward camera aim on the physical tool.
- Slice the remaining revised jaw/pads, review full travel and service
  clearance, and resolve the shortened rails' large-phone far-side limit
  if that configuration is required before the V4 print.

The clamp shortening, 30% exposed rail shortening, lowered fixed cuff,
full-face flush pads and 3 × 2 mm cap guides are implemented in the V4
review design. Field validation remains outstanding; V3 is preserved.

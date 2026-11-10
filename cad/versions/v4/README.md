# V4 · Official design baseline

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
- Physically verify the implemented plunger stop, tail handle and volume-button
  centering; measure safe button travel and check insertion/key retention.
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

## Official V4 baseline — 2026-11-09

The user approved the current harness as the official V4 design. This
promotes design status, not physical validation or a production release.
V4 is the default viewer. V3 is preserved; V4 currently uses the V3
actuator pending separate concept selection. The maintained V4 generator
is source/build_preview.py; manufacturing bundle promotion is still pending.


### Mandatory support gate

Reject proposed designs that generate any support or interface extrusion.
Check with automatic supports enabled and bridge suppression disabled.
Zero support does not establish physical fit, strength or retention.

### Pulley experiments withdrawn — 2026-11-09

The user requested undoing all wheel changes. The original V3 pulley
remains the official V4 wheel. The isolated flange/lip concepts are
withdrawn; the approved shaft-cap string passages are retained.
Next priorities are the actuator's positive travel stop and end-positioned
plunger handle, then string tension adjustment and physical verification.

### Removable plunger travel-stop concepts — 2026-11-09

Isolated at `review/concepts/travel-stops/`; official actuator unchanged.
A uses a removable pin inserted from underneath into a closed-ended through slot in the slider,
with 6 mm nominal pull before contact. B uses a removable one-sided handle gate
in a shallow rectangular guide-wall pocket, with approximately 3.2 mm pull before contact;
B keeps the exact current plunger. Both require stop installation after slider
insertion. Stop seating is provisional: A has a nominal line fit; B has 0.15–0.2 mm side clearance and will need a retaining fit or latch before printing. Neither stop retention is validated.
The candidate stroke is an escape limit, not a safe phone-button stroke.

Valid single solids, sampled unobstructed slider insertion with stop removed,
positive stop interference beyond the limit, sampled stop installation/removal, and clearance to the current wheel,
axle and key were checked. All six PETG candidate pieces sliced with **zero
support/interface extrusion**, automatic supports ON and bridge suppression OFF,
A1 mini 0.4 mm nozzle / 0.12 mm layers. See the concept's `support-status.json`
for actual extrusion masses and package hashes. Printed retention, wear, strength,
and full-stroke cord/band clearance remain unverified. No print sent.

Reproduce: `uv run python versions/v4/source/build_travel_stops.py build/NEW/source`,
then `uv run python versions/v4/source/check_travel_stop_slices.py build/NEW/slice
build/NEW/source`. Generated meshes and slices remain ignored build outputs.

### Tail-positioned handle — 2026-11-09

The user rejected both removable travel-stop concepts: the extra pieces could
fall out. Do not promote them. The next review moves the original integral
plunger handle **8 mm tailward**, seating its 1.6 mm-wide stem in the existing
2.4 mm groove; stem end Y41 has 0.4 mm nominal clearance to the Y41.4 end wall.
Foot, triangular shaft and bracket remain unchanged. No extra parts or slots.

`source/build_tail_handle.py` generates the isolated review and checks the
full sampled insertion/pull path (0–53 mm in 0.5 mm steps) against the bracket,
wheel, axle and key. All overlap volumes are zero. This change does not yet
provide a positive forward travel stop. Cord/band routing and physical fit
remain follow-up checks. Official harness geometry is unchanged pending review.

Rebuild with `uv run python versions/v4/source/build_tail_handle.py build/NEW/source`.
Slice with `uv run python versions/v4/source/check_tail_handle_slice.py
build/NEW/slice build/NEW/source`. No printer is contacted.

The relocated-handle PETG slice generates zero support and interface extrusion
with automatic supports enabled and bridge suppression disabled (0.12 mm layers).
See `review/concepts/tail-handle/support-status.json` for the exact hashes/settings.

The main V4 viewer now includes a Bill of Materials mode (`?view=bom`) using
current V4 geometry: seven rigid pieces and sixteen TPU pieces, including the
two separate liners. Repeated cuffs/screws/nuts display once with quantities.
This official BOM excludes rejected loose stops and retains the existing
actuator until the separate tail-handle review is accepted.


### Accepted tail-handle checkpoint — 2026-11-09

User approved the 8 mm tailward handle relocation. Preserve this design as the
accepted actuator baseline for subsequent guide-wall studies. The main BOM's
older actuator geometry has not yet been regenerated; the tail-handle review
contains the accepted geometry. The positive travel stop remains unresolved.

Next study: steepen the two captured guide faces (currently 45 degrees from the
bracket base) to allow a thicker matching plunger section while keeping the
open handle lane and end-loading insertion. Retain inward capture; fully
vertical walls alone would not prevent lift-out. A 60-degree face is a candidate,
not a verified support-free result. Check both parts with automatic supports
on, bridge suppression off, and rerun insertion/motion clearances before adoption.

### 70-degree captured guide and underside T/V stop study

The isolated `review/concepts/steep-stop/` retains the accepted tail handle and
widens the plunger upper section from 1.6 to 5.67 mm. Both guide faces are 70°
from the bed, with a 7.19 mm top opening capturing the 8 mm shaft base. A closed
through-slot accepts a shortened TPU T/V stop installed from underneath after
the plunger. This key is not interchangeable with the pulley axle key. Its
free arm ends remain separated from the stem to allow inward flexure.

Nominal pull limit is 6.2 mm; this is not a verified safe button stroke. The
0–53 mm sampled insertion path clears the bracket and pulley context with the
stop removed. Physical snap retention, underside service access, string/band
routing and loaded sliding still need checks. Official assembly is unchanged.
Reproduce with `source/build_steep_stop.py OUTPUT`, then
`source/check_steep_stop_slices.py SLICE SOURCE petg` and a separate `tpu` run.

Both PETG parts and the final TPU key sliced with **zero support/interface**
extrusion (automatic supports ON, bridge suppression OFF, A1 mini 0.4 mm
nozzle / 0.12 mm layers). Exact settings and hashes are retained in the study
`support-status.json`. No print sent.

The stop key is now rotated 90° around its insertion axis: its V opens along
the travel direction. The plunger slot narrows from 5.6 to 3.6 mm, retaining
0.3 mm nominal lateral clearance per side of the 3 mm key thickness. The slot
is lengthened to keep approximately 6.2 mm pull travel. Refreshed PETG and TPU
slices still contain zero support/interface extrusion. This remains a concept.

### Extended plunger stop slot — 2026-11-09

The review slot extends in both directions to Y15.35..33.0, 17.65 mm long
and 3.6 mm wide. Retain 2 mm solid bridges before the shaft/foot transition
and handle root at Y35. Nominal forward travel grows from 6.2 to 10.6 mm;
the existing bracket tail wall limits reverse travel. The key and bracket are
unchanged. The full sampled insertion path still clears the bracket and pulley;
key contact begins at 11 mm in the 0.5 mm sampling. Fresh PETG slicing with
automatic supports on and bridge suppression off produces zero support/interface.
This geometric escape limit is not a qualified phone-button stroke; the longer
slot and its ligaments need physical strength/retention checks. No print sent.

Handle-side extension: slot now ends at Y33.5, adding 0.5 mm and leaving
1.5 mm before the handle root. Length 18.15 mm; nominal pull 11.1 mm.
Fresh PETG slice remains zero support/interface with automatic support on.
Sampled insertion clearance passes; thinner end bridge strength is untested.

The extended stop slot was accepted. The next review rounds the transverse
neck/foot shoulder with a 0.5 mm fillet, preserving the concave contact face,
slot and sliding surfaces. Valid single solid and 0–53 mm sampled insertion
clearance pass. Refreshed automatic-support PETG slice has zero support/interface.
This is a local shoulder refinement; physical fit/strength remains untested.

Superseding shoulder refinement: replace the small fillet with a 3.35 mm
long cubic tangent transition from Z7.4 to Z6.6 (Y10..13.35), removing the
raised transverse step. Foot contact curve and slot remain unchanged.
Valid solid and full sampled insertion checks pass; fresh PETG slice remains
zero support/interface. Added Foot junction camera preset for review.

User accepted the curved junction and requested the slot end meet the handle
start. Slot now Y15.35..35.0, 19.65 mm long. No separate bridge ahead of
the handle; the solid tail behind Y35 connects it. Nominal pull limit 12.6 mm.
The foot transition and 3.6 mm slot width are retained. This supersedes the
prior conservative 1.5 mm front-of-handle bridge allowance.
Valid single-solid and sampled insertion/motion checks pass. Fresh automatic-
support PETG slice reports zero support/interface; loaded strength remains untested.

## Approved actuator promotion — 2026-11-09

The user approved the 70° guide, thicker plunger with curved foot transition,
19.65 mm slot ending at the tail handle, and shortened underside TPU T/V key.
`source/build_steep_stop.py:geometry_stop` is the canonical actuator generator;
`source/build_viewer.py` uses it for all eight official V4 configurations.
The BOM now contains 14 designs / 24 pieces (7 rigid, 17 TPU). The plunger
stop is distinct from the pulley axle key. This supersedes earlier notes saying
these parts are a separate study. Automatic-support slices have zero support
and interface extrusion; physical retention, strength and safe button travel
remain unverified. The 12.6 mm escape limit is not a button stroke prescription.

V3/V4 share the V3 viewer app; V4 supplies its own generated manifest and meshes.
Do not fork a second dashboard. Validate with
`uv run python tests/check_v4_viewer.py build/v4-review` from cad.

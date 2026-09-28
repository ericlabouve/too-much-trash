# Measurement record

All dimensions are millimetres. Recorded 2026-09-27. User-supplied values
are not independently verified; do not substitute prior CAD defaults for
missing measurements.

## Phone

The selected button is **volume up**. D is measured along the phone from
the charging-end outer edge to the button center. H is measured through
thickness to button center. The confirmed datum is the rear outside surface
(wallet back when cased). Use the derived screen-side distance for actuator
placement; do not confuse it with D.
T is the outside thickness at the jaw contact region, excluding camera bump.

| Configuration | L | W | D | T | H | Source |
| --- | ---: | ---: | ---: | --- | --- | --- |
| iPhone 15 Pro, bare | 146.6 | 70.6 | 102 | 8.25 | 4 | L/W/D reported from online; T/H supplied by user |
| User's phone in wallet case | 152 | 76 | 105 | 18 | 12 | User measurements; case has rear credit-card storage |

The user confirmed the cased button center is **12 mm from the wallet back
and 6 mm from the screen-side outside surface**, with this orientation:

```text
WALLET BACK                              SCREEN / FRONT
     |                                         |
     |------ 12 mm ------o------- 6 mm ---------|
                    button center
     |<---------------- 18 mm ---------------->|
```

The extra case depth houses credit cards; do not assume its button is
centered through thickness. For the bare sample, the supplied H=4 gives
a nominal screen-side distance of 8.25-4=4.25 mm using the same rear datum;
this bare-phone datum interpretation should be checked during fit testing.
With screen facing the observer, volume buttons are on the left and the
power button on the right.

The user initially identified the sample as iPhone 15 Pro and later used
“iphone 15” as shorthand. Working assumption, stated in conversation: both
samples are that 15 Pro. The exact wallet-case brand/model is unknown.

## Reacher

| Measurement | Value | Source |
| --- | ---: | --- |
| S: lowest moving claw-mechanism extent to top of blue center brace | 200 | User measurement |
| Shaft outside width/depth at phone clamp | 14 × 19 | User: width along project X, depth along project Z |
| Shaft outside width/depth above handle for housing anchor | 14 × 19 | User confirms same section at both locations |

The measured shaft is RECTANGULAR, not square. These physical measurements
supersede the square-section assumption in earlier concept metadata and CAD.

The phone mount belongs in the S region near the claws. A separate compact
housing anchor belongs immediately above the handle, consistent with 3a.

## Trigger motion — clarified direction and working stroke

A is the shaft centerline at the metal/blue-handle sleeve boundary.
X is parallel to the shaft from A toward the grip; Y is perpendicular
from the shaft centerline toward the trigger. P must be the same marked
material point on the trigger in both states.

| State | X | Y | Source |
| --- | ---: | ---: | --- |
| Open | 102 | 65 | User measurement |
| Closed | 85 | 65 | User measurement |

The user subsequently clarified that the trigger point moves **toward the
grip, away from the claws**, approximately along a straight line: roughly
20 mm in the supplied photos and up to roughly 40 mm at full compression.
Use this clarified physical direction for mechanism development. The earlier
102/85 coordinates conflict with the defined datum/direction and must not
be used as validated endpoint coordinates. Retain them only as history.
Trigger-point travel is not automatically equal to cable take-up: compute
the changing span to the selected stationary housing exit. Prototype the
complete stroke, including excess travel after button contact.

User proposes a flexible hook-and-loop strap around the moving trigger,
passing through a cable end loop. This replaces the need to size a rigid
printed trigger tab. Check strap slip, clearance during full squeeze, and
cable-loop retention on the physical prototype; no trigger cross-section
measurement is currently requested.

## Agreed design requirements

- One physical carrier adjusts to multiple phone sizes, bare or cased;
  intended family is iPhone 14–18, with compatibility still to be checked
  against actual envelopes and button/camera positions.
- Slim padded opposing jaws, one fixed and one sliding; no GoPro interface.
- Use the supplied universal-holder images as the jaw mechanism reference:
  the phone is gripped between padded opposing side faces. The desired
  carrier is slim and rigid with open access and retaining lips/closure.
- Adjustable volume-up actuator holds the button while the trigger is held.
- Adjust actuator position along the phone and through its thickness to
  accommodate bare buttons and raised case button covers. Case actuation
  must be checked physically; equal force/travel is not established.
- Compact housing anchor and removable trigger attachment as in concept 3a.
- Avoid the prior 72 mm handle outrigger. Use a flexible trigger strap
  instead of a rigid printed trigger tab where prototype retention permits.
- Minimize printed part count, bulk, and mass without sacrificing durability.
- Keep cameras aimed along the shaft toward the claws and all phone/mount
  geometry clear of claw motion. Preserve port, microphone, camera, and
  control access; no permanent tool changes or reliance on factory screws.
- Preserve project axes: +Y toward claws, X/Z as concept 00a. Added printed
  parts orange; stock handle/brace blue, metal silver, trigger/feet black.
- Keep measured samples separate from provisional design ranges.

## Implementation choices and validation still required

These are engineering choices, not additional measured facts:

- Thumb-screw jaw adjustment is the stated working default; the user did
  not separately answer the earlier thumb-screw preference question.
- Use a defined housing reaction point, constrained actuator, positive
  return, adjustable contact/rest gap, and controlled button travel.
- Accommodate remaining trigger travel after button contact with a spring
  or other compliant transmission. A hard stop alone is insufficient.
- Calculate cable take-up from actual anchor geometry rather than assuming
  the full 20–40 mm trigger stroke is transmitted along the cable.
- Button force/safe travel, spring rates, jaw retention, camera keep-outs,
  strap slip, and print tolerances require prototypes. No physical fit or
  durability validation has been completed. No blocking measurement
  questions remain for the initial CAD redesign.
- R2 source/STLs are preserved in `../archive/r2/`. The current R4 source
  and exports implement the revised measurements and design decisions;
  they remain unvalidated physical prototypes.

## Supplied image references

The conversation includes these user-supplied images:

- `full-length.png`: complete reacher alongside tape.
- `uncompressed.png`: open trigger alongside tape.
- `compressed.png`: squeezed trigger alongside tape.
- `universal-phone-holder.png`: adjustable opposing-jaw holder example.
- [Holder with phone](holder-with-phone-reference.png): second holder example,
  copied unchanged from the supplied screenshot.

Tape has inch and metric (cm/mm) scales. No numerical dimensions were
extracted from the images for this record. The first four attachment paths
were unavailable on disk when this record was consolidated; images remain
in the conversation, and are not claimed to be archived in this repository.
Original stock photo and concept renders remain unchanged.

## Next phase

1. Redesign the adjustable carrier, 14 × 19 mm clamps, compact cable anchor,
   and actuator around these measurements and decisions.
2. Check the entire mechanism stroke, overtravel accommodation, return,
   collisions, assembly access, and FDM print orientations.
3. Regenerate individual STL/STEP parts and an assembly drawing from real
   CadQuery solids; document parameters, setup, BOM, assembly, materials,
   prototype limitations, and intentional differences from concept art.
4. Commit logical increments on the existing PR branch and open the final
   STL set in Chrome. Physically validate small fit/mechanism prototypes
   before treating the resulting design as ready for final field printing.

## R4 review decisions — 2026-09-27

- User explicitly selected **Option B**: phone beside the shaft; shaft must not intersect the phone. “Centered” means equal phone length on either side of the gripping band, not a shaft passing through the phone center.
- Carrier and sliding jaw support the rear/camera face, leaving screen viewing unobstructed.
- Camera envelope belongs on the opposite edge from volume actuation in the reviewed layout. Default actuator is far from shaft; provide mounting interfaces on both sides using the same printed mechanism.
- Route housing centrally on the neck face facing the moving black trigger, with the outlet aligned to a Velcro attachment on the upper trigger. No rigid printed trigger attachment.
- Preserve previous draft before changes: pushed annotated Git tag `cad-r3-first-draft` at `c7c0030`.
- No additional dimensions were measured in this review. R4 pad friction, camera envelope, spring selection, housing bends and stock handle proxy remain provisional.

### Demo orientation correction — 2026-09-27

The user's rear landscape reference places the camera block at lower left and volume up on the upper long edge. The default demo therefore uses the near-shaft actuator rail, with the camera block on the far edge. This supersedes R4's initial far-side demo placement; either-side printable capability is unchanged. Volume-up center/depth use the supplied measurements. Added button-marker size (7 ×2.6 mm), 14 mm down-button spacing and camera block dimensions are illustrative, not new measurements.

“Dummy phone test” means a physical size/weight surrogate and dummy button gauge to check clamp slip, stiffness, cable friction, return and stop behavior before risking the phone. CAD swept-motion checks and the browser lever slider visualize rigid motion only; they do not validate those physical effects.

### Housing route and hardware clarification — 2026-09-27

User declined dummy-phone testing and requested the housing illustration use a simple loop with two right-angle turns. The CAD now shows three straight segments, with the long run centered on the trigger-facing neck surface. These corners are a routing schematic; actual housing requires rounded bends and selected-hardware clearance. No hardware dimensions or physical tests were supplied. The lever's existing short cylinder represents a purchased screw-on cable stop; it does not assume a particular factory nipple. The README now identifies all non-printed hardware and the housing/inner-wire load paths.

### Available filament — 2026-09-27

User owns PETG, PLA and PLA+ and prefers all printed parts in one material or interchangeable materials. Adopt PETG for all current rigid printable parts, including rocker. Keep soft pads/shims/contact tip purchased or cut from compliant sheet; no TPU printing is required. Same STL geometry does not establish equivalent strength, fit or thermal performance between filaments. PLA+ brand/grade is unknown; no structural interchangeability has been validated.

### Two-stage material plan — 2026-09-27

User requested material recommendations alongside each BOM part for initial prototype and later TPU availability, and declined further PLA+ brand discussion. Initial rigid prints may use available PLA/PLA+ (PETG optional). Later recommendation is PETG structure plus separate TPU pads, liners and contact cap. Metal transmission/fastening hardware and textile strap/tether remain conventional. Proposed TPU accessories and optional printed knob/guides are identified as not yet modeled/exported; the current printable set remains six unique designs/seven pieces. Regenerate current exports and display in Chrome.

### Unified BOM — 2026-09-27

User requested one Bill of Materials view combining printed parts and purchases without double-counting. The BOM now has one row per component or explicit hardware set, quantities for one assembly, requirement status and alternative supply/material choices. Thumb head is included with the draw screw; future printed substitutes replace their purchased equivalents. Shaft shims are fit-dependent, tether recommended, trigger saddle optional; pads, contact cap, trigger strap and housing retention are required.

### Dynamic BOM material selection — 2026-09-27

User requested on-hand PLA/PLA+, PETG and TPU checkboxes plus a “Most Optimal Layout” override that disables them. The viewer combines the two static stage columns into one dynamic Material column and colors the BOM models to match. Working interpretation: layout means material assignment, not changed geometry. Best recommendation is PETG structure plus planned TPU soft parts and conventional metal/textile hardware. Unchecking the override restores the previous selection; no new accessory exports are implied.

### Stock trigger visualization — 2026-09-27

User requested a visible black squeeze trigger in Full tool, pivoting as Lever stroke changes, with the bicycle inner-wire/Velcro tie moving with it. Added a separate stock trigger envelope and pivot; corrected the simplified fixed grip so the trigger is distinct. No new dimensions were supplied: contour, pivot and 27.5° animation sweep are provisional. The slider prescribes movement and cable/spring connectivity, not force response or measured travel validation.

### Spring visualization — 2026-09-27

User requested recognizable springs instead of cylinders. CAD and BOM references now show helical wire for both metal springs, with closed eyes on the extension spring and legs on the torsion spring. The viewer changes extension-coil pitch during squeeze, keeping wire diameter and eyes unchanged. Visual extension-wire diameter 0.8 mm / 24 turns and return-coil 0.4 mm / 5.5 turns are illustrative only; they do not establish the required spring rates, force or fatigue life. No printed components or purchase quantities changed.

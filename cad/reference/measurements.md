# Measurement record

All dimensions are millimetres. Recorded 2026-09-27. User-supplied values
are not independently verified; do not substitute prior CAD defaults for
missing measurements.

## Phone

The selected button is **volume up**. D is measured along the phone from
the charging-end outer edge to the button center. H is measured through
thickness to button center; the datum for supplied H values needs confirmation
after the user corrected the orientation of the assistant's side-view diagram.
T is the outside thickness at the jaw contact region, excluding camera bump.

| Configuration | L | W | D | T | H | Source |
| --- | ---: | ---: | ---: | --- | --- | --- |
| iPhone 15 Pro, bare | 146.6 | 70.6 | 102 | 8.25 | 4 | L/W/D reported from online; T/H supplied by user |
| User's phone in wallet case | 152 | 76 | 105 | 18 | 12 | User measurements; case has rear credit-card storage |

H=12 may be measured from the rear wallet surface; if so, button center
is 18-12=6 mm from the front outside plane. Do not encode that inference
as a confirmed measurement. With screen facing the observer, volume buttons
are on the left and the power button on the right.

User called the cased device “iphone 15”; confirm that it is the same
iPhone 15 Pro before assigning this envelope to a device profile.

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
- Adjustable volume-up actuator holds the button while the trigger is held.
- Compact housing anchor and removable trigger attachment as in concept 3a.
- Keep measured samples separate from provisional design ranges.

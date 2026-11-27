# V4 cord adjustment concepts — 2026-11-09

User requests tension options without assuming an inline rubber band. These
are isolated visual concepts, not promoted manufacturing geometry.

**Decision:** User rejected these options for now and will manually manage
string tension. Do not promote them or assume an inline rubber band is required.

A: a flat PETG wrap cleat near the trigger. Continuous effective-length
adjustment by pulling the free tail and locking wraps around the cleat neck.
B: a flat PETG loop ladder. Closed slots offer discrete attachment positions.
C: a flat TPU serpentine link. Knots set coarse length; bending can absorb
extra pull without a separate rubber band. Force, creep and useful travel
are unmeasured. The link is an experiment, not a calibrated force limiter.

A/B change rest length only. They cannot absorb full trigger take-up after the
phone button is pressed. Before a full-squeeze design is accepted, determine
trigger take-up, released button gap, required button motion and acceptable
force. A smaller trigger attachment radius may reduce take-up, but its actual
pivot/access geometry needs measurement before proposing a fitted attachment.
The local return band is retained; a take-up spring pulling toward the phone
could hold the button down. The current 12.6 mm stop prevents plunger escape,
not excessive button force. Harness slip must still be resolved by the liners.

The page uses flat 3 mm extrusions with vertical through-openings and no
undercuts. This is a support-avoiding design strategy, not a verified slice.
Actual supports, tolerances, string wear/slip, TPU response and loaded strength
remain untested. No print submitted. No mechanism promoted.

The tool-route view includes the accepted actuator meshes as context and a
shortened schematic shaft/trigger. The path is illustrative, not a clearance
or motion audit. It deliberately does not reuse V3's old inline-band path.
Cords terminate with schematic ties; final knot clearance requires review.

Reproduce by copying index.html/concepts.js into the matching built-site
concept path. Requires the shared view cube, annotation modules, and generated
steep-stop actuator meshes already used by the V4 review site.

# V2 compact-rails-r12 manufacturing files

**Plate 01 completed successfully; revised plates 02/03 prepared for review.** See the [2026-10-03 five-plate review](jobs/2026-10-03-current-low-waste/README.md) for the current files, settings, support previews and checksums. Reuse the user’s two successful screws and two nuts; the fixed jaw is now complete and seventeen pieces remain. The user confirms plate 01 finished and its supports peeled off easily. Remaining plates await review. The user declined another coupon. Do not send earlier r10/r11 prepared or uploaded jobs as this revision.

STLs are millimetres, 100% scale and bed-oriented. Carrier, shaft cap, sliding jaw, actuator bracket, rocker, pivot key and new dual-eye string guide changed from r11. The successful screw/nut designs remain reusable. The revised rocker and pivot key must be printed together with the updated bracket. Use two exact copies of the original centered-eye string guide and one new dual-eye guide nearest the harness. Earlier revisions are in [Git history](../history.md).

## Quantities

Ten designs / twenty-two pieces: carrier ×1, shaft_cap ×1, sliding_jaw ×1, actuator_bracket ×1, rocker ×1, pivot_key ×1, thumb_screw ×7, thumb_nut ×6, string_guide ×2, dual_string_guide ×1. Four screw/nut pairs close the collar; two clamp the actuator; one screw contacts the button. One continuous twine length and seven modeled rubber bands remain. Count retained successful fasteners before making more.

## Layout and validation

Both actuator positions are beside the shaft on the 160 mm paired rail, now integral with the removable shaft cap. Turn the phone end-for-end for originally outer-edge buttons. The large example shifts 20 mm along the jaws. Four collar screws form opposing pairs at Z −24/−76 mm:52 mm spacing, 102 mm collar. The 11.6 ×17.6 mm opening is unchanged from the accepted short coupon; full-length closure and loaded strength remain unvalidated.

Read the current [V2 README](../README.md) for the service path and rotated-camera framing concern. The camera keepout is transformed with the phone; expanded rotated viewing envelopes intersect carrier/bands. A clear lens block does not establish a clear image.

## Before slicing

- The successful short coupon used 0.2 mm layers, three walls, 15% gyroid, no brim and cut-end-on-bed orientation. This does not automatically qualify full-part strength or orientation.
- The earlier roof-down supports were difficult to remove. Prioritize accessible/support-free mating surfaces. Do not reuse that full-size slice or inherit tight 0.12 mm support gaps when using 0.2 mm model layers.
- Keep successful thread geometry and its 0.12 mm layer recipe. Existing original-size 8×3 screws/nuts are compatible. Never support inside threads.
- Investigate low-density infill first, with adequate local walls at clamp ears, roots, rails and pivot. Avoid blanket 100% infill. Report model versus support consumption separately.
- Arrange actual supports and brims within the A1 mini bed; respect its purge areas. Verify nozzle, material, bed, object quantities, warnings and toolpaths. Manufacturing mesh bounds alone are not print approval.

No extra coupon is scheduled. Following layout approval, prepare and review fresh carrier/cap slices first, then the remaining changed jaw. Validate closure with alternating gentle tightening, interface cleanup, cap service, band grip, button alignment, return and actual camera framing before field use.

Inset-guide update: carrier, shaft cap and actuator bracket exports replace the prior Z−32 upper-hole layout. Use these matching parts together; the nominal shaft opening, lower pair and fastener quantities stay unchanged. The bracket’s press/return stop tabs are intentional.

Indexing-ledge refinement: the bracket now has a 4 mm-wide outer support joining the upper beam, replacing its thin 1.5 mm connector. Use the refreshed actuator bracket STL. The linked 2026-10-03 low-waste review includes this refinement. Earlier jobs and reference slice estimates do not qualify this revision; physical support removal and assembly fit still require testing.

Plate 01 orientation update: prioritize the fixed jaw’s sliding track finish. The current `01-carrier-neck-contact` job places support against the static neck-contact face and prints the track vertically. It supersedes `01-carrier`; remove support residue from the neck face before checking seating. Other plates are unchanged.

Plate 02 now contains only the flat shaft cap, with all four fastener ears on the bed. Sliding jaw moved to plate 03 beside the bracket and three guides. Exact sliced files and complete per-plate profiles are preserved in the linked job record for reproducibility.

Current guide STL/STEP exports now have edge-aligned eyes (2026-10-04); auto-support validation generates no supports. Saved plate 03 job files remain the historical printed geometry. Do not reuse those jobs to manufacture the revised guides. No new print is scheduled.

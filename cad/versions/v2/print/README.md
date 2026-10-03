# V2 compact-rails-r12 manufacturing files

**Printing is paused for layout review.** The user declined another coupon. Do not send earlier r10/r11 prepared or uploaded jobs as this revision. These are geometric exports, not an approved full-harness slice. Review orientation, support cleanup and low-material settings before submission.

STLs are millimetres, 100% scale and bed-oriented. Carrier, shaft cap, sliding jaw, actuator bracket and string guide changed from r11. Rocker, pivot, screw and nut remain reusable. Print three copies of the revised broad-face string guide. Earlier revisions are in [Git history](../history.md).

## Quantities

Nine designs / twenty-two pieces: carrier ×1, shaft_cap ×1, sliding_jaw ×1, actuator_bracket ×1, rocker ×1, pivot_key ×1, thumb_screw ×7, thumb_nut ×6, string_guide ×3. Four screw/nut pairs close the collar; two clamp the actuator; one screw contacts the button. One continuous twine length and seven modeled rubber bands remain. Count retained successful fasteners before making more.

## Layout and validation

Both actuator positions are beside the shaft on the 160 mm paired rail, now integral with the removable shaft cap. Turn the phone end-for-end for originally outer-edge buttons. The large example shifts 20 mm along the jaws. Four collar screws form opposing pairs at Z −32/−76 mm:44 mm spacing, 102 mm collar. The 11.6 ×17.6 mm opening is unchanged from the accepted short coupon; full-length closure and loaded strength remain unvalidated.

Read the current [V2 README](../README.md) for the service path and rotated-camera framing concern. The camera keepout is transformed with the phone; expanded rotated viewing envelopes intersect carrier/bands. A clear lens block does not establish a clear image.

## Before slicing

- The successful short coupon used 0.2 mm layers, three walls, 15% gyroid, no brim and cut-end-on-bed orientation. This does not automatically qualify full-part strength or orientation.
- The earlier roof-down supports were difficult to remove. Prioritize accessible/support-free mating surfaces. Do not reuse that full-size slice or inherit tight 0.12 mm support gaps when using 0.2 mm model layers.
- Keep successful thread geometry and its 0.12 mm layer recipe. Existing original-size 8×3 screws/nuts are compatible. Never support inside threads.
- Investigate low-density infill first, with adequate local walls at clamp ears, roots, rails and pivot. Avoid blanket 100% infill. Report model versus support consumption separately.
- Arrange actual supports and brims within the A1 mini bed; respect its purge areas. Verify nozzle, material, bed, object quantities, warnings and toolpaths. Manufacturing mesh bounds alone are not print approval.

No extra coupon is scheduled. Following layout approval, prepare and review fresh carrier/cap slices first, then the remaining changed jaw. Validate closure with alternating gentle tightening, interface cleanup, cap service, band grip, button alignment, return and actual camera framing before field use.

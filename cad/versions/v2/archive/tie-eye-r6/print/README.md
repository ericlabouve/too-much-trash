# V2 tie-eye-r6 manufacturing files

**Successful isolated thread trial:** the user reported that the **original-size 8 mm × 3 mm trapezoidal trial** printed and fit perfectly at 0.12 mm layers. The original and enlarged 12×4 trials failed. Use the successful trial in [`thread-trials/original-size-trapezoid-8x3/`](thread-trials/original-size-trapezoid-8x3/). These trial parts are not compatible with the current assembly. The original assembly exports are preserved while we establish a printable thread.

Use these STL files at **100% scale in millimetres**. They are already bed-oriented. See [quantities, PLA+ settings and assembly sequence](../README.md#prototype-printing). Use the successful 8×3 trial pair for reprints while the active mating parts await conversion; do not repeat the failed active 8×2 screw/nut batch.

Eight designs / thirteen pieces: carrier ×1, sliding_jaw ×1, actuator_bracket ×1, rocker ×1, pivot_key ×1, thumb_screw ×3, thumb_nut ×2, string_guide ×3.

The reference slice uses a Bambu A1, 0.4 mm nozzle and Generic PLA; your actual printer and PLA+ preset are not specified. The rocker needs a 20° support threshold in that reference profile to avoid support inside the threaded bore. Inspect actual layers and support access. `slicer-review.json` binds results to exact STL hashes; PNGs show sampled extrusion layers (orange model, blue support). These are fit-prototype exports, not proof of physical function.

These files match the official reinforced V2 viewer. Carrier, sliding jaw, actuator bracket, rocker, pivot key and shaft guide replace recessed-r3; the screw and nut designs are unchanged. Previous exports are preserved in `../archive/recessed-r3/print/`. These remain mechanical fit-prototype files; actual camera framing, guide strength and twine friction are unvalidated.

The active bracket now has open knot access. Replace only `actuator_bracket.stl` when upgrading from reinforced-r4; other seven printable designs are unchanged. The former bracket crowded the intended stopper knot. Read the attachment and physical-check sequence in the V2 guide before assembly.

Active tie-eye-r6 replaces the stopper attachment with a loop tied around an 8 mm rocker eye. Replace `rocker.stl` and `actuator_bracket.stl` when upgrading from knot-access-r5. Other printable designs are unchanged. Tie the loop before mounting the actuator; the knot is not required to be larger than the eye.

## Historical first V2 print sequence — thread audit, 2026-09-30

The sequence below predates the failed 8×2 prints and successful isolated 8×3 trial. Do not follow its old thread batch until the mating assembly has been revised. The 2026-10-02 autonomous trial reprint is recorded in [jobs/2026-10-02-thread-pair/job.json](jobs/2026-10-02-thread-pair/job.json).

The user accepts checking trigger attachment, band sizing/force, slack/return and camera framing after the first print. These do not block the initial fit-prototype print. The thread audit required no geometry change. Use PLA+, 0.4 mm nozzle, 0.2 mm layers, 100% scale, and the supplied bed orientation. [Thread audit](../review/thread-printability.json) records the dimensions and STL cross-sections.

| Batch | Print | Validate before proceeding |
| --- | --- | --- |
| 1 | `thumb_screw.stl` ×1; `thumb_nut.stl` ×1 | Clear loose stringing, start squarely and turn using fingers only. The nut should travel along the usable threaded shaft and back without binding, skipping or stripping. No pliers or forced engagement. If it fails, retain both parts and report whether it binds at the entry or throughout; do not resize the complete assembly. |
| 2 | `rocker.stl` ×1; `actuator_bracket.stl` ×1; `pivot_key.stl` ×1; `string_guide.stl` ×1 | Test the same screw in the rocker. Remove supports fully; verify free pivot motion, quarter-turn retention and both stops. Tie the actual twine loop, fit the return band, and pull/release off the phone. Confirm the guide threads easily and its saddle/band fits the real shaft. |
| 3 | `carrier.stl` ×1; `sliding_jaw.stl` ×1; **additional** `thumb_screw.stl` ×2, `thumb_nut.stl` ×1, `string_guide.stl` ×2 | Verify sliding-jaw travel, both rail mounting positions and gentle hand tightening. Assemble the actual bands/twine and check trigger attachment, full squeeze/release, friction, grip, collar slip, and camera framing. Set button contact only after reliable off-phone return. |

Successful prints from earlier batches count toward the finished assembly: **3 screws, 2 nuts, 3 guides, and one each of the other five designs = 13 pieces**. No V1 neck caps or handle anchor are required for V2.

Screws/nuts/pivot: 6 walls and 100% infill (Zig-zag in Bambu Studio). Carrier/jaw: 5 walls, 35%. Bracket/guide: 5 walls, 40%. Rocker: 5 walls, 60%. Screw and nut: no supports. Other parts need support review as listed above; use the reference rocker's 20° support threshold only as a starting point and keep its threaded bore empty. The other supported reference parts use 30°. Review layers in your own printer/material profile before printing.

The thumb screw has external threads; the nut and rocker contain the matching internal threads. This is a custom 8 mm / 2 mm pitch thread, not an off-the-shelf metric thread specification. The 2 mm pitch spans ten layers at 0.2 mm, the thread depth is 0.8 mm, and the crest's 0.5 mm axial flat spans 2.5 layers. Nominal female radial clearance is 0.30 mm. The current reference slices preserve the threads; print fit remains the deciding check.

The latest original-size trial uses 0.12 mm Fine on A1 mini / 0.4 mm nozzle, with slower walls and cooling settings documented in the V2 README. Do not reuse the old 0.2 mm thread trial settings. The two trial files retain the original outer sizes, and do not mate with old 2 mm-pitch parts.

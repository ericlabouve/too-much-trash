# Too Much Trash: project guide

## Purpose

Too Much Trash is a research and product project for teaching robots to recognize and eventually pick up litter. Its first step is a practical way to collect egocentric video of real pickup attempts. A person uses a stock reacher grabber fitted with a neck-mounted iPhone and holds a separate collection bucket in the other hand. A mechanical bicycle brake cable couples the grabber's squeeze trigger to a lever at the phone's volume button, marking each grasp while a rolling video buffer preserves the approach. Deposits, misses, drops, and rejections can then inform review and self-supervised labeling.

The aspiration is a useful, varied dataset and a humane path from field capture to segmentation, classification, and imitation-learning research. Treat the hardware and automatic labels as hypotheses until they are measured and validated. Preserve failed attempts and uncertain outcomes; they are part of the research signal.

## Repository map

| Path | Intent |
| --- | --- |
| `compose.yaml`, `.env.example` | Define the hosted stack and its local configuration shape. |
| `backend/api/` | uv-managed FastAPI service for client-facing endpoints and future capture metadata and media coordination. |
| `backend/caddy/` | Reverse proxy and browser UI serving layer. |
| `backend/postgres/` | Database initialization and future schema or migration support. |
| `backend/workflows/` | Prefect flows for ingestion, event alignment, frame extraction, proposed labels, and review processing. |
| `frontend/src/` | Shared browser and Electron interface; keep visual language consistent with iOS. |
| `frontend/electron/` | Secure desktop shell for the shared interface. |
| `ios/` | Dedicated SwiftUI iPhone experience, including eventual capture and review. |
| `ml/training/` | Reproducible image and video segmentation and classifier training code. |
| `ml/experiments/` | Research questions, run records, comparisons, and evaluations. |
| `cad/reference/` | Photos and measurements of the exact physical reacher model. |
| `cad/renders/` | Technical concept drawings used to communicate mechanical intent. |
| `cad/source/` | Editable CAD models and assemblies for the retrofit. |
| `cad/print/` | Reviewed printer-ready exports, including Bambu Studio 3MF files. |
| `docs/` | Development notes and cross-cutting design decisions. |

## Design intent

Use the photo in `cad/reference/reacher-grabber.png` as the specific grabber geometry. The iPhone belongs on the straight neck below the claw fork in a removable, GoPro-like harness. Its rear cameras face along the shaft toward the claw tips and remain uncovered. Keep the phone and mount outside the moving claw sweep. Route the bicycle brake cable externally, with a housing anchor near the handle and a removable flexible strap on the moving black trigger. Avoid drilling the stock handle or depending on its screw holes. A compact cable-driven lever at the phone should press a side volume rocker.

For concept drawing pairs, positive y points up along the grabber shaft. In a views, positive x points right and positive z comes out of the page toward the viewer. In b views, the camera and axis key rotate 90 degrees about y: positive z points left and positive x comes out of the page. Keep each sheet to one view, with a small x/y/z axis glyph and a white background. These are concept illustrations, not proof of fit or working force transmission.

Use the measured rectangular silver neck: 14 mm along project X and 19 mm along project Z, including ribs. This supersedes the square-section assumption in the concept drawings. The later accepted PLA+ collar fit (2026-09-28) supersedes the derived clamp opening: use 11.6 mm local X × 17.6 mm local Y while preserving outer geometry and bolt centers. Keep the earlier stock measurement as historical reference; see cad/reference/measurements.md. The only blue stock parts are the shaft's center brace and the handle; color every added 3D-printed retrofit component orange. Keep the original metal silver and the stock claw feet and squeeze trigger black.

Each image in `cad/renders/` has an adjacent `.spec.json` file. Treat these sidecars as the record of user-provided positioning and component requirements when revising or replacing a drawing. Update the relevant sidecar whenever the user adds a constraint. In assembly and phone-mount a views, place the phone to the positive-x side and into negative z so its near thin long edge rests against the neck support while its short charging-port edge remains visible. Keep the earlier centered phone placement in 1b and 2b; the a-view translation was requested only for 1a and 2a. The b views turn 90° around the shaft and show the phone's long edge. In the rotated complete and handle views, the blue upper handle head is visible while the black squeeze trigger is occluded.

Keep the public README focused on the project's purpose and aspirations. Put setup instructions and implementation details in `docs/` or the relevant component directory.

The approved R4 CAD layout supersedes the earlier illustrative phone offsets: Option B keeps the phone beside the shaft on negative X, with its length centered on the gripping band. Put the bridge behind the camera face, provide either-side actuator interfaces, and route housing centrally on the trigger-facing neck surface. Preserve the original concept images and record these later constraints in their metadata.

## Printer workflow

For requests to connect to the Bambu printer, configure a CAD print, or send a print job, use the repository skill at [`.agents/skills/bambu-print/SKILL.md`](.agents/skills/bambu-print/SKILL.md). The CLI print cycle completed a live test with touchscreen extrusion confirmation; keep credentials out of the repository and distinguish monitored completion from physical fit or unattended operation.

## Product versions

**Current history policy (supersedes earlier archive-directory instructions below):** Keep only current V1 and V2 in the working tree and viewer. Preserve earlier V2 revisions through Git commits, not duplicated archive folders. Existing snapshots are recoverable at `f8f11822459f5e140ed34d06caa46a720999467c`; see `cad/versions/v2/history.md`. References below to archive paths describe paths in that historical commit. Keep physical experiment records; do not recreate archive directories for future design changes.


The checkpointed R4 prototype is product Version 1 (`printed-prototype-checkpoint`, `ade5b54`). V2 is isolated in `cad/versions/v2/`; the active revision uses adjustable opposing band-clamped jaws and either-side actuator rails using only PLA/PLA+, one continuous twine length, and rubber bands, with no padding or metal hardware. The user reports bands roughly 2–3 cm in radius; force, thickness and twine diameter remain unknown. Do not confuse V1/V2 product versions with earlier R2/R3/R4 revisions. Preserve V1 source, standard exports, BOM and `viewer-v1.html`. Register additional viewers in `cad/versions.json`. Preserve the earlier dedicated V2 under `archive/dedicated-r1/`. V2 `print/` contains bed-oriented fit-prototype exports; `review/` contains visualization meshes. Neither establishes physical validation; its new open saddle is not the accepted V1 collar assembly.

The user selected the recessed rail study as the preferred V2 direction on 2026-09-30. The recessed layout is now promoted to active `cad/versions/v2/source/`, viewer and print exports (recessed-r3). Preserve the raised-rail reference under `cad/versions/v2/archive/raised-r2/`. Camera-view clearance remains unresolved; the comparison study imports the archived raised baseline for reproducibility.

Active V2 reinforced-r4 replaces thin guide rings with supported D-shaped lugs (8 mm bore, 11 mm flared mouths, 6 mm thickness). Preserve recessed-r3 under `cad/versions/v2/archive/recessed-r3/`. Twine diameter is unknown; 3 mm passage checks are provisional. Lower routing, revised rocker and further-recessed rails remain physically unvalidated. Camera sensitivity results are in `review/route-validation.json`; do not equate them with measured framing.

Active V2 knot-access-r5 opens the bracket above the rocker attachment. Preserve reinforced-r4; its knot was omitted from earlier clearance checks and collided with the bracket roof. The knot remains an illustrative envelope, not a tested termination. See attachment-audit.json and the physical-check sequence in the V2 README.

Active V2 tie-eye-r6 supersedes the stopper-knot attachment at the user’s request. Twine forms a closed loop through the 8 mm rocker eye and around its front ligament, then ties back to the standing string. Preserve knot-access-r5. The viewer shows a moving schematic loop. Only rocker and bracket geometry change from r5; physical knot security and strength remain unvalidated.

For the first V2 print, the user accepts trigger attachment, band behavior, slack/return and camera framing as post-print checks. Do not hold the first fit-prototype print for those issues. Thread audit and staged print sequence are recorded in V2 review/thread-printability.json and print/README.md. No thread geometry change was required for the assumed 0.4 mm nozzle / 0.2 mm layer baseline; actual fit remains untested.

The original V2 threaded print failed according to user feedback. This supersedes the prior digital printability conclusion. An isolated 12 mm major / 4 mm pitch / 1.5 mm depth trial is in `cad/versions/v2/print/thread-trials/coarse-12x4/`, built by `source/build_thread_trial.py`. Active assembly remains the old thread geometry; do not mix the trial pair with it or claim the coarse thread is validated. Obtain physical trial feedback before propagating changes to mating rocker/rails/bracket.

The enlarged 12×4 thread trial also failed. User now requires original screw/nut outer dimensions and reports A1 mini / 0.4 mm nozzle / 0.2 mm layers, with malformed as-printed threads. The original-size-trapezoid-8x3 trial (custom 90° included trapezoid, not standard ACME) was printed at 0.12 mm layers; the user reported that this print worked perfectly. Preserve earlier trials and do not enlarge bodies again. The active assembly still uses the old 2 mm-pitch thread, so do not mix its mating parts with the successful 3 mm-pitch trial.

## Active thread promotion — 2026-10-02

V2 `thread-8x3-r7` supersedes the earlier notes saying active threads remain 2 mm pitch. The screw and nut now use the exact successful original-envelope 8×3 trial geometry; the rocker has matching internal threads and 0.6 mm entry lead-ins. Preserve `cad/versions/v2/archive/tie-eye-r6/`. Existing successful trial fasteners are reusable. Use 0.12 mm layers for all three threaded designs. Isolated print success does not validate physical rocker fit or loaded assembly. See `review/thread-promotion.json` and `print/README.md`.

The 2026-10-02 automated thread-pair print completed and the user confirmed success and a cleared bed. The extrusion-confirmation prompt required the user's touchscreen intervention; the cycle is not fully unattended. Keep this distinction when describing automation.

## Closed shaft clamp and lighter bracket — 2026-10-02

Active V2 `closed-clamp-r8` replaces the two band shaft attachment with a rigid printed split collar/cap and two printed 8×3 screw/nut pairs. Preserve `archive/thread-8x3-r7/`. Opening target 11.6 × 17.6 mm, collar length 74 mm, fastener stations 54 mm apart, split gap 1 mm; this new fit/retention is unvalidated. Remove actuator module before cap removal toward local +Y. Two rounded bracket windows remove 23.0% of solid CAD volume, preserving plate thickness, slots and mechanism interfaces; stiffness/strength are not established. Nine designs, eighteen printed pieces, seven bands. Existing successful fasteners remain reusable. Printing is paused by user; the previously uploaded r7 actuator job is superseded and must not be started as this revision.

The r8 collar sits toward the handle at local Z −86..−12 mm, clear of the modeled blue brace ending at −90 mm. First shaft guide moves to −130 mm, below the brace; other stations stay −175/−300 mm. New clamp screws are outside tested illustrative camera envelopes; actual framing remains unvalidated. Matched bracket slices estimate 11.4% less filament including supports, versus 23.0% less CAD solid volume.

## Screen clearance — screen-clear-r9

User requested removal of the shaft fastener from the screen view. Preserve `archive/closed-clamp-r8/`. R9 rotates the collar split so it opens toward local +X after actuator removal; both fastener axes run along X with heads/nuts beside the shaft. Stations are (Y,Z)=(-25,-36),(25,-76), 40 mm axial separation; collar spans Z −86..−26 (60 mm). Nominal opening and successful screw/nut geometry are unchanged. Carrier/cap change; bracket and other print designs stay unchanged. `build.py` now checks cap/shaft-fastener obstruction of the modeled straight-on screen across all eight configurations. Clamp stiffness/retention and oblique screen visibility remain physical checks. Print pause remains in effect. R8 slice estimates are historical until current files are resliced.

## Extended harness-to-neck support — extended-saddle-r10

User rejected r9's narrow carrier connection. Preserve `archive/screen-clear-r9/`. R10 extends the collar from 60 to 102 mm (Z −86..16), with screw stations (Y,Z)=(-25,6),(25,-76), 82 mm axial separation. Twin 5 mm tapered webs and a solid jaw root broaden the carrier connection across 27.6 mm. Only carrier/cap geometry changes; successful threads and lighter bracket remain unchanged. Cap removal after actuator/screws removal follows +X about 6 mm, then −Y past the rail, then away; upper cap relief leaves 3.5 mm wall and nominal side clearance about 0.7 mm. Test this path physically. Opening 11.6 × 17.6 mm remains a fit target, not verified stock CAD clearance. Longer fit, structural strength, loaded retention, camera framing and twine friction are unvalidated. Printing remains paused; reslice current files only after review.

## Astra preprint review — r10 service access

Retain r10 geometry for initial fit. Near-side wallet/bare/small actuator inner rail screw cannot withdraw at Y5 because the long cap obstructs its head. Before cap service: remove phone, release twine tension, loosen rail nuts, slide complete module +20 mm Y to screw centers25/73, remove nuts/module outward+X, then rail screws−X; large centers41/89 already clear. Remove clamp fasteners, then follow cap dogleg. Reverse for assembly. `source/check_service_access.py` tests this prerequisite. See `cad/versions/v2/review/astra-design-review.md`. Cap-ear bending/preload remains a physical risk; no demonstrated need to change geometry before fit. Reference `check_slices.py` now defaults to A1 mini, uses manifest layer heights, and gives the cap40% infill; Generic PLA reference slices are not qualified PLA+ jobs. Print pause remains.

Active V2 opposed-clamp-r11 preserves the successful 11.6 × 17.6 mm short-coupon sizing and end-oriented print. User observed a V-shaped split when tightening the one-sided coupon. Both carrier and cap now have four matching stations: (Y,Z)=(-25,6),(25,-76),(25,-32),(-25,-76). Direct upper opposition at (25,6) collides with the near actuator. Lower coupon uses two opposing fasteners; full clamp has four. Nine designs /22 pieces: screws7, nuts6. Preserve r10 and old coupon exports. Closure/retention remains unvalidated; no full print before new coupon closure and low-waste slice review.

Active V2 compact-rails-r12 supersedes the r11 layout: user chose end-for-end phone rotation in the screen plane. Both actuator positions are on a 160 mm paired shaft-side rail; remove outer-jaw rail/guide. Same actuator/threads in both positions. Large example phone shifts20 mm along jaws to limit rail length; original button-side selector now implies rotation. Four collar fasteners form opposing pairs at Z−32/−76 (44 mm spacing), collar length102 unchanged. Twine crossover is lowered. Rotated lens envelope is transformed correctly, but expanded camera-view envelopes intersect carrier/bands; framing unresolved. User explicitly declined the two-fastener coupon. Printing remains paused pending layout and fresh low-waste slice review. Preserve old designs in Git only.

R12 compact refinements: jaw bands centered at Y ±6 mm on raised retaining posts. The paired rail is now integral with the removable shaft cap, through a 24 mm-wide ×22 mm-high web. Do not recreate a closed bridge around the stock neck: both halves must install sideways. Bracket gains a lower captive twine guide, so it is a changed manufacturing part. Printed strength and real camera framing remain unvalidated.

The later r12 routing revision removes the carrier’s entire two-eye crossover arm. Use captive actuator guides and three broad-face shaft guides; rotate guides 180 degrees around the shaft for the opposite actuator side. New string-guide prints are required. The earlier framed-guide arrangement is recoverable at `0ced78d`.

Final guide selection requested by user: two exact copies of the original centered-eye `string_guide` plus one `dual_string_guide` nearest the harness, with opposite selectable eyes. Ten printable designs, twenty-two pieces. Do not replace all three with the temporary single-sided broad-face guide.

The actuator bracket now has one guide in a broad bottom foot (bore local 34,0,−55; broad foot and extended central plate root); its redundant upper guide is removed. Shaft guide stations are −190/−230/−300 mm: the first dual-eye position is lowered to clear clamp-screw tips. Modelled cord sweep passes do not validate friction or force.

Pivot insertion correction: original 8.4 mm cross-tab could not pass the round 6.5 mm rocker bore. Rocker now has a 9×2.2 mm keyway in a 12 mm boss. Four-flat pivot head and revised indexing ledge permit aligned insertion, quarter-turn and seating; `check_pivot_assembly.py` checks the complete path plus geometric retention obstructions. Rocker, pivot and bracket are changed parts; only screw/nut thread geometry remains physically print-validated.

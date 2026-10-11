# Too Much Trash CAD memory

Last reconciled: 2026-10-11. This is the canonical memory for the `cad-agent` skill. Maintain it freely during CAD work: record accepted decisions, user preferences, evidence and unresolved questions; remove superseded guidance rather than accumulating contradictory instructions. User instructions take precedence. Memory never grants permission to print, publish, commit, or change unrelated systems.

## Start and finish a session

- Confirm the actual checkout, branch, status and served directory before editing. The CAD branch is currently `cad-agent`; paths and ports are environment-specific. Preserve overlapping work and investigate unexpected files before staging.
- Read `cad/versions/v3/README.md`, relevant source and reports for current dimensions. `cad/versions.json` registers V1, V2 and V3 and defaults to V3.
- Change the editable source, regenerate affected exports and reports, inspect the result in 3D, and run relevant checks. Verify metadata, BOM, animation and assembly instructions agree with the geometry.
- Keep intentionally tracked review meshes: they power the viewer. Keep manufacturing exports, exact experiment inputs, profiles, hashes and outcomes. Exclude environments, caches, credentials and incidental root-level slicer outputs.
- Distinguish valid solids, collision checks, reference slices, observed print completion and physically verified fit/strength. Never promote one into another.

## Version and architecture boundaries

- V1 is the preserved printed prototype. V2 is preserved before the deeper-jaw/single-cleat redesign, including its translated guide eyes and historical print jobs. Iterate exclusively in V3 unless explicitly instructed otherwise.
- Preserve earlier geometry through Git, not duplicate historical source/archive directories. Never overwrite a print-job record with geometry newer than the parts actually printed.
- `cad/versions/v3/source/plunger_design.py` owns the actuator; `model.py` owns the harness and assembly; `build.py` generates meshes, STEP, BOM and provisional manufacturing exports. Current details and report pointers belong in the V3 README, not duplicated here.
- The removable shaft cap must install sideways; do not recreate a closed structural loop requiring the grabber to be threaded through it. The actuator rail belongs to that removable cap.
- Turn the phone end-for-end in its screen plane for opposite-side buttons; do not roll it about its long axis. Keep hardware outside usable screen and camera areas, and check service paths as well as assembled clearance.
- Current construction uses printed PLA/PLA+ parts, rubber bands and twine, not metal hardware or padding. Added printed parts are orange; stock shaft silver, brace/handle blue, claws/trigger black.

## User preferences

- Interpret highlighted screenshot regions literally. If an edit changes the requested spatial intent, explain it and obtain direction; use concrete 3D geometry to resolve ambiguity.
- Prefer compact, coherent load paths and rounded, smoothly blended transitions. Avoid thin connecting necks, gratuitous trays/covers, unnecessary pieces and support on sliding/mating surfaces.
- Prefer low-material prototypes and deliberate bed-contact planes. Do not trade away bore ligaments, locating engagement or structural roots merely to make an outline flat.
- The viewer must retain V1/V2/V3 selection. V3 annotations follow parts while orbiting; retain lighting-aware highlights, color selection and brush/rectangle/ellipse/arrow tools. V2 does not inherit V3-only controls.
- View-cube arrows rotate smoothly with drag distance. Hover and clicks without dragging must not rotate; no fixed 15-degree click steps. BOM floating labels must be toggleable.
- Verify the actual served checkout and stale cache before diagnosing a missing change. A hard refresh has previously been necessary.

## Accepted V3 decisions

- Shared-cleat sliding plunger replaces the rocker. Use an open frame, a broad rounded rectangular contact shoe with a blended root, and a capped moving cleat shared by the twine and small return band. Twine wraps/ties near the T instead of threading through an eye.
- Pulley redirects directly to the nearest shaft guide; do not restore bracket guide holes or a zig-zag route. Two twine sections joined by an inline band provide a proposed separate overtravel provision. The return band is not overtravel protection.
- Pulley uses a smooth headed axle supported by two cheeks, a removable cross-key and a keeper band, not a free retaining nut or fragile snap finger. Check insertion, removal, running clearance and retention independently.
- Flush-T cap rail remains 120 mm. Single screw/nut plus locating lugs secures the actuator; lugs resist rotation but do not establish zero play, and preload must resist sliding.
- Current `flat-back-mount-v3` offsets plate, bore and full locating-lug envelope together to preserve a 5.4 mm bore-side ligament while aligning the plate and spine back at local Y5.4. The user explicitly approved this offset. Keep the opposite projection that carries the load; do not simply trim both sides. The reinforcement eases into the spine in width and height.
- Preserve the requested T-jaw, 100 mm contact spacing, 4 mm lips and 14 mm pocket. Recorded 18 mm wallet and 20 mm large-phone proxies deliberately remain incompatible; never shrink them to make checks pass.

## Validation and known limits

- V3 has not been printed. Button force, excess trigger travel, inline-band behavior, case/adjacent-button interference, real camera framing, friction, jaw strength and loaded retention remain unverified.
- The animation prescribes 0.65 mm stroke, not a physically validated safe stop. Bigger motion or a larger section is not proof of safety/strength. Current 21 printed pieces / 13 designs are a checkpoint, not a fixed requirement.
- Offset mounting changes reach asymmetrically. Do not reuse the earlier centered mount's reach limits. Consult `review/compact-keyed-plunger.json`; near-side +24..+28 mm outgoing cord collides with the carrier, while +29 clears in the recorded samples.
- Run current applicable checks for solids, motion, band/twine routing, mount bearing, button envelopes and service access across the eight standard configurations. Preserve reported phone-fit failures. Historical rocker checks do not validate the plunger.
- Viewer tests include `cad/tests/viewer-plunger.cjs` and `viewer-annotations.cjs`; the older `viewer-interactions.cjs` targets V2. Check runtime paths locally. Staged assembly views are not collision-validated continuous insertion animations.
- `review/flat-back-slice/comparison.json` records matched Generic PLA / A1 mini reference slices: approximately 67% less support and 15% less total filament for the flat back. This is an offline estimate with remaining local supports, not a qualified PLA+ print or permission to send one.

## Printing handoff

- Read `bambu-print/SKILL.md` and its relevant references before slicing, printer setup or control. Obtain current authorization and bed/material readiness before sending a print. Never infer completion from a start command.
- Original threads and an enlarged 12x4 trial failed. The user confirmed the original-envelope 8x3 trapezoidal trial printed successfully at 0.12 mm layers. Changed long collar screws and the loaded assembly are not thereby validated.
- Support-heavy orientations left rough functional surfaces. Tree Organic plate 2 failed adhesion and was stopped; Normal Snug reprint succeeded. Preserve these observations without assuming one support style always wins.
- Do not repeat the extra two-fastener coupon the user rejected. Record exact orientation, machine/filament/process and per-object settings, input/output hashes, and observed outcome.
- V2 `print/jobs/2026-10-04-combined-45/` records a RUNNING start but a pending outcome. Do not claim completion without new evidence. Keep credentials only in private configuration, never in Git or this memory.

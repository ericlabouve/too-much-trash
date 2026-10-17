# V3 actuator — one-plate slice review

User requested a single plate and support preview, not a print start. Revision `plain-clamp-mount-v3`; seven separate pieces at 100% scale: actuator bracket, plunger, pulley, axle, cross-key, one short rail screw and one nut. No shaft cap, harness, collar screws or shaft guides. Nothing uploaded or sent to the printer.

Open `index.html` through the CAD server for the interactive 3D toolpaths, per-part focus, layer-height slider, support toggle, static projections, report and downloadable 3MFs. Model paths are orange, scaffold blue, support interface purple. These show actual sliced extrusion centerlines, not hypothetical support geometry or simulated beads.

## Recipe and estimates

- Bambu Studio 02.07.01.62; A1 mini, 0.4 mm nozzle, Textured PEI; Generic PLA reference recipe. Actual loaded spool and hardware have not been verified for a live job.
- Whole plate at 0.12 mm layers / 0.20 mm first layer, preserving the successful thread recipe. By-layer printing, 15% infill. Mechanism parts: 3 walls / gyroid. Screw and nut: 2 walls / grid.
- Normal Snug auto supports at 30°, enabled on bracket, plunger, pulley and axle; disabled on key and fasteners. Support may start on model surfaces. Top/bottom gaps 0.24 mm, XY separation 0.4 mm, two top/bottom interface layers and 0.5 mm interface spacing. No brim or raft.
- Bed/nozzle waits verified in generated G-code: 65/220°C.
- **14.15 g, 1 h 52 min**, estimated by the slicer; no warnings. **0.810 g** support/interface extrusion: bracket 0.587 g, plunger 0.145 g, pulley 0.048 g, axle 0.030 g. No support on screw, nut or cross-key.
- Placement and scale verified against sliced object bounds. Deposited footprints, including supports, fit within the bed and remain separated with a 0.6 mm combined path-width margin; no overlap with the recorded top-right detection zone.

## Support review

Bracket support occurs inside the pulley fork, mounting bore and beneath retaining lips. The common back is on the bed, without a broad underside raft. Plunger support is concentrated beneath the shared cleat cap, not beneath the long flat shoe/stem face. Small supports also occupy the pulley groove and the axle cross-key slot. Inspect and remove these carefully: support residues can impair wheel rotation, key insertion and guide fit. Automatic generation and small support mass do not establish accessible or damage-free removal.

This is a first-print review candidate. Printed strength, clamp retention, pulley/key/band fit, friction, button force and inline-band overtravel protection remain unverified. The full harness's known phone-pocket and inward-position conflicts remain; this actuator plate does not resolve them.

## Reproducibility

`inputs.json` records exact source STL hashes, orientation, scale, placement and intended object overrides. `actuator-input.3mf` is the editable arranged project. `actuator.gcode.3mf` contains the reviewed G-code; its embedded G-code matches `plate_1.gcode`. Full machine/process/filament profiles, CLI logs/results and intermediate layout projects are retained. `review.json` records effective settings, deposited role masses, clearances, heat waits and file hashes.

Prepared using `source/prepare_actuator_plate.py`; audited/rendered using `source/review_actuator_plate.py`. Do not overwrite this job when revising geometry or settings; use a new job directory. The preparation script refuses to replace an existing sliced job. Estimates and support drawings apply only to these exact files. No live printer connection was made.

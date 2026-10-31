# Concave boot and extended guide — two-piece review slice

Revision `concave-boot-guide-v3`. One actuator bracket and one sliding plunger, separate objects at 100% scale. User subsequently approved this exact plate and confirmed the printer ready. Uploaded with verified remote G-code hash; RUNNING/preheating observed on 2026-10-15 UTC (2026-10-14 local). See `preflight.json` and `start-record.json` for actual print status; the offline `review.json` remains the slice-time record. Completion and physical quality are not yet verified. Existing approved pulley, axle cross-key and screw/nut are not included.

Estimate: **9.69 g / 78.3 minutes**. Support/interface **0.0863 g**, all inside the bracket's round mounting hole. No support is generated on the plunger or extended guide. This does not establish surface quality, print strength, support removability or free sliding.

Recipe: recorded A1 mini / 0.4 mm nozzle / Generic PLA reference, textured PEI, 0.12 mm layers (0.2 mm initial), 3 walls, 15% gyroid, Normal Snug automatic supports. Explicit 0.24 mm top/bottom support gaps and 0.4 mm XY separation. G-code heat waits verified at 220°C nozzle / 65°C bed; loaded material and bed are not verified for a live job.

The neck-to-boot blend is a spline fit to a hyperbolic rational quadratic with no inflection. The long guide remains full height through v=42 mm, including its inner lip; nominal sliding clearances are 0.3 mm sideways and 0.4 mm under the lip. The far guide end tapers to the base by v=55 mm. Source checks and current V3 reports cover solids, motion and the retained band/cord routes.

**Unresolved assembly issue:** outgoing twine still intersects the carrier in wallet-near, bare-near and small-near. Resolve/review routing before another print. Current single-bearing axle loading, safe button force, inline-band behavior and the 14 mm pocket versus 18/20 mm phone conflicts also remain unqualified.

Open `index.html` through the CAD server. The preview shows actual positive extrusion centerlines with model, support and interface separately toggled; it does not simulate bead width or sag. Exact input hashes, placements and overrides are in `inputs.json`; effective settings, toolpath audit and output hashes are in `review.json`.

Reproduce in a **new** output directory, after building the selected source revision:

```sh
cad/.venv/bin/python cad/versions/v3/source/prepare_actuator_plate.py prepare --parts actuator_bracket plunger --output-dir NEW_JOB_DIRECTORY
cad/.venv/bin/python cad/versions/v3/source/prepare_actuator_plate.py slice --output-dir NEW_JOB_DIRECTORY
cad/.venv/bin/python cad/versions/v3/source/review_actuator_plate.py --output-dir NEW_JOB_DIRECTORY
```

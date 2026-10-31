# V3 actuator — bridged axle-slot recipe

CAD remains `ramped-retainers-v3`; no geometry changed. User declined the teardrop mounting-hole roof; bore remains round. The sole object-setting change versus `../2026-10-14-actuator-ramped/` is axle `enable_support: 1→0`. Seven separate parts, orientation, placement, source hashes and all machine/process/filament profiles match.

Support/interface 0.4801→0.4500 g; total 13.7481 g; 107.19 minutes. No axle supports; actual bridge extrusion paths match the previous supported slice. See `comparison.json` and `axle-bridge.png`.

Open `index.html` through the CAD server for layer inspection. Full input/sliced 3MFs, source hashes, profiles, settings, logs and G-code are retained. Regenerate only in a new directory with `prepare_actuator_plate.py`; `--support-axle` restores the historical setting for comparisons. Audit with `review_actuator_plate.py` then `review_axle_bridge.py`.

Print sent on 2026-10-14 as `tmt-v3-actuator-bridge-2bd7d71f.gcode.3mf`; guarded remote hash inspection passed and the printer reported RUNNING during preheating, then PAUSE during external filament loading before layer 1 (error `0x07FF8007`). No remote resume was sent. The user subsequently reported all actuator parts printed, approving pulley, screw/nut and cross-key, with bracket/plunger changes requested. See `physical-feedback.json` and `start-record.json`; terminal completion was not remotely observed. This directory retains the actual printed geometry/toolpaths; new source geometry must be sliced elsewhere. Loaded strength, button force and revised assembly fit remain unverified.

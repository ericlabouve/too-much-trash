# Single-contact cuff fit prototype — PETG slice review

Offline review only. No printer contacted, uploaded file or print start.

Three parts at 100% scale: C cuff ×1, local jaw socket with integral friction ribs ×1, shared T-key ×1. This is not the full fixed/sliding jaw assembly. User chose to retain the 12.2 mm key rather than trim another 0.5 mm from its keeper-band end shoulder. No geometry changed during slicing.

## Recipe and orientation

- Recorded Bambu A1 mini / 0.4 mm nozzle / textured PEI / Bambu PETG Translucent Blue recipe, copied from the October 15 PETG job. Loaded material and bed state were not queried for this offline review.
- 0.12 mm layers, 0.2 mm first layer, 3 walls, 15% gyroid, by-layer printing; no brim/raft or scaling. Nozzle 250°C first layer then 245°C; bed 70°C. Recorded filament flow ratio 0.95 and volumetric limit 6 mm³/s retained.
- Normal Snug automatic supports enabled for all three parts, 30° threshold, 0.24 mm top/bottom gaps, 0.4 mm XY gap, two interface layers and 0.5 mm interface spacing.
- Cuff: +90° about source X, flat C-profile side on bed, source Y becomes build Z. Jaw: +90° about source Y, socket axis vertical. Key: source Z thickness on bed. Exact matrices, translations, source hashes and bed positions are in `inputs.json`; source and oriented meshes are retained.

## Actual slice

Approximately **24.1 minutes / 1.132 g** slicer total. Actual labeled-object extrusion: model 1.0420 g, support scaffold 0.0164 g and interface 0.0018 g. Role accounting excludes unlabeled startup/purge and is not expected to equal the slicer total exactly.

All support is in the cuff's central key opening/recess, at build Z1.64–8.48 mm. Access is through the opening/recess; gently remove support and inspect the thin surrounding wall and recessed head seat before assembly. Small support mass does not establish easy PETG removal or a clean precision fit.

**The friction ribs are model geometry integral to the PETG jaw socket. Do not remove them as supports.** Neither jaw nor key generated support paths. The jaw top projection shows the two inward rib contours. Rib gap is a nominal 2.95 mm against a 3 mm stem, not a measured as-printed gap or holding force.

Use a dummy phone edge first. PETG tests assembly and fit, not the intended ELEGOO TPU 95A cushioning/grip. Stop rather than force a jammed key. Cuff shoulder strength, thin key head, retention force, wear and creep remain unqualified. Active jaws and actuator manufacturing geometry are unchanged.

## Files and reproducibility

- `cuff-fit-input.3mf`: oriented editable plate.
- `cuff-fit.gcode.3mf`: exact sliced project; G-code MD5 `a1f87de29b4e4327e91ff64d3d8fc59f`.
- `review.json`: effective settings, part/support estimates, heat-command checks, separation checks and hashes.
- `index.html`: shared actual-toolpath preview; blue scaffold, purple interface, orange model.
- `support-details.png`: top/front/side projections for every part.
- `prepare.log`: initial sandbox-restricted Bambu Studio abort; `prepare-retry.log` and `slice.log` correspond to the successful offline retry.

Generator: `cad/versions/v3/source/prepare_cuff_fit_plate.py --output-dir <NEW-DIRECTORY>`. Audit: `review_actuator_plate.py --output-dir <DIRECTORY> --project-stem cuff-fit --title 'V3 cuff fit · PETG' --detail-parts fit-cuff fit-jaw fit-key`. Historical sliced files must not be overwritten. Browser test passed with three pieces and 106 toolpath heights, including cumulative/single-layer, support visibility, part focus and narrow-screen layout.

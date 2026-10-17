# Reusable slice review

Preserves the user-approved actuator-bridge review: actual extrusion paths, faint orange model, blue supports, purple interfaces, green adhesion, orbit/zoom, part framing, 3D/top/front views, cumulative height or one-layer inspection, per-part support statistics, recipe, warnings and hashes.

## Existing audited plate

From repository root, package the existing report and path buffers into a **new** directory:

```sh
cad/.venv/bin/python cad/slice_review/build.py \
  --job cad/versions/v3/print/jobs/2026-10-14-actuator-bridge \
  --output cad/versions/v3/review/slice-viewer-example \
  --bed-size 180 180 --title 'V3 actuator · reusable slice review'
```

Serve `cad/` over HTTP and open the output's `index.html`. The CLI refuses an existing output directory. Legacy jobs need explicit bed dimensions; newer exports carry their bed polygon. Three.js is version-pinned and requires network access; keep static previews and the sliced 3MF available for offline fallback. This is a review tool, not printer control or a generic G-code interpreter.

## New plate audit integration

Add `cad/` to the Python import path, then:

```python
from slice_review import export_toolpaths, write_page

# Every segment: (Z_mm, unique_object_key, role, (X1,Y1), (X2,Y2)).
# Roles: model, support, interface, adhesion. Use real, unscaled coordinates.
# Objects: {unique_key: {x, y, z, width, depth, height}} in millimetres.
export_toolpaths(job_dir, segments, objects, bed_polygon)
# Write review.json using your plate-specific audit, then:
write_page(job_dir, title='My plate', subtitle='Revision / plate number',
           notes=['Part-specific inspection notes'],
           links=[{'label': 'Sliced project', 'href': 'plate.gcode.3mf'}])
```

`review_actuator_plate.py` now uses this API for future jobs. Its part-identity, temperature and A1-mini clearance assertions remain **actuator-specific**, separate from the shared viewer. `prepare_actuator_plate.py --parts actuator_bracket plunger` selects just those parts without changing scale, print orientation or recorded plate positions; the audit checks the selected count against `inputs.json`. Do not run the audit over a historical physical job just to restyle it; use the packaging CLI and a new review directory instead.

`review.json` fields: `pieces`, `total_g`, `total_minutes`, `warning` (empty string means none; absent means unknown), `deposited_g_by_role`, `objects` (per-instance `deposited_g_by_role` and `support_z_mm` or null), `effective_settings`, `gcode_md5`, `hashes`, `limits`. Missing total estimates are shown as unknown. Keep unique keys for duplicate copies and summed multi-filament estimates explicit in the upstream audit. Never infer filament mass from an unrelated material density.

Source adapters must interpret actual slicer extrusion and layer/feature annotations, relative/absolute extrusion and retractions. Interpolate G2/G3 arcs before export or reject them explicitly (the current actuator audit requires arc fitting off). Do not substitute mesh silhouettes for supports. The exporter sorts by height and stores little-endian float32 line endpoints with cumulative even vertex counts. All roles, including empty support buffers, are valid. Current visualization shows centerlines, not bead volume, sag, collision validation or support removability; part focus frames but does not isolate geometry.

Historical reports and exact sliced files remain immutable. The generic page does not say “not sent” or “completed”; printer outcomes belong in the job's start/outcome records.

Tests: `cad/.venv/bin/python -m unittest discover -s cad/tests -p 'test_slice_review.py'`. Browser checks: `node cad/tests/viewer-slice-review.cjs` with `CAD_SLICE_REVIEW_URL`, `PLAYWRIGHT_MODULE`, and `CHROME_PATH` set as needed.

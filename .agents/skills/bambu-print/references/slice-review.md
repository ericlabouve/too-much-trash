# Reproduce the preferred slice display

User preference recorded 2026-10-14: the review at `cad/versions/v3/print/jobs/2026-10-14-actuator-bridge/` is the visual baseline. Do not hard-code its seven parts, A1-mini bed or PLA recipe into future viewers.

Shared implementation: `cad/slice_review/`; usage/schema/tests in its `README.md`. For an already audited directory, run from repository root:

```sh
cad/.venv/bin/python cad/slice_review/build.py \
  --job <audited-job-directory> --output <new-review-directory> \
  --title '<job name> · slice review'
```

Older `paths.json` files lack bed geometry; provide `--bed-size X_MM Y_MM` using the exact printer bed. New adapters pass the bed polygon to `export_toolpaths`, then save `review.json` and call `write_page`. The actuator audit is already integrated; its part-specific manufacturing assertions stay separate from the generic display. Preserve unique instance keys when printing duplicate parts.

Serve `cad/` over HTTP from the correct checkout and open the new review URL. Verify the selected part, support visibility, cumulative/single-layer controls, estimates, and absence of JavaScript errors/overflow. Test different part counts and beds when changing shared code. The shared viewer uses pinned Three.js CDN assets; retain static views and the sliced project as fallbacks if unavailable.

Use actual positive extrusion paths and slicer feature labels; never sketch supports from CAD silhouettes. Parse or explicitly reject arcs upstream. Role mass calculations must use the correct filament accounting and disclose excluded purge/adhesion. The shared viewer renders centerlines, not beads or predicted sag. Keep support scaffold/interface visually distinct and document access for removal from cavities and effects on sliding/bearing surfaces.

Include exact sliced-file hashes and links to source reports, arranged/sliced 3MFs and static projections. A preview does not establish bed clearance, loaded material, physical fit, strength or safe button travel. Job-start/completion records remain separate; avoid stale “not sent” claims in a reusable template. Do not change a historical print's geometry or toolpaths to update its presentation.

# R3 print set — fit prototypes

Six unique bed-oriented STL files; print **two neck caps** and one of each other part. STEP parts remain in assembly coordinates. `assembly.step` includes printed parts plus unthreaded hardware and provisional stock/phone envelopes. `assembly_meshes/` is viewer data, **not a print set**. Use only the six top-level STLs for printing.

See [assembly/print instructions](../README.md), [BOM](../bom.md), and [limitations](../design-review.md). `manifest.json` records CAD volumes and bounding boxes; `validation.json` records sample checks and provisional mechanism calculations. Open `../viewer.html` through `../serve_viewer.py` to inspect the actual exports in Chrome. The viewer uses pinned Three.js modules from a public CDN and loads geometry from localhost.

# R1 generated prototype files

Eight printable `*.stl` files and matching editable `*.step` files come from [`../source/build.py`](../source/build.py). `assembly.step` includes these parts plus simplified phone and full stock-grabber visual proxies. [`full-assembly-cad.png`](full-assembly-cad.png) shows the complete assembly and both attachment details; `assembly-cad.png` remains the near-claw technical view. These are **fit prototypes**, not approved final manufacturing files. Re-export after measuring the actual phone and grabber. Import STLs separately in Bambu Studio and use the orientations in [the CAD README](../README.md).

To inspect all eight local STLs in Chrome, run `python3 serve_viewer.py` from `cad/` and open `http://localhost:8765/viewer.html`. The viewer uses Three.js from a public CDN; the STL files stay on the local loopback server.

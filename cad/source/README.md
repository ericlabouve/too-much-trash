# Editable R3 CAD

`parameters.py` separates measured phone/shaft inputs from provisional design settings. `parts.py` creates six independent printable designs. `assembly.py` supplies shared placements, hardware/stock envelopes and rocker kinematics. `check_design.py` verifies fit and movement; `build.py` exports bed-oriented STLs, STEP and manifests; `render.py` draws actual CAD triangles. All lengths are mm. Run from `cad/` using the [locked workflow](../README.md). R2 source is preserved in `../archive/r2/source/`.

# V2 recessed-r3 manufacturing files

Use these STL files at **100% scale in millimetres**. They are already bed-oriented. See [quantities, PLA+ settings and assembly sequence](../README.md#prototype-printing). Start with one `thumb_screw.stl` and one `thumb_nut.stl` to check printed thread fit.

Eight designs / thirteen pieces: carrier ×1, sliding_jaw ×1, actuator_bracket ×1, rocker ×1, pivot_key ×1, thumb_screw ×3, thumb_nut ×2, string_guide ×3.

The reference slice uses a Bambu A1, 0.4 mm nozzle and Generic PLA; your actual printer and PLA+ preset are not specified. The rocker needs a 20° support threshold in that reference profile to avoid support inside the threaded bore. Inspect actual layers and support access. `slicer-review.json` binds results to exact STL hashes; PNGs show sampled extrusion layers (orange model, blue support). These are fit-prototype exports, not proof of physical function.

These files match the official recessed V2 viewer. Carrier, sliding jaw and actuator bracket replace the raised-rail versions preserved in `../archive/raised-r2/print/`. Camera-view clearance remains unresolved; these are mechanical fit-prototype files.

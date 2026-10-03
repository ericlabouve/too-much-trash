# V2 reinforced-r4 manufacturing files

Use these STL files at **100% scale in millimetres**. They are already bed-oriented. See [quantities, PLA+ settings and assembly sequence](../README.md#prototype-printing). Start with one `thumb_screw.stl` and one `thumb_nut.stl` to check printed thread fit.

Eight designs / thirteen pieces: carrier ×1, sliding_jaw ×1, actuator_bracket ×1, rocker ×1, pivot_key ×1, thumb_screw ×3, thumb_nut ×2, string_guide ×3.

The reference slice uses a Bambu A1, 0.4 mm nozzle and Generic PLA; your actual printer and PLA+ preset are not specified. The rocker needs a 20° support threshold in that reference profile to avoid support inside the threaded bore. Inspect actual layers and support access. `slicer-review.json` binds results to exact STL hashes; PNGs show sampled extrusion layers (orange model, blue support). These are fit-prototype exports, not proof of physical function.

These files match the official reinforced V2 viewer. Carrier, sliding jaw, actuator bracket, rocker, pivot key and shaft guide replace recessed-r3; the screw and nut designs are unchanged. Previous exports are preserved in `../archive/recessed-r3/print/`. These remain mechanical fit-prototype files; actual camera framing, guide strength and twine friction are unvalidated.

# PETG cuff support investigation — 2026-10-16

Offline comparison only. No printer contact or print command. Existing C pocket,
seating ribs, jaw socket, integral friction ribs and 12.2 mm shared key are unchanged.
Source mesh hashes match across all three slices. Active jaws/actuator are untouched.

| Three-piece plate | Support + interface | Total estimate | Time |
| --- | ---: | ---: | ---: |
| Original side-down | 0.0182 g | 1.1316 g | 24.09 min |
| Side-down, omit detected bridge supports | 0.0182 g | 1.1316 g | 24.09 min |
| Cuff curved-back-down | 0 g | 1.1141 g | 20.07 min |

The support amount is small, but it contacts a precision key pocket where cleanup
can affect fit. Bridge-aware support omission alone changes no extrusion-path
buffers. Rotating the cuff −90° about source Y makes the key passage vertical and
the C opening face up. Jaw/key orientations remain unchanged. Automatic supports
remain enabled on **all three pieces**, rather than being forced off.

- [Recommended orientation candidate / actual toolpaths](../../print/jobs/2026-10-16-cuff-back-study/index.html)
- [Bridge-setting comparison](../../print/jobs/2026-10-16-cuff-bridge-study/index.html)
- [Preserved original slice](../../print/jobs/2026-10-16-cuff-fit-petg/index.html)
- [First-layer comparison, same scale](first-layer-comparison.png)
- [Machine-readable comparison and source hashes](comparison.json)

Recipe unchanged: A1 mini / 0.4 mm, Bambu PETG Translucent, textured PEI,
250/245°C nozzle, 70°C bed, 0.12 mm layers (0.2 first), three walls, 15% gyroid.
No brim. Check the curved back's first-layer adhesion and the curved phone seats'
overhang finish physically. These paths do not simulate sag or prove strength;
the changed layer direction must also be checked with the actual TPU cuff later.
The viewer passed part/layer/support controls, three viewport widths and no JS errors.

## Rigid-key fit remains unresolved

Both the key and jaw ribs are rigid PETG in this prototype. The intended later TPU
cuff does not make the jaw ribs flexible. A 2.95 mm rib gap against the 3 mm stem
is deliberate 0.05 mm total interference, not clearance. It may jam; do not force it.
The ribs are short tapered lands, not engineered spring fingers or a positive latch.
Use a dummy edge, not a real suspended phone, for initial fit evaluation.

Before printing, consider replacing the interference with a measured/tuned friction
fit or a deliberately compliant rib. Simply increasing clearance will ease insertion
but may lose pull-out retention; do not call that a complete retention solution.
No rib change has been made in these matched slices.

## Why no sloped-pocket change yet?

Orientation eliminates the generated supports without altering the approved C or
thinned shared head. A trapezoidal/chamfered roof remains a fallback if this orientation
prints poorly, but it must preserve key insertion space and the thin head-bearing
shoulder. Rounding alone is not sufficient: the underside's actual layer-to-layer
overhang matters. Do not fill the pocket with a ramp that blocks the rigid T-head.

Print orientation is also the first remedy recommended in
[Prusa's bridging guidance](https://help.prusa3d.com/article/poor-bridging_1802).
Its [PETG guidance](https://help.prusa3d.com/article/petg_2059) notes bridging and
overhang limitations. These general references do not qualify this specific part.

Reproduce with `source/prepare_cuff_fit_plate.py --cuff-orientation back` or
`--bridge-no-support`, always using a new output directory. Audit with
`source/review_actuator_plate.py --project-stem cuff-fit`, then regenerate the
comparison using `source/compare_cuff_slices.py`.

# V2 thread-8x3-r7 manufacturing files

Use these bed-oriented STLs at **100% scale, millimetres**. The screw, nut and rocker now share the successful original-envelope **8 mm major / 3 mm pitch custom trapezoidal thread**. Reuse successful 8×3 trial fasteners; old 8×2 parts are incompatible. Outer screw/nut dimensions are unchanged. Previous assembly: `../archive/tie-eye-r6/`.

Eight designs / thirteen pieces: carrier ×1, sliding_jaw ×1, actuator_bracket ×1, rocker ×1, pivot_key ×1, thumb_screw ×3, thumb_nut ×2, string_guide ×3.

## Next batches

| Order | Files | Validate |
| --- | --- | --- |
| 1 — actuator fit | `rocker.stl` ×1, `actuator_bracket.stl` ×1, `pivot_key.stl` ×1, `string_guide.stl` ×1; any remaining screw | Hand-thread a successful screw into the rocker; verify free pivot, key retention, stops, tie-eye access, twine threading and band return off the phone. Check guide fit on the shaft. |
| 2 — carrier | `carrier.stl` ×1, `sliding_jaw.stl` ×1, remaining guides/fasteners | Check jaw travel, both actuator rails, gentle clamping, shaft retention, full trigger squeeze/release and camera framing. Set phone-button contact after reliable off-phone return. |

If both successful screw/nut pairs were retained, you have two screws and two nuts: only **one additional screw** is needed. Count actual retained pieces before printing.

## Settings

A1 mini / 0.4 mm nozzle / PLA+, 0.12 mm layers for **rocker, screw and nut**; 0.2 mm for other parts. Successful fastener reprint: 2 walls, 15% infill, outer/inner walls 30/60 mm/s, internal solid infill 80 mm/s; no supports. See [job record](jobs/2026-10-02-thread-pair/job.json). Physical strength is not established.

Rocker: 5 walls /60%; carrier/jaw: 5 /35%; bracket/guide: 5 /40%; pivot: 6 /100%. At 100%, use Zig-zag. Review supports on all except screw/nut. The prior rocker reference used a 20° support threshold to keep the bore clear; inspect the new slice before printing. See [assembly guide](../README.md).

The previous `slicer-review.json` and slice PNGs are historical and do not validate newly exported threaded parts. New job preparation must inspect current STL hashes and toolpaths. CAD checks in `../review/thread-promotion.json` and `validation.json` do not establish physical rocker fit, force, strength or loaded retention. No print job was started by this promotion.

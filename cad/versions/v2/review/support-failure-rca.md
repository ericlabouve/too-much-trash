# Neck coupon support failure and lighter reprint

Physical feedback: the lower 20 mm r10 coupon pair printed, but support could not be removed sufficiently to expose the neck-contact surface. Fit is **not validated**. User requests low-waste, low-mass prototypes. Preserve the failed files and settings; do not send the previously prepared full-size carrier/cap job.

## Cause and evidence

The submitted job already used Bambu Studio native Normal (auto) supports. The preparation placed each split face down, leaving a roof over the neck-contact cavity. Auto supports filled that cavity. The reviewer did not adequately assess access for removing supports from the very surface the coupon was intended to test. This is a preparation/review failure, not evidence that native auto supports were unavailable.

A 5 mm outer brim with 0.1 mm object gap explains the perimeter flange. It was an adhesion aid, but was applied without sufficient footprint-specific justification. Raft layers were zero. The apparent closing base in the photos is consistent with the sliced support base, not a new solid CAD wall or intentional raft.

The process inherited a 0.12 mm Fine preset and changed model layers to 0.2 mm while retaining 0.12 mm support top/bottom Z gaps. That tight separation plausibly contributed to removal difficulty. Photos alone cannot isolate fusion, temperature, interface or gap effects. Supports could start on the model; the job used two top and two bottom interface layers, 0.5 mm interface spacing and 2.5 mm base spacing. The central issue is where supports contact and how they are removed, not simply their total mass.

Approximate positive-extrusion feature analysis: failed pair ~1.36 g supports/interfaces, 0.22 g brim and 2.05 g sparse infill. Lowering model infill alone cannot fix cleanup.

## Prepared replacement, not sent

`../print/fit-coupons/neck-r10-endface-r2/` contains the same actual cropped solids, cut end on the bed, neck passage vertical. Nominal 11.6 × 17.6 mm opening and geometry volumes unchanged. Original failed exports remain intact. Historical generator and source are preserved in commit `f8f11822459f5e140ed34d06caa46a720999467c`; restore that worktree to reproduce r10. Current two-fastener coupons use `source/build_opposed_fit_coupon.py`.

- A1 mini, 0.4 mm nozzle, 0.2 mm layers; three walls, 15% gyroid.
- No brim or raft. Native Normal (auto), snug, buildplate-only, 0.2 mm top/bottom support gaps, two top interface layers, zero bottom interface layers.
- 30/60 mm/s outer/inner walls; existing PLA+ recipe retained at 220°C nozzle/65°C textured bed.
- Combined pair: **9.51 g / 47.58 minutes**, versus failed pair **13.05 g / 49.53 minutes** (~27% less total filament).
- Separate-part comparison predicts ~0.02 g supports combined, versus ~1.36 g previously. Combined slice confirms only tiny outer-ear patches; it is not completely support-free.
- Reviewed eight layer levels: neck channels remain open, support is outside the neck-contact channel; all toolpaths within the bed and objects separated. Single connected valid solids, watertight STL meshes, bed Z=0 and unchanged CAD volume checked.
- G-code MD5 `03eecdbae07cda4abf15d49f5159883c`, plate 1. No upload/start this review.
- `result.json` warning string empty, but slice metadata still warns bed temperature exceeds the generic PLA profile threshold. The 65°C value is the existing off-brand PLA+ recipe, not a newly qualified material setting. Do not discard this warning. Physical adhesion, support release and end-oriented fit remain untested.

After printing: remove the tiny outer supports; inspect the channel for clean walls and first-layer edge flare. Use the existing screw/nut lightly and hold the other split edge aligned. Check upper/middle/lower neck positions without forcing the gap closed. This is local fit only, not proof of full-length fit, full-part layer strength or loaded retention.

## Infill and full-harness weight

Controlled full-carrier reslices retained the old orientation/support settings solely to compare material settings. They are **not approved print jobs**:

| Walls | Infill | Total filament including supports |
| --- | --- | --- |
| 5 | 35% (baseline) | 108.84 g |
| 5 | 15% | 104.32 g |
| 3 | 15% | 87.84 g |
| 3 | 5% | 82.44 g |

The baseline contained approximately 30.78 g support, 52.54 g walls and only 9.76 g sparse infill. These feature estimates exclude some priming/other extrusion and are not scale measurements. Support savings reduce consumed material, not final assembled harness weight. Reducing walls reduces final part weight but changes strength. 35→15% alone saves 4.51 g; five→three walls at 15% saves another 16.48 g. Dropping 15→5% with three walls saves another 5.40 g.

Use three walls/15% for the nonloaded fit coupon. Evaluate lower-density full parts with targeted strength at clamp ears, roots, rails and pivots rather than blindly reducing all walls or using zero infill. Full carrier/cap orientation, support cleanup and light structural settings require review before the full print. Successful thread settings are unchanged.

Generic workflow lessons are recorded in `.agents/skills/bambu-print/SKILL.md`: inspect removal access, explicitly review inherited support gaps when changing layers, justify adhesion aids, and separate support/wall/infill consumption. Native support controls are documented in [Bambu Studio PrintConfig.cpp](https://github.com/bambulab/BambuStudio/blob/master/src/libslic3r/PrintConfig.cpp).

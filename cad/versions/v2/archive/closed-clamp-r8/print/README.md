# V2 closed-clamp-r8 manufacturing files

**Printing paused for design review.** The uploaded actuator-r7 job contains the older solid bracket. Do not start it as the current revision; generate and inspect a fresh slice after review.

All manufacturing STLs here are millimetres, 100% scale and bed-oriented. Six designs are geometrically unchanged from r7: sliding jaw, rocker, pivot key, thumb screw, thumb nut and string guide. Carrier and actuator bracket change; `shaft_cap.stl` is new. Preserve earlier files in `../archive/thread-8x3-r7/`.

## Quantities

Nine designs / eighteen pieces: carrier ×1, shaft_cap ×1, sliding_jaw ×1, actuator_bracket ×1, rocker ×1, pivot_key ×1, thumb_screw ×5, thumb_nut ×4, string_guide ×3. One continuous twine length and seven rubber bands remain. Two printed screw/nut pairs replace the shaft's two rubber bands.

If both successful thread pairs were retained, three additional screws and two additional nuts remain to reach the total. Count the actual retained pieces before slicing.

## Validation order after design review

1. Check the new carrier/cap on the actual shaft with two existing successful screw/nut pairs, before installing the phone. Check 11.6 × 17.6 mm nominal opening along the full 74 mm length, clearance from the stock fork, screw access, and cap removal toward local +Y with the actuator module removed. Tighten gently and evenly; the 1 mm split gap need not close. Do not force it if ribs/taper prevent seating.
2. Check resistance to hand-applied sliding, twisting and rocking without the phone. Inspect the cap, ears and printed threads for movement, whitening, cracking or stripping; passing this is an initial fit screen, not a load rating.
3. Fit the unchanged successful screw into the rocker. Assemble the new windowed bracket, pivot and return band; check pivot retention, stops, twine threading, return and visible bracket flex while operated off the phone.
4. Only after reliable attachment/return, fit the phone over a table while supporting it. Check jaw retention, camera framing and gentle button contact through normal trigger motion. Stop if the clamp shifts or the bracket flexes enough to change contact. No dummy-phone test is required.

## Starting settings

A1 mini / 0.4 mm nozzle / PLA+. Use 0.12 mm layers for rocker, screw and nut; 0.2 mm elsewhere. Reuse successful fasteners. The successful isolated reprint used 2 walls/15% infill, 30/60 mm/s outer/inner walls and 80 mm/s internal solid infill; this is not a demonstrated shaft-clamp load rating.

Carrier/jaw: 5 walls/35%; shaft cap, bracket and guide: 5/40%; rocker: 5/60%; pivot: 6/100% (Zig-zag). Screw/nut: no supports. Review supports on the other designs, especially the cap's inner roof, carrier collar and bracket arms. Keep threads and mating surfaces clear. The prior rocker used a 20° support threshold as a starting point.

Individual reference slices estimate carrier 108 g / 6.1 hours and cap 20 g / 1.2 hours, including supports. Both fit the A1 mini bed with zero reported slice warnings; support removal is untested. Keep the supplied carrier orientation (flat lower ear face down). See [slice record](../review/clamp-slice-review.json) and [sampled layer paths](../review/clamp-slice-preview.png). These are reference estimates, not a queued print job.

See [design and assembly notes](../README.md) and [clamp/material audit](../review/clamp-revision.json). Earlier slice PNGs/reports are historical and do not validate current carrier/cap/bracket exports. Geometry checks do not establish physical fit, friction, stiffness, strength or fatigue life.

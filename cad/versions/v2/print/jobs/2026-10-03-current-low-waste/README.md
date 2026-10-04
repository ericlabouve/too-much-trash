# Current V2 low-waste slice review

**Prepared only: no upload or print start.** Source CAD at `4a8d279`. All five sliced 3MFs are stored under `cad/exports/2026-10-03-v2-low-waste/` (generated files excluded from Git).

The user has two successful screws and two nuts. These plates add 18 parts to complete the 22-piece assembly; no duplicate copies of those four retained parts are included.

| Plate | Parts | Layer | Walls / infill | Total g | Support g | Time |
| --- | --- | --- | --- | --- | --- | --- |
| 01 | Carrier | 0.2 mm | 3 / 10% | 55.2 | 9.61 | 4h 05m |
| 02 | Shaft cap + sliding jaw | 0.2 mm | 3 / 10% | 44.0 | 4.40 | 3h 30m |
| 03 | Bracket + 3 guides | 0.2 mm | 3 / 10% | 33.1 | 1.46 | 2h 31m |
| 04 | Rocker + pivot | 0.12 mm | 3 / 15% | 4.0 | 0.42 | 1h 08m |
| 05 | 5 screws + 4 nuts | 0.12 mm | 2 / 15% | 8.6 | 0.00 | 1h 25m |

Total: **144.9 g**, about **12h 40m**; support 15.9 g. Slicer time estimates include each plate’s startup, exclude manual changes/cleanup, and are not guarantees.

## Orientation and cleanup decisions

- Carrier and cap use the reversed neck-end orientation: neck-contact surfaces run vertically, rather than becoming supported roofs. Sparse normal supports have 5 mm base spacing, 0.24 mm top/bottom gaps and 0.4 mm XY clearance. Supports beneath the jaw and rail are accessible from open sides. Carrier support is still 9.61 g; avoiding support against the neck-contact face takes priority over the lowest total weight.
- The cheaper 49.51 g carrier side orientation places support against the neck-contact surface; rejected given prior cleanup feedback. The other neck-end orientation takes 99.35 g. Selected carrier: 55.20 g.
- Cap selected orientation: 35.20 g alone, 4.21 g support, compared with 37.27 g / 8.20 g support for the flat export.
- Sliding jaw stays upright; bracket has its broad outside plate down; guide bores are vertical. Rocker thread axis stays vertical; upright pivot requires no support. No support in any screw/nut threads or the rocker thread bore.
- All plates use native automatic supports where enabled. No brim, raft or prime tower. Support removal remains a physical check; support material is not assumed to peel successfully merely because slicing succeeded.

## Checks

- Official A1 mini 0.4 mm preset; 100% scale; 180 × 180 mm bed; print by layer.
- Actual G-code confirms 220 °C nozzle, 65 °C textured bed, 100% fan settings after initial layers, layer heights and infill above. First layer is 0.2 mm even on fine-layer plates.
- Actual model/support extrusion envelopes fit the bed, with a 0.25 mm line-width allowance. Multi-object projected extrusion boxes are separated by at least 7.10 mm after subtracting 0.5 mm for line width. Calibration region avoidance enabled for arranged plates; fasteners occupy a deliberately spaced central grid.
- Nine fastener instances verified in sliced 3MF metadata; global and actual subsequent G-code layers are 0.12 mm. Metadata thumbnail entries use first-layer height 0.2 mm.
- No slicer warnings. Embedded G-code matches the reviewed G-code and MD5. Input and output SHA-256 hashes are in review.json.
- Orange lines in the previews are model; blue lines are supports. Full layer paths were parsed; arc fitting disabled and absence of extrusion arcs asserted.

## Suggested print order

Print plate 05 first for the missing fasteners, then plates 01 and 02 for full-length collar closure, cap service and jaw return checks. Continue with 03 and 04 for actuator fit and complete twine routing. Verify the current bed, nozzle, spool and printer state before authorizing a start. No files have been uploaded.

- [01-carrier layer review](01-carrier-layers.png) · [support side views](01-carrier-support-sides.png)
- [02-cap-and-jaw layer review](02-cap-and-jaw-layers.png) · [support side views](02-cap-and-jaw-support-sides.png)
- [03-bracket-and-guides layer review](03-bracket-and-guides-layers.png) · [support side views](03-bracket-and-guides-support-sides.png)
- [04-rocker-and-pivot layer review](04-rocker-and-pivot-layers.png) · [support side views](04-rocker-and-pivot-support-sides.png)
- [05-fasteners layer review](05-fasteners-layers.png) · [support side views](05-fasteners-support-sides.png)

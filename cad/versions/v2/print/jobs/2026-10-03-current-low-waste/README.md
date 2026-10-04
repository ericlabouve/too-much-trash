# Current V2 low-waste print records

Plate 01 completed: the user reports a successful fixed-jaw print with supports that peeled off easily. This validates cleanup for this exact part/orientation/recipe, not loaded assembly strength. Two screws and two nuts were previously successful. Plate 02 Normal Snug retry also succeeded according to the user, after an early stop of the Tree Organic experiment for poor support adhesion. Sixteen pieces remain unconfirmed: plate 03 was restarted with unchanged settings; plates 04 and 05 have not started.

## Reproducibility

The exact sliced 3MFs are preserved alongside this record, including the successfully printed plate 01. Complete machine, filament and per-plate process profiles, source/input hashes, output SHA-256 and embedded G-code MD5 are in `review.json`. The sliced 3MF retains arranged geometry, orientation and actual toolpaths. Recheck printer, nozzle, material, plate and clearance before replaying a file. Firmware behavior and physical material can vary even with identical G-code.

| Plate | Parts | Layer | Walls / infill | Total g | Support g | Time |
| --- | --- | --- | --- | --- | --- | --- |
| 01 | Fixed jaw — completed | 0.2 mm | 3 / 10% | 48.5 | 3.74 | 3h 59m |
| 02 | Shaft cap only — flat | 0.2 mm | 3 / 10% | 35.8 | 6.74 | 2h 11m |
| 03 | Sliding jaw + bracket + 3 guides | 0.2 mm | 3 / 10% | 41.7 | 1.46 | 3h 34m |
| 04 | Rocker + pivot | 0.12 mm | 3 / 15% | 4.0 | 0.42 | 1h 08m |
| 05 | 5 screws + 4 nuts | 0.12 mm | 2 / 15% | 8.6 | 0.00 | 1h 25m |

## Latest placement and support review

- Plate 01 keeps the sliding track vertical, with support against the static neck-contact face. Its actual printed recipe is preserved unchanged.
- Plate 02 replaces the previous upright cap/jaw batch. Cap lies flat, neck opening down and actuator rail above it, matching the user’s image. All four fastener-ear undersides lie at bed Z=0 and appear in the first model layer, so there is no elevated second pair to support. Supports remain beneath the neck recess and rail. Do not confuse deliberate open screw bores with missing support. Cleanup of this orientation has not yet been physically tested.
- Plate 03 now has five objects: sliding jaw, bracket, two centered guides and one dual guide. It uses the successful plate 01 support recipe: Normal Snug, 5 mm base spacing, 0.24 mm top/bottom gaps, 0.4 mm XY gap, two top interface layers at 0.5 mm spacing. This replaces the prior plate 03 settings (2.5 mm base spacing and 0.2 mm gaps); transferring a successful recipe does not establish cleanup on different parts.
- Plates 04 and 05 are unchanged. All parts remain 100% scale, by-layer printing, A1 mini / 0.4 mm nozzle / Textured PEI, 220 °C nozzle and 65 °C bed. No brim or raft. Actual first layer is 0.2 mm, including fine-layer jobs.
- Embedded G-code and file hashes verified. Model/support extrusion bounds fit the bed with a 0.25 mm line-width margin, and every multi-object projected bounding box remains separated after a 0.5 mm line-width allowance. No slicer warnings. Profiles and layer paths checked; removal and fit still need physical validation.

The previous plate 02 and 03 records remain in Git history. Do not use those superseded sliced files. Plate 02 estimate is 35.8 g; actual required spool reserve should allow for variation and startup waste. Remaining spool quantity is unknown.

[Support-style comparison](support-comparison.md) records the algorithm exploration; the generic trial order is also in the bambu-print skill reference.

- [01-carrier-neck-contact sliced file](01-carrier-neck-contact.gcode.3mf) · [layers](01-carrier-neck-contact-layers.png) · [side views](01-carrier-neck-contact-support-sides.png)
- [02-shaft-cap-flat sliced file](02-shaft-cap-flat.gcode.3mf) · [layers](02-shaft-cap-flat-layers.png) · [side views](02-shaft-cap-flat-support-sides.png)
- [03-jaw-bracket-and-guides sliced file](03-jaw-bracket-and-guides.gcode.3mf) · [layers](03-jaw-bracket-and-guides-layers.png) · [side views](03-jaw-bracket-and-guides-support-sides.png)
- [04-rocker-and-pivot sliced file](04-rocker-and-pivot.gcode.3mf) · [layers](04-rocker-and-pivot-layers.png) · [side views](04-rocker-and-pivot-support-sides.png)
- [05-fasteners sliced file](05-fasteners.gcode.3mf) · [layers](05-fasteners-layers.png) · [side views](05-fasteners-support-sides.png)

## Plate 02 Tree Organic experiment — stopped early

Alternative to the flat-cap Snug file: [Tree Organic sliced 3MF](02-shaft-cap-tree-organic.gcode.3mf), [layers](02-tree-organic-layers.png), [side views](02-tree-organic-support-sides.png), [settings and checksums](02-tree-organic-experiment.json). Same flat cap, 0.2 mm layers, three walls, 10% gyroid, 0.24 mm support Z gaps, 0.4 mm XY clearance, two interface layers and 0.5 mm interface spacing. Explicit Tree Organic style verified in generated G-code.

Organic: 36.90 g total, 7.86 g supports, 2h 44m. Snug: 35.80 g total, 6.74 g supports, 2h 11m. Organic is a removal-quality experiment, not a material-saving improvement here. Both all-four-ear first-layer contact and rail/neck support reviewed. Bed bounds and embedded MD5 passed; no slicer warnings. Automatic tree arrangement failed; explicit centered placement succeeded without scaling or changing the flat orientation. Compare cleanup effort, residual material, underside finish and neck fit after printing. Tree Organic was stopped early because supports did not adhere well to the bed; cleanup could not be evaluated. The user subsequently confirmed the Normal Snug cap print succeeded.

## Plate 02 retry

User stopped Tree Organic early due to support-to-bed adhesion failure; ease of removal was not evaluated. Normal Snug flat-cap file was verified, uploaded and restarted after bed clearance confirmation. See `plate-02-snug-retry.json`. No geometry or recipe changes to the reviewed Snug candidate.

## Plate 03 start

User confirms plate 02 Normal Snug retry succeeded. Plate 03 (sliding jaw, bracket and three guides) started with authorization after file hash, remote dry run, idle state and camera bed-clearance checks. Result pending; see `plate-03-start.json`.

Plate 03 restart: the previous attempt reported `FAILED` with no active print error; the cause was not supplied. After the user confirmed bed readiness, the same remotely verified file was restarted. The last observed state was `PREPARE` with no errors; completion remains unverified. See `plate-03-retry-20261004T175914Z.json`.

# Parallel string approach study

Review-only proposal following the accepted uniform rail sleeve. The string approaches the pulley parallel to plunger travel at a nominal 3.1 mm lateral offset from the triangular shaft centerline. This is a direction alignment, not a coaxial force application; handle height and lateral offset still create eccentric loading.

Changes:
- Pulley center moves 3.0249 mm inward, 2.55 mm toward the curved foot, and 2.05 mm upward to match the string-wrap height.
- Remove the pulley-side 2 mm handle-cap overhang; retain the wrap neck.
- Extend the smooth axle shaft by 2.05 mm while retaining its diamond opening, key and head geometry. The previously printed axle is therefore too short for this proposal.
- Carry the moved bearing down to the bed with a flat pad. Preserve the curved foot, triangular tunnel, accepted rail sleeve and unchanged shaft-cap rail.

The first slice (`2026-10-30-aligned-pulley-b-petg`) found 0.0011 g of support under a small bearing overhang. Its geometry and toolpaths remain preserved in that job. The revised pad extends beneath the entire bearing; use the final flat-pad slice linked in the viewer.

`study_aligned_pulley_b.py` builds the CAD and checks sampled rigid travel to 6 mm, local cord/band paths over 1.5 mm, and eight static assembly configurations. The actual full-squeeze stroke is unknown. The outer cord route to the grabber handle has not been qualified by these local checks. Flexible cord seating, band behavior, printed strength, friction and loaded retention remain physical checks. No print, active V3 promotion or approval is implied.

Final slice: `2026-10-30-aligned-pulley-b-flat-petg`, 8.5203 g total / 79.94 minutes, zero support or interface extrusion, automatic supports enabled and bridge suppression disabled. Exact source hashes are recorded in `slice-evidence.json`; all three meshes match the sliced input. No slicer warnings.

Travel measurement: handle center to cord tangent is14.7 mm projected along the slide direction; the free incoming cord is11.6 mm. This is not usable stroke: rigid wheel contact starts at approximately7.8 mm pull. At6 mm pull the handle has0.832 mm wheel clearance and0.900 mm sleeve clearance. The handle cannot pass fully beside the wheel in this revision. See `travel-measurement.json` and `source/measure_aligned_pulley_travel.py`. No geometry changed by this measurement.

# Recessed rail feasibility study

**User-selected preferred V2 direction (2026-09-30); camera clearance remains in progress.** The recessed candidate has now been promoted to active V2 source, viewer and manufacturing exports. The raised baseline is preserved in `../../archive/raised-r2/`. Open [the comparison viewer](viewer.html), switch Recessed / Earlier raised rails, and compare both actuator sides.

The current long rail beams occupy local Z=60–80 mm. The phone rear datum is Z=18; the existing illustrative camera bump ends at Z=22. Thus the rail fronts project 58 mm toward the claws beyond the assumed lens plane. Previous `camera_keepout` checks protected the bump volume only; they did not establish an unobstructed image.

The candidate moves the long beams **64 mm toward the handle**, to Z=−4–16, and **8 mm farther outward on each side**. The complete mounting assembly is 16 mm wider across the rail interfaces. New shorter rail supports and a lower slotted bracket reconnect to the same jaws and unchanged rocker. The longitudinal adjustment and depth adjustment ranges remain available; no new parts or materials are added. The carrier, sliding jaw and actuator bracket would change; the other five print designs remain reusable in this proposal.

Moving the rails straight backward without moving the fasteners outward would bring the near-side screw heads into the shaft. The outward shift resolves that collision in the checked geometry. Candidate rail screws/nuts have zero overlap with the historical shaft proxy. The existing smaller saddle-opening discrepancy is still excluded; this does not validate the saddle fit.

Eight candidate configurations (four phone envelopes × both actuator sides) passed the existing rigid-intersection, phone/bump, rocker-sweep and off-rail pivot-turn checks. The three changed parts are valid connected CAD solids. The files in this study folder remain assembly-coordinate comparison meshes. Manufacturing exports for the promoted recessed geometry are in `../../print/`.

## What remains in the image envelope

The long rails sit entirely behind the **assumed** Z=22 lens plane, with 6 mm clearance. This conclusion is about the long beams; their short support connections, jaw hooks, bands, actuator and twine are checked separately as part of their respective components.

A conservative expanding view volume still intersects the upper jaw-band/hook region. Wider envelopes also intersect carrier features and the elevated string route. With the actuator on the far, camera-side edge, the raised guide, rocker and pivot remain significant potential intrusions. Relocating the rails alone therefore does **not** establish a clear camera image.

Recommended next geometry changes, before a camera-clear print release:

1. Adopt the recessed rail direction, retaining the 8 mm fastener offset unless another clamp arrangement replaces it.
2. Lower the camera-side band hooks and reroute the upper band away from the camera corner while keeping it clear of the sliding track.
3. Replace the raised first string guide/crossover with a lower, side-routed path. This requires checking rocker pull direction and return/overtravel again; simply lowering its guide can reverse or weaken the pull.
4. Verify the actual wallet-case lens opening/depth and capture lens/crop, then confirm the assembled mount is absent from that live camera view.

No dummy-phone test is proposed. No new phone/camera dimensions have been inferred as measurements.

## Optical assumptions and research

The model expands a square viewing envelope from **every point of the existing 38 × 40 mm illustrative camera footprint**, starting at Z=22 and extending 100 mm toward the claws. Half-angles 40°, 50° and 60° are sensitivity cases; the interactive illustration shows the first 55 mm for readability. This envelope is deliberately broader than a single circular lens cone. CAD intersection volumes are not blocked-image percentages and do not account for occlusion, distortion, stabilization or crop.

[Apple lists a 120° field of view for the iPhone 15 Pro Ultra Wide](https://support.apple.com/en-by/111829). That motivates checking a broad 120° envelope, but does not mean the square 120°-in-each-axis model matches a recorded frame. The repository identifies the phone as a 15 Pro working assumption, not a fresh confirmation. No exact 1× field angle is assumed.

The actual lens plane may be recessed relative to the wallet's credit-card storage. The existing Z=22 bump proxy is **not** a measured optical datum. Therefore “6 mm behind the assumed lens plane” is not a physical guarantee; actual lens depth and camera framing remain necessary inputs before release.

`report.json` records the checks and remaining possible intrusions. Regenerate from the repository root with `cad/.venv/bin/python cad/versions/v2/studies/camera_clearance.py`; this writes only study assets. The current V2 `print/` files now implement the recessed layout, but must not be interpreted as camera-clear prints.

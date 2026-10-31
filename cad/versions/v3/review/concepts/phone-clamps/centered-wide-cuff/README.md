# Centered cuff concepts — current C

## Fixed-retention comparison

`fixed-retention.html` compares two new alternatives side by side, with independent cubes, assembled/exploded/cutaway views, and full-assembly context. Neither is selected or promoted. All three common 21.6 mm cuffs and both sliding crossed-T attachments are unchanged.

1. **Integral stud:** the short tapered T is part of the fixed jaw, pointing into the cuff. No loose fixed-retainer parts. The 9.2 mm head requires the 6.8 mm TPU opening to deform during installation/removal; that is not a strain or force simulation. Do not force PETG over it. TPU peel, creep and pull-off strength remain untested.
2. **Short removable T:** new 8.6 mm T with the exact existing 12.2 mm shared keeper inserted sideways. The keeper is rotated about its insertion axis so its head projects along Z, not into the neck. Nominal T/neck clearance is 0.5 mm, with only 1.1 mm tip ligament and channel front wall. These thin regions are explicitly unqualified; the keeper may drift. Local straight keeper/T removal paths are sampled, not ergonomic or all-assembly service validation.

Both new jaws trim the earlier schematic upright to the backing face above Z0. The old root intersected the common cuff's lower outer curve (110.380 mm³); the new relief retains a continuous L and does not alter the cuff. The prior C baseline is not evidence of a collision-free cuff/root interface.

The removable option's side-entry channel continues past the collar's upper edge; otherwise the keeper head clips that edge during removal despite fitting when seated. This local exit relief is part of the new jaw, not a modification to the approved actuator or common cuff.

Reproduce with `build_fixed_retention.py`, then `render-fixed.cjs`. `fixed-retention.json` records checks and limitations; `fixed-retention-viewer-check.json` records browser results. Renderer/cube code is shared with the existing concept viewer through `concept_scene.js`. No slicing, print or production promotion.

October 17: the user rejected the 40 mm fixed cuff because widening beyond the green contact face crowds the volume buttons/actuator. Current C uses a **21.6 mm centered fixed cuff**, with attachment explicitly unresolved. No hidden fastener or glue is implied. All three cuffs are now identical 21.6 mm parts, including the T socket. Each opposing cuff retains one larger pierced T plus the existing 12.2 mm transverse key: two crosslocked assemblies overall. The +16 mm offset remains revoked. Nothing is promoted to manufacturing; V1/V2, active V3 solids and print jobs are untouched.

Open `index.html?concept=C` through the CAD server. Choose fixed or sliding cuff detail, then assembled, exploded or cutaway. Toggle phone/cap/actuator. Both panels have navigation cubes; click parts to identify them. PNGs come from the CAD meshes. A/B remain earlier superseded footprint comparisons, not current proposals. These labels are separate from the original five-clamp study.

## Common layout

- Current C: centered **21.6 mm fixed cuff**, two 21.6 mm sliding cuffs at Y±50 mm. Fixed attachment is deliberately absent. A/B retain their earlier 40 mm width only for comparison.
- The enlarged approved C cross-section and compliant seating curves are retained, but cuff widths and attachment cuts are new. Cyan and green are regions of ONE intended TPU 95A component, not two printed pieces.
- One constant-section L-shaped carrier junction replaces the highlighted stepped side profile. The shaft cap remains a separate, sideways-removable half with a 120 mm actuator rail. Collar fasteners/band anchors and full travel stops are omitted or schematic: these are architecture studies, not ready-to-print collars.
- A/B retain **3 mm additional phone-to-neck standoff** (X−23). C restores original X−20 and the actual bare-phone Z10..18 datum, with the unchanged bare-near actuator/button included. The 76×152×8 mm phone dimensions are not scaled. All-phone reach and service paths remain unqualified.
- The rail retains Z16..36 / screw-center Z26 and its 120 mm length. Its proposed thickness is 4.6 mm rather than 6 mm to clear the actual 14 mm stock-neck envelope. The cap/rail is therefore a new schematic proposal, not an unchanged actuator interface or print-qualified part.
- The simplified collar is drawn around the measured 14×19 mm stock envelope with nominal clearance, not the accepted 11.6×17.6 mm printed collar fit target. Do not promote this illustrative opening into manufacturing without reconciling the physical fit evidence.
- Orange = rigid jaw/cap; darker amber = new larger T; blue = the exact existing 12.2 mm shared key, colored differently only to explain reuse. It is not a stock grabber component.

## Options

| Concept | Retention | Main tradeoff |
|---|---|---|
| A — shallow broad T | Recessed broad head, short pierced stem, shared key inserted sideways | Closest to the proposed crossed-T mechanism. Tight package: 2 mm nominal neck clearance and 1.2 mm stem-tip ligament; strength unqualified. |
| B — side-loading dovetail | Broad external cuff tongue captured in a jaw track; closed end plus shared-key stop | Fewest new retainer shapes, distributed loading, no central stem. TPU peel/stretch and removal access need tests. |
| C — narrow fixed / crosslocked sliding | Fixed retention unresolved; one larger pierced T crossed by a shared key at EACH 21.6 mm sliding cuff | Keeps fixed contact within 21.6 mm. Sliding retention needs drift/load testing; fixed attachment still needs design. |

The cross-key blocks the main T's withdrawal only while it stays inserted. These concepts do **not** establish self-locking retention of the small key. Phone compression should bear on the backing shoulders rather than relying solely on pins. Actual phone slip, TPU creep and printed strength are unmeasured.

## Reproduction and evidence

From this directory, run the project's CAD Python on `build_concepts.py` to regenerate `assets/`, `manifest.json`, and `checks.json`. `render.cjs` uses the configured Playwright and Chrome runtime against the local CAD server to generate the images and `viewer-check.json`.

The CAD checks distinguish collision-free assembled interfaces from deliberate obstruction during pull-out/end-escape tests. They check valid solids, local key/cuff/receiver intersections, actual stock-neck intersections, and nominal retention obstruction. They are not a qualified manufacturing or load audit. Exploded spacing illustrates separation; it is not a collision-validated assembly animation. Cutaway removes material only for display.

Current C has no fixed-cuff or fixed-jaw intersection with the displayed bare-near actuator. Fixed cuff/button distance is 14.914 mm in this one configuration. There is no fixed retention test because that attachment is not designed. Browser checks cover both cuff targets, assembled/exploded/cutaway modes, cubes and 320/390 px layouts.

No claim of universal thickness fit or camera/screen clearance is made. The 18/20 mm examples remain too thick for the unchanged C cross-section; even thin-phone seating needs physical TPU tests. This work does not resolve the earlier outgoing-twine/carrier interference. No slicing or print command is authorized by this concept review.

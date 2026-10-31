# V3 manufacturing exports — not approved for printing

## Current revision: deep-groove-pulley-v3

Redirect pulley groove doubled to 2.2 mm nominal depth, preserving its external envelope and bore. [Actual PETG slice review](jobs/2026-10-25-deep-groove-pulley/) reports zero support/interface paths with automatic supports enabled, 0.7315 g and 13.25 minutes. Only the pulley requires a replacement print for this change. No job sent; live groove quality and string retention remain unvalidated.

One `clip_string_guide` in ELEGOO TPU 95A replaces the two old guide designs and all three guide bands. Print end-on-bed (6 mm height), with the 4 mm eye vertical. Geometry is constant-section but no slice has qualified it yet. Test snap installation, axial sliding and actual cord travel on the stock neck. Two lower guides are removed. Current total: 12 designs / 22 printed pieces; five rubber bands.

Five identical long screws (four collar + one actuator) and five matching nuts are now specified in ELEGOO TPU 95A. Use the current `collar_screw` and `thumb_nut` exports, 0.12 mm thread layers, with a fresh TPU slice; old PETG/PLA jobs do not implement this material change. No print has been sent. Long-screw TPU fit, loaded retention and creep remain physical checks despite the user's positive TPU tightening feedback.

### Previous jaw support study

Sliding cleat, tongue shoulders and all three cuff-stud undersides use 35° from the bed. The user rounds the tested 34° functional minimum up for memorability; the slicer-only boundary is 31°. Exact existing 21.6 mm TPU cuffs remain unchanged. New retaining ramps require a physical pull-out test; square-stud success does not transfer.

Matched Bambu PETG Translucent / A1 mini 0.4 / 0.12 mm slices: [sliding jaw](jobs/2026-10-25-sliding-jaw-angle-35/) has zero supports; [fixed jaw](jobs/2026-10-25-sliding-jaw-fixed-angle-35/) has zero at its stud but retains support elsewhere (neck cavity/fixed cleat). These are offline reviews, not print authorization or physical validation. After the next print containing these 35° features, ask the user whether they printed successfully without supports; retain this pending check until physical feedback arrives.

### Preceding direct-root-fixed-jaw-v3

Carrier-only update: track and fixed band cleat move +2.7 mm X to join the collar directly through the full-depth end. No thin connector. Cuffs, phone, sliding-jaw stop, cap and fasteners retain their positions/designs. Carrier STEP/STL must be freshly sliced; no print authorized. Physical root strength and band preload are unqualified.

### Preceding flat-bed-shaft-cap-v3

Whole exterior side flattened to X12, including both rail wings and all four screw seats, with this face down on Z0. Rail thickness is 4.2 mm. Matching bracket bearing plate extends inward 1.8 mm; collar screws shorten at the head end to 30.2 mm threaded span. These three designs need new prints; do not mix the previous longer collar screws with this cap near the phone screen. Existing nuts, cuffs and other parts are unchanged. No fresh slice or support-free claim. Fit, strength and preload remain unqualified.

### Preceding straddled-four-bolt-collar-v3

The fixed carrier and shaft cap now have two screw/nut pairs on each axial side of the jaw, four pairs total. Collar bodies span Z−40..70 (110 mm), with stations at Z−30/+60. The old left tail is removed; the new right pair clears the jaw-band cleat for nut removal. The accepted neck opening is recut through all boss roots. Existing collar screws/nuts, actuator, sliding jaw and three identical 21.6 mm TPU cuffs are unchanged by this revision.

Current STEP/STL exports and `manifest.json` are regenerated from the editable source, but neither new collar half has been sliced or print-qualified. Use a fresh job directory for any future slice; never reuse the historical jobs below as toolpaths for this geometry. The current BOM has 12 designs / 22 pieces. Full-neck fit, retention and strength still need physical validation; existing phone-fit and outgoing-twine issues remain recorded in the review reports.

## Historical concave-boot-guide-v3 print preparation

The [two-piece slice review](jobs/2026-10-14-concave-boot-guide/index.html) contains only the revised actuator bracket and sliding plunger, at 100% scale. It uses the recorded A1 mini / 0.4 mm / Generic PLA reference recipe, 0.12 mm layers, 3 walls, 15% gyroid and automatic Normal Snug supports. The concave boot blend and full-height extended guide supersede the earlier shapes. See the current `review.json` for exact estimates and hashes; no new print was sent.

The user reports printing the earlier bridge plate and approves its pulley, screw/nut and cross-key. Preserve that exact job and its physical feedback. New bracket/plunger geometry is unprinted. The raised wheel has 1 mm total axial clearance on a single bearing boss; the outer cheek/arm is gone. Cantilever strength and rotation remain physical checks. Outgoing twine intersects the carrier in wallet-near, bare-near and small-near, including the previous +29 mm example: resolve this before another print. The 14 mm jaw pocket still conflicts with the recorded 18/20 mm phone envelopes.

## Historical print-preparation notes (superseded by the current section)

Current actuator-only plate: [interactive support review](jobs/2026-10-14-actuator-bridge/index.html), seven pieces including its single mounting screw/nut. Offline slice estimate: **13.75 g / 1 h 47 min / 0.450 g support and interface**, all on the bracket. Only axle supports are disabled versus the [preserved ramped plate](jobs/2026-10-14-actuator-ramped/index.html); geometry, orientation, placement and profiles match. Its slot roof uses the same bridge paths without support beneath it. Check sag and cross-key fit after printing; do not force insertion. The user declined the teardrop mounting-hole roof; the bore stays round. Complete input/sliced 3MFs, profiles, bridge close-up, toolpath previews and hashes are retained. No printer contacted; loaded material/bed readiness still need checking before a separately authorized start. All other exports remain unsliced at this revision.

Current revision: ramped-retainers-v3, 2026-10-14. The fixed-band lip and moving shared cleat now have ramped undersides, both pulley groove flanks are steeper, and the outer fork leg extends 2.6 mm to the bed. Retaining rims and the open wheel cavity remain; band/string paths, part positions and print orientations are unchanged. Rail locating lugs remain removed; the mount relies on single-screw preload and friction for sliding and rotation resistance. The offset bore and flat back are unchanged. The rear pulley cheek reaches the common Y5.4 bed-contact plane; the recessed cross-key pocket is gone. Axle span is 20.6 mm, and its retaining slot, option-B cross-key and keeper band sit 2.2 mm farther outboard. Print the bracket without these removable parts attached. The selected key retains its wide T-head with uniform 3 mm thickness. The earlier bracket-tab, shoe/root and rail-screw cleanup remains. No V3 parts have been printed. The older slice comparison below is historical; use the current actuator job above for exact current support placement.

The preceding flat-back change blended the reinforced haunch into the spine without the raised end lip. The plate and bore are offset to make the Y5.4 back flat while retaining 5.4 mm beside the mounting hole. The opposite projection remains. Section area remains about 67 mm²; this does not establish load capacity. The latest cleanup preserves these features except for the explicitly removed rail locating lugs.

Export orientation is −90° about X, with the common +Y back face on the bed. The bracket must be printed separately from its removable parts. The matched offline reference slices in `../review/flat-back-slice/` use A1 mini / 0.4 mm, Generic PLA, 0.2 mm layers, 3 walls, 15% gyroid and Normal Snug. They are comparative estimates, not qualified PLA+ or approved print jobs; inspect pulley, key-pocket and guide-lip support contact and removal. No support-free claim.

Reference comparison: support extrusion estimate **2.73 → 0.90 g**, total slicer estimate **10.75 → 9.09 g**. Effective settings and selected layer paths were checked; broad support under the spine is eliminated, but local support remains. Neither saved sliced 3MF is authorized to start.

The preceding compact-axle iteration changed the bracket, axle and cross-key. The flush-T cap remains unchanged: its wings share the X12 exterior plane and the rail remains 120 mm long. Cap export rotates +90° about Y to put the common outer face down; no support-free slice claim. The bracket uses one closed bore without locating lugs. Fully remove nut and screw, move outward 4.5 mm, lower the module 2 mm, then withdraw along the conservative sampled clearance path.

Use `manifest.json` and the [BOM](../bom.md): 12 designs, 22 printed pieces. The bracket has no twine-guide holes or lower base. The axle is 20.6 mm long with a recessed 1.6 mm head and an outboard cross-key/keeper band. Front/rear bearing lands are 2/6.2 mm. The earlier 18.4 mm axle does not match this flush-back bracket. Head strength, bearing wear and key fit are untested.

Across the preceding plunger iterations, changed parts also include **both collar halves**, pulley, nearest dual guide and **four longer collar screws**. Do not mix the former collar screw length with the new ears. The rail screw retains its earlier thread and head but loses the former contact nose; all five nuts, lower centered guides and jaw contact geometry are unchanged.

The long collar screws preserve the successful 8×3 profile and head, but their length/flush tip are new and untested. Use the recorded 0.12 mm thread recipe for both screw designs and nuts. This is a starting recipe, not sliced approval. All new-part orientations, supports and mating-surface quality require fresh slicer review.

Physical tests are required for collar closure/retention, axle/key fit and strength, keeper-band retention, pulley friction, button gap/force/overtravel, jaw strength and assembly fit. The unchanged 18/20 mm phone proxies still do not fit the 14 mm pocket. The inline band and prescribed animation do not establish safe button force.

Do not assume all rail positions are usable: the near-side outgoing cord intersects the carrier at sampled centers +24..+28 mm; the existing +29 mm example clears. The longer axle now intersects the carrier at the former far-side −24 mm candidate. See `../review/compact-keyed-plunger.json` for separately checked outward candidates; inward reach remains asymmetric and unqualified physically.

No print was started or authorized. Historical V2 jobs are untouched at `../../v2/print/jobs/`; their orientations, profiles and outcomes do not qualify these new parts.

# V3 manufacturing exports — not approved for printing

Current revision: flat-back-mount-v3, 2026-10-09.

The latest manufacturing change is the actuator bracket only: the reinforced haunch now blends into the spine without the raised end lip. The plate, bore and full-length locating lugs are offset to make the Y5.4 back flat while retaining 5.4 mm beside the mounting hole. The opposite projection remains. Section area remains about 67 mm²; this does not establish load capacity. Other manufacturing part designs are unchanged, although the assembled rail screw/nut follow the offset bore.

Export orientation is −90° about X, with the common +Y back face on the bed. The bracket must be printed separately from its removable parts. The matched offline reference slices in `../review/flat-back-slice/` use A1 mini / 0.4 mm, Generic PLA, 0.2 mm layers, 3 walls, 15% gyroid and Normal Snug. They are comparative estimates, not qualified PLA+ or approved print jobs; inspect pulley, key-pocket and guide-lip support contact and removal. No support-free claim.

Reference comparison: support extrusion estimate **2.73 → 0.90 g**, total slicer estimate **10.75 → 9.09 g**. Effective settings and selected layer paths were checked; broad support under the spine is eliminated, but local support remains. Neither saved sliced 3MF is authorized to start.

The preceding compact-axle iteration changed the bracket, axle and cross-key. The flush-T cap remains unchanged: its wings share the X12 exterior plane and the rail remains 120 mm long. Cap export rotates +90° about Y to put the common outer face down; no support-free slice claim. The bracket uses one closed bore and two locating lugs. Fully remove nut and screw, disengage the lugs outward 4.5 mm, lower the module 2 mm, then withdraw.

Use `manifest.json` and the [BOM](../bom.md): 13 designs, 21 printed pieces. The bracket has no twine-guide holes or lower base. The recessed axle is 18.4 mm long with a 1.6 mm head, a shorter rear cross-key and keeper band. Front/rear bearing lands are 2/4 mm. Head strength, bearing wear and key fit are untested.

Across the preceding plunger iterations, changed parts also include **both collar halves**, pulley, nearest dual guide and **four longer collar screws**. Do not mix the former collar screw length with the new ears. The one rail screw and five nuts retain their earlier geometry; lower centered guides and jaw contact geometry are unchanged.

The long collar screws preserve the successful 8×3 profile and head, but their length/flush tip are new and untested. Use the recorded 0.12 mm thread recipe for both screw designs and nuts. This is a starting recipe, not sliced approval. All new-part orientations, supports and mating-surface quality require fresh slicer review.

Physical tests are required for collar closure/retention, axle/key fit and strength, keeper-band retention, pulley friction, button gap/force/overtravel, jaw strength and assembly fit. The unchanged 18/20 mm phone proxies still do not fit the 14 mm pocket. The inline band and prescribed animation do not establish safe button force.

Do not assume all rail positions are usable: the near-side outgoing cord intersects the carrier at sampled centers +24..+28 mm; the existing +29 mm example clears. The far-side −24 mm candidate clears digital checks. See `../review/compact-keyed-plunger.json`; inward reach remains asymmetric and unqualified physically.

No print was started or authorized. Historical V2 jobs are untouched at `../../v2/print/jobs/`; their orientations, profiles and outcomes do not qualify these new parts.

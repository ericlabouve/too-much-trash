# R4 bill of materials

Material stages: **initial prototype uses existing PLA or PLA+ for rigid prints** (PETG is also acceptable). **Later configuration uses PETG for rigid prints and TPU for compliant accessories**. TPU does not replace the structure, precision fasteners or springs. PLA/PLA+ functional durability remains unverified; recheck fits when switching filament. No brand-specific PLA+ assessment is required.

## Printed

| File | Quantity | Initial prototype | After acquiring TPU | Purpose |
| --- | ---: | --- | --- | --- |
| `print/carrier.stl` | 1 | PLA / PLA+; PETG optional | PETG; retain rigid construction | Fixed jaw, guide, near-side actuator rail, integral shaft saddle |
| `print/sliding_jaw.stl` | 1 | PLA / PLA+; PETG optional | PETG; retain rigid construction | Opposing padded jaw, far-side actuator rail, captive draw-screw nut |
| `print/neck_cap.stl` | 2 | PLA / PLA+; PETG optional | PETG; retain rigid construction | Identical caps for phone and handle collars |
| `print/actuator_bracket.stl` | 1 | PLA / PLA+; PETG optional | PETG; retain rigid construction | Housing reaction, metal pivot support, stroke stop and adjustment slots |
| `print/rocker.stl` | 1 | PLA / PLA+; PETG optional | PETG; retain rigid construction | Cable input arm and padded button contact |
| `print/handle_anchor.stl` | 1 | PLA / PLA+; PETG optional | PETG; retain rigid construction | Compact collar with housing reaction beside shaft |

Six unique STL files, seven printed pieces. Initial pads are cut from compliant sheet. Later TPU accessories are listed below; their printable designs have not yet been added to this six-file export set.

## Purchased (provisional selection; verify dimensions before ordering)

| Item | Qty | Initial prototype | After acquiring TPU | Fit / purpose |
| --- | ---: | --- | --- | --- |
| M4×80 draw screw, ≤16 mm thumb head ×5 mm thick | 1 | Purchased metal hardware | Same; retain conventional hardware | Adjust opposing jaw; 80 mm measured under head. Ordinary socket screw is usable before mounting, but thumb head allows in-place adjustment. |
| M4 square nut, nominal 7 ×7 ×3.2 mm | 1 | Purchased metal hardware | Same; retain conventional hardware | Top-loading pocket, 7.5 mm across; do not substitute an oversized flange nut |
| M4×35 through-bolts, washers, locking nuts | 4 sets | Purchased metal hardware | Same; retain conventional hardware | Two per rectangular collar; verify actual stack and trim excessive projection |
| M3×25 bolts, broad washers, locking nuts | 2 sets | Purchased metal hardware | Same; retain conventional hardware | Bracket/rail slotted adjustment; washers bridge slots |
| 3 mm smooth metal pivot, about 26–30 mm usable length, washers and axial retainers | 1 set | Purchased metal hardware | Same; retain conventional hardware | Both ears support axle; leave rocker and spring free, no clamping friction. Choose actual retention style before assembly. |
| M3 threaded contact screw/rod, about 25 mm, two thin locknuts | 1 set | Purchased metal hardware | Same; retain conventional hardware | Adjustable contact; cut excess and cover end with soft tip |
| M3×20 stop screw, 5.5 mm square nut ≤2.4 mm thick, locking nut | 1 set | Purchased metal hardware | Same; retain conventional hardware | Adjust positive rocker travel limit; set conservatively before button contact |
| Bicycle brake housing, 5 mm nominal OD, ferrules | ~1 m, 2 ferrules | Purchased brake housing + ferrules | Same; retain conventional hardware | Bore is provisionally 5.6 mm; measure ferrule OD and seating length |
| Stainless brake inner wire, about 1.6 mm | ~1 m | Purchased stainless inner cable | Same; retain conventional hardware | Cut after routing; terminate ends safely |
| Screw-on cable stop/barrel ≤5 mm OD at rocker; rated loop clamp at handle; end caps | 1 each / as needed | Purchased metal hardware | Same; retain conventional hardware | Stop bears on the input-arm face away from the housing; inner-wire path is 2.2 mm. No dependence on a factory brake nipple shape. |
| Torsion return spring, fits 3 mm pivot; ≤6 mm OD, ≤2.7 mm coil length, ~0.4 mm wire | 1 | Purchased metal spring | Same; retain conventional hardware | Target initial torque 5 N·mm, rate ~30 N·mm/rad. Spring legs must match seats; test supplied spring, these are design targets. |
| Closed-eye extension spring, ~35 mm eye-to-eye relaxed, ≤8 mm OD | 1 | Purchased metal spring | Same; retain conventional hardware | Target initial tension 1.5 N, rate 0.055 N/mm, **rated working extension ≥45 mm**. This is a sourcing requirement, not a validated stock SKU. See design review. |

Fastener envelopes in the STEP/Chrome assembly omit threads; spring coil and strap shapes are indicative. The hardware drawing is not a supplier specification. Measure selected spring and ferrule before final printing; parameters and pockets can then be adjusted.

## Soft accessories and optional printable replacements

These recommendations do not add new STL files yet. Keep the current purchased thumb head and route ties until their optional replacements are modeled.

| Component | Qty | Initial prototype | After acquiring TPU | Purpose / status |
| --- | ---: | --- | --- | --- |
| Side jaw pads | 2 | Cut compliant rubber sheet | Printed TPU inserts | Nominal 0.8 mm thick; trim to phone thickness ×24 mm. Verify compressed fit and grip. |
| Rear jaw pads | 2 | Cut compliant rubber sheet | Printed TPU inserts | Nominal 0.8 ×9 ×24 mm; locate rear face without hard contact. |
| Shaft-contact liners/shims | As needed | Thin compliant rubber sheet | Printed TPU liners | Fit the existing 0.6 mm total collar allowance; thickness must suit compressed fit. |
| Soft button-contact cap | 1 | Purchased rubber/silicone cap | Printed TPU cap | Covers metal contact screw; remains replaceable. |
| Thumb wheel | 1, part of draw-screw assembly | Purchased head, or proposed PLA/PLA+ knob | Proposed PETG knob | Captures a metal screw head; screw and nut remain metal. Optional knob STL not yet modeled. |
| Housing route clips/ties | Several | Purchased removable ties; proposed PLA/PLA+ rigid guides | PETG guides or TPU retaining loops, according to geometry | Routing only; do not replace bolted housing reaction anchors. Optional STL not yet modeled. |
| Trigger strap | 1 | Purchased hook-and-loop textile | Same textile strap | Flexible connection to moving trigger; retain textile attachment. |
| Optional trigger saddle | 0–1 | Purchased soft pad if needed | Proposed TPU saddle | Protects trigger beneath strap; not a replacement cable termination. Not yet modeled. |
| Independent phone tether | 1 | Purchased textile tether | Same textile tether | Independent retention; do not replace with an unqualified printed strap. |

Rigid PLA/PLA+ prints of TPU accessory shapes would only show geometry; they cannot reproduce cushioning, stretch or grip. Getting TPU alone does not require replacing existing satisfactory PETG structural parts. Material recommendations are not proof of physical fit or durability.

# R4 bill of materials

One row per item or explicitly bundled hardware set. Quantities are for one assembly. **Choose one supply option per row:** later printed alternatives replace their purchased equivalents; they are not additional quantities. The thumb head is included in the draw-screw assembly. Hardware sets include their listed nuts, washers or retainers.

**Initial prototype:** PLA/PLA+ rigid prints (PETG optional), purchased metal hardware, compliant sheet/caps and textile attachments. **Later:** PETG rigid prints plus proposed TPU soft accessories. Only the six rigid STL designs (seven pieces) are currently exported; optional knob, guides and TPU accessory designs are not yet modeled. PLA/PLA+ durability is unverified; recheck fits when switching materials. No brand-specific PLA+ assessment is required.

## Complete assembly

| Component / file | Quantity | Need | Initial prototype / supply | Later material / replacement | Purpose and counting notes |
| --- | ---: | --- | --- | --- | --- |
| `print/carrier.stl` | 1 | Required | Print: PLA / PLA+; PETG optional | Print: PETG; retain rigid construction | Fixed jaw, guide, near-side actuator rail, integral shaft saddle |
| `print/sliding_jaw.stl` | 1 | Required | Print: PLA / PLA+; PETG optional | Print: PETG; retain rigid construction | Opposing padded jaw, far-side actuator rail, captive draw-screw nut |
| `print/neck_cap.stl` | 2 | Required | Print: PLA / PLA+; PETG optional | Print: PETG; retain rigid construction | Identical caps for phone and handle collars |
| `print/actuator_bracket.stl` | 1 | Required | Print: PLA / PLA+; PETG optional | Print: PETG; retain rigid construction | Housing reaction, metal pivot support, stroke stop and adjustment slots |
| `print/rocker.stl` | 1 | Required | Print: PLA / PLA+; PETG optional | Print: PETG; retain rigid construction | Cable input arm and padded button contact |
| `print/handle_anchor.stl` | 1 | Required | Print: PLA / PLA+; PETG optional | Print: PETG; retain rigid construction | Compact collar with housing reaction beside shaft |
| M4×80 draw screw including thumb head (≤16 mm diameter ×5 mm thick) | 1 | Required | Purchased metal hardware | Metal screw; retain purchased head OR replace head with proposed PETG knob | Adjust opposing jaw; 80 mm measured under head. Ordinary socket screw is usable before mounting, but thumb head allows in-place adjustment. Count once: thumb head is included, not a separate purchase. Optional printed knob is not yet modeled; metal screw remains required. |
| M4 square nut, nominal 7 ×7 ×3.2 mm | 1 | Required | Purchased metal hardware | Same; retain conventional hardware | Top-loading pocket, 7.5 mm across; do not substitute an oversized flange nut |
| M4×35 through-bolts, washers, locking nuts | 4 sets | Required | Purchased metal hardware | Same; retain conventional hardware | Two per rectangular collar; verify actual stack and trim excessive projection |
| M3×25 bolts, broad washers, locking nuts | 2 sets | Required | Purchased metal hardware | Same; retain conventional hardware | Bracket/rail slotted adjustment; washers bridge slots |
| 3 mm smooth metal pivot, about 26–30 mm usable length, washers and axial retainers | 1 set | Required | Purchased metal hardware | Same; retain conventional hardware | Both ears support axle; leave rocker and spring free, no clamping friction. Choose actual retention style before assembly. |
| M3 threaded contact screw/rod, about 25 mm, two thin locknuts | 1 set | Required | Purchased metal hardware | Same; retain conventional hardware | Adjustable contact; cut excess and cover end with soft tip |
| M3×20 stop screw, 5.5 mm square nut ≤2.4 mm thick, locking nut | 1 set | Required | Purchased metal hardware | Same; retain conventional hardware | Adjust positive rocker travel limit; set conservatively before button contact |
| Bicycle brake housing, 5 mm nominal OD, ferrules | ~1 m, 2 ferrules | Required | Purchased brake housing + ferrules | Same; retain conventional hardware | Bore is provisionally 5.6 mm; measure ferrule OD and seating length |
| Stainless brake inner wire, about 1.6 mm | ~1 m | Required | Purchased stainless inner cable | Same; retain conventional hardware | Cut after routing; terminate ends safely |
| Screw-on cable stop/barrel ≤5 mm OD at rocker; rated loop clamp at handle; end caps | 1 each / as needed | Required | Purchased metal hardware | Same; retain conventional hardware | Stop bears on the input-arm face away from the housing; inner-wire path is 2.2 mm. No dependence on a factory brake nipple shape. |
| Torsion return spring, fits 3 mm pivot; ≤6 mm OD, ≤2.7 mm coil length, ~0.4 mm wire | 1 | Required | Purchased metal spring | Same; retain conventional hardware | Target initial torque 5 N·mm, rate ~30 N·mm/rad. Spring legs must match seats; test supplied spring, these are design targets. |
| Closed-eye extension spring, ~35 mm eye-to-eye relaxed, ≤8 mm OD | 1 | Required | Purchased metal spring | Same; retain conventional hardware | Target initial tension 1.5 N, rate 0.055 N/mm, **rated working extension ≥45 mm**. This is a sourcing requirement, not a validated stock SKU. See design review. |
| Side jaw pads | 2 | Required | Cut compliant rubber sheet | Proposed printed tpu inserts (STL not yet modeled) | Nominal 0.8 mm thick; trim to phone thickness ×24 mm. Verify compressed fit and grip. |
| Rear jaw pads | 2 | Required | Cut compliant rubber sheet | Proposed printed tpu inserts (STL not yet modeled) | Nominal 0.8 ×9 ×24 mm; locate rear face without hard contact. |
| Shaft-contact liners/shims | As needed | Fit-dependent | Thin compliant rubber sheet | Proposed printed tpu liners (STL not yet modeled) | Fit the existing 0.6 mm total collar allowance; thickness must suit compressed fit. |
| Soft button-contact cap | 1 | Required | Purchased rubber/silicone cap | Proposed printed tpu cap (STL not yet modeled) | Covers metal contact screw; remains replaceable. Count once here; metal contact-screw row excludes the cap. |
| Housing route clips/ties | Several | Required | Purchased removable ties; proposed PLA/PLA+ rigid guides | PETG guides or TPU retaining loops, according to geometry | Routing only; do not replace bolted housing reaction anchors. Optional STL not yet modeled. Choose ties OR printed guides, not both as separate requirements. |
| Trigger strap | 1 | Required | Purchased hook-and-loop textile | Same textile strap | Flexible connection to moving trigger; retain textile attachment. |
| Optional trigger saddle | 0–1 | Optional | Purchased soft pad if needed | Proposed TPU saddle | Protects trigger beneath strap; not a replacement cable termination. Not yet modeled. |
| Independent phone tether | 1 | Recommended | Purchased textile tether | Same textile tether | Independent retention; do not replace with an unqualified printed strap. |

## Interpretation

- **Required:** included in the proposed working assembly.
- **Fit-dependent:** use only where needed to obtain the intended fit.
- **Recommended:** independent phone retention, not a mechanism component.
- **Optional:** an additional protective accessory, not required for operation.
- Hardware quantities and dimensions are provisional until actual parts are selected. Spring values are targets, not validated supplier specifications.
- The CAD hardware models omit threads and some details; they are illustrative envelopes, not printable files. The viewer shows representative items, not every washer or the full required quantity.
- Rigid PLA/PLA+ cannot reproduce TPU cushioning or grip. Acquiring TPU does not require replacing satisfactory PETG structure.

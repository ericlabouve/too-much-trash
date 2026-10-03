# Astra review of extended-saddle-r10 — 2026-10-02

Independent reviewer: GPT-6 Astra, explicitly requested by the user. Review covered source geometry, load paths, fastener access, cap withdrawal, reference slicing and limitations of the existing checks. No printer commands were sent. Geometry remains r10.

## Recommendation

Retain r10 geometry for the first fit prototype. Address the confirmed service-access sequence and reference slicing configuration before use. Prepare/review current carrier and cap slices before a real job; printing remains paused.

## Confirmed issue: near-side actuator screw access

At the wallet/bare/small position, the inner rail screw center is Y=5, Z=−14. Its head spans X=12..16, leaving 2.7 mm to the extended cap. Straight withdrawal by 3 mm produces 46.18 mm³ of interference. Leaving that screw in the rail also blocks the cap's +6 mm release move (508.00 mm³ overlap). Earlier cap checks assumed the actuator had been removed without checking how to accomplish that.

**Resolution:** remove the phone and release twine tension. Loosen the rail nuts and slide the complete near-side actuator +20 mm along Y, to screw centers 25/73 mm. Remove the nuts toward +X, lift the module outward over the retained screws, then withdraw both rail screws toward −X. Only then remove the clamp fasteners and follow the cap's sideways removal path. The large illustrative phone starts at screw centers 41/89 mm and needs no service shift. Reverse this sequence during assembly.

The reviewer tested all four near-side phone configurations with 1 mm shift/withdrawal samples and conservative screw envelopes, plus sampled outward module/nut removal. The repository regression is `../source/check_service_access.py`, with results in [service-access.json](service-access.json). Its nut cylinder bounds external hex rotation; intentional mating threads are excluded because a real nut unscrews helically, not by axial translation through its threads. Physical finger access, friction, print tolerance and support residue remain untested.

Instructions were corrected in the V2 README, print README and project guide. No clearance notch or extra hardware was needed.

## Confirmed issue: historical reference slicing defaults

The old `check_slices.py` default used an A1 profile, forced all parts to 0.2 mm, and assigned the shaft cap 35% infill. Its thread flag forced 0.12 mm globally. These defaults disagreed with the current A1 mini/per-part instructions.

**Resolution:** default to A1 mini 0.4, explicit Textured PEI, per-part manifest layer height, and cap 40% infill. Threaded parts require 0.12 mm or finer; normal structural parts retain 0.2 mm. Preserve bed orientation during arranging. Successful standard screw/nut reference settings are 2 walls/15%, with 30/60 mm/s wall speeds and 100% cooling after initial layers; these remain isolated-print settings, not qualified load-bearing fasteners. The Generic PLA reference preset is not proof of compatibility with the loaded off-brand PLA+.

Fresh cap and screw reference slices completed without warnings. Their actual G-code settings were checked for printer/nozzle, layer height, walls, infill and bed type. See [slice smoke report](astra-slice-smoke.json). This two-part smoke check does not replace full current carrier/cap toolpath and support review or a reviewed print-job artifact.

## Structural concerns requiring physical checks

- Cap clamp ears are 3.5 mm thick versus 7.5 mm on the carrier. Screw centers sit 11.2 mm beyond the shell edge, with sharp roots. Cap-ear bending under excessive tightening is plausible. Tighten alternately and gently; inspect for bending, whitening and cracking. Successful threads do not establish useful preload or resistance to loosening.
- The diagonal pair of screw stations can twist the long shell if tightened unevenly. Rebalancing ear thickness to 5.5/5.5 mm without changing grip length is an optional refinement; the review did not establish it as necessary before the first fit prototype.
- The twin 5 mm webs and solid jaw root genuinely broaden the connection into the long saddle. No disconnected or obviously narrow replacement load path was found. This is a geometric finding, not a structural rating.
- Cap removal has approximately 0.7 mm nominal clearance after initial sideways movement. It clears tested non-shaft stock geometry and nominal shaft opening; the historical 14×19 shaft proxy remains inconsistent with the accepted opening and is not a fit validation.
- Actual neck taper/ribs over 102 mm, grip under load, PLA creep, band force, twine friction and camera framing remain physical checks. No dummy-phone test is required.

## Next physical sequence after print authorization

Print/review the carrier and cap as the next fit stage, reusing successful screws/nuts. Fit the empty harness, verify the service sequence and evenly tightened retention against hand-applied rocking, twisting and sliding. Inspect the ears and threads. Then fit the real phone while supported over a table. The current review does not authorize or start a print.

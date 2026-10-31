# Compact phone retention — five concepts

Research date: 2026-10-14. **Concept study, not active CAD or validated retention.** The user reports that the interconnected fixed/sliding jaws do not secure the phone sufficiently. The direction of escape, loads, band preload and contact condition have not been measured. TPU is expressly in scope for this study; earlier no-padding construction guidance is not applied to these proposed inserts.

## What we retain

Keep the existing sliding tongue and fixed-jaw track as the width-adjusting structural connection, and rubber bands as the closing-force source. Current V3 has two sliding-jaw contacts 100 mm apart, opposed by one central fixed-jaw contact; 8 mm contact pads, 6 mm walls, 4 mm lips and a 14 mm pocket. No geometry is changed by this report. The actuator, screen, camera and end-for-end phone reversal remain keepouts/requirements.

Use X for phone width / jaw closure, Y for phone length, and Z for thickness / screen-normal lift in the illustrations. Do not imply that several angled arrows are several independent actuators: contact reactions derive from the same closing force.

## Research findings, and what they do not prove

- **Soft contact is a useful baseline, not a retention guarantee.** Manfrotto's compact MCLAMP uses two silicone contact pads. That establishes a manufacturer example of compliant contact in a small generic clamp; silicone behavior does not establish a coefficient of friction for printed TPU. [Manfrotto MCLAMP](https://www.manfrotto.com/ca-en/universal-smartphone-clamp-with-thread-connections-mclamp/)
- **Location and clamping can be separate functions.** RAM's Quick-Grip uses a spring-loaded holder with adjustable side keepers. Its example motivates explicit geometric escape stops rather than assuming higher squeeze force will solve every direction of motion. Our proposed parts are not a reproduction or a performance-equivalent substitute. [RAM Quick-Grip](https://rammount.com/products/RAM-HOL-PD3-238AU)
- **A secondary corner keeper is a distinct retention layer.** RAM offers an elastomeric tether that fits around phone corners in addition to its X-Grip clamp. This motivates concept E; it does not qualify a printed TPU loop or make it fail-safe. [RAM X-Grip phone tether](https://rammount.com/products/ram-tether1u)
- **Design TPU pieces to print flat, without buried supports.** Prusa notes that flexible-material softness changes print difficulty and that bridges/overhangs are challenging; supports can adhere strongly. This supports separate, simple liners/straps instead of a one-piece hollow soft cage. Its printer profiles are not an A1 mini recipe. [Prusa flexible-material guide](https://help.prusa3d.com/article/flexible-materials_2057)
- **A compressed insert is not a permanent spring.** BASF documents TPU compression set and grade-dependent viscoelastic response. These are reasons to test preload loss, temperature and cycling, not numerical design allowables for our unknown printed filament. Do not transfer molded-sample limits to FDM inserts. [BASF Elastollan material properties](https://www.basf.com/dam/jcr:b36f0d83-b60b-35d8-8dab-35f7f0795b37/basf/www/kr/documents/ko/product/Elastollan_Material%20Properties.pdf)

The five mechanisms below are **our proposals**, informed by these principles. No manufacturer source validates their dimensions, strength or holding force.

## A — Three keyed V-saddles: smallest change

Replace the hard contact surface at each of the existing three stations with a shallow, open TPU V-saddle. Two rounded sloping faces meet the phone/case's front and rear edge shoulders. Jaw closure compresses them laterally and seats the thickness between them. A broad T-shaped root slides into an open-ended rigid pocket, with a positive end stop; do not rely on adhesive or a loose cap.

- **Retention:** softer conforming contact and opposed thickness reactions; current rigid lips remain backup lift stops. Sliding along Y is still primarily friction-controlled. The V is open, not a snap-over hook.
- **Compactness:** three small inserts at existing stations; no additional frame, screw or linkage. Remove/recess rigid contact material to make room for TPU rather than simply narrowing the existing pocket.
- **Print concept:** print each short V extrusion on its end so the channel is open through the print direction. Round contact edges; avoid tiny thin fins. Exact TPU grade, wall thickness and preload are unselected.
- **Risk:** rounded or tapered cases can roll in a poorly chosen V; two-point contact may concentrate load. A deep V can wedge on a case or press glass. This is not a universal-fit claim.
- **Visual:** existing left T jaw with two cyan pads at Y±50 and one cyan pad on the opposite center jaw. Include a magnified X/Z section showing two angled contact normals, an open mouth and the captured root.

## B — C-wrap cuffs: local lift capture

At those same three stations, use short split TPU cuffs with a rigid-backed side pad and front/rear return fingers. The cuffs wrap only the outer case edge; jaw opening permits insertion, and a deliberate outward peel tab releases each front return. A mechanically trapped root prevents a whole cuff from sliding off the jaw.

- **Retention:** width closure plus local front/rear geometric overlap. This is more explicit lift capture than A, but it still lacks a positive stop along phone length.
- **Compactness:** no long arms or full phone case. Three local cuffs, with room for the actuator between contact stations.
- **Print concept:** print each C-shaped extrusion on its end with its slot visible in the bed plane; avoid closing an unsupported roof. Broad radiused return roots, not sharp hooks.
- **Risk:** flexible hooks can peel off, tear or take a set; they are not hard-lock safety catches. No usable screen overlap is acceptable. A front return is feasible only if the actual case rim/bezel provides a non-screen bearing area; otherwise this concept must change, not silently cover the display. Front/rear geometry may need thickness families.
- **Visual:** same three locations as A, but explicit C-shaped side sections wrapping a case rim; show the release tab and rear support, not merely thicker V pads. Illustrate lift direction and its geometric blocker.

## C — Four corner cups: positive longitudinal stops

Keep the X interlock. Replace the contact ends with two short adjustable Y outrigger pairs, one carried by each jaw, ending in four small rigid L-shaped cups with removable TPU liners. The Y adjustment puts the cups at actual corners; a printed pin or screw locks each chosen span. No rigid rectangle surrounds the phone.

- **Retention:** cup sidewalls resist width/length motion; small case-rim returns resist lift. TPU supplies local conformity, while rigid geometry defines escape limits.
- **Compactness:** an open four-corner structure rather than a tray, but it necessarily extends toward the phone ends and has the largest span/part count of these ideas. Current 100 mm contact spacing cannot reach arbitrary corners without changing or extending the Y contact arrangement.
- **Print concept:** rigid arms flat with load paths primarily in-layer; TPU cup liners separately, open-side up or on end. Keep camera-corner relief and connector openings explicit.
- **Risk:** corner radius, camera bulge, case shape and phone length vary. An adjustment mechanism and locked fit are required; bending long thin arms is not a substitute. Far more development than A/B.
- **Visual:** four cyan L/corner liners at actual phone corners, orange narrow arms connected to the same two central X-interlocking jaws. Mark Y adjustment with a dashed arrow. Do not draw an unchanged 100 mm T with impossible corner contact.

## D — Floating equalizer: spread the load

Keep the two sliding-jaw contacts. Replace the single fixed contact with a short rigid rocker carrying two TPU pads. A captive, limited-angle printed pivot or captured TPU flexural bushing lets this bar rotate slightly about Z so both pads can seat despite taper or small alignment error. Back it with rigid travel limits; the bushing is not the only phone-retention member.

- **Retention:** four conforming contacts with load equalization rather than one rigid central opposition. Existing lips or short pad returns handle lift. Length restraint remains predominantly friction, and a rocking degree of freedom can worsen stability if unconstrained.
- **Compactness:** one small bar and captive joint on the fixed jaw; do not add a full four-bar linkage or redesign the existing sliding track. Example sketch spacing is illustrative, not committed geometry.
- **Print concept:** bar flat; broad bearing area; pads or a captured bushing printed separately. Keep joint supports out of running surfaces. A solid elastomer hinge needs a fatigue/creep test.
- **Risk:** more assembly and play than A/B, unknown load sharing, pad clearance near volume buttons. Useful if uneven contact is the measured problem, not the default solution to unknown escape.
- **Visual:** two existing sliding pads on one side; short pivoting bar with two pads on the other. Draw a central pivot symbol and a small curved arrow. The distinctive mechanism is load sharing, not a fifth soft pad.

## E — Corner keepers: independent escape restraint

Retain the existing jaws and optionally thin flat TPU liners. Add two separate narrow TPU Y-shaped keepers, each anchored behind a jaw with mechanically trapped buttonhole/tab roots and stretching to the two phone corners on that side. Each corner loop turns over only the outer case rim. The long branches run behind or outside the phone perimeter, not diagonally across the display or camera.

- **Retention:** the jaws set position; four tensioned corner loops oppose lift and longitudinal escape. It is an independent restraint topology, but not a certified safety tether. Broken/loose loops still require the jaws to carry the phone.
- **Compactness:** minimal new rigid material; soft branches reach corners. More fiddly installation than A, and extra straps are less visually clean.
- **Print concept:** flat TPU straps with generous anchor-root fillets and no supports. Broad, replaceable loops rather than tiny tension-loaded eyelets. Do not assume the selected TPU can stretch like a commercial elastomer tether.
- **Risk:** creep, tearing, snagging, abrasion and corner roll-off; anchors must be checked under tension. Avoid buttons, camera corners, charging port and screen. Separate TPU sizes may be needed rather than extreme stretch for every phone.
- **Visual:** four small corner loops with two branches per jaw, long legs shown dashed behind the phone. Include an exploded buttonhole/cleat anchor inset. No X-shaped strap across usable screen.

## Recommendation and next evidence

**A is the smallest diagnostic prototype; B is the most compact candidate for extra lift capture.** C offers the clearest positive length restraint but conflicts most with minimal size. D is appropriate only if contact imbalance is observed. E is a low-rigid-material backup layer and can combine with A, but should be evaluated as its own retention mechanism first.

Before promoting a concept, identify whether the phone moves along Y, lifts/rolls in Z, or forces the sliding jaw open in X. Keep band preload and phone/case constant when comparing. Test with a dummy of representative mass over a catch surface first; measure displacement and release force in all three directions, then repeat after dwell/cycles and with realistic damp/dusty contact. A positive escape stop can remain effective when friction drops; a soft pad alone cannot establish this.

**Pocket conflict remains:** the active 14 mm pocket does not fit the recorded 18 mm wallet and 20 mm large-phone proxies. Adding TPU worsens clearance unless rigid volume is recessed or the pocket is explicitly redesigned. These concepts cannot promise generic phone compatibility while preserving that conflict. A future concept must specify case-inclusive thickness and rim/corner geometry; retain the existing proxy sizes and failed checks until a user-approved geometry change.

No exact TPU hardness, force, thickness, coefficient of friction, filament brand or print profile is selected. A moderate-hardness TPU with compliant geometry may be easier to print than very soft filament, but choosing a grade and qualifying it on the actual printer is separate work. Use mechanical capture for replaceable inserts, allow inspection, and avoid compression so large that all compliance is consumed at assembly.

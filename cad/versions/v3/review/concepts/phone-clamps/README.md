# Five phone-retention concepts in 3D

**October 16 promotion:** the approved enlarged rounded cuff is now integrated into active V3 (`integrated-cuffs-v3`). The concept-only statements below describe the preceding exploration. See the V3 assembly and `review/cuff-integration.json` for current placement, service checks and unresolved retention/fit limits.

New exploration: [Rounded B cuff with A's adaptable seating](rounded-cuff/index.html). Three local curved TPU cuffs with shallow seating ribs; front/rear clearance views, end-for-end reversal, an assembled cross-section and an isolated-insert view. Remains a concept, not an active jaw replacement.

October 16 review: user rejects C and E for camera-obstruction risk. A and B remain promising; D is questioned because the phone must not pivot. D's limited-angle joint is intended to seat the pad bar, not provide an adjustable phone pivot, but additional play is a real tradeoff. No jaw concept has been promoted. The original illustrations remain as study evidence, not an indication that rejected concepts are active candidates.

Open `index.html` through the CAD server: `/versions/v3/review/concepts/phone-clamps/`.

- A: three keyed open V-saddles.
- B: three C-wrap TPU cuffs with local case-rim returns.
- C: four TPU-lined corner cups on longitudinally adjustable arms.
- D: a limited-angle, captive equalizer carrying two TPU pads.
- E: two independently anchored Y-keepers reaching four corners from behind the phone.

These are **procedural 3D illustrations, not manufacturing models or validated assemblies**. The common width interlock is schematic. Orange denotes rigid printed structure, cyan denotes proposed TPU, violet denotes schematic closing bands, gray denotes a neutral illustrative phone/case. Screens remain free of long straps. Phone/case dimensions and adjustment geometry shown here are illustrative; they do not replace, shrink or modify the active 18/20 mm test envelopes or resolve the 14 mm pocket conflict. Case-rim, button, camera, printability and loading checks remain required before adopting a design.

Each view can be orbited separately. The front/back and hide-phone controls expose the retained interlock and rear restraint paths. The detail views for A/B separate the insert and phone-edge section for legibility; E separates the anchor and corner-loop examples. Their exploded spacing is not an assembly gap. The asymmetrical E branch skirts the indicated camera region, but that is only one illustrative layout, not a qualified camera keepout for arbitrary phones.

`concepts.js` is the editable Three.js geometry source; `concepts.css` and `index.html` form the review. Three.js 0.180.0 modules are loaded from the same version-pinned CDN used by the existing CAD concept viewer. No extra package install is needed.

`concept-a-3d.png` through `concept-e-3d.png` are screenshots of the actual rendered scenes, not AI-generated images. Each contains the assembled view, an enlarged mechanism detail and explicit tradeoffs. Regenerate with:

```sh
PLAYWRIGHT_MODULE=/absolute/path/to/playwright CHROME_PATH=/absolute/path/to/chrome node cad/versions/v3/review/concepts/phone-clamps/render.cjs
```

The script defaults to `http://127.0.0.1:8767`; set `CAD_VIEWER_URL` for another server. It tests all five selection states, phone visibility, camera controls, runtime errors and narrow-screen overflow, then writes the five PNGs. See `research.md` for rationale, source links and unresolved material/retention issues. No active jaw geometry or print files were changed.

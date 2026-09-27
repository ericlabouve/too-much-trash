# Too Much Trash: project guide

## Purpose

Too Much Trash is a research and product project for teaching robots to recognize and eventually pick up litter. Its first step is a practical way to collect egocentric video of real pickup attempts. A person uses a stock reacher grabber fitted with a neck-mounted iPhone and holds a separate collection bucket in the other hand. A mechanical bicycle brake cable couples the grabber's squeeze trigger to a lever at the phone's volume button, marking each grasp while a rolling video buffer preserves the approach. Deposits, misses, drops, and rejections can then inform review and self-supervised labeling.

The aspiration is a useful, varied dataset and a humane path from field capture to segmentation, classification, and imitation-learning research. Treat the hardware and automatic labels as hypotheses until they are measured and validated. Preserve failed attempts and uncertain outcomes; they are part of the research signal.

## Repository map

| Path | Intent |
| --- | --- |
| `compose.yaml`, `.env.example` | Define the hosted stack and its local configuration shape. |
| `backend/api/` | uv-managed FastAPI service for client-facing endpoints and future capture metadata and media coordination. |
| `backend/caddy/` | Reverse proxy and browser UI serving layer. |
| `backend/postgres/` | Database initialization and future schema or migration support. |
| `backend/workflows/` | Prefect flows for ingestion, event alignment, frame extraction, proposed labels, and review processing. |
| `frontend/src/` | Shared browser and Electron interface; keep visual language consistent with iOS. |
| `frontend/electron/` | Secure desktop shell for the shared interface. |
| `ios/` | Dedicated SwiftUI iPhone experience, including eventual capture and review. |
| `ml/training/` | Reproducible image and video segmentation and classifier training code. |
| `ml/experiments/` | Research questions, run records, comparisons, and evaluations. |
| `cad/reference/` | Photos and measurements of the exact physical reacher model. |
| `cad/renders/` | Technical concept drawings used to communicate mechanical intent. |
| `cad/source/` | Editable CAD models and assemblies for the retrofit. |
| `cad/print/` | Reviewed printer-ready exports, including Bambu Studio 3MF files. |
| `docs/` | Development notes and cross-cutting design decisions. |

## Design intent

Use the photo in `cad/reference/reacher-grabber.png` as the specific grabber geometry. The iPhone belongs on the straight neck below the claw fork in a removable, GoPro-like harness. Its rear cameras face along the shaft toward the claw tips and remain uncovered. Keep the phone and mount outside the moving claw sweep. Route the bicycle brake cable externally, with a housing anchor near the handle and a removable tab on the moving black trigger. Avoid drilling the stock handle or depending on its screw holes. A compact cable-driven lever at the phone should press a side volume rocker.

For concept drawing pairs, positive y points up along the grabber shaft. In a views, positive x points right and positive z comes out of the page toward the viewer. In b views, the camera and axis key rotate 90 degrees about y: positive z points left and positive x comes out of the page. Keep each sheet to one view, with a small x/y/z axis glyph and a white background. These are concept illustrations, not proof of fit or working force transmission.

Use the reference grabber's square-cross-section silver neck, drawn as a rectangular prism with flat faces and sharp edges. Printed clamps must fit that square profile. The only blue stock parts are the shaft's center brace and the handle; color every added 3D-printed retrofit component orange. Keep the original metal silver and the stock claw feet and squeeze trigger black.

Each image in `cad/renders/` has an adjacent `.spec.json` file. Treat these sidecars as the record of user-provided positioning and component requirements when revising or replacing a drawing. Update the relevant sidecar whenever the user adds a constraint. In assembly and phone-mount a views, place the phone to the positive-x side and into negative z so its near thin long edge rests against the neck support while its short charging-port edge remains visible. Keep the earlier centered phone placement in 1b and 2b; the a-view translation was requested only for 1a and 2a. The b views turn 90° around the shaft and show the phone's long edge. In the rotated complete and handle views, the blue upper handle head is visible while the black squeeze trigger is occluded.

Keep the public README focused on the project's purpose and aspirations. Put setup instructions and implementation details in `docs/` or the relevant component directory.

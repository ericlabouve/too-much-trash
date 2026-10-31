# Dataset interoperability design plan

Status: proposed; researched October 7, 2026. No sensor-ingestion schema,
exporters, or migrations are implemented by this document. The current API
stores uploaded media and the worker creates previews.

## Format choices

Use established consumer formats rather than an exclusive training schema:

| Format | Proposed role | Scope |
| --- | --- | --- |
| 1. [LeRobot v3](https://huggingface.co/docs/lerobot/en/lerobot-dataset-v3) | Initial support: episodes | MP4, Parquet signals, episode/feature metadata. Start with aligned video and events as observations, not fabricated actions. Pin a supported version and validate with its loader. |
| 2. [COCO](https://cocodataset.org/#format-data) | Initial support: SAM3 masks | Per-frame image IDs, categories, boxes and lossless RLE instance masks. Preserve temporal identity separately; COCO images alone are not video tracks. |
| 3. [ASAM OpenLABEL](https://www.asam.net/standards/detail/openlabel/) | Rich temporal/multimodal annotations | Objects, events, streams, coordinate systems, frame-level labels. A formal standard, unlike the ecosystem-specific training formats above. |
| 4. [RLDS](https://github.com/google-research/rlds) | Consumer-requested research adapter | Episodes and steps; preserve first/last/terminal distinctions. TFDS-compatible delivery where required. |
| 5. [robomimic](https://robomimic.github.io/docs/datasets/overview.html) | Consumer-requested export | HDF5 demos, observations, and actions for that ecosystem. |

There is no universal robotics interchange format. Use adapters around a
lossless capture record; do not force all raw signals into a resampled training
table. Confirm the first downstream user's loader and feature requirements
before freezing the contract.

## Capture and provenance requirements

### UMI design reference

[UMI](https://umi-gripper.github.io/) is a research hardware/learning framework,
not a formal interchange standard. Its hardware guide and printing tutorials
are CAD references, not certified fits for our stock reacher. Study camera/tool
geometry, visible jaw-width measurement, rigidity, synchronization, and latency.
Preserve the approved removable iPhone harness, measured rectangular neck,
stock claw sweep, and cable trigger. Inspect CAD licenses and independently
validate fit before reusing parts; no CAD changes are authorized by this plan.

The original UMI pipeline is tested on Ubuntu 22.04 and assumes its GoPro-based
workflow. Our iPhone app is not a drop-in UMI recorder. Video and squeeze events
are observations; action-ready exports also require validated tool pose,
continuous jaw state, robot feasibility, and retargeting.

- Immutable originals and checksums; derivatives link to source IDs.
- Episode, session, collector pseudonym, device, firmware/app, and task IDs.
- Native-rate streams with monotonic timestamps, clock-domain identifiers,
  measured offsets/uncertainty, missing-sample indicators, and optional UTC.
- Camera intrinsics, resolution, distortion assumptions, camera-to-tool
  calibration, calibration version, tracking resets, and session-local frame.
- Explicit SI units, handedness, axis conventions, quaternion component order,
  transform direction, and validity/confidence flags.
- Separate measured observations, estimated tool pose, reviewed outcomes,
  inferred jaw state, and robot actions. Never call human pose a robot action.
- Versioned annotation vocabulary with unknown/uncertain outcomes; annotator,
  review history, quality checks, consent/license scope, and dataset release ID.
- Held-out split assignment at session/collector/location/object level.
  Preserve failures; exclusion reasons must be auditable.

## SAM3 mask and track storage

Segmentation is part of the initial processing plan, not implemented capture.
The [official SAM3 setup](https://github.com/facebookresearch/sam3) requires a
CUDA-compatible GPU; plan separate backend compute, not iPhone or M1 inference.

- Retain originals plus lossless binary masks as COCO RLE or PNG, not just
  colored overlays or lossy video. Validate encode/decode round trips with
  [pycocotools](https://github.com/cocodataset/cocoapi/blob/master/PythonAPI/pycocotools/mask.py).
- Link every mask to video/episode ID, source frame index, timestamp, image
  dimensions, category and video-scoped object/track ID. Do not infer identity
  across videos. Keep the temporal index alongside episode metadata.
- Record model/weights version, prompts, processing configuration, available
  scores, and review status. Model-generated masks remain proposed labels until
  reviewed; preserve corrections and uncertain/occluded frames.
- COCO is the first per-frame interchange target. Offer a
  [YouTube-VIS](https://youtube-vos.org/dataset/vis/) adapter if a consumer needs
  video-instance tracks. OpenLABEL is optional, not required just to save masks.

## Backend implementation trail

1. Agree a capture specification and schema version with a downstream user.
2. Add versioned sensor/event ingestion and explicit migrations; do not modify
   first-start SQL scripts as a migration substitute.
3. Keep Postgres as catalog and review state, blob storage as immutable media
   and stream payloads; retain native timing before producing synchronized views.
4. Add review provenance and export manifests. Support LeRobot episodes and
   COCO masks together initially; use OpenLABEL only for richer annotation.
   Add RLDS or HDF5 only when a consumer needs them.
5. Validate exports with official loaders, schema checks, timestamp alignment,
   and round-trip sample tests. Record excluded/retargeted episodes.
6. Keep observation-only captures distinct from action-ready demonstrations.
   Export inferred signals with uncertainty, never fabricated ground truth.

Implementation remains separate work requiring authorization. Public research
claims and vendor pricing are on the Project Timeline page, not API guarantees.

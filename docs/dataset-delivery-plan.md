# Dataset delivery plan — 2026-11-19

Recommendation from three independent agent reviews: preserve capture originals,
keep a consolidated labels table, and generate reproducible versioned exports.
This is a recommendation, not evidence of a buyer's procurement requirements.

## Current collection

The November 13 beach collection has 242 egocentric reacher-grabber episodes,
silent 960×720 video, native-rate IMU, estimated camera poses and button events.
Its consolidated outcome annotations contain 221 deposited and 21 not deposited:
16 human labels take precedence; 226 remain AI-only. These are bucket-deposit
outcomes, not verified object categories, segmentation masks or robot actions.

All capture manifests retain `complete: false` and clock alignment `unverified`.
Source-file integrity and successful upload do not establish temporal calibration.
Recorded raw intrinsics are at 1920×1440; encoded video is 960×720. Consumers must
apply recorded scale/offset geometry to intrinsics instead of using raw matrices
as encoded-image calibration. Preserve coordinate frames, units and conventions.

The audit found 85 overlapping adjacent episode intervals. Summed episode time
is about 30.94 minutes, not unique footage duration. Split by walk/session and
collector/location where known; randomly splitting neighboring clips risks shared
frames leaking across training and evaluation sets. One collection cannot establish
cross-session generalization. Rights/license, consent/privacy, coverage and a
measured quality policy must be settled before a commercial release.

## Storage layers

1. **Capture archive:** existing per-clip MP4/JSONL/manifest files, UUID index and
   checksums, plus original annotations and immutable run history.
2. **Authoritative working labels:** `labels.json` contains one row per clip,
   effective label, AI/human source, relative media paths and original evidence.
   It is regenerated from an explicitly selected prediction run and its reviews.
3. **Buyer releases:** versioned derivatives with schema, dataset card, checksums,
   grouping/splits, conversion configuration and clearly described limitations.
   Keep logs, failed runs, backend receipts and scratch executables in the internal
   archive rather than the default delivery package. Do not delete that history.

## Interoperability

Hugging Face JSON loading accepts `labels.json` with `field="items"`; this loads
annotation rows, not synchronized sensor tensors. VideoFolder supports relative
video paths through a `file_name` column in metadata.jsonl/CSV/Parquet, so source
folders need not move. Native sensor paths can be metadata; a consumer must still
parse and align those streams. A VideoFolder adapter is recommended, not yet built.

LeRobot v3 instead packs episodes into MP4 and Parquet shards with episode offsets,
features, FPS and statistics in metadata. Build a separate versioned converter
once observation semantics and alignment are validated. Never manufacture an
`action` column from phone motion to imply executable robot supervision. RLDS is
an optional buyer-requested episode/step adapter, not the only canonical format.

Current human labels can support supervised outcome or reward-model research.
They are not paired trajectory preferences and do not constitute a complete RLHF
pipeline. Robot imitation learning additionally needs usable action supervision
and embodiments/retargeting validated for the target robot.

## Primary sources

- [HF VideoFolder](https://huggingface.co/docs/datasets/en/video_dataset)
- [HF JSON loading](https://huggingface.co/docs/datasets/en/loading)
- [HF dataset cards](https://huggingface.co/docs/hub/datasets-cards)
- [LeRobot v3](https://huggingface.co/docs/lerobot/en/lerobot-dataset-v3)
- [LeRobot imitation learning](https://huggingface.co/docs/lerobot/en/il_robots)
- [RLDS specification](https://github.com/google-research/rlds)
- [Universal Manipulation Interface](https://umi-gripper.github.io/)
- [Human preference learning paper](https://arxiv.org/abs/1706.03741)

# Dataset and review storage contract

## Organized layout (version 2)

The beach collection's authorized reorganization keeps the dataset root focused
on its README and consolidated labels. Capture files move as complete episode
folders; their original bytes, UUIDs and clip numbering remain unchanged.

```text
<descriptive-collection-root>/
  README.md
  labels.json
  episodes/
    001/
      video.mp4
      imu.jsonl
      poses.jsonl
      manifest.json
    …
  metadata/
    dataset.json                  layout version and active_prediction_manifest
    clip-index.json               clip-to-capture-UUID and ordering map
  audit/
    runs/<run-id>/
      predictions.json            AI predictions, evidence, confidence, provenance
      original-manifest.json       byte-identical pre-migration manifest
      human-reviews.json          separate human decisions/corrected labels
      job.json                    recorded run settings, scope and status
      schema.json                 structured prediction contract
      prompts/                    exact prompts
      responses/                  original per-clip model JSON
      logs/                       agent/error logs
      contact-sheets/             timestamped frame overviews
      context/                    prior-agent evidence snapshots
      scratch/                    per-clip frames/helpers/temporary analysis
    verification/
      source-inventory.json       original sizes/SHA-256, keyed by capture UUID
      copy-verification.json      original external-drive copy verification
      backend-verification.json   historical upload snapshot
      migration-path-map.json     old-to-new path mapping
      migration-verification.json integrity/hash counts and human preservation
      migration-journal.json      rename/move journal
      migration-tool.py           preserved one-time migration script
      pre-migration-README.md      original dataset README
      pre-migration-labels.json    original consolidated labels
```

`metadata/dataset.json` identifies the layout version and the selected run via
`active_prediction_manifest`, a dataset-relative path. Its legacy path aliases
allow old manifest bookmarks to resolve after migration. Pass the dataset root to
the viewer rather than depending on a dated run's physical location.

A version 2 prediction manifest lives under `audit/runs/`, but each `media` path
is **relative to the dataset root** (for example,
`episodes/001/video.mp4`). The viewer resolves that root using its ancestor
`metadata/dataset.json`. Derived `labels.json` uses the same relative-path base
for source media and explicit nested paths for provenance. `human-reviews.json`
is adjacent to its own run's `predictions.json`.

Current beach, park and home episode directories are consecutive `001`, `002`,
etc., independently starting at 001 for each collection. `metadata/clip-index.json`
keeps the original stable `clip` IDs and UUIDs and adds `directory` for the numeric
folder. Review keys and historical agent artifacts retain their original IDs;
load recordings through label file paths or the clip index, not by assuming an ID
is its directory name. The viewer and fresh-agent selection resolve this mapping.
Prior metadata and renumbering receipts live under
`audit/verification/episode-numbering/`. This supersedes keeping gaps in physical
folder names; original IDs still retain their historical gaps.

Historical prompts, responses, logs and scratch configurations preserve their
original bytes. Embedded old absolute paths document the historical invocation;
they do not become new runnable commands simply because their files were moved.
Use `migration-path-map.json` to interpret those paths. Each run's
`original-manifest.json` preserves its pre-migration AI manifest byte-for-byte.
`migration-verification.json` records byte/hash counts and human-label preservation;
`migration-journal.json` records renames. The original README and labels are retained
under `audit/verification/pre-migration-README.md` and `pre-migration-labels.json`.
`migration-tool.py` is the preserved one-time script, not a request to rerun it. New runs must create
current input paths, helper configurations and scratch locations. Prediction
manifest media references, selected-run pointers and derived labels must be
rebased explicitly during migration. Checksum-verify original recordings and
verify human reviews semantically and byte-for-byte where only moved.

Some aborted/historical runs lack particular artifact types. Empty review logs
mean no human decisions were saved for that run. Preserve earlier model outputs
and decisions; never reconstruct a missing review from an AI label. Keep audit
history internal when producing a consumer export; it need not ship with every
training package.

## Legacy flat layout (version 1)

The original mixed park/home collection used this earlier pattern, inspected on
2026-11-15. On November 20 Eric requested its explicit migration to version 2:
`/Volumes/ERICS_DRIVE/park` retains 57 clips and `/Volumes/ERICS_DRIVE/home`
contains original clips 006–010. Beach is now `/Volumes/ERICS_DRIVE/beach`.
Dates and 960×720 resolution belong in each README, not root names. Home's date
requires owner confirmation. Legacy layout support remains for other collections.

```text
<legacy-collection-root>/
  README.md
  clip-001/{video.mp4,imu.jsonl,poses.jsonl,manifest.json}
  clip-index.json
  verified-inventory.json
  backend-verification.json
  copy-verification.json
  label-review.json
  label-review.decisions.json
  review.csv
  review-provisional.csv
  .review/runs/<run-id>/
  label-review.agent-<run-id>.json
  label-review.agent-<run-id>.decisions.json
```

Legacy manifest `media` paths remain relative to the manifest directory.
The original mixed collection had 62 clips with gaps starting at clip-006; do not renumber them. Its original
human decisions are in `deposit-prediction-validation.json`; the viewer resumes
that file when the standard log is absent. Its `review.csv` may supply historical
confidence. Blank confidence means unknown, never high. Do not discard that log
or silently reconstruct it from corrected labels.

Migrated park/home retain byte-identical mixed-collection originals under
`audit/verification/pre-split/`, with collection-specific active manifests,
human review logs and CSV subsets. Original UUIDs are indexed in metadata.
`metadata/dataset.json` identifies the historical manifest/CSV pairing so original
confidence enrichment applies to that run only. Three legacy park denials lack
explicit corrected labels and remain unresolved; preserve the original CSV outcomes
without silently changing canonical labels. Historical runs have no prompts/logs
unless those artifacts actually existed. Root renames preserve the earlier audit
path-map contents; a root-renaming receipt supplies the old-to-new root mapping.

The beach collection has clip-001 through clip-242 in ascending capture-button
press time. Folder names do not prove successful trash recovery. Keep original
capture UUIDs and the clip-index mapping when changing physical paths.
AppleDouble `._*` files are macOS metadata, not examples. Verify mounted paths;
do not assume the external drive is available.

## Common review fields

Each review item has stable `id`, relative `media`, original `prediction`, optional
display `label`, playback start/timing and evidence `note`. Confidence is `high`,
`medium`, `low`, or null when unavailable. `labels.json` consolidates these records
with separate human decisions; it is not a replacement for immutable AI history.

## Prediction task

Judge **deposit into the collection bucket, directly observed or strongly inferred**:

- `confirmed`: the picked-up item is visibly deposited, or context supports a high-confidence inference (for example, occluded release inside the bucket followed by an open, empty grabber withdrawing).
- `not_deposited`: evidence of a failed deposit, a drop outside, or no deposit.
- `uncertain`: the outcome cannot be established from the supplied evidence.

The ML product convention maps observed deposit to trash; capture relevance
(off-policy footage) is a separate question. Button release, disappearance from view, or intent alone does not establish
high-confidence deposit; strong contextual inference across the sequence is allowed. The park review found errors among
low-confidence predictions forced to binary outcomes; retain uncertainty.

New agents return prediction, categorical confidence, timestamped evidence and
limitations. Confidence is a subjective model assessment, not calibrated accuracy.
The initial overview samples roughly two frames/second, capped at 64, with timestamps. Workers may use tools to inspect the original video, extract additional frames and inspect available IMU/poses/manifest data. Each worker has its own writable scratch directory; original dataset files remain outside that workspace. Record the exact prompt and disclose which inputs were actually inspected. It does not perform segmentation automatically. A failed agent is not a negative prediction.

Run files preserve model output and source evidence. Human decisions are never
made automatically. Need human review includes unreviewed medium, low, uncertain and unknown-confidence
items; uncertain outcomes qualify even at high confidence. Other items remain
accessible through All samples. Approval
means agreement with the original prediction. Denial alone does not resolve a
three-way classification; corrected labels need separate adjudication. Preserve
original predictions and reviews across reruns.

Raw media, labels, local history, prompts containing private evidence and logs
stay outside Git. Parallel count limits simultaneous fresh, ephemeral per-clip agent processes;
conversations and scratch directories are never reused between samples. Run
metadata stores model, thinking level and selected clip IDs. Default eligibility
is missing predictions or medium/low/unknown confidence, always excluding human
approvals/denials across historical decision logs. Excluded items and prior
provenance remain in the new review manifest.

Repeat-review evidence is preserved in `<clip>.history.json` inside each run and
provided in that clip's prompt. It includes earlier predictions, confidence,
evidence, limitations and available originating run/model metadata. Deduplicate
carried-forward predictions; preserve disagreements and original outputs.

Human correction records may include `corrected_label` (`confirmed`,
`not_deposited`) alongside the original `prediction` and
`decision`. Explicit matching labels are approvals; different labels are denials.
Keep original manifests and model evidence immutable. For adjudicated labels, use
`corrected_label` when present; otherwise an approval means the original prediction
and a denial remains unresolved. Do not infer the opposite class from denial.

New human labels are binary: confirmed or not_deposited. Uncertain remains an
agent prediction class and historical human choices are not deleted. Video review
starts one second before the capture-manifest press relative to capture start;
release is not used as the squeeze start.

The canonical working `labels.json` is a versioned-schema JSON envelope with an
`items` array. Every item includes an effective label, AI/human source, UUID,
relative file paths and original AI/human provenance. Human labels take precedence
across known review logs. The selected log wins; conflicting historical labels
without a selected decision are blocked for explicit resolution. A null or
uncertain effective label counts as unresolved. Retain the source logs and use
reproducible versioned export adapters rather than rewriting original capture contents.

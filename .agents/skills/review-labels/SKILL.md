---
name: review-labels
description: Start the Too Much Trash local label review SPA for human validation of image or video predictions, resume a saved review, or tally approvals and denials.
---

# Review training labels

- Follow the [label review contract](../../../ml/label_review/README.md): organized collections use `audit/runs/<run-id>/predictions.json` and adjacent `human-reviews.json`; legacy collections keep their flat manifest/log names. Preserve original predictions and stable sample IDs. Set playback near the capture event when timing is available and identify the actual batch provenance.
- Run `python3 ml/label_review/serve.py /path/to/dataset` from the repository root. Organized roots resume `metadata/dataset.json`'s selected run; v2 media paths are dataset-root-relative. Verify item count and media access, then share the local URL. Reuse the original decision log to resume the same batch.
- Approve and Deny measure agreement with the displayed prediction. Use the saved log to report reviewed and total counts, approvals, denials, and approvals divided by reviewed predictions. Keep the original manifest alongside the decisions.
- When asked to apply reviews, join by stable ID and verify the saved prediction matches the original. Use explicit corrected labels; a historical denial without one remains unresolved. Keep human corrections separate from the original predictions.

The dashboard's Deposited / Not deposited buttons record an explicit `corrected_label` alongside the original prediction and agreement decision. Use them for every predicted clip regardless of confidence. A historical denial without that field remains unresolved; an approval without it retains the original label. Preserve the original manifest and never enter human labels on the user's behalf. Default to Need human review while its queue is nonempty, then switch to All samples.

For dataset switching, raw collections, agent runs and confidence filtering, read [the dataset format](../../../ml/label_review/dataset-format.md) and use the dedicated [Data Reviewer skill](../data-reviewer/SKILL.md). The dashboard accepts either a dataset root or review manifest; preserve the park dataset’s legacy decision log.

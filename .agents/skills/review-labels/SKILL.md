---
name: review-labels
description: Start the Too Much Trash local label review SPA for human validation of image or video predictions, resume a saved review, or tally approvals and denials.
---

# Review training labels

- Prepare a JSON manifest beside the dataset using the [label review contract](../../../ml/label_review/README.md). Preserve the original prediction and use stable sample IDs. Set a playback start near each video event when timing is available. Give the batch a source name that matches its actual provenance.
- Run `python3 ml/label_review/serve.py /path/to/dataset/label-review.json` from the repository root. Verify the item count and media access, then share the local URL. Reuse the original decision log to resume the same batch.
- Approve and Deny measure agreement with the displayed prediction. Use the saved log to report reviewed and total counts, approvals, denials, and approvals divided by reviewed predictions. Keep the original manifest alongside the decisions.
- When asked to apply the reviews, join by stable ID and verify the saved prediction matches the original. Flip a denial only when the task has two exhaustive classes. Obtain the corrected label separately for other denials. Keep corrected labels separate from the original predictions.

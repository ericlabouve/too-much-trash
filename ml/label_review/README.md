# Training label review

Run the local viewer from the repository root with Python 3.10 or newer.

```sh
python3 ml/label_review/serve.py /path/to/dataset/label-review.json
```

Open http://127.0.0.1:8788/. Use the arrows to browse and Approve or Deny to record agreement with the displayed prediction and advance to the next unreviewed item. Refreshing resumes the review. The viewer shows counts, the approve/deny ratio, and agreement among reviewed predictions.

Put the manifest beside the dataset. Each item needs a stable ID, a media path relative to the manifest, and an original prediction. Use browser-playable media such as JPEG, PNG, or H.264 MP4. Set `start_seconds` to start a video near the event under review. The title, source, display label, timing caption, and evidence note are optional.

```json
{
  "title": "Pickup outcome review",
  "source": "Candidate A · run 12",
  "items": [
    {
      "id": "clip-025",
      "media": "clip-025/video.mp4",
      "prediction": "confirmed",
      "label": "DEPOSITED",
      "start_seconds": 3.55,
      "timing": "Release at 4.55 s",
      "note": "The item crosses the bucket rim."
    }
  ]
}
```

Decisions are saved to `label-review.decisions.json` alongside the manifest. Use `--decisions PATH` to resume from another log and `--port PORT` for a different local port. Run one viewer per decision log and use a fresh log for a new set of predictions. The viewer preserves the manifest. Each decision records the prediction shown and the latest approve or deny for that item. Apply decisions to training labels separately. In a multiclass task, a denial leaves the corrected class to be adjudicated.

Keep private media, manifests, and decision logs in ignored dataset storage.

# Training label review

Run the local viewer from the repository root with Python 3.10 or newer.
Build the locally served Tailwind CSS / daisyUI theme once (Node.js required):

```sh
npm --prefix ml/label_review ci
npm --prefix ml/label_review run build
```

Dependencies are locked. Generated `dist/` styles and `node_modules/` are ignored;
no CDN scripts or styles are loaded while reviewing private footage.

```sh
python3 ml/label_review/serve.py /path/to/dataset
```

Open http://127.0.0.1:8788/. Use the arrows to browse. Every predicted video
shows Replay, Deposited and Not deposited, regardless of confidence or prior human
review. Choose an outcome to save an explicit human label and advance. Refreshing
resumes the review. The viewer retains the AI prediction and evidence separately.

The organized layout keeps recordings in `episodes/`, the selected run pointer
in `metadata/dataset.json`, and review history in `audit/runs/`. Pass the dataset
root to resume its selected run. In a version 2 `predictions.json`, media paths
are relative to the dataset root, for example `episodes/025/video.mp4`.
The root is resolved through its ancestor `metadata/dataset.json`.

The older flat layout remains supported: put `label-review.json` beside the
recordings, with media paths relative to the manifest directory. The following
example illustrates that legacy manifest format. Each item needs a stable ID,
a media path and an original prediction. Use browser-playable media such as JPEG, PNG, or H.264 MP4. Set `start_seconds` to start a video near the event under review. The title, source, display label, timing caption, and evidence note are optional.

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

Version 2 decisions are saved to `audit/runs/<run-id>/human-reviews.json`, next
to `predictions.json`. Legacy decisions are saved to
`label-review.decisions.json` alongside their manifest. Use `--decisions PATH` to resume from another log and `--port PORT` for a different local port. Run one viewer per decision log and use a fresh log for a new set of predictions. The viewer preserves the manifest. Each decision records the prediction shown and the latest approve or deny for that item. The derived labels table applies explicit human outcomes while retaining AI history. In a multiclass task, an old denial without an explicit correction leaves the
corrected class unresolved. The outcome buttons store `corrected_label` separately
from the immutable original `prediction`, with `decision` derived as approve when
they match and deny when they differ. Every review requires an explicit binary outcome button. Uncertain remains available to agents, but cannot be submitted as a new human label. Historical records are preserved.
Ordinary review never rewrites capture files, original prediction values or model evidence. An authorized layout migration may rebase file references without changing those contents. Corrections
count as human evaluations and exclude the sample from subsequent agent runs.
Approvals in historical logs imply the original label; historical denials without
`corrected_label` must not be treated as any particular corrected class.

```json
{"clip-003": {"prediction": "uncertain", "decision": "deny", "corrected_label": "confirmed"}}
```

Keep private media, manifests, and decision logs in ignored dataset storage.

## Dataset dashboard and agents

Pass a dataset root (including raw collections without predictions) or an existing
review manifest. The dashboard displays the full root path, remembers previously
loaded roots, discovers dataset folders on mounted volumes, and offers an explicit
folder browser. Recent selections persist in
`~/.local/state/too-much-trash-review/datasets.json`; `--state PATH` overrides it.

**Run Predictions**, immediately to the right of the Show filter, opens a dialog with a short task description, 1–10 parallel
agents, model selection, thinking level, sample scope and progress. Scope defaults
to all eligible samples; an optional positive maximum limits the run to the first
N eligible clips in clip order. The server applies eligibility before the cap,
and the run records the requested limit and exact selected clip IDs. Model choices and supported
thinking levels come from the local Codex image-capable model catalog; defaults
come from the user's configured model/effort. Explicit choices are validated and
passed to the CLI, then stored with each run. Close the dialog by clicking outside,
using its close button, or pressing Escape; inference continues and the dashboard
keeps showing the same progress bar. The viewer process must stay running.

A yellow badge above the dataset selector identifies the loaded root as a
Working copy, Read-only reference, or ERICS_DRIVE · Golden copy. Other writable
locations show Local dataset. Read-only detection checks filesystem mount flags
and write access, rather than trusting a folder name. The header displays explicit
Human reviewed and AI reviewed counts across the full dataset on its first line,
and deposited/not deposited totals on a separate line. Human reviewed means a saved human decision, including historical
reviews; AI reviewed means a saved prediction, including uncertain predictions and
legacy prelabels. These groups overlap. Label totals use explicit human corrections
first, an approved original label second, and AI predictions for unreviewed clips.
An unresolved denial never flips a class; unresolved/uncertain labels are counted
separately when present. Filtering does not change these dataset-wide totals.
Run identifiers and shown counts are omitted. Show is left-aligned and Run
Predictions right-aligned on the same horizontal row.

By default a run selects clips with missing predictions or medium/low/unknown
confidence. High-confidence predictions are retained. Any saved human approval
or denial excludes a sample, including decisions from earlier runs and park's
legacy log. The server rechecks eligibility at start. A run preserves excluded
items, prior provenance and the active decision log. A denied three-way prediction
is still human-reviewed; it is not silently changed into a corrected label.

Each selected clip starts a **fresh ephemeral `codex exec` process**, with a unique
scratch directory and no reused conversation. Parallel agents means the maximum
simultaneous per-clip processes, not multiple votes per clip. The Mac uses
Swift/AVFoundation to make timestamped contact sheets, then attaches them with
structured output. This uses the signed-in Codex account; source frames and any
further evidence the agent inspects are sent through that service.
Workers can inspect original video and available sensors using tools in their
isolated writable scratch workspace. Original files remain outside it. Exact
prompts, outputs, model/effort settings and selected IDs are retained per run.
Repeat reviews receive prior agents' predictions, confidence, evidence, limitations
and available model/run provenance for the same clip. Raw run outputs and historical
review manifests are joined, with carried-forward predictions deduplicated by
originating run (or identical legacy content). The exact context is saved under `context/` as
`<clip>.history.json` in version 2 runs (flat inside legacy runs) and included in the per-clip prompt. Earlier interpretations
are leads to verify against source footage, not human ground truth or independent
votes. No previous conversation is resumed.
Capacity errors stop the batch with an actionable message; the runner never silently
switches models. Cancellation stops active agents and skips queued clips without
counting a terminated agent as a failed prediction. Error causes are visible in
the dashboard as well as per-clip logs. Completed results remain saved;
failed/cancelled clips retain any earlier prediction. A rerun creates a separate
run. Restarting the server does not resume inference automatically.

The dashboard polls progress. Show offers All samples, Need human review,
AI Reviewed, and Human Reviewed. Need human review excludes all saved human
reviews and includes missing predictions, uncertain predictions at any confidence,
and medium/low/unknown-confidence predictions. AI Reviewed means an AI prediction
exists (including uncertain results); Human Reviewed includes historical saved
approvals/denials. A newly saved human label leaves Need human review immediately. The viewer defaults to that queue on opening or switching datasets and automatically falls back to All samples when the queue is empty. Explicitly selected filters remain selected on ordinary refresh.
New runs switch the active review manifest for that dataset and save
manual decisions separately. See [dataset-format.md](dataset-format.md) for the
park-derived storage contract, prediction meanings and confidence limitations.

Validation: `python3 -m unittest discover -s ml/label_review -p 'test_*.py'`
and `npm --prefix ml/label_review run test:ui`. Tests use synthetic fixtures and
mocked agents; they do not send private datasets for inference.

Frame inspection uses a supplied per-clip `inspect_frames.py` helper and fixed-input
configuration when a working FFmpeg binary is available. No installation occurs.
Workers receive the exact Python command and request up to 12 video timestamps;
JPEGs plus requested/actual decoded PTS are written only into their scratch folder.
Each call has a 60-second total budget and 20-second per-frame timeout. The prompt
forbids decoder searches, package installs and the previously failing agent-written
Swift/AVFoundation approach. If the helper fails or is unavailable, workers use the
overview, disclose the limitation and retain uncertainty when evidence is inadequate.
The earlier clip-002 decode failure was reproduced in its log; the supplied FFmpeg
helper successfully decoded five timestamps from that clip locally on 2026-11-18.
No extra Codex prediction was sent for that decoder test.

Review video playback and Replay start one second before the squeeze **press**,
using `(capture timing.press - timing.start) - 1`, clamped at video start. The
viewer derives this from each clip's capture manifest without changing source
files or prediction manifests. Capture timing is cached with file-change
invalidation. When press timing is missing or invalid, retain the manifest's
existing review start rather than inventing a squeeze time.

## Consolidated labels

`labels.json` is an automatically regenerated dataset-level table (`items` rows),
with effective `label` and `label_source` (`ai` / `human`), UUID, relative file
paths, original AI evidence/provenance and a separate human review. Explicit human
corrections win; legacy approvals retain their original label; denials without
corrections remain unresolved. The selected decision log takes precedence, while
nonconflicting historical human reviews are retained if absent from that log.
Conflicting historical reviews require selecting an authoritative log, never
mtime-based guessing. Original media, predictions and decisions stay unchanged.
The viewer refreshes this derivative on loading and saving reviews. Reopening a
dataset root resumes its selected prediction manifest; the version 2 pointer is
`metadata/dataset.json` → `active_prediction_manifest`. Source paths in
`labels.json` include `episodes/`, and review/provenance paths identify the nested
run instead of relying on a basename that could match multiple runs.

The beach reorganization puts the UUID index in `metadata/clip-index.json` and
integrity receipts under `audit/verification/`. Its `audit/verification/migration-path-map.json` preserves old-to-new locations.
`migration-verification.json` records byte/hash counts and human-label preservation;
`migration-journal.json` records moves. The one-time `migration-tool.py` and original
`pre-migration-README.md` / `pre-migration-labels.json` are preserved in that same
verification directory. Each run keeps a byte-identical `original-manifest.json`
from before its live media references were rebased. Exact historical prompts, logs and scratch configurations
retain their old path strings for audit fidelity; they are not live replay
instructions. New runs use current paths. See [dataset-format.md](dataset-format.md)
for the versioned layouts and complete artifact roles.

See [the delivery plan](../../docs/dataset-delivery-plan.md) for buyer-facing
Hugging Face/LeRobot exports and the current collection's limitations.

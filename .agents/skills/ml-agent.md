# Too Much Trash: ML working memory

Last updated: 2026-11-06. Read before project ML work; verify current code/runtime when needed.

## Maintain this memory

Update freely and frequently when user preferences, architectural decisions, measurements, failures or blockers materially change the work. Ordinary in-scope memory edits need no separate approval. Replace superseded state, date evidence, retain consequential failures, and link detailed records rather than copying logs. Distinguish tested capabilities from proposals. Mention material changes briefly in task handoffs; avoid churn without new durable information. Never store credentials, frames, weights or raw masks here. Memory updates do not authorize unrelated implementation or automatic commits/pushes.

## Preferences and semantics

- Use pretrained models; training our own model is out of scope for now.
- Prefer native Apple MPS. CPU decode/encode/evaluation is fine; do not silently benchmark CPU model inference as MPS. Docker Desktop Linux containers cannot gain Mac MPS through mounted files. Native host inference is acceptable, with container clients using `host.docker.internal`.
- Segment the item picked up by the reacher claw without requiring its category name. `cylinder of yarn` was only a benchmark aid.
- Observed bin deposit means `trash`; no separate `deposited_in_bin` product class. The complete negative example is `not trash` because the item was not deposited. Retain ambiguous evidence, misses, drops and failed attempts for review.
- Off-policy means the clip contains no relevant pickup footage (for example, an accidental recording), not that a relevant pickup ended outside the bin. Keep capture relevance separate from pickup outcome and uncertainty.
- Planned capture context: two seconds before grasp, held interval, two seconds after release. Event detection is not implemented.
- Optimize visual quality and actual end-to-end FPS together. Single-video exploration is acceptable now; generalization can wait, but must not be claimed from this clip. Keep explanations concise and distinguish working features from proposals.

## Architecture and current state

- Cutie is the selected tracker, visually approved on 2026-10-09. Working runner: original video + one supplied reviewed SAM 3 mask at frame 90 -> independent forward/reverse memory passes -> every-frame masks, pixel boxes, JSON RLE and overlay MP4 -> human review.
- Cutie predicts new masks using object memory on every tracked frame; this is not frame skipping or optical-flow mask warping. Validated: official `cutie-base-mega`, strict weights, unmodified upstream source, float32 MPS, shortest side 480 px, five-frame memory updates, no long-term memory or flip augmentation.
- SAM 3 inference works via Transformers/PyTorch. The Cutie CLI supports fresh one-second SAM 3 anchors via `--sam-prompt`; the original reviewed-seed mode remains a control. Default `forward-after-first` backfills only before the first usable anchor and then tracks forward from each usable anchor. `--anchor-policy bidirectional` keeps the nearer anchor's prediction as a comparison. Empty/ambiguous SAM samples do not seed tracking. The CLI is not wired into Gradio.
- Automatic held-frame/object selection and the SAM 3 Agent are not implemented. Agent inspection of held frames, SAM 3 prompting and mask review is a proposal. Do not assume SAM 3's text prompt directly understands the temporal action “item picked up by the claw.”
- Gradio's Video tab still performs independent text-prompted SAM 3 sampling and holds preview snapshots; it does not expose Cutie. Automatic `trash` / `not trash` classification is also unimplemented.
- SAM 3.1 migration is blocked by the published CUDA/Triton runtime assumptions; validated Mac inference remains SAM 3. SAM 2.1 is a separate alternative. No validated vLLM, Ollama, quantization or compilation optimization is in use.

## Ground truth and evaluation

- The user approved the dense SAM 3 tracker video's exact masks as ground truth for the positive yarn clip only. Reference: `ml/data/sam3-tracker-benchmark/2026-10-09/full-positive/`, containing `results.json`, `segmented.mp4`, and `NNNN_prediction.npz`. Open this video when asked for “ground truth segmented.mp4,” not another identically named preview.
- Source files: local `positive-trash-example.mov` and `negative-trash-example.mov` in the preserved source checkout; verify access/paths when needed, never commit them. Positive clip: 249 frames, 30 FPS, 8.3 s, upright 1920 x 1080, -180-degree rotation metadata. Seed frame 90 is at 3 s. References: 195 visible masks, 54 empty masks (0–18 and 214–248).
- Feed original unpainted frames to models. Use the frozen reference seed only in the supplied-seed control. Fresh-anchor runs read reference masks for offline scoring only, never runtime refresh triggers or candidate selection. Do not derive ground truth from colored overlay pixels.
- Report visible mean/p10 Dice, fraction below 0.80, and false positives on empty-reference frames. Both-empty frames must not inflate visible Dice. Exploratory mean-Dice target: at least 0.90; visual review and boundary failures still matter.
- Separate synchronized model timing from actual end-to-end time; disclose seed, decode/transfer, scoring/export and cold-load treatment. Cached/accounted replay FPS is not observed wall throughput; supplied-seed FPS is not full automated-pipeline throughput.
- Preserve failures, empty predictions and uncertainty outside Git. Validate frame coverage, exact RLE/NumPy agreement, original-pixel coordinates and preview orientation/count. Benchmark boxes have exclusive right/bottom maxima.

## Evidence: 2026-10-09, positive clip only

Apple M1 Pro, 16 GB unified memory, native MPS float32; Python 3.14.8, PyTorch 2.14.1, Transformers 5.18.0. Single runs, not repeated confidence intervals or current environment guarantees.

| Method | Mean visible Dice | p10 Dice | FPS and scope |
| --- | ---: | ---: | --- |
| Dense SAM 3 tracker | Reference | Reference | 0.290 model-only |
| Best tested OF + frequent SAM refreshes | 0.805 | 0.507 | 1.36 standalone |
| SAM 2.1 Tiny, one seed | 0.978 | 0.971 | 0.876 end-to-end; 284.12 s |
| Cutie, one seed | 0.964 | 0.955 | 4.07 end-to-end; 61.18 s |

- Tiny and Cutie each had zero false positives on 54 empty-reference frames, CPU inference fallback explicitly disabled. Small was not needed/run because Tiny met the quality target.
- Cutie inference plus image transfer: 7.77 FPS, not end-to-end FPS. Two visible frames below Dice 0.80: first appearance at frame 19 (0.700), final visibility at frame 213 (604 reference pixels, predicted empty). Preserve this one-frame-early disappearance as a miss.
- None of 25 OF configurations was acceptable. Forward/backward consistency is computed round-trip error, not RAFT's built-in confidence or proof of identity; it missed cumulative drift. Retain fractional masks between warps: repeated thresholding loses subpixel motion. The aborted hard-threshold run is not evidence of success.
- Dense SAM 3 tracking was slower than independent SAM 3 on eight matching frames; do not repeat unsupported tracker-speedup claims.
- Artifacts: `ml/data/cutie-benchmark/2026-10-09/full/`, `ml/data/sam2-benchmark/2026-10-09/tiny-full/`, `ml/data/sam3-flow/2026-10-09/`. Consult component docs for checkpoint revisions and timing caveats.

## Operational pointers and next work

Read `ml/experiments/sam3/README.md` for setup, benchmark commands and detailed evidence. Runners are in `sam3_lab/benchmark_cutie.py`, `benchmark_sam2.py`, `benchmark_tracker.py`, `benchmark_compare.py`, `flow_experiment.py`; viewer sampling/export is in `video.py` and `viewer.py`. Use the component uv environment or `.venv/bin/python`, fresh output directories, and sequential GPU runs when timing. Cutie source/weights/isolated dependencies are under ignored `ml/data/cutie/`.

HF authentication and SAM 3 access were previously established; verify relevant operations without exposing credentials. Servers/tabs are transient: check before claiming availability. Keep videos, frames, weights and local environment files out of Git. `ml-agent` was pushed at `c874bf6`; inspect current Git state. This memory does not authorize merge/rebase or future commits/pushes.

One-second baseline, 2026-11-06: six usable anchors from nine fresh SAM 3 calls on the positive clip, using the known yarn prompt (no Agent). All 249 frames exported; mean visible Dice 0.9657, p10 0.9549, 0/54 empty-frame false positives, 89.26 seconds processing (2.79 FPS), 100.25 seconds including startup. The last visible frame was still missed. Artifacts: `ml/data/cutie-benchmark/2026-11-06/sam3-1s-positive/`. This is not a controlled comparison to the earlier supplied-seed run.

Forward-after-first comparison, same clip and pixel-identical SAM 3 outputs: 243 Cutie predictions instead of 388, 68.68 seconds processing (3.63 FPS; 23% less time) and 77.18 seconds including startup. Measured: SAM 3 24.51 s, Cutie forward 20.86 s, backward 2.96 s, seeds 0.70 s. Mean visible Dice 0.9636, p10 0.9534, same two visible frames below 0.80 and 0/54 empty-frame false positives. Largest frame-level drop: frame 58, 0.969 to 0.915. Artifacts: `ml/data/cutie-benchmark/2026-11-06/sam3-1s-forward-positive/`. This speed/quality tradeoff is measured on one clip, not a generalization claim.

Next: verify subscription-backed authentication with image input, then evaluate Agent review of SAM 3 anchors without an object name. Integrate the workflow into Gradio, followed by capture relevance, grasp/release timestamps and deposit-based labeling with uncertainty review. Defer further anchor-schedule optimization until more reviewed clips are available. No custom training.

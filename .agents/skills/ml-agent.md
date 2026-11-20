# Too Much Trash: ML working memory

Last updated: 2026-11-08. Read before project ML work; verify current code/runtime when needed.

## Maintain this memory

Update freely and frequently when user preferences, architectural decisions, measurements, failures or blockers materially change the work. Ordinary in-scope memory edits need no separate approval. Replace superseded state, date evidence, retain consequential failures, and link detailed records rather than copying logs. Distinguish tested capabilities from proposals. Mention material changes briefly in task handoffs; avoid churn without new durable information. Never store credentials, frames, weights or raw masks here. Memory updates do not authorize unrelated implementation or automatic commits/pushes.

## Preferences and semantics

- Use pretrained models for the segmentation pipeline. Evolution candidates may train their own policies, SVMs, or other models on the designated fitting data. They may propose new implementations, spend more compute for accuracy, and use any available runtime sensor signals, including video, IMU, and ARKit. Measure laptop p95 under the common protocol.
- Prefer native Apple MPS. CPU decode/encode/evaluation is fine; do not silently benchmark CPU model inference as MPS. Docker Desktop Linux containers cannot gain Mac MPS through mounted files. Native host inference is acceptable, with container clients using `host.docker.internal`.
- Future policy training video is 960 × 720, square pixels, 4:3. Downscale 1920 × 1440 by half on both axes. Preserve full framing, frame order and capture timing. Keep originals and sidecars and flag incompatible display aspect ratios for review.
- Policy targets include squeeze, unsqueeze, and whether the item enters the waste bucket. Review the release through the visible outcome. Record failed pickup and missed deposit separately and retain uncertain or occluded outcomes for review. A visible bucket alone is insufficient evidence of deposit.
- Segment the item picked up by the reacher claw without requiring its category name. `cylinder of yarn` was only a benchmark aid.
- Observed bin deposit means `trash`; no separate `deposited_in_bin` product class. The complete negative example is `not trash` because the item was not deposited. Retain ambiguous evidence, misses, drops and failed attempts for review.
- Off-policy means the clip contains no relevant pickup footage (for example, an accidental recording), not that a relevant pickup ended outside the bin. Keep capture relevance separate from pickup outcome and uncertainty.
- Planned capture context: two seconds before grasp, held interval, two seconds after release. Event detection is not implemented.
- Optimize visual quality and actual end-to-end FPS together. Single-video exploration is acceptable now; generalization can wait, but must not be claimed from this clip. Keep explanations concise and distinguish working features from proposals.

## Architecture and current state

- Cutie is the selected tracker, visually approved on 2026-10-09. Working runner: original video + one supplied reviewed SAM 3 mask at frame 90 -> independent forward/reverse memory passes -> every-frame masks, pixel boxes, JSON RLE and overlay MP4 -> human review.
- Cutie predicts new masks using object memory on every tracked frame; this is not frame skipping or optical-flow mask warping. Validated: official `cutie-base-mega`, strict weights, unmodified upstream source, float32 MPS, shortest side 480 px, five-frame memory updates, no long-term memory or flip augmentation.
- SAM 3 inference works via Transformers/PyTorch. The Cutie CLI supports fresh one-second SAM 3 anchors via `--sam-prompt`; the original reviewed-seed mode remains a control. Default `forward-after-first` backfills only before the first usable anchor and then tracks forward from each usable anchor. `--anchor-policy bidirectional` keeps the nearer anchor's prediction as a comparison. Empty/ambiguous SAM samples do not seed tracking.
- Automatic held-frame/object selection and the SAM 3 Agent are not implemented. Agent inspection of held frames, SAM 3 prompting and mask review is a proposal. Do not assume SAM 3's text prompt directly understands the temporal action “item picked up by the claw.”
- Native Gradio's **Track with Cutie** tab uses the same forward-after-first runner on uploads with a user-supplied object phrase, no reference masks, and overlay/JSON downloads. Verified via a real localhost Gradio request on MPS: 249 frames and six usable anchors. The separate Video tab still samples SAM 3 independently. The CPU Docker demo cannot run Cutie. Automatic `trash` / `not trash` classification is unimplemented.
- SAM 3.1 migration is blocked by the published CUDA/Triton runtime assumptions; validated Mac inference remains SAM 3. SAM 2.1 is a separate alternative. No validated vLLM, Ollama, quantization or compilation optimization is in use.

## Ground truth and evaluation

- Marker-free jaw event research uses an evolutionary pool of at most ten candidates, with equal weight for event accuracy and measured speed. Try one seeded, bounded mutation per incumbent each round while unseen neighbors remain. Each benchmark clip has one squeeze and one release. Count all unmatched detections as false triggers. Use matched / (matched + missed + 2 × false triggers), weighted 75% pooled development score and 25% weakest development clip. Fill the ten retained slots before pruning, with at most five per detector method. Once full, replace at most one incumbent with a higher-scoring challenger and preserve at least one of each represented method. Iterate on the laptop and validate meaningful improvements on iPhone. Candidates may combine video with any available sensors and draw on web research. The first laptop round used the three-second press reference and recorded release as proxy labels. See `ml/experiments/jaw-trigger/README.md` for the holdout result and iPhone validation status.

- On the five Round 23 fitting clips, the frozen jaw winner scored F1 1.00 on the originals and 0.70 on the 960 × 720 encoded copies (7 matches, 3 misses, 3 false triggers). Both are 4:3. Rebaseline the resized input before adding deposit scoring and reserve fresh captures for independent evaluation. The paired check includes encoding as well as resizing.

- Human bucket-deposit review on 2026-11-08 approved 59 of 62 binary predictions. All three denials came from six explicitly low-confidence calls that had originally been uncertain. This prediction set combines earlier prelabels and agent reviews. Preserve the predictions and their evidence alongside the human outcome in the local dataset, and exclude the three clips without a visible grabber from deposit scoring. Clips 003–005 were removed from both deposit dataset copies because they show no grabber. The 62-clip dataset has 50 deposits and 12 non-deposits. The local copy located by `/tmp/tmt-jaw-policy-stage-current` and the backup on `ERICS_DRIVE/jaw-deposit-720p-62/` share the same reviewed label file. Use its clip IDs as the allowlist. Five non-deposits were used for Round 23 fitting. All 57 fresh clips are in one provisional upload block, so confirm recording sessions before splitting. The deposit review did not validate squeeze or unsqueeze timestamps. Use the `review-labels` skill for future local review batches.

- Round 24 uses all 62 reviewed clips as development data, with in-sample reporting. Joint fitness weights jaw accuracy 40%, balanced bucket-deposit accuracy 20%, and speed 40%. Use capture button cues as the squeeze and release ground truth. Use human-reviewed deposit outcomes as deposit ground truth and keep prior predictions as review provenance. Keep the frozen jaw-only baseline as a comparison.

- Joint Rounds 24–26 evaluated 39 proposals on the 62 development clips. Best fitness rose 0.571 → 0.590 → 0.596. Round 26 combined rising HOG with held-release optical flow. It matched 28 of 50 deposits with no false deposits, achieved 78% balanced deposit accuracy, and scored 0.322 jaw F1 against button cues. Laptop prepared-frame p95 was 0.105 ms. Keep these in-sample results separate from independent or live validation.

- Joint Rounds 27–36 evaluated 130 new genotypes on those same 62 clips using preplanned agent recipes and three researched seeds per round. The Round 29 winner remained first through Round 36 at 0.6145 fitness, 0.433 jaw F1 (53 matched, 71 missed, 68 false), and 76.7% balanced deposit accuracy (35 of 50 deposits and two false positives). Laptop prepared-frame p95 was 0.135 ms, earning full speed credit. The highest jaw F1 was 0.463 from a Round 33 challenger. The winner refits signed HOG with equal clip and class weighting and uses optical flow near its predicted release. Private reports are `joint-round-27.json` through `joint-round-36.json` in the current local stage. These are in-sample laptop replays.

- Retrospective selection audit of Rounds 27–36: 22 of 27 eligible new lineages received just one mutation opportunity, eight final slots used fitted HOG variants, and Round 33's best jaw candidate ranked second in its round but lost its head-to-head against the overall winner. All 130 new trials earned full speed credit and scored zero on the single worst clip. The winner had 22 zero-F1 clips; other trials found at least one matched jaw event on each of those clips.

- Joint Rounds 37–46 used the portfolio selector with one champion, complementary competitors, and up to three exploration lineages with three scored mutation attempts each. Three fresh ideas and ten parent proposals used each preceding round's actual results. Seven protected roots completed three attempts, and fitted HOG fell from eight active slots to three. The Round 44 winner held through Round 46 at fitness 0.6265, jaw F1 0.4810, 19 clips without a jaw match, 27 of 50 deposits, and zero false deposits. Deposit F1 was 0.7013 versus 0.8046 for the Round 36 winner. These are laptop development results on the same 62 clips.

- After Round 46, fitness shifted to 80% jaw-event F1 and 20% normalized laptop jaw p95 speed. Deposit accuracy and runtime are supplementary diagnostics. The dashboard re-scores recorded leaders on the current formula, and archived reports retain their original selection scores. All 299 archived joint trials already earned full speed credit, with maximum combined laptop p95 of 1.269 ms against the 4.17 ms full-credit threshold.

- Include scoring and runtime budgets in every jaw research and parent brief. Laptop p95 earns full credit through 4.17 ms per prepared frame and falls linearly to zero at 16.67 ms. The phone target is 60 fps. Ask candidates for their expected accuracy gain, p95, and how often expensive conditional work runs.

- The jaw-event success target is 0.95 F1. Track squeeze and release results separately and verify the combined target on fresh recording sessions when available.

- Jaw-only diagnostic on the 62 development clips: the Round 46 leader matched 19 of 62 squeezes and 38 of 62 releases at 15 Hz. Replaying the same detector at 30 Hz with comparable timing windows lowered total F1 from 0.481 to 0.464. This single-candidate comparison supports prioritizing squeeze evidence and testing new detector implementations. It does not establish that a higher frame rate is ineffective for other detectors.

- Round 47 completed 13 trials under 80% jaw F1 and 20% jaw runtime fitness. A causal video plus IMU model scored 1.000 F1 on its 62 fitting clips (124 matches, zero false triggers, 0.213 ms laptop p95). The shaft-registered geometry readout scored 0.940 and ARKit-assisted tracking scored 0.518 in development. Retrospective block-withheld refits scored 0.563 pooled F1 for the temporal model, with 107 matches, 149 false triggers, and 17 misses. Its five-clip earlier capture block scored 0.889 after training on the later 57 clips. Keep fitting scores and withheld results distinct. The progress dashboard reports squeeze and release counts separately.

- Dream-RSI-inspired replay of Rounds 27–36 reproduced all ten baseline pools. At 69 revealed trials, baseline fitness was 0.6145 versus 0.6071 for the portfolio selector. The portfolio requested 61 unlogged continuations, so the replay is a coverage audit rather than a comparison of how those new branches would perform. The ten subsequent live rounds changed the selector and proposals together. The local dashboard plots each completed joint round's leader fitness, jaw F1, and deposit F1.

- Shared evolutionary runner and agent briefs live in `ml/evolution/`. Use the `evolve` project skill for agent-guided rounds and new domain adapters. Jaw-specific scoring and candidate code remain under `ml/experiments/jaw-trigger/`.

- Jaw-trigger Rounds 19–23 used all five clips for fitting. Each round dispatched one primary-source researcher for three replacement ideas and one agent per parent. Parent briefs compare other detector families and give the champion and rotating parents structural assignments. Keep the better parent or child, then replace the bottom three lineages. The 60 fps phone target gives full speed credit through 4.17 ms per sampled frame to leave capture headroom. Round 23 scores at actual confirmation time. Signed HOG with median squeeze filtering matched all ten proxies with no false triggers in-sample. Use fresh recordings for generalization and keep paired iPhone/laptop timings by feature family before relying on latency regression.

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

Follow-up branch/PR: verify subscription-backed authentication with image input, then evaluate Agent review of SAM 3 anchors without an object name. Later tackle capture relevance, grasp/release timestamps and deposit-based labeling with uncertainty review. Defer further anchor-schedule optimization until more reviewed clips are available. No custom training.

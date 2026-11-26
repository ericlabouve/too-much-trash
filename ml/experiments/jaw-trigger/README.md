# Marker-free jaw trigger

`round_one.py` evolves lightweight detectors on the same five clips. Use
a Python environment with PyAV, NumPy, and OpenCV. Keep clips, labels, and
results in private storage outside Git.

```sh
python ml/experiments/jaw-trigger/round_one.py CLIP_DIRECTORY LABELS_JSON OUTPUT_JSON
```

The label file maps each MP4 filename to two timestamps in seconds, using the
keys `close` and `open`. This first run uses the episode manifest's volume
button callbacks relative to the recording window start. These are proxy
labels. Some objects hide the jaws and the offset between visible jaw motion
and the recorded callbacks has not been measured.

The first three clips in filename order rank the candidates. The last two
evaluate the selected winner. Sample at 15 Hz and match events of the same
type within 0.5 seconds. Each clip has one reference squeeze followed by one
reference release. A reference can match only once. Every other detection
counts as a false trigger, including duplicate and mistimed events.
Accuracy and speed receive equal weight. The accuracy metric is
`matched / (matched + missed + 2 × false triggers)`. Use the pooled metric
for 75% of accuracy and the weakest clip's metric for 25%. Report F1 and
the number of clips with both events matched and zero false triggers
alongside fitness. From Round 21, speed gets full credit at or below 4.17 ms,
one quarter of a 60 fps frame period. Credit then falls linearly to zero
at 16.67 ms. Timing
covers feature extraction on prepared frames. Variants of the same feature
extractor reuse its timing. From Round 23, researched runs score at the
confirmation frame, when a live detector could first fire. Earlier runs
backdated detections to the first qualifying frame.

Each incumbent attempts one previously untested variant per round. Seeded
mutations move bounded settings up or down, with occasional two-step
mutations. A parent with no unseen neighbors within two steps skips its
trial. Use `--seed` to set the mutation seed. The runner fills up to ten
slots without pruning, with at most five slots per detector method. In a
full pool, the highest-ranked challenger with an eligible replacement
competes against the lowest-ranked eligible incumbent. A swap requires at
least 0.001 fitness gain and preserves at least one candidate per represented
method. One swap is allowed per round.

Use `--rounds 3 --resume PREVIOUS_RESULTS_JSON` to continue the search.
Resuming the original round-one result restores its pruned shaft-aligned
template. Development footage controls selection. The final winner is checked
on the two existing comparison clips. They have
already been inspected, so use fresh holdout footage for independent
validation.

## Round 1 result

Bilateral flow ranked first on development footage with event F1 0.171 and
p95 feature extraction of 0.38 ms per sampled frame on the laptop. It matched
three of six proxy events and produced 26 false triggers. On the two held-out
clips it matched one of four events and produced nine false triggers.
The shaft-aligned template ranked last and was removed. The next pool contains
the winning parent and its untested three-frame confirmation variant.
This run validates the selection loop. Detector accuracy and iPhone timing
still need validation.

## Local dashboard

From the repository root, use the experiment's Python environment (PyAV,
OpenCV and NumPy) to serve the dashboard on loopback.

```sh
python ml/experiments/jaw-trigger/dashboard_server.py
```

Open <http://127.0.0.1:8787/>. The Start Round button launches a local Codex
coordinator for one agent-guided round. Codex must be installed and signed in.
The coordinator dispatches parent-to-child tasks and researchers, refits learned
models using training clips, and selects candidates using validation clips.
Each research agent owns exactly one fresh proposal; the research-agent count
is independent of pool reproduction. Every current retained candidate produces
exactly one child in an ordinary All families round. There is no top-X evolution
limit. Pool size caps the survivors after selection; if it is lowered, all current
members still reproduce in that transition round, then the smaller next pool
determines following rounds' reproduction counts. Choosing a specific family
also permits previously evaluated proposals from that family to re-enter. Family
names come from saved architecture metadata, not a fixed list. Research proposals may explore other families. New Family
runs zero evolution agents and requires one distinct new architecture per
research agent, with one separate reviewer checking all architecture claims.
That reviewer and each owning researcher exchange actionable feedback and revised
proposals through the coordinator. Acceptance can finish on the first pass;
unresolved proposals must receive at least three proposal/revision–review cycles
before the round may fail for architectural reasons. Check novelty early, then
review the final implementation again if its architecture changes. Each agent
keeps its identity and one proposal throughout revisions. Save versioned proposals,
feedback prompts and reviewer verdicts; completion verifies approval of the exact
final candidate, while architectural failure verifies the minimum cycles. Tooling,
authentication, cancellation and timeouts may stop earlier as operational failures.
New Family time allocation includes three researcher/reviewer passes, rather than
treating the independent review as a single task.
These dashboard allocation rules supersede earlier one-researcher/multiple-idea
briefs. The reserved test partition is excluded
from round selection. The bridge uses workspace sandboxing and retains job logs,
agent receipts, predictions and measured timings for its completion audit.

New jobs use `reproduction_protocol=all-pool-v1`. Completion requires a distinct
parent agent and exactly one changed child for every candidate in the selected
scope, including low-ranked and protected members. Task counts and round budgets
derive from that actual parent count. Parallel agents controls concurrency,
not which parents get a chance. Defaults are 10 current parents + 10 children +
3 fresh research candidates evaluated, with 10 survivors retained. New Family
remains research-only. Historical top-X jobs retain their original audit rules;
the removed `evolution_agents` setting is rejected in new dashboard requests.

The **Breeding & diversity** controls expose `protected_slots` (default 2,
0–9), `mutation_attempts` (default 2, 1–20) and the soft `family_limit`
(default 2, 1–10). Protection leaves a champion slot: effective protected slots
are bounded by pool size minus one; effective family cap cannot exceed the
pool size. A smaller evaluated family-scoped pool can reduce these further.
Zero protection clears inherited protection, but does not itself ban those
candidates from ordinary competition. Lowering protection retains the strongest
still-eligible inherited lanes within the new limit. Changing the attempt
limit applies to saved attempt counts, not a reset of lineage age.

At most one fresh research candidate gains a new protection lane per round.
Choose the least represented reviewed architecture family first, then the
greatest additional per-clip F1 beyond the champion, then the ordinary ranking.
A better parent/child inherits an existing lane; expiry follows actual evaluated
children, not elapsed rounds. Competitive family caps remain soft: mandatory
champion/protected/specialist picks and scarce alternative families can exceed
them. New `portfolio-v1` rounds recompute per-clip selection inputs from saved
validation detections and independently replay admission using configured
limits and reviewed family identities. Reported complementary coverage alone
cannot determine admission. Historical pools are not silently reselected.

New rounds require `training_protocol=validation-checkpoints-v1`, implemented
by the [shared training monitor](../../evolution/training.py) and
`dashboard_training.py`. Evolution and research briefs share the same rules:
measured baselines, a predeclared hypothesis/seed/resources/capacity/regularization,
complete attempted-fit journal, periodic validation, best-checkpoint export and
patience/time stopping. Defaults are 10 evaluations without a 0.001 event-F1
gain, minimum five epochs before patience, and 300 seconds per trial (bounded
by a shorter agent allocation). Agents declare an epoch ceiling; they need not
train for 100 epochs. Loss breaks exact F1 ties, then earlier epochs win.
The checkpoint-selection decoder stays fixed throughout fitting; log any
subsequent validation-only decoder tuning separately. See the shared README
for API usage, opaque tensor checkpoints, noniterative records and limitations.

Completion recomputes each recorded epoch's event F1 and checks the chosen
checkpoint against the published parameters. It rejects missing fit receipts,
open attempts, stale evidence, incomplete logged trials, invalid stops and a final-epoch
export that discards a better checkpoint. Reviewers inspect training code and
noniterative claims; metadata alone cannot prove honest execution. The outer
worker pins evaluator/training source snapshots and rejects changes during a
round. Historical fixed-epoch jobs remain readable as legacy evidence; this
does not retroactively retrain or approve them. Incompatible future training
policies need a new protocol version and a compatible historical validator.
Audited histories directly populate candidate loss charts, without duplicate
legacy `candidate_metadata.training_history` artifacts.

The dataset checklist discovers beach, park and home from the frozen local
reference snapshot. Selected episodes are shuffled by the seed and assigned to
the configured training/validation/test percentages. Random clip splitting can
share capture conditions and overlapping intervals. Store the snapshot digest
and exact split membership with every run. The local working review copies are
curation outputs and do not replace frozen training inputs automatically.

Controls include family, clip limit, retained pool size, evolution and research
agent counts, agent time and
concurrency, seed, fitness weights, validation-F1 target, matching tolerance and
speed bounds. Event-specific controls are grouped by event set: currently
**Jaw events · squeeze & release** contains tolerance and target validation F1.
Jaw and speed weights remain visible in the fitness card above its collapsed equation;
speed weight is the remaining percentage after jaw weight. Shared speed settings
live in a separate section. Both bounds
are **frame fractions**, shown as two draggable dots on one scale: full credit
defaults to 0.25 frame and zero credit to 1.00 frame. Target frame rate is derived
and hidden when the selected datasets share a known source cadence. Rates within
57–63 fps (60 fps ±5%) count as 60 fps, so one frame is 16.667 ms. Mixed or unknown
source rates expose a scoring-rate choice (default 60 fps); this does not resample
the clips. Use capture-source frame intervals, rather than container average/base
rates or the experiment's sampled replay cadence. The credit curve and slider sit to the
right of the speed controls on wider screens and stack on narrow screens. Handles
support dragging, keyboard adjustment and track clicks, and cannot cross.
Save both fractions and target fps. Convert with `full_speed_ms = full_fraction *
1000 / target_fps` and `frame_budget_ms = zero_fraction * 1000 / target_fps`.
The server rejects conflicting fractions/milliseconds and accepts legacy
millisecond-only settings. Default scoring and historical values remain unchanged.
Expanded candidate cards show recorded training/validation losses by epoch for
iterative models. Missing series are labeled, never reconstructed from final F1.
The original R50 multiscale Temporal MLP saved only training BCE; other old
neural fits did not save epoch histories. A November 22 diagnostic reproduced
both current top-two 100-epoch fits with exactly identical final frozen parameters,
recording training and validation BCE after every epoch in inference mode.
The multiscale fit also reproduced all 100 original noisy minibatch-loss values.
These curves are a hash-checked overlay via `working/runs/training-loss-current.json`;
original results, ranking, F1 and benchmark artifacts remain unchanged. Evidence
is in `working/runs/loss-curves-r50-20261122/`. Both validation curves rise as
training loss falls, suggesting overfitting; no new checkpoint was selected.
To reproduce this specific R50 diagnostic, use the experiment runtime with
`record_top_loss_curves.py PRIOR_RESULTS_JSON FRESH_OUTPUT_DIRECTORY`. It reuses
the pinned train/validation preparation cache and original fit implementations,
preserves training RNG state during observation, and refuses to publish curves
unless the regenerated parameters exactly match the current checkpoints. It does
not launch evolution, change decoder settings, benchmark speed or open test clips.
Closed-form fits, threshold rules and tree ensembles do not receive invented curves.
Future agent rounds save both series under the same objective with inference-mode
validation and no test access. Their `candidate_metadata[name].training_history`
contains job-relative `path`, `sha256`, `model_path` and `model_sha256`. The history
JSON has `metric`, `points` (`epoch`, `train_loss`, `validation_loss`) and optional
`note`. The model JSON must equal `feature_parameters[method]`. Changed hashes,
models or candidate configurations invalidate the displayed history. These are
objective-loss diagnostics, separate from deployment F1 and fitness.
Hover or focus a parameter for its definition. The default
agent allocation is 2 minutes per candidate for the supervised smoke check, with up to three child agents
working concurrently. The controls show actual evolution, research and review
counts before launch; the coordinator is fixed at one and hidden from parameters.
The parallel-agent control supports up to five (default three). Agents may
research, implement and fit concurrently, but final candidate latency replay
must run sequentially after all fitting stops, using the same runtime, prepared
inputs and timing scope. Concurrent preparation or tuning timings cannot be
substituted for those final isolated measurements.
Pool size only limits retained competitors.
Completion requires a distinct research-agent receipt mapped to each fresh candidate.
The round prompt textbox supplies additional direction verbatim to the coordinator
and every child agent. Settings and child prompt files preserve it with the run.
The Research Agent section previews the same coordinator prompt template and
discloses the configured harness, tools, project instructions and output evidence.
Its preview endpoint validates settings without launching agents. Job paths are
filled in at launch, and individual child prompts are generated during the round.

Subset checks save separate results under the local dataset's `working/runs/`
directory. Complete all-family and full-dataset New Family rounds advance the
durable resume pointer there. Family-filtered and clip-limited checks keep their
own results; completed checks still consume a round number.
Audited subset checks can supply newly measured scores for unchanged current-pool
candidates without promoting a new official pool. The table also shows evaluated
proposals that were not retained, labeled in their expanded cards. The family
menu can select these for renewed exploration without growing the retained pool
beyond ten. The early Architecture review parameter is shown only in New Family
mode; Reviewers per candidate is always available, defaults to one, and cannot be disabled.
The table shows train and
validation event F1; fitness stays in expanded details. Test remains reserved until
model selection is frozen, following the user's November 21 decision. Changing
datasets, split seed or scoring settings clears mismatched table values instead
of reusing historical fitting scores.

New jobs require `agent_budget_protocol=supervised-v1`. A local MCP supervisor
uses a default 2-minute allocation per started agent for the supervised smoke check.
Increase this before substantial model research. There is currently no
per-agent token budget (deferred by user choice).
The supervisor owns independent CLI child process groups, queue/concurrency limits, monotonic
deadlines, same-thread continuation and cancellation. Minutes per agent starts
at actual launch; early candidate-author replies resume automatically with the
original remaining budget. Authors inspect failures, try further hypotheses
and retain the best validated checkpoint. Their final 10% (up to 120 seconds)
is reserved for finalization only; shared deployment export and isolated final
benchmarks still happen afterward. At the hard deadline, the supervisor stops
the process group, allowing only a short cleanup grace. Ordinary feedback
cannot reset clocks; only bounded New Family architecture cycles 2/3 renew
the same research/reviewer identities. A documented operational blocker stops
early; completed reviewers need not consume their whole allowance.

The coordinator uses `evolution_agents` MCP lifecycle tools rather than built-in
subagent dispatch. The outer worker copies its private supervisor ledger into
`agent-runtime.json`, pins its hash and independently verifies every task's
identity, assignments, prompt, artifact, deadline and export window before
publication. A failed, timed-out or unfinished child blocks successful publication.
Legacy jobs remain readable without retroactive deadline certification. See
`ml/evolution/README.md` for the shared lifecycle contract and Goal diagnostics.
On installed Codex 0.160.0, native Goals continued automatically in persistent
app-server threads but `codex exec` exited after one turn with its Goal active;
our spawned CLI children therefore use explicit supervised resume.

Leader history uses only audited validation jobs. Context fingerprints include
the frozen snapshot, exact partitions, seed, comparison scope, scoring/timing
settings and evaluator hashes. The chart never connects different contexts or
includes old in-sample F1 in the new validation curve. It recomputes fitness from
measured validation F1 and p95 under that context's recorded formula and finds
the leading evaluated candidate, including fresh proposals. Isolated checks are
explicitly labeled. Context matching here controls score presentation; it does
not itself promote a pool or change historical search/selection decisions.
The November 21 live New Family check completed with one researcher and one
reviewer: ten baselines were refitted on 182 training clips and replayed on
61 validation clips, with 61 test clips reserved. The new Extra Trees model
scored 0.8176 train F1, 0.7094 validation F1 and 0.3187 ms prepared-frame p95;
the best refitted incumbent scored 0.7529 validation F1. Early architecture
and final implementation reviews both accepted it; rejection/revision retries
remain unit-tested rather than live-exercised. Independent completion audit
passed. This check was initially isolated; on the user's subsequent request it
became the Round 49 continuation checkpoint. Round 50 is next. The original
portfolio selection excluded Extra Trees, so it remains an evaluated proposal
available for explicit family exploration, rather than a retained competitor.
This was subsequently traced to a shared selector bug: ideas entered ordinary
competition only as champion or through a free protected lane. The selector now
includes every fresh idea in competitive eligibility even when all three lanes
are occupied. Replaying selection alone admitted Extra Trees fourth by fitness,
replacing the lowest-scoring pose-weighted HOG model. The corrected continuation
checkpoint is `results-selection-corrected.json` in the same job, with a
`selection-correction.json` receipt. Original `results.json`, model weights,
predictions, timings and round number remain unchanged. No retraining or test
evaluation was performed.

The round prompt is a compact resizable field in the parameter flex layout.
The API poll retries after disconnection, shows an explicit reconnecting message,
and clears stale errors once the same completed-round state returns. Recovery
also refreshes the agent prompt preview; it does not discard dataset selections.

Round 50 completed with four parallel parent agents and one researcher on the
same seed-0 split. All 15 candidates (ten incumbents plus five proposals) passed
the receipt audit. The asymmetric temporal-confirmation child scored 0.9917
train F1, 0.8235 validation F1, fitness 0.8588 and 0.1889 ms laptop prepared-frame
p95. All four children improved on their respective parents; the fresh
prototype-distance proposal scored 0.4527 validation F1. Test remained reserved.
An independent audit confirmed six non-overlapping replay batches, all after
the six recorded fitting logs finished. Artifacts are under dataset
`working/runs/dashboard-20261122T043156Z-2a4799fe/`, including
`independent-timing-audit.json`. No subsequent round was started. The target
remains 0.95 validation F1. History accepts both basename and repository-relative
evaluator hash keys so these equivalent protocols share one trend context.
Artifacts: `working/runs/dashboard-20261122T035257Z-20c4923c/` under the dataset root.

### Final integrity gate and continuous-stream limitation

New round scoring uses `benchmark_protocol=deployment-v1`: final train/validation
F1 and latency must come from the **same frozen deployable artifact**, preprocessing
and event decoder. Python/NumPy/PyTorch/Hugging Face remain unrestricted for fitting
and prototyping; their predictor outputs are provisional. C++ is one deployment
option, not a required research language. Core ML and supported native, ONNX Mobile,
ExecuTorch, TFLite or Metal artifacts are also permitted. A Python wrapper may
invoke the real exported deployment runtime without substituting prototype logic.
Export and serial final measurement use the coordinator's reserved preparation/
evaluation stage, outside each proposing agent's research window. Conversion
failures remain useful research evidence, but an unexported prototype cannot
supply final pool scores. Physical-phone validation remains a separate milestone.

`deployment_benchmark.py` verifies reports for every evaluated incumbent and
challenger. Freeze runtime/model/preprocessor/decoder files; bind predictions,
per-frame timing traces and train/validation membership to that exact bundle.
Saved final predictions and timings must equal those native-runtime outputs.
Every candidate is measured serially on the same disclosed device, with warmup,
nominal thermal state and fitting finished. Final reviewers must inspect the same
deployed bundle. Missing evidence or mixing prototype F1 with deployment latency
blocks publication. Historical jobs retain their original scoring context.

Every new round ends with independent final integrity reviews after fitting and
serial latency evaluation, before pool admission. Configure one to five
**Reviewers per candidate** (default one). New settings bind
`review_protocol=per-candidate-v1`; `review_agents` stores this per-candidate
count. Every candidate/reviewer slot starts a fresh independent agent context;
reviewer identities cannot be reused across candidates or overlap any author
or the early New Family architecture reviewer. Each reviewer sees exactly one
frozen candidate with the common rubric and evidence, without peer verdicts.
The default next pool has 8 parents and 2 research agents, producing 10 challengers
and 10 fresh reviewer tasks (20 author/reviewer tasks total). Reducing a current
10-parent pool first reproduces all 10 and adds 2 researchers (24 author/reviewer
tasks in that transition); selection then retains up to 8. Parallel agents controls batches.
The Population & agents card shows these counts in a live vertical diagram;
its expandable Breeding & diversity subsection controls survivor selection.
Jaw-event and speed-score controls are subsections of Fitness; weight fields
remain visible while the detailed equations stay expandable.
Research and evolution briefs explicitly prohibit episode-timing
shortcuts, labels or clip identity at inference, future samples, and hidden resets
at labeled boundaries. All challengers, including those not ultimately retained,
require approval from every assigned reviewer; missing or rejected reviews block
publication and preserve the prior pool.

Each `kind=integrity_review` task records `candidate_name`, `fresh_context=true`,
its unique `agent_id`, completed status, `prompt_path` and report `artifact`.
Each `integrity_reviews` receipt binds `candidate_name`, `reviewer_id` and
`artifact`. Its report declares those names, `fresh_context=true`, frozen
`context_sha256` and a `candidates` list containing exactly its assigned review.
The verifier checks exact coverage, independence, hashes and existing probes,
and publishes `candidate_reviewers` for candidate-scoped approval badges.
Legacy jobs without `review_protocol` retain their original shared-review rules.

New jobs require `review_bundle_protocol=frozen-bundle-v1`. Before dispatch,
save a candidate-scoped review package containing `candidate`, `artifact_bundle`
and frozen `context`; pass its path as `review_bundle` to the supervisor. The
supervisor rejects duplicate artifact paths, stale hashes, missing roles or
wrong candidate scope before spending a reviewer task. The package hash and
graph are pinned for final comparison with the published candidate artifacts.
Do not silently deduplicate a reviewed package after rejection or bypass a
negative verdict. Fix structural errors before dispatch; changed reviewed
artifacts require legitimate fresh review evidence.

Reviewers inspect exact code, model and configuration hashes and save numeric
evidence for timestamp-origin shifts, variable prefixes, continuous multiple-event
and chunk-equivalence tests, long open/closed no-event streams, and prefix causality.
`dashboard_integrity.py` checks the evidence against frozen candidate artifacts,
settings, train/validation manifests and evaluation results. Publication also
requires the independent outer worker's verified completion receipt; a completed
status file or a self-declared approval is insufficient. The server and leader
history revalidate this receipt. Bounded mutation CLI runs are diagnostic only and
cannot publish a formal pool. These checks reduce reward-hacking risk; receipts
cannot prove arbitrary runner execution or reviewer honesty.

The November 22 audit found no explicit three-second timer or future-label rule
in the inspected candidates. It did demonstrate that an invalid clock-only
negative control can score 1.000 F1 on the 61 validation clips by firing at three
seconds and duration minus three seconds. Existing replay initializes reference,
history and decoder state separately for each clip, so the historical scores are
**clip-replay results, not proof of nonstop performance**. Existing incumbents are
marked `legacy_unreviewed`; final review never retroactively certifies them.
The current scoring protocol remains `clip_replay-v1`; continuous-stream F1 is
not implemented or claimed by the gate.

Native timestamp-shift and future-truncation probes passed for the four inspected
temporal models across all 61 validation clips. Idle-prefix insertion increased
the winner's false triggers from 38 to 42 (F1 0.8235 to 0.8116). This exposes
initialization sensitivity without establishing deliberate cheating; synthetic
padding can also introduce inertial transients. Audit scripts, reports and scope
are preserved privately under dataset
`working/runs/integrity-audit-r50-20261122/`. No new round or reserved-test replay
was performed. A persistent frame-step inference adapter and a realistic
uninterrupted-stream benchmark remain necessary before a deployment claim.

The CLI requires `--approve-for-me` without the redundant `--sandbox` option;
it already selects workspace-write. Structured output requires every schema
property to be listed in `required`, including `failure_kind='none'` on success.
Pass the exact known Python runtime and dependency overlay to children. Never
search personal/home/cloud folders for environments: an initial broad discovery
attempt was stopped after macOS access prompts. Keep discovery within the
repository, job and explicit manifest inputs; missing dependencies are an
operational blocker, not permission to broaden the search.
The service starts idle and accepts a single job at a time. Use `--prior` to
select a frozen round explicitly. The service requires the frozen dataset mount
described in the ML memory. The bounded mutation CLI saves diagnostic results
without advancing the dashboard's official pool.

```sh
python ml/experiments/jaw-trigger/round_one.py CLIP_DIRECTORY LABELS_JSON OUTPUT_JSON \
  --progress ml/experiments/jaw-trigger/dashboard/progress.json
```

The page reads the latest local snapshot twice per second. The runner writes
updates while preparing clips, scoring each candidate, and checking the
holdout. The completed snapshot shows the retained pool, scored trials, and
any candidate removed from the pool. Repeat laptop rounds until candidates improve meaningfully, then use the
phone for a separate replay benchmark and live pickup validation. Candidate
ideas can come from web research and use any available capture sensors. Serve this directory on loopback since the progress file
contains local experiment data.

## iPhone bilateral-flow replay

### Current-pool native replay (November 22)

The paired Mac benchmark uses the exact same `pool_runtime.hpp` (matching SHA-256),
OpenCV 5.0, six fixtures, native CPU math, warmup and three rotated serial passes.
Build `iphone-replay/CMakeLists.txt` against a matching native OpenCV core/imgproc
build, then run `jaw-pool-mac FIXTURES OUTPUT_JSON`. `phone_benchmark.py --platform
laptop-native` validates it without labeling laptop results as phone measurements.
On the M1 Pro, paired leader p95 was 0.0744 ms versus iPhone 0.0600 ms. This is a
comparison under observed normal-device conditions, not an intrinsic hardware
speed ratio. Paired evidence: `working/runs/laptop-native-pool-r50-20261122/`.

At the user's request, a separate full deployment replay now supplies the pool's
displayed laptop p95 **and F1**. `prepare_deployment_replay.py` exports all 182
training and 61 validation clips from the unchanged cache, keeping labels outside
inference fixtures. The Mac runner streams one clip at a time outside the timing
boundary. `score_deployment_replay.py` validates complete serial passes and derives
F1 and p95 directly from native outputs; no fitting or test-media read occurs.
All ten candidates retained their prior F1. Native validation p95 is 0.0495–0.0777
ms for visual/model methods and below 0.001 ms for IMU methods, with 20,991 measured
validation frames per candidate. Full suite including training, warmup and loading
took 69.25 seconds. Evidence: `working/runs/deployment-pool-r50-20261122/`.

A hash-pinned `deployment-evaluation-current.json` overlays those exact-checkpoint
scores in the dashboard and creates a separate deployment-runtime leader context.
Original R50 files, pool admission, fitting and reserved test remain unchanged.
The expanded card retains the six-clip paired laptop timing; the phone column
still uses its six-clip replay. Neither is silently substituted for full-validation
final scoring. These legacy clip-initialized models remain streaming-unreviewed.

`prepare_pool_replay.py RESULTS RUN_DIRECTORY` exports the first two cached
validation clips per frozen collection, the exact retained candidate configurations
and frozen runtime weights. It performs no fitting and never opens test footage.
Labels, source identities and Python parity outputs remain outside the phone's
`Fixtures` folder. `iphone-replay/pool_runtime.hpp` ports the ten R50 candidates
to native C++/Accelerate/OpenCV CPU inference; unsupported future methods fail
explicitly. It is separate from the recording app and the older replay below.

Stage `pool_main.mm`, `pool_runtime.hpp` and `pool-project.yml` (as `project.yml`)
beside `Fixtures` in the private run/build directory, supply the official OpenCV
5.0 iOS framework, generate with XcodeGen, and build the JawPoolReplay scheme in
Release with the local development team. No generated project, framework,
fixture, learned weight, executable or device output belongs in Git. The
standalone bundle reuses `org.toomuchtrash.jawflowreplay`; the production collector
bundle and its captures are unaffected. Current iOS requires the scene lifecycle.

Each candidate runs alone, one full untimed warmup followed by three serial
measured passes with rotated order. The app disables auto-lock while running,
records foreground interruption, low-power/thermal state, exact frame counts,
and per-candidate non-overlapping uptime intervals. Retrieve
`Documents/pool-result.json` as `RUN_DIRECTORY/phone-result.json`, then run
`python phone_benchmark.py RUN_DIRECTORY`. Validation requires nominal thermal
conditions, no interruption/low-power mode, complete coverage, exact events and
score agreement within 0.0001 with the unchanged Python models. Zero-duration
samples from timer quantization stay zero; an unmeasurable p95 is rejected.

R50 measured six validation clips (705 frames), three passes and 2,115 samples
per candidate on a physical iPhone 15 Pro (iOS 27.2.1). All ten native ports
matched all Python events; maximum score discrepancy was below 0.000004.
The suite including warmup took 1.09 seconds, without interruption, at nominal
thermal state. Winner p95 was 0.0600 ms; the remaining visual/model candidates
ranged from 0.0354 to 0.0625 ms. Both IMU-only variants were below 0.001 ms and
timer-limited. Private evidence is under dataset
`working/runs/phone-pool-r50-20261122/`.

These timings include prepared-frame feature extraction, raw IMU alignment,
native model inference and the confirmation decoder. They exclude capture,
decoding, grayscale resize, input/model loading and warmup. They are CPU native
ports, whereas historical laptop timings use Python/NumPy; they do not establish
live camera throughput or continuous-stream accuracy. Clip initialization is
preserved for parity, so this benchmark does not grant integrity approval.
Models, pool selection, laptop fitness and reserved test scores remain unchanged.
The dashboard reads a hash-pinned private `phone-timing-current.json` pointer and
shows measurements only for the exact source result and candidate configuration;
a refitted checkpoint must be benchmarked again.

A standalone Release app replayed the two held-out clips on a physical iPhone
15 Pro using OpenCV 5.0.0. Both machines received the same prepared grayscale
crops at 15 Hz and used the same Farneback parameters. For 221 frame pairs,
the iPhone measured 0.29 ms median and 0.69 ms p95 detector time. The matching
laptop replay measured 0.42 ms p95. Both emitted identical events and matched
one of four references, with nine false triggers. The press reference is
three seconds into the recording window. Release uses the recorded button
timestamp. Timing excludes video decoding, resizing, live capture, and event
scoring.

## Rounds 2–4

Round 2 restored the shaft-aligned template and expanded the pool from six
to ten with no removals. Rounds 3 and 4 each tested ten new challengers and
replaced one incumbent. The shaft-aligned template was removed in round 3
after the pool reached capacity. Round 4 selected bilateral flow with a
0.135 motion threshold and three confirming frames. Development F1 rose from
0.171 to 0.286. On the two previously inspected comparison clips, the winner
matched zero of four reference events with six false triggers. The original
matched one of four with nine false triggers. These are results against
button timing proxies, and they do not establish a detector improvement.

## Rounds 5–8

Scored 40 challengers. Mutations explored temporal smoothing, a short cooldown
after a detected event, requiring opposing motion on both sides, and aligning
the crop to the shaft. Mean development F1 gives each clip equal influence
during selection. Creation rounds and parents are carried forward on resume.
The round 4 variant remained the winner with pooled development F1 0.286.
It matched zero of four reference events on the two comparison clips and
produced six false triggers, the same result as the prior round. The
comparison clips use previously inspected button timing proxies.

## Rounds 9–12

The `--diversify-flow` option replaced the bottom five of ten bilateral-flow
candidates with jaw angle, shaft-relative patch tracking, spatial gradient
histograms, calibrated change occupancy, and accelerometer transients.
Once the pool is full, admission preserves at least one incumbent from each
method and caps bilateral flow at five. Resume mixed pools with `--imu`
pointing at the private sidecar JSON array in clip filename order. Each entry
contains the manifest's recording `start` and the original IMU `samples`.

The four rounds tested 40 mutations. The final pool retained all six methods
and had one bilateral-flow entry. Spatial gradient histograms won with mean
development F1 0.533 and laptop detector p95 0.071 ms. The winner matched all
four button reference events with zero false triggers on the two previously
inspected comparison clips. Median timestamp error was 0.277 seconds.
Development footage controlled selection. This comparison uses the same
previously inspected clips and approximate timing labels as earlier rounds.

### Dashboard video replay

Publish a scored round with
`python publish_replay.py CLIP_DIRECTORY LABELS_JSON RESULTS_JSON dashboard/replay --imu IMU_JSON`.
Use the same clips, timing labels, and IMU sidecars as the scoring run. The
publisher replays the scored candidates and links the original MP4s. Keep
the dashboard on loopback when serving the private clips. The generated
replay directory is ignored by Git.

For joint rounds, pass the development manifest as `LABELS_JSON` and its
directory as `CLIP_DIRECTORY`. The publisher uses the manifest's videos,
button references, IMU and pose sidecars, and the round's frozen weights.
Replay includes the retained candidates and defaults to the top-ranked candidate.
Republish after a new scored round to update its predictions and video links.

## Rounds 13–16

The revised search uses bounded mutations and the weakest development clip in
its accuracy score. With seed 0 and the Round 12 pool, it tested 40 new
variants, made four swaps and retained six detector methods in ten slots.
The selected accelerometer variant scored 0.333, 0.333 and 0.400 on the three
development clips, with 17 false triggers total. On the same two comparison
clips it matched three of four references with seven false triggers. Round
12's gradient variant matched four with zero false triggers there. The
new search improved weakest-clip development F1 while degrading this
comparison result. Both use the same five recordings and button proxies.

## Rounds 17–18

False triggers now cost twice as much as misses in the accuracy metric.
Two laptop rounds tested 20 variants. The spatial gradient candidate from
Round 12 ranked first again. On development clips it matched four of six
events and generated three false triggers. The prior accelerometer winner
matched five and generated 17 false triggers. On the same comparison clips
the gradient candidate matched all four events with zero false triggers.
Clip 2 remains a miss for that candidate.


## Agent-guided rounds

The jaw experiment uses the [shared evolutionary runner and agent rules](../../evolution/README.md).
Run `python agent_briefs.py PREVIOUS_RESULTS_JSON` from this directory for
briefs with jaw-specific evaluation guidance. After collecting proposals,
run `round_one.py` with `--resume PREVIOUS_RESULTS_JSON --plan PLAN_JSON`.
Each researched jaw round fits all five clips and saves its plan with the
result. Rounds 19 and later have no independent comparison clips.

### Rounds 19–23

Ran five rounds using all five clips for selection and, for fitted HOG,
coefficient fitting. Each round evaluated ten parent proposals and three
research proposals. Rounds 19–21 led with eight matches and two false
triggers. Gyro flow and cumulative/adaptive gradient variants recovered
Clip 2 events but had more false triggers overall. Round 22's shared ridge
projection on signed HOG changes matched all ten with one false trigger.
Round 23's median squeeze filter matched all ten at confirmation time with
zero false triggers. The median absolute error against the button timestamps
was about 0.22 seconds. Fresh sessions, including no-squeeze footage, are
needed to measure generalization and the field false-trigger rate.

Research directions included [HOG](https://www.cs.cornell.edu/courses/cs4670/2013fa/projects/p5/files/dalal_triggs_cvpr2005.pdf),
[Lucas–Kanade flow](https://docs.opencv.org/4.x/d4/dee/tutorial_optical_flow.html),
[sequential change detection](https://doi.org/10.1093/biomet/41.1-2.100),
and [ridge regression](https://www.stat.cmu.edu/technometrics/70-79/VOL-12-01/v1201055.pdf).

The physical iPhone 15 Pro replay used identical prepared 15 Hz crops.
The source files are nominally 60 fps and averaged 56.2–58.0 fps. Compare
per-method laptop and iPhone p95 with the dashboard. iPhone numbers cover
feature extraction and omit capture, decoding, preprocessing and event
confirmation. A first log-linear timing fit across gradient, edge and
dense flow failed leave-one-family-out validation. Collect paired timings
across more feature families before using it to estimate a new method.

The standalone XcodeGen benchmark source is in `iphone-replay/`. Generate
private inputs with `python prepare_phone_replay.py CLIP_DIRECTORY RESULT_JSON
iphone-replay/Fixtures`. Supply the OpenCV iOS 5.0 framework locally as
`iphone-replay/opencv2.framework`, generate the project with XcodeGen,
and build Release with the local development team. The app writes
`Documents/result.json`. Check the suite tag, interruption flag and all
per-clip sample counts before using the file. The app keeps the screen awake
only during the replay. The device must be unlocked when launching it.

On the iPhone 15 Pro the native Round 23 winner processed 583 prepared
frames without interruption. Its ten emitted events matched the laptop
replay exactly. The full detector step measured 0.0315 ms p95, including
the median and state decision. The four-method suite finished in 261 ms
with nominal thermal state. These figures do not include live capture
or preparation.

## Reviewed development corpus

Use `evaluate_development.py MANIFEST BASELINE OUTPUT` to replay the frozen
Round 23 video detector on the local 62-clip, 960 × 720 development
manifest. Capture button cues are the reference for squeeze and release.
Use the human-reviewed deposit outcome as the deposit reference. Earlier
deposit predictions are review provenance. Report results as in-sample.
The success target is 0.95 jaw-event F1. Track squeeze and release results
separately and confirm the target on fresh recording sessions when available.

Fitness uses 80% jaw event F1 and 20% normalized laptop jaw p95 speed.
For supplementary deposit reporting, pass `--deposit-predictions PREDICTIONS_JSON`
with a binary `predictions` mapping keyed by clip ID and `p95_ms` measured
for the joint detector. Full speed credit extends
through 4.17 ms per prepared frame, one quarter of a 60 fps phone frame.
Speed credit then falls linearly to zero at 16.67 ms. The fitness benchmark
covers jaw features and event logic on prepared frames. Measure frame
preparation and iPhone runtime separately. The earlier joint rounds used 40%
precision-weighted jaw accuracy, 20% balanced deposit accuracy, and 40%
speed. Saved reports retain the fitness used for selection. Keep
prediction inputs and results in private storage.

Agent-guided joint rounds use
`run_joint_round.py MANIFEST PRIOR_RESULTS PLAN OUTPUT --progress dashboard/progress.json`.
Generate the research and parent briefs with `python agent_briefs.py PRIOR_RESULTS --portfolio`.
Pass `--target-f1 0.95` to end the run after the first round with an
evaluated candidate at the target. Use `--feature-parameters` to supply a
JSON object keyed by candidate method for fitted models. Parameters are
copied into the private result for replay.
Use `validate_withheld.py MANIFEST FOLDS OUTPUT CANDIDATE...` to replay
training-specific models and decoders on withheld capture blocks.
Supply its output with `--withheld-report` and use `--target-basis withheld`
when the threshold applies to that replay.
Candidates may propose new code, train policies, SVMs, or other models on
the fitting set, and combine video, IMU, ARKit, or other runtime signals.
They may spend more compute for accuracy and report laptop p95 under the
common scoring protocol.
The plan uses the shared evolution schema. Joint candidates add
`deposit_method`, `deposit_threshold`, and optional `release_ratio`,
`release_cooldown`, and `release_confirm` to the jaw candidate record.
The release ratio defaults to 0.70. By default both edges use the same
cooldown and confirmation.
Deposit heuristics operate around the candidate's predicted release and
are reported for diagnosis. Fitness and specialist selection use jaw metrics.
The brightest-region gate only selects where to look for transfer
evidence. It cannot on its own produce a positive prediction. Record
the combined laptop p95 separately and report these results as
in-sample. Phone timing requires a new joint benchmark.

For a preplanned batch, `--batch-rounds N` takes a plan with `parents`
(one ranked-slot recipe list and rationale per incumbent) and `ideas`
(three fresh candidate configurations per round). The adapter materializes
the recipes against each new pool and saves each round separately by
appending its round number to the output stem. Use a single-round plan when
fresh agent proposals must respond to that round's replay results.

Use `--portfolio` for champion, specialist, and protected selection.
To keep decoded clips cached while gathering fresh agent plans, pass a
directory as `PLAN` and set `--batch-rounds N`. Publish
`joint-plan-ROUND.json` atomically in that directory after reviewing the
previous round. The runner waits for the next plan between rounds.
Score and log the clips with no matched jaw event alongside the official
fitness.
The dashboard plots the fitness and jaw F1 of each completed
joint round's recorded leader. It recomputes the fitness trace using the
current weights. Archived joint runs earned full speed credit even with
deposit processing included. Use the round slider to inspect exact scores.

`replay_selection.py RESULT OUTPUT --from-round 27` compares the original
and portfolio selectors on recorded joint trials. It reveals each
continuation only when requested, counts requests with no recorded
continuation, and compares scores at the same number of revealed trials.
Prospective runs are needed to measure branches missing from the archive.

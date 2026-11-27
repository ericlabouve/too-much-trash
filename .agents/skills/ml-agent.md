# Too Much Trash: ML working memory

Last updated: 2026-11-26. Read before project ML work; verify current code/runtime when needed.

## Current dataset storage and identity

The Data Reviewer handoff on November 20 supersedes historical stage and drive paths below. Frozen inputs are under `/Users/ericlabouve/Datasets/too-much-trash/reference/current/{beach,park,home}/`. The mounted snapshot's `SNAPSHOT.json` was present at handoff receipt and records creation at `2026-11-21T01:00:06.853640+00:00`. The reviewer verified checksums and an EROFS write failure. Follow `/Users/ericlabouve/Datasets/too-much-trash/README.md` to remount `reference/datasets-20261121T005738Z.dmg` read-only after reboot. Keep the mount read-only. External ERICS_DRIVE remains the golden copy and may be unplugged.

- Put generated manifests, features, frames, weights, reports and experiments under `/Users/ericlabouve/Datasets/too-much-trash/working/{runs,cache,exports,annotations}/`. Pin runs to the frozen snapshot. `working/review/` contains independent writable curation copies for the port 8788 viewer. Later reviews require deliberate reconciliation and a new snapshot before changing training inputs.
- The snapshot has 304 episodes, with 242 beach, 57 park and five home. Home is original clips 006–010 from the old mixed 62-clip collection. Physical folders now use independent consecutive `episodes/NNN/` numbering per collection. Read paths from `labels.json` items' `files` or `metadata/clip-index.json`, whose `directory` field maps original IDs to folders. Join globally by collection and capture UUID. Original clip IDs alone are not globally unique. Exclude macOS metadata in `macos-metadata.tar` from examples.
- Each labels envelope retains `items`, `summary` and optional `definitions`, explicit human outcomes, AI evidence/confidence and provenance. Human corrections take precedence. Beach has 221 confirmed and 21 not_deposited, with 16 human-sourced and 226 AI-only labels. Home has five human-approved not_deposited. On November 21, the mounted park labels explicitly contained corrected_label=confirmed for original clips 046, 068 and 077, giving 50 confirmed and seven not_deposited. This supersedes the earlier handoff's three unresolved denials. A denial without an explicit corrected label still does not establish the opposite outcome. Current total is 271 confirmed and 33 not_deposited, with 78 human-reviewed records. Verify the current snapshot before each run.
- The 242 beach clips came from one outing with 85 identified overlapping neighboring intervals. Preserve session and overlap groups when splitting. The old 62 clips were already used for fitting/tuning. Collection names alone do not establish independent sessions. Button callback uptime supplies jaw references, without physical-edge or clock-alignment verification. Preserve `complete:false` and other quality flags and account for source versus encoded intrinsics. Deposit outcome labels do not supervise jaw timing.
- `metadata/dataset.json` selects the active prediction manifest. `audit/runs/<run-id>/` and `audit/verification/` preserve history. Old absolute paths inside historical logs are evidence, not current runnable inputs. Existing jaw runners need a manifest adapter for current reference paths, with output manifests under `working/runs/`.

Read each collection README and `/Users/ericlabouve/.codex/worktrees/96fa/main/ml/label_review/dataset-format.md` for the full contract. The Data Reviewer helper implementation in that worktree was uncommitted at handoff, so verify before reuse. This handoff authorizes preserving storage context, with new training or canonical data changes requiring a separate assignment.

## Maintain this memory

Update freely and frequently when user preferences, architectural decisions, measurements, failures or blockers materially change the work. Ordinary in-scope memory edits need no separate approval. Replace superseded state, date evidence, retain consequential failures, and link detailed records rather than copying logs. Distinguish tested capabilities from proposals. Mention material changes briefly in task handoffs; avoid churn without new durable information. Never store credentials, frames, weights or raw masks here. Memory updates do not authorize unrelated implementation or automatic commits/pushes.

## Preferences and semantics

- November 26 latest restart approved: eight starting parents (explicitly drop bottom two by current validation fitness), two fresh researchers, six agent slots, at most two memory-heavy fits,20minutes per started agent, test reserved. Implemented conservative kernel flock-v1 cap for ALL TrainingMonitor fits, including baseline/noniterative fits; hashed leases are audited for slot overlap. Trial timers start after permit acquisition; waiting still counts against the author's wall allocation. Source review must confirm no fitting before/outside monitor and no full private frame copies. Memory monitor samples system pressure/compression/swap and owned RSS every30seconds outside the agent-writable job. Fresh critical pressure delays new fits; active work is not killed. Future curves use paired measured train/validation objective losses each epoch, mark selected checkpoint and warn of falling train/rising validation loss; noniterative methods get no invented curves. No new round is launched until code checks and the explicit top-eight checkpoint are ready. Historical ten-parent R50 remains preserved.

- Restart preparation checks passed71shared/runtime/resource tests and88dashboard tests (159total), JS syntax and diff checks. Actual short-process tests verified six agent slots, queue clocks, at most two fitting locks across four processes, lock release after termination, critical-pressure admission pause/recovery and training-lease audit/tamper rejection. The Mac memory sampler reported normal pressure before launch. Keep resource logs in .resource-monitor and use actual new training/validation histories; do not infer curves from scores or claim these controls eliminate overfitting.

- November 26 next-round correction after cancellation: user explicitly authorizes dropping the two lowest-fitness current R50 parents BEFORE the next round, leaving8 starting parents; this supersedes the earlier reproduce-all10 transition for the next restart. Preserve original R50 evidence and record any derived trimmed checkpoint/provenance; do not silently overwrite the historical result. With2researchers the next author cohort is10, not12, and requires10independent candidate reviewers. The user requested RAM assessment before restarting; round remains cancelled/paused. Host check:16GiB physical RAM, about24GiB swap already used, prepared train/validation pickle files total2.08GiB; no current10-fit peak-memory benchmark exists. Duplicating the full cache per process would exceed physical RAM at10copies. Recommend distinguishing lightweight agent work from memory-heavy fitting and measuring peak working sets before permitting all10simultaneous fits; no concurrency/training-limiter implementation or new run is authorized merely by this assessment.

- November 26 full Round52 authorized: restore dashboard minutes default20 after the successful two-minute smoke. Run exactly one full All families round on beach/home/park, all304 clips, seed0 and the unchanged182train/61validation/61reserved test split. Keep pool8, research2, reviewers1per challenger, concurrency3, protected2/opportunities2/familycap2 and80%jawF1/20%speed. Current official R50 has10 parents: all10 must reproduce once before selecting up to8; add2fresh proposals and12fresh independent review tasks (24 author/reviewer tasks, plus coordinator). Keep test reserved, serial deployment scoring after fitting, immutable provenance and finish-v1 exports. Monitor real progress and final publication audit; no automatic extra round.

- November 26 smoke PASSED: dashboard-20261126T215406Z-198a1472 completed six independent supervised agents (one parent, two researchers, three fresh reviewers), four newly measured serial native train/validation replays,15 native probes, training/portfolio audits and the real outer-worker completion gate. Independently reverified publication afterward, including private-ledger binding, all three approved reports and zero overlap of smoke train/validation with the original61 reserved test clips. No test predictions/media were used, no full round or official-pool promotion; R50's10-member pool remains the checkpoint. The smoke's four-model subset/three validation clips do not establish generalization. Defaults remain2minutes for smoke; increase deliberately for real research. Report-export preflight and shared writer worked live; no reviewer format-correction resume was needed (that path is regression-tested). Independent readback found writer/reader mismatch: supervised receipts include agent_runtime, but reader expected only legacy keys. Fixed exact required-key set to require that ledger for supervised jobs; hashes/missing-ledger checks remain enforced. Regression65 shared+87 dashboard tests passed (152 total), including full receipt readback and ledger tampering/missing cases. No original failed-run reports, identities or verdicts were edited.

- Smoke history integration: the chart reader expected the old evaluator-source/sha256.json, while supervised workers pin protected-source snapshots. Added a verified-source fallback retaining legacy support and exact hashes/context separation. Independent history replay now includes successful isolated R51, so next round is52; official R50 remains unpromoted. Regression65 shared+88 dashboard tests passed (153 total). This changes result readback/presentation, with no new agents, fitting, measurements or evidence edits.

- November 26 full report-contract correction: smoke dashboard-20261126T214246Z-740f00cf again completed six distinct tasks, four native evaluations and15 probes; contrast report used findings objects and extra checks, which the initial partial preflight missed. Keep failure intact. Shared write_review_report now fills exact frozen metadata from reviewer-supplied substantive decisions and validates findings as text, inspection coverage, required check kinds and evidence paths. The jaw adapter pins the five kinds in supervisor config; runtime enforces them before ready. Outer learned-status checks now use the already independently verified frozen bundle, with family heuristics only for legacy incumbents; a new handwritten family is not automatically a fitted model. Regression65 shared+86 dashboard tests passed. Read-only diagnostics on this failed run passed lifecycle, training, deployment and recomputed selection; its invalid report remains rejected, no publication/test access. Next fresh smoke must pass the full unchanged admission process before a full round.

- November 26 report-export follow-up: smoke dashboard-20261126T213038Z-9c8a7549 completed all six distinct agents, four new serial native evaluations and15 native probes; all review bundles passed preflight. Final audit still blocked because contrast reviewer wrote candidates[0].candidate as a name string rather than full frozen record. Preserve that failed evidence; no promotion/test evaluation. Supervisor now preflights final report structure before ready and allows one same-context export-only packaging correction under finish-v1. Original report and substantive decision/probe fields are hash-bound; formatting repair cannot change rejection to approval or redo review/research. Outer timer accounts for this actual reviewer export time too. Dashboard progress bar/status moved above Population & agents as user requested. Rerun smoke before any full round.

- November 26 user correction supersedes hard author-export cutoff notes below: do not cut off an agent already exporting. New dashboard jobs freeze agent_export_completion=finish-v1. The research/export cutoff remains enforced, with the same identity; export-only packaging may finish beyond the nominal allocation, with no new fits/research/search. Reviewer deadlines stay hard. Outer coordinator timeout excludes the union of actual supervisor-owned author export intervals, including active exports, so it cannot kill export indirectly. Cancellation and real process failures remain effective. Historical jobs without the flag retain prior hard-deadline semantics. Shared budget_policy now supplies the supervisor and audit (removing a duplicated calculation caught by the runtime regression). Verified60 shared/runtime tests and85 dashboard tests, including export past deadline, audit rejection of research overruns, and concurrent export wall-time accounting. Rerun the smoke; no full round yet.

- November 26 smoke rerun: user explicitly kept test reserved and authorized rerunning the fixed supervised smoke before any full round. Dashboard minutes default temporarily drops from20 to2 for this check (other reduced population/reviewer settings unchanged); increase it deliberately for substantial model research. A successful smoke is evidence about orchestration/admission, not generalization. Do not launch a full round automatically.

- Two-minute smoke attempt dashboard-20261126T211900Z-5e1ea0d9 exposed too-short CLI export startup: all three authors saved proposals but timed out in their 12-second export turns; lifecycle audit blocked publication, no new native scoring/reviews occurred. Preserve that failed evidence. New settings freeze agent_export_min_seconds=60, capped at half total budget and120seconds; two-minute authors now get60seconds search+60seconds export within the unchanged hard deadline. The supervisor ledger and outer audit bind this setting. Historical jobs lacking it retain the prior five-second-floor policy. No gate or failed verdict may be bypassed.

- November 26 supervised smoke follow-up: committed and pushed accumulated runner/dashboard work at 8cde5db before launching scoped Round51 (Scanlines, 12 clips, one parent/two researchers/three independent final reviewers, 20-minute allocations, concurrency3). Actual early-author continuation and 18-minute export cutoff worked; the independent lifecycle audit verified six distinct tasks and one follow-up. All 15 native streaming probes passed, but all three reviewers rejected duplicate evaluator records in frozen review packages. Admission correctly failed, preserving official R50 and its pool; tiny-subset validation F1=1.0 is diagnostic only. Test IDs were checked for overlap; no held-out test media or predictions were used. Original failed evidence remains in working/runs/dashboard-20261126T203950Z-a40b77aa. New jobs require frozen-bundle-v1 preflight before allocating a reviewer: unique job-local artifact paths, current hashes, required roles, exact candidate scope and frozen context hash. Pin dispatched package hash/graph and recheck against publication; never deduplicate silently or revise a dispatched package. Regression replay rejects all three original bad packages and accepts structurally corrected diagnostic copies without changing original verdicts or promoting models. No second live round authorized automatically after this failure.

- Test-set decision guidance: changing fitness does not itself require consuming test. Select on validation, freeze the model/preprocessing/decoder and then use test for a final report. If a formal jaw-only baseline is wanted before adding deposit, evaluate one preselected frozen champion once, not the pool to choose a winner. Keep the current 61 test clips reserved unless explicitly requested. If test findings guide later tuning or deposit design, that partition is no longer an untouched final test for the resulting model; collect fresh final data. Current random clip splits share capture conditions and cannot establish new-session generalization. Continue reporting jaw and deposit metrics separately when a future composite is agreed.

- Review-package fix verification: 55 shared/runtime/preflight tests and 83 dashboard tests passed (138 total), plus diff checks and replay against the actual failed smoke packages. One dashboard socket test required normal loopback permissions outside the sandbox. This fixes the reproduced packaging failure; a new full live preflight-enabled round has not run.

- November 26 next-run decision: agent_minutes default20 (downfrom30); keep pool8/research2/protection2/opportunities2/familycap2, one reviewer per challenger and parallel3. User explicitly deferred token budgets and agreed to one small supervised smoke round. Commit and push accumulated changes to the current draft PR BEFORE launching that smoke. Use the new settings; a family/clip-limited smoke does not promote the official pool and cannot establish generalization. Do not add deposit to fitness yet; next successful round is intended to precede discussion of a class-balanced deposit/not_deposited objective, its weights and jaw safeguards.

- November 26 cost-conscious dashboard defaults supersede the earlier10/3/3/3/3 settings: pool_size8, research_slots2, protected_slots2, mutation_attempts2, family_limit2. Keep one independent reviewer per challenger. A current10-parent pool still reproduces all10 once, plus2 researchers and12 reviewers (24 author/reviewer tasks); after selecting8, steady rounds have8 children+2 researchers+10 reviewers (20tasks, versus26previously). Never silently prune before the transition. These are agent-count savings, not guaranteed token savings; minutes remains30 and is not a token cap. Recommended before a full run: author token budgets/usage accounting and a small end-to-end supervised smoke round; not implemented/started by this UI/default request. User plans to add deposit/not_deposited fitness after a successful next round; retain current80%jaw/20%speed until new scoring is agreed, and use a class-balanced deposit metric with separate jaw reporting.

- November 26 jaw display: remove completed-round summary and measured-score paragraph while retaining errors/progress and a concise missing-evaluation message. Add an illustrative cue/prediction matching-window SVG on the right of Jaw events, with parameters on the left; tolerance/target labels update live, event types stay separate and each cue matches at most one prediction. Fitness component cards now stack consistently with controls/graphics side by side; narrow phones stack. Current defaults0.5s/0.95F1 and80/20 weights unchanged. Browser checked all five smaller defaults, live graphic changes/restoration, removed paragraphs and18px card spacing without page overflow. 82 dashboard tests plus JS/HTML/diff checks passed. Port8787 restarted idle next51; no new round, training, test evaluation, commit or push.

- November 26 supervised budgets supersede earlier prompt-only minutes/early-author-finish notes. New dashboard jobs require agent_budget_protocol=supervised-v1. A per-invocation stdio evolution_agents MCP supervisor owns child CLI process trees, queue/concurrency and monotonic deadlines; builtin multiagent dispatch is disabled. Clocks start at actual launch. Parent/research early finishes automatically resume SAME thread within original budget, inspect validation failures/try further hypotheses and preserve best completed validated checkpoint; training patience ends a fit, not the assignment. Final10% capped120s is export-only (no new fit); shared deployment export/final serial benchmark remain afterward. Hard deadline stops tracked descendants/process groups with short cleanup grace. Only concrete operational blockers stop authors early; reviewers may finish their checks early. New Family architecture cycles2/3 may renew the same author/reviewer IDs; ordinary feedback cannot renew clocks. Private supervisor ledger/identity streams stay outside job writes; outer worker copies+hash-pins ledger and audits exact identities/prompts/artifacts/times/export evidence; legacy jobs keep old semantics. Runtime best-across-trials selection remains an author/reviewer evidence requirement, not a numeric quality guarantee. Detached/double-fork work is forbidden; this is process supervision rather than OS security containment.

- November 26 Goal verification on Codex CLI0.160.0: persistent app-server Goal automatically ran a second turn and completed; actual codex --no-daemon exec created a Goal but exited after one turn with Goal active; ephemeral threads rejected Goals. Probe goals were cleared and own threads archived. Use explicit supervised exec/resume, no native Goals in these CLI children. Reusable diagnostic ml/evolution/goal_probe.py; evidence /tmp/tmt-goal-probe-persistent and /tmp/tmt-goal-exec-probe. Actual Codex loaded required MCP supervisor and called get_agents once (empty), no candidate agents: /tmp/tmt-runtime-mcp-smoke. Final regression suites passed50 shared/supervisor tests and81 dashboard tests (131 total), plus skill/diff checks. No evolution round, fitting, model benchmark, reserved-test read, commit or push ran; full live supervised round remains unexercised.

- November 26 visual consistency: all eight top-level dashboard sections use the same clean outlined card treatment as Population & agents / Datasets (1px border, 8px corners, 12px padding, matching compact title typography and chevron, 18px section spacing). Preserve collapse behavior and existing defaults. Browser verified equal computed styles, all collapse controls and expanded candidate table rendering without page overflow; CSS/diff checks passed. No round ran.

- November 26 dashboard presentation: every top-level section is collapsible (Population & agents, Datasets, Fitness, Candidates, Leader scores, Video replay, Research Agent, Experiment loop). Preserve prior expanded defaults except Video replay/Research Agent remain closed; nested Breeding & diversity now opens by default. Population and breeding inputs use compact three-column grids, two columns on narrow phones; diagram stays on the right where space permits. Remove both agent-task-count and breeding-policy summary paragraphs; retain live diagram counts and concise parameter tooltips. Browser checked all eight collapse states, parent/nested reopening, unchanged form ownership and parameter values; HTML/diff checks passed. No round ran.

- November 26 candidate-scoped reviews supersede the shared final-reviewer settings below: new jobs bind review_protocol=per-candidate-v1; Reviewers per candidate defaults to 1 (range 1–5). Each frozen challenger gets that many fresh independent agent identities/contexts, with exactly one assigned candidate each; never reuse authors, architecture reviewers or another candidate's reviewer. Spawn without inherited conversation; use the same rubric, frozen implementation/model/evaluation evidence and native probes, without peer verdicts. Exact assignment/report coverage, current hashes and every assigned approval are required; no extra stale challengers may slip into the reviewer workload. Legacy shared-review jobs retain their saved audit semantics. Default 10 parents + 3 researchers means 13 challengers + 13 final review tasks, or 26 author/reviewer tasks plus the coordinator; concurrency controls batching. Dashboard reserves a right-hand vertical flow diagram with live counts in Population & agents (stacks on narrow screens), nests expandable Breeding & diversity there, and nests Jaw events + Speed score inside Fitness with weights always visible. Evolve skill, shared briefs and component READMEs carry the new rules. Verified 76 dashboard tests, then 11 integrity tests after final protocol-downgrade guard; 18 shared tests, JS/HTML/skill/diff checks passed. Independent code review found no blockers. API/browser checked default and New Family counts, restored default1/All families; port8787 restarted idle next51. No live round, training, test evaluation, commit or push ran. Fresh-context receipts cannot prove model-context isolation; actual live new-protocol execution remains untested. Adjacent pre-existing New Family family-name whitespace normalization issue was noted but not changed.

- November 26 dashboard grouping: put clip limit (0=all) and seed inside Datasets beside train/validation/test split controls. Group pool size, research agents, final reviewers, minutes per agent and parallel agents under Population & agents (the user found Round configuration too broad); contextual architecture review stays with that group. Keep start/family/round prompt in the toolbar. Preserve form names, defaults and behavior. Browser-checked form ownership and live split/count updates; no round started.

- November 26 full-pool reproduction supersedes ALL earlier top-X/starvation notes: remove Evolution agents top X from the dashboard and new settings. New jobs require reproduction_protocol=all-pool-v1; every current retained member gets exactly1 changed child and1 distinct parent-agent receipt per ordinary All families round, including low-ranked/protected members. Family-filtered checks reproduce every scoped candidate (preserving evaluated-proposal re-entry); New Family remains research-only. Pool size is NEXT survivor capacity: after lowering it, all current members still reproduce in the transition round, then the smaller next pool controls following rounds. Research count adds fresh proposals; parallel agents controls concurrency. Defaults now dispatch10 evolution+3research+2final reviewer child tasks (15 total plus fixed coordinator). Worker budgets/preview counts use actual full scope. New API rejects obsolete evolution_agents; historical runs retain old top-X verification. Updated evolve skill and shared/domain READMEs. Verified70 dashboard tests and18 shared tests, plus targeted19 agent checks after final guard adjustment; skill/syntax/diff checks passed. Port8787 restarted idle next51; no new training/evolution/test evaluation, commit or push. This resolves reproduction starvation in completed ordinary All families rounds.

- November 26 breeding controls: dashboard now exposes protected_slots (3, range0–9), mutation_attempts (3, range1–20), and soft family_limit (3, range1–10). Effective protection is capped at available pool minus1 for champion; effective family cap at pool size. Lowering/disabling protection trims strongest eligible inherited lanes, and attempts count actual children, not rounds. At most1 fresh idea receives new protection per round: least represented reviewed family, then additional per-clip F1 beyond champion, then normal ranking. New jobs require portfolio-v1, use dashboard_selection.select_evaluated, and independently replay admission from per-clip metrics recomputed from saved validation detections; verify next_pool, protected counters, roles and limits. Family names are normalized and pinned to prior identities, including fallback identities. These fix stale/fabricated coverage, family-collapse and smaller-pool/disabled-protection inconsistencies; historical R50 is not reselected. Separate agent review found no blockers; 67 dashboard tests and18 shared tests passed, syntax/diff checks passed. Local port8787 restarted idle, next51; API/browser verified knobs and bounds without starting a round. Protected-lineage scheduling starvation is STILL unfixed: reserve reproduction slots or rotate protected parents is recommended, not implemented. No new training, test evaluation, commit or push.

- November 22 approved agent-training workflow: adapt autoresearch principles within existing ml/evolution, not replace the runner or import CUDA/LLM/infinite-loop/git-reset behavior. New dashboard jobs require validation-checkpoints-v1. Shared TrainingMonitor predeclares hypothesis/objective/capacity/regularization/seed/resources, journals every attempted fit including crashes, records both inference-mode losses and validation event F1 each epoch, preserves the best F1 checkpoint (loss then earlier epoch ties), and stops for patience/time/declared epoch ceiling. Defaults: patience10, min_delta0.001, min_epochs5, per-trial cap300s or shorter owning agent allocation; no mandatory100 epochs. Domain completion independently recomputes epoch F1 and checks selected model/hash/split/stopping/journal evidence; reviewers inspect actual training and exemptions. New protocols cannot bypass the checks; legacy jobs remain readable. These measures address overtraining but cannot guarantee generalization or eliminate adaptive validation overfitting. Final F1/p95 still come from the same deployment artifact; test remains reserved. Code and contract: ml/evolution/training.py, dashboard_training.py and shared README. Verified 59 dashboard, 18 shared, 3 deployment and 6 phone benchmark tests (86 total); no live new-protocol agent round has run. Dashboard port8787 restarted idle, next51, preview contains new instructions, top-two historical loss overlays unchanged. No new model training/evolution, commit or push for this workflow change.
- November 22 breeding review: current dashboard preserves a portfolio champion, protected leads (up to3, at most1 new lane/round), a useful jaw specialist and complementary per-clip coverage with soft family cap3; parent and child may both survive. Defaults remain pool10/evolve top7/research3. Protection expires after3 actual child attempts, not3 rounds. Top7 scheduling can starve weak protected lineages indefinitely; reserve protected reproduction slots is proposed, not yet changed. Suggested advanced parameters: protected slots/opportunities and soft family cap, each default3. Do not describe the older plain-selector minimum-gain parent replacement as current portfolio admission. No automatic weight crossover.

- Dashboard weight placement, November 22: jaw weight and derived speed weight stay visible inside the fitness card above its collapsed equation, superseding their placement in the event/speed parameter groups and hiding them in the disclosure. Full definitions still expand separately.
- Expanded model cards plot recorded epoch training and validation loss where applicable. Never invent curves from final F1 or show decoder sweeps/tree counts as training loss. Historical R50 multiscale Temporal MLP has 100 recorded training minibatch weighted-BCE points (dropout/noise active), no saved validation loss; other old neural models lack histories. Bind histories to exact candidate configuration and frozen model, hash-check explicit evidence, and label absent series. Agent briefs now require both loss series under the same objective, validation without gradients/dropout/augmentation and no test access. Curves do not change deployed event F1, fitness or stopping rules. Detailed contract: jaw-trigger README and dashboard_losses.py.
- November 22 top-two loss diagnostic supersedes their missing-curve status above: reproduced the original fixed 100-epoch asymmetric Temporal state and multiscale Temporal MLP fits on the same 182 train/61 validation clips. Both regenerated frozen models exactly equal R50 parameters; multiscale also reproduced all 100 old noisy minibatch-loss points. New train/validation weighted BCE is measured after each epoch in eval mode without dropout/input noise, preserving training RNG state; do not compare its train series as if it were the older noisy minibatch objective. Both show training loss decreasing and validation loss increasing (overfitting evidence, not a new event-F1 score or selected epoch). Evidence: dataset working/runs/loss-curves-r50-20261122/; hash-pinned training-loss-current.json overlays exact checkpoint curves in the dashboard. No pool/decoder/benchmark changes, new evolutionary round or test-media evaluation. Reusable diagnostic CLI: record_top_loss_curves.py; current API overlay verified by 46 dashboard tests.

- Dashboard parameter organization, November 22: group event-specific controls by predicted event set. Current Jaw events · squeeze & release contains tolerance, target validation F1 and jaw fitness weight. Both speed bounds use frame fractions on one two-dot slider (full credit 0.25, zero credit 1.00 by default). Derive target fps and hide its input when selected datasets share a known source cadence; user-approved 57–63 fps (60 ±5%) normalizes to 60. Mixed/unknown rates expose a manual scoring rate (60 default), without resampling. Use manifest capture-source intervals, not container average/base rate or experiment subsampling. Metadata/header-only audit: beach 242 clips and home 5 at nominal 60; park 29 at 30 and 28 at 60. No frames decoded or test scores computed for this audit. 1.0 frame = 16.667 ms at 60 fps, 33.333 ms at 30 fps. Keep fractions fixed when fps changes. Save target_fps/full_speed_frame_fraction/zero_speed_frame_fraction plus derived full_speed_ms=full_fraction*1000/fps and frame_budget_ms=zero_fraction*1000/fps; server rejects contradictory representations and keeps legacy ms-only API compatibility. Slider supports drag/keyboard/track clicks and ordered bounds. Place the credit graph and shared slider to the right of other speed parameters to save vertical space; stack on narrow screens. Default scoring, prior results and event types remain unchanged.

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

Current scoring preference, November 22: final deployment-representative benchmarking supplies BOTH F1 and performance. Research, fitting and provisional evaluation may freely use Python/NumPy/PyTorch/Hugging Face. Do not require C++ for every proposal; exported Core ML/native/ONNX Mobile/ExecuTorch/TFLite/Metal artifacts are allowed. Use a shared export/final-benchmark stage outside each proposing agent's research window. Only the real frozen deployable artifact, preprocessing and decoder may produce final train/validation event predictions and latency. No mixing prototype F1 with native p95. New dashboard jobs require benchmark_protocol=deployment-v1 and exact hashed reports/traces for every evaluated incumbent and challenger. Final reviews cover that same deployment bundle. Laptop execution is a disclosed deployment-runtime surrogate; physical-phone validation remains periodic, not after every round. Historical prototype scores stay separate; unsupported/unexported prototypes cannot gain final scores. See deployment_benchmark.py and the jaw README.

Native laptop evidence, November 22: same detector header SHA-256, OpenCV 5.0, six phone fixtures and three serial measured passes gave leader p95 0.0744 ms on M1 Pro versus 0.0600 ms on iPhone; all events/scores passed parity. Paired evidence: dataset working/runs/laptop-native-pool-r50-20261122/. User then required updating every retained candidate using final-deployment models: replayed unchanged native artifacts across all 182 train/61 validation clips with warmup and three serial passes, 20,991 measured validation frames per candidate. Native F1 matches prior scores for all ten; full-validation p95 0.0495–0.0777 ms for visual/model methods, <0.001 ms for IMU. Leader p95 0.077708 ms; validation F1 0.823529, train F1 0.991690. Suite 69.25 seconds including warmup/training replay/loading, nominal thermal and low-power off. Normal working laptop on battery with Docker VM active; no concurrent fitting/build. Evidence: working/runs/deployment-pool-r50-20261122/. The hash-pinned deployment-evaluation-current.json supplies current table F1/fitness/laptop p95 and a separate runtime-context chart; original R50 artifacts and official genetic pool are preserved. No new evolution, fitting, test-media read or retroactive streaming approval. Expanded cards retain the paired six-clip laptop result; phone timing stays on six clips. Source CLI: prepare_deployment_replay.py, iphone-replay/mac_main.mm/CMakeLists.txt, score_deployment_replay.py.

Deployment-scoring verification: 37 dashboard tests, three deployment-contract tests, six native-benchmark tests and six shared evolution tests passed; JavaScript syntax, Python compilation and diff checks passed. Browser verified all ten native laptop values, native-derived train/validation F1, reserved test, explicit runtime scope, separate deployment chart context and Start Round 51. Laptop p95 below 0.001 ms displays as an upper bound, not zero. These prepared-frame CPU timings exclude capture/decode/resize/loading; physical-phone timing still uses its six-clip comparison. No new fully agent-guided deployment-v1 round has yet completed; only the existing pool was rebenchmarked.

Current integrity policy, November 22 (supersedes earlier reviewer-only-for-New-Family notes): every dashboard round must finish with configurable independent Final reviewers, default two, minimum one, maximum five. These reviewers are separate from the early New Family architecture reviewer and from all proposal authors. Every challenger requires unanimous final approval of exact code/model/configuration hashes plus timestamp-origin, variable-prefix, persistent continuous/chunk-equivalence, long open/closed negative-stream and future-causality numeric evidence. Freeze settings, training/validation membership and evaluator hashes into review context. Missing/rejected/stale evidence blocks publication and preserves the prior pool. Server publication and chart history reverify an outer-worker completion receipt and trusted launch registration; coordinator status or self-stamped approvals do not suffice. Bounded mutation CLI runs are diagnostic only and cannot publish a formal pool. All research/evolution briefs must explicitly forbid reward hacking. See jaw README and dashboard_integrity.py for the evidence contract; these checks reduce risk rather than formally proving arbitrary code execution or reviewer honesty.

November 22 audit: no explicit three-second or future-label shortcut was found in inspected candidates, but a deliberately invalid clock-only control scored 1.000 validation F1 (close at 3 s, open at duration minus 3 s). Existing detectors initialize references/history/open state per clip; these scores do not establish nonstop operation. Preserve historical candidates as legacy_unreviewed and display clip-replay scope. Current scoring remains clip_replay-v1; integrity approval is not continuous-stream accuracy certification. Actual native probes across all 61 validation clips passed timestamp-origin shifts and future truncation for four temporal methods. Idle insertion moved winner F1 0.8235 to 0.8116 (false triggers 38 to 42), showing initialization/transient sensitivity, not proof of intent. Reports/scripts: dataset working/runs/integrity-audit-r50-20261122/. No new evolution round or reserved-test replay was requested or performed. Next model work needs persistent frame-step inference and a realistic continuous evaluation protocol before a nonstop-readiness claim.

Integrity gate verification: 36 dashboard regression tests and six shared evolution tests passed, including executed synthetic native streaming probes, contradictory evidence, stale artifacts, independent reviewer identity, missing/rejected approval and forged-publication controls. Browser verified default two Final reviewers, zero rejected, separate early Architecture review in New Family mode, historical Unreviewed · clip replay disclosure and Start Round 51. Dashboard restarted idle on port 8787. No fully agent-run gated round has yet been exercised; do not describe the gate as live-round validated until one completes.

R50 physical-phone timing, November 22: all ten retained candidates now have native Release C++/Accelerate/OpenCV CPU replay timings on iPhone 15 Pro / iOS 27.2.1. Six frozen validation clips, 705 frames, identical inputs, full warmup then three measured passes with rotated candidate order; run one candidate at a time and verify non-overlapping uptime intervals. Each candidate has 2,115 measured frames; all Python events match and max score discrepancy <0.000004. Nominal thermal state throughout, no foreground interruption or low-power mode; complete suite with warmup 1.09 s. Winner p95 0.0600 ms; other visual/model methods 0.0354–0.0625 ms; IMU-only methods <0.001 ms, timer-limited. Scope includes prepared-frame features, raw IMU alignment, frozen model and decoder, excludes camera/decode/resize/load/warmup. These native CPU ports differ from laptop NumPy execution; no claim of live throughput, generalization, continuous accuracy or integrity approval. No fitting, new round, fitness change or reserved-test read. Code: prepare_pool_replay.py, iphone-replay/pool_runtime.hpp and pool_main.mm, phone_benchmark.py. Evidence: dataset working/runs/phone-pool-r50-20261122/. Hash-pinned phone-timing-current.json supplies exact-checkpoint measurements to dashboard; refitted results invalidate them.

The RSI dashboard runs through `ml/experiments/jaw-trigger/dashboard_server.py` on loopback port 8787. Start Round defaults to `agent_guided`, launching a sandboxed local Codex coordinator with researchers and parent-candidate subagents. New Family requests a novel architecture plus independent review. On November 21, one live New Family round with one researcher and one reviewer completed and passed both its worker audit and an independent replay of the receipt audit. Job `working/runs/dashboard-20261122T035257Z-20c4923c` under the dataset root evaluated ten training-refitted baselines plus one Extra Trees proposal on the pinned 182 train / 61 validation / 61 reserved test split. The proposal scored 0.8176 train F1, 0.7094 validation F1 and 0.3187 ms laptop prepared-frame p95; the best incumbent scored 0.7529 validation F1. Initial architecture and final implementation reviews accepted; no rejection/revision loop was needed live. This family-scoped check did not promote the official pool. Old fitting F1=1.0 is not comparable to these validation results. Bounded mode remains an explicit internal diagnostic, with no automatic fallback from agent mode.

Live launch fixes: `--approve-for-me` already selects workspace-write and cannot accompany `--sandbox`; the strict final schema requires every property, with failure_kind='none' on success. An initial coordinator searched the account home for Python environments, likely triggering MacDroid/iCloud access prompts, and was stopped. Supply the exact known runtime/dependency overlay in coordinator and child instructions; prohibit discovery through home, Library, personal/cloud folders and unrelated worktrees/integrations. Missing runtime dependencies must be an operational blocker, not a reason to scan elsewhere. Do not ask the user to grant iCloud/personal-file access for this work.

The dataset checklist selects frozen beach/home/park inputs. Defaults select all 304 episodes and record a seeded random 60/20/20 split (182 train, 61 validation, 61 test), following the user's requested exploratory split despite shared capture conditions and overlaps. Refit learned candidates on training only, select on validation and keep test out of evolutionary selection. Controls expose family, clip limit, pool size, scoring/timing settings, researcher slots, minutes per candidate (default 30) and child concurrency (default three). Job receipts, predictions and timings are audited before publishing results under the dataset's working/runs. Subset jobs preserve official history. Controls, tooltips, dataset counts and fitness layout were browser-checked without starting another agent round.

The dashboard title is Evolutionary Phone Model: current candidates predict events rather than choose actions. An optional per-round research prompt is stored in settings and forwarded verbatim to every child; completion verifies saved child prompt files contain it. The Research Agent section previews the launch prompt template and discloses configured tools, harness and project instructions. Previewing does not start a round. Fitness defaults to a collapsed equation with full definitions on expansion.

November 21 score presentation: use event F1 for train/validation/test columns; keep composite fitness in expanded details. The user explicitly chose to keep test reserved until model selection is frozen. The current seed-0 split has measured train/validation scores for all ten unchanged pool models from the successful family-scoped check, with Test shown as Reserved. Current leader: 0.986 train F1, 0.753 validation F1, fitness 0.802. A changed dataset/seed/scoring setting clears mismatched values. The validation leader chart groups audited jobs by snapshot, exact partitions, seed, scope, scoring/timing settings and evaluator hashes, recomputes each leader's fitness from measured F1/p95, and excludes the old in-sample curve. Family-scoped checks are labeled isolated and do not promote the official resume pool. These context fingerprints govern score presentation, not automatic search-pool promotion or a new parent-selection policy. Tested with 22 dashboard tests and browser checks including seed change and restoration.

Dashboard agent allocation, November 21: each research agent implements exactly one independent fresh proposal; the configurable research count defaults to three. Evolution uses the top X retained candidates by last measured fitness within the chosen family (default ten, capped by availability); retained pool size is a separate setting. Research can explore other families. New Family runs zero evolution agents, one distinct new-family proposal per research agent and one separate architecture reviewer. The UI discloses evolution/research/review counts; the fixed single coordinator is hidden from parameters. The reviewer and owning researchers exchange feedback and revisions through the coordinator, retaining the same identities and one proposal each. Accepted proposals may finish early; unresolved proposals require at least three proposal/revision–review cycles before architectural failure. Save versioned proposal evidence, feedback prompts and review verdicts; audit exact final-candidate approval, revision evidence and the minimum cycles on architectural failure. Operational blockers may stop earlier honestly. The deadline includes these passes. These rules are receipt-tested, not yet live-agent validated. The audit requires one distinct research receipt per evaluated proposal. These settings supersede historical one-researcher/three-idea allocation for dashboard rounds. No live training round was requested for this allocation change.

Continuation correction, November 21 (supersedes the earlier isolated-check/default-ten notes): the user expects completed New Family rounds to count and their researched families to remain discoverable. The completed full-dataset R49 is now the resume checkpoint, and the next round is 50. Full-dataset New Family and all-family jobs advance the checkpoint; family-filtered/clip-limited checks remain separate but consume round numbers. Evolution top X now defaults to seven. Review-agent controls and their count are hidden outside New Family. Available families come from saved candidate metadata across retained and evaluated proposals. Extra Trees was not retained by the portfolio selector; it is now visible as an evaluated non-retained proposal (train F1 0.818, validation 0.709, p95 0.319 ms). Selecting Extra Trees explicitly can re-enter that evaluated proposal for evolution; All families still evolves the ten-member retained pool. This fixes discoverability without silently changing retention policy. No current dashboard Test action exists: freeze a checkpoint and replay the 61 reserved test clips without fitting, decoder tuning or evolutionary selection when the user asks. No test evaluation or new training was launched for these controls. Verified by 24 tests and browser checks.

Selector correction, November 21 (supersedes Extra Trees' non-retained status above): all three protected lanes were occupied, and the shared portfolio code incorrectly omitted fresh ideas from ordinary competition. Fixed `ml/evolution/portfolio.py` to make ideas eligible regardless of protection availability, with regression tests for full/disabled protected slots. Replayed only selection from unchanged R49 measurements: Extra Trees is now fourth by fitness and retained in the ten-model pool, replacing the lowest-scoring pose-aware HOG model. Current continuation is the same job's `results-selection-corrected.json`; `selection-correction.json` records the source and selector hashes. Original results/evaluation/weights remain intact; no training or test-set read. Next round remains 50. The compact one-row round prompt flows with other parameters and can be resized. Fixed stale Failed to fetch status after reconnecting to the same completed round; browser-verified server restart cleared the error and preserved datasets. Retention correction is a selector bug fix, not a change to protection quotas or fitness weights.

Round 50, November 21: user requested four evolution agents plus one researcher all in parallel. Raised the allowed child-concurrency maximum from three to five, retaining default three; dispatched exactly those five tasks. User explicitly requires comparable speed measurements: final replay one candidate at a time, same runtime/input preparation/timing scope, after all fitting stops. The coordinator enforced separate fit and replay phases and explicit timing grants. Job `working/runs/dashboard-20261122T043156Z-2a4799fe` completed on the unchanged 182 train / 61 validation / 61 reserved test seed-0 split. Independently verified receipts for four parents and one research proposal, all 15 evaluated candidates, and six non-overlapping replay batches after all six recorded fitting logs ended (`independent-timing-audit.json`). New leader asymmetric temporal confirmation: train F1 0.9917, validation F1 0.8235 (112 matched, 38 false, 10 missed), fitness 0.8588, laptop prepared-frame p95 0.1889 ms. Prior leader validation F1 was 0.7529; all four children improved over their respective parents. Fresh prototype-distance proposal scored 0.4527. Target 0.95 unmet; test untouched. Official continuation is R50, next button R51; no extra round launched. Fixed history reading both basename/repository-relative source hashes and summary counting incumbents as well as retained/new entries; chart now joins R49 and R50 in the same evaluation context. Dashboard and shared-runner suites passed 25+6 tests; browser verified values and reserved test columns. No commit/push performed for this run.

Read `ml/experiments/sam3/README.md` for setup, benchmark commands and detailed evidence. Runners are in `sam3_lab/benchmark_cutie.py`, `sam3_lab/benchmark_sam2.py`, `sam3_lab/benchmark_tracker.py`, `sam3_lab/benchmark_compare.py`, `sam3_lab/flow_experiment.py`; viewer sampling/export is in `video.py` and `viewer.py`. Use the component uv environment or `.venv/bin/python`, fresh output directories, and sequential GPU runs when timing. Cutie source/weights/isolated dependencies are under ignored `ml/data/cutie/`.

HF authentication and SAM 3 access were previously established; verify relevant operations without exposing credentials. Servers/tabs are transient: check before claiming availability. Keep videos, frames, weights and local environment files out of Git. `ml-agent` was pushed at `c874bf6`; inspect current Git state. This memory does not authorize merge/rebase or future commits/pushes.

One-second baseline, 2026-11-06: six usable anchors from nine fresh SAM 3 calls on the positive clip, using the known yarn prompt (no Agent). All 249 frames exported; mean visible Dice 0.9657, p10 0.9549, 0/54 empty-frame false positives, 89.26 seconds processing (2.79 FPS), 100.25 seconds including startup. The last visible frame was still missed. Artifacts: `ml/data/cutie-benchmark/2026-11-06/sam3-1s-positive/`. This is not a controlled comparison to the earlier supplied-seed run.

Forward-after-first comparison, same clip and pixel-identical SAM 3 outputs: 243 Cutie predictions instead of 388, 68.68 seconds processing (3.63 FPS; 23% less time) and 77.18 seconds including startup. Measured: SAM 3 24.51 s, Cutie forward 20.86 s, backward 2.96 s, seeds 0.70 s. Mean visible Dice 0.9636, p10 0.9534, same two visible frames below 0.80 and 0/54 empty-frame false positives. Largest frame-level drop: frame 58, 0.969 to 0.915. Artifacts: `ml/data/cutie-benchmark/2026-11-06/sam3-1s-forward-positive/`. This speed/quality tradeoff is measured on one clip, not a generalization claim.

Follow-up branch/PR: verify subscription-backed authentication with image input, then evaluate Agent review of SAM 3 anchors without an object name. Later tackle capture relevance, grasp/release timestamps and deposit-based labeling with uncertainty review. Defer further anchor-schedule optimization until more reviewed clips are available. No custom training.


## Round 52 six-agent restart — 2026-11-26

User authorized starting with the best eight R50 parents (drop the bottom two
acceleration candidates), two researchers, six concurrent agents, at most two
concurrent fits, twenty minutes per started agent, and test reserved. Preserved
R50 and recorded the manual trim in working/runs/pool-trim-r52-20261126T223521Z/.
The full restart working/runs/dashboard-20261126T223554Z-54cc26ea is FAILED
admission, not a new official pool: all ten authors, eighteen serial native
train/validation evaluations, ten fresh reviewers and fifty integrity probes
finished. All reviewer verdicts approve their candidate's structural evidence,
but twelve temporal-fusion training trials saved positional prediction lists
where the unchanged canonical receipt checker requires clip-keyed objects.
The other eighty-nine completed fits pass that checker. Do not rewrite the
frozen receipts, override the failed gate or promote the unadmitted pool.
The original eight-parent trim remains the dashboard checkpoint.

Unpublished native leader: absolute temporal fusion, train F1 0.903475,
validation F1 0.877470, p95 0.135625 ms, fitness 0.901976. Its malformed training
receipts block admission; do not treat this as an audited champion. Best
clip-replay accuracy is still below the 0.95 validation goal. The 182/61/61
seed-0 partition remains unchanged and test predictions were not generated.

All 101 completed fitting leases passed the concurrency audit, observed peak
two. Root memory watcher saved 123 samples at 30-second intervals: maximum
tracked agent RSS 3286 MiB (shared pages may overlap), maximum kernel pressure
2/warning, no critical event, maximum swap 10971.62 MiB (includes preexisting
system swap). The watcher measures supervised agent trees, not every Mac app
or coordinator benchmark child; do not report its RSS as whole-machine usage.

Saved 73 paired iterative loss histories (1906 epochs), preserving failed and
overfit trials. Post-epoch train/validation objective losses use the same
inference-mode calculation; checkpoint selection remains validation event F1,
then lower validation loss, then earlier epoch. Real curves show widening gaps
in some baselines. Losses alone do not prove independent generalization and
new screenshots/plots must disclose that this run failed admission.

After worker exit, tightened TrainingMonitor.observe to reject empty/non-object
validation prediction containers or blank/non-string example IDs before writing
an epoch/checkpoint. This addresses the late-found schema failure for FUTURE
fits, preserves existing immutable evidence, and does not waive domain
membership/F1 checks. A regression test verifies same-allocation correction
without saving a malformed epoch. Do not start another round without user
authorization.


## Independent R52 audit and retry preparation — 2026-11-26

An independent audit reproduced89valid/12invalid training receipts, checked all18
exports equal their selected parameters and found no test IDs in saved predictions.
P04 reviewer used a weaker custom checker, so its approval missed the schema error.
All73iterative histories/1906epochs have real paired losses;72patience stops and
1epoch-cap stop. Gaps mostly reflect genuine overfitting. P07's weight-mass scaling
changes validation data loss by2.3–2.7%, insufficient to explain the large gaps;
class-balanced evaluation is legitimate when explicit. Separate data loss from
regularization and do not change event-F1 checkpoint selection to make curves pretty.
The example plot previously used exploratory p02-absolute; exported P02 child is
p02-compact8, selectedepoch13. Corrected plot resolves evaluation.training_receipts
and verifies exact model hashes. Dashboard long objective labels (>150characters)
silently hid three selected histories; expanded bounded label support to2048.

New trusted jaw make_training_monitor wrapper checks exact canonical-JSON IDs,
close/open schema and recomputed F1 before immutable epoch/checkpoint writes.
Tuple events/JSON-compatible NumPy timestamps serialize consistently. Public
preflight_training_trial reuses the canonical checker while peer fits are open.
Supervisor review_preflight_command requires the FULL canonical training gate to
pass before allocating a final-review task (no slot spent on failure). Final
publication gates remain unchanged. Optional shared NumPy binary_data_loss helper
reports sum(weight*BCE)/sum(weight), sample count and weight mass. Measurement
notes preserve weighting/masks/offsets and penalty treatment; other objectives
remain allowed. Independent follow-up review found no remaining must-fix issue.
73shared and96dashboard regression tests passed (169total).

User now authorizes a light smoke and then ONE full retry after fixes/smoke pass.
Keep eight parents/two researchers/six agent slots/two fitting slots/twenty minutes
for the full run, original182/61/61seed0 split,80%validation jawF1/20%speed,
0.95validation target and reserved test. Smoke is scoped and cannot promote the
official eight-parent pool. No extra full round beyond that authorization.
Detailed independent report, per-receipt audit and corrected plot/provenance are
under working/runs/audits/round52-20261126/, outside Git.


Audit smoke dashboard-20261127T003502Z-7ce6ed0e failed honestly before native
scoring/reviews: coordinator supplied a temporal-model scaffold to the Scanlines
parent author. Two completed iterative fits passed canonical receipts, wrong-ID/
wrong-F1 prewrite tests and selected-loss recomputation, but they are the wrong
lineage and cannot be relabeled/promoted. Preserve evidence. Supervisor now
automatically appends the full frozen parent candidate to every parent assignment
and records it in its private ledger; authors must check exact name/method/
genotype before fitting, rather than trust a borrowed scaffold. A focused
regression verifies a conflicting prompt cannot omit that authoritative object.
Retry the light smoke with the exact Scanlines parent and its parent03 source
explicitly pinned, then proceed to the user-authorized full round only after
canonical publication succeeds. No change to split, scoring or agent budgets.


Audit smoke follow-up: dashboard-20261127T004250Z-81fc480e preserved a blocked
parent: the two-minute/60-second-search budget ended before fitting. Increased
ONLY smoke allocation to5minutes; full remains20. Scanlines baseline is genuinely
closed-form ridge and must stay noniterative; the child tests real epoch curves.

Smoke dashboard-20261127T004841Z-d66e533e completed4independent tasks,3serial native
evaluations and10native probes. Canonical training/fit/deployment/budget/review/
portfolio gates pass, with selected-checkpoint loss recomputation exact. Original
outer audit rejected only an overlong differentiator. Trusted presentation-only
recovery backed up original results/status/final in display-recovery-originals,
changed ONLY that one string to 'Trimmed bilateral row consensus', independently
reconstructed frozen dataset/source/config/private-ledger bindings, reran every
unchanged verify_completion gate and wrote a real terminal-worker receipt.
All models/scores/reviews/fit receipts/candidates/families/architecture unchanged.
The independent audit verified recursive scientific equality, original final
bytes, backup hash, private ledger and verify_publication success. Disclose this
as documented manual display repair, not a clean unattended first-attempt smoke.
Full original61test IDs remain excluded, test_evaluatedfalse. Exact evaluated
child's259-character objective renders22paired epochs, selectedepoch22.

Extracted the unchanged display-metadata contract into validate_display_metadata
and added it to pre-review canonical --round preflight for novel methods only,
preventing this formatting failure after review. Focused14training tests pass,
and the actual smoke passes the new CLI gate. Official eight-parent pool remains
unpromoted; successful scoped R52 consumes the round number, so next full isR53.
User authorization covers that ONE full round with8parents/2researchers,6slots,
2fits,20minutes,182/61/61seed0,80/20jaw/speed and reserved test.


## Full Round 53 passed — 2026-11-26

The full run working/runs/dashboard-20261127T010810Z-470e0ef7 completed normally
with no scientific/metadata recovery. Independent verify_publication passed.
All20supervised tasks (8parent authors,2researchers,10fresh reviewers),18serial
native evaluations,50native probes and103canonical fitting trials passed, with
zero crashes. Root matched all103fit starts to original supervised allocations:
none after the export cutoff. All native timing follows completed authors/fits
and intervals do not overlap. Original182/61/61seed0 partitions are identical;
no reserved test IDs in evaluation, test_evaluatedfalse. Root report:
independent-monitor-audit.json in that run. A stale coordinator phrase saying
outer audit pending was cleared from the DISPLAY status only after receipt
verification, preserving original status in status-before-monitor-message.json.

New admitted champion: R53 causal appearance fusion; display Appearance Fusion:
Causal pooled geometry state. Train eventF1=0.910761, validationF1=0.880000
(110matched,18false,12missed;44clean validation clips), fitness0.904000,
laptop deployment CPU p95=0.025917ms. Prior admitted R50 validationF1=0.823529.
The0.95validation goal remains unmet; no physical-phone benchmark or test replay.
Winner uses current intensity/absolute spatial-gradient pooling,250ms causal EMA
appearance memory and8-unitReLU readout with train-only normalization; IMU was
ablated after comparison, so this checkpoint is video-only. It remains clip-
replay evidence plus structural probes, not proof of nonstop field accuracy.

All72iterative histories/1560epochs preserved;12exact evaluated-model histories
load through the dashboard. Winner curve is training/research01-finevisual-
collection/history.json:19epochs,selectedepoch9; checkpoint selection still
validation eventF1. Memory watcher126samples, peak tracked agentRSS3596MiB
(shared pages can overlap), kernel pressure at most2/warning, never critical;
max system swap15482.31MiB includes other workloads/preexisting swap. Fit peak2.
Official pool promoted to8members in this run's results.json; dashboard next54.
User authorized monitoring only after launch: no Round54 was started.

## Next-round Transformer direction and event learning curves — 2026-11-26

User requests exploring Transformer architectures in the next round's prompt,
and train/validation squeeze/release F1 on one plot. Dashboard's editable default
prompt now prepares distinct causal visual-attention and optional video/IMU/pose
fusion hypotheses, a compact MLP control, bounded persistent streaming state,
capacity/context comparisons, regularization/augmentation controls and unchanged
80/20 validation-F1/native-speed scoring. No Round54 launched or automatic new
round/stopping-policy change authorized by this request.

New jaw make_training_monitor plans require full inference-mode
training_predictions each epoch with the SAME fixed selection decoder as validation.
Shared TrainingMonitor saves hashed train predictions; canonical per-fit and
round audits validate training IDs/schema/hashes. Existing frozen trials remain
compatible. Exact-model dashboard charts derive four per-event F1 series from
saved predictions and hash-bound train/validation manifests, keep raw losses
and selected epoch, and never read test. R53 has only validation epoch predictions,
so historical training lines explicitly remain unrecorded. No refit or invented
train curve. The prototype epoch decoder differs from the separately tuned final
deployment decoder; do not label their scores as identical.

Guidelines now request a documented generalization control/ablation or concrete
budget/blocker reason; normalize only on train, preserve sensor consistency for
augmentations, and do not game objective scale or demand prettier curves.
Stopping recommendation (not a new enforced setting): pause when validation F1
reaches0.95 or when meaningful improvements plateau across several comparable
rounds; then freeze and validate on phone/fresh sessions, keeping test reserved
until separately authorized. Shared74 and dashboard100 tests pass (174total),
JS syntax/diff checks and real R53 history loading passed. Browser verified the
loaded Transformer prompt, selected-epoch marker, squeeze/release validation
lines and explicitly absent training lines; Start Round54 remains unclicked.

## Active continuation goal — 2026-11-26

User now authorizes consecutive audited rounds until validation jaw-eventF1>=0.95,
with adaptive round prompts, then the leading model's updated loss/event-F1 plots
and concise architecture. This supersedes earlier one-round-only authorization
and the proposed plateau pause (which was never an enforced policy). Do not
change fitness/splits/tolerance or use reserved test to reach this goal. Keep
8parents/2researchers/6agent slots/2fitting slots/20minutes and independent final
reviews. Full Round54 started at working/runs/dashboard-20261127T044502Z-887aba33
from the actual admitted R53 pool, with the prepared causal Transformer prompt.
Resource monitor and worker-bound idle-sleep prevention are attached. Verify live
worker/ledger state and actual final outer-worker publication before any promotion
or next round; coordinator output alone is insufficient. No commit/push implied.

Round54 attempt dashboard-20261127T044502Z-887aba33 failed after the provider
returned an exact temporary model-capacity error for parent04. Other tasks were
closed and evidence preserved (28partial epoch histories/485epochs at monitoring);
no scoring/publication/test access. Worker terminal state verified as defunct.
Future supervisor versions allow two bounded5/10second capacity retries using the
same established identity and original deadline, with slot reservation and hashed
failed error evidence checked by the outer budget audit. No model substitution,
quota/auth retry, new identity or clock renewal. Retry the authorized round from
the unchanged admitted R53 pool after synthetic regression checks pass.

Actual retry Round54 is now live at working/runs/dashboard-20261127T045652Z-7c515bc7
(worker28410). Six authors are running and four queued; current completed trial
histories retain full training prediction evidence. All three manifest file
hashes equal R53's original partitions; test untouched. Same-identity capacity
retries reserve their slot so queued authors cannot starve a pending retry;
outer audit validates the exact provider-error stream hash and5/10second backoff.
39targeted runtime/budget regressions pass; previous shared77tests passed before
the added audit-only guard. Runtime handles/health scripts are recorded in
/tmp/tmt-goal-state.json for continuation, but verify actual live state. Last
accepted validationF1 remains0.880 pending a full audited native round result.

## Round54 accepted; autonomous0.95goal continues — 2026-11-26

Retry dashboard-20261127T045652Z-7c515bc7 passed the actual outer-worker gate
and independent verify_publication. Twenty supervised tasks, ten approvals,
fifty native probes and eighteen serial native replays completed; root verified
ALL native intervals are nonoverlapping and begin after all author allocations
and fitting leases ended. All train/validation/test manifest hashes equal R53.
138fits:136completed/two honestly logged experimental crashes;101iterative
histories/1988epochs. No capacity retry was needed in this successful attempt.

Admitted leader R54 attended appearance fusion: validationF1=0.9149797571,
113matched/12false/9missed;trainF1=0.9264305177,fitness0.9319838057,
laptop native p95=0.0430832ms. Squeeze55matched/8false/6missed;release58/4/3.
Beach11false/6missed,park1/1,home0/2. Runtime cannot use collection/clip identity.
Wide current grayscale/absolute gradients and250ms causal memory feed an8-channel,
8-token causal attention cache with relative-lag bias and residual feed-forward
readout, then persistent hysteresis. Exact selected history has12epochs and
all FOUR train/validation squeeze/release F1 traces; no test replay/phone run.
Root audit saved /tmp/tmt-last-goal-round-audit.json and scripts preserve details.

Resource monitor120samples:maximum trackedRSS5416MiB,pressure at most2/warning,
no observed critical4;system swap peak20717.56MiB includes other/preexisting
workloads. Keep current2fit/6agent controls. Fixed presentation-only missing
benchmark_protocol in dashboard evaluation views, which incorrectly called
native scores Historical prototype;6metric-reader regressions pass. No model,
evaluation result or scientific context changed.

Prepare Round55 with adaptive prompt /tmp/tmt-round55-prompt.txt: prioritize
squeeze errors, matched-input ablation of wider ROI versus attention, meaningfully
wider/deeper causal Transformers, and complementary learned spatial/patch/CNN
features with optional evidence-backed sensor fusion. Native compute has headroom;
retain exact80/20 scoring,182/61/61seed0 split,8pool/2researchers/6agents/2fits,
20minutes and reserved test. Root is authorized by the ACTIVE continuous goal,
not a new one-round approval. Dashboard reload uses the adaptive prompt as its
in-memory default so visible controls match the next actual job configuration.

Round55 now started at working/runs/dashboard-20261127T055956Z-1725b017,
worker63120, from the accepted R54 pool with the complete adaptive prompt saved
in config.settings.agent_prompt. Live monitor/awake/server handles are updated in
/tmp/tmt-goal-state.json. Root goal verification script checks actual publication,
unchanged manifest hashes, serial native measurements after all authors/fits,
and exact selected model's four F1 curves. The0.95goal is an accuracy target:
inspect the best audited F1 among ALL evaluated models as well as the composite-
fitness pool leader; do not impose a new requirement that a0.95model must also
win composite fitness. Disclose a speed/fitness tradeoff if these differ.

## Round55 accepted; finer inputs/raw sensors next — 2026-11-27

dashboard-20261127T055956Z-1725b017 passed outer publication and root's independent
verify-goal-round script.20supervised tasks/10approvals/50probes/18serial native
evaluations;122fits,102iterative histories/1644epochs. Native intervals are
nonoverlapping and begin after ALL authors/fits. All three manifest hashes
remain identical. Leader R55 wide-attention8-k8-boundary:valF1=0.918699187,
trainF1=0.9322493225,113matched/11false/9missed,p95=0.042708ms,
fitness0.9349593496;16raw epochs with all four train/validation event-F1 series.
Only one false trigger improvement over R54;0.95not yet achieved. No test/phone run.

Raw-training inspection /tmp/tmt-training-roi-inspection.png covers one training
example from beach/park/home, three timepoints each. Current x144..223,y80..191
crop generally includes the gripper, but small feet/jaw details can be coarsened
by4px pooling; this is a hypothesis, NOT proof of the error cause. Prepared images
are full320x240grayscale, so more detailed pixels are available without changing
the frozen fixture/evaluator. R55 fresh spatial model used a convolution over
the existing six-channel pooled descriptors and reached0.89764; dual-scale
Transformer with an8-dimensional input bottleneck reached0.90837. Merely widening
attention did not yield a step increase.

Adaptive Round56 prompt /tmp/tmt-round56-prompt.txt prioritizes an actual fine-
pixel learned CNN with causal temporal state and a complementary raw-IMU
convolution/recurrent encoder plus visual fusion. Primary research starting
points (not jaw-task validation):DeepSense arxiv1611.01942 and DeepConvLSTM
PMC4732148. Keep current split/settings/gates and root continuous goal. Resource
115samples:trackedRSSmax4783MiB,pressure<=2,system swapmax10236.25MiB. Four-line
plot renderer /tmp/tmt-plot-goal-candidate.py verifies exact selected checkpoint
and separates fixed-decoder epoch curves from tuned native final metrics; audited
R54 baseline rendered at /tmp/tmt-round54-curves.png. Goal deliverable still pending.

Round56 actually started at working/runs/dashboard-20261127T070057Z-77866e65,
worker97026, using accepted R55 as prior and the complete finer-pixel/raw-IMU
prompt in frozen config. Current monitor/awake/server handles and helper paths
are in /tmp/tmt-goal-state.json; verify live state before continuing. The
continuous0.95goal remains active; no next round is preauthorized beyond its
actual stopping condition. Do not consume test or claim target completion at0.919.

Round56 attempt dashboard-20261127T070057Z-77866e65 failed after its watchdog
shut the supervisor down, closing six live authors/four queued tasks. MCP still
answered afterwards, so this was the watchdog failure path, not a disappeared
MCP process. The OLD runtime only printed its exception to stderr and the
coordinator log did not retain it; exact original cause remains unknown. Do NOT
claim a proved timeout. Preserve24partial histories/365epochs and unchanged R55;
no final native scoring/reviews/publication/test access occurred.

Investigated a related reliability hazard: a single0.5second process-snapshot
timeout was fatal, and stop/cleanup repeatedly sampled all processes per task.
Future runtime retries ONE such timeout with fresh data, reuses the current
tick's snapshot for stop/cleanup, and durably records original watchdog type/
message/traceback in its private ledger and watchdog-failure.json before shutdown.
Other/persistent failures still stop; publication rejects any fatal watchdog
record. No clock, identity, reviewer gate or shutdown grace relaxed. Synthetic
fault injection verifies the real watchdog logging path and cleanup/deadlines;
83shared and100dashboard checks pass (183total). Retry the same Round56 direction
from admitted R55. If it recurs, inspect the NEW private failure evidence first.

Actual Round56 retry is live at working/runs/dashboard-20261127T071747Z-ad90e8c7,
worker4300, same research direction/admitted R55 prior. Monitor/awake handles
are updated in /tmp/tmt-goal-state.json. Durable fatal diagnostics would appear
in working/runs/.agent-runtime/<job>.json.watchdog_failure and its private-io
watchdog-failure.json; read the actual ledger field, not a guessed error reason.
Continue the authorized goal while unmet, verifying live process/receipts before
any restart/promotion. Latest accepted validationF1 is still0.918699187.


## Round56 interrupted-fit logger retry — 2026-11-27

Second attempt dashboard-20261127T071747Z-ad90e8c7 failed before native scoring:
KeyboardInterrupt has an empty string, and TrainingMonitor.fail serialized that
as a blank reason, correctly rejected by canonical full-journal audit. The
supervisor stayed healthy (watchdog_failure null). Preserve failed journals and
partial fits; do not supplement original evidence or waive publication. Future
fail() logs exception class even when its message is empty, including interruption
while acquiring a fit slot.85shared+100dashboard checks passed. Candidate expanded
cards retain exact-checkpoint loss and four train/validation squeeze/release F1
series; historical missing predictions are disclosed, never reconstructed falsely.
Root browser verification observed both graphs in the accepted R55 leader card.

Third Round56 attempt dashboard-20261127T074334Z-7909f33f,worker17097, now uses
accepted R55 and the same fine-pixel/raw-IMU direction, plus canonical logger and
current-round scaffold notes. Actual config preserves8pool/2researchers/6agents/
2fits/20minutes,1reviewer per candidate,80/20fitness and reserved test. Verify
live state via /tmp/tmt-goal-state.json. No accepted F1 above0.918699187 yet.


Round56 third attempt dashboard-20261127T074334Z-7909f33f stopped operationally:
NEW durable watchdog evidence proves both0.5s process snapshots timed out while
six authors were active.29completed fits/27partial-or-complete histories477epochs,
no native evaluation/reviews/promotion; test untouched. Unlike the first failed
attempt, this exact cause is known. Logger fix worked: KeyboardInterrupt failures
now have nonempty typed reasons. Resource41samples:trackedRSSmax5875MiB,pressure
at most2,system swapmax21613MiB (includes unrelated/preexisting workloads).

Future process snapshots now allow2seconds per fresh attempt,still at mostONE
retry; persistent failures remain fatal and fatal ledger records prevent publish.
No stale process metadata, identity changes, deadline reset or shutdown-grace
increase. Tick reads actual clock after sampling; a synthetic delayed observation
crossing the hard deadline correctly stops the task. Existing2second overrun
audit remains strict, so excessive observation delays near cutoff can still
reject a run rather than grant extra research time. No source changes in failed
job and no reuse of closed tasks. Retry from accepted R55 after regression checks.

Round56 fourth attempt started at working/runs/dashboard-20261127T080601Z-32025a41,
worker26773. Frozen source includes PROCESS_SNAPSHOT_TIMEOUT_SECONDS=2.0;
86shared regressions passed, previous100dashboard regressions unchanged/passed.
Actual config is8pool/2research/6concurrent/2fits/20minutes/1reviewer and prior
accepted R55. Root verified exact config prompt and frozen runtime source.
Current live monitor/awake/server handles are in /tmp/tmt-goal-state.json.
Goal remains actual audited validationF1>=0.95 plus exact model curves/architecture;
latest accepted F1 is0.918699187. Test remains reserved. No failed job was admitted.


## Round56 admitted; explicit event supervision next — 2026-11-27

Fourth attempt dashboard-20261127T080601Z-32025a41 completed and passed actual
outer publication plus root /tmp/tmt-verify-goal-round.py.20supervised tasks,
10independent approvals,50native integrity probes,18serialnative evaluations,
61fits,49iterative histories942epochs. Native intervals do not overlap and
start after ALL authors and fits. All182/61/61seed0 manifest hashes unchanged;
test never evaluated. Leader unchanged:R55 wide-attention8-k8-boundary,
validationF1=.918699187,trainF1=.9322493225,p95=.043458ms,fitness=.9349593496.
Its exact16epoch history has all four train/validation squeeze/release curves.
Fresh finepixel CNN+48D attention=.87603,raw-IMU confidence residual=.914286.
Both passed integrity; neither improves leader. Runtime2second snapshot fix
completed the full run; no fatal watchdog. Resource127samples,RSSmax4746MiB,
pressure always1,system swapmax10270.12MiB includes other/preexisting workloads.

Researcher2 discovered sampled-state supervision holes. Root independently
recomputed them from actual Fixtures/clips.json timestamps and unchanged TRAIN/
VALIDATION button references:3TRAIN clips and1VALIDATION clip have zero closed
video frames;4TRAIN intervals<100ms. Some durations~0.25ms,validation~3.67ms.
This is NOT a label-error conclusion. Preserve labels/evaluator; state-only BCE
supplies no positive target for intervals entirely between sampled frames.
Root evidence:/tmp/tmt-root-state-supervision-audit.json;author report:
research-02/state-supervision-coverage.json and research-report.md. No test read.

Next adaptive prompt:/tmp/tmt-round57-prompt.txt. Researcher1 prioritizes explicit
causal close/open heads with matched state-only control,optionally raw-IMU and
auxiliary state loss; keep one-event-per-step adapter contract and no quota/time
shortcut. Researcher2 tests transfer learning compact pretrained visual features
with honest native export/full runtime costs,not cached embeddings masquerading
as inference. Official sources:docs.pytorch.org/vision/stable/models/generated/
torchvision.models.mobilenet_v3_small.html;github.com/pytorch/vision/blob/main/
torchvision/models/mobilenetv3.py;github.com/facebookresearch/dinov2;arxiv2304.07193.
These motivate hypotheses,not jaw performance claims. No required model download
or dependency changes yet. Keep all current split/scoring/resource/review settings.
Accepted current pointer now R56 results.json. Goal remains unmet at.919<.95.


Round57 actually started:working/runs/dashboard-20261127T091522Z-5f03b985,
worker60680,accepted prior R56. Root confirmed complete adaptive prompt in frozen
settings and unchanged8pool/2research/6parallel/2fits/20minutes/1reviewer. Dashboard
server refreshed from current code with that prompt as visible default; newserver
PID60550. Live monitor/awake/server handles:/tmp/tmt-goal-state.json. Continue
actual0.95goal; target still unmet, test reserved. No source changes needed to
current evaluators, supervisor or scoring for this new research direction.


## Round57 admitted:0.930; recover complementary misses next — 2026-11-27

working/runs/dashboard-20261127T091522Z-5f03b985 passed actual outer publication
and root independent goal audit.20supervised tasks,10approvals,50causal probes,
18serial native evaluations AFTER all authors/fits;92fits,80iterative histories/
1426epochs. All182/61/61seed0 manifests unchanged,test not evaluated. Leader:
R57 explicit events event-regularized,method explicit_event_heads57,validationF1
.9300411523,trainF1.9386084584,113TP/8FP/9FN,p95.1312172ms,fitness.9440329218.
83932parameters:separate TRAIN-refitted8D visual-state attention and16D visual/
raw-IMU event attention graphs;4frame event-confidence buffer VETOES state
transitions unsupported at.1. It cannot recover absent state transitions.
Exact18epoch selected history has all four train/validation event-F1 curves.
R55 baseline.918699 was113TP/11FP/9FN,so improvement is3fewerfalse events.

Actual transfer proposal.895161 uses frozen ImageNet MobileNetV3Small first4
stages with spatial cells plus visual branch/8Dattention. Native artifact is
PyTorch Mobile Lite interpreter2.14.1 CPU via torch._C._load_for_lite_interpreter,
one libtorch intra-op thread,not handwritten C++. Coordinator deployment_runtime
metadata accurately overrides engine; full graph/preprocessing/decoder timed.
No physical-phone benchmark. Its final reviewer recovered one exact capacity
error via same-identity/original-clock bounded retry; full audit accepted it.
Monitor126samples,RSSmax4812MiB,pressure always1,system swapmax9702.12MiB.

Root generated /tmp/tmt-r57-complementarity.json by checking hash-bound native
outputs and actual one-to-one matches against TRAIN/VALIDATION refs. Every one
of leader9validation misses was matched by another model. Motion eventheads
covers5but28FP;geometry covers4but27FP;ExtraTrees covers4but29FP;spatial model
covers3but18FP. This is ORACLE DIAGNOSTIC ONLY,not an ensemble result. Never use
its clip IDs,reference times or routing labels at inference. The current misses
are NOT the earlier zero-closed-frame validation example; do not overfocus on
that edge case. Native source/report and scientific context unchanged.

Next prompt:/tmp/tmt-round58-prompt.txt(7511chars). Prioritize recall-capable
causal state/event correction and complementary learned expert fusion with
TRAIN-only fitting/cross-fitting where feasible. Official stacking guidance:
https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.StackingClassifier.html
warns about in-sample meta-learning overfit; no validation labels tofitfuser.
Keep all8parents reproducing and all resource/scoring/review/test settings.
Latest accepted current pointerR57. Goal remains actual.95validationF1+graphs/
architecture; unmet at.930. Current exact handles:/tmp/tmt-goal-state.json.


Round58 actually started at working/runs/dashboard-20261127T102409Z-488de607,
worker93559,accepted prior R57. Frozen prompt equals /tmp/tmt-round58-prompt.txt
(7511chars),settings remain8pool/2research/6parallel/2fits/20minutes/1reviewer.
Dashboard refreshed with this prompt as visible default,serverPID93495. Live
monitor/awake/server handles and specific fusion/engine audit notes are in
/tmp/tmt-goal-state.json. Continue the same0.95goal; current acceptedF1.930041
and target unmet. No source/evaluator/scoring change or physical-phone run.


## Round58 admitted:.939; hard negatives/event objective next — 2026-11-27

working/runs/dashboard-20261127T102409Z-488de607 passed actual outer publication
and root independent verify-goal-round audit.20supervised tasks,10approvals,
50causal probes,18serialnative evaluations after ALL authors/fits;89fits,
70iterative histories1226epochs. All182/61/61seed0 manifest hashes unchanged;
test never evaluated. Leader R58 recall correction additive-delta(method
causal_event_correction58):validationF1=.9387755102,trainF1=.9322493225,
115TP/8FP/7FN,p95=.2311662ms,fitness=.9510204082. FITNESS>.95is NOT goal completion;
actual validationF1 remains below.95. Exact15epoch selected history has all four
train/validation squeeze/release F1 traces. R57 prior113TP/8FP/9FN;recovers2park
CLOSEs,loses0validation matches,unchanged8false. TRAIN recovers1/loses1match and
adds5netFP,so accuracy is not uniformly improved. New independent additive16D
signed-motion event correction sits beside unchanged visual/veto branches.
Published checkpoint/curves use fixed fit decoder; final post-decoder selected
.8confidence/.8s same-kind refractory after checkpoints frozen. Rapid same-kind
repeats can be suppressed; no nonstop/iPhone generalization claim. Full real
branches and sensor alignment are measured. Global logistic geometry fusion
failed to improve(.918699);all negative trials remain recorded. Resource135samples,
RSSmax4629MiB,pressure<=2,system swapmax9580.12MiB includes other/preexisting work.

Next adaptive prompt:/tmp/tmt-round59-prompt.txt(7603chars). Researcher1 tests
matched BCE versus focal/TRAIN-only hard-negative mining;primary source
https://arxiv.org/abs/1708.02002 motivates sparse hard examples,not jaw accuracy.
Researcher2 tests event-window/bag or timing-aligned objectives with actual causal
online heads;inspirations arxiv1703.03329(UntrimmedNets) and arxiv2006.03732(WOAD).
Offline proposal/whole-clip aggregation must never be deployed. Keep original
button cues,.5s matching and splits;no validation-label fitting or runtime oracle.
With115TP/7FN,FP8->5 suffices for F1>.95,or recover3misses with8FP;do not impose
extra individual precision/recall targets. Require explicit structured parameters,
not trial-name substring dispatch(confounded prior wide trial disclosed). All
resource/reviewer/scoring settings remain as accepted. Goal remains unmet at.939.
Current exact state/handles:/tmp/tmt-goal-state.json. No extra source-code change
or model fitting by root; all training stays in supervised round tasks.


Round59 actually started:working/runs/dashboard-20261127T113641Z-7a33ad2c,
worker27235,accepted prior R58. Root confirmed complete7603character adaptive
prompt and exact8pool/2research/6parallel/2fits/20minutes/1reviewer settings in
frozen config. Dashboard refreshed with same visible default prompt,PID27130.
Live monitor/awake/server handles and loss/mining/causality audit notes are in
/tmp/tmt-goal-state.json. Target remains actual validationF1>=.95,not composite
fitness; accepted F1=.93877551,test reserved. No scoring/evaluator/source edits
or physical-phone performance claim. Continue same active goal.


### Audited R59 and paired RGB preparation — 2026-11-27

R59 `dashboard-20261127T113641Z-7a33ad2c` passed actual outer publication and independent root audit: all20 supervised tasks ready,10 independent final approvals,18 final native comparisons strictly serial after all authors/fits,50 probes,99 fit leases,84 histories/1396 epochs. Strongest `R59 independent motion delta-bce` validationF1=.9392712550607287(116TP/9FP/6FN),trainF1=.9327956989247311,p95=.2266746ms,fitness=.9514170040. Exact15epoch history contains all4 train/validation squeeze/release series. Frozen train/validation/test manifests unchanged; test not evaluated. Goal.95F1 UNMET. R59 focal/proposal-validity/event-bag approaches mostly tied/regressed; preserve parent08 original wrong-objective attempt and explicit quarantine (variable shadowing disabled focal); its separate corrected focal attempt regressed. Do not confuse structural training preflight with scientific objective correctness.

Next hypothesis: remove artificial320x240gray-only input bottleneck without changing frozen evaluation. `prepare_rgb_inputs.py` deterministically prepares rawRGB960x720 with orientation/aspect-preserving letterbox from only the existing243 TRAIN/VAL videos, reproducing EVERY oldgray pixel and timestamp exactly. First real104frame pilot passed; full cache preparation in progress under working/input-cache/rgb960x720-v1-r59 (private, not Git). `paired_rgb_inputs.py` maps read-only paired inputs, pins full index SHA and current manifest/fixture context; coordinator must verify all pixel hashes before dispatch.12 focused real-video tests passed. These are label-free preparation checks, not model accuracy or native benchmarks. Before R60 authors start, job-local native benchmark AND independent probes need genuine RGB opt-in dispatch with exact same model input contract; keep legacy gray baseline unchanged. All algorithm-specific resize/crop/color/features/inference/decoder cost counts. No cached embeddings replacing runtime. Read-only mmap cache shared across rounds, no full corpus duplication. No test input. Input metadata/clip IDs never reach inference. Adaptive R60 prompt is /tmp/tmt-round60-prompt.txt; not yet launched at this note.


### Failed first R60 and conservative epoch admission — 2026-11-27

First R60 `dashboard-20261127T125501Z-130133c9` FAILED, not admitted. Six authors ready/four explicitly cancelled, no final native evaluation/review; priorR59 .939271255 retained, test untouched. Researcher01 legitimate23745parameter RGB-CNN/TCN MobileLite export feasibility passed but first gray-control trial `r60r01-gray-retry` took315.21874891698826s versus unchanged300s policy+15s canonical grace. Original7epochs,receipt,plan,checkpoint and full journal remain unchanged and rejected. Raw first epoch217.878s included expensive label-free crop prep; later epochs~16s. No candidate accuracy claim from this failed job. Monitor/resource owner exited,zero active fits.

Future shared TrainingMonitor now pins epoch-lookahead-v1 for new iterative plans. can_start_epoch() uses the longest of up to3recent adjacent epoch measurement intervals (excluding initial interval with prep),25%margin and bounded finalization reserve; stops early as epoch_budget with hash-bound receipt evidence. Canonical dashboard audit recomputes exact decision from original raw history. Actual300s bound/315s audit max unchanged; old overrun remains rejected. Cannot predict sudden stalls; authors still check long loops. No fake terminal epochs or rewritten histories. New helper ml/evolution/epoch_admission.py is protected-source. Actual trace replay would stop after epoch5 at283.2145s; this is counterfactual guard validation,not training or improved accuracy.83 shared and102 dashboard regressions passed (process/loopback tests require normal elevated permissions); acceptedR59 independently re-audited successfully. Shared agent briefs/README updated.

Raw pairedRGBcache now COMPLETE and independently hash-verified:243train/validation clips(182/61),28329frames,58743045504bytes,indexSHA c68c8b26aa2acf9957ab090bbbd19a3c32374cdbbcc78c76e9acb829b0b171b4. All original sampled sources960x720. No test footage read; every oldgraypixel/timestamp exact. Failed R60 job has source-only input_dispatch.py/benchmark/probe recipe scaffolds and genuine no-fit RGB/gray dispatch checks; future jobs may inspect/copy/test source,but no invalid learned artifacts or task revival. Optional researcher01 gray-*pixels.npy caches are deterministic uint8 raw pixel crops only; can be reused with independently verified order,split,input,preprocessor andhash provenance,never learned scores/embeddings or invalid weights. Final native processing always recomputes model-specific transforms inside timedstep.

Fresh R60 retry prompt /tmp/tmt-round60-retry-prompt.txt(7356chars) and detail /tmp/tmt-round60-retry-guidance.txt preserve same8parents/2researchers/6parallel/2fits/20minutes/1reviewer and admittedR59. Not yet launched at this note; reload idle server for new monitor/auditor source before launch. Keep failed attempt immutable.


### User cancelled open-ended goal; one final round only — 2026-11-27

Latest user instruction supersedes all previous.95 continuation directives: finish interrupted round if valid; otherwise run JUST ONE replacement round,then present latest audited leader. Goal tool is PAUSED (no cancelled status available),no automatic continuation/resume/new Goal. Interrupted R60 dashboard-20261127T133811Z-886f1ca6 FAILED on Codex quota/automatic approval failure,6authors ready/4closed,no final native scoring/reviews; closed allocations cannot reopen. Same-account read-only quota check subsequently showed available capacity(no account/model/approval bypass or credit purchase). The user's ONE replacement job is dashboard-20261127T144126Z-6e54376f,worker10818. Finite prompt /tmp/tmt-user-final-round-prompt.txt(7100chars); technical /tmp/tmt-final-round-technical-contract.txt. Same8/2/6/2/20/1,admittedR59 prior,test reserved. After this job,STOP regardless of F1 or outcome. Do not start another job even if.95 unmet. Latest accepted leader before this job remains R59 independent motion delta-bce,F1 .939271255. Current controls in /tmp/tmt-goal-state.json user_final_request maximum_additional_rounds1,launches_used1. Final report needs actual audited latest leader,recorded loss/four-F1 curves and real architecture; disclose any failed final run instead of promoting provisional output.


### Final authorized round stopped; R59 retained — 2026-11-27

The user's ONE replacement job dashboard-20261127T144126Z-6e54376f is terminal FAILED before native scoring/reviews. All10authors ready;81attempts(78completed,3typedcrashes),60histories/1035epochs,zeroactivefits/tasks. Full combined training gate correctly rejected parent02 baseline and child sharing method `causal_event_correction58` with different selected weights; feature_parameters[method] overwrote the baseline despite each per-fit checkpoint being individually valid. No original author allocation reopened or scientific gate waived; failed evidence retained. Future runner work should catch unique model-ID/storage-key collisions while authors can still correct export metadata,or design explicit per-candidate parameter storage under a newly tested protocol; do NOT change this frozen failed run. No new round is authorized.

Goal remains PAUSED by explicit user cancellation. user_final_request launches_used1,max1,finishedtrue in /tmp/tmt-goal-state.json. Resource monitor30585completed,worker10818ended; no further work/round/Goalcontinuation. Latest admitted R59 independent motion delta-bce reverified via actual publication and independent full audit: validation .939271255(116TP9FP6FN),train .932795699,p95 .2266746ms laptop native,fitness .9514170040;testreserved. Exact15epoch primary-history curves(all4F1series),epoch5selected,140647totalparameters across visual/IMUevent/motion correction graphs. Final evidence /tmp/tmt-final-user-round-audit.json,graph /tmp/tmt-round59-leader-curves.png. Do not describe final R60 as completed or admit provisional children.


## R60 candidate-binding recovery — 2026-11-27

- User requested fixing the failed round and recovering saved candidates, not a
  new breeding round or restarting the cancelled goal. No new fitting, test
  evaluation, reviewer dispatch or model admission happened during recovery.
- Last source job: working/runs/dashboard-20261127T144126Z-6e54376f, terminal
  failed. Its 10 authors finished; 81 attempts comprise 78 completed fits and
  3 recorded crashes. Preserve that job and its original author allocations.
- Cause: parent R58 recall correction additive-delta and child R60 recall
  correction short target share method causal_event_correction58 but have
  different correct selected weights. The combined method-keyed table overwrote
  one binding. Individual checkpoints were intact; do not rename authored
  genotypes or weaken selected-checkpoint equality to hide this collision.
- New shared ml/evolution/model_parameters.py uses candidate-scoped-v1 and
  candidate_parameters[exact candidate.name]. bind_parameters rejects duplicate
  identities. parameters_for fails closed on missing/bad scoped bindings and
  reads historical method-keyed tables only when scoped format is absent.
  Gates, curves, runtime architecture display and replay/export readers use
  candidate identity. New jobs freeze the helper and require scoped binding
  before native evaluation. Shared evolution/research briefs carry this rule.
- Recovery package: /Users/ericlabouve/Datasets/too-much-trash/working/runs/recovery-r60-candidate-bindings-v1.
  All 10 challengers plus 8 baselines recovered with exact candidate objects,
  selected bare weights, histories/checkpoints/receipts, implementation files
  and full journal. Canonical whole-journal audit passes all 18 selected models.
  3,783 hash-bound source files archived (558,249,115 bytes); source unmodified.
  recover_saved_candidates.py --verify --output PACKAGE rechecks both original
  source and archive. A recovery archive may preserve empty build logs, but
  canonical training/deployment artifact gates remain strict and unchanged.
- Status recovered_pending_evaluation_and_review, published=false. This is NOT a
  completed round and must not enter leader history or next_pool as admitted.
  Resume serial native evaluation and new independent reviews before promotion;
  do not reopen completed authors, retrain or silently edit original receipts.
- Prior admitted R59 independent motion delta-bce still passes full publication
  gate: validation F1 0.9392712550607287, fitness 0.951417004048583. Test reserved.

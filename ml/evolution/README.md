# Evolutionary search

Use `run_round` for search and selection. A domain owns its data, candidate
parameters, measurement, fitness formula, resume files, and presentation.
The shared code uses the Python standard library.

## Add a domain

1. Define a candidate dataclass with `name`, `created_round`, `parent`, and the
   domain parameters. Use JSON-compatible fields so candidates can round-trip
   through `asdict(candidate)` and `Candidate(**record)`.
2. Build a `SearchSpace` with the candidate class, a stable genotype tuple,
   a function yielding bounded one-step neighbors, and functions returning
   the candidate's family key and display name. Exclude names and lineage
   metadata from the genotype. Optionally provide a ranking key for fitness
   ties. Keep descending fitness first in the sort order.
3. Implement `evaluate(candidate)`. Return a fresh dictionary with
   `candidate=asdict(candidate)`, numeric `fitness` (higher is better), and
   any metrics the domain needs. Use comparable inputs and measurement
   conditions across candidates. Keep independent validation out of selection
   when the goal is to estimate generalization.
4. Call `run_round(pool, number, seen, evaluate, space, seed=seed)`, optionally
   with a `Policy` or research `plan`. Persist the result, scored history,
   seed, and `seen`. To resume, rebuild candidates from `next_pool` and restore
   genotype tuples. Use JSON scalar genotype entries for a simple tuple
   round-trip. The runner updates the caller's `seen` set in place.

The [integer-search test](test_evolution.py) is a runnable, dependency-free
example of another domain. Run it with
`python -m unittest ml.evolution.test_evolution` from the repository root.

The [jaw experiment](../experiments/jaw-trigger/round_one.py) is a working
adapter. Its `SearchSpace`, `score`, and CLI show how to keep data and
fitness rules in the experiment.

## Selection modes

- **Seeded search** tries one unseen child per parent using bounded neighbors.
  It occasionally takes two steps and tries two-step neighbors when all
  one-step neighbors are exhausted. Fill available slots before pruning.
  A full pool admits at most one improving child, subject to family limits
  and preserving each represented family.
- **Agent-guided search** compares each parent with its proposed child, then
  gives the lowest-ranked lineages' slots to fresh research ideas. A full
  pool and one proposal per parent are required. The default policy is ten
  slots and three research replacements. If a proposed genotype has already
  been scored, the runner tries seeded mutation instead. The plan format is
  `{"mutations": {"parent name": {"changes": {"parameter": 1}, "rationale":
  "..."}}, "ideas": [...]}`. Each idea is a complete candidate record.
  Plain change dictionaries are accepted for older plans.
- **Portfolio search** uses the same plan and evaluation budget. Pass a
  `Portfolio` with callbacks for objectives and per-case coverage to
  `run_round`. The selector retains the best overall candidate, holds up
  to three exploration lineages for three scored mutations each, then
  fills the pool with objective specialists and candidates that add
  coverage. An exploration leader can also be the overall champion.
  Persist `protected` and pass it back on resume. Use `--portfolio` when
  generating the agent briefs for this mode.
  Fresh ideas also enter ordinary competition when protected slots are full;
  protection grants extra mutation opportunities rather than gating admission.

The jaw dashboard now passes its protected-slot limit, actual mutation-attempt
limit and soft architecture-family cap explicitly into a domain selection
adapter. It trims inherited lanes when limits shrink and independently checks
selection against per-case metrics recalculated from validation detections.
Use reviewed architecture identities rather than method-string heuristics for
this domain. Legacy CLI defaults remain available for reproducing old runs.

The current jaw dashboard uses **portfolio** selection, not the older plain
parent/child-replacement rule. Its defaults retain eight incumbents, produce
one child per current incumbent, and add two fresh researcher proposals.
Survivors need not be the eight highest fitness scores: the global champion,
protected leads, a useful task specialist and complementary per-clip coverage
share the pool. Parent and child can both survive; no automatic neural-weight
crossover occurs. The architecture-family cap of two is soft when diversity
is scarce. At most one new protected lane is opened per round, within two
total lanes. Protection expires after two actual child attempts, not two
elapsed rounds. The former top-seven cutoff was removed: every current member
gets a child in ordinary All families rounds, including weak protected members.
New Family runs research only; family-filtered checks reproduce every candidate
in their selected scope. Pool size sets the next survivor capacity, so shrinking
it takes effect after the current full-pool reproduction/selection transition.
Research count controls fresh proposals and agent concurrency controls parallel
execution. Neither is a hidden parent cutoff. New completion audits require
exactly one mutated child and one parent-agent receipt per expected parent;
old top-X runs retain their historical rules under their saved settings.

From the repository root, generate domain-specific briefs with
`python -m ml.evolution.agent_briefs RESULTS_JSON --context "Evaluation and constraints"`.
Pass `--pool-size` and `--research-slots` for a custom policy. The orchestrating
Codex session dispatches the configured research tasks and one task per parent, collects
proposals, and passes the plan to the runner. The library emits briefs
and executes search. Agent dispatch belongs to the session.

## Supervised agent lifetimes

New jaw dashboard jobs bind `agent_budget_protocol=supervised-v1`. The
coordinator delegates through the local `evolution_agents` MCP server in
`agent_runtime.py`; built-in multi-agent dispatch is disabled for that invocation.
Each task runs an independent `codex exec` process group. Concurrency queues
work; a task's monotonic clock starts when it actually launches, not when queued.
`start_agent`, `get_agents`, `wait_agents`, `send_message` and `close_agent` expose
the controlled lifecycle. Other domains can reuse this stdlib supervisor by
providing repository/job paths, fixed budget settings and expected task counts.

**Minutes per agent sets an enforced research schedule, not a suggested prompt duration.**
Candidate authors use the search window to inspect failures, try credible
hypotheses, journal failures and preserve their best validated checkpoint.
When an author returns early, the supervisor explicitly resumes the same thread
with its original remaining allocation. Patience-stopping one model fit does not
finish the author assignment. Export one final child/fresh proposal, rather than
growing the round population with every internal trial. Concrete operational
blockers stop honestly; reviewers can finish once their evidence is complete.

The last 10% of an author's allocation, capped at 120 seconds, is reserved for
finalization. New dashboard jobs freeze `agent_export_min_seconds=60` to leave
room for CLI resume startup on short allocations; the export window cannot
exceed half the total allocation. Thus a two-minute smoke has 60 seconds of
search and a nominal 60 seconds of export.
Legacy jobs without this field retain the five-second floor. At that cutoff,
active search is interrupted and the same thread gets an export-only turn: no new
fitting or parameter search, restore/package the best checkpoint and evidence.
Shared deployment export and serial final benchmarking remain separate phases
outside the author's research window. New jobs freeze
`agent_export_completion=finish-v1`: an export turn may finish beyond the nominal
deadline; no new research, fitting or parameter search is allowed. The coordinator
timeout excludes the union of actual author export intervals, including active
exports, so the outer timer cannot undo this rule. Reviews retain their hard
deadlines. Explicit cancellation and real process failures still stop work.
Legacy jobs without this flag retain hard author deadlines and the two-second
shutdown bookkeeping allowance.
Ordinary feedback never resets time. Only the existing bounded New Family
architecture feedback cycles 2/3 renew research/architecture-review allocations
on the same identities. Cancellation, EOF and supervisor signals clean up owned
process groups and observed command descendants, including helpers in separate
sessions. PID/start identities are rechecked before signaling. This is process
supervision, not an OS security container: deliberately double-forking out of
the tree before its first observation can escape tracking, and detached work
is forbidden. A timed-out/failed/unfinished task cannot publish success.

The supervisor writes its lifecycle ledger outside the agent-writable job root.
The outer worker copies and hash-pins `agent-runtime.json` after the coordinator
exits. `agent_budgets.py` binds actual thread IDs, assignments, exact prompts and
final artifacts to coordinator receipts, verifies deadlines/export windows and
rejects extra/uncontrolled work. Legacy jobs without this protocol retain their
original audit semantics; new API jobs cannot disable it.

Goal capability was checked on Codex CLI 0.160.0 on November 26:
persistent app-server Goals automatically continued into a second turn, but
`codex --no-daemon exec` created a Goal and exited after its first turn while the
Goal remained active. Ephemeral threads rejected Goal operations. Therefore
CLI children use explicit supervised resume, without native Goals. The bounded
diagnostic `python -m ml.evolution.goal_probe --output /tmp/tmt-goal-probe`
rechecks the CLI lifecycle and clears/archives its own probe thread; it starts
no evolutionary round or training. Goal support can change with CLI versions.

## Validation checkpoints and experiment records

New jaw jobs use `fit_slot_protocol=flock-v1`, with `fit_concurrency=2` and up to
six independently scheduled agents. TrainingMonitor acquires a process-shared
kernel fitting slot before optimization and releases it on finish/failure;
process exit also releases the kernel lock. Waiting does not consume the trial's
optimization budget but stays inside its author's original wall allocation.
All completed fits need hash-bound leases, checked for overlapping slot use.
Agents must construct the monitor before allocating heavy working sets or
optimizing, not fit first and manufacture a receipt afterward. Shared caches
and independent source review remain necessary; advisory locks are not a
security boundary against deliberately dishonest code. Legacy jobs retain their
original protocol. The standalone monitor_resources command records memory and
pauses new fitting admissions during fresh critical memory pressure.

The workflow adapts the fixed evaluator, bounded experiments, baseline and
failure-log principles of [autoresearch](https://github.com/karpathy/autoresearch/blob/master/program.md).
Our existing multi-family portfolio, requested round limits and deployment
benchmarks remain in place. Do not import its CUDA language-model trainer,
infinite loop, dependency ban or Git reset workflow into this shared checkout.

The shared `training.py` monitor is independent of PyTorch/Core ML/framework
choice. Before fitting, declare a hypothesis, objective, capacity/parameter count,
regularization (including a reason if none), seed and resource allocation. Reuse
prepared inputs with pinned train/validation manifests and establish an unchanged
measured baseline. The trial journal retains failures and rejected alternatives;
learning only from winners hides useful evidence and exaggerates search success.

For each iterative fit, evaluate **both losses in inference mode after every
epoch**, using the same objective/reduction/weighting, with no gradients,
dropout or augmentation on validation. Do not advance training RNG state while
measuring. The domain's validation task score selects a checkpoint; lower
validation loss then earlier epoch break exact score ties. The jaw domain uses
event F1 with a predeclared decoder held fixed within a fit. Training loss,
validation loss, event F1 and composite fitness are different quantities.

Default policy: 10 evaluations without at least 0.001 task-score improvement,
at least five epochs before patience stopping, and a 300-second per-trial wall
cap including optimization/validation after preparation (or the owning agent's
shorter allocation). Agents declare their epoch ceiling before fitting; 100
epochs is not mandatory. Stop on patience, the ceiling or the time cap, and
export the **saved best checkpoint**, not the last optimizer state. Call
`can_start_epoch()` and check the budget inside long epochs; disclose boundary
overruns. Parallel research/fitting may share resources, so record contention
and do not claim equal effective hardware compute from wall time alone. Final
deployment latency remains serial and isolated from training.

```python
from ml.evolution.training import TrainingMonitor, policy_for

# plan: candidate_name, hypothesis, objective, capacity, regularization, seed,
# resources={device, threads}, kind='iterative', max_epochs, selection_decoder.
# context: SHA256 of the pinned train and validation manifest files.
with TrainingMonitor(job, trial_id, plan, context,
                     policy=policy_for(settings)) as trial:
    while trial.can_start_epoch():
        train_one_epoch()
        # Run your model in eval/inference mode here; do not fit on validation.
        if trial.observe(train_loss=train_loss, validation_loss=validation_loss,
                         validation_score=validation_task_score,
                         validation_predictions=validation_predictions,
                         parameters=frozen_parameters, artifacts=opaque_weight_paths):
            break
    receipt = trial.finish()
    checkpoint = trial.selected_checkpoint()
    export_model(checkpoint['parameters'])
```

JSON-safe parameters can reference hashed opaque framework checkpoints; keep
referenced weight filenames immutable for each checkpoint. The
monitor does not require tensor weights to be serialized as JSON. Genuinely
noniterative fits use an explicit noniterative plan and `finish(parameters=...)`,
with a fitting justification, not invented losses. Failed context-manager
trials are journaled as crashes. Journal all other attempted fits as well,
including candidates not finally proposed. Preserve small gains when they
simplify the mechanism; no hidden simplicity bonus changes official fitness.

The jaw completion gate verifies `evaluation.training_receipts` for every
fitted candidate, exact split/checkpoint/history hashes, per-epoch F1 against
saved validation detections, best-epoch selection and stopping/budget evidence.
Independent final reviewers inspect the actual training code and declared
noniterative exemptions. Receipts reduce accidental errors and dishonest
reporting; they do not mathematically prove arbitrary agent code is honest.

The jaw dashboard uses `review_protocol=per-candidate-v1`: **Reviewers per
candidate** defaults to 1 (range 1–5). After freezing and serially evaluating
challengers, dispatch fresh independent review contexts for every
candidate/reviewer slot. Each reviews exactly one candidate using the same
rubric, without another reviewer's verdict. Never reuse an author, early
architecture reviewer or another candidate's reviewer identity/context. With
8 parents and 2 researchers, defaults produce 10 challengers and 10 review tasks,
plus 10 author tasks. All assigned reviews must approve before publication;
the next pool competes approved challengers against current parents. Concurrency
limits batching, not the number of assignments. Historical jobs without this
protocol retain their saved shared-review interpretation. The domain README
documents the exact frozen-artifact and streaming-probe receipts.

Final reviewer starts also require `review_bundle_protocol=frozen-bundle-v1`.
The coordinator passes `review_bundle` to `start_agent`: a candidate-scoped
JSON envelope with `candidate`, `artifact_bundle={candidate, learned, files}`
and `context.context_sha256`. `review_bundles.py` checks exact scope, every hash,
unique resolved artifact paths and required roles before a reviewer task is
created. One file has one record; do not repeat an evaluator as a dependency.
Invalid packages consume no review allocation and can be corrected before
dispatch. The supervisor pins the package and graph, and completion rejects
later changes or disagreement with the published graph. This preflight does
not replace independent source inspection or streaming probes.

Before marking a final reviewer ready, the supervisor calls `preflight_report`
to require the full exact candidate object, actual reviewer identity, frozen
context and artifact hashes. A malformed completed report gets one same-context
export-only correction under finish-v1, which may finish past the timer. Original
report bytes are preserved; verdict, findings, inspected paths and probe evidence
are hash-bound and cannot change during correction. Review analysis still has
its hard deadline. The outer timeout includes report-export pauses too. This
structural check never approves a rejection or replaces the final integrity audit.
Reviewers should export through `write_review_report`: supply their own verdict,
text-string findings, inspected paths and native check records. The writer fills
the full frozen candidate/context/hash metadata and validates it. Domain adapters
pin `review_report_probe_kinds` in supervisor configuration; exactly those kinds
belong in `checks`, with other diagnostics kept separately. Findings objects,
missing/extra/duplicate checks and incomplete inspection are rejected before ready.

If training loss improves while validation worsens, investigate capacity,
weight decay, dropout, label-preserving augmentation and simpler baselines.
Increasing validation loss alone is not a rejection if task F1 improves.
One logged decoder-tuning stage may follow checkpoint selection. Repeated
validation selection can itself overfit a small validation set: keep test
reserved and qualify random/overlapping-session generalization. More varied
data may still be required. Monitoring reduces overtraining; it cannot repair
dataset leakage or create missing independent evidence.

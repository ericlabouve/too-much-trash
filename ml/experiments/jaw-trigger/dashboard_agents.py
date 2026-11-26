"""Launch a sandboxed Codex coordinator and verify its persisted round receipts."""

import argparse
from hashlib import sha256
import json
from math import ceil, isfinite
from pathlib import Path
import shutil
import os
import signal
import shlex
import subprocess
import sys
import tempfile
from time import monotonic

from dashboard_round import architecture, candidate_catalog, candidate_family, write_json
from dashboard_integrity import REVIEW_PROTOCOL, review_context, verify_integrity_reviews
from ml.evolution.agent_briefs import EXPERIMENT_GUIDELINES
from ml.evolution.training import PROTOCOL as TRAINING_PROTOCOL, policy_for
from ml.evolution.agent_budgets import PROTOCOL as BUDGET_PROTOCOL, budget_policy, verify_agent_budgets
from ml.evolution.review_bundles import PROTOCOL as REVIEW_BUNDLE_PROTOCOL
from dashboard_selection import PROTOCOL as SELECTION_PROTOCOL, selection_parameters, verify_selection

HERE = Path(__file__).resolve().parent
REPOSITORY = HERE.parents[2]
MIN_REVIEW_CYCLES = 3
REPRODUCTION_PROTOCOL = 'all-pool-v1'
FINAL_SCHEMA = {
    'type': 'object', 'additionalProperties': False,
    'required': ['status', 'message', 'results_path', 'agent_manifest_path', 'evaluation_path'],
    'properties': {key: {'type': 'string'} for key in
                   ['status', 'message', 'results_path', 'agent_manifest_path', 'evaluation_path']},
}
FINAL_SCHEMA['properties']['failure_kind'] = {
    'type': 'string', 'enum': ['none', 'architecture_review', 'integrity_review', 'operational'],
}
FINAL_SCHEMA['required'].append('failure_kind')


def readiness():
    binary = shutil.which('codex')
    if binary is None:
        return {'ready': False, 'message': 'Install the Codex CLI on this Mac.', 'authenticated': False}
    try:
        result = subprocess.run([binary, 'login', 'status'], capture_output=True, text=True, timeout=10)
    except (OSError, subprocess.TimeoutExpired):
        return {'ready': False, 'message': 'Codex sign-in could not be checked.', 'binary': binary,
                'authenticated': False}
    authenticated = result.returncode == 0
    return {'ready': authenticated, 'authenticated': authenticated, 'binary': binary,
            'message': ('Codex is installed and signed in.'
                        if authenticated else 'Sign in with codex login on this Mac.')}


def selected_incumbents(prior, settings):
    """Rank retained competitors, or allow evaluated proposals to re-enter a selected family."""
    scores = {entry['candidate']['name']: entry['fitness'] for group in
              ('incumbents', 'challengers', 'pruned_scores', 'ranked') for entry in prior.get(group, [])}
    source = prior['next_pool'] if settings['family'] in ('all', 'new_family') else candidate_catalog(prior)
    candidates = [candidate for candidate in source
                  if settings['family'] in ('all', 'new_family', candidate_family(candidate, prior))]
    return sorted(candidates, key=lambda candidate: scores.get(candidate['name'], float('-inf')), reverse=True)


def evolution_parents(prior, settings):
    protocol = settings.get('reproduction_protocol')
    if protocol not in (None, REPRODUCTION_PROTOCOL):
        raise ValueError('Unknown reproduction protocol')
    if protocol == REPRODUCTION_PROTOCOL and 'evolution_agents' in settings:
        raise ValueError('all-pool-v1 has no top-X evolution_agents cap')
    if settings['family'] == 'new_family':
        return []
    parents = selected_incumbents(prior, settings)
    if protocol == REPRODUCTION_PROTOCOL:
        return parents
    # Historical jobs keep their original parent allocation when receipts are
    # reverified. Never reinterpret an old top-X round as all-pool reproduction.
    return parents[:settings.get('evolution_agents', 7)]


def agent_counts(prior, settings):
    evolution = len(evolution_parents(prior, settings))
    if settings.get('review_protocol') not in (None, REVIEW_PROTOCOL):
        raise ValueError('Unknown final-review protocol')
    review_count = settings.get('review_agents', 0)
    if settings.get('review_protocol') == REVIEW_PROTOCOL:
        review_count *= evolution + settings['research_slots']
    return {'evolution': evolution,
            'research': settings['research_slots'],
            'integrity_review': review_count,
            'review': int(settings['family'] == 'new_family'), 'coordinator': 1}


def round_allocation_seconds(prior, settings):
    counts = agent_counts(prior, settings)
    if settings['family'] == 'new_family':
        # Each pass has researcher/revision batches followed by the shared reviewer.
        batches = MIN_REVIEW_CYCLES * (ceil(counts['research'] / settings['agent_concurrency']) + 1)
    else:
        batches = ceil((counts['evolution'] + counts['research']) / settings['agent_concurrency'])
    batches += ceil(counts['integrity_review'] / settings['agent_concurrency'])
    return (batches + 2) * settings['agent_minutes'] * 60


def supervisor_configuration(prior, settings, job, binary):
    """Keep the lifecycle journal outside agent-writable job/repository roots."""
    counts = agent_counts(prior, settings)
    return {'protocol': BUDGET_PROTOCOL, 'job': str(job.resolve()),
            'repository': str(REPOSITORY), 'binary': binary, 'settings': settings,
            'expected': {'parent': [parent['name'] for parent in evolution_parents(prior, settings)],
                         **{kind: counts[key] for kind, key in
                            (('research', 'research'), ('review', 'review'), ('integrity_review', 'integrity_review'))}},
            'ledger_path': str(job.parent / '.agent-runtime' / f'{job.name}.json')}


def coordinator_command(binary, job, schema_path, final_path):
    """Expose only supervised child dispatch, without changing global CLI settings."""
    pythonpath = os.pathsep.join(filter(None, (str(REPOSITORY), os.environ.get('PYTHONPATH'))))
    command = [binary, '--no-daemon', '--search', 'exec', '--disable', 'multi_agent', '--approve-for-me']
    overrides = {'mcp_servers.evolution_agents.command': sys.executable,
                 'mcp_servers.evolution_agents.args': ['-m', 'ml.evolution.agent_runtime', '--config', str(job / 'runtime-config.json')],
                 'mcp_servers.evolution_agents.env.PYTHONPATH': pythonpath,
                 'mcp_servers.evolution_agents.required': True,
                 'mcp_servers.evolution_agents.startup_timeout_sec': 30,
                 'mcp_servers.evolution_agents.tool_timeout_sec': 45}
    for key, value in overrides.items():
        command.extend(['-c', f'{key}={json.dumps(value)}'])
    return [*command, '--add-dir', str(job), '--cd', str(REPOSITORY), '--json',
            '--output-schema', str(schema_path), '--output-last-message', str(final_path), '-']


def supervised_instructions(settings):
    if settings.get('agent_budget_protocol') != BUDGET_PROTOCOL:
        return ''
    policy = budget_policy(settings)
    return f'''
EXTERNALLY SUPERVISED AGENTS ({BUDGET_PROTOCOL}): Dispatch ALL authors and reviewers through
the evolution_agents MCP tools: start_agent, get_agents, wait_agents, send_message, close_agent.
Built-in multi_agent is disabled. Do not substitute shell-launched Codex processes, fabricated
agent IDs, or another delegation mechanism. The supervisor enforces concurrency and deadlines.
start_agent accepts kind (parent/research/review/integrity_review), prompt, optional parent and
candidate_name. A parent task must name its exact parent; an integrity reviewer must name its
ONE assigned frozen candidate. Each start creates an independent context; never share a final
reviewer with an author or another candidate. Save actual agent_id/thread_id, prompt_path and
artifact returned by get_agents/wait_agents in agents.json. Queued tasks have no agent ID yet.
wait_agents accepts task_ids and timeout_seconds <=30. Dispatch the configured tasks before
waiting; the supervisor queues excess work and starts clocks only on actual execution.

Each child has {policy['seconds']:g} seconds of wall time from its own start, not from round start.
Author search receives {policy['seconds'] - policy['export_seconds']:g} seconds; the final
{policy['export_seconds']:g} seconds are reserved for finalization. An early author reply does NOT
end the task: the supervisor resumes the SAME context with the remaining budget to inspect
failures, try credible alternative hypotheses and improve validation fitness. Every trial stays
in the journal. Retain the best independently validated version; never replace it with a worse
last attempt. Early stopping one fit is not permission to stop the whole candidate search.
The finalization-only turn must finish the best checkpoint, proposal and evidence, not start a
new fit. Shared deployment export and isolated final benchmarks still happen afterward, outside
each author's research allocation. The supervisor interrupts at finalization cutoff, then kills
overdue child process groups at the original deadline. No ordinary follow-up resets the clock.
Only a concrete documented blocker can end author search early. Report attempted paths and
what is needed to unblock; a missing final artifact/failed task cannot publish a successful round.

Child final replies follow the supervisor's JSON schema: status ready/blocked, summary, artifact
(nonempty job-local final proposal/report file), candidate_name (empty only for shared architecture
review). Candidate authors may internally explore many trials but export exactly ONE child/fresh
proposal. Reviewers may finish as soon as their assigned checks and report are complete.
send_message(task_id,message) supplies feedback within the ORIGINAL deadline. Only New Family
research/architecture-review feedback may use architecture_cycle=2 then3 to obtain the already
approved bounded revision allocations; keep the SAME agent identity and save the exchange.
No new task identity or budget reset may be used to evade a deadline. Do not close successful
tasks: collect their ready artifacts. close_agent is cancellation, not completion.
The outer worker copies and hashes the supervisor's private lifecycle ledger and independently
binds every agents.json task to it. Self-reported timestamps cannot replace this evidence.
BEFORE starting a final reviewer, save its candidate-scoped review package as JSON with candidate,
artifact_bundle (exact candidate, learned flag and files), and context including context_sha256.
Pass its job-local path as review_bundle to start_agent. The supervisor checks unique file paths,
all hashes, required roles and candidate scope BEFORE creating the reviewer task or charging time.
One file must have one record: do not list an evaluator again as a dependency. Fix any preflight
error and retry dispatch; never spend reviewer allocations on structurally invalid packages.
The package and its artifact graph are pinned at dispatch and must still equal the final result.
Do not activate native Goals in CLI children: external continuation is authoritative and bounded.
'''


def coordinator_prompt(config, job, manifests):
    settings = config['settings']
    new_family = settings['family'] == 'new_family'
    research_count = settings['research_slots']
    prior = json.loads(Path(config['prior']).read_text())
    final_reviewers = agent_counts(prior, settings)['integrity_review']
    reviewers_per_candidate = settings.get('review_agents', 0)
    parent_names = [parent['name'] for parent in evolution_parents(prior, settings)]
    round_number = config.get('round_number', prior['round'] + 1)
    runtime = [sys.executable]
    if os.environ.get('PYTHONPATH'):
        runtime = ['env', f"PYTHONPATH={os.environ['PYTHONPATH']}", *runtime]
    return f'''Run exactly one agent-guided jaw-detection evolution round requested by the local RSI dashboard.
Read AGENTS.md, .agents/skills/evolve/SKILL.md, .agents/skills/ml-agent/SKILL.md and its memory,
ml/evolution/README.md, and the jaw experiment README. Session settings below override old preferences.
Frozen prior result: {config['prior']}
Requested round number: {round_number}. Use this even when the retained pool comes from an earlier round.
Job output directory: {job}
Training manifest: {manifests['train']}
Validation manifest: {manifests['validation']}
Settings: {json.dumps(settings, sort_keys=True)}
Training protocol: {TRAINING_PROTOCOL}
Shared training policy: {json.dumps(policy_for(settings), sort_keys=True)}
{supervised_instructions(settings)}
Portfolio selection policy: {json.dumps(selection_parameters(settings), sort_keys=True)}
Reproduction protocol: {settings.get('reproduction_protocol', 'legacy-top-X')}
Final-review protocol: {settings.get('review_protocol', 'legacy-shared-review')}
Reviewers per candidate: {reviewers_per_candidate}; total final review assignments: {final_reviewers}.
Known Python runtime command: {shlex.join(runtime)}
Use that runtime for NumPy/OpenCV/PyAV/PyTorch and pass it unchanged to every child.
Do not search for Python environments elsewhere. Confine discovery to this repository,
this job, and the explicit dataset files referenced by its manifests. Do not recursively
scan the user's home, other worktrees, Library, Documents, Desktop, iCloud Drive, Photos,
Applications, external volumes or personal files. Do not access unrelated device integrations.
The frozen prior and its explicitly referenced implementation/model artifacts are also permitted
resume inputs, even when they live in an earlier job directory. Do not broadly discover other jobs.
If this exact runtime cannot import required dependencies, report an operational blocker
instead of broadening discovery or requesting personal/cloud-folder access.

Additional research direction from the dashboard:
<round-research-direction>
{settings.get('agent_prompt', '')}
</round-research-direction>
Pass this additional research direction verbatim to every researcher, parent-candidate,
and review subagent. Apply it within the configured scoring, split and workspace constraints.

The user permits custom learned models and any runtime video/IMU/ARKit inputs, online research,
and ambitious structural changes. Use native inputs, no clip identity, absolute/elapsed clip time,
button cues, or labels at inference. Preserve every pre-existing repository change. Prefer new
candidate modules and private checkpoints under this job. Keep source inputs read-only. Never launch detached background processes. Keep training and evaluation commands attached so
they are stopped with the coordinator on failure. Never
mutate canonical labels or the reference mount. Do not commit, push, deploy, or change credentials.
The frozen prior's weights saw old home/park data. Use them as diagnostic baselines only. Refit ALL
learned candidates using only the training manifest before scoring validation. Architecture and
decoder choices may use training and validation, never test. The reserved test manifest must not
be read or evaluated during this evolutionary round. Random episode splitting is exploratory and
may share capture conditions/overlapping footage; do not claim independent session generalization.

EXPERIMENT GUIDELINES (forward these verbatim to every evolution/research/review agent):
{EXPERIMENT_GUIDELINES}
Each fit gets at most the shared max_seconds wall time, including optimization and
periodic validation, after input preparation. Do not change this cap between candidates;
record device, threads, elapsed time and any epoch-boundary overrun. Parallel search is
permitted, so disclose resource contention rather than claim identical effective compute.
The existing agent_minutes allocation still bounds all of each agent's trials/research.
Use TrainingMonitor(job, unique_trial_id, plan, context, policy=policy_for(settings)).
The plan kind is iterative or noniterative; include candidate_name, hypothesis, objective,
capacity, regularization, seed and resources={{device,threads}}. Seed is a nonnegative
integer (null only for a deterministic noniterative fit). Optional candidate_names aliases
must be predeclared and share exactly the same frozen parameters; differing decoders
may share a fit, but differently wrapped/transformed model states need explicit evidence.
Iterative plans also declare
max_epochs and selection_decoder before fitting. Context pins train_manifest_sha256 and
validation_manifest_sha256. Use can_start_epoch() before every epoch, observe() after every
epoch with measured train_loss/validation_loss/validation_score, validation_predictions,
JSON-safe frozen parameters and optional opaque artifact paths, then finish(). Use its
selected_checkpoint() to export the best model, not the current final optimizer state.
Keep inference-mode observation from advancing training RNG state. Referenced opaque
weight files must be immutable per checkpoint; never overwrite the saved best weights.
Stop for patience,
declared epoch ceiling or time budget; record crashes with fail() or its context manager.
Validation_score means jaw-event F1, recomputed with the trusted evaluator and fixed
selection_decoder/tolerance. The loss remains the model's declared differentiable
objective. One subsequent decoder-tuning stage may use validation after checkpoint
selection; record its trials separately, not a fresh decoder sweep per epoch. Do not
use test, train on validation, or select an epoch using training loss/fitness instead.
Record evaluation.training_receipts as candidate-name -> hashed receipt from finish(),
covering every fitted candidate, including refitted baselines. Keep every attempt in
the monitor's job/trials.jsonl (completed or crash), including discarded proposals;
never erase a failed fit to make the search look better. Attach the selected model's
history to candidate_metadata for charts. For opaque checkpoints, hash all referenced
files and bind export evidence to the selected weights for final reviewer inspection.
Log final-decoder tuning separately with its fixed checkpoint and validation-only trials.
Final reviewers must inspect checkpoint selection, regularization rationale and journal
completeness as well as the existing streaming probes. A noniterative label cannot be
used to exempt a neural optimizer from validation monitoring.

Use actual subagents, not a list of unexecuted ideas. Maximum concurrent child agents is
{settings['agent_concurrency']}. Each candidate agent has up to {settings['agent_minutes']} minutes
for primary-source research, setup, training, and testing. New Family feedback/revision and review
passes each receive a fresh allocation of up to {settings['agent_minutes']} minutes per cycle.
Dispatch a distinct parent-to-child task
for every selected parent, in batches when necessary. Each parent agent must compare its own
failures with other families, explain a concrete child, and sometimes attempt a structural change.
When this concurrency limit accommodates all selected evolution and research agents, dispatch
ALL of those tasks before waiting for any one to finish. Let their research and implementation
overlap; do not serially wait through parent tasks. Share prepared inputs with provenance rather
than duplicating video decoding. Keep measured inference/latency replay passes isolated from
training or other benchmarks so parallel agent work does not contaminate fitness timings.
Evolve exactly these parents under the configured reproduction protocol within architecture
family '{settings['family']}' (all means EVERY member of the current retained pool):
{json.dumps(parent_names)}
For all-pool-v1, dispatch exactly one evolution agent and evaluate exactly one mutated
child for EVERY listed parent, including low-ranked and protected members. There is no
top-X cap. In a specific family scope, every selected incumbent/catalog re-entry candidate
reproduces once; New Family runs no evolution agents. pool_size limits NEXT-round
survivors, not current reproduction: after reducing pool_size, reproduce all current
selected incumbents this transition round, then reproduce each smaller survivor next round.
Evaluate all retained baselines in this family scope, including parents not selected for evolution.
Pool size {settings['pool_size']} limits retained competitors, not agent counts.
Dispatch exactly {research_count} distinct research agents. Each research agent independently
researches, implements, and evaluates exactly ONE fresh proposal, with no required parent.
Research proposals may introduce other families even when an existing family is selected.
Coordinate their briefs to avoid duplicate proposals. Do not ask one researcher for multiple ideas.
New Family selected: {new_family}. If true, EACH research agent must propose a genuinely new architecture family
beyond current competitors, with runnable implementation, trained weights if needed, and measured
validation scores. Compare it with the selected incumbent baselines, without requiring mutations
of existing parents in this special mode. A new method name or thresholds alone are not a new
family. Have ONE separate review agent review all new architecture claims against current families
and each other. In this mode there are zero evolution agents regardless of the evolution setting.
Keep the same researcher and reviewer agents available for two-way feedback, routed through the
coordinator if necessary. Review the architecture early, before expensive fitting, and verify the
final implementation again after material architecture changes. A reviewer rejection must include
specific actionable feedback; send it to the owning researcher, have that researcher revise its
ONE proposal, then ask the SAME reviewer to reassess it against existing and other proposed families.
An accepted proposal can finish immediately. For each unresolved proposal, complete at least
{MIN_REVIEW_CYCLES} proposal/revision -> review cycles before giving up for architectural reasons.
Do not replace the researcher with additional research agents or count retries as fresh proposals.
Every rejection before the final cycle must lead to an actual revised artifact, not a repeated review.
If any proposal remains rejected after these cycles, fail the round explicitly; do not publish a
partial round or mislabel an existing family as new. This is a novelty/implementation review, not
a requirement for the new family to beat incumbents. Tooling, authentication, timeouts, cancellation
and other operational failures may stop earlier; record them honestly rather than fabricating cycles.

FINAL INTEGRITY GATE: Dispatch {final_reviewers} NEW independent final reviewers after candidate
implementations, fitted weights, decoder parameters, evaluation predictions and timings are frozen,
before any candidate enters next_pool or the round is published. They are distinct from ALL
parent/research/architecture agents. Close finished author/architecture agents after saving their
receipts if necessary to free concurrency slots; batch final reviewers within agent_concurrency.
Under per-candidate-v1, assign exactly {reviewers_per_candidate} freshly initialized reviewer(s)
to EACH challenger. Every assignment uses a new agent ID and fresh context, shared with no other
candidate assignment. Spawn without inheriting the coordinator/author/reviewer conversation
(fork_turns='none' or the available API's equivalent). Pass only the assigned candidate's frozen
implementation, training/evaluation evidence, relevant fixtures, objective and protocol instructions;
do not seed it with another candidate's review or another reviewer's verdict. Do not reuse one
reviewer across candidates or use authors/architecture reviewers as final reviewers. Each task and
report is scoped to exactly ONE candidate; use the schema below to bind that assignment.
They inspect candidate artifacts read-only, writing only their own reports and probe evidence.
The shared workspace is not a per-reviewer read-only OS sandbox: frozen hashes must be checked
after review, and any change requires refreezing and fresh reviews. Tell EVERY proposing agent
up front that all its code, model artifacts and inference behavior will face this independent gate.
Review ALL challengers, including proposals that may be pruned, so a high unreviewed score cannot
become a chart leader. Every candidate needs all of its assigned reviewers' approval; any
missing, stale, rejected or contradictory review fails the round and preserves the previous pool.
Repairs require the owning author's original allocation to still be active; never reset a finished
author's deadline or create a substitute author to bypass it. Otherwise report the rejection and
preserve the prior pool. All assigned reviewers must approve the exact final version, with fresh
evidence after any change. Do not silently change retention policy to bypass rejection.

Deployment is a nonstop causal stream, NOT independently reset episodes. Prohibit reward hacking:
fixed squeeze at 3 seconds, release at duration-3 seconds, labels/button metadata/filenames/IDs,
absolute or elapsed clip time, elapsed-frame clocks (including an implicit EMA startup clock),
future frames/sensors, clip length/endpoints, per-episode state reset or assumed-open starts.
Strip labels, row.jaw_reference, capture/button metadata, clip IDs, filenames and paths from
the inference payload before calling the native detector; an unused label field is still an
unnecessary leakage surface. Allow only current frame/causal sensor values and monotonic
timestamps needed for physical alignment, not a predictor feature encoding capture position.
A blind predictor close@3s/open@(duration-3s) can score perfectly on this aligned dataset without
seeing any media; high clip F1 alone is not evidence of a valid model. First-frame references and
warmup may not assume every capture starts with open jaws. A native continuous detector must
preserve state across arbitrary chunk boundaries, including boundaries in the middle of a hold.
Keep bounded native state/history rather than recomputing ever-growing complete stream history
through a batch wrapper. A disclosed one-time startup warmup is allowed for arbitrary initial
jaw states; resetting or repeating warmup at labeled episode/event boundaries is prohibited.
Reviewers must run the actual frozen implementation with real sample-prefix insertion (different
event positions relative to startup), not only translated timestamps. Compare uninterrupted and
arbitrarily chunked repeated-event streams using the SAME retained native state. Test >=12-second
event-free streams starting both open and already closed; do not allow phantom squeeze events
from an assumed initial open state. Also test prefix causality by changing future samples.
Use train/validation or synthetic controls only; reserved test remains inaccessible. These are
integrity tests, not extra model-fitting or speed measurements. Do not fabricate pass-through
probe scripts that report success without calling the real candidate update/step implementation.

The configured evaluation_protocol is {settings.get('evaluation_protocol', 'clip_replay-v1')}.
Record it unchanged in results.json. Integrity approval does NOT convert clip-replay F1 into
continuous-stream accuracy. Keep old retained incumbents explicitly legacy_unreviewed unless
separately reviewed; never claim the final gate retroactively approved the historical pool.

Prepare the plan and replay real candidates through ml/evolution.run_round or an adapter preserving
its parent-child comparison, lineage, seeds, a pool of at most ten and existing portfolio policy.
Final admission MUST call dashboard_selection.select_evaluated(incumbents, challengers,
prior, settings, candidate_metadata), not the historical fixed PORTFOLIO constant or manual
top-N sorting. Merge its ranked/next_pool/protected/roles/selection_policy into results.json.
This adapter uses the requested protected_slots, mutation_attempts and family_limit;
effective protection is bounded by pool_size minus one, reserving champion capacity,
and the soft family cap by pool_size. A family-scoped job with fewer measured candidates
retains at most that available count. When protection is reduced/disabled, inherited
active lanes are trimmed by incumbent fitness to the effective cap. Family identity
comes from reviewed candidate_metadata; preserve incumbent families from the prior.
Fresh protection prefers underrepresented families, then complementary clip coverage,
then the normal score/rank tie-break. At most one new lane starts per round. Protection
expires after mutation_attempts actual child attempts, not elapsed rounds. Under
all-pool-v1 every selected protected lineage receives a child in an ordinary round;
New Family is explicitly a research-only round and does not consume mutation attempts.
The outer gate recomputes per-clip coverage from saved validation predictions and repeats
selection, rejecting mismatched next_pool, roles, protected counters or knob settings.
Ordinary mode evolves every selected incumbent plus researcher proposals. Never substitute the old
bounded-mutation dashboard worker. Implement a job-local evaluation adapter as needed so it obeys
the configured weights, timing tolerance, speed budget, split, and any new trained models.
Fitness = jaw_weight * validation jaw-event F1 + (1-jaw_weight) * speed score.
F1=2*matched/(2*matched+missed+false_positives), matching event type once within match_seconds at
actual confirmation time. Speed=min(1,max(0,(frame_budget_ms-p95_ms)/(frame_budget_ms-full_speed_ms))).
Prepared-frame p95 includes jaw features and decoder. No deposit score. Record close/open counts
separately, latency scope, failures and every rejected candidate. Never score a mock detector.
Final benchmark contract: {settings.get('benchmark_protocol', 'legacy-prototype')}.
For deployment-v1, derive BOTH final train/validation event F1 and measured latency from the SAME
frozen deployable artifact, preprocessing and event decoder. Python/NumPy/PyTorch/Hugging Face
are unrestricted for research, fitting and provisional accuracy checks. Do NOT require a manual
C++ rewrite of every idea: Core ML, native C++/Swift/Metal, ONNX Runtime Mobile, ExecuTorch or
another supported iOS artifact may be appropriate. A Python wrapper invoking the real exported
deployment artifact is allowed; running the original Python/PyTorch predictor is not final evidence.
Use the shared export/benchmark stage in the coordinator's reserved preparation/evaluation time;
keep conversion and benchmarking outside each proposing agent's allotted research window.
Export once, freeze weights/code, replay every training and validation clip through that artifact,
then compute F1 and p95 from its saved outputs. Never combine prototype predictions with native
timings or silently reuse historical Python measurements. Preserve conversion failures as research
evidence; an unexported prototype cannot enter the final scored pool. Final reviewers inspect this.
The laptop can execute the deployment runtime during rounds with the exact backend/precision,
compute units and hardware disclosed. Physical-phone validation remains a separate milestone,
not a requirement to run the phone after every round. Never label a laptop surrogate as phone speed.
Write evaluation.deployment_benchmarks[name]={{path,sha256}} for ALL evaluated candidates, incumbents
and challengers. Each report records protocol='deployment-v1', exact candidate, runtime fields
engine/device/compute_units/precision/mobile_target='iOS'/format (native,coreml,onnx,executorch,tflite,metal),
and artifacts=[{{path,sha256,roles:[...]}}] covering runtime, model, preprocessor, decoder.
Include hashed runner, actual command, and hashed outputs. The output JSON contains exact candidate,
runtime and artifact_hashes; preparation_complete/warmup_complete/thermal_nominal/
same_preprocessing_and_decoder=true, test_evaluated=false, serial started/finished_uptime_seconds,
and splits={{train:[...],validation:[...]}} in exact manifest order. Each clip row has clip,
sample_times_seconds, scores, timings_ms and events. evaluation predictions/training_predictions
must exactly equal these exported-runtime events; timings_ms must flatten the validation native
durations in manifest order. Keep all benchmark reports ordered by actual non-overlapping execution.
See deployment_benchmark.py for the completion audit. Frozen challenger review bundles must also
include the exact deployed artifacts, not just the prototype/exporter. A .py integrity-probe entrypoint
may be an adapter that invokes this real deployment artifact; it must not substitute prototype logic.
Target F1={settings['target_f1']} applies to validation; even if reached, finish the current comparison
and receipt audit, then stop. This is one round only. No deployment or test-set evaluation.

Write agent-progress.json atomically inside the job after each real stage/task completes, with
phase, completed_tasks and total_tasks plus a short message. Stages are preparation, research,
evolution, evaluation, integrity_review, and audit. Do not claim tasks have completed merely because dispatched.
Keep exact prompts, Codex child IDs, proposal artifacts, trained parameters, scores and logs.

Write results.json with round={round_number}, incumbents (all evaluated baselines), ranked, challengers, next_pool, seen, seed,
feature_parameters, history, candidate_metadata, mode='agent_guided', reporting='validation', actual fitness_weights,
settings, benchmark_protocol matching settings, input_manifest paths and evidence. Candidate records must remain compatible with
JointCandidate. Every ranked entry contains candidate, development (the validation jaw-event
counts, retained field name for UI compatibility), jaw_by_event, p95_ms, speed_score, fitness,
clip_f1, worst_clip_accuracy, zero_jaw_clips. Use validation-only per-clip predictions.
Also record split_scores for every evaluated candidate as an object with train and validation
event metrics (f1, matched, missed, false_positives), and test=null. Replay the fitted model on
training clips to measure train metrics; do not substitute fitting loss for event F1.
For iterative learned models, save training AND validation loss at each epoch using the
same named objective/reduction. Validation runs without gradients, dropout or augmentation;
it never supplies fitting examples, and the test split remains untouched. Save a JSON
history {{"metric":"objective name", "points":[{{"epoch":1,"train_loss":number,
"validation_loss":number}}],"note":"measurement/weighting details"}} inside this job.
Audited training receipts are the canonical source for new dashboard loss curves; no
duplicate chart metadata/model serialization is required. Legacy optional curves may
link from candidate_metadata[name].training_history as {{"path":job-relative path,
"sha256":file digest,"model_path":job-relative frozen model JSON path,
"model_sha256":model file digest}}. This legacy model JSON is bare parameters matching
feature_parameters[method], not the monitor's selected-checkpoint.json wrapper.
Copy retained histories and model evidence into the new job when carrying unchanged
models forward; refits need new history tied to the new model. Do not invent old losses or treat tree counts, decoder
sweeps, final F1, or closed-form fits as epoch loss curves. For noniterative candidates,
omit training_history. Saving curves must not alter the agreed fitting/selection rules.
Every selected evolution parent must have an evaluated mutated child in challengers whose candidate.parent
is its exact name, created_round is next round, and genotype differs from the parent. Ordinary mode
requires exactly research_slots evaluated fresh research candidates (parent null, next created_round,
unseen genotype), one per distinct research agent. New Family requires each research candidate to
introduce a distinct family absent from the prior pool,
with a separate architecture review receipt and a genuinely new underlying family claim.
For every novel-method candidate, supply candidate_metadata[name] with family (one or two words),
differentiator (three or four words), and architecture as [[stage title, description], ...]. These
must describe the reviewed runtime implementation, never invented architecture names.
Write evaluation.json containing training_clip_ids (exact training manifest IDs), fitted_candidates
(names of every learned candidate refitted on training only), validation_clip_ids (exact manifest IDs), predictions mapping
candidate name to mapping clip ID to [kind,seconds] detections, and timings_ms mapping candidate
name to native per-frame measured times. Include no test predictions.
Also save training_predictions mapping each evaluated candidate name to its training clip ID
and [kind,seconds] detections, so the dashboard can independently audit training F1.
Use the existing accuracy evaluator and detector timing protocol. Save the evaluator source and invocation in this job.
Write agents.json as {{"tasks":[{{"kind":"parent" or "research" or "review", "parent":name or null,
"agent_id":actual Codex child ID,"status":"completed","artifact":existing path in job,
"proposal_candidate":exact evaluated candidate name for a research task or null,
"prompt_path":path to the exact prompt sent to this child}}],
"new_families":[new architecture family names, empty in ordinary mode]}}. The task artifact must contain real output,
not an empty placeholder. In New Family mode, also include architecture_reviews, one per researcher:
[{{"proposal_candidate":final candidate name,"research_agent_id":owning child ID,
"review_agent_id":the shared reviewer child ID,"cycles":[{{"attempt":1,
"proposal_artifact":path to this version's proposal/implementation evidence,
"research_prompt_path":path to the actual initial or feedback/revision prompt,
"review_prompt_path":path to the actual review/reassessment prompt,
"review_artifact":path to JSON containing verdict (accepted or changes_requested), actionable feedback,
proposal_artifact (the version reviewed), and, on acceptance, candidate (exact final candidate record)
and family (the final architecture family)}}]}}]. Save distinct, nonempty prompt and proposal/review
artifacts for every cycle. Keep the dashboard direction in every feedback prompt too. Rejected
versions remain as evidence; only the final accepted candidate is evaluated as the research proposal.
If novelty remains unresolved after at least {MIN_REVIEW_CYCLES} cycles, return status='failed',
failure_kind='architecture_review' and a valid agent_manifest_path with the full exchange history.
For an early operational stop use failure_kind='operational' and explain the concrete blocker.
Record partial/failed agent tasks too. If work cannot finish or tooling
is blocked, return status='blocked' or 'failed' and explain; do not invent completion.
Your final response must be the requested JSON with status, message, failure_kind ('none' on success), results_path,
agent_manifest_path and evaluation_path, all pointing inside this job. The dashboard wrapper
validates these receipts and evaluation counts before it publishes a completed round.

For the final gate, add result.candidate_artifacts for EVERY challenger:
{{candidate_name:{{"candidate":exact candidate record,"learned":boolean,"files":[{{"path":job-local
frozen file,"sha256":digest,"role":"implementation" or "evaluator" or "model" or "config" or "dependency"}}]}}}}.
Freeze the complete inference dependency graph, fitted parameters and evaluation adapter; require
implementation + evaluator and a model file for learned models. Review copies must be inside this
job even when the implementation originally lived in the repository or a prior job.
Add one task per final reviewer with kind='integrity_review', actual distinct child ID, completed
status, candidate_name (the ONE assigned challenger), fresh_context=true, saved prompt_path and
artifact pointing at that reviewer's report. Add agents.json integrity_reviews=[{{"reviewer_id":child ID,
"candidate_name":assigned candidate name,"artifact":report path}}]. Each report contains reviewer_id,
candidate_name, fresh_context=true, context_sha256, and candidates=[{{"candidate":exact assigned record,
"verdict":"approved" or "rejected",
"artifact_hashes":{{job-relative frozen path:SHA256}},"inspected_paths":[all frozen files],
"findings":[substantive source-inspection conclusions],"checks":[{{"kind":probe kind,"passed":boolean,
"evidence":path to evidence JSON}}]}}]. The candidates array has exactly ONE assigned candidate.
Across all fresh reviewers, every challenger (not just finalists) has exactly the configured
reviewers_per_candidate coverage, with no reviewer ID shared between candidate assignments.
Five required distinct probe kinds: timestamp_origin_shift, variable_prefix, continuous_multiple_events,
no_event_stream, prefix_causality. Evidence JSON has kind, candidate_name, entrypoint (actual native
function), artifact_hashes, runner={{path,sha256}}, command=[actual command including runner path],
inputs=[{{path,sha256}}], outputs={{path,sha256}}, observations and details. Output JSON has kind,
candidate_name, native_calls>0 and streams=[{{sample_count:integer>1,detections:[[close/open,seconds],...]}}].
For timestamp_origin_shift, details contains distinct offsets_seconds and equivalent_after_translation=true;
for variable_prefix, distinct positive prefix_lengths_seconds and real_prefix_samples_inserted=true;
for continuous_multiple_events, segments>=2, reference_events>=4, native_state_persisted=true,
state_reset_between_segments=false and arbitrary_chunk_boundaries=true, with equal sample counts
and native detections between uninterrupted and chunked outputs. Record reference_detections as
at least four alternating close/open events inside the actual sample timeline and
chunk_boundary_indices as interior sample indices, including one during a held squeeze;
the chunked output records those same chunk_boundaries. For no_event_stream, duration_seconds>=12,
reference_events=0, initial_states=['open','closed'] and no native detections in either stream;
for prefix_causality, altered_future_suffix=true, matching_prefix_outputs=true and two actual outputs.
Compute the frozen review context with dashboard_integrity.review_context(job, result, settings,
{{'train':train_manifest,'validation':validation_manifest}}, evaluation_path) after evaluation.json
is frozen. Put its context_sha256 in every reviewer report and probe evidence; changing settings,
split manifests or evaluation predictions/timings invalidates all previous reviews. Each reviewer
must save separate probe evidence and outputs, rather than reuse another reviewer's receipts.
Every output stream also contains sample_times_seconds and scores arrays with one finite native
score per sample. Native calls must cover all samples. Each probe includes entrypoint_source=
{{path,sha256}} pointing to the actual callable's frozen Python implementation, not an unused label.
The checker recomputes origin-translated timestamps/scores/events; uninterrupted/chunked sample
timelines, scores and events must agree; no-event streams must actually cover >=12 seconds at
regular sampling with >=120 samples; future-prefix tests record shared_prefix_samples and compare
native scores/events before that cutoff. Variable-prefix fixtures must have different real sample
counts and include padding_sensitivity_analysis: source-supported interpretation of changed
predictions vs forbidden startup clocks. Arbitrary real-input changes can legitimately influence
adaptive history; weaker F1 or imperfect padding invariance alone is not evidence of cheating.
Do not require a weak but honest model to detect every repeated reference event to pass integrity.
For hand-written candidates with no fitted weights, freeze a complete config/parameter file instead
of omitting runtime parameters; a candidate listed as fitted cannot declare learned=false.
Use failure_kind='integrity_review' for unresolved final rejection. Do not self-stamp integrity approval:
the wrapper independently verifies receipts and hashes and stamps approved candidate names server-side.
'''


def research_disclosure(settings, prior, round_number=None):
    """Use the launch prompt template for a side-effect-free dashboard preview."""
    job = Path('<job-directory>')
    config = {'settings': settings, 'prior': str(prior)}
    if round_number is not None:
        config['round_number'] = round_number
    manifests = {name: job / f'{name}.json' for name in ('train', 'validation', 'test')}
    return {
        'prompt': coordinator_prompt(config, job, manifests),
        'harness': f"One local Codex CLI coordinator with a runner-owned MCP supervisor; one evolution agent for EVERY selected incumbent (zero in New Family mode), one independent researcher per fresh proposal, one architecture reviewer in New Family mode, then {settings.get('review_agents', 0)} freshly initialized final reviewer(s) PER challenger ({agent_counts(json.loads(Path(prior).read_text()), settings)['integrity_review']} total assignments). Each reviewer sees only its assigned candidate and is never reused across candidates. Each started child has an enforced wall deadline; early author finishes resume within it and the final window is reserved for export. Next-pool capacity does not cap current reproduction. Final rejection blocks publication. Rejected new-family proposals receive at least three architecture research/review cycles before architectural failure.",
        'agent_counts': agent_counts(json.loads(Path(prior).read_text()), settings),
        'selection_policy': selection_parameters(settings),
        'tools': [
            'Supervised child dispatch/resume with per-agent wall deadlines, reserved finalization and bounded concurrency',
            'Live web search for primary-source research (--search)',
            'Terminal commands, Python, model training and measured evaluation',
            'Workspace files and the writable job directory; frozen reference inputs are read-only',
        ],
        'permissions': 'workspace-write sandbox with automatic approval review. Repository instructions and connected tools are loaded from the local Codex configuration; availability can vary at launch.',
        'instructions': ['AGENTS.md', '.agents/skills/evolve/SKILL.md', '.agents/skills/ml-agent/SKILL.md',
                         '.agents/skills/ml-agent.md', 'ml/evolution/README.md',
                         'ml/experiments/jaw-trigger/README.md'],
        'artifacts': 'Prompts, child IDs, supervisor-owned lifecycle ledger, proposals, complete trial journal, pinned training plans, losses, best validation checkpoints, evaluator source, predictions, measured timings and audit receipts are saved in the job directory.',
        'preview_note': 'This is the coordinator prompt template with the current form settings. Job paths are filled in at launch. The coordinator writes the individual child prompts during the round.',
    }


def artifact(job, filename):
    path = Path(filename)
    path = path if path.is_absolute() else job / path
    path = path.resolve(strict=True)
    if not path.is_relative_to(job.resolve()) or not path.is_file():
        raise ValueError('Agent artifacts must be files inside this job')
    return path


def verify_architecture_reviews(job, receipts, settings, candidates=None, metadata=None, *, failed=False):
    """Audit per-proposal dialogue, including the minimum effort before novelty failure."""
    researchers = [task for task in receipts.get('tasks', []) if task.get('kind') == 'research']
    reviewers = [task for task in receipts.get('tasks', []) if task.get('kind') == 'review']
    researcher_ids = {task.get('agent_id') for task in researchers}
    if (len(researchers) != settings['research_slots'] or len(researcher_ids) != len(researchers)
            or not all(researcher_ids) or len(reviewers) != 1
            or not reviewers[0].get('agent_id') or reviewers[0]['agent_id'] in researcher_ids):
        raise ValueError('Architecture dialogue requires the owning researchers and one independent reviewer')
    dialogues = receipts.get('architecture_reviews', [])
    if (len(dialogues) != len(researchers)
            or {item.get('research_agent_id') for item in dialogues} != researcher_ids):
        raise ValueError('Every new-family researcher needs saved architecture review cycles')
    tasks = {task['agent_id']: task for task in researchers}
    reviewed_candidates = set()
    rejected = False
    paths_used = set()
    for dialogue in dialogues:
        name = dialogue.get('proposal_candidate')
        if (not name or name in reviewed_candidates
                or tasks[dialogue['research_agent_id']].get('proposal_candidate') != name
                or dialogue.get('review_agent_id') != reviewers[0]['agent_id']):
            raise ValueError('Architecture review must map to the owning researcher and shared reviewer')
        reviewed_candidates.add(name)
        cycles = dialogue.get('cycles', [])
        if not cycles:
            raise ValueError('Architecture dialogue requires at least one real review cycle')
        previous_feedback, previous_proposal = None, None
        for attempt, cycle in enumerate(cycles, 1):
            if type(cycle.get('attempt')) is not int or cycle['attempt'] != attempt:
                raise ValueError('Architecture review cycles must be consecutively numbered')
            paths = {key: artifact(job, cycle[key]) for key in
                     ('proposal_artifact', 'research_prompt_path', 'review_prompt_path', 'review_artifact')}
            if (len(set(paths.values())) != len(paths) or paths_used.intersection(paths.values())
                    or any(not path.stat().st_size for path in paths.values())):
                raise ValueError('Each review cycle needs distinct nonempty proposal, prompts and review artifacts')
            paths_used.update(paths.values())
            proposal = paths['proposal_artifact'].read_bytes()
            research_prompt = paths['research_prompt_path'].read_text()
            review_prompt = paths['review_prompt_path'].read_text()
            if previous_feedback and (previous_feedback not in research_prompt or proposal == previous_proposal):
                raise ValueError('Reviewer feedback must reach the researcher and produce a revised proposal')
            direction = settings.get('agent_prompt')
            if direction and any(direction not in prompt for prompt in (research_prompt, review_prompt)):
                raise ValueError('Every architecture feedback prompt must preserve the dashboard direction')
            review = json.loads(paths['review_artifact'].read_text())
            feedback = review.get('feedback')
            if (review.get('verdict') not in ('accepted', 'changes_requested')
                    or not isinstance(feedback, str) or not feedback.strip()
                    or artifact(job, review['proposal_artifact']) != paths['proposal_artifact']):
                raise ValueError('Each review must identify its proposal version, verdict and actionable feedback')
            if review['verdict'] == 'accepted':
                if attempt != len(cycles):
                    raise ValueError('An accepted architecture must be the final reviewed version')
                if candidates is not None and (review.get('candidate') != candidates.get(name)
                        or review.get('family') != metadata.get(name, {}).get('family')):
                    raise ValueError('Architecture acceptance must cover the exact final candidate and family')
            elif attempt == len(cycles):
                rejected = True
                if not failed:
                    raise ValueError('Completed New Family rounds require accepted architecture reviews')
                if len(cycles) < MIN_REVIEW_CYCLES:
                    raise ValueError('Try at least three research/review cycles before architectural failure')
            previous_feedback, previous_proposal = feedback, proposal
    if failed and not rejected:
        raise ValueError('Architectural failure requires an unresolved proposal after three review cycles')
    if candidates is not None and reviewed_candidates != set(candidates):
        raise ValueError('Architecture acceptance must cover every evaluated research proposal')


def verify_completion(job, final, config, manifests):
    from round_one import accuracy
    from run_joint_round import JointCandidate, joint_genotype, read_genotype
    import round_one
    import numpy as np

    for name, digest in config.get('_trusted_input_hashes', {}).items():
        if sha256(artifact(job, name).read_bytes()).hexdigest() != digest:
            raise ValueError('Pinned input manifests changed during the agent round')

    if final.get('status') != 'completed':
        if config['settings']['family'] == 'new_family':
            if final.get('failure_kind') == 'architecture_review':
                receipts = json.loads(artifact(job, final['agent_manifest_path']).read_text())
                verify_architecture_reviews(job, receipts, config['settings'], failed=True)
            elif final.get('failure_kind') not in ('operational', 'integrity_review'):
                raise ValueError('New Family failures must distinguish architectural exhaustion from operational blockers')
        raise ValueError(final.get('message') or 'The agent did not complete this round')
    result_path = artifact(job, final['results_path'])
    result = json.loads(result_path.read_text())
    receipts = json.loads(artifact(job, final['agent_manifest_path']).read_text())
    evaluation = json.loads(artifact(job, final['evaluation_path']).read_text())
    prior = json.loads(Path(config['prior']).read_text())
    settings = config['settings']
    if result.get('round') != config.get('round_number', prior['round'] + 1) or result.get('mode') != 'agent_guided' or result.get('reporting') != 'validation':
        raise ValueError('The result is not the requested agent-guided validation round')
    if result.get('settings') != settings or result.get('fitness_weights') != {'jaw_f1': settings['jaw_weight'], 'speed_score': 1 - settings['jaw_weight']}:
        raise ValueError('The result settings and fitness weights must match the submitted job')
    if result_path != (job / 'results.json').resolve():
        raise ValueError('The completed round must be saved as results.json')
    if not result.get('ranked') or not 1 <= len(result.get('next_pool', [])) <= settings['pool_size']:
        raise ValueError('The agent result has an invalid candidate pool')
    ranked = result['ranked']
    if len({entry['candidate']['name'] for entry in ranked}) != len(ranked):
        raise ValueError('Retained candidates must have unique names')
    if result['next_pool'] != [entry['candidate'] for entry in ranked]:
        raise ValueError('The next pool must match the ranked retained candidates')
    if any(not isfinite(entry['fitness']) for entry in ranked) or [entry['fitness'] for entry in ranked] != sorted((entry['fitness'] for entry in ranked), reverse=True):
        raise ValueError('Ranked candidates must have finite descending fitness')
    tasks = receipts.get('tasks', [])
    completed = [task for task in tasks if task.get('status') == 'completed']
    selected = selected_incumbents(prior, settings)
    parents_to_evolve = evolution_parents(prior, settings)
    incumbents = result.get('incumbents', [])
    if {entry['candidate']['name'] for entry in incumbents} != {candidate['name'] for candidate in selected}:
        raise ValueError('Evaluation must include every selected incumbent baseline')
    incumbent_configs = {entry['candidate']['name']: entry['candidate'] for entry in incumbents}
    for candidate in selected:
        if incumbent_configs[candidate['name']] != candidate:
            raise ValueError('Incumbent configurations must match the frozen parent pool')
    challengers = result.get('challengers', [])
    baseline_names = [entry['candidate']['name'] for entry in incumbents]
    challenger_names = [entry['candidate']['name'] for entry in challengers]
    if (len(baseline_names) != len(set(baseline_names)) or len(challenger_names) != len(set(challenger_names))
            or set(baseline_names) & set(challenger_names)):
        raise ValueError('Incumbents and challengers must have distinct unique candidate names')
    eligible = {entry['candidate']['name']: entry['candidate'] for entry in [*incumbents, *challengers]}
    if any(eligible.get(entry['candidate']['name']) != entry['candidate'] for entry in ranked):
        raise ValueError('Every retained candidate must be an unchanged incumbent or a reviewed challenger')
    prior_methods = {candidate['method'] for candidate in candidate_catalog(prior)} | set(prior.get('feature_parameters', {}))
    seen = {read_genotype(item) for item in prior.get('seen', []) if len(item) in (8, 9, 11)}
    seen.update(joint_genotype(JointCandidate(**candidate)) for candidate in prior['next_pool'])
    research = [entry for entry in challengers if entry['candidate'].get('parent') is None
                and entry['candidate'].get('created_round') == result['round']
                and joint_genotype(JointCandidate(**entry['candidate'])) not in seen]
    if len(research) != settings['research_slots'] or len({joint_genotype(JointCandidate(**entry['candidate'])) for entry in research}) != settings['research_slots']:
        raise ValueError('The round requires one evaluated fresh candidate per research agent')
    if settings['family'] == 'new_family':
        old_families = {candidate_family(candidate, prior).casefold() for candidate in candidate_catalog(prior)}
        new_families = [result.get('candidate_metadata', {}).get(entry['candidate']['name'], {}).get('family', '').casefold()
                        for entry in research]
        if (any(entry['candidate']['method'] in prior_methods for entry in research)
                or not all(new_families) or len(set(new_families)) != len(new_families)
                or set(new_families) & old_families):
            raise ValueError('Every New Family research agent must introduce a distinct new architecture family')
        if {family.casefold() for family in receipts.get('new_families', [])} != set(new_families):
            raise ValueError('New Family requires reviewed architecture names for every proposal')
    else:
        for parent in parents_to_evolve:
            children = [entry['candidate'] for entry in challengers
                        if entry['candidate'].get('parent') == parent['name']
                        and entry['candidate'].get('created_round') == result['round']]
            if settings.get('reproduction_protocol') == REPRODUCTION_PROTOCOL and len(children) != 1:
                raise ValueError('Every selected incumbent needs exactly one evaluated child under all-pool-v1')
            if not any(joint_genotype(JointCandidate(**child)) != joint_genotype(JointCandidate(**parent)) for child in children):
                raise ValueError('Every selected parent needs an evaluated mutated child')
    if settings.get('reproduction_protocol') == REPRODUCTION_PROTOCOL:
        children = [entry['candidate'] for entry in challengers if entry['candidate'].get('parent') is not None]
        expected_parents = {parent['name'] for parent in parents_to_evolve}
        if (len(children) != len(parents_to_evolve)
                or {child['parent'] for child in children} != expected_parents
                or any(child.get('created_round') != result['round'] for child in children)):
            raise ValueError('all-pool-v1 requires exactly one current-round child per selected incumbent and no extra evolution children')
    if settings.get('review_protocol') == REVIEW_PROTOCOL:
        expected = {entry['candidate']['name'] for entry in research}
        expected.update(entry['candidate']['name'] for entry in challengers
                        if entry['candidate'].get('parent') in {parent['name'] for parent in parents_to_evolve}
                        and entry['candidate'].get('created_round') == result['round'])
        if (len(challengers) != len(parents_to_evolve) + settings['research_slots']
                or set(challenger_names) != expected):
            raise ValueError('Candidate-scoped review requires exactly the expected children and fresh research proposals; no extra challengers')
    all_entries = [*incumbents, *challengers, *ranked]
    observed = {}
    for entry in all_entries:
        name = entry['candidate']['name']
        if name in observed and any(entry.get(key) != observed[name].get(key)
                                    for key in ('candidate', 'development', 'p95_ms', 'fitness', 'speed_score')):
            raise ValueError('Repeated candidate evidence must be consistent across result groups')
        observed[name] = entry
        if entry['candidate']['method'] not in prior_methods:
            metadata = result.get('candidate_metadata', {}).get(name, {})
            graph = metadata.get('architecture')
            if (not isinstance(metadata.get('family'), str) or not 1 <= len(metadata['family'].split()) <= 2
                    or not isinstance(metadata.get('differentiator'), str) or not 3 <= len(metadata['differentiator'].split()) <= 4
                    or not isinstance(graph, list) or not graph
                    or any(not isinstance(stage, list) or len(stage) != 2
                           or any(not isinstance(text, str) or not text.strip() for text in stage) for stage in graph)):
                raise ValueError('Novel methods require reviewed display and architecture metadata')
    parent_tasks = [task for task in completed if task.get('kind') == 'parent']
    if (len(parent_tasks) != len(parents_to_evolve)
            or {task.get('parent') for task in parent_tasks} != {candidate['name'] for candidate in parents_to_evolve}):
        raise ValueError('A separate completed evolution agent is required for every configured reproduction parent')
    if len({task.get('agent_id') for task in completed}) != len(completed):
        raise ValueError('Each agent task requires a distinct child ID')
    research_tasks = [task for task in completed if task.get('kind') == 'research']
    if (len(research_tasks) != settings['research_slots']
            or {task.get('proposal_candidate') for task in research_tasks} != {entry['candidate']['name'] for entry in research}):
        raise ValueError('Each research proposal needs its own completed research agent receipt')
    review_tasks = [task for task in completed if task.get('kind') == 'review']
    if len(review_tasks) != int(settings['family'] == 'new_family'):
        raise ValueError('New Family requires a reviewed architecture proposal')
    for task in completed:
        if not task.get('agent_id') or not artifact(job, task['artifact']).stat().st_size:
            raise ValueError('Completed agent tasks need child IDs and nonempty artifacts')
        if settings.get('agent_prompt') and settings['agent_prompt'] not in artifact(job, task.get('prompt_path', '')).read_text():
            raise ValueError('Each child prompt must include the dashboard research direction')
    if 'agent_budget_protocol' in settings:
        result['agent_budget_audit'] = verify_agent_budgets(job, receipts, settings, challengers,
                                                         result.get('candidate_artifacts'))
    if settings['family'] == 'new_family':
        verify_architecture_reviews(job, receipts, settings,
                                    {entry['candidate']['name']: entry['candidate'] for entry in research},
                                    result['candidate_metadata'])
    if 'benchmark_protocol' in settings:
        from deployment_benchmark import PROTOCOL, verify_deployment_benchmarks
        if settings['benchmark_protocol'] != PROTOCOL or result.get('benchmark_protocol') != PROTOCOL:
            raise ValueError('Final scoring requires the configured deployment benchmark protocol')
        train_ids = [row['clip'] for row in json.loads(manifests['train'].read_text())['clips']]
        validation_ids = [row['clip'] for row in json.loads(manifests['validation'].read_text())['clips']]
        result['deployment_benchmark'] = verify_deployment_benchmarks(job, evaluation, eligible, train_ids, validation_ids,
                                                                     result.get('candidate_artifacts', {}))
    if 'review_protocol' in settings and 'review_agents' not in settings:
        raise ValueError('A configured final-review protocol cannot omit its reviewer count')
    if 'review_agents' in settings:
        if result.get('evaluation_protocol') != settings.get('evaluation_protocol', 'clip_replay-v1'):
            raise ValueError('Result evaluation protocol must match the configured scoring protocol')
        context = review_context(job, result, settings, manifests, final['evaluation_path'])
        result['integrity_review'] = verify_integrity_reviews(job, result, receipts, settings, context,
                                                            evaluation.get('fitted_candidates', []))
    else:
        result.pop('integrity_review', None)  # No approval inference from old jobs or model self-declaration.
    validation = json.loads(manifests['validation'].read_text())['clips']
    ids = [row['clip'] for row in validation]
    if not ids or evaluation.get('validation_clip_ids') != ids:
        raise ValueError('Validation evidence must match the frozen split exactly')
    training = json.loads(manifests['train'].read_text())['clips']
    training_ids = [row['clip'] for row in training]
    if evaluation.get('training_clip_ids') != training_ids:
        raise ValueError('Training provenance must match the frozen training split')
    if set(training_ids) & set(ids):
        raise ValueError('Training and validation episodes must be disjoint')
    labels = [row['jaw_reference'] for row in validation]
    round_one.MATCH_SECONDS = settings['match_seconds']
    fitted = set(evaluation.get('fitted_candidates', []))
    handcrafted = {'threshold', 'geometry', 'template', 'optical flow', 'hog'}
    learned = {name for name, entry in observed.items()
               if result.get('candidate_metadata', {}).get(name, {}).get(
                   'family', architecture(entry['candidate']['method'])).casefold() not in handcrafted}
    if not learned <= fitted:
        raise ValueError('Every learned candidate needs training-only refit provenance')
    if 'training_protocol' in settings:
        if settings['training_protocol'] != TRAINING_PROTOCOL:
            raise ValueError('Unknown training checkpoint protocol')
        from dashboard_training import verify_training_records
        result['training_audit'] = verify_training_records(job, result, evaluation, settings, manifests, eligible)
    for name, entry in observed.items():
        training_predictions = evaluation.get('training_predictions', {}).get(name, {})
        if set(training_predictions) != set(training_ids):
            raise ValueError('Every evaluated candidate needs predictions for its training split')
        train_metrics = accuracy([training_predictions[clip] for clip in training_ids],
                                 [row['jaw_reference'] for row in training])
        predictions = evaluation.get('predictions', {}).get(name, {})
        if set(predictions) != set(ids):
            raise ValueError('Missing validation predictions or test clips included')
        metrics = accuracy([predictions[clip] for clip in ids], labels)
        split_scores = entry.get('split_scores', {})
        for split, measured in [('train', train_metrics), ('validation', metrics)]:
            if any(split_scores.get(split, {}).get(key) != measured[key]
                   for key in ('matched', 'missed', 'false_positives', 'f1')):
                raise ValueError('Split scores must match the saved train and validation predictions')
        if split_scores.get('test') is not None:
            raise ValueError('Test scores remain reserved during evolutionary selection')
        if any(entry['development'].get(key) != metrics[key] for key in ('matched', 'missed', 'false_positives', 'f1')):
            raise ValueError('Reported validation scores do not match saved predictions')
        times = np.asarray(evaluation.get('timings_ms', {}).get(name, []), dtype=float)
        if not times.size or not np.isfinite(times).all() or (times < 0).any():
            raise ValueError('Every candidate requires finite measured timings')
        p95 = float(np.percentile(times, 95))
        speed = min(1., max(0., (settings['frame_budget_ms'] - p95) /
                          (settings['frame_budget_ms'] - settings['full_speed_ms'])))
        fitness = settings['jaw_weight'] * metrics['f1'] + (1 - settings['jaw_weight']) * speed
        if any(not isfinite(entry.get(key, float('nan'))) for key in ('p95_ms', 'fitness', 'speed_score')):
            raise ValueError('Reported scores and timings must be finite')
        if abs(entry['p95_ms'] - p95) > 1e-6 or abs(entry['fitness'] - fitness) > 1e-6 or abs(entry['speed_score'] - speed) > 1e-6:
            raise ValueError('Reported fitness or p95 does not match evaluation evidence')
    if 'selection_protocol' in settings:
        result['selection_audit'] = verify_selection(result, prior, settings, validation,
                                                      evaluation.get('predictions', {}))
    return result_path, result


def _publication_receipt_path(job):
    return job.parent / '.verified-completions' / f'{job.name}.json'


def write_publication_receipt(job, final, trusted_inputs):
    """Only the outer worker calls this, outside the model-writable job directory."""
    records = {key: {'path': str(artifact(job, final[key])),
                     'sha256': sha256(artifact(job, final[key]).read_bytes()).hexdigest()}
               for key in ('results_path', 'agent_manifest_path', 'evaluation_path')}
    for key, name in [('config', 'config.json'), ('final', 'agent-final.json')]:
        path = artifact(job, name)
        records[key] = {'path': str(path), 'sha256': sha256(path.read_bytes()).hexdigest()}
    if 'agent_budget_protocol' in json.loads(artifact(job, 'config.json').read_text()).get('settings', {}):
        path = artifact(job, 'agent-runtime.json')
        records['agent_runtime'] = {'path': str(path), 'sha256': sha256(path.read_bytes()).hexdigest()}
    destination = _publication_receipt_path(job)
    destination.parent.mkdir(parents=True, exist_ok=True)
    write_json(destination, {'policy_version': 'continuous-v1', 'worker_pid': os.getpid(),
                             'job': str(job.resolve()), 'files': records,
                             'trusted_input_hashes': trusted_inputs})


def verify_publication(job, require_review=False):
    """Read-only publication check; never execute an agent-supplied probe program.

    Legacy jobs are returned without any approval stamp. New gated jobs require
    the outer worker's receipt, terminal PID and a fresh receipt/hash verification.
    """
    job = Path(job).resolve(strict=True)
    config = json.loads(artifact(job, 'config.json').read_text())
    status = json.loads(artifact(job, 'status.json').read_text())
    receipt_path = _publication_receipt_path(job)
    registration_path = job.parent / '.review-required' / f'{job.name}.json'
    registration = json.loads(registration_path.read_text()) if registration_path.exists() else None
    policy_path = job.parent / '.integrity-policy.json'
    policy = json.loads(policy_path.read_text()) if policy_path.exists() else None
    active_path = job.parent / 'dashboard-active.json'
    active = json.loads(active_path.read_text()) if active_path.exists() else {}
    active_matches = bool(active.get('job_directory')) and Path(active['job_directory']).resolve() == job
    required = (require_review or 'review_agents' in config.get('settings', {})
                or 'review_protocol' in config.get('settings', {})
                or 'agent_budget_protocol' in config.get('settings', {}) or receipt_path.exists()
                or registration is not None
                or (active_matches and active.get('requires_integrity_review') is True)
                or (policy is not None and job.name not in policy.get('legacy_jobs', [])))
    if status.get('state') != 'completed':
        raise ValueError('Only completed jobs can be published')
    if not required:
        path = artifact(job, status.get('results_path', 'results.json'))
        result = json.loads(path.read_text())
        if any(key in result.get('settings', {}) for key in ('review_agents', 'review_protocol', 'agent_budget_protocol')):
            raise ValueError('Gated result cannot downgrade itself to a legacy job')
        result.pop('integrity_review', None)
        return path, result
    if 'review_agents' not in config.get('settings', {}):
        raise ValueError('A review-required job cannot downgrade its configured gate')
    if (registration is not None and (registration.get('job') != str(job)
            or registration.get('config_sha256') != sha256(artifact(job, 'config.json').read_bytes()).hexdigest())):
        raise ValueError('Registered review-required job configuration changed')
    if (active_matches and active.get('config_sha256')
            and sha256(artifact(job, 'config.json').read_bytes()).hexdigest() != active['config_sha256']):
        raise ValueError('Server-pinned job configuration changed')
    receipt = json.loads(receipt_path.read_text())
    if receipt.get('job') != str(job) or type(receipt.get('worker_pid')) is not int or receipt['worker_pid'] <= 0:
        raise ValueError('Invalid outer-worker publication receipt')
    try:
        os.kill(receipt['worker_pid'], 0)
    except ProcessLookupError:
        pass
    except PermissionError as error:
        raise ValueError('Cannot verify that the outer worker has finished') from error
    else:
        raise ValueError('The outer worker has not finished the final gate')
    for record in receipt.get('files', {}).values():
        if sha256(artifact(job, record['path']).read_bytes()).hexdigest() != record['sha256']:
            raise ValueError('Published integrity evidence changed after outer-worker verification')
    if set(receipt.get('files', {})) != {'results_path', 'agent_manifest_path', 'evaluation_path', 'config', 'final'}:
        raise ValueError('Outer-worker publication receipt is incomplete')
    final = json.loads(artifact(job, receipt['files']['final']['path']).read_text())
    config['_trusted_input_hashes'] = receipt.get('trusted_input_hashes', {})
    return verify_completion(job, final, config, {split: job / f'{split}.json' for split in ('train', 'validation')})


def stop_coordinator(process):
    """Stop this no-daemon coordinator and its attached local process group."""
    if process.poll() is not None:
        return
    os.killpg(process.pid, signal.SIGTERM)
    try:
        process.wait(timeout=15)
    except subprocess.TimeoutExpired:
        os.killpg(process.pid, signal.SIGKILL)
        process.wait(timeout=5)


def execute(config_path):
    from dashboard_datasets import build_split_manifest

    config = json.loads(config_path.read_text())
    settings = config['settings']
    job = config_path.parent.resolve()
    status_path = job / 'status.json'
    last_phase = 'prepare'

    def status(state, progress, message, **extra):
        nonlocal last_phase
        last_phase = extra.pop('phase', last_phase)
        write_json(status_path, {'state': state, 'progress': progress, 'message': message,
                                 'mode': 'agent_guided', 'phase': last_phase,
                                 'round': config.get('round_number'), **extra})

    process = None
    try:
        if type(settings.get('review_agents')) is not int or not 1 <= settings['review_agents'] <= 5:
            raise ValueError('New agent-guided jobs require one to five final integrity reviewers')
        if settings.get('review_protocol') != REVIEW_PROTOCOL:
            raise ValueError('New agent-guided jobs require fresh per-candidate-v1 reviewer assignments')
        if settings.get('evaluation_protocol') != 'clip_replay-v1':
            raise ValueError('New jobs must explicitly record the implemented clip_replay-v1 scoring protocol')
        if settings.get('benchmark_protocol') != 'deployment-v1':
            raise ValueError('New jobs must derive final F1 and latency from the same deployment artifact')
        if settings.get('training_protocol') != TRAINING_PROTOCOL:
            raise ValueError('New jobs require validation checkpoints and complete training receipts')
        if settings.get('selection_protocol') != SELECTION_PROTOCOL:
            raise ValueError('New jobs require parameter-bound portfolio selection')
        if settings.get('reproduction_protocol') != REPRODUCTION_PROTOCOL:
            raise ValueError('New jobs require all-pool-v1 reproduction of every selected incumbent')
        if settings.get('agent_budget_protocol') != BUDGET_PROTOCOL:
            raise ValueError('New jobs require supervised-v1 per-agent lifecycle control')
        if settings.get('review_bundle_protocol') != REVIEW_BUNDLE_PROTOCOL:
            raise ValueError('New jobs require frozen-bundle-v1 review-package preflight')
        if settings.get('agent_export_min_seconds') != 60:
            raise ValueError('New jobs require the 60-second short-budget export minimum')
        selection_parameters(settings)
        status('running', .01, 'Preparing the pinned train and validation inputs', phase='prepare')
        ready = readiness()
        if not ready['ready']:
            raise RuntimeError(ready['message'])
        split = build_split_manifest(settings)
        write_json(job / 'inputs.json', split)
        manifests = {}
        for name, records in split['splits'].items():
            path = job / f'{name}.json'
            write_json(path, {'clips': records, 'split': name, 'snapshot_sha256': split['snapshot_sha256']})
            manifests[name] = path
        config['_trusted_input_hashes'] = {path.name: sha256(path.read_bytes()).hexdigest()
                                          for path in manifests.values()}
        # Freeze trusted source before agents run. Publication later checks these
        # copies, so future legitimate repository edits do not erase old history.
        protected = ['ml/evolution/training.py', 'ml/evolution/agent_briefs.py',
                     'ml/evolution/agent_runtime.py', 'ml/evolution/agent_budgets.py', 'ml/evolution/review_bundles.py',
                     'ml/evolution/portfolio.py', 'ml/evolution/__init__.py',
                     *[f'ml/experiments/jaw-trigger/{name}' for name in
                       ('round_one.py', 'joint_fitness.py', 'dashboard_agents.py',
                        'dashboard_training.py', 'dashboard_selection.py', 'deployment_benchmark.py', 'dashboard_integrity.py',
                        'dashboard_datasets.py')]]
        live_hashes = {}
        for name in protected:
            source = REPOSITORY / name
            raw = source.read_bytes()
            target = job / 'protected-source' / name
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(raw)
            live_hashes[name] = sha256(raw).hexdigest()
            config['_trusted_input_hashes'][str(target.relative_to(job))] = live_hashes[name]
        prior_hash = sha256(Path(config['prior']).read_bytes()).hexdigest()
        config_hash = sha256(config_path.read_bytes()).hexdigest()
        schema_path, final_path = job / 'final-schema.json', job / 'agent-final.json'
        write_json(schema_path, FINAL_SCHEMA)
        runtime_config = supervisor_configuration(json.loads(Path(config['prior']).read_text()), settings, job, ready['binary'])
        write_json(job / 'runtime-config.json', runtime_config)
        runtime_config_hash = sha256((job / 'runtime-config.json').read_bytes()).hexdigest()
        config['_trusted_input_hashes']['runtime-config.json'] = runtime_config_hash
        prompt = coordinator_prompt(config, job, manifests)
        (job / 'coordinator-prompt.txt').write_text(prompt)
        command = coordinator_command(ready['binary'], job, schema_path, final_path)
        write_json(job / 'invocation.json', {'argv': command, 'mode': 'agent_guided',
                                           'validation': 'Not live-validated until this job completes'})
        status('running', .03, 'Dispatching the Codex coordinator and candidate subagents', phase='research')
        with ((job / 'events.jsonl').open('w') as events,
              (job / 'codex-stderr.log').open('w') as stderr,
              (job / 'coordinator-prompt.txt').open() as prompt_input):
            deadline = monotonic() + round_allocation_seconds(json.loads(Path(config['prior']).read_text()), settings)
            process = subprocess.Popen(command, stdin=prompt_input, stdout=events, stderr=stderr, text=True, start_new_session=True)
            last_progress = .03
            phases = {'preparation': 0, 'research': 1, 'evolution': 2, 'evaluation': 3,
                      'integrity_review': 4, 'audit': 5}
            while process.poll() is None:
                if monotonic() >= deadline:
                    stop_coordinator(process)
                    raise TimeoutError('The coordinator exceeded its round allocation')
                progress_file = job / 'agent-progress.json'
                if progress_file.exists():
                    try:
                        update = json.loads(progress_file.read_text())
                        done, total = update['completed_tasks'], update['total_tasks']
                        if type(done) is int and type(total) is int and 0 <= done <= total and total > 0:
                            phase = update.get('phase', 'preparation')
                            fraction = .05 + .85 * (phases.get(phase, 0) + done / total) / len(phases)
                            last_progress = max(last_progress, fraction)
                            status('running', last_progress, f"{phase}: {done}/{total} tasks completed", phase=phase)
                    except (OSError, ValueError, KeyError):
                        pass
                try:
                    process.wait(timeout=1)
                except subprocess.TimeoutExpired:
                    continue
        if process.returncode != 0:
            raise RuntimeError('Codex stopped before completion; inspect codex-stderr.log and events.jsonl')
        if sha256((job / 'runtime-config.json').read_bytes()).hexdigest() != runtime_config_hash:
            raise ValueError('Pinned agent-supervisor configuration changed')
        private_ledger = Path(runtime_config['ledger_path'])
        ledger_bytes = private_ledger.read_bytes()
        # Replace any agent-created path rather than following a job-local symlink.
        descriptor, temporary = tempfile.mkstemp(prefix='.agent-runtime-', dir=job)
        try:
            with os.fdopen(descriptor, 'wb') as stream:
                stream.write(ledger_bytes)
            os.replace(temporary, job / 'agent-runtime.json')
        finally:
            if os.path.exists(temporary):
                os.unlink(temporary)
        config['_trusted_input_hashes']['agent-runtime.json'] = sha256(ledger_bytes).hexdigest()
        final = json.loads(final_path.read_text())
        status('running', .95, 'Auditing subagent receipts and validation evidence', phase='audit')
        if any(sha256((REPOSITORY / name).read_bytes()).hexdigest() != digest for name, digest in live_hashes.items()):
            raise ValueError('Protected evaluator or training harness changed during the round')
        if sha256(Path(config['prior']).read_bytes()).hexdigest() != prior_hash:
            raise ValueError('Frozen baseline result changed during the round')
        result_path, result = verify_completion(job, final, config, manifests)
        if sha256(config_path.read_bytes()).hexdigest() != config_hash:
            raise ValueError('Pinned job configuration changed during the agent round')
        if 'review_agents' in settings:
            write_json(result_path, result)  # Only the verified wrapper stamps final-gate metadata.
            write_publication_receipt(job, final, config['_trusted_input_hashes'])
        subset = settings['family'] not in ('all', 'new_family') or settings['clip_limit'] > 0
        winner = result['ranked'][0]
        summary = {'round': result['round'], 'subset': subset, 'clip_count': len(split['clips']),
                   'evaluated_candidates': len({entry['candidate']['name'] for entry in
                                                result.get('incumbents', []) + result['ranked'] + result.get('challengers', [])}),
                   'best_fitness': winner['fitness'], 'jaw_f1': winner['development']['f1'],
                   'p95_ms': winner['p95_ms'], 'target_basis': 'validation', 'mode': 'agent_guided'}
        summary['integrity_review'] = result.get('integrity_review', {'status': 'legacy_unreviewed'})
        summary['evaluation_protocol'] = result.get('evaluation_protocol', 'clip_replay-v1')
        if not subset and 'review_agents' not in settings:
            write_json(job.parent / 'dashboard-current.json', {'results_path': str(result_path)})
            dashboard = Path(config['dashboard'])
            old = json.loads((dashboard / 'progress.json').read_text())
            old.update(step='selected', round=result['round'], active_candidate=None,
                       pool=result['next_pool'], ranked=result['ranked'], result=result)
            old.pop('leader_trend', None)
            write_json(dashboard / 'progress.json', old)
        status('completed', 1., final['message'], result=summary, results_path=str(result_path), phase='selected')
    except Exception as error:
        if process is not None and process.poll() is None:
            stop_coordinator(process)
        status('failed', 0., str(error))
        raise


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('config', type=Path)
    execute(parser.parse_args().config)

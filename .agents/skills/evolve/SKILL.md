---
name: evolve
description: Run or extend agent-guided evolutionary experiments using the shared ML runner, including candidate proposals, mutation, selection, and reproducible evaluation across domains.
---

# Evolve

Use `ml/evolution/` for shared mutation, selection and agent briefs. Read
`ml/evolution/README.md` for the adapter contract and plan schema. Keep domain
data, candidates, feature extraction, scoring and benchmark hardware in that
domain's experiment directory. For jaw detection, use
`ml/experiments/jaw-trigger/README.md` and its existing CLI.

Before a run, establish the domain's fitness, dataset split, compute budget,
pool policy, round count and stopping condition from the current request.
Keep existing approved settings when the user requests continuation.
Disclose fitting-set results and independent validation separately.

Read `ml/evolution/README.md`'s validation-checkpoint workflow before learned
experiments. Use its shared training monitor and domain completion audit:
declare hypotheses/resources, journal every attempted fit, monitor validation
after each epoch, retain the best validation-task checkpoint and stop for
patience/budget. Keep objective loss distinct from fitness and task accuracy.
Rising validation loss calls for analysis of capacity/regularization; it does
not alone invalidate improved event F1. Keep frozen evaluators and test inputs
outside candidate edits. These safeguards reduce overtraining, not guarantee
generalization from small or overlapping datasets.

For an agent-guided round, generate shared briefs with domain context.
Dispatch the domain's configured research tasks to review prior evidence and
primary sources; the jaw dashboard assigns one fresh proposal per researcher.
In ordinary jaw dashboard rounds, every current retained pool member receives
exactly one child. Do not apply a fitness/top-X reproduction cutoff. Pool size
limits the next survivors, research count adds fresh proposals, and parallel
agents limits concurrency. Family-filtered checks reproduce every scoped
candidate; New Family is research-only. Use saved historical settings when
auditing older runs rather than retroactively applying this rule.
New jaw jobs use review_protocol=per-candidate-v1. Reviewers per candidate
defaults to 1 (range 1–5). After fitting and serial evaluation, initialize a fresh
review task for each candidate/reviewer slot; never reuse an author, architecture
reviewer, or another candidate's reviewer/context. Give it the shared rubric,
frozen evidence and exactly one candidate. All assigned reviews must approve;
missing, rejected or stale evidence blocks publication. Historical shared-review
jobs keep their saved protocol. See the domain README for receipt requirements.
New dashboard jobs also require agent_budget_protocol=supervised-v1. Dispatch
through the runner-owned evolution_agents MCP supervisor, never unsupervised
spawn/shell delegation. Every started task has its own hard wall deadline;
queued time is excluded. Early author finishes resume the same context and
original deadline to improve validation fitness and retain the best checkpoint.
Reserve the last 10% (at most 120 seconds) for finalization only, with no new fit.
Export one best child/fresh proposal, preserving failed trials. A concrete
documented blocker can stop work early; reviewers may finish after their checks.
Only bounded New Family architecture cycles 2/3 renew the existing identities'
allocation. The outer worker audits the supervisor-owned lifecycle ledger.
Codex 0.160.0 probes confirmed native Goals continue in persistent app-server
threads, but codex exec exits after its first turn with an active Goal. Use the
supervisor's explicit exec/resume continuation; do not rely on Goals in CLI children.
Dispatch a separate task per
parent, in batches if concurrency is limited. Each parent agent should
compare its own family's successes and failures with other families and
explain one concrete child proposal. Give each parent room for structural
changes to features, sensor fusion, or decision rules when its evidence warrants them.

Collect the proposals into a plan and run the domain adapter. Preserve
the scored history, seed, lineage, rationales and evaluated genotypes for
resume. Apply the configured selector: plain mode keeps the better parent
or child; portfolio mode preserves champion/exploration/complementary coverage
and may retain both. Do not silently replace portfolio admission with top-N
fitness sorting. Inspect the actual scored configuration
when a duplicate proposal causes seeded fallback. Stop at the requested
round count or completion condition and summarize remaining failures.

Use the domain's native inputs for inference. Evaluation labels and clip
identity may guide fitting when authorized, but should not silently enter
runtime logic. Keep private examples, generated reports, learned weights
and build artifacts out of Git under the project's existing policy.

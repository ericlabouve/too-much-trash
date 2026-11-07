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

For an agent-guided round, generate shared briefs with domain context.
Dispatch one researcher to review prior evidence and primary sources and
propose the policy's number of fresh ideas. Dispatch a separate task per
parent, in batches if concurrency is limited. Each parent agent should
compare its own family's successes and failures with other families and
explain one concrete child proposal. Give the champion and rotating parents
room for structural changes to features, sensor fusion, or decision rules.

Collect the proposals into a plan and run the domain adapter. Preserve
the scored history, seed, lineage, rationales and evaluated genotypes for
resume. The runner keeps the better parent or child and reserves the
research slots for fresh ideas. Inspect the actual scored configuration
when a duplicate proposal causes seeded fallback. Stop at the requested
round count or completion condition and summarize remaining failures.

Use the domain's native inputs for inference. Evaluation labels and clip
identity may guide fitting when authorized, but should not silently enter
runtime logic. Keep private examples, generated reports, learned weights
and build artifacts out of Git under the project's existing policy.

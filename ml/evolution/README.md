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

From the repository root, generate domain-specific briefs with
`python -m ml.evolution.agent_briefs RESULTS_JSON --context "Evaluation and constraints"`.
Pass `--pool-size` and `--research-slots` for a custom policy. The orchestrating
Codex session dispatches one researcher and one task per parent, collects
proposals, and passes the plan to the runner. The library emits briefs
and executes search. Agent dispatch belongs to the session.

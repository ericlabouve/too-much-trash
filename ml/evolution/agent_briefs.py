"""Generate research and per-parent tasks from a scored round."""

import argparse
import json
from pathlib import Path

from . import Policy

EXPERIMENT_GUIDELINES = '''
Establish a measured unchanged baseline before claiming improvement. Treat the
domain's split, labels, evaluator, event tolerance, fitness and benchmark harness
as fixed: propose changes to them separately, never alter them to improve a score.
Declare each trial's hypothesis, objective, capacity/parameter count, regularization,
seed and resource allocation before fitting. Keep a complete trial journal including
crashes, rejected ideas and negative results. Favor simpler mechanisms when gains
are indistinguishable, without inventing a simplicity bonus in the fitness formula.
Use ml.evolution.training.TrainingMonitor for iterative fits. Evaluate training and
validation loss under the same objective in inference mode after each epoch; no
validation gradients, dropout or augmentation. Save the best validation-task-score
checkpoint, with lower validation loss then earlier epoch as tie-breaks. Freeze the
checkpoint-selection decoder within a fit. Monitor patience and a common wall-time
cap; do not blindly export the last epoch or prescribe 100 epochs for every model.
Keep loss separate from task F1 and composite fitness. Rising validation loss is an
overfitting warning, not automatic rejection of a model with better task F1. Review
capacity, weight decay, dropout, label-preserving augmentation and simpler baselines
when the train/validation gap grows. Genuine closed-form/tree fits get an explicit
noniterative record, not invented epoch curves. Large tensors may remain framework
checkpoints referenced by hash; Python, NumPy, PyTorch and other suitable prototypes
are allowed. Final task accuracy and latency must use the same deployment artifact
and the domain's serial benchmark protocol. Reserve test for a separately authorized
final evaluation. Repeated validation selection and overlapping recording sessions
limit generalization claims. Retain protected exploration/diversity under the domain
selector; this is not an instruction to greedily discard every novel lower score.
For jaw dashboard rounds, each frozen challenger receives its own freshly initialized
integrity reviewer(s), one per candidate by default. Reviewers are independent of all
authors, early architecture review and other candidate reviews. Expect inspection
of the actual deployed code, checkpoint and native streaming probes; do not exploit
episode offsets, labels, clip identity, future inputs or hidden labeled resets.
Answer findings with evidence; changed artifacts require a fresh review of their hashes.
Package each frozen file once, with its correct role. The coordinator must pass
candidate-scoped bundles through the supervisor's preflight before reviewer dispatch;
duplicate evaluator/dependency records and stale hashes are structural failures.
Candidate authors should use their remaining allocated search time: inspect validation
failures, compare previous attempts, and try another credible hypothesis while retaining
the best validated checkpoint. A first valid proposal or patience-stopped fit does not
complete the research assignment. Export exactly one best child/fresh proposal. Respect
the supervisor's finalization-only window: stop new fitting and package the best model,
implementation, configuration and trial evidence. Only a concrete operational blocker
justifies ending early; record attempted remedies. Reviewers may finish once checks are
complete. Follow-ups share the original deadline; never start another identity to evade
it. Use the runner's supervised lifecycle tools; a Goal or instruction alone is not a
wall-time enforcement mechanism. Do not manufacture meaningless trials to fill time.
Stay within the requested round/agent budget. Preserve unrelated changes; never
copy another project's infinite-loop or git-reset workflow into a shared checkout.
'''.strip()


def proposal_mode(history, minimum_gain):
    recent = history[-4:]
    if len(recent) < 4 or any(entry.get("fitness_weights") != recent[-1].get("fitness_weights")
                              for entry in recent):
        return "refine"
    gain = recent[-1]["ranked"][0]["fitness"] - recent[0]["ranked"][0]["fitness"]
    return "plateau" if gain < minimum_gain else "refine"


def build_briefs(result, source, *, context="", policy=Policy(), portfolio=False):
    round_number = result["round"] + 1
    survivors = policy.pool_size - policy.research_slots
    common = f"Round {round_number}. Read {Path(source).resolve()} and its scored history. "
    mode = proposal_mode(result.get("history", []), policy.minimum_gain)
    if portfolio:
        common += (
            "Preserve the champion, complementary specialists and protected lineages. "
            "Use parent–child results and per-case failures to distinguish weak "
            "mechanisms from specific, repairable failures. "
        )
    else:
        common += (f"The planned round keeps the {survivors} best parent–child lineages and gives "
                   f"{policy.research_slots} slots to new research proposals. ")
    common += "Use the domain's evaluation protocol and keep evaluation-only inputs out of inference."
    common += '\n' + EXPERIMENT_GUIDELINES
    if context:
        common += f" Domain guidance: {context}"
    parents = []
    for index, parent in enumerate(result["next_pool"]):
        ambitious = index == 0 or (index + round_number) % (3 if portfolio and mode == "plateau" else 5) == 0
        ambition = (
            "Propose a structural or cross-family change that could escape the parent's current failure."
            if ambitious else "Choose parameter tuning or a broader change based on the evidence."
        )
        parents.append({
            "parent": parent["name"],
            "ambitious": ambitious,
            "task": (
                f"{common} You own only {parent['name']}. Compare at least one useful result "
                "in its family with a success or failure from another family. "
                f"{ambition} Return one child, the exact changes, and a brief rationale. "
                "Use a previously untested configuration."
            ),
        })
    research = f"{common} Browse primary sources and propose exactly {policy.research_slots} new candidates."
    if portfolio:
        if mode == "plateau":
            research += " Recent gains have stalled. Prioritize distinct mechanisms over parameter-only variants."
        else:
            research += " Balance new mechanisms and evidence-backed refinements."
        research += " Include at most one targeted repair, and name the evidence for its cause."
    return {
        "round": round_number,
        "research": research,
        "research_tasks": [f'{common} Researcher {index + 1}: browse primary sources and implement exactly ONE distinct fresh candidate; coordinate to avoid duplicate proposals.'
                           for index in range(policy.research_slots)],
        "parents": parents,
    }


def main(*, context=""):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("results", type=Path)
    parser.add_argument("--context", default="", help="Additional goals, constraints, or evaluation guidance")
    parser.add_argument("--pool-size", type=int, default=Policy.pool_size)
    parser.add_argument("--research-slots", type=int, default=Policy.research_slots)
    parser.add_argument("--portfolio", action="store_true")
    args = parser.parse_args()
    policy = Policy(pool_size=args.pool_size, research_slots=args.research_slots)
    result = json.loads(args.results.read_text())
    guidance = " ".join(part for part in (context, args.context) if part)
    print(json.dumps(build_briefs(result, args.results, context=guidance, policy=policy,
                                  portfolio=args.portfolio), indent=2))


if __name__ == "__main__":
    main()

"""Generate research and per-parent tasks from a scored round."""

import argparse
import json
from pathlib import Path

from . import Policy


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

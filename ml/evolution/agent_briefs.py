"""Generate research and per-parent tasks from a scored round."""

import argparse
import json
from pathlib import Path

from . import Policy


def build_briefs(result, source, *, context="", policy=Policy()):
    round_number = result["round"] + 1
    survivors = policy.pool_size - policy.research_slots
    common = (
        f"Round {round_number}. Read {Path(source).resolve()} and its scored history. "
        f"The planned round keeps the {survivors} best parent–child lineages and gives "
        f"{policy.research_slots} slots to new research proposals. "
        "Use the domain's evaluation protocol and keep evaluation-only inputs out of inference."
    )
    if context:
        common += f" Domain guidance: {context}"
    parents = []
    for index, parent in enumerate(result["next_pool"]):
        ambitious = index == 0 or (index + round_number) % 5 == 0
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
    return {
        "round": round_number,
        "research": f"{common} Browse primary sources and propose exactly {policy.research_slots} new candidates.",
        "parents": parents,
    }


def main(*, context=""):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("results", type=Path)
    parser.add_argument("--context", default=context, help="Domain goals, constraints, and evaluation rules")
    parser.add_argument("--pool-size", type=int, default=Policy.pool_size)
    parser.add_argument("--research-slots", type=int, default=Policy.research_slots)
    args = parser.parse_args()
    policy = Policy(pool_size=args.pool_size, research_slots=args.research_slots)
    result = json.loads(args.results.read_text())
    print(json.dumps(build_briefs(result, args.results, context=args.context, policy=policy), indent=2))


if __name__ == "__main__":
    main()

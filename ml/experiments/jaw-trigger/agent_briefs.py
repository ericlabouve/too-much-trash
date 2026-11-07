"""Generate the research and per-parent agent briefs for a scored round."""

import argparse
import json
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("results", type=Path)
    args = parser.parse_args()
    result = json.loads(args.results.read_text())
    round_number = result["round"] + 1
    context = (
        f"Round {round_number}. Read {args.results.resolve()} and its scored history. "
        "Use all five fitting clips and pay particular attention to Clip 2. A false trigger "
        "costs twice a miss. The pool keeps its seven best parent–child lineages and gives "
        "three slots to research proposals. Avoid clip identity, elapsed clip time, and labels "
        "at inference. Give concrete parameters and preserve a causal, phone-feasible runtime."
    )
    parent_briefs = []
    for index, parent in enumerate(result["next_pool"]):
        ambitious = index == 0 or (index + round_number) % 5 == 0
        ambition = (
            "Propose a structural or cross-family change, such as a new feature, fusion, "
            "or decision rule, that could escape the parent's current failure."
            if ambitious else "Choose parameter tuning or a broader change based on the evidence."
        )
        parent_briefs.append({
            "parent": parent["name"],
            "ambitious": ambitious,
            "task": (
                f"{context} You own only {parent['name']}. Compare at least one useful result "
                "in its family with a success or failure from another family. "
                f"{ambition} Return one child, the exact changes, and a brief rationale. "
                "Use a previously untested configuration."
            ),
        })
    print(json.dumps({
        "round": round_number,
        "research": f"{context} Browse primary sources and propose exactly three new detector ideas.",
        "parents": parent_briefs,
    }, indent=2))


if __name__ == "__main__":
    main()

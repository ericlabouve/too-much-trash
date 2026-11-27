"""Compare joint selectors with recorded candidate outcomes at equal evaluation counts."""

import argparse
from collections import defaultdict, deque
from dataclasses import replace
import json
from pathlib import Path

from run_joint_round import POLICY, PORTFOLIO, SPACE
from ml.evolution import select_lineages


LEGACY_PORTFOLIO = replace(
    PORTFOLIO,
    objectives=lambda entry: (("jaw specialist", entry["accuracy_score"]),
                              ("deposit specialist", entry["deposit"]["balanced_accuracy"])),
)
DEPOSIT_PORTFOLIO = replace(
    PORTFOLIO,
    objectives=lambda entry: (*PORTFOLIO.objectives(entry),
                              ("deposit specialist", entry["deposit"]["balanced_accuracy"])),
)


def name(entry):
    return entry["candidate"]["name"]


def replay(history, portfolio=False):
    continuations = defaultdict(deque)
    ideas_by_round = {}
    for result in history:
        ideas_by_round[result["round"]] = []
        for trial in result["challengers"]:
            parent = trial["candidate"]["parent"]
            if parent is None:
                ideas_by_round[result["round"]].append(trial)
            else:
                continuations[parent].append(trial)

    pool = history[0]["incumbents"]
    best = [max(entry["fitness"] for entry in pool)]
    unknown = defaultdict(int)
    attempts = 0
    protected = ()
    rounds = []
    for result in history:
        children = []
        for parent in pool:
            parent_name = name(parent)
            attempts += 1
            available = continuations[parent_name]
            if available:
                children.append(available.popleft())
            else:
                unknown[parent_name] += 1
        ideas = ideas_by_round[result["round"]]
        for entry in [*children, *ideas]:
            best.append(max(best[-1], entry["fitness"]))
        if portfolio:
            weights = result.get("fitness_weights")
            selector = PORTFOLIO
            if weights is None:
                selector = LEGACY_PORTFOLIO
            elif weights.get("deposit_balanced_accuracy", 0) > 0:
                selector = DEPOSIT_PORTFOLIO
            pool, _, selection = selector.select(pool, children, ideas, SPACE, POLICY, protected)
            protected = selection["protected"]
        else:
            pool, _ = select_lineages(pool, children, ideas, SPACE, POLICY)
        rounds.append({"round": result["round"], "revealed_trials": len(best) - 1,
                       "unsupported_mutations": sum(unknown.values()), "best_fitness": best[-1],
                       "pool": [name(entry) for entry in pool]})
    return {"rounds": rounds, "fitness_by_revealed_trial": best, "requested_mutations": attempts,
            "unsupported_mutations": dict(unknown)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("history", type=Path, help="Saved result with embedded history")
    parser.add_argument("output", type=Path)
    parser.add_argument("--from-round", type=int, default=27)
    args = parser.parse_args()
    history = [row for row in json.loads(args.history.read_text())["history"]
               if row["round"] >= args.from_round]
    if not history or any("incumbents" not in row for row in history):
        parser.error("Select recorded joint rounds with incumbent and trial scores")
    baseline = replay(history)
    proposed = replay(history, portfolio=True)
    matched = min(len(row["fitness_by_revealed_trial"]) for row in (baseline, proposed)) - 1
    result = {
        "baseline": baseline,
        "proposed": proposed,
        "baseline_reproduced_pools": all(
            replayed["pool"] == [entry["name"] for entry in recorded["next_pool"]]
            for replayed, recorded in zip(baseline["rounds"], history, strict=True)
        ),
        "matched_revealed_trials": matched,
        "matched_fitness": {label: row["fitness_by_revealed_trial"][matched]
                            for label, row in (("baseline", baseline), ("proposed", proposed))},
    }
    args.output.write_text(json.dumps(result, indent=2) + "\n")


if __name__ == "__main__":
    main()

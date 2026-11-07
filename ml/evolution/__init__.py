"""Domain-independent mutation, selection, and round orchestration."""

from collections import Counter
from collections.abc import Callable, Iterable
from dataclasses import dataclass, replace
from random import Random
from typing import Any


@dataclass(frozen=True)
class Policy:
    pool_size: int = 10
    family_limit: int = 5
    minimum_gain: float = 0.001
    research_slots: int = 3

    def __post_init__(self):
        if not 0 <= self.research_slots < self.pool_size or self.family_limit < 1 or self.minimum_gain <= 0:
            raise ValueError("Use positive limits and fewer research slots than pool slots")


def fitness_order(entry):
    return -entry["fitness"], entry["candidate"]["name"]


@dataclass(frozen=True)
class SearchSpace:
    candidate_type: type
    genotype: Callable[[Any], tuple]
    neighbors: Callable[[Any], Iterable[Any]]
    family: Callable[[Any], str]
    family_name: Callable[[Any], str]
    rank_key: Callable[[dict], tuple] = fitness_order


def run_round(pool, round_number, seen, evaluate, space, *, policy=Policy(), seed=0, plan=None):
    """Score one round and add evaluated genotypes to the caller's resume set."""
    if not 1 <= len(pool) <= policy.pool_size:
        raise ValueError("Supply a nonempty pool within the policy limit")
    seen.update(space.genotype(candidate) for candidate in pool)
    rng = Random(f"{seed}:{round_number}")
    if plan is None:
        return _evolve(pool, round_number, seen, evaluate, rng, space, policy)
    return _evolve_researched(pool, round_number, seen, evaluate, plan, rng, space, policy)


def _mutate(parent, seen, round_number, rng, space):
    local = list(space.neighbors(parent))
    unseen = {space.genotype(child): child for child in local if space.genotype(child) not in seen}
    # Occasionally take two steps to escape a local plateau. Fall back to
    # two-step mutations when all one-step neighbors have already been scored.
    if not unseen or rng.random() < 0.25:
        broader = {space.genotype(child): child for neighbor in local for child in space.neighbors(neighbor)
                   if space.genotype(child) not in seen and space.genotype(child) not in unseen}
        unseen = broader or unseen
    if not unseen:
        return None
    child = rng.choice(list(unseen.values()))
    return _name_trial(child, parent, round_number, seen, space.family_name(child))


def _name_trial(child, parent, round_number, seen, base):
    return replace(child, name=f"{base} / R{round_number} trial {len(seen) + 1}",
                   created_round=round_number, parent=parent.name)


def _evolve(pool, round_number, seen, evaluate, rng, space, policy):
    def rank(scores):
        return sorted(scores, key=space.rank_key)

    parents = rank(evaluate(candidate) for candidate in pool)
    challengers = []
    exhausted = []
    for parent in pool:
        child = _mutate(parent, seen, round_number, rng, space)
        if child is None:
            exhausted.append(parent.name)
            continue
        entry = evaluate(child)
        seen.add(space.genotype(child))
        entry["parent"] = parent.name
        challengers.append(entry)
    challengers = rank(challengers)
    pruned = []
    pruned_scores = []
    counts = Counter(space.family(candidate) for candidate in pool)
    admitted = []
    if len(pool) < policy.pool_size:
        for child in challengers:
            if len(pool) + len(admitted) == policy.pool_size:
                break
            family = space.family(space.candidate_type(**child["candidate"]))
            if counts[family] < policy.family_limit:
                admitted.append(child)
                counts[family] += 1
    else:
        for child in challengers:
            family = space.family(space.candidate_type(**child["candidate"]))
            for index in range(len(parents) - 1, -1, -1):
                incumbent = parents[index]
                incumbent_family = space.family(space.candidate_type(**incumbent["candidate"]))
                if child["fitness"] - incumbent["fitness"] < policy.minimum_gain:
                    break
                if family != incumbent_family and (counts[incumbent_family] == 1 or counts[family] >= policy.family_limit):
                    continue
                admitted = [child]
                pruned_scores = [parents.pop(index)]
                pruned = [incumbent["candidate"]]
                break
            if admitted:
                break
    retained = rank(parents + admitted)
    return {"round": round_number, "ranked": retained, "challengers": challengers, "exhausted": exhausted,
            "pruned": pruned, "pruned_scores": pruned_scores, "admitted": [entry["candidate"] for entry in admitted],
            "next_pool": [entry["candidate"] for entry in retained]}


def _evolve_researched(pool, round_number, seen, evaluate, plan, rng, space, policy):
    """Evaluate incumbent mutations, then give fresh ideas reserved pool slots."""
    if not policy.research_slots:
        raise ValueError("Enable research slots to run a planned round")
    if len(pool) != policy.pool_size or len(plan["ideas"]) != policy.research_slots:
        raise ValueError(f"A researched round requires {policy.pool_size} incumbents and {policy.research_slots} new ideas")
    if set(plan["mutations"]) != {candidate.name for candidate in pool}:
        raise ValueError("Provide one mutation plan per incumbent")

    def rank(scores):
        return sorted(scores, key=space.rank_key)

    parents = rank(evaluate(candidate) for candidate in pool)
    best_by_parent = {entry["candidate"]["name"]: entry for entry in parents}
    challengers = []
    for parent in pool:
        proposal = plan["mutations"][parent.name]
        changes = proposal.get("changes", proposal)
        child = replace(parent, **changes)
        if space.genotype(child) in seen:
            child = _mutate(parent, seen, round_number, rng, space)
        if child is None:
            continue
        base = parent.name.split(" / ")[0] if space.family(child) == space.family(parent) else space.family_name(child)
        child = _name_trial(child, parent, round_number, seen, base)
        entry = evaluate(child)
        seen.add(space.genotype(child))
        entry["parent"] = parent.name
        if "rationale" in proposal:
            entry["rationale"] = proposal["rationale"]
        challengers.append(entry)
        if entry["fitness"] - best_by_parent[parent.name]["fitness"] >= policy.minimum_gain:
            best_by_parent[parent.name] = entry

    ranked_lineages = rank(best_by_parent.values())
    survivors = ranked_lineages[:-policy.research_slots]
    removed = ranked_lineages[-policy.research_slots:]
    ideas = []
    for data in plan["ideas"]:
        child = space.candidate_type(**(data | {"created_round": round_number}))
        if space.genotype(child) in seen:
            raise ValueError(f"Already scored research proposal: {child.name}")
        ideas.append(evaluate(child))
        seen.add(space.genotype(child))
    retained = rank(survivors + ideas)
    return {"round": round_number, "ranked": retained, "challengers": rank(challengers + ideas),
            "pruned": [entry["candidate"] for entry in removed],
            "pruned_scores": removed, "incumbents": parents,
            "admitted": [entry["candidate"] for entry in ideas],
            "next_pool": [entry["candidate"] for entry in retained]}

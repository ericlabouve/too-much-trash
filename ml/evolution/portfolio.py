"""Select a champion, complementary specialists, and protected lineages."""

from collections import Counter
from collections.abc import Callable
from dataclasses import dataclass


@dataclass(frozen=True)
class Portfolio:
    objectives: Callable[[dict], tuple[tuple[str, float], ...]]
    coverage: Callable[[dict], tuple[float, ...] | list[float]]
    family_limit: int = 3
    protected_slots: int = 3
    mutation_attempts: int = 3

    def select(self, parents, children, ideas, space, policy, protected=()):
        key = space.rank_key
        pool_size = policy.pool_size
        name = lambda entry: entry["candidate"]["name"]
        family = lambda entry: space.family(space.candidate_type(**entry["candidate"]))
        by_name = {name(entry): entry for entry in parents}
        by_parent = {entry["candidate"]["parent"]: entry for entry in children}
        all_scores = [*parents, *children, *ideas]
        champion = min(all_scores, key=key)
        competition = dict(by_name)
        competition.update({name(entry): entry for entry in children})
        protected_next = []
        selected = {name(champion): champion}

        for lane in protected:
            parent = by_name[lane["name"]]
            child = by_parent.get(lane["name"])
            attempts = lane["attempts"] + (child is not None)
            if attempts >= self.mutation_attempts:
                continue
            contenders = [parent, child] if child is not None else [parent]
            lead = min(contenders, key=key)
            protected_next.append({"name": name(lead), "attempts": attempts,
                                   "root": lane["root"]})
            selected[name(lead)] = lead
            for contender in contenders:
                competition.pop(name(contender))

        roles = {name(champion): "champion"}
        if ideas and len(protected_next) < self.protected_slots:
            represented = Counter(family(entry) for entry in parents)
            coverage = self.coverage(champion)
            candidates = [entry for entry in ideas if name(entry) not in selected]
            if candidates:
                entrant = min(candidates, key=lambda entry: (
                    represented[family(entry)],
                    -self._additional_coverage(coverage, entry),
                    key(entry),
                ))
                selected[name(entrant)] = entrant
                protected_next.append({"name": name(entrant), "attempts": 0, "root": name(entrant)})
        for lane in protected_next:
            roles.setdefault(lane["name"], "exploration")

        eligible = {candidate: entry for candidate, entry in competition.items()
                    if candidate not in selected}
        counts = Counter(family(entry) for entry in selected.values())

        def retain(entry, role):
            selected[name(entry)] = eligible.pop(name(entry))
            roles[name(entry)] = role
            counts[family(entry)] += 1

        # Keep the best on each individual objective when it adds a specialist.
        for index, (label, value) in enumerate(self.objectives(champion)):
            if len(selected) >= pool_size or not eligible:
                break
            best = min(eligible.values(), key=lambda entry: (-self.objectives(entry)[index][1], key(entry)))
            if self.objectives(best)[index][1] > value:
                retain(best, label)

        # A family cap limits near-duplicates, with a fallback when variety is scarce.
        # Coverage is compared to the mature pool so promising but early variants
        # do not prevent retaining a complementary candidate with stronger evidence.
        mature = [entry for candidate, entry in selected.items() if roles[candidate] != "exploration"]
        covered = tuple(map(max, zip(*(self.coverage(entry) for entry in mature), strict=True)))
        while len(selected) < pool_size:
            options = [entry for entry in eligible.values() if counts[family(entry)] < self.family_limit]
            best = min(options or eligible.values(), key=lambda entry: (
                -self._additional_coverage(covered, entry), key(entry)
            ))
            retain(best, "competitive")
            covered = tuple(map(max, zip(covered, self.coverage(best), strict=True)))
        retained = sorted(selected.values(), key=key)
        removed = sorted((entry for entry in parents if name(entry) not in selected), key=key)
        return retained, removed, {"protected": protected_next, "roles": roles}

    def _additional_coverage(self, covered, entry):
        return sum(max(0, value - prior) for prior, value in zip(covered, self.coverage(entry), strict=True))

"""Dependency-free checks using an unrelated integer-search domain."""

from dataclasses import asdict, dataclass, replace
import json
import unittest

from ml.evolution import Policy, SearchSpace, run_round
from ml.evolution.agent_briefs import build_briefs


@dataclass(frozen=True)
class Number:
    name: str
    value: int
    created_round: int = 1
    parent: str | None = None


def evaluate(candidate):
    return {"candidate": asdict(candidate), "fitness": -abs(candidate.value - 5)}


SPACE = SearchSpace(
    Number,
    lambda candidate: (candidate.value,),
    lambda candidate: [replace(candidate, value=candidate.value + step) for step in (-1, 1)],
    lambda candidate: "integer",
    lambda candidate: "Integer search",
)
POLICY = Policy(pool_size=4, family_limit=4, research_slots=1)


class EvolutionTests(unittest.TestCase):
    def setUp(self):
        self.pool = [Number(f"Parent {index}", index) for index in range(4)]
        self.seen = {SPACE.genotype(candidate) for candidate in self.pool}
        self.plan = {
            "mutations": {candidate.name: {"changes": {"value": candidate.value + 10},
                                          "rationale": "Explore beyond the local neighbors"}
                          for candidate in self.pool},
            "ideas": [{"name": "Research idea", "value": 5}],
        }

    def test_research_selection_and_resume(self):
        result = run_round(self.pool, 2, self.seen, evaluate, SPACE, policy=POLICY, plan=self.plan)
        self.assertEqual(result["ranked"][0]["candidate"]["value"], 5)
        self.assertEqual(len(result["challengers"]), 5)
        self.assertEqual(len(result["pruned"]), 1)
        self.assertEqual(len(result["admitted"]), 1)
        self.assertTrue(all(entry["rationale"] for entry in result["challengers"] if entry.get("parent")))
        restored = json.loads(json.dumps(result))
        pool = [Number(**entry) for entry in restored["next_pool"]]
        left = run_round(pool, 3, self.seen.copy(), evaluate, SPACE, policy=POLICY, seed=7)
        right = run_round(pool, 3, self.seen.copy(), evaluate, SPACE, policy=POLICY, seed=7)
        self.assertEqual(left, right)
        self.assertEqual(len(left["next_pool"]), 4)
        self.assertLessEqual(len(left["pruned"]), 1)

    def test_incomplete_plan_rejected(self):
        self.plan["mutations"].pop(self.pool[0].name)
        with self.assertRaises(ValueError):
            run_round(self.pool, 2, self.seen, evaluate, SPACE, policy=POLICY, plan=self.plan)

    def test_briefs_use_domain_context_and_policy(self):
        briefs = build_briefs({"round": 1, "next_pool": [asdict(c) for c in self.pool]},
                              "numbers.json", context="Minimize distance to five", policy=POLICY)
        self.assertEqual(len(briefs["parents"]), 4)
        self.assertTrue(briefs["parents"][0]["ambitious"])
        self.assertIn("Minimize distance to five", briefs["research"])
        self.assertIn("exactly 1 new candidates", briefs["research"])

    def test_failed_child_can_be_retried(self):
        def failing(candidate):
            if candidate.parent:
                raise RuntimeError("Evaluation unavailable")
            return evaluate(candidate)

        with self.assertRaises(RuntimeError):
            run_round(self.pool, 2, self.seen, failing, SPACE, policy=POLICY, plan=self.plan)
        self.assertNotIn((10,), self.seen)


if __name__ == "__main__":
    unittest.main()

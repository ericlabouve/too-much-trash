"""Jaw fitness and supplementary deposit metrics."""

from math import isfinite

FITNESS_WEIGHTS = {"jaw_f1": 0.80, "speed_score": 0.20}
MATCH_SECONDS = 0.5
PHONE_TARGET_FPS = 60
DETECTOR_FRAME_SHARE = 0.25
FRAME_TIME_MS = 1000 / PHONE_TARGET_FPS
FULL_SPEED_CREDIT_MS = FRAME_TIME_MS * DETECTOR_FRAME_SHARE


def detector_speed_score(p95_ms):
    if not isfinite(p95_ms) or p95_ms < 0:
        raise ValueError("Detector p95 must be finite and nonnegative")
    return min(1.0, max(0.0, (FRAME_TIME_MS - p95_ms) / (FRAME_TIME_MS - FULL_SPEED_CREDIT_MS)))


def deposit_metrics(predictions, references):
    """Compare binary outcomes and give both reference classes equal weight."""
    matched = missed = false_positives = rejected = 0
    for prediction, reference in zip(predictions, references, strict=True):
        if type(prediction) is not bool or type(reference) is not bool:
            raise ValueError("Deposit scoring requires a binary prediction and reviewed outcome")
        if reference and prediction:
            matched += 1
        elif reference:
            missed += 1
        elif prediction:
            false_positives += 1
        else:
            rejected += 1
    if not (matched + missed and rejected + false_positives):
        raise ValueError("Balanced deposit accuracy requires both reference outcomes")
    return {
        "balanced_accuracy": 0.5 * (matched / (matched + missed)
                                    + rejected / (rejected + false_positives)),
        "matched": matched,
        "missed": missed,
        "false_positives": false_positives,
        "rejected": rejected,
        "f1": 2 * matched / (2 * matched + missed + false_positives),
    }


def jaw_fitness(jaw_f1, speed_score):
    if any(not isfinite(value) or not 0 <= value <= 1 for value in (jaw_f1, speed_score)):
        raise ValueError("Fitness inputs must be finite scores between zero and one")
    return FITNESS_WEIGHTS["jaw_f1"] * jaw_f1 + FITNESS_WEIGHTS["speed_score"] * speed_score


def fitness_for(entry):
    return jaw_fitness(entry["development"]["f1"], entry["speed_score"])

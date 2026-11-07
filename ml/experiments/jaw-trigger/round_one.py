"""Run marker-free selection rounds on timestamped iPhone clips."""

import argparse
from bisect import bisect_right
from collections import Counter, deque
from dataclasses import asdict, dataclass, replace
import json
import math
from pathlib import Path
from random import Random
from statistics import median
from tempfile import NamedTemporaryFile
from time import perf_counter_ns

import av
import cv2
import numpy as np

from alternative_signals import (
    fit_jaw_projection, imu_features, motion_samples, projected_jaw_features, sparse_jaw_flow, visual_features,
)


SAMPLE_HZ = 15
MATCH_SECONDS = 0.5
PHONE_TARGET_FPS = 60
DETECTOR_FRAME_SHARE = 0.25
CALIBRATION_FRAMES = 8
MAX_CANDIDATES = 10
MAX_PER_METHOD = 5
MIN_FITNESS_GAIN = 0.001
FALSE_TRIGGER_COST = 2
PROJECTION_METHODS = {"linear_hog", "linear_hog_rearm", "linear_hog_median", "linear_hog_slope", "linear_hog_regularized"}


@dataclass(frozen=True)
class Candidate:
    name: str
    method: str
    threshold: float
    confirm: int = 2
    smoothing: int = 1
    cooldown: int = 0
    signal: str = "default"
    created_round: int = 1
    parent: str | None = None


CANDIDATES = [
    Candidate("gray template", "gray", 0.20),
    Candidate("edge template", "edge", 0.30),
    Candidate("row edge profile", "profile", 0.20),
    Candidate("shaft-aligned template", "aligned", 0.20),
    Candidate("bilateral flow", "flow", 0.18),
]


ALTERNATIVES = [
    Candidate("jaw angle", "angle", 0.12),
    Candidate("shaft-relative jaw patch", "patch", 3.0),
    Candidate("spatial gradient histograms", "gradient", 0.28),
    Candidate("calibrated change occupancy", "occupancy", 0.10),
    Candidate("acceleration transients", "imu", 0.15, confirm=1, cooldown=8),
]

RESEARCH_CANDIDATES = [
    Candidate("short-window gradient change", "local_gradient", 0.06),
    Candidate("gyro-damped bilateral flow", "gyro_flow", 0.05),
    Candidate("shaft-relative gradients", "shaft_gradient", 0.22),
    Candidate("center-surround gradients", "surround_gradient", 0.15),
    Candidate("sparse jaw flow", "sparse_flow", 0.15),
    Candidate("acceleration-confirmed gradients", "accel_gradient", 0.25),
    Candidate("adaptive open-reference gradients", "adaptive_gradient", 0.18),
    Candidate("cumulative gradients", "gradient_cusum", 0.12),
    Candidate("gyro-gated gradients", "gyro_gradient_veto", 0.18),
    Candidate("top-cell gradients", "gradient_topcell", 0.48),
    Candidate("sparse-flow gradient rescue", "gradient_flow_rescue", 0.28),
    Candidate("fitted signed HOG projection", "linear_hog", 0.70),
    Candidate("fitted HOG with open rearming", "linear_hog_rearm", 0.62),
    Candidate("fitted HOG with median squeeze", "linear_hog_median", 0.70),
    Candidate("fitted HOG with rising squeeze", "linear_hog_slope", 0.62),
    Candidate("regularized fitted HOG", "linear_hog_regularized", 0.78),
]


def load_frames(path):
    frames = []
    with av.open(str(path)) as video:
        first = None
        for frame in video.decode(video=0):
            if frame.time is None:
                continue
            first = frame.time if first is None else first
            timestamp = frame.time - first
            if timestamp + 0.001 < len(frames) / SAMPLE_HZ:
                continue
            image = frame.reformat(width=320, height=240, format="gray").to_ndarray()
            image = np.rot90(image, round(frame.rotation / 90))
            frames.append((timestamp, cv2.resize(image, (320, 240))))
    return frames


def correlate_difference(left, right):
    return 1 - float(cv2.matchTemplate(left, right, cv2.TM_CCOEFF_NORMED)[0, 0])


def features(method, frames, signal="default", samples=None, parameters=None):
    if method in PROJECTION_METHODS:
        key = "linear_hog_regularized" if method == "linear_hog_regularized" else "linear_hog"
        return projected_jaw_features(frames, parameters[key], CALIBRATION_FRAMES)
    if method == "gradient_flow_rescue":
        visual, visual_ms = visual_features("gradient", frames, CALIBRATION_FRAMES)
        flow, flow_ms = features("sparse_flow", frames, signal)
        votes, values, durations = deque(maxlen=4), [], []
        for (timestamp, distance), (_, motion), a, b in zip(visual, flow, visual_ms, flow_ms, strict=True):
            start = perf_counter_ns()
            votes.append(motion >= 0.15)
            if 0.16 <= distance < 0.28 and sum(votes) >= 2:
                distance = 0.29
            values.append((timestamp, distance))
            durations.append(a + b + (perf_counter_ns() - start) / 1_000_000)
        return values, durations
    if method == "imu":
        return imu_features(frames, samples["accelerometer"])
    if method == "gradient_cusum":
        return visual_features("gradient", frames, CALIBRATION_FRAMES)
    if method == "gyro_gradient_veto":
        visual, durations = visual_features("gradient", frames, CALIBRATION_FRAMES)
        times, gyro = samples["gyroscope"]
        values = []
        for index, (timestamp, value) in enumerate(visual):
            start = perf_counter_ns()
            motion_index = bisect_right(times, timestamp) - 1
            if 0.16 <= value < 0.28 and motion_index >= 0 and np.linalg.norm(gyro[motion_index]) > 0.8:
                value = math.nan
            values.append((timestamp, value))
            durations[index] += (perf_counter_ns() - start) / 1_000_000
        return values, durations
    if method == "accel_gradient":
        visual, visual_ms = visual_features("gradient", frames, CALIBRATION_FRAMES)
        motion, motion_ms = imu_features(frames, samples["accelerometer"])
        recent = deque(maxlen=3)
        values = []
        durations = []
        for (timestamp, value), (_, jerk), a, b in zip(visual, motion, visual_ms, motion_ms, strict=True):
            start = perf_counter_ns()
            recent.append(jerk)
            values.append((timestamp, value + (0.08 if value > 0.14 and max(recent) > 0.10 else 0)))
            durations.append(a + b + (perf_counter_ns() - start) / 1_000_000)
        return values, durations
    if method in {"angle", "patch", "gradient", "occupancy", "shaft_gradient", "local_gradient", "surround_gradient", "adaptive_gradient", "gradient_topcell"}:
        return visual_features(method, frames, CALIBRATION_FRAMES)
    values, durations = [], []
    baseline = []
    previous = reference_shaft = None
    for timestamp, frame in frames:
        started = perf_counter_ns()
        # Common framing for this mount, selected on development footage.
        crop = frame[105:207, 148:207]
        if method == "aligned" or signal == "shaft":
            shaft = frame[193:229, 197:239].astype(np.float32)
            if reference_shaft is None:
                reference_shaft = shaft
            (dx, dy), confidence = cv2.phaseCorrelate(reference_shaft, shaft)
            if confidence >= 0.3 and max(abs(dx), abs(dy)) <= 5:
                x, y = round(dx), round(dy)
                crop = frame[105 + y:207 + y, 148 + x:207 + x]
        if method == "sparse_flow":
            value = sparse_jaw_flow(previous, crop) if previous is not None else 0.0
            previous = crop.copy()
        elif method in {"flow", "gyro_flow"}:
            value = 0.0
            if previous is not None:
                flow = cv2.calcOpticalFlowFarneback(previous, crop, None, 0.5, 2, 11, 2, 5, 1.1, 0)
                left = float(np.median(flow[10:75, 8:27, 0]))
                right = float(np.median(flow[10:75, 32:51, 0]))
                value = left - right
                if signal == "opposed":
                    # A large difference can come from one moving patch. Require
                    # evidence on both sides before counting it as jaw movement.
                    value = 2 * (min(max(left, 0), max(-right, 0))
                                 - min(max(-left, 0), max(right, 0)))
            if method == "gyro_flow":
                times, gyro = samples["gyroscope"]
                index = max(0, bisect_right(times, timestamp) - 1)
                if times[index] <= timestamp:
                    value /= 1 + float(np.linalg.norm(gyro[index])) / 0.8
            previous = crop.copy()
        else:
            if method in {"edge", "profile"}:
                crop = np.abs(cv2.Sobel(crop, cv2.CV_32F, 1, 0, ksize=3))
            if method == "profile":
                crop = crop.mean(axis=1, keepdims=True)
            if len(baseline) < CALIBRATION_FRAMES:
                baseline.append(crop.copy())
                value = 0.0
            else:
                value = correlate_difference(crop.astype(np.float32), baseline[-1].astype(np.float32))
        durations.append((perf_counter_ns() - started) / 1_000_000)
        values.append((timestamp, value))
    return values, durations


def events(candidate, samples, confirmation_time=False):
    closed, streak, output = False, [], []
    flow = candidate.method in {"flow", "gyro_flow", "local_gradient", "sparse_flow"}
    recent = deque(maxlen=candidate.smoothing)
    last_event = -candidate.cooldown
    evidence = 0.0
    rearm_remaining = 0
    slope = deque(maxlen=4)
    for index, (time, value) in enumerate(samples[CALIBRATION_FRAMES:]):
        if not math.isfinite(value):
            recent.clear()
            streak.clear()
            evidence = 0.0
            slope.clear()
            continue
        recent.append(value)
        mean_value = sum(recent) / len(recent)
        if candidate.method == "linear_hog_slope":
            slope.append(mean_value)
        if rearm_remaining:
            rearm_remaining = (rearm_remaining - 1 if mean_value < candidate.threshold * 0.70 else 3)
            continue
        if index - last_event < candidate.cooldown:
            continue
        value = median(recent) if candidate.method == "linear_hog_median" and not closed else mean_value
        threshold = candidate.threshold
        if candidate.method == "gradient_cusum":
            evidence = max(0.0, evidence + (0.20 - value if closed else value - 0.15))
            crosses = evidence > threshold * (0.75 if closed else 1.0)
        elif candidate.method == "gyro_gradient_veto" and closed:
            crosses = value < 0.16
        elif candidate.method == "imu":
            crosses = value > threshold
        else:
            crosses = (value < -threshold if flow else value < threshold * 0.70) if closed else value > threshold
        if candidate.method == "linear_hog_slope" and not closed:
            crosses = crosses and len(slope) == slope.maxlen and value - slope[0] > 0.04
        if not crosses:
            streak.clear()
            continue
        streak.append(time)
        if len(streak) == candidate.confirm:
            closed = not closed
            last_event = index
            evidence = 0.0
            if not closed and candidate.method == "linear_hog_rearm":
                rearm_remaining = 3
            output.append(("close" if closed else "open", time if confirmation_time else streak[0]))
            streak.clear()
    return output


def accuracy(predictions, labels):
    matched = false_positives = missed = clean_clips = 0
    errors = []
    for predicted, expected in zip(predictions, labels, strict=True):
        remaining = list(expected.items())
        previous_false_positives = false_positives
        for kind, time in predicted:
            matches = [(abs(time - reference), index) for index, (event, reference) in enumerate(remaining)
                       if event == kind and abs(time - reference) <= MATCH_SECONDS]
            if matches:
                error, index = min(matches)
                remaining.pop(index)
                matched += 1
                errors.append(error)
            else:
                false_positives += 1
        missed += len(remaining)
        if not remaining and false_positives == previous_false_positives:
            clean_clips += 1
    return {
        "f1": 2 * matched / (2 * matched + false_positives + missed),
        "matched": matched,
        "false_positives": false_positives,
        "missed": missed,
        "clean_clips": clean_clips,
        "median_error_seconds": median(errors) if errors else None,
    }


def write_progress(path, step, ranked, *, pool, round_number=1, active_candidate=None, result=None):
    if path is None:
        return
    snapshot = {
        "step": step,
        "round": round_number,
        "active_candidate": active_candidate,
        "pool": [asdict(candidate) for candidate in pool],
        "ranked": ranked,
        "result": result,
    }
    if path.exists():
        prior = json.loads(path.read_text())
        for field in ("iphone_benchmark", "iphone_timing"):
            if field in prior:
                snapshot[field] = prior[field]
    with NamedTemporaryFile(mode="w", dir=path.parent, prefix=".progress-", suffix=".json", delete=False) as pending:
        json.dump(snapshot, pending)
    Path(pending.name).replace(path)


def genotype(candidate):
    return (candidate.method, candidate.threshold, candidate.confirm,
            candidate.smoothing, candidate.cooldown, candidate.signal)


def neighbors(parent):
    base = next(candidate for candidate in [*CANDIDATES, *ALTERNATIVES, *RESEARCH_CANDIDATES] if candidate.method == parent.method)
    thresholds = [round(base.threshold * 2 ** (step / 4), 4) for step in range(-8, 9)]
    choices = {
        "threshold": thresholds,
        "confirm": [1, 2, 3, 4, 5],
        "smoothing": [1, 2, 3, 5, 7],
        "cooldown": [0, 4, 8, 12, 16],
    }
    for field, levels in choices.items():
        current = getattr(parent, field)
        below = [level for level in levels if level < current]
        above = [level for level in levels if level > current]
        for value in below[-1:] + above[:1]:
            yield replace(parent, **{field: value})
    if parent.method == "flow":
        for signal in ("default", "opposed", "shaft"):
            if signal != parent.signal:
                yield replace(parent, signal=signal)


def mutate(parent, seen, round_number, rng):
    local = list(neighbors(parent))
    unseen = {genotype(child): child for child in local if genotype(child) not in seen}
    # Occasionally take two steps to escape a local plateau. Fall back to
    # two-step mutations when all one-step neighbors have already been scored.
    if not unseen or rng.random() < 0.25:
        broader = {genotype(child): child for neighbor in local for child in neighbors(neighbor)
                   if genotype(child) not in seen and genotype(child) not in unseen}
        unseen = broader or unseen
    if not unseen:
        return None
    child = rng.choice(list(unseen.values()))
    base = next(candidate.name for candidate in [*CANDIDATES, *ALTERNATIVES, *RESEARCH_CANDIDATES] if candidate.method == parent.method)
    return replace(child, name=f"{base} / R{round_number} trial {len(seen) + 1}",
                   created_round=round_number, parent=parent.name)


def resume_pool(prior):
    births = {}
    for record in prior.get("history", []):
        for entry in record["challengers"]:
            candidate = entry["candidate"]
            births.setdefault(candidate["name"], {
                "created_round": record["round"], "parent": entry.get("parent"),
            })
    original_child = prior.get("offspring", {}).get("name", "bilateral flow / 3-frame confirmation")
    births.setdefault(original_child, {"created_round": 1, "parent": "bilateral flow"})
    pool = [Candidate(**(births.get(data["name"], {}) | data)) for data in prior.get("next_pool", [])]
    if prior and "history" not in prior:
        pool = list(dict.fromkeys([*CANDIDATES, *pool]))
    return pool or CANDIDATES.copy()


def rank_scores(scores):
    return sorted(scores, key=lambda entry: (
        -entry["fitness"], entry["development"]["false_positives"], entry["development"]["missed"],
        -entry["worst_clip_accuracy"], entry["candidate"]["name"],
    ))


def precision_weighted_accuracy(metrics):
    matched = metrics["matched"]
    return matched / (matched + metrics["missed"] + FALSE_TRIGGER_COST * metrics["false_positives"])


def score(candidate, measured, labels, confirmation_time=False):
    p95 = float(np.percentile([time for _, times in measured for time in times], 95))
    frame_ms = 1000 / PHONE_TARGET_FPS
    detector_budget = frame_ms * DETECTOR_FRAME_SHARE
    speed = min(1.0, max(0.0, (frame_ms - p95) / (frame_ms - detector_budget)))
    predictions = [events(candidate, samples, confirmation_time) for samples, _ in measured]
    metrics = accuracy(predictions, labels)
    per_clip = [accuracy([predicted], [expected])
                for predicted, expected in zip(predictions, labels, strict=True)]
    clip_f1 = [entry["f1"] for entry in per_clip]
    worst_clip_accuracy = min(map(precision_weighted_accuracy, per_clip))
    pooled_accuracy = precision_weighted_accuracy(metrics)
    accuracy_score = 0.75 * pooled_accuracy + 0.25 * worst_clip_accuracy
    return {"candidate": asdict(candidate), "development": metrics, "p95_ms": p95,
            "clip_f1": clip_f1, "mean_clip_f1": sum(clip_f1) / len(clip_f1), "worst_clip_f1": min(clip_f1),
            "worst_clip_accuracy": worst_clip_accuracy, "pooled_accuracy": pooled_accuracy,
            "accuracy_score": accuracy_score, "speed_score": speed, "fitness": (accuracy_score + speed) / 2}


def evolve(pool, round_number, seen, evaluate, rng):
    parents = rank_scores(evaluate(candidate) for candidate in pool)
    challengers = []
    exhausted = []
    for parent in pool:
        child = mutate(parent, seen, round_number, rng)
        if child is None:
            exhausted.append(parent.name)
            continue
        seen.add(genotype(child))
        entry = evaluate(child)
        entry["parent"] = parent.name
        challengers.append(entry)
    challengers = rank_scores(challengers)
    pruned = []
    pruned_scores = []
    counts = Counter(candidate.method for candidate in pool)
    admitted = []
    if len(pool) < MAX_CANDIDATES:
        for child in challengers:
            if len(pool) + len(admitted) == MAX_CANDIDATES:
                break
            method = child["candidate"]["method"]
            if counts[method] < MAX_PER_METHOD:
                admitted.append(child)
                counts[method] += 1
    else:
        for child in challengers:
            method = child["candidate"]["method"]
            for index in range(len(parents) - 1, -1, -1):
                incumbent = parents[index]
                incumbent_method = incumbent["candidate"]["method"]
                if child["fitness"] - incumbent["fitness"] < MIN_FITNESS_GAIN:
                    break
                if method != incumbent_method and (counts[incumbent_method] == 1 or counts[method] >= MAX_PER_METHOD):
                    continue
                admitted = [child]
                pruned_scores = [parents.pop(index)]
                pruned = [incumbent["candidate"]]
                break
            if admitted:
                break
    retained = rank_scores(parents + admitted)
    return {"round": round_number, "ranked": retained, "challengers": challengers, "exhausted": exhausted,
            "pruned": pruned, "pruned_scores": pruned_scores, "admitted": [entry["candidate"] for entry in admitted],
            "next_pool": [entry["candidate"] for entry in retained]}


def evolve_researched(pool, round_number, seen, evaluate, plan, rng):
    """Evaluate incumbent mutations, then give three fresh ideas pool slots."""
    if len(pool) != MAX_CANDIDATES or len(plan["ideas"]) != 3:
        raise ValueError("A researched round requires ten incumbents and three new ideas")
    if set(plan["mutations"]) != {candidate.name for candidate in pool}:
        raise ValueError("Provide one mutation plan per incumbent")

    parents = rank_scores(evaluate(candidate) for candidate in pool)
    best_by_parent = {entry["candidate"]["name"]: entry for entry in parents}
    challengers = []
    for parent in pool:
        proposal = plan["mutations"][parent.name]
        changes = proposal.get("changes", proposal)
        child = replace(parent, **changes)
        if genotype(child) in seen:
            child = mutate(parent, seen, round_number, rng)
        if child is None:
            continue
        base = (parent.name.split(" / ")[0] if child.method == parent.method else
                next(seed.name for seed in [*CANDIDATES, *ALTERNATIVES, *RESEARCH_CANDIDATES]
                     if seed.method == child.method))
        child = replace(child, name=f"{base} / R{round_number} trial {len(seen) + 1}",
                        created_round=round_number, parent=parent.name)
        seen.add(genotype(child))
        entry = evaluate(child)
        entry["parent"] = parent.name
        if "rationale" in proposal:
            entry["rationale"] = proposal["rationale"]
        challengers.append(entry)
        if entry["fitness"] - best_by_parent[parent.name]["fitness"] >= MIN_FITNESS_GAIN:
            best_by_parent[parent.name] = entry

    ranked_lineages = rank_scores(best_by_parent.values())
    survivors = ranked_lineages[:-3]
    ideas = []
    for data in plan["ideas"]:
        child = Candidate(**(data | {"created_round": round_number}))
        if genotype(child) in seen:
            raise ValueError(f"Already scored research proposal: {child.name}")
        seen.add(genotype(child))
        ideas.append(evaluate(child))
    retained = rank_scores(survivors + ideas)
    return {"round": round_number, "ranked": retained, "challengers": rank_scores(challengers + ideas),
            "pruned": [entry["candidate"] for entry in ranked_lineages[-3:]],
            "pruned_scores": ranked_lineages[-3:], "incumbents": parents,
            "admitted": [entry["candidate"] for entry in ideas],
            "next_pool": [entry["candidate"] for entry in retained]}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("clips", type=Path)
    parser.add_argument("labels", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--progress", type=Path, help="Write live dashboard updates to this JSON file")
    parser.add_argument("--rounds", type=int, default=1)
    parser.add_argument("--seed", type=int, help="Mutation seed, defaults to the resumed seed or 0")
    parser.add_argument("--resume", type=Path, help="Resume from a previous results JSON")
    parser.add_argument("--diversify-flow", action="store_true", help="Replace the lowest five flow variants with alternate signals")
    parser.add_argument("--plan", type=Path, help="One researched round fitting all five clips")
    parser.add_argument("--imu", type=Path, help="IMU sidecars in clip filename order")
    args = parser.parse_args()
    if args.rounds < 1:
        parser.error("--rounds must be positive")
    if args.plan and args.rounds != 1:
        parser.error("Provide one research plan per round")
    plan = json.loads(args.plan.read_text()) if args.plan else None
    cv2.setNumThreads(1)
    paths = sorted(args.clips.glob("*.mp4"))
    labels = json.loads(args.labels.read_text())
    if len(paths) != 5 or set(labels) != {path.name for path in paths}:
        parser.error("Supply five clips with matching reference labels")
    if any(set(pair) != {"close", "open"} or not 0 <= pair["close"] < pair["open"] < math.inf
           for pair in labels.values()):
        parser.error("Each clip needs one squeeze followed by one release with finite timestamps")
    prior = json.loads(args.resume.read_text()) if args.resume else {}
    pool = resume_pool(prior)
    seed = args.seed if args.seed is not None else prior.get("seed", 0)
    if not 1 <= len(pool) <= MAX_CANDIDATES:
        parser.error("Resume file must contain a valid candidate pool")
    start_round = prior.get("round", 1 if prior else 0) + 1
    seed_replacements = []
    if args.diversify_flow:
        flow = [entry["candidate"]["name"] for entry in prior.get("ranked", [])
                if entry["candidate"]["method"] == "flow"]
        if len(pool) != MAX_CANDIDATES or len(flow) != MAX_CANDIDATES:
            parser.error("--diversify-flow expects a ranked pool of ten flow candidates")
        seed_replacements = flow[len(flow) // 2:]
        pool = [candidate for candidate in pool if candidate.name not in seed_replacements]
        pool.extend(replace(candidate, created_round=start_round) for candidate in ALTERNATIVES)
    if any(candidate.method in {"imu", "gyro_flow", "accel_gradient", "gyro_gradient_veto"} for candidate in pool) and not args.imu:
        parser.error("An IMU candidate requires --imu")
    imu = [None] * len(paths)
    if args.imu:
        sidecars = json.loads(args.imu.read_text())
        if len(sidecars) != len(paths):
            parser.error("Supply one IMU sidecar per clip")
        imu = [motion_samples(sidecar) for sidecar in sidecars]
    history = prior.get("history", []).copy()
    seen = {genotype(candidate) for candidate in pool}
    seen.update(tuple(entry) + (1, 0, "default") if len(entry) == 3 else tuple(entry)
                for entry in prior.get("seen", []))
    round_number = start_round
    ranked = []
    write_progress(args.progress, "prepare", ranked, pool=pool, round_number=round_number)
    try:
        frames = [load_frames(path) for path in paths]
        development_count = len(paths) if plan else 3
        dev_labels = [labels[path.name] for path in paths[:development_count]]
        measurements = {}
        parameters = prior.get("feature_parameters", {})
        confirmation_time = bool(plan and plan.get("confirmation_time", True))
        if plan:
            proposed = [*plan["ideas"], *(item.get("changes", item) for item in plan["mutations"].values())]
            methods = {item.get("method") for item in proposed}
            for key, wanted, ridge in (
                ("linear_hog", PROJECTION_METHODS - {"linear_hog_regularized"}, 0.01),
                ("linear_hog_regularized", {"linear_hog_regularized"}, 0.10),
            ):
                if key not in parameters and methods & wanted:
                    parameters[key] = fit_jaw_projection(frames, dev_labels, CALIBRATION_FRAMES, ridge)
        for round_number in range(start_round, start_round + args.rounds):
            ranked = []

            def evaluate(candidate):
                write_progress(args.progress, "replay", ranked, pool=pool,
                               round_number=round_number, active_candidate=candidate.name)
                key = (candidate.method, candidate.signal)
                if key not in measurements:
                    measurements[key] = [features(candidate.method, clip, candidate.signal, samples, parameters)
                                         for clip, samples in zip(frames[:development_count], imu[:development_count], strict=True)]
                entry = score(candidate, measurements[key], dev_labels, confirmation_time)
                ranked.append(entry)
                return entry

            rng = Random(f"{seed}:{round_number}")
            result = (evolve_researched(pool, round_number, seen, evaluate, plan, rng) if plan
                      else evolve(pool, round_number, seen, evaluate, rng))
            history.append(result)
            pool = [Candidate(**candidate) for candidate in result["next_pool"]]
            ranked = result["ranked"]
            write_progress(args.progress, "selected", ranked, pool=pool, round_number=round_number, result=result)

        final = {**result, "history": history, "seen": sorted(seen),
                 "seed": seed, "seed_replacements": seed_replacements,
                 "phone_target_fps": PHONE_TARGET_FPS, "detector_frame_share": DETECTOR_FRAME_SHARE,
                 "development_clips": [p.name for p in paths[:development_count]],
                 "held_out_clips": [p.name for p in paths[development_count:]]}
        if plan:
            final["fit_all_clips"] = True
            final["research_plan"] = plan
            final["confirmation_time"] = confirmation_time
            final["feature_parameters"] = parameters
        else:
            winner = pool[0]
            write_progress(args.progress, "holdout", ranked, pool=pool, round_number=round_number,
                           active_candidate=winner.name, result=result)
            holdout = [events(winner, features(winner.method, clip, winner.signal, samples, parameters)[0])
                       for clip, samples in zip(frames[3:], imu[3:], strict=True)]
            final["winner_holdout"] = accuracy(holdout, [labels[p.name] for p in paths[3:]])
        args.output.write_text(json.dumps(final, indent=2) + "\n")
        write_progress(args.progress, "selected", ranked, pool=pool, round_number=round_number, result=final)
    except (Exception, KeyboardInterrupt):
        write_progress(args.progress, "failed", ranked, pool=pool, round_number=round_number)
        raise


if __name__ == "__main__":
    main()

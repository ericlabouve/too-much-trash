"""Run an agent-guided joint round against the private development manifest."""

import argparse
from dataclasses import asdict, dataclass, fields, replace
import json
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
from tempfile import NamedTemporaryFile
from time import monotonic, perf_counter_ns, sleep

import cv2
import numpy as np
from joint_fitness import FITNESS_WEIGHTS, deposit_metrics, fitness_for
from round_one import (
    CALIBRATION_FRAMES, POLICY, POSE_METHODS, Candidate, accuracy, detector_speed_score, family_name,
    features, genotype, load_frames, measure_events, motion_samples, neighbors, pose_samples, rank_key,
    score, write_progress,
)
from ml.evolution import SearchSpace, run_round
from ml.evolution.portfolio import Portfolio
from alternative_signals import fit_jaw_projection


@dataclass(frozen=True)
class JointCandidate(Candidate):
    deposit_method: str = "motion"
    deposit_threshold: float = 0.07
    release_ratio: float = 0.70
    release_cooldown: int | None = None
    release_confirm: int | None = None


def joint_genotype(candidate):
    return (*genotype(candidate), candidate.deposit_method, candidate.deposit_threshold, candidate.release_ratio,
            candidate.release_cooldown, candidate.release_confirm)


def read_genotype(record):
    if len(record) == 8:
        record = [*record, 0.70]
    return (*record, None, None) if len(record) == 9 else tuple(record)


def joint_neighbors(parent):
    yield from neighbors(parent)
    for cooldown in (3, 6):
        if cooldown != parent.cooldown:
            yield replace(parent, release_cooldown=cooldown)


def detector_family(candidate):
    method = candidate.method
    for family in ("temporal", "motion", "geometry"):
        if method.startswith(family) and method[len(family):].isdigit():
            return family
    if method.startswith("linear_hog"):
        return "fitted_hog"
    if method in {"imu", "gyro_flow", "accel_gradient", "gyro_gradient_veto"}:
        return "motion_fusion"
    if method in {"flow", "sparse_flow", "gradient_flow_rescue"}:
        return "optical_flow"
    if method in {"angle", "patch", "occupancy", "aligned", "gray", "edge", "profile"}:
        return "shape_and_appearance"
    return "gradient_change"


SPACE = SearchSpace(JointCandidate, joint_genotype, joint_neighbors,
                    detector_family, family_name, rank_key)
PORTFOLIO = Portfolio(
    objectives=lambda entry: (("jaw specialist", entry["development"]["f1"]),),
    coverage=lambda entry: entry["clip_f1"],
)


def transfer_strength(before, after, method):
    core = after[20:111, 25:131]
    if np.mean(core > 170) < 0.15:
        return 0.0
    delta = cv2.absdiff(before, after)
    flank = (np.mean(delta[:, :22] > 22) + np.mean(delta[:, -22:] > 22)) / 2
    local = max(0.0, float(np.mean(delta[20:111, 25:131] > 22) - flank))
    if method == "motion":
        return local

    jaw = before[55:76, 63:84]
    mouth = after[25:103, 25:132]
    if method == "transfer_appearance":
        if jaw.std() < 8:
            return 0.0
        interior = cv2.matchTemplate(mouth, jaw, cv2.TM_CCOEFF_NORMED)
        _, correlation, _, (x, y) = cv2.minMaxLoc(interior)
        if abs(x + 25 - 63) + abs(y + 25 - 55) < 8:
            return 0.0
        grip = cv2.matchTemplate(after[55:76, 63:84], jaw, cv2.TM_CCOEFF_NORMED).item()
        return max(0.0, correlation - max(0.65, grip))
    if method == "transfer_occupancy":
        prior = before[25:103, 25:132]
        histograms = [cv2.normalize(cv2.calcHist([frame], [0], None, [16], [0, 256]), None,
                                    alpha=1, norm_type=cv2.NORM_L1) for frame in (prior, mouth)]
        jaw_delta = float(np.mean(delta[55:76, 63:84] > 22))
        return max(0.0, cv2.compareHist(*histograms, cv2.HISTCMP_BHATTACHARYYA) - flank) if jaw_delta > .12 else 0.0
    if method == "transfer_flow":
        mask = np.zeros_like(before)
        mask[48:84, 57:90] = 255
        points = cv2.goodFeaturesToTrack(before, 16, 0.02, 3, mask=mask)
        if points is None:
            return 0.0
        next_points, status, _ = cv2.calcOpticalFlowPyrLK(before, after, points, None)
        if next_points is None:
            return 0.0
        back, returned, _ = cv2.calcOpticalFlowPyrLK(after, before, next_points, None)
        if back is None:
            return 0.0
        shift, _ = cv2.phaseCorrelate(before.astype(np.float32), after.astype(np.float32))
        first, last = points[:, 0], next_points[:, 0]
        valid = status.ravel().astype(bool) & returned.ravel().astype(bool)
        valid &= np.linalg.norm(back[:, 0] - first, axis=1) <= 1.5
        valid &= np.linalg.norm(last - first - shift, axis=1) >= 4
        valid &= (last[:, 0] >= 25) & (last[:, 0] < 132) & (last[:, 1] >= 25) & (last[:, 1] < 103)
        return float(np.count_nonzero(valid)) / 16
    raise ValueError(f"Unknown deposit method {method}")


def deposit_signal(frames, detected, method):
    """Measure transfer evidence near a predicted release, without reference times."""
    durations = np.zeros(len(frames))
    if method.startswith("held_"):
        releases = []
        close = None
        for event, timestamp in detected:
            if event == "close":
                close = timestamp
            elif close is not None and timestamp - close >= 0.40:
                releases.append(timestamp)
                if len(releases) == 2:
                    break
        strengths = []
        for release in releases:
            value, cost = release_signal(frames, release, method.removeprefix("held_"))
            durations += cost
            strengths.append(value)
        return max(strengths, default=0.0), durations
    release = next((t for event, t in detected if event == "open"), None)
    if release is None:
        return 0.0, durations
    return release_signal(frames, release, method)


def release_signal(frames, release, method):
    durations = np.zeros(len(frames))
    values = []
    before = None
    for index, (timestamp, frame) in enumerate(frames):
        if timestamp < release - 0.25:
            continue
        if timestamp > release + 0.45:
            break
        start = perf_counter_ns()
        roi = frame[80:210, 100:255]
        if timestamp < release:
            before = roi
        elif before is not None:
            values.append(transfer_strength(before, roi, method))
            if method == "motion":
                before = roi
        durations[index] = (perf_counter_ns() - start) / 1_000_000
    if method == "motion":
        strength = max(values, default=0.0)
    else:
        strength = max((min(a, b) for a, b in zip(values, values[1:])), default=0.0)
    return strength, durations


def batch_plan(spec, pool, seen, offset):
    """Materialize the next plan using the current ranked pool and agent recipes."""
    ideas = spec["ideas"][offset]
    reserved = seen | {joint_genotype(candidate) for candidate in pool}
    for idea in ideas:
        key = joint_genotype(JointCandidate(**{k: v for k, v in idea.items() if k != "rationale"}))
        if key in reserved:
            raise ValueError(f"Duplicate research proposal {idea['name']}")
        reserved.add(key)
    reserved.update(joint_genotype(JointCandidate(**{k: v for k, v in idea.items() if k != "rationale"}))
                    for future in spec["ideas"][offset + 1:] for idea in future)
    proposals = {}
    limits = {"threshold": (0.05, 2.0), "confirm": (1, 5), "smoothing": (1, 7),
              "cooldown": (0, 24), "release_ratio": (0.40, 0.95),
              "deposit_threshold": (0.01, 0.95)}
    for parent, policy in zip(pool, spec["parents"], strict=True):
        variants = []
        for recipe in policy["recipes"]:
            changes = dict(recipe.get("set", {}))
            for field, delta in recipe.get("add", {}).items():
                low, high = limits[field]
                changes[field] = round(min(high, max(low, getattr(parent, field) + delta)), 4)
            variants.append((replace(parent, **changes), changes, policy["rationale"]))
        variants.extend(
            (child, {key: val for key, val in asdict(child).items() if val != getattr(parent, key)},
             "Bounded neighbor fallback after previously tried agent recipes")
            for child in joint_neighbors(parent)
        )
        for child, changes, rationale in variants:
            key = joint_genotype(child)
            if key not in reserved:
                reserved.add(key)
                proposals[parent.name] = {"changes": changes, "rationale": rationale}
                break
        else:
            raise ValueError(f"No unseen proposal for {parent.name}")
    return {"mutations": proposals, "ideas": ideas}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("prior", type=Path)
    parser.add_argument("plan", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--progress", type=Path)
    parser.add_argument("--batch-rounds", type=int, default=1,
                        help="Apply agent-authored mutation recipes and researched seeds over multiple rounds")
    parser.add_argument("--portfolio", action="store_true", help="Use cross-lineage and protected selection")
    parser.add_argument("--feature-parameters", type=Path, help="JSON parameters for additional candidate methods")
    parser.add_argument("--target-f1", type=float, help="Stop after the first round that reaches this jaw F1")
    parser.add_argument("--target-basis", choices=("development", "withheld"), default="development",
                        help="Which replay can satisfy the target")
    parser.add_argument("--withheld-report", type=Path, help="JSON output from validate_withheld.py")
    args = parser.parse_args()
    if args.target_f1 is not None and not 0 < args.target_f1 <= 1:
        parser.error("--target-f1 must be greater than zero and at most one")
    candidate_fields = {field.name for field in fields(JointCandidate)}
    prior = json.loads(args.prior.read_text())
    withheld = {
        entry["candidate"]["name"]: entry["withheld"]
        for entry in prior["ranked"] if "withheld" in entry
    }
    if args.withheld_report:
        for report in json.loads(args.withheld_report.read_text()):
            if report["reporting"] != "retrospective_block_withheld":
                parser.error("The withheld report must contain capture-block replay results")
            withheld[report["candidate"]["name"]] = report
    manifest = json.loads(args.manifest.read_text())
    clips = manifest["clips"]
    labels = [{"close": row["jaw_reference"]["squeeze"]["button_cue_seconds"],
               "open": row["jaw_reference"]["release"]["button_cue_seconds"]} for row in clips]
    outcomes = [row["deposit"] for row in clips]
    if len({row["clip"] for row in clips}) != len(clips) or any(
        not 0 <= pair["close"] < pair["open"] for pair in labels
    ):
        parser.error("The manifest needs unique clips and ordered jaw references")
    plans_dir = args.plan if args.plan.is_dir() else None
    plan = None if plans_dir else json.loads(args.plan.read_text())
    if args.batch_rounds < 1 or (
        not plans_dir and args.batch_rounds > 1 and len(plan["ideas"]) != args.batch_rounds
    ):
        parser.error("Supply one research proposal group per batch round")
    pool = [JointCandidate(**data) for data in prior["next_pool"]]
    round_number = prior["round"] + 1
    seen = {read_genotype(g) for g in prior["seen"] if len(g) in (8, 9, 11)}
    base = args.manifest.parent
    parameters = dict(prior["feature_parameters"])
    if args.feature_parameters:
        parameters.update(json.loads(args.feature_parameters.read_text()))
    cv2.setNumThreads(1)
    ranked = []
    write_progress(args.progress, "prepare", ranked, pool=pool, round_number=round_number)
    with ThreadPoolExecutor(max_workers=4) as workers:
        frames = list(workers.map(load_frames, [base / row["video"] for row in clips]))
    motion, poses = [], []
    for row in clips:
        capture = json.loads((base / row["capture_manifest"]).read_text())
        with (base / row["imu"]).open() as file:
            motion.append(motion_samples({"start": capture["timing"]["start"],
                                          "samples": [json.loads(line) for line in file]}))
        poses.append((base / row["poses"] if "poses" in row else None, capture["timing"]["start"]))
    jaw_cache, deposit_cache = {}, {}
    pose_inputs = None

    def evaluate(candidate):
        nonlocal pose_inputs
        if candidate.method.startswith("linear_hog_refit") and "linear_hog_refit" not in parameters:
            parameters["linear_hog_refit"] = fit_jaw_projection(
                frames, labels, CALIBRATION_FRAMES, ridge=0.003, balance_clips=True
            )
        write_progress(args.progress, "replay", ranked, pool=pool, round_number=round_number,
                       active_candidate=candidate.name)
        key = (candidate.method, candidate.signal)
        if key not in jaw_cache:
            sensors = motion
            if candidate.method in POSE_METHODS:
                if pose_inputs is None:
                    pose_inputs = [{"imu": imu, "poses": pose_samples(*source)}
                                   for imu, source in zip(motion, poses, strict=True)]
                sensors = pose_inputs
            jaw_cache[key] = [features(candidate.method, clip, candidate.signal, imu, parameters)
                              for clip, imu in zip(frames, sensors, strict=True)]
        measured = jaw_cache[key]
        jaw_predictions, jaw_times = measure_events(candidate, measured)
        entry = score(candidate, measured, labels, predictions=jaw_predictions)
        entry["jaw_by_event"] = {
            kind: accuracy(
                [[event for event in clip if event[0] == kind] for clip in jaw_predictions],
                [{kind: label[kind]} for label in labels],
            )
            for kind in ("close", "open")
        }
        predictions, joint_times = [], []
        for index, (detected, times, clip) in enumerate(zip(jaw_predictions, jaw_times, frames, strict=True)):
            deposit_key = (index, tuple(detected), candidate.deposit_method)
            if deposit_key not in deposit_cache:
                deposit_cache[deposit_key] = deposit_signal(clip, detected, candidate.deposit_method)
            strength, added_ms = deposit_cache[deposit_key]
            predictions.append(bool(strength >= candidate.deposit_threshold))
            joint_times.extend(times + added_ms)
        deposit = deposit_metrics(predictions, outcomes)
        jaw_timings = np.concatenate(jaw_times)
        p95 = float(np.percentile(jaw_timings, 95))
        speed = detector_speed_score(p95)
        entry.update(deposit=deposit, p95_ms=p95, speed_score=speed, peak_ms=float(jaw_timings.max()),
                     joint_p95_ms=float(np.percentile(joint_times, 95)),
                     zero_jaw_clips=entry["clip_f1"].count(0),
                     deposit_predictions=dict(zip((clip["clip"] for clip in clips), predictions, strict=True)))
        entry["fitness"] = fitness_for(entry)
        if candidate.name in withheld:
            report = withheld[candidate.name]
            config = {key: value for key, value in report["candidate"].items() if key in candidate_fields}
            if joint_genotype(JointCandidate(**config)) != joint_genotype(candidate):
                raise ValueError(f"Withheld replay does not match the configuration of {candidate.name}")
            entry["withheld"] = report
        ranked.append(entry)
        return entry

    seed = prior.get("seed", 0)
    for offset in range(args.batch_rounds):
        ranked = []
        if plans_dir:
            path = plans_dir / f"joint-plan-{round_number}.json"
            deadline = monotonic() + 900
            while not path.exists():
                if monotonic() >= deadline:
                    raise TimeoutError(f"Timed out waiting for {path}")
                sleep(0.25)
            active_plan = json.loads(path.read_text())
        else:
            active_plan = batch_plan(plan, pool, seen, offset) if args.batch_rounds > 1 else plan
        result = run_round(pool, round_number, seen, evaluate, SPACE, policy=POLICY,
                           seed=seed, plan=active_plan, portfolio=PORTFOLIO if args.portfolio else None,
                           protected=prior.get("protected", ()))
        result["fitness_weights"] = FITNESS_WEIGHTS
        evaluated = result["incumbents"] + result["challengers"]
        if args.target_basis == "withheld":
            target_scores = [(entry["withheld"]["jaw"]["f1"], entry["candidate"]["name"])
                             for entry in evaluated if "withheld" in entry]
        else:
            target_scores = [(entry["development"]["f1"], entry["candidate"]["name"]) for entry in evaluated]
        best_target = max(target_scores, default=None)
        if args.target_f1 is not None:
            result["target_f1"] = args.target_f1
            result["target_basis"] = args.target_basis
            result["target_best"] = ({"f1": best_target[0], "candidate": best_target[1]}
                                     if best_target is not None else None)
            result["target_reached"] = best_target is not None and best_target[0] >= args.target_f1
        result.update(history=[*prior["history"], dict(result)], seen=sorted(seen, key=repr), seed=seed,
                      feature_parameters=parameters, reporting="in_sample", reference="button_cue_seconds",
                      fit_all_clips=True, research_plan=active_plan)
        output = args.output.with_name(f"{args.output.stem}-{round_number}{args.output.suffix}") if args.batch_rounds > 1 else args.output
        with NamedTemporaryFile(mode="w", dir=output.parent, prefix=".round-", suffix=".json", delete=False) as pending:
            json.dump(result, pending, indent=2)
            pending.write("\n")
        Path(pending.name).replace(output)
        pool = [JointCandidate(**entry) for entry in result["next_pool"]]
        write_progress(args.progress, "selected", result["ranked"], pool=pool,
                       round_number=round_number, result=result)
        winner = result["ranked"][0]
        print(f"Round {round_number}: fitness {winner['fitness']:.4f}, "
              f"jaw F1 {winner['development']['f1']:.4f}, "
              f"deposit accuracy {winner['deposit']['balanced_accuracy']:.4f}", flush=True)
        if result.get("target_reached"):
            print(f"Jaw F1 target reached on {args.target_basis} replay by {best_target[1]} "
                  f"at {best_target[0]:.4f}.", flush=True)
            break
        prior = result
        round_number += 1


if __name__ == "__main__":
    main()

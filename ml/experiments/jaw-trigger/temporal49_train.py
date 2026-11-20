"""Fit the directed temporal detector and replay withheld capture blocks."""

import argparse
from dataclasses import asdict
from itertools import product
import json
from pathlib import Path

import cv2
import numpy as np

from joint_fitness import detector_speed_score, jaw_fitness
from round_one import accuracy, measure_events
from run_joint_round import JointCandidate
from temporal47_train import load_inputs
from temporal48_train import phase_metrics, predict
from temporal49 import features, fit, prepare, score_prepared


NAME = "R49 directed visual jaw boundaries and causal state filter"
RATIONALE = (
    "Fit separate state and close/release boundary heads using an interior shaft-aligned video strip, "
    "signed visual differences and IMU magnitudes. Combine them online with a two-state forward filter. "
    "Inspired by boundary and frame-state supervision in Ishikawa et al. "
    "https://openaccess.thecvf.com/content/WACV2021/html/"
    "Ishikawa_Alleviating_Over-Segmentation_Errors_by_Detecting_Action_Boundaries_WACV_2021_paper.html "
    "and the causal forward recursion in https://www.cs.cmu.edu/~durand/03-711/Readings/Rabiner89.pdf."
)


def select_decoder(series, labels):
    settings = product((0.44, 0.55, 0.66, 0.77), (1, 2), (1, 2, 3), (12, 20),
                       (0.62, 0.79, 0.94), (2, 4), (1, 2))
    best_key, best = None, None
    for threshold, confirm, smoothing, cooldown, ratio, dwell, release_confirm in settings:
        candidate = JointCandidate(name=NAME, method="temporal49", threshold=threshold,
                                   confirm=confirm, smoothing=smoothing, cooldown=cooldown,
                                   release_ratio=ratio, release_cooldown=dwell,
                                   release_confirm=release_confirm, deposit_method="held_transfer_flow",
                                   deposit_threshold=0.1875)
        metrics = accuracy(predict(candidate, series), labels)
        key = (metrics["f1"], -metrics["false_positives"], metrics["clean_clips"],
               -(metrics["median_error_seconds"] or 0))
        if best_key is None or key > best_key:
            best_key, best = key, candidate
    return best


def train_model(prepared, labels, indices):
    return fit([prepared[i] for i in indices], [labels[i] for i in indices])


def calibrate_inside_training(prepared, labels, train):
    by_index = {}
    for internal_validation in np.array_split(train, 3):
        internal_train = [i for i in train if i not in internal_validation]
        model = train_model(prepared, labels, internal_train)
        by_index.update({i: score_prepared(prepared[i], model) for i in internal_validation})
    return select_decoder([by_index[i] for i in train], [labels[i] for i in train])


def check_prefix(frames, motion, model, measured):
    for index in (0, 5, len(frames) - 1):
        prefix = frames[index][:40]
        timestamp = prefix[-1][0]
        truncated = {stream: (times[:stop], vectors[:stop])
                     for stream, (times, vectors) in motion[index].items()
                     if (stop := int(np.searchsorted(times, timestamp, side="right"))) > 0}
        if features(prefix, truncated, model)[0] != measured[index][0][:len(prefix)]:
            raise ValueError("Removing future frames or IMU changed a causal prediction")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    cv2.setNumThreads(1)
    clips = json.loads(args.manifest.read_text())["clips"]
    if len(clips) != 62:
        parser.error("This retrospective fold definition requires the original 62-clip archive")
    frames, motion, labels = load_inputs(args.manifest)
    prepared = [prepare(clip, sensors) for clip, sensors in zip(frames, motion, strict=True)]
    groups = [("earlier_capture_batch", list(range(5)))] + [
        (f"contiguous_later_block_{index + 1}", list(map(int, group)))
        for index, group in enumerate(np.array_split(np.arange(5, len(clips)), 4))]
    indices = range(len(clips))
    folds, oof_scores, oof_predictions, oof_times = [], {}, {}, []
    for name, test in groups:
        train = [i for i in indices if i not in test]
        candidate = calibrate_inside_training(prepared, labels, train)
        model = train_model(prepared, labels, train)
        measured = [features(frames[i], motion[i], model) for i in test]
        predicted, timings = measure_events(candidate, measured)
        test_labels = [labels[i] for i in test]
        metrics = accuracy(predicted, test_labels)
        oof_times.extend(timings)
        oof_scores.update(zip(test, (values for values, _ in measured), strict=True))
        oof_predictions.update(zip(test, predicted, strict=True))
        folds.append({"id": name, "train_clips": [clips[i]["clip"] for i in train],
                      "test_clips": [clips[i]["clip"] for i in test], "candidate": asdict(candidate),
                      "model": model, "metrics": metrics, "phases": phase_metrics(predicted, test_labels)})
        print(f"{name}: {metrics}", flush=True)

    pooled_predictions = [oof_predictions[i] for i in indices]
    withheld = accuracy(pooled_predictions, labels)
    full_candidate = select_decoder([oof_scores[i] for i in indices], labels)
    model = train_model(prepared, labels, indices)
    measured = [features(clip, sensors, model) for clip, sensors in zip(frames, motion, strict=True)]
    check_prefix(frames, motion, model, measured)
    predicted, timings = measure_events(full_candidate, measured)
    p95 = float(np.percentile(np.concatenate(timings), 95))
    withheld_p95 = float(np.percentile(np.concatenate(oof_times), 95))
    development = accuracy(predicted, labels)
    candidate = asdict(full_candidate)
    candidate.pop("parent")
    candidate.pop("created_round")
    candidate["rationale"] = RATIONALE
    artifact = {"candidate": candidate, "model": model, "folds": folds, "withheld": withheld,
                "withheld_phases": phase_metrics(pooled_predictions, labels),
                "withheld_p95_ms": withheld_p95, "development": development,
                "development_phases": phase_metrics(predicted, labels), "p95_ms": p95,
                "fitness": jaw_fitness(development["f1"], detector_speed_score(p95)),
                "prefix_checked_clips": 3}
    args.output.write_text(json.dumps(artifact, separators=(",", ":")) + "\n")
    print(f"Pooled withheld: {withheld}; p95 {withheld_p95:.3f} ms\n"
          f"Full development: {development}; p95 {p95:.3f} ms", flush=True)


if __name__ == "__main__":
    main()

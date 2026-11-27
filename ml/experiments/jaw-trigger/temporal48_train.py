"""Fit temporal48 and run deterministic nested capture-block validation."""

import argparse
from dataclasses import asdict
from itertools import product
import json
from pathlib import Path

import cv2
import numpy as np

from joint_fitness import detector_speed_score, jaw_fitness
from round_one import accuracy, events, measure_events
from run_joint_round import JointCandidate
from temporal47_train import load_inputs
from temporal48 import features, fit, prepare


NAME = "R48 regularized causal scanline and motion state"
RATIONALE = (
    "Reduce capacity with shaft-relative scanlines, fixed causal fast/slow filters and small IMU "
    "magnitudes. Fit clip-balanced ridge with a same-state score-change penalty to limit chatter. "
    "Choose each outer fold's decoder on nested training-only splits. The score-consistency "
    "penalty is inspired by https://openaccess.thecvf.com/content_CVPR_2019/html/"
    "Abu_Farha_MS-TCN_Multi-Stage_Temporal_Convolutional_Network_for_Action_Segmentation_CVPR_2019_paper.html."
)


def scores(prepared, model):
    timestamps, rows = prepared
    values = rows @ np.asarray(model["weights"], dtype=np.float32) + model["intercept"]
    return list(zip(timestamps, values, strict=True))


def select_decoder(series, labels):
    best_key, best = None, None
    settings = product((0.48, 0.54, 0.60, 0.66), (1, 2, 3), (1, 2, 4),
                       (14, 22), (0.70, 0.82, 0.92), (2, 4), (1, 2))
    for threshold, confirm, smoothing, cooldown, ratio, dwell, release_confirm in settings:
        candidate = JointCandidate(name=NAME, method="temporal48", threshold=threshold,
                                   confirm=confirm, smoothing=smoothing, cooldown=cooldown,
                                   release_ratio=ratio, release_cooldown=dwell,
                                   release_confirm=release_confirm, deposit_method="held_transfer_flow",
                                   deposit_threshold=0.1875)
        predicted = [events(candidate, samples, confirmation_time=True) for samples in series]
        metrics = accuracy(predicted, labels)
        key = (metrics["f1"], -metrics["false_positives"], metrics["clean_clips"],
               -(metrics["median_error_seconds"] or 0))
        if best_key is None or key > best_key:
            best_key, best = key, candidate
    return best


def train_model(prepared, labels, indices):
    return fit([prepared[i] for i in indices], [labels[i] for i in indices])


def calibrate_inside_training(prepared, labels, train_indices):
    predictions = {}
    for internal_validation in np.array_split(train_indices, 3):
        internal_train = [i for i in train_indices if i not in internal_validation]
        model = train_model(prepared, labels, internal_train)
        predictions.update({i: scores(prepared[i], model) for i in internal_validation})
    return select_decoder([predictions[i] for i in train_indices], [labels[i] for i in train_indices])


def phase_metrics(predicted, labels):
    return {phase: accuracy([[(kind, stamp) for kind, stamp in episode if kind == phase]
                             for episode in predicted],
                            [{phase: label[phase]} for label in labels])
            for phase in ("close", "open")}


def predict(candidate, values):
    return [events(candidate, samples, confirmation_time=True) for samples in values]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("model", type=Path)
    parser.add_argument("candidate", type=Path)
    parser.add_argument("report", type=Path)
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
    folds, oof_scores, oof_predictions = [], {}, {}
    for name, test in groups:
        train = [i for i in range(len(clips)) if i not in test]
        candidate = calibrate_inside_training(prepared, labels, train)
        model = train_model(prepared, labels, train)
        observed = [scores(prepared[i], model) for i in test]
        test_labels = [labels[i] for i in test]
        predicted = predict(candidate, observed)
        metrics = accuracy(predicted, test_labels)
        oof_scores.update(zip(test, observed, strict=True))
        oof_predictions.update(zip(test, predicted, strict=True))
        folds.append({"id": name, "train_clips": [clips[i]["clip"] for i in train],
                      "test_clips": [clips[i]["clip"] for i in test], "candidate": asdict(candidate),
                      "model": model, "metrics": metrics, "phases": phase_metrics(predicted, test_labels)})
        print(f"{name}: {metrics}", flush=True)

    indices = range(len(clips))
    all_predictions = [oof_predictions[i] for i in indices]
    withheld = accuracy(all_predictions, labels)
    full_candidate = select_decoder([oof_scores[i] for i in indices], labels)
    full_model = train_model(prepared, labels, indices)
    measured = [features(clip, sensors, full_model) for clip, sensors in zip(frames, motion, strict=True)]
    for index in (0, 5, len(clips) - 1):
        prefix = frames[index][:40]
        timestamp = prefix[-1][0]
        truncated = {stream: (times[:stop], vectors[:stop])
                     for stream, (times, vectors) in motion[index].items()
                     if (stop := int(np.searchsorted(times, timestamp, side="right"))) > 0}
        if features(prefix, truncated, full_model)[0] != measured[index][0][:len(prefix)]:
            raise ValueError("Temporal scores changed after removing future video and IMU")
    predicted, timings = measure_events(full_candidate, measured)
    p95 = float(np.percentile(np.concatenate(timings), 95))
    full_metrics = accuracy(predicted, labels)
    candidate = asdict(full_candidate)
    candidate.pop("parent")
    candidate.pop("created_round")
    candidate["rationale"] = RATIONALE
    report = {"candidate": candidate, "folds": folds, "withheld": withheld,
              "withheld_phases": phase_metrics(all_predictions, labels), "development": full_metrics,
              "development_phases": phase_metrics(predicted, labels), "p95_ms": p95,
              "fitness": jaw_fitness(full_metrics["f1"], detector_speed_score(p95)),
              "prefix_checked_clips": 3}
    args.model.write_text(json.dumps(full_model, separators=(",", ":")) + "\n")
    args.candidate.write_text(json.dumps(candidate, indent=2) + "\n")
    args.report.write_text(json.dumps(report, separators=(",", ":")) + "\n")
    print(f"Pooled withheld: {withheld}\nFull development: {full_metrics}; p95 {p95:.3f} ms", flush=True)


if __name__ == "__main__":
    main()

"""Fit and evaluate temporal47 on a private development manifest."""

import argparse
from concurrent.futures import ThreadPoolExecutor
from dataclasses import asdict
from itertools import product
import json
from pathlib import Path
from time import perf_counter

import cv2
import numpy as np

from alternative_signals import motion_samples
from joint_fitness import detector_speed_score, jaw_fitness
from round_one import accuracy, events, load_frames, measure_events
from run_joint_round import JointCandidate
from temporal47 import features, fit


def load_inputs(manifest):
    clips = json.loads(manifest.read_text())["clips"]
    with ThreadPoolExecutor(max_workers=4) as workers:
        frames = list(workers.map(load_frames, [manifest.parent / clip["video"] for clip in clips]))
    sensors, labels = [], []
    for clip in clips:
        capture = json.loads((manifest.parent / clip["capture_manifest"]).read_text())
        with (manifest.parent / clip["imu"]).open() as file:
            sensors.append(motion_samples({"start": capture["timing"]["start"],
                                          "samples": [json.loads(line) for line in file]}))
        labels.append({"close": clip["jaw_reference"]["squeeze"]["button_cue_seconds"],
                       "open": clip["jaw_reference"]["release"]["button_cue_seconds"]})
    return frames, sensors, labels


def select_settings(measured, labels):
    base = {"name": "R47 causal video and IMU temporal state", "method": "temporal47",
            "deposit_method": "held_transfer_flow", "deposit_threshold": 0.1875}
    settings = product((0.45, 0.60, 0.75, 0.85), (1, 2), (1, 2, 3), (10, 16),
                       (0.70, 0.90), (2, 4))
    best_key, best = None, None
    for threshold, confirm, smoothing, cooldown, release_ratio, release_cooldown in settings:
        candidate = JointCandidate(**base, threshold=threshold, confirm=confirm,
                                   smoothing=smoothing, cooldown=cooldown,
                                   release_ratio=release_ratio, release_cooldown=release_cooldown,
                                   release_confirm=1)
        predicted = [events(candidate, samples, confirmation_time=True) for samples, _ in measured]
        metrics = accuracy(predicted, labels)
        key = (metrics["f1"], -metrics["false_positives"], metrics["clean_clips"],
               -(metrics["median_error_seconds"] or 0))
        if best_key is None or key > best_key:
            best_key, best = key, candidate
    return best


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("model", type=Path)
    parser.add_argument("candidate", type=Path)
    parser.add_argument("report", type=Path)
    parser.add_argument("--seed", type=int, default=47)
    parser.add_argument("--epochs", type=int, default=100)
    parser.add_argument("--single-frame", action="store_true")
    parser.add_argument("--video-only", action="store_true")
    args = parser.parse_args()

    cv2.setNumThreads(1)
    start = perf_counter()
    frames, sensors, labels = load_inputs(args.manifest)
    print(f"Loaded {len(frames)} clips and {sum(map(len, frames))} frames in {perf_counter()-start:.1f} s", flush=True)
    model = fit(frames, sensors, labels, seed=args.seed, epochs=args.epochs,
                temporal=not args.single_frame, use_imu=not args.video_only)
    args.model.write_text(json.dumps(model, separators=(",", ":")) + "\n")
    print(f"Fitted weights in {perf_counter()-start:.1f} s elapsed", flush=True)

    measured = [features(clip, motion, model) for clip, motion in zip(frames, sensors, strict=True)]
    reference = measured[0][0][:40]
    prefix, _ = features(frames[0][:40], sensors[0], model)
    timestamp = frames[0][39][0]
    truncated_sensors = {name: (times[:stop], values[:stop])
                         for name, (times, values) in sensors[0].items()
                         if (stop := int(np.searchsorted(times, timestamp, side="right"))) > 0}
    truncated, _ = features(frames[0][:40], truncated_sensors, model)
    if prefix != reference or truncated != reference:
        raise ValueError("Temporal features changed when future inputs were removed")

    candidate = select_settings(measured, labels)
    predicted, timings = measure_events(candidate, measured)
    p95 = float(np.percentile(np.concatenate(timings), 95))
    metrics = accuracy(predicted, labels)
    phases = {phase: accuracy([[(kind, timestamp) for kind, timestamp in events if kind == phase]
                               for events in predicted],
                              [{phase: label[phase]} for label in labels])
              for phase in ("close", "open")}
    proposal = asdict(candidate)
    proposal.pop("created_round")
    proposal.pop("parent")
    proposal["rationale"] = (
        "Fit a regularized causal state network with compact spatial video descriptors, IMU impulses, "
        "and fixed lags. Training uses only the designated development data. The online decoder uses "
        "neither elapsed clip time nor button cues. Temporal architecture inspiration: "
        "https://arxiv.org/abs/1803.01271."
    )
    report = {"development": metrics, "phases": phases, "p95_ms": p95,
              "fitness": jaw_fitness(metrics["f1"], detector_speed_score(p95)),
              "clip_count": len(frames), "elapsed_seconds": perf_counter() - start,
              "candidate": proposal, "reporting": "in_sample",
              "model_config": {"seed": args.seed, "epochs": args.epochs,
                               "temporal": not args.single_frame, "use_imu": not args.video_only},
              "prefix_check": "identical with future frames and sensor samples removed"}
    args.candidate.write_text(json.dumps(proposal, indent=2) + "\n")
    args.report.write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2), flush=True)


if __name__ == "__main__":
    main()

"""Replay frozen, separately fitted jaw candidates on withheld capture blocks."""

import argparse
from dataclasses import fields
import json
from pathlib import Path
from tempfile import NamedTemporaryFile

import cv2
import numpy as np

from round_one import POSE_METHODS, accuracy, features, measure_events, pose_samples
from run_joint_round import JointCandidate
from temporal47_train import load_inputs


def candidate_from_record(record):
    keys = {field.name for field in fields(JointCandidate)}
    return JointCandidate(**{key: value for key, value in record.items() if key in keys})


def metrics_by_event(predictions, labels):
    return {
        kind: accuracy(
            [[event for event in clip if event[0] == kind] for clip in predictions],
            [{kind: label[kind]} for label in labels],
        )
        for kind in ("close", "open")
    }


def replay_candidate(record, expected_folds, inputs, poses):
    candidate = candidate_from_record(record["candidate"])
    folds = {item["id"]: item for item in record["folds"]}
    if len(folds) != len(record["folds"]) or folds.keys() != expected_folds.keys():
        raise ValueError(f"{candidate.name} needs exactly one model for every capture block")
    predictions, targets, timings, reports = [], [], [], []
    clip_results = {}
    for block, test_ids in expected_folds.items():
        fold = folds[block]
        train_ids = set(inputs) - set(test_ids)
        if (len(fold["test_clips"]) != len(test_ids) or set(fold["test_clips"]) != set(test_ids)
                or len(fold["train_clips"]) != len(train_ids) or set(fold["train_clips"]) != train_ids):
            raise ValueError(f"Incorrect training or test membership for {candidate.name}, {block}")
        decoder = candidate_from_record(fold["candidate"])
        if decoder.method != candidate.method:
            raise ValueError(f"Unexpected detector method in {candidate.name}, {block}")
        measured, labels = [], []
        for clip_id in test_ids:
            frames, motion, label = inputs[clip_id]
            if decoder.method in POSE_METHODS:
                motion = {"imu": motion, "poses": poses[clip_id]}
            measured.append(features(decoder.method, frames, decoder.signal, motion,
                                     {decoder.method: fold["model"]}))
            labels.append(label)
        detected, durations = measure_events(decoder, measured)
        for clip_id, prediction, label in zip(test_ids, detected, labels, strict=True):
            by_event = metrics_by_event([prediction], [label])
            clip_results[clip_id] = {kind: {
                key: outcome[key] for key in ("matched", "false_positives", "median_error_seconds")
            } for kind, outcome in by_event.items()}
        reports.append({"id": block, "test_clips": test_ids, "train_clip_count": len(train_ids),
                        "jaw": accuracy(detected, labels), "jaw_by_event": metrics_by_event(detected, labels)})
        predictions.extend(detected)
        targets.extend(labels)
        timings.extend(durations)
    return {"candidate": record["candidate"], "jaw": accuracy(predictions, targets),
            "jaw_by_event": metrics_by_event(predictions, targets),
            "p95_ms": float(np.percentile(np.concatenate(timings), 95)), "folds": reports,
            "clips": clip_results,
            "reporting": "retrospective_block_withheld"}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("folds", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("candidates", type=Path, nargs="+")
    args = parser.parse_args()
    expected_folds = json.loads(args.folds.read_text())
    clips = json.loads(args.manifest.read_text())["clips"]
    clip_ids = [clip["clip"] for clip in clips]
    held_out = [clip_id for block in expected_folds.values() for clip_id in block]
    if not expected_folds or any(not block for block in expected_folds.values()) or sorted(held_out) != sorted(clip_ids):
        parser.error("Capture blocks must cover every manifest clip exactly once")
    cv2.setNumThreads(1)
    inputs = dict(zip(clip_ids, zip(*load_inputs(args.manifest), strict=True), strict=True))
    records = [json.loads(path.read_text()) for path in args.candidates]
    poses = {}
    if any(item["candidate"]["method"] in POSE_METHODS for item in records):
        base = args.manifest.parent
        for row in clips:
            capture = json.loads((base / row["capture_manifest"]).read_text())
            poses[row["clip"]] = pose_samples(base / row["poses"] if "poses" in row else None,
                                              capture["timing"]["start"])
    reports = []
    for record in records:
        result = replay_candidate(record, expected_folds, inputs, poses)
        print(f"{result['candidate']['name']}: withheld jaw F1 {result['jaw']['f1']:.4f}", flush=True)
        reports.append(result)
    with NamedTemporaryFile(mode="w", dir=args.output.parent, prefix=".withheld-", delete=False) as pending:
        json.dump(reports, pending, indent=2)
        pending.write("\n")
    Path(pending.name).replace(args.output)


if __name__ == "__main__":
    main()

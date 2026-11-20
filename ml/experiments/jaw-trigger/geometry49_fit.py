"""Fit and validate landmark tracking with disjoint capture blocks."""

import argparse
from concurrent.futures import ThreadPoolExecutor
from dataclasses import asdict, replace
from functools import lru_cache
import json
from pathlib import Path

import cv2
import numpy as np

from geometry47 import CALIBRATION_FRAMES, _registration, _shaft_patch
from geometry47_fit import fit
from geometry48_fit import calibrate
from geometry49 import (
    PATCH_WIDTH, SCALE, WINDOWS, _channels, _search_view, descriptors,
)
from round_one import accuracy, events, load_frames


READOUTS = ((0.8, 0.008, -0.12), (1.5, 0.02, -0.18), (1.5, 0.04, 0.0))
NAME = "R49 tracked claw-tip separation and direction"


def _training_frame(channels, landmark, point):
    bounds = WINDOWS[landmark]
    x0, x1, y0, y1 = bounds
    view = _search_view(channels, bounds)
    patches = np.lib.stride_tricks.sliding_window_view(view, (PATCH_WIDTH, PATCH_WIDTH), axis=(1, 2))
    rows, cols = np.mgrid[y0:y1, x0:x1]
    distance = (cols - point[0]) ** 2 + (rows - point[1]) ** 2
    # Include every location near the label and a spatially stratified sample
    # of nonmatches. Every annotated image contributes the same total weight.
    near = distance <= 6.25
    far = (distance >= 16) & ((rows + 2 * cols) % 4 == 0)
    selected = near | far
    if not near.any() or not far.any():
        raise ValueError(f"Annotated {landmark} outside its training window: {point}")
    values = patches[:, selected].transpose(1, 0, 2, 3).reshape(int(selected.sum()), len(channels), -1).copy()
    values -= values.mean(axis=2, keepdims=True)
    values /= np.maximum(np.linalg.norm(values, axis=2, keepdims=True), 1e-6)
    target = np.exp(-distance[selected] / 2.9).astype(np.float32)
    weights = np.where(near[selected], 0.5 / near.sum(), 0.5 / far.sum()).astype(np.float32)
    return values.reshape(len(values), -1), target, weights


def annotation_rows(frames, annotations):
    shaft = np.rint(np.median([_shaft_patch(frame) for _, frame in frames[:CALIBRATION_FRAMES]], axis=0))
    shaft = shaft.astype(np.uint8)
    rows = {name: [] for name in WINDOWS}
    for annotation in annotations:
        index = annotation["frame"]
        _, frame = frames[index]
        for name in rows:
            label = annotation.get(name)
            if label is None:
                continue
            examples = [(index, label)]
            point = np.asarray(label, dtype=np.float32).reshape(1, 1, 2)
            for neighbor in (index - 2, index + 2):
                if not 0 <= neighbor < len(frames):
                    continue
                target = frames[neighbor][1]
                moved, status, _ = cv2.calcOpticalFlowPyrLK(frame, target, point, None, winSize=(15, 15), maxLevel=1)
                if moved is None or not status[0, 0]:
                    continue
                back, status, _ = cv2.calcOpticalFlowPyrLK(target, frame, moved, None, winSize=(15, 15), maxLevel=1)
                if back is not None and status[0, 0] and np.linalg.norm(back - point) < 1.4:
                    if np.linalg.norm(moved - point) < 6:
                        examples.append((neighbor, moved[0, 0]))
            for example, label in examples:
                _, pixels = frames[example]
                offset = _registration(pixels, shaft if example >= CALIBRATION_FRAMES - 1 else None)
                channels = _channels(pixels, offset)
                point = (label[0] - offset[0]) / SCALE, (label[1] - offset[1]) / SCALE
                rows[name].append(_training_frame(channels, name, point))
    return rows


def fit_landmarks(samples, indices):
    model = {}
    for name in WINDOWS:
        examples = [row for index in indices for row in samples[index][name]]
        values, targets, weights = [np.concatenate(part) for part in zip(*examples, strict=True)]
        weighted = values * weights[:, None]
        regularizer = np.eye(values.shape[1], dtype=np.float32) * weights.sum() * 0.004
        model[name] = np.linalg.solve(values.T @ weighted + regularizer, weighted.T @ targets).tolist()
    return model


def fit_readout(data, labels, config, indices):
    absolute_scale, ridge, label_offset = config
    return fit((data[i] for i in indices), (labels[i] for i in indices),
               absolute_scale=absolute_scale, ridge=ridge, label_offset=label_offset)


def predict(data, readout):
    times, absolute, relative = data
    weights = np.asarray(readout["weights"], dtype=np.float32)
    values = absolute @ weights[0] + relative @ weights[1] + readout["intercept"]
    values[:CALIBRATION_FRAMES] = 0
    return times, values


def measurement(data, labels, indices, readout, candidate):
    predictions = [events(candidate, list(zip(*predict(data[index], readout), strict=True)),
                          confirmation_time=True) for index in indices]
    expected = [dict(close=labels[index][0], open=labels[index][1]) for index in indices]
    phases = {}
    for phase in ("close", "open"):
        phase_predictions = [[event for event in episode if event[0] == phase] for episode in predictions]
        phases[phase] = accuracy(phase_predictions, [{phase: row[phase]} for row in expected])
    return accuracy(predictions, expected), phases


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("annotations", type=Path, help="Private prepared-frame landmark coordinates by clip ID")
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    rows = json.loads(args.manifest.read_text())["clips"]
    annotations = json.loads(args.annotations.read_text())
    labels = [(row["jaw_reference"]["squeeze"]["button_cue_seconds"],
               row["jaw_reference"]["release"]["button_cue_seconds"]) for row in rows]
    early = [index for index, row in enumerate(rows) if row["previous_fit"]]
    later = [index for index, row in enumerate(rows) if not row["previous_fit"]]
    blocks = [tuple(early), *(tuple(map(int, part)) for part in np.array_split(later, 4))]
    names = ["earlier_capture_batch", *(f"contiguous_later_block_{i}" for i in range(1, 5))]
    cv2.setNumThreads(1)
    with ThreadPoolExecutor(max_workers=4) as workers:
        frames = list(workers.map(lambda row: load_frames(args.manifest.parent / row["video"]), rows))
    samples = [annotation_rows(clip, annotations.get(row["clip"], []))
               for clip, row in zip(frames, rows, strict=True)]
    print("loaded clips and prepared annotations", flush=True)

    @lru_cache(maxsize=None)
    def fit_partition(train):
        landmarks = fit_landmarks(samples, train)
        data = []
        for clip in frames:
            times, points, _ = zip(*descriptors(clip, landmarks), strict=True)
            absolute = np.asarray(points)
            data.append((np.asarray(times), absolute, absolute - np.median(absolute[:CALIBRATION_FRAMES], axis=0)))
        return landmarks, data

    def select(groups, test):
        best = None
        for config in READOUTS:
            predictions, expected = [], []
            for index, validation in enumerate(groups):
                train = tuple(sorted(clip for i, block in enumerate(groups) if i != index for clip in block))
                _, data = fit_partition(train)
                readout = fit_readout(data, labels, config, train)
                predictions.extend(predict(data[clip], readout) for clip in validation)
                expected.extend(labels[clip] for clip in validation)
            key, candidate = calibrate(predictions, expected)
            if best is None or key > best[0]:
                best = key, candidate, config

        key, candidate, config = best
        train = tuple(sorted(clip for block in groups for clip in block))
        landmarks, data = fit_partition(train)
        readout = fit_readout(data, labels, config, train)
        candidate = replace(candidate, name=NAME, method="geometry49")
        metrics, phases = measurement(data, labels, test, readout, candidate)
        return {"candidate": asdict(candidate), "model": {"landmarks": landmarks, "readout": readout},
                "training_oof_f1": key[0], "readout_config": config,
                "metrics": metrics, "phases": phases}

    full = select(blocks, list(range(len(rows))))
    print("fitted", full["metrics"], full["readout_config"], full["training_oof_f1"], flush=True)
    folds = []
    for index, (name, test) in enumerate(zip(names, blocks, strict=True)):
        groups = [block for i, block in enumerate(blocks) if i != index]
        fold = select(groups, test)
        fold.update(id=name, train_clips=[rows[clip]["clip"] for block in groups for clip in block],
                    test_clips=[rows[clip]["clip"] for clip in test])
        folds.append(fold)
        print(name, fold["metrics"], fold["readout_config"], fold["training_oof_f1"], flush=True)
    args.output.write_text(json.dumps(full | {"folds": folds}) + "\n")


if __name__ == "__main__":
    main()

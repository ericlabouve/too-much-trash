"""Fit compact jaw geometry with training-only blocked decoder calibration."""

import argparse
from concurrent.futures import ThreadPoolExecutor
from itertools import product
import json
from pathlib import Path

import cv2
import numpy as np

from geometry47_fit import fit
from geometry48 import CALIBRATION_FRAMES, _descriptors
from round_one import MATCH_SECONDS, accuracy, events, load_frames
from run_joint_round import JointCandidate


# A small, predetermined menu. Each outer fold chooses both its readout and
# decoder on out-of-fold predictions inside the four training blocks only.
READOUTS = (
    ("profiles", 1.0, 0.025, -0.12),
    ("profiles", 3.0, 0.012, -0.18),
    ("profiles", 3.0, 0.045, -0.18),
    ("profiles", 3.0, 0.025, 0.0),
    ("fine_profiles", 3.0, 0.003, -0.18),
    ("fine_profiles", 3.0, 0.012, -0.18),
    ("fine_profiles", 3.0, 0.045, -0.18),
    ("fine_profiles", 1.0, 0.012, -0.10),
    ("spans", 1.0, 0.002, -0.12),
    ("spans", 3.0, 0.008, -0.18),
    ("deformation", 1.0, 0.008, -0.12),
    ("deformation", 1.0, 0.025, -0.18),
    ("deformation", 1.0, 0.008, 0.0),
)
DESCRIPTORS = tuple(dict.fromkeys(config[0] for config in READOUTS))
SETTINGS = np.array(list(product(
    (0.43, 0.49, 0.54, 0.58, 0.63, 0.68), (0.68, 0.79, 0.90, 0.98),
    (1, 2, 3), (10, 16, 22), (2, 5), (1, 2),
)))


def _prepared(times, vectors):
    return times, vectors, vectors - np.median(vectors[:CALIBRATION_FRAMES], axis=0)


def load_clip(manifest, row, cache):
    if cache:
        file = cache / f"{row['clip']}.npz"
        with np.load(file) as data:
            return {kind: _prepared(data[f"{kind}_t"], data[kind])
                    for kind in DESCRIPTORS}

    frames = load_frames(manifest.parent / row["video"])
    result = {}
    for kind in DESCRIPTORS:
        times, vectors, _ = zip(*_descriptors(frames, kind), strict=True)
        result[kind] = _prepared(np.asarray(times), np.asarray(vectors))
    return result


def fit_readout(data, labels, config, indices):
    kind, absolute_scale, ridge, label_offset = config
    model = fit((data[index][kind] for index in indices), (labels[index] for index in indices),
                absolute_scale=absolute_scale, label_offset=label_offset, ridge=ridge)
    return {"descriptor": kind, **model}


def predict(data, model):
    times, absolute, relative = data[model["descriptor"]]
    weights = np.asarray(model["weights"], dtype=np.float32)
    scores = absolute @ weights[0] + relative @ weights[1] + model["intercept"]
    scores[:CALIBRATION_FRAMES] = 0
    return times, scores


def calibrate(predictions, labels):
    """Replay the finite-state decoder across a fixed grid without revealing test results."""
    threshold, ratio, close_confirm, cooldown, release_cooldown, release_confirm = SETTINGS.T
    release_threshold = threshold * ratio
    labels = np.asarray(labels)
    nclips = len(predictions)
    length = max(len(times) - CALIBRATION_FRAMES for times, _ in predictions)
    times = np.full((nclips, length), np.inf)
    cumulative = np.zeros((nclips, length + 1))
    for index, (timestamps, scores) in enumerate(predictions):
        n = len(timestamps) - CALIBRATION_FRAMES
        times[index, :n] = timestamps[CALIBRATION_FRAMES:]
        cumulative[index, 1:n + 1] = scores[CALIBRATION_FRAMES:].cumsum(dtype=np.float64)
    close_window = abs(times - labels[:, :1]) <= MATCH_SECONDS
    release_window = abs(times - labels[:, 1:]) <= MATCH_SECONDS
    shape = nclips, len(SETTINGS)
    best = None
    for smoothing in (2, 4, 6):
        closed = np.zeros(shape, dtype=bool)
        close_found = np.zeros(shape, dtype=bool)
        release_found = np.zeros(shape, dtype=bool)
        last = np.broadcast_to(-cooldown, shape).copy()
        streak = np.zeros(shape, dtype=np.int16)
        false = np.zeros(shape, dtype=np.int16)
        for index in range(length):
            first = max(0, index + 1 - smoothing)
            value = (cumulative[:, index + 1] - cumulative[:, first])[:, None] / (index + 1 - first)
            active = np.isfinite(times[:, index, None]) & (
                index - last >= np.where(closed, release_cooldown, cooldown)
            )
            crossed = np.where(closed, value < release_threshold, value > threshold)
            streak = np.where(active, np.where(crossed, streak + 1, 0), streak)
            fired = active & crossed & (streak == np.where(closed, release_confirm, close_confirm))
            close_match = fired & ~closed & ~close_found & close_window[:, index, None]
            release_match = fired & closed & ~release_found & release_window[:, index, None]
            close_found |= close_match
            release_found |= release_match
            false += fired & ~close_match & ~release_match
            closed ^= fired
            last = np.where(fired, index, last)
            streak = np.where(fired, 0, streak)
        matches = close_found.sum(axis=0) + release_found.sum(axis=0)
        errors = false.sum(axis=0)
        scores = 2 * matches / (2 * nclips + matches + errors)
        order = np.lexsort((np.arange(len(SETTINGS)), -matches, errors, -scores))
        top = int(order[0])
        key = (float(scores[top]), -int(errors[top]), int(matches[top]))
        if best is None or key > best[0]:
            best = key, smoothing, SETTINGS[top]
    key, smoothing, settings = best
    threshold, ratio, close_confirm, cooldown, release_cooldown, release_confirm = settings
    candidate = JointCandidate(
        "R48 compact shaft-relative jaw geometry", "geometry48", float(threshold),
        confirm=int(close_confirm), smoothing=smoothing, cooldown=int(cooldown),
        release_ratio=float(ratio), release_cooldown=int(release_cooldown), release_confirm=int(release_confirm),
        deposit_method="held_transfer_flow", deposit_threshold=0.1875,
    )
    return key, candidate


def select(data, labels, blocks):
    best = None
    for config in READOUTS:
        predictions, expected = [], []
        for index, validation in enumerate(blocks):
            train = [clip for i, block in enumerate(blocks) if i != index for clip in block]
            model = fit_readout(data, labels, config, train)
            predictions.extend(predict(data[clip], model) for clip in validation)
            expected.extend(labels[clip] for clip in validation)
        key, candidate = calibrate(predictions, expected)
        if best is None or key > best[0]:
            best = key, candidate, config
    key, candidate, config = best
    train = [clip for block in blocks for clip in block]
    return key, candidate, config, fit_readout(data, labels, config, train)


def measure(data, labels, indices, model, candidate):
    predictions = [events(candidate, list(zip(*predict(data[clip], model), strict=True)),
                          confirmation_time=True) for clip in indices]
    expected = [dict(close=labels[clip][0], open=labels[clip][1]) for clip in indices]
    phases = {}
    for phase in ("close", "open"):
        phase_predictions = [[event for event in episode if event[0] == phase] for episode in predictions]
        phases[phase] = accuracy(phase_predictions, [{phase: ref[phase]} for ref in expected])
    return accuracy(predictions, expected), phases


def main():
    from dataclasses import asdict

    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--descriptor-cache", type=Path, help="Optional private cache of prepared descriptors")
    args = parser.parse_args()
    rows = json.loads(args.manifest.read_text())["clips"]
    labels = [(row["jaw_reference"]["squeeze"]["button_cue_seconds"],
               row["jaw_reference"]["release"]["button_cue_seconds"]) for row in rows]
    earlier = [i for i, row in enumerate(rows) if row["previous_fit"]]
    later = [i for i, row in enumerate(rows) if not row["previous_fit"]]
    blocks = [earlier, *[part.tolist() for part in np.array_split(later, 4)]]
    names = ["earlier_capture_batch", *(f"contiguous_later_block_{i}" for i in range(1, 5))]
    cv2.setNumThreads(1)
    with ThreadPoolExecutor(max_workers=4) as executor:
        data = list(executor.map(lambda row: load_clip(args.manifest, row, args.descriptor_cache), rows))

    def summarize(blocks, indices):
        key, candidate, config, model = select(data, labels, blocks)
        metrics, phases = measure(data, labels, indices, model, candidate)
        return {"candidate": asdict(candidate), "model": model, "readout": config,
                "training_oof_f1": key[0], "metrics": metrics, "phases": phases}

    full = summarize(blocks, list(range(len(rows))))
    print("all clips", full["readout"], full["training_oof_f1"], full["metrics"], flush=True)
    folds = []
    for index, (name, test) in enumerate(zip(names, blocks, strict=True)):
        training = [block for i, block in enumerate(blocks) if i != index]
        fold = summarize(training, test)
        fold.update(id=name, train_clips=[rows[clip]["clip"] for block in training for clip in block],
                    test_clips=[rows[clip]["clip"] for clip in test])
        folds.append(fold)
        print(name, fold["readout"], fold["training_oof_f1"], fold["metrics"], flush=True)
    args.output.write_text(json.dumps(full | {"folds": folds}) + "\n")


if __name__ == "__main__":
    main()

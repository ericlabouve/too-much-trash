"""Fit the Round 47 scanline classifier from a private development manifest."""

import argparse
from concurrent.futures import ThreadPoolExecutor
import json
from pathlib import Path

import cv2
import numpy as np

from geometry47 import CALIBRATION_FRAMES, descriptors
from round_one import load_frames


def prepare(frames):
    times, vectors, _ = zip(*descriptors(frames), strict=True)
    values = np.asarray(vectors)
    return np.asarray(times), values, values - np.median(values[:CALIBRATION_FRAMES], axis=0)


def fit(prepared, labels, *, absolute_scale=3.0, label_offset=-0.10, ridge=0.003):
    rows, targets, weights = [], [], []
    for (times, absolute, relative), (close, release) in zip(prepared, labels, strict=True):
        margin = min(0.24, (release - close) * 0.29)
        close += label_offset
        release += label_offset
        held = (times >= close + margin) & (times <= release - margin)
        opened = ((times > 0.12) & (times < close - margin)) | (times > release + margin)
        if not held.any() or not opened.any():
            continue
        stable = held | opened
        rows.append(np.concatenate((absolute[stable] * absolute_scale, relative[stable]), axis=1))
        targets.append(held[stable])
        # Give every usable recording and each jaw state equal weight.
        weights.append(np.where(held[stable], 0.5 / held.sum(), 0.5 / opened.sum()))
    if not rows:
        raise ValueError("Fitting requires development examples of both jaw states")

    matrix = np.concatenate(rows)
    target = np.concatenate(targets).astype(np.float32)
    weight = np.concatenate(weights).astype(np.float32)
    design = np.column_stack((matrix, np.ones(len(matrix), dtype=np.float32)))
    weighted = design * weight[:, None]
    penalty = np.eye(design.shape[1], dtype=np.float32) * ridge * weight.sum()
    penalty[-1, -1] = 0
    coefficients = np.linalg.solve(design.T @ weighted + penalty, weighted.T @ target)
    features = matrix.shape[1] // 2
    return {
        "weights": [list(map(float, coefficients[:features] * absolute_scale)),
                    list(map(float, coefficients[features:-1]))],
        "intercept": float(coefficients[-1]),
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    clips = json.loads(args.manifest.read_text())["clips"]
    labels = [(row["jaw_reference"]["squeeze"]["button_cue_seconds"],
               row["jaw_reference"]["release"]["button_cue_seconds"]) for row in clips]
    cv2.setNumThreads(1)
    with ThreadPoolExecutor(max_workers=4) as executor:
        data = list(executor.map(lambda row: prepare(load_frames(args.manifest.parent / row["video"])), clips))
    args.output.write_text(json.dumps(fit(data, labels)) + "\n")


if __name__ == "__main__":
    main()

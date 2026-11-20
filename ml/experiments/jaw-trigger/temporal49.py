"""Causal visual jaw state and directed boundaries with a forward state filter."""

from collections import deque
import math
from time import perf_counter_ns

import numpy as np

from geometry47 import CALIBRATION_FRAMES, descriptors
from temporal48 import _motion_signal


def _rows(frames, samples):
    samples = {stream: (np.asarray(times), vectors) for stream, (times, vectors) in samples.items()}
    reference = []
    history = deque(maxlen=6)
    previous_time = -np.inf
    baseline = None
    for timestamp, descriptor, started in descriptors(frames):
        # Reduce the jaw-plane scan to interior bands. This excludes the two
        # outer columns, where unrelated background texture is strongest.
        shape = descriptor.reshape(5, 24, 6)[:, :, 1:5]
        shape = shape.reshape(5, 12, 2, 2, 2).mean(axis=(2, 4)).ravel()
        if len(reference) < CALIBRATION_FRAMES:
            reference.append(shape)
            baseline = np.median(reference, axis=0)
        history.appendleft(shape)
        motion = _motion_signal(samples, previous_time, timestamp)
        previous_time = timestamp
        state_row = np.concatenate((2.0 * shape, 0.8 * (shape - baseline), 0.2 * motion))
        boundary_row = np.concatenate((0.55 * shape, 0.20 * (shape - baseline),
                                       1.2 * (shape - history[min(2, len(history) - 1)]),
                                       0.7 * (shape - history[-1]), 0.6 * motion))
        yield timestamp, state_row, boundary_row, started


def prepare(frames, samples):
    times, state, boundary, _ = zip(*_rows(frames, samples), strict=True)
    return np.asarray(times), np.asarray(state), np.asarray(boundary)


def _weighted_ridge(rows, target, weight, ridge):
    design = np.column_stack((rows, np.ones(len(rows), dtype=np.float32)))
    weighted = design * weight[:, None]
    penalty = np.eye(design.shape[1], dtype=np.float32) * ridge * weight.sum()
    penalty[-1, -1] = 0
    return np.linalg.solve(design.T @ weighted + penalty, weighted.T @ target)


def fit(prepared, labels):
    """Fit state and separately directed boundary scores on training clips."""
    state_rows, state_targets, state_weights = [], [], []
    edge_rows, edge_targets, edge_weights = [], [], []
    for (timestamps, state, boundary), label in zip(prepared, labels, strict=True):
        times = timestamps[CALIBRATION_FRAMES:]
        close, release = label["close"], label["open"]
        margin = min(0.10, (release - close) / 5)
        held = (times >= close + margin) & (times <= release - margin)
        opened = (times <= close - margin) | (times >= release + margin)
        if held.any() and opened.any():
            stable = held | opened
            state_rows.append(state[CALIBRATION_FRAMES:][stable])
            state_targets.append(held[stable])
            state_weights.append(np.where(held[stable], 0.5 / held.sum(), 0.5 / opened.sum()))

        edge_margin = min(0.16, (release - close) / 3)
        close_edge = (times >= close - 0.065) & (times <= close + edge_margin)
        release_edge = (times >= release - 0.065) & (times <= release + edge_margin)
        neutral = ~(close_edge | release_edge)
        weights = (0.60 * neutral / max(1, neutral.sum())
                   + 0.20 * close_edge / max(1, close_edge.sum())
                   + 0.20 * release_edge / max(1, release_edge.sum()))
        edge_rows.append(boundary[CALIBRATION_FRAMES:])
        edge_targets.append(np.column_stack((close_edge, release_edge)))
        edge_weights.append(weights)

    if not state_rows:
        raise ValueError("Fitting requires recordings of both jaw states")
    state = _weighted_ridge(np.concatenate(state_rows), np.concatenate(state_targets).astype(np.float32),
                            np.concatenate(state_weights).astype(np.float32), 0.013)
    edge = _weighted_ridge(np.concatenate(edge_rows), np.concatenate(edge_targets).astype(np.float32),
                           np.concatenate(edge_weights).astype(np.float32), 0.030)
    return {"state_weights": state[:-1].tolist(), "state_intercept": float(state[-1]),
            "boundary_weights": edge[:-1].tolist(), "boundary_intercept": edge[-1].tolist()}


def _advance(prior, state_score, close_edge, release_edge):
    close_hazard = 0.018 + 0.64 * min(0.70, max(0.0, close_edge - 0.33))
    release_hazard = 0.022 + 0.69 * min(0.70, max(0.0, release_edge - 0.33))
    transitioned = prior * (1.0 - release_hazard) + (1.0 - prior) * close_hazard
    evidence_ratio = math.exp(max(-3.0, min(3.0, (state_score - 0.5) * 5.5)))
    return transitioned * evidence_ratio / (1.0 - transitioned + transitioned * evidence_ratio)


def _parameters(model):
    return (np.asarray(model["state_weights"], dtype=np.float32), model["state_intercept"],
            np.asarray(model["boundary_weights"], dtype=np.float32),
            np.asarray(model["boundary_intercept"], dtype=np.float32))


def score_prepared(prepared, model):
    times, state_rows, boundary_rows = prepared
    state_weights, state_bias, boundary_weights, boundary_bias = _parameters(model)
    state = state_rows @ state_weights + state_bias
    boundary = boundary_rows @ boundary_weights + boundary_bias
    prior = 0.025
    values = []
    for index, (timestamp, estimate, (close, release)) in enumerate(zip(times, state, boundary, strict=True)):
        if index >= CALIBRATION_FRAMES:
            prior = _advance(prior, estimate, close, release)
        values.append((timestamp, prior))
    return values


def features(frames, samples, parameters):
    """Return the filtered closed-state score and latency for each frame."""
    state_weights, state_bias, boundary_weights, boundary_bias = _parameters(parameters)
    prior = 0.025
    values, durations = [], []
    for index, (timestamp, state, boundary, started) in enumerate(_rows(frames, samples)):
        if index >= CALIBRATION_FRAMES:
            estimate = float(state @ state_weights + state_bias)
            close, release = boundary @ boundary_weights + boundary_bias
            prior = _advance(prior, estimate, close, release)
        values.append((timestamp, prior))
        durations.append((perf_counter_ns() - started) / 1_000_000)
    return values, durations

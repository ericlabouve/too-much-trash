"""Regularized causal scanline and motion state detector."""

from time import perf_counter_ns

import numpy as np

from geometry47 import CALIBRATION_FRAMES, descriptors


LABEL_LEAD_SECONDS = 1 / 15


def _motion_signal(samples, previous_time, timestamp):
    values = []
    for stream in ("accelerometer", "gyroscope"):
        signal = samples.get(stream)
        if signal is None:
            values.extend((0.0, 0.0, 0.0))
            continue
        times, vectors = signal
        start, stop = np.searchsorted(times, (previous_time, timestamp), side="right")
        history = vectors[max(0, start - 1):stop]
        if stop == 0 or timestamp - times[stop - 1] > 0.2 or not len(history):
            values.extend((0.0, 0.0, 0.0))
            continue
        magnitude = np.linalg.norm(history, axis=1)
        change = np.linalg.norm(np.diff(history, axis=0), axis=1)
        values.extend(np.log1p((magnitude.mean(), magnitude.max(), change.max(initial=0))))
    return np.asarray(values, dtype=np.float32)


def _rows(frames, samples):
    samples = {stream: (np.asarray(times), vectors) for stream, (times, vectors) in samples.items()}
    reference = []
    previous_time = -np.inf
    slow = fast = baseline = None
    for timestamp, descriptor, started in descriptors(frames):
        # Pool adjacent scan rows to suppress texture and localization noise.
        shape = descriptor.reshape(5, 12, 2, 6).mean(axis=2).ravel()
        if fast is None:
            fast = slow = shape
        else:
            fast = 0.7 * shape + 0.3 * fast
            slow = 0.22 * shape + 0.78 * slow
        if len(reference) < CALIBRATION_FRAMES:
            reference.append(shape)
            baseline = np.median(reference, axis=0)
        motion = _motion_signal(samples, previous_time, timestamp)
        previous_time = timestamp
        # Fixed group scales shrink scene-dependent residuals and sensor magnitudes.
        row = np.concatenate((2.0 * fast, 0.7 * (fast - baseline),
                              0.6 * (fast - slow), 0.25 * motion))
        yield timestamp, row, started


def prepare(frames, samples):
    times, rows, _ = zip(*_rows(frames, samples), strict=True)
    return np.asarray(times), np.asarray(rows)


def fit(prepared, labels, *, ridge=0.018, consistency=0.25):
    """Fit clip-balanced ridge with a same-state score-consistency penalty."""
    training, targets, weights, differences, transition_weights = [], [], [], [], []
    for (times, rows), label in zip(prepared, labels, strict=True):
        times = times[CALIBRATION_FRAMES:]
        rows = rows[CALIBRATION_FRAMES:]
        close, opened = label["close"] - LABEL_LEAD_SECONDS, label["open"] - LABEL_LEAD_SECONDS
        margin = min(0.10, (opened - close) / 5)
        held = (times >= close + margin) & (times <= opened - margin)
        released = (times <= close - margin) | (times >= opened + margin)
        if not held.any() or not released.any():
            continue
        stable = held | released
        training.append(rows[stable])
        targets.append(held[stable])
        weights.append(np.where(held[stable], 0.5 / held.sum(), 0.5 / released.sum()))

        same_state = (held[1:] & held[:-1]) | (released[1:] & released[:-1])
        if same_state.any():
            differences.append(np.diff(rows, axis=0)[same_state])
            transition_weights.append(np.full(same_state.sum(), consistency / same_state.sum()))

    if not training:
        raise ValueError("Fitting requires recordings of both jaw states")
    matrix = np.concatenate(training)
    target = np.concatenate(targets).astype(np.float32)
    weight = np.concatenate(weights).astype(np.float32)
    design = np.column_stack((matrix, np.ones(len(matrix), dtype=np.float32)))
    weighted = design * weight[:, None]
    penalty = np.eye(design.shape[1], dtype=np.float32) * ridge * weight.sum()
    penalty[-1, -1] = 0
    if differences:
        delta = np.concatenate(differences)
        stable_weight = np.concatenate(transition_weights).astype(np.float32)
        penalty[:-1, :-1] += delta.T @ (delta * stable_weight[:, None])
    coefficients = np.linalg.solve(design.T @ weighted + penalty, weighted.T @ target)
    return {"weights": coefficients[:-1].tolist(), "intercept": float(coefficients[-1])}


def features(frames, samples, parameters):
    """Return timestamped scores and measured per-frame latency."""
    weights = np.asarray(parameters["weights"], dtype=np.float32)
    intercept = parameters["intercept"]
    values, durations = [], []
    for timestamp, row, started in _rows(frames, samples):
        values.append((timestamp, float(row @ weights + intercept)))
        durations.append((perf_counter_ns() - started) / 1_000_000)
    return values, durations

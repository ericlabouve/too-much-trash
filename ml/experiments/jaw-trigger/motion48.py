"""Causal low-dimensional inertial and optical squeeze/release classifier."""

from collections import deque
from time import perf_counter_ns

import cv2
import numpy as np

from alternative_signals import jaw_descriptor


WINDOWS = (0.085, 0.21, 0.49)
STREAMS = ("accelerometer", "gyroscope")
VISUAL_SIZE = 28
REFERENCE_FRAMES = 8


def sensor_row(times, vectors, timestamp, ends):
    stop = int(ends[0])
    result = []
    for start in ends[1:]:
        if stop == 0 or timestamp - times[stop - 1] > 0.12:
            result.extend((0.0,) * 17)
            continue
        begin = min(int(start), stop - 1)
        window = vectors[begin:stop]
        center = window.mean(axis=0)
        diffs = np.diff(vectors[max(0, begin - 1):stop], axis=0)
        magnitudes = (diffs * diffs).sum(axis=1)
        peak_delta = diffs[np.argmax(magnitudes)] if len(diffs) else np.zeros(3)
        result.extend(window[-1] - center)
        result.extend(center)
        result.extend(window[-1] - window[0])
        result.extend(window.std(axis=0))
        result.extend(peak_delta)
        result.append(float(np.sqrt(magnitudes.max(initial=0))))
        result.append(float(np.linalg.norm(center)))
    return result


def optical_descriptor(frame):
    crop = frame[105:207, 148:207]
    small = cv2.resize(crop, (12, 16), interpolation=cv2.INTER_AREA).astype(np.float32)
    return jaw_descriptor(frame).reshape(4, 8), small


def optical_change(current, earlier):
    histograms, patch = current
    old_histograms, old_patch = earlier
    delta = patch - old_patch
    delta -= np.median(delta)
    return np.concatenate((np.linalg.norm(histograms - old_histograms, axis=1),
                           (np.abs(delta[:8, :6]).mean(), np.abs(delta[:8, 6:]).mean(),
                            np.abs(delta[8:, :6]).mean(), np.abs(delta[8:, 6:]).mean())))


def feature_rows(frames, samples, use_visual):
    streams = {key: (np.asarray(times), np.asarray(vectors))
               for key, (times, vectors) in samples.items() if key in STREAMS}
    initial = []
    history = deque(maxlen=4)
    reference = None
    for timestamp, frame in frames:
        started = perf_counter_ns()
        sensor_values = []
        offsets = np.array((0.0, *WINDOWS))
        for key in STREAMS:
            if key in streams:
                times, vectors = streams[key]
                ends = np.searchsorted(times, timestamp - offsets, side="right")
                sensor_values.extend(sensor_row(times, vectors, timestamp, ends))
            else:
                sensor_values.extend((0.0,) * (17 * len(WINDOWS)))
        if use_visual:
            observed = optical_descriptor(frame)
            if len(initial) < REFERENCE_FRAMES:
                initial.append(observed)
                reference = tuple(np.median(np.stack(part), axis=0) for part in zip(*initial, strict=True))
            history.appendleft(observed)
            optical = [optical_change(observed, earlier) for earlier in
                       (reference, history[min(1, len(history) - 1)], history[-1])]
            _, patch = observed
            patch_contrast = [part.std() for part in (patch[:8, :6], patch[:8, 6:], patch[8:, :6], patch[8:, 6:])]
            row = np.concatenate((sensor_values, *optical, patch_contrast)).astype(np.float32)
        else:
            row = np.asarray(sensor_values, dtype=np.float32)
        yield timestamp, row, started


def features(frames, samples, parameters):
    if not parameters:
        raise ValueError("The motion-edge detector requires frozen classifier parameters")
    mean = np.asarray(parameters["mean"], dtype=np.float32)
    scale = np.asarray(parameters["scale"], dtype=np.float32)
    layers = [(np.asarray(layer["weight"], dtype=np.float32), np.asarray(layer["bias"], dtype=np.float32))
              for layer in parameters["layers"]]
    values, durations = [], []
    for timestamp, row, started in feature_rows(frames, samples, parameters["use_visual"]):
        state = np.clip((row - mean) / scale, -6, 6)
        for index, (weights, bias) in enumerate(layers):
            state = weights @ state + bias
            if index + 1 < len(layers):
                state = np.maximum(state, 0)
        score = signed_confidence(state, parameters.get("state_gate", False)).item()
        values.append((timestamp, score))
        durations.append((perf_counter_ns() - started) / 1_000_000)
    return values, durations


def signed_confidence(logits, state_gate):
    edge_logits = logits[..., :3]
    probabilities = np.exp(edge_logits - edge_logits.max(axis=-1, keepdims=True))
    close, release = probabilities[..., 1], probabilities[..., 2]
    if state_gate:
        closed = 1.0 / (1.0 + np.exp(-np.clip(logits[..., 3], -30, 30)))
        close = close * (.3 + .7 * closed)
        release = release * (.3 + .7 * (1 - closed))
    return (close - release) / probabilities.sum(axis=-1)

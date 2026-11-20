"""Causal jaw-state inference with a fixed-lag video and IMU network."""

from collections import deque
from time import perf_counter_ns

import cv2
import numpy as np

from alternative_signals import jaw_descriptor


# The first frames provide a visual reference without any action-time labels.
REFERENCE_FRAMES = 8
LAGS = (0, 1, 2, 4, 8)
PATCH_SIZE = (16, 24)


def _video_features(frame):
    crop = frame[105:207, 148:207]
    patch = cv2.resize(crop, PATCH_SIZE, interpolation=cv2.INTER_AREA).astype(np.float32)
    patch -= patch.mean()
    patch /= max(12, float(patch.std()))
    histogram = jaw_descriptor(frame).astype(np.float32)
    return np.concatenate((patch.ravel(), histogram))


def _motion_features(samples, timestamp, previous_timestamp):
    result = []
    for stream in ("accelerometer", "gyroscope"):
        if stream not in samples:
            result.extend((0.0,) * 8)
            continue
        times, vectors = samples[stream]
        start, stop = np.searchsorted(times, (previous_timestamp, timestamp), side="right")
        if stop == 0 or timestamp - times[stop - 1] > 0.20:
            result.extend((0.0,) * 8)
            continue
        observed = vectors[start:stop] if start < stop else vectors[stop - 1:stop]
        history = vectors[max(0, start - 1):stop]
        result.extend(observed[-1])
        result.extend(observed.mean(axis=0))
        result.append(float(np.linalg.norm(np.diff(history, axis=0), axis=1).max(initial=0.0)))
        result.append(float(np.linalg.norm(observed, axis=1).max()))
    return result


def _feature_rows(frames, samples):
    """Generate each row from current and already observed frames and sensors."""
    samples = {stream: (np.asarray(times), vectors) for stream, (times, vectors) in samples.items()}
    initial = []
    previous_video = reference = None
    previous_timestamp = -np.inf
    for timestamp, frame in frames:
        started = perf_counter_ns()
        current = _video_features(frame)
        if len(initial) < REFERENCE_FRAMES:
            initial.append(current)
            reference = np.median(initial, axis=0)
        delta = current - previous_video if previous_video is not None else np.zeros_like(current)
        row = np.concatenate((current - reference, delta, current[-32:],
                              _motion_features(samples, timestamp, previous_timestamp))).astype(np.float32)
        previous_video = current
        previous_timestamp = timestamp
        yield timestamp, row, started


def _lagged_matrix(rows):
    indices = np.arange(len(rows))[:, None] - np.asarray(LAGS)
    return rows[np.maximum(indices, 0)]


def fit(frames_by_clip, motion_by_clip, labels, *, seed=47, epochs=100, temporal=True, use_imu=True):
    """Fit on caller-provided labeled clips and return JSON-safe frozen parameters."""
    import torch
    from torch import nn
    from torch.nn import functional

    torch.set_num_threads(2)
    torch.manual_seed(seed)
    clip_features, clip_targets, clip_weights = [], [], []
    for frames, motion, label in zip(frames_by_clip, motion_by_clip, labels, strict=True):
        timestamps, rows, _ = zip(*_feature_rows(frames, motion), strict=True)
        timestamps = np.asarray(timestamps)[REFERENCE_FRAMES:]
        rows = np.stack(rows)
        if not use_imu:
            rows[:, -16:] = 0
        clip_features.append(_lagged_matrix(rows)[REFERENCE_FRAMES:])
        is_closed = (timestamps >= label["close"]) & (timestamps < label["open"])
        nearest_transition = np.minimum(abs(timestamps - label["close"]), abs(timestamps - label["open"]))
        # Upweight examples near transitions, while giving both states and all clips similar weight.
        weights = np.where(is_closed, 1.0 / max(1, int(is_closed.sum())),
                           1.0 / max(1, int((~is_closed).sum())))
        weights *= 1 + 0.75 * (nearest_transition < 0.24)
        clip_targets.append(is_closed)
        clip_weights.append(weights / weights.sum())

    values = np.concatenate(clip_features)
    if not temporal:
        values = values[:, :1, :]
    targets = torch.tensor(np.concatenate(clip_targets), dtype=torch.float32)
    weights = np.concatenate(clip_weights)
    weights = torch.tensor(weights / weights.mean(), dtype=torch.float32)
    mean = values[:, 0].mean(axis=0)
    scale = np.maximum(values[:, 0].std(axis=0), 0.03)
    inputs = torch.from_numpy(np.clip((values - mean) / scale, -8, 8))

    class TemporalState(nn.Module):
        def __init__(self):
            super().__init__()
            self.embed = nn.Linear(inputs.shape[-1], 48)
            self.hidden = nn.Linear(inputs.shape[1] * 48, 64)
            self.output = nn.Linear(64, 1)

        def forward(self, value):
            encoded = self.embed(value).relu().flatten(1)
            encoded = functional.dropout(encoded, p=0.10, training=self.training)
            hidden = self.hidden(encoded).relu()
            return self.output(hidden).squeeze(-1)

    model = TemporalState()
    optimizer = torch.optim.AdamW(model.parameters(), lr=0.0016, weight_decay=0.02)
    schedule = torch.optim.lr_scheduler.CosineAnnealingLR(optimizer, T_max=epochs, eta_min=0.00015)
    for _ in range(epochs):
        for batch in torch.randperm(len(inputs)).split(256):
            logits = model(inputs[batch])
            errors = functional.binary_cross_entropy_with_logits(logits, targets[batch], reduction="none")
            loss = (errors * weights[batch]).mean()
            optimizer.zero_grad(set_to_none=True)
            loss.backward()
            optimizer.step()
        schedule.step()

    return {
        "mean": mean.tolist(), "scale": scale.tolist(), "use_imu": use_imu,
        "lags": list(LAGS if temporal else LAGS[:1]),
        "layers": [{"weight": layer.weight.detach().numpy().tolist(),
                    "bias": layer.bias.detach().numpy().tolist()}
                   for layer in (model.embed, model.hidden, model.output)],
    }


def features(frames, samples, parameters):
    """Return timestamped probabilities and per-frame inference durations."""
    mean = np.asarray(parameters["mean"], dtype=np.float32)
    scale = np.asarray(parameters["scale"], dtype=np.float32)
    layers = [(np.asarray(layer["weight"], dtype=np.float32),
               np.asarray(layer["bias"], dtype=np.float32)) for layer in parameters["layers"]]
    lags = parameters["lags"]
    history = deque(maxlen=max(lags) + 1)
    values, durations = [], []
    for timestamp, row, started in _feature_rows(frames, samples):
        if not parameters["use_imu"]:
            row[-16:] = 0
        current = np.maximum(layers[0][0] @ np.clip((row - mean) / scale, -8, 8) + layers[0][1], 0)
        history.appendleft(current)
        window = np.concatenate([history[min(lag, len(history) - 1)] for lag in lags])
        hidden = np.maximum(layers[1][0] @ window + layers[1][1], 0)
        logit = (layers[2][0] @ hidden + layers[2][1]).item()
        probability = 1.0 / (1.0 + np.exp(-np.clip(logit, -30, 30)))
        values.append((timestamp, float(probability)))
        durations.append((perf_counter_ns() - started) / 1_000_000)
    return values, durations

"""Causal shaft-relative tracking of two articulated grabber landmarks."""

from collections import deque
from time import perf_counter_ns

import cv2
import numpy as np

from geometry47 import CALIBRATION_FRAMES, _registration, _shaft_patch


SCALE = 2
PATCH_RADIUS = 5
PATCH_WIDTH = 2 * PATCH_RADIUS + 1
# Bounds are center coordinates after 2× subsampling of the prepared frame.
WINDOWS = {"upper": (87, 99, 55, 75), "lower": (84, 97, 70, 100)}
ROI_X = 75
ROI_Y = 48
ROI_WIDTH = 33
ROI_HEIGHT = 61


def _channels(frame, offset):
    x, y = offset
    y0, x0 = ROI_Y * SCALE + y, ROI_X * SCALE + x
    crop = frame[y0:y0 + ROI_HEIGHT * SCALE, x0:x0 + ROI_WIDTH * SCALE]
    image = cv2.resize(crop.astype(np.float32), (ROI_WIDTH, ROI_HEIGHT), interpolation=cv2.INTER_AREA)
    horizontal = cv2.Sobel(image, cv2.CV_32F, 1, 0, ksize=3)
    vertical = cv2.Sobel(image, cv2.CV_32F, 0, 1, ksize=3)
    return np.stack((image, horizontal, vertical, np.hypot(horizontal, vertical)))


def _search_view(channels, bounds):
    x0, x1, y0, y1 = bounds
    return channels[:, y0 - ROI_Y - PATCH_RADIUS:y1 - ROI_Y + PATCH_RADIUS,
                    x0 - ROI_X - PATCH_RADIUS:x1 - ROI_X + PATCH_RADIUS]


def _tracker(channels, landmark, weights, previous):
    x0, x1, y0, y1 = WINDOWS[landmark]
    region = _search_view(channels, WINDOWS[landmark])
    combined = np.zeros((y1 - y0, x1 - x0), dtype=np.float32)
    for channel, (kernel, strength) in zip(region, weights, strict=True):
        if strength > 1e-8:
            combined += cv2.matchTemplate(channel, kernel, cv2.TM_CCOEFF_NORMED) * strength
    rows = np.arange(y0, y1)
    cols = np.arange(x0, x1)
    # A soft continuity cost discourages implausible jumps to nearby clutter.
    # Bound the penalty to leave a path to reacquire after partial occlusion.
    prior_x = 92 + 0.15 * (rows - 62) if landmark == "upper" else 90
    combined -= 0.002 * (cols[None, :] - np.broadcast_to(prior_x, rows.shape)[:, None]) ** 2
    raw = combined.copy()
    if previous is not None:
        combined = 0.68 * combined + 0.32 * previous
    iy, ix = np.unravel_index(combined.argmax(), combined.shape)
    far = (abs(rows[:, None] - rows[iy]) > 3) | (abs(cols[None, :] - cols[ix]) > 3)
    score = float(combined[iy, ix])
    margin = score - float(combined[far].max(initial=-1.0))
    profile = combined.max(axis=1)
    closed = rows >= 65 if landmark == "upper" else rows <= 84
    evidence = float(profile[closed].max() - profile[~closed].max())
    return float(cols[ix] * SCALE), float(rows[iy] * SCALE), score, margin, evidence, raw


def template_weights(raw):
    result = {}
    for landmark, values in raw.items():
        kernel = np.asarray(values, dtype=np.float32).reshape(-1, PATCH_WIDTH, PATCH_WIDTH)
        kernel -= kernel.mean(axis=(1, 2), keepdims=True)
        result[landmark] = [(channel, float(np.linalg.norm(channel))) for channel in kernel]
    return result


def descriptors(frames, raw_weights):
    weights = template_weights(raw_weights)
    initial_shaft = []
    shaft = None
    previous_top = previous_pad = None
    history = deque(maxlen=4)
    for timestamp, frame in frames:
        started = perf_counter_ns()
        if len(initial_shaft) < CALIBRATION_FRAMES:
            initial_shaft.append(_shaft_patch(frame).copy())
            if len(initial_shaft) == CALIBRATION_FRAMES:
                shaft = np.rint(np.median(initial_shaft, axis=0)).astype(np.uint8)
        channels = _channels(frame, _registration(frame, shaft))
        tx, ty, ts, tm, te, previous_top = _tracker(channels, "upper", weights["upper"], previous_top)
        px, py, ps, pm, pe, previous_pad = _tracker(channels, "lower", weights["lower"], previous_pad)
        motion = np.asarray(((ty - 126) / 18, (171 - py) / 29, (53 - py + ty) / 32),
                            dtype=np.float32)
        speed = motion - history[0] if history else np.zeros_like(motion)
        history.append(motion)
        point_quality = max(0, min(tm, pm))
        row = np.concatenate((motion, speed, (
            (tx - 185) / 12, (px - 180) / 12, ts, ps, tm, pm,
            motion[2] * point_quality, speed[2] * point_quality, te, pe,
        ))).astype(np.float32)
        yield timestamp, row, started


def features(frames, samples, parameters):
    weights = np.asarray(parameters["readout"]["weights"], dtype=np.float32)
    intercept = parameters["readout"]["intercept"]
    initial = []
    baseline = None
    values, durations = [], []
    for timestamp, row, started in descriptors(frames, parameters["landmarks"]):
        if len(initial) < CALIBRATION_FRAMES:
            initial.append(row)
            if len(initial) == CALIBRATION_FRAMES:
                baseline = np.median(initial, axis=0)
            score = 0.0
        else:
            score = float(row @ weights[0] + (row - baseline) @ weights[1] + intercept)
        values.append((timestamp, score))
        durations.append((perf_counter_ns() - started) / 1_000_000)
    return values, durations

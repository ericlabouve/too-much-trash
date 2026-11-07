"""Marker-free signals for the jaw trigger replay."""

from bisect import bisect_right
from collections import deque
import math
from statistics import median
from time import perf_counter_ns

import cv2
import numpy as np


def jaw_angle(crop):
    lines = cv2.HoughLinesP(cv2.Canny(crop, 45, 110), 1, np.pi / 180, 10,
                            minLineLength=12, maxLineGap=4)
    if lines is None:
        return math.nan
    sides = [[], []]
    pivot = np.array([45, 69])
    for line in lines.reshape(-1, 4):
        start, end = line.reshape(2, 2)
        direction = end - start
        length = np.linalg.norm(direction)
        delta = pivot - start
        distance = abs(direction[0] * delta[1] - direction[1] * delta[0]) / length
        if distance <= 12 and min(start[0], end[0]) <= 48:
            sides[int((start[1] + end[1]) / 2 >= pivot[1])].append(
                (length, math.atan2(direction[1], direction[0]) % math.pi))
    if not all(sides):
        return math.nan
    upper, lower = [max(side)[1] for side in sides]
    gap = abs(upper - lower)
    return min(gap, math.pi - gap)


def tracked_offset(reference, crop):
    offsets = []
    for x, y in ((45, 69), (31, 87)):
        patch = reference[y - 5:y + 6, x - 4:x + 5]
        search = crop[y - 12:y + 13, x - 11:x + 12]
        matches = cv2.matchTemplate(search, patch, cv2.TM_CCOEFF_NORMED)
        _, quality, _, offset = cv2.minMaxLoc(matches)
        if quality < 0.55 or patch.std() < 5:
            return math.nan
        offsets.append(np.array(offset))
    return float(np.linalg.norm(offsets[1] - offsets[0]))


def gradient_histograms(crop):
    dx = cv2.Sobel(crop, cv2.CV_32F, 1, 0)
    dy = cv2.Sobel(crop, cv2.CV_32F, 0, 1)
    magnitude, angle = cv2.cartToPolar(dx, dy)
    bins = (angle * (8 / np.pi)).astype(np.int32) % 8
    descriptors = []
    for rows in (slice(10, 51), slice(51, 92)):
        for cols in (slice(10, 29), slice(29, 49)):
            histogram = np.bincount(bins[rows, cols].ravel(),
                                    weights=np.minimum(magnitude[rows, cols], 100).ravel(),
                                    minlength=8)
            descriptors.append(np.sqrt(histogram / max(histogram.sum(), 1)))
    return np.asarray(descriptors)


def jaw_descriptor(frame):
    return gradient_histograms(frame[105:207, 148:207]).ravel()


def fit_jaw_projection(clips, labels, calibration_frames, ridge=0.01):
    rows, targets = [], []
    for frames, label in zip(clips, labels, strict=True):
        descriptors = np.asarray([jaw_descriptor(frame) for _, frame in frames])
        timestamps = np.asarray([timestamp for timestamp, _ in frames])
        reference = np.median(descriptors[:calibration_frames], axis=0)
        stable = (abs(timestamps - label["close"]) > 0.20) & (abs(timestamps - label["open"]) > 0.20)
        rows.extend(descriptors[stable] - reference)
        targets.extend((timestamps[stable] >= label["close"]) & (timestamps[stable] <= label["open"]))
    matrix = np.column_stack((rows, np.ones(len(rows))))
    target = np.asarray(targets)
    prevalence = target.mean()
    if not 0 < prevalence < 1:
        raise ValueError("Jaw projection requires stable open and closed examples")
    weights = np.where(target, 0.5 / prevalence, 0.5 / (1 - prevalence))
    regularizer = np.eye(matrix.shape[1]) * ridge
    regularizer[-1, -1] = 0
    return np.linalg.solve(matrix.T @ (weights[:, None] * matrix) + regularizer,
                           matrix.T @ (weights * target)).tolist()


def projected_jaw_features(frames, coefficients, calibration_frames):
    values, durations = [], []
    baseline = []
    weights = np.asarray(coefficients[:-1])
    intercept = coefficients[-1]
    for timestamp, frame in frames:
        started = perf_counter_ns()
        descriptor = jaw_descriptor(frame)
        value = 0.0
        if len(baseline) < calibration_frames:
            baseline.append(descriptor)
            if len(baseline) == calibration_frames:
                reference = np.median(baseline, axis=0)
        else:
            value = float((descriptor - reference) @ weights + intercept)
        values.append((timestamp, value))
        durations.append((perf_counter_ns() - started) / 1_000_000)
    return values, durations


def sparse_jaw_flow(previous, current):
    offsets = []
    for left, right in ((8, 27), (32, 51)):
        mask = np.zeros_like(previous)
        mask[10:75, left:right] = 255
        points = cv2.goodFeaturesToTrack(previous, 8, 0.02, 3, mask=mask)
        if points is None:
            return math.nan
        moved, forward, _ = cv2.calcOpticalFlowPyrLK(previous, current, points, None, winSize=(11, 11), maxLevel=1)
        back, backward, _ = cv2.calcOpticalFlowPyrLK(current, previous, moved, None, winSize=(11, 11), maxLevel=1)
        valid = forward.ravel().astype(bool) & backward.ravel().astype(bool)
        valid &= np.linalg.norm((back - points).reshape(-1, 2), axis=1) <= 1
        if not valid.any():
            return math.nan
        offsets.append(float(np.median((moved - points)[valid, 0, 0])))
    return offsets[0] - offsets[1]


def change_occupancy(reference, noise, crop):
    residual = crop.astype(np.float32) - reference
    residual -= np.median(residual)
    changed = (np.abs(residual) > np.maximum(18, 3 * noise)).astype(np.uint8)
    changed = cv2.morphologyEx(changed, cv2.MORPH_OPEN, np.ones((3, 3), np.uint8))
    inner = changed[12:91, 16:45].mean()
    outer = (changed[:, :10].mean() + changed[:, -10:].mean()) / 2
    return float(max(0, inner - outer))


def visual_features(method, frames, calibration_frames):
    baseline, values, durations = [], [], []
    reference = noise = reference_shaft = None
    recent = deque(maxlen=5)
    gradient = method in {"gradient", "shaft_gradient", "local_gradient", "surround_gradient", "adaptive_gradient", "gradient_topcell"}
    for timestamp, frame in frames:
        started = perf_counter_ns()
        crop = frame[105:207, 148:207]
        if method == "shaft_gradient":
            shaft = frame[193:229, 197:239].astype(np.float32)
            if reference_shaft is None:
                reference_shaft = shaft
            (dx, dy), confidence = cv2.phaseCorrelate(reference_shaft, shaft)
            if confidence >= 0.3 and max(abs(dx), abs(dy)) <= 5:
                x, y = round(dx), round(dy)
                crop = frame[105 + y:207 + y, 148 + x:207 + x]
        observed = jaw_angle(crop) if method == "angle" else (
            gradient_histograms(crop) if gradient else crop)
        if method == "surround_gradient":
            surround = gradient_histograms(frame[105:207, 89:148])
            observed = np.stack((observed, surround))
        if len(baseline) < calibration_frames:
            baseline.append(observed)
            value = 0.0
            if len(baseline) == calibration_frames:
                if method == "angle":
                    valid = [angle for angle in baseline if math.isfinite(angle)]
                    reference = median(valid) if valid else math.nan
                else:
                    reference = np.median(baseline, axis=0)
                    if method == "patch":
                        reference = reference.astype(np.uint8)
                    elif method == "occupancy":
                        noise = np.median(np.abs(np.asarray(baseline) - reference), axis=0)
        elif method == "angle":
            value = abs(observed - reference)
        elif gradient:
            distance = float(np.linalg.norm(observed - reference, axis=-1).mean())
            if method == "surround_gradient":
                jaw, surround = np.linalg.norm(observed - reference, axis=-1).mean(axis=-1)
                distance = max(0.0, jaw - 0.5 * surround)
            if method == "gradient_topcell":
                distance = float(np.linalg.norm(observed - reference, axis=-1).max())
            if method == "adaptive_gradient" and distance < 0.11:
                reference += 0.05 * (observed - reference)
            if method == "local_gradient":
                value = distance - median(recent) if recent else 0.0
                recent.append(distance)
            else:
                value = distance
        elif method == "occupancy":
            value = change_occupancy(reference, noise, crop)
        else:
            value = tracked_offset(reference, crop)
        values.append((timestamp, value))
        durations.append((perf_counter_ns() - started) / 1_000_000)
    return values, durations


def motion_samples(sidecar):
    streams = {row["sample"]["stream"] for row in sidecar["samples"]}
    return {stream: sensor_samples(sidecar, stream) for stream in streams & {"accelerometer", "gyroscope"}}


def sensor_samples(sidecar, stream):
    samples = sorted((row["commonTime"] - sidecar["start"], row["sample"]["values"])
                     for row in sidecar["samples"]
                     if row.get("sample", {}).get("stream") == stream)
    if len(samples) < 2:
        raise ValueError(f"Missing {stream} samples")
    times, vectors = zip(*samples, strict=True)
    return times, np.asarray(vectors)


def imu_features(frames, samples):
    times, vectors = samples
    times = times[1:]
    values, durations = [], []
    first = 0
    for timestamp, _ in frames:
        started = perf_counter_ns()
        stop = bisect_right(times, timestamp, lo=first)
        changes = np.diff(vectors[first:stop + 1], axis=0)
        value = float(np.linalg.norm(changes, axis=1).max(initial=0))
        first = stop
        values.append((timestamp, value))
        durations.append((perf_counter_ns() - started) / 1_000_000)
    return values, durations

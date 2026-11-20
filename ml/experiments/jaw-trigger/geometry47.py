"""Estimate jaw state from shaft-relative strips through the mounted grabber.

The prepared grayscale frame is 320 × 240. The jaw plane is approximately
parallel to the image y axis for this mount. Two long arms pivot in that plane,
so the upper metal cap moves down while the lower pad moves up on closure.
A short translation correction uses the rigid shaft downstream of the hinge.
The feature scan then measures local profiles at fixed offsets from the shaft.
"""

from time import perf_counter_ns

import cv2
import numpy as np


CALIBRATION_FRAMES = 8
SHAFT_Y = slice(193, 219)
SHAFT_X = slice(197, 218)
SEARCH_RADIUS = 4
SCAN_Y = np.arange(112, 208)
SCAN_CENTER = np.rint(187 + 0.23 * (SCAN_Y - 165)).astype(np.int32)
SCAN_X = SCAN_CENTER[:, None] + np.arange(-28, 14)
ROW = SCAN_Y[:, None]


def _shaft_patch(frame):
    return frame[SHAFT_Y, SHAFT_X]


def _registration(frame, shaft):
    if shaft is None or shaft.std() < 4:
        return 0, 0
    radius = SEARCH_RADIUS
    search = frame[SHAFT_Y.start - radius:SHAFT_Y.stop + radius,
                   SHAFT_X.start - radius:SHAFT_X.stop + radius]
    scores = cv2.matchTemplate(search, shaft, cv2.TM_CCOEFF_NORMED)
    _, score, _, (x, y) = cv2.minMaxLoc(scores)
    return (x - radius, y - radius) if score >= 0.58 else (0, 0)


def _scan(frame, shaft):
    x, y = _registration(frame, shaft)
    strip = frame[ROW + y, SCAN_X + x].astype(np.float32)
    strip -= float(strip.mean())
    strip /= max(float(strip.std()), 12)
    dx = cv2.Sobel(strip, cv2.CV_32F, 1, 0, ksize=3) / 8
    dy = cv2.Sobel(strip, cv2.CV_32F, 0, 1, ksize=3) / 8
    # Preserve where across the hinge plane each response came from. Widths of
    # seven pixels keep narrow tool edges separate from nearby scene texture.
    regions = (strip, dx, dy, np.abs(dx), np.abs(dy))
    return np.concatenate([channel.reshape(24, 4, 6, 7).mean(axis=(1, 3)).ravel()
                           for channel in regions])


def descriptors(frames):
    reference = []
    shaft = None
    for timestamp, frame in frames:
        started = perf_counter_ns()
        if len(reference) < CALIBRATION_FRAMES:
            reference.append(_shaft_patch(frame).copy())
            if len(reference) == CALIBRATION_FRAMES:
                shaft = np.rint(np.median(reference, axis=0)).astype(np.uint8)
        values = _scan(frame, shaft)
        yield timestamp, values, started


def features(frames, samples, parameters):
    weights = np.asarray(parameters["weights"], dtype=np.float32)
    intercept = parameters["intercept"]
    reference = []
    baseline = None
    values, durations = [], []
    for timestamp, descriptor, started in descriptors(frames):
        if len(reference) < CALIBRATION_FRAMES:
            reference.append(descriptor)
            if len(reference) == CALIBRATION_FRAMES:
                baseline = np.median(reference, axis=0)
            score = 0.0
        else:
            score = float(descriptor @ weights[0] + (descriptor - baseline) @ weights[1] + intercept)
        values.append((timestamp, score))
        durations.append((perf_counter_ns() - started) / 1_000_000)
    return values, durations

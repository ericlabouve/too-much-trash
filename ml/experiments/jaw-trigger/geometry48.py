"""Low-capacity jaw geometry using projected arm motion or pooled profiles."""

from itertools import product
from time import perf_counter_ns

import cv2
import numpy as np

from geometry47 import (
    CALIBRATION_FRAMES, ROW, SCAN_X, _registration, _shaft_patch, descriptors as scanlines,
)


# Rectified strip indices. Upper arm shortening is relative to the hinge;
# the lower arm/pad can pass across the hinge, so use a translation there.
UPPER_ROWS = np.arange(118, 167) - 112
UPPER_COLS = np.arange(17, 37)
UPPER_TRANSFORMS = np.asarray(list(product(np.arange(0.55, 1.10, 0.06), (-2, 0, 2))))
UPPER_Y = np.rint((UPPER_ROWS[None, :] - 60) * UPPER_TRANSFORMS[:, 0, None] + 60).astype(np.intp)
UPPER_X = UPPER_COLS[None, :] + UPPER_TRANSFORMS[:, 1, None].astype(np.intp)
LOWER_ROWS = np.arange(176, 199) - 112
LOWER_COLS = np.arange(9, 30)
LOWER_TRANSFORMS = np.asarray(list(product(range(-28, 9, 3), range(-3, 4, 3))))
LOWER_Y = LOWER_ROWS[None, :] + LOWER_TRANSFORMS[:, 0, None]
LOWER_X = LOWER_COLS[None, :] + LOWER_TRANSFORMS[:, 1, None]
UPPER_CLOSED = UPPER_TRANSFORMS[:, 0] < 0.86
LOWER_CLOSED = LOWER_TRANSFORMS[:, 0] < -7
SPAN_OFFSETS = np.asarray(list(product(range(19, 31, 2), (7, 9, 11))))
SPAN_CUTS = np.arange(7, 44, 2)
PAD_CUTS = np.arange(41, 83, 2)


def _strip(frame, shaft):
    x, y = _registration(frame, shaft)
    image = frame[ROW + y, SCAN_X + x].astype(np.float32)
    image = cv2.GaussianBlur(image, (3, 3), 0.6)
    horizontal = cv2.Sobel(image, cv2.CV_32F, 1, 0, ksize=3) / 8
    vertical = cv2.Sobel(image, cv2.CV_32F, 0, 1, ksize=3) / 8
    return np.stack((image, horizontal, vertical), axis=-1)


def _correlation(template, warped, weights):
    candidates = warped.reshape(len(warped), -1, 3)
    reference = template.reshape(-1, 3)
    candidates -= candidates.mean(axis=1, keepdims=True)
    reference = reference - reference.mean(axis=0, keepdims=True)
    reference_norm = np.sqrt((reference**2).sum(axis=0))
    candidate_norms = np.sqrt((candidates**2).sum(axis=1))
    evidence = (candidates * reference).sum(axis=1) / np.maximum(candidate_norms * reference_norm, 1.0)
    return evidence @ weights


def _deformation(frames):
    shaft_frames, initial_strips = [], []
    shaft = None
    for timestamp, frame in frames:
        started = perf_counter_ns()
        current = _strip(frame, shaft)
        if len(shaft_frames) < CALIBRATION_FRAMES:
            shaft_frames.append(_shaft_patch(frame).copy())
            initial_strips.append(current)
            if len(shaft_frames) == CALIBRATION_FRAMES:
                shaft = np.rint(np.median(shaft_frames, axis=0)).astype(np.uint8)
                template = np.median(initial_strips, axis=0)
                upper = template[UPPER_ROWS[:, None], UPPER_COLS]
                lower = template[LOWER_ROWS[:, None], LOWER_COLS]
            yield timestamp, np.zeros(12, dtype=np.float32), started
            continue

        upper_scores = _correlation(upper, current[UPPER_Y[:, :, None], UPPER_X[:, None, :]],
                                    (0.7, 0.15, 0.15))
        lower_scores = _correlation(lower, current[LOWER_Y[:, :, None], LOWER_X[:, None, :]],
                                    (0.6, 0.2, 0.2))
        upper_idx, lower_idx = int(upper_scores.argmax()), int(lower_scores.argmax())
        upper_score, lower_score = upper_scores[upper_idx], lower_scores[lower_idx]
        shortening = 1 - UPPER_TRANSFORMS[upper_idx, 0]
        lift = -LOWER_TRANSFORMS[lower_idx, 0] / 24
        upper_evidence = upper_scores[UPPER_CLOSED].max() - upper_scores[~UPPER_CLOSED].max()
        lower_evidence = lower_scores[LOWER_CLOSED].max() - lower_scores[~LOWER_CLOSED].max()
        upper_quality, lower_quality = max(0, upper_score), max(0, lower_score)
        vector = np.asarray(
            [shortening, upper_score, upper_evidence, shortening * upper_quality,
             upper_evidence * upper_quality, lift, lower_score, lower_evidence,
             lift * lower_quality, lower_evidence * lower_quality,
             upper_score * lower_score, upper_evidence * lower_evidence], dtype=np.float32
        )
        yield timestamp, vector, started


def pooled_scan(vector, rows=6):
    # Keep the interior jaw bands and pool four rows and two columns of the
    # original scanline representation. This discards outer scene texture.
    regions = np.asarray(vector).reshape(5, 24, 6)[:, :, 1:5]
    return regions.reshape(5, rows, 24 // rows, 2, 2).mean(axis=(2, 4)).ravel()


def _compact_profiles(frames, rows):
    for timestamp, vector, started in scanlines(frames):
        yield timestamp, pooled_scan(vector, rows), started


def _arm_spans(frames):
    shaft_frames = []
    shaft = None
    center, width = SPAN_OFFSETS.T
    left = center - width // 2
    right = center + width // 2
    for timestamp, frame in frames:
        started = perf_counter_ns()
        if len(shaft_frames) < CALIBRATION_FRAMES:
            shaft_frames.append(_shaft_patch(frame).copy())
            if len(shaft_frames) == CALIBRATION_FRAMES:
                shaft = np.rint(np.median(shaft_frames, axis=0)).astype(np.uint8)
        x, y = _registration(frame, shaft)
        image = frame[ROW + y, SCAN_X + x].astype(np.float32)
        image = cv2.GaussianBlur(image, (3, 3), 0.6)
        horizontal = cv2.Sobel(image, cv2.CV_32F, 1, 0, ksize=3) / 8
        edge_norm = max(float(np.mean(np.abs(horizontal))), 3)
        left_edges, right_edges = horizontal[:, left], horizontal[:, right]
        paired = np.minimum(np.abs(left_edges), np.abs(right_edges))
        paired *= np.where(left_edges * right_edges < 0, 1.0, 0.65)
        paired /= edge_norm
        # Select the parallel strip aligned with the rigidly connected shaft end.
        score = paired[38:57].mean(axis=0) - 0.025 * abs(center - 25)
        best = int(score.argmax())
        profiles = [paired[:, best], paired.mean(axis=1)]
        readings = []
        for profile in profiles:
            below = np.asarray([profile[cut:cut + 12].mean() for cut in SPAN_CUTS])
            above = np.asarray([profile[max(0, cut - 10):cut].mean() for cut in SPAN_CUTS])
            evidence = below - above
            strongest = int(evidence.argmax())
            readings.extend((SPAN_CUTS[strongest] / 44, evidence[strongest],
                             profile[8:23].mean(), profile[24:40].mean(), profile[40:57].mean()))
        pad = image[:, 12:24].mean(axis=1) - image[:, 26:36].mean(axis=1)
        pad /= max(float(image.std()), 12)
        pad_edge = np.asarray([pad[cut:cut + 7].mean() - pad[cut - 7:cut].mean() for cut in PAD_CUTS])
        strongest = int(np.abs(pad_edge).argmax())
        readings.extend((PAD_CUTS[strongest] / 88, pad_edge[strongest],
                         pad[36:51].mean(), pad[51:67].mean(), pad[67:82].mean(),
                         float(score[best]), center[best] / 30, width[best] / 11))
        yield timestamp, np.asarray(readings, dtype=np.float32), started


def _descriptors(frames, kind):
    if kind == "deformation":
        return _deformation(frames)
    if kind == "profiles":
        return _compact_profiles(frames, 6)
    if kind == "fine_profiles":
        return _compact_profiles(frames, 24)
    if kind == "spans":
        return _arm_spans(frames)
    raise ValueError(f"Unknown geometry descriptor {kind!r}")


def features(frames, samples, parameters):
    kind = parameters["descriptor"]
    weights = np.asarray(parameters["weights"], dtype=np.float32)
    intercept = parameters["intercept"]
    initial = []
    baseline = None
    values, durations = [], []
    for timestamp, vector, started in _descriptors(frames, kind):
        if len(initial) < CALIBRATION_FRAMES:
            initial.append(vector)
            if len(initial) == CALIBRATION_FRAMES:
                baseline = np.median(initial, axis=0)
            score = 0.0
        else:
            score = float(vector @ weights[0] + (vector - baseline) @ weights[1] + intercept)
        values.append((timestamp, score))
        durations.append((perf_counter_ns() - started) / 1_000_000)
    return values, durations

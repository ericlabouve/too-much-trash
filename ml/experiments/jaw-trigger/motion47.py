"""Reacher-relative jaw appearance with ARKit background downweighting."""

from bisect import bisect_right
from time import perf_counter_ns

import cv2
import numpy as np


JAW_ROWS = slice(105, 207)
JAW_COLS = slice(148, 207)
CELLS = (
    (slice(10, 51), slice(10, 29)), (slice(10, 51), slice(29, 49)),
    (slice(51, 92), slice(10, 29)), (slice(51, 92), slice(29, 49)),
)
AR_TO_OPTICAL = np.diag([1, -1, -1])
CROP_TO_FRAME = np.array([[1, 0, JAW_COLS.start], [0, 1, JAW_ROWS.start], [0, 0, 1]])
INVERSE_DEPTHS = (0.0, 0.35, 0.75, 1.35, 2.2)
MAX_POSE_AGE = 0.04


def pose_at(times, records, timestamp, frame_shape):
    index = bisect_right(times, timestamp) - 1
    if index < 0 or timestamp - times[index] > MAX_POSE_AGE:
        return None
    sample = records[index]
    if sample.get("tracking") != "normal":
        return None
    columns = sample.get("cameraToWorldColumns", ())
    intrinsics = sample.get("intrinsicsColumns", ())
    source_width = sample.get("imageWidth", 0)
    source_height = sample.get("imageHeight", 0)
    if len(columns) != 16 or len(intrinsics) != 9 or not source_width or not source_height:
        return None
    transform = np.asarray(columns).reshape(4, 4).T
    camera = np.asarray(intrinsics).reshape(3, 3).T
    if not np.isfinite(transform).all() or not np.isfinite(camera).all() or min(camera[0, 0], camera[1, 1]) <= 0:
        return None
    height, width = frame_shape[:2]
    camera = np.diag([width / source_width, height / source_height, 1]) @ camera
    return transform[:3, :3], transform[:3, 3], camera


def foreground_weights(previous, current, previous_pose, current_pose):
    """Downweight image changes that a static world point could explain."""
    before_rotation, before_position, before_camera = previous_pose
    after_rotation, after_position, after_camera = current_pose
    before_view = AR_TO_OPTICAL @ before_rotation.T
    rotation = before_view @ after_rotation @ AR_TO_OPTICAL
    translation = before_view @ (after_position - before_position)
    angular_step = np.sqrt(max(0.0, 3.0 - np.trace(rotation)))
    if angular_step < .003 and np.linalg.norm(translation) < .002:
        return None

    crop = current[JAW_ROWS, JAW_COLS]
    local_error = cv2.blur(cv2.absdiff(previous[JAW_ROWS, JAW_COLS], crop), (5, 5))
    best_error = np.full(crop.shape, np.inf, dtype=np.float32)
    rays = np.linalg.solve(after_camera, CROP_TO_FRAME)
    translated = np.zeros((3, 3))
    translated[:, 2] = translation
    size = crop.shape[1], crop.shape[0]
    for inverse_depth in INVERSE_DEPTHS:
        # A plane at optical depth d gives H = K_prev (R + t e3.T/d) K_cur^-1.
        homography = before_camera @ (rotation + inverse_depth * translated) @ rays
        warped = cv2.warpPerspective(previous, homography, size,
                                     flags=cv2.INTER_LINEAR | cv2.WARP_INVERSE_MAP,
                                     borderMode=cv2.BORDER_CONSTANT, borderValue=-1)
        error = cv2.blur(np.where(warped >= 0, np.abs(warped - crop), 255), (5, 5))
        np.minimum(best_error, error, out=best_error)
    confidence = np.clip((local_error - best_error - 2) / 12, 0, 1)
    confidence *= np.clip((14 - best_error) / 10, 0, 1)
    return 1 - .85 * confidence


def gradient_bins(crop):
    dx = cv2.Sobel(crop, cv2.CV_32F, 1, 0)
    dy = cv2.Sobel(crop, cv2.CV_32F, 0, 1)
    magnitude, angle = cv2.cartToPolar(dx, dy)
    return (angle * (8 / np.pi)).astype(np.int32) % 8, np.minimum(magnitude, 100)


def histogram(gradients, weights=None):
    bins, magnitude = gradients
    if weights is not None:
        magnitude = magnitude * weights
    values = []
    for rows, cols in CELLS:
        counts = np.bincount(bins[rows, cols].ravel(), weights=magnitude[rows, cols].ravel(), minlength=8)
        values.extend(np.sqrt(counts / max(counts.sum(), 1)))
    return np.asarray(values)


def features(frames, samples, parameters):
    """Return a closed-state score using only current and past frames/poses."""
    if parameters is None or "linear_hog_refit" not in parameters:
        raise ValueError("The pose-aware jaw detector requires the fitted HOG projection")
    coefficients = np.asarray(parameters["linear_hog_refit"])
    strength = parameters.get("strength", .85)
    calibration_frames = 8
    poses = samples.get("poses", ()) if samples else ()
    times, records = zip(*poses) if poses else ((), ())
    baseline_crops, baseline_descriptors = [], []
    values, durations = [], []
    previous, previous_pose = None, None
    for timestamp, frame in frames:
        started = perf_counter_ns()
        current = frame.astype(np.float32)
        crop = current[JAW_ROWS, JAW_COLS]
        gradients = gradient_bins(crop)
        raw_descriptor = histogram(gradients)
        pose = pose_at(times, records, timestamp, current.shape)
        value = 0.0
        if len(baseline_crops) < calibration_frames:
            baseline_crops.append(crop.copy())
            baseline_descriptors.append(raw_descriptor)
            if len(baseline_crops) == calibration_frames:
                reference = np.median(baseline_descriptors, axis=0)
                reference_gradients = gradient_bins(np.median(baseline_crops, axis=0))
                reference_image_descriptor = histogram(reference_gradients)
        else:
            change = raw_descriptor - reference
            if strength and previous_pose is not None and pose is not None:
                weights = foreground_weights(previous, current, previous_pose, pose)
                if weights is not None:
                    # Apply the same mask to the current and open reference crops.
                    # Keep the original descriptor exactly where the mask is one.
                    change += strength * (histogram(gradients, weights) - raw_descriptor
                                          - histogram(reference_gradients, weights) + reference_image_descriptor)
            value = float(change @ coefficients[:-1] + coefficients[-1])
        previous, previous_pose = current, pose
        values.append((timestamp, value))
        durations.append((perf_counter_ns() - started) / 1_000_000)
    return values, durations

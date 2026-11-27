"""Conservative epoch admission under an unchanged trial wall-time limit."""

from math import isfinite

PROTOCOL = 'epoch-lookahead-v1'


def budget_stop(points, elapsed, limit):
    """Return evidence when another observed-size epoch will not fit.

    Ignore the first measurement's duration: it can include input preparation.
    Later adjacent measurements include optimization, both split evaluations,
    checkpoint writing and caller overhead. Reserve time for finalization.
    This predicts cost, not a guarantee against a sudden stall. The actual time
    bound and canonical receipt check remain authoritative.
    """
    if (type(elapsed) not in (int, float) or not isfinite(elapsed) or elapsed < 0
            or type(limit) not in (int, float) or not isfinite(limit) or limit <= 0):
        raise ValueError('Epoch admission requires finite elapsed time and limit')
    if len(points) < 2 or elapsed >= limit:
        return None
    times = [point['elapsed_seconds'] for point in points]
    if (any(type(value) not in (int, float) or not isfinite(value) or value < 0 for value in times)
            or any(a > b for a, b in zip(times, times[1:])) or times[-1] > elapsed):
        raise ValueError('Epoch admission measurements must be monotonic')
    durations = [b - a for a, b in zip(times, times[1:])][-3:]
    predicted = max(.001, 1.25 * max(durations))
    reserve = max(.05, min(5., .01 * limit))
    if limit - elapsed >= predicted + reserve:
        return None
    return {'protocol': PROTOCOL, 'elapsed_seconds': elapsed, 'limit_seconds': limit,
            'observed_epoch_intervals_seconds': durations,
            'predicted_epoch_seconds': predicted, 'finalization_reserve_seconds': reserve}

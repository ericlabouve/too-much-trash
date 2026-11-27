"""Event-level learning curves from frozen predictions; never infer missing epochs."""

from math import isfinite


def event_f1(predictions, rows, tolerance):
    """Same one-to-one, same-kind greedy matching used by round_one.accuracy."""
    ids = [row['clip'] for row in rows]
    if (not ids or len(set(ids)) != len(ids) or not isinstance(predictions, dict)
            or set(predictions) != set(ids)):
        raise ValueError('Event curves require exactly the frozen split IDs')
    counts = {kind: dict(tp=0, fp=0, fn=0) for kind in ('close', 'open')}
    for row in rows:
        remaining = list(row['jaw_reference'].items())
        events = predictions[row['clip']]
        if not isinstance(events, list):
            raise ValueError('Predictions must contain event lists')
        for event in events:
            if (not isinstance(event, list) or len(event) != 2 or event[0] not in counts
                    or type(event[1]) not in (int, float) or not isfinite(event[1])):
                raise ValueError('Expected finite close/open event predictions')
            kind, time = event
            matches = [(abs(time - ref), index) for index, (expected, ref) in enumerate(remaining)
                       if kind == expected and abs(time - ref) <= tolerance]
            if matches:
                remaining.pop(min(matches)[1])
                counts[kind]['tp'] += 1
            else:
                counts[kind]['fp'] += 1
        for kind, _ in remaining:
            counts[kind]['fn'] += 1
    return {label: 2 * counts[kind]['tp'] / max(1, 2 * counts[kind]['tp'] + counts[kind]['fp'] + counts[kind]['fn'])
            for kind, label in (('close', 'squeeze'), ('open', 'release'))}

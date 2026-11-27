# Labeled continuous recordings

**Recommendation for the first new recording:** keep it whole as a separate
**streaming development-validation session** and replay the frozen alpha over it.
Do not immediately fit on its frames or divide it into three equal pieces. Its
first job is to reveal live-stream failures that the existing episode benchmark
cannot measure. Once it guides model/threshold changes, it is development
validation, not an untouched final test.

Prefer splitting **by independently collected capture session** as more footage
arrives: training sessions, development-validation sessions and later a sealed
test session. Nearby video frames and neighboring windows are correlated;
randomly shuffling them across partitions gives overly optimistic estimates.
[Scikit-learn's grouped/time-dependent evaluation guidance](https://scikit-learn.org/stable/modules/cross_validation.html).
Our existing 61 test episodes remain reserved; this plan does not reshuffle them.

If one recording is all that is available and it must supply fitting data, an
explicit same-session fallback is chronological, disjoint blocks with guard
regions and no shared frames/windows across boundaries. Choose those regions
before tuning, based on model/preprocessor history (including decaying state).
Reset at split boundaries and warm up using data from that split only. This
remains a same-session diagnostic; do not call it evidence for new environments.
Reserve a future independently recorded session for final testing. Do not tune
on test results. [Test-set isolation guidance](https://scikit-learn.org/stable/common_pitfalls.html).

## Preserve the stream

- Keep timestamps, original video, native sensor streams and a stable session ID.
  Storage may use consecutive video parts, but a manifest must preserve their
  timing and gaps. File boundaries must not reset inference state.
- Label every squeeze/release in verified coverage intervals, plus initial jaw
  state if known. Long stretches with **no events** are valuable examples too.
  Missing annotation is not automatically a confirmed negative.
- Keep model predictions separate from human/button references. Do not use the
  alpha's own flashes as ground truth. The exact physical-button delay remains
  unmeasured; button callbacks are references when that is the chosen label source.
- Retain failed pickups, empty squeezes, partial closures, camera movement,
  lengthy holds, walking and bucket handling. A squeeze is independent of whether
  trash is successfully collected or deposited.

Illustrative future annotation format (not a currently accepted training manifest):

```json
{
  "schema": "jaw-continuous-annotations-v1",
  "session_id": "field-session-001",
  "time_base": "seconds from session start, mapped to capture monotonic clock",
  "initial_jaw_state": "unknown",
  "coverage": [{"start": 0.0, "end": 300.0, "all_events_verified": true}],
  "events": [
    {"kind": "squeeze", "time_seconds": 12.34},
    {"kind": "release", "time_seconds": 18.90},
    {"kind": "squeeze", "time_seconds": 42.10},
    {"kind": "release", "time_seconds": 48.20}
  ]
}
```

## Training and evaluation changes needed before using it in RSI

The current adapter expects one `close`/`open` pair per episode. **It does not
yet ingest arbitrary event lists or train on continuous sessions.** Adding this
requires a new versioned domain adapter and evaluation context, not silently
calling the old one-pair scorer on a long video.

For training, derive varied causal windows **only from training sessions**;
include no-event windows and varying event positions/counts. Do not recreate a
fixed three-second squeeze cue, fixed-length one-pair quota, or known-open reset
at every event. Stateful training can use truncated chunks with explicit reset
and warmup rules; evaluation must preserve the actual stream behavior.

For validation/test, load in manageable chunks while keeping **one detector
instance per continuous session**, until an explicitly logged interruption.
Score arbitrary numbers of events with same-kind one-to-one matches within the
frozen tolerance (currently ±0.5 seconds). Report squeeze/release precision,
recall and F1, false events per verified no-event minute, event timing errors,
missed inference deadlines and reset/gap counts. Separate data-loading chunks
from model resets. Report continuous results separately from old clip-replay
scores until all candidates are evaluated under the new protocol.

An hour-long file is not required to begin this check: an uninterrupted multi-event
sample with verified idle periods can uncover useful failures. Longer field use
will still be needed to assess reliability, heat, battery and changing conditions.

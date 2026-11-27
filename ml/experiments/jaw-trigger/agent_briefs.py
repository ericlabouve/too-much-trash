"""Generate shared evolutionary briefs with jaw-trigger evaluation guidance."""

from pathlib import Path
import sys

from joint_fitness import (
    DETECTOR_FRAME_SHARE, FITNESS_WEIGHTS, FRAME_TIME_MS, FULL_SPEED_CREDIT_MS, MATCH_SECONDS,
    PHONE_TARGET_FPS,
)

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
from ml.evolution.agent_briefs import main


if __name__ == "__main__":
    main(context=(
        "Propose new detector code, custom policies, trained models, SVMs, or other methods. "
        "Use video, IMU, ARKit, or any available runtime sensor data, alone or in combination. "
        "Spend more compute when it can improve accuracy. "
        "The jaw-event success target is 0.95 F1. Report squeeze and release results separately "
        "to show what is holding back the combined score. "
        f"Fitness weights jaw F1 at {FITNESS_WEIGHTS['jaw_f1']:.0%} "
        f"and measured laptop jaw p95 speed at {FITNESS_WEIGHTS['speed_score']:.0%}. "
        "Deposit outcomes are diagnostic only. Propose changes that improve jaw detection. "
        f"Jaw F1 matches each squeeze or release once to a button cue of the same type within "
        f"{MATCH_SECONDS:g} seconds at confirmation time. Duplicate and mistimed detections count "
        "as false positives, and unmatched cues count as misses. F1 is twice the number of matches "
        "divided by twice the matches plus misses and false positives. "
        f"The phone target is {PHONE_TARGET_FPS} fps, or {FRAME_TIME_MS:.2f} ms per frame. "
        f"Laptop p95 gets full speed credit through {FULL_SPEED_CREDIT_MS:.2f} ms per prepared frame "
        f"({DETECTOR_FRAME_SHARE:.0%} of a phone frame), then falls linearly to zero at "
        f"{FRAME_TIME_MS:.2f} ms. The fitness benchmark counts jaw feature extraction and "
        "event logic on prepared frames. Budget separately for frame preparation and verify "
        "phone performance on-device. Report estimated or measured laptop p95 and the expected "
        "accuracy gain. For expensive conditional work, estimate how often it runs and its latency. "
        "Describe the implementation, training data, and expected accuracy and latency tradeoff. "
        "Report the full-fit replay separately from withheld capture blocks. When validating a "
        "block, fit the model and choose decoder settings entirely within the other blocks. "
        "Avoid clip identity, elapsed clip time, and labels at inference."
    ))

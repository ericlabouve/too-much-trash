"""Replay a frozen jaw candidate on the development corpus and score supplied deposit predictions."""

import argparse
import json
from pathlib import Path

import cv2
import numpy as np
from joint_fitness import FITNESS_WEIGHTS, deposit_metrics, fitness_for
from round_one import Candidate, detector_speed_score, features, load_frames, measure_events, score


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("baseline", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--button-proxy", action="store_true", help=argparse.SUPPRESS)
    parser.add_argument("--deposit-predictions", type=Path,
                        help="JSON with predictions keyed by clip ID and measured joint p95_ms")
    args = parser.parse_args()
    manifest = json.loads(args.manifest.read_text())
    clips = manifest["clips"]
    reference_key = "button_cue_seconds"
    labels = [{"close": row["jaw_reference"]["squeeze"][reference_key],
               "open": row["jaw_reference"]["release"][reference_key]} for row in clips]
    if any(not 0 <= pair["close"] < pair["open"] for pair in labels):
        parser.error("Each clip requires a squeeze followed by release")
    deposit = None
    if args.deposit_predictions:
        data = json.loads(args.deposit_predictions.read_text())
        predictions = data["predictions"]
        if predictions.keys() != {clip["clip"] for clip in clips}:
            parser.error("Deposit prediction IDs must match the development manifest")
        deposit = deposit_metrics([predictions[clip["clip"]] for clip in clips],
                                  [clip["deposit"] for clip in clips])
        joint_p95 = data["p95_ms"]
    baseline = json.loads(args.baseline.read_text())
    candidate = Candidate(**baseline["ranked"][0]["candidate"])
    if candidate.method != "linear_hog_median":
        parser.error("This development replay expects the frozen Round 23 video-only champion")
    base = args.manifest.parent
    cv2.setNumThreads(1)
    measured = []
    for clip in clips:
        measured.append(features(candidate.method, load_frames(base / clip["video"]),
                                 candidate.signal, parameters=baseline.get("feature_parameters")))
    jaw_predictions, jaw_times = measure_events(candidate, measured)
    result = score(candidate, measured, labels, predictions=jaw_predictions)
    jaw_p95 = float(np.percentile(np.concatenate(jaw_times), 95))
    result.update(reference=reference_key, reporting="in_sample", clip_count=len(clips),
                  p95_ms=jaw_p95, speed_score=detector_speed_score(jaw_p95),
                  fitness_weights=FITNESS_WEIGHTS)
    result["fitness"] = fitness_for(result)
    if deposit is not None:
        result.update(deposit=deposit, joint_p95_ms=joint_p95)
    args.output.write_text(json.dumps(result, indent=2) + "\n")


if __name__ == "__main__":
    main()

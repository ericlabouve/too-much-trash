"""Publish local video and event timelines from an already scored round."""

import argparse
import json
from pathlib import Path
from tempfile import NamedTemporaryFile

import av
import cv2

from round_one import Candidate, motion_samples, events, features, load_frames


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("clips", type=Path)
    parser.add_argument("labels", type=Path)
    parser.add_argument("results", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--imu", type=Path)
    args = parser.parse_args()
    result = json.loads(args.results.read_text())
    labels = json.loads(args.labels.read_text())
    candidates = {}
    for group in ("ranked", "challengers", "pruned_scores", "incumbents"):
        for entry in result.get(group, []):
            candidate = Candidate(**entry["candidate"])
            candidates.setdefault(candidate.name, candidate)
    development = result["development_clips"]
    comparison = result["held_out_clips"]
    names = development + comparison
    sidecars = json.loads(args.imu.read_text()) if args.imu else []
    if any(candidate.method in {"imu", "gyro_flow", "accel_gradient", "gyro_gradient_veto"} for candidate in candidates.values()) and len(sidecars) != len(names):
        parser.error("The replay requires one IMU sidecar per clip in filename order")
    imu = dict(zip(sorted(names), map(motion_samples, sidecars), strict=True)) if sidecars else {}
    cv2.setNumThreads(1)
    args.output.mkdir(parents=True, exist_ok=True)
    clips = []
    for index, name in enumerate(names, 1):
        if Path(name).name != name or Path(name).suffix != ".mp4":
            parser.error(f"Invalid clip filename {name!r}")
        source = (args.clips / name).resolve(strict=True)
        frames = load_frames(source)
        with av.open(str(source)) as container:
            duration = container.duration / av.time_base
        measurements, predictions = {}, {}
        for candidate in candidates.values():
            key = candidate.method, candidate.signal
            if key not in measurements:
                measurements[key] = features(
                    candidate.method, frames, candidate.signal, imu.get(name), result.get("feature_parameters")
                )[0]
            predictions[candidate.name] = events(candidate, measurements[key], result.get("confirmation_time", False))
        video_name = f"clip-{index}.mp4"
        link = args.output / video_name
        if link.is_symlink() and link.resolve() != source:
            link.unlink()
        if not link.exists():
            link.symlink_to(source)
        elif not link.is_symlink() or link.resolve() != source:
            raise FileExistsError(link)
        split = "Fitting" if result.get("fit_all_clips") else ("Development" if name in development else "Comparison")
        clips.append({"name": f"Clip {index}", "split": split,
                      "video": video_name, "duration": duration,
                      "references": list(labels[name].items()), "predictions": predictions})

    replay = {"round": result["round"], "candidates": list(candidates), "clips": clips}
    with NamedTemporaryFile(mode="w", dir=args.output, prefix=".replay-", suffix=".json", delete=False) as pending:
        json.dump(replay, pending)
    Path(pending.name).replace(args.output / "events.json")


if __name__ == "__main__":
    main()

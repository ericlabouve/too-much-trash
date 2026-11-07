"""Export local, identical grayscale crops for the laptop and iPhone benchmark."""

import argparse
import json
from pathlib import Path

from round_one import load_frames


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("clips", type=Path)
    parser.add_argument("result", type=Path)
    parser.add_argument("fixtures", type=Path)
    args = parser.parse_args()
    result = json.loads(args.result.read_text())
    coefficients = result["feature_parameters"]["linear_hog"]
    clips = result["development_clips"]
    if len(clips) != 5 or len(coefficients) != 33:
        parser.error("Use a five-clip result with a fitted HOG projection")
    args.fixtures.mkdir(parents=True, exist_ok=True)
    fixtures = []
    for index, clip in enumerate(clips, 1):
        if Path(clip).name != clip:
            parser.error("Use clip filenames without directories")
        frames = load_frames(args.clips / clip)
        name = f"clip-{index}.bin"
        (args.fixtures / name).write_bytes(b"".join(frame[105:207, 148:207].tobytes() for _, frame in frames))
        fixtures.append({"file": name, "timestamps": [timestamp for timestamp, _ in frames]})
    (args.fixtures / "fixtures.json").write_text(json.dumps(fixtures))
    (args.fixtures / "projection.json").write_text(json.dumps(coefficients))


if __name__ == "__main__":
    main()

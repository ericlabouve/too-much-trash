"""Summarize the original iPhone sidecars without altering their timebase."""

import json
import math
import re
from pathlib import Path

EPISODE_KEY = re.compile(r"originals/([^/]+)/client-[^/]+/episode-([0-9a-f]{64})")
IMU_STREAMS = ("accelerometer", "gyroscope", "attitude")
POSE_STREAMS = ("camera_pose",)
MAX_RECORD_BYTES = 64 * 1024


def episode_sidecar_prefix(capture_id: str, original_key: str) -> str | None:
    match = EPISODE_KEY.fullmatch(original_key)
    if match and match[1] == capture_id:
        return f"episodes/{capture_id}/{match[2]}"
    return None


def scan_samples(path: Path, names: tuple[str, ...]) -> tuple[dict, dict]:
    streams = {name: {"samples": 0, "timestamp_reversals": 0} for name in names}
    previous = {}
    diagnostics = {"invalid_rows": 0, "missing_markers": 0, "scan_truncated": False}
    with path.open("rb") as source:
        while line := source.readline(MAX_RECORD_BYTES + 1):
            if len(line) > MAX_RECORD_BYTES:
                diagnostics["invalid_rows"] += 1
                diagnostics["scan_truncated"] = True
                break
            try:
                record = json.loads(line)
                if record.get("type") == "missing":
                    diagnostics["missing_markers"] += 1
                    continue
                sample = record["sample"]
                stream = "camera_pose" if names == POSE_STREAMS else sample["stream"]
                timestamp = record["commonTime"]
                if (not isinstance(sample, dict) or type(timestamp) not in (float, int)
                        or not math.isfinite(timestamp)):
                    raise ValueError("Invalid sample")
                summary = streams[stream]
            except (AttributeError, KeyError, TypeError, ValueError, OverflowError):
                diagnostics["invalid_rows"] += 1
                continue
            summary["samples"] += 1
            summary["first"] = min(timestamp, summary.get("first", timestamp))
            summary["last"] = max(timestamp, summary.get("last", timestamp))
            if stream in previous and timestamp < previous[stream]:
                summary["timestamp_reversals"] += 1
            previous[stream] = timestamp
    return streams, diagnostics


def summarize_episode(directory: Path) -> dict:
    manifest = json.loads((directory / "manifest.json").read_bytes())
    metadata = manifest["sensor_metadata"]
    imu, imu_diagnostics = scan_samples(directory / "imu.jsonl", IMU_STREAMS)
    poses, pose_diagnostics = scan_samples(directory / "poses.jsonl", POSE_STREAMS)
    gaps = metadata.get("gaps")
    return {
        "version": 1,
        "capture_reported_complete": manifest["complete"],
        "clock_alignment": "validated" if metadata.get("nativeClockAlignment") == "validated" else "unverified",
        "capture_reported_gap_count": len(gaps) if isinstance(gaps, list) else None,
        "streams": imu | poses,
        "sidecars": {"imu": imu_diagnostics, "poses": pose_diagnostics},
    }

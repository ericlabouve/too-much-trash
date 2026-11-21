"""Bounded, local frame extraction for review agents; no installs or model calls."""
import argparse
import json
import math
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import time


def find_ffmpeg():
    candidates = [shutil.which('ffmpeg'), '/opt/homebrew/bin/ffmpeg', '/usr/local/bin/ffmpeg',
                  '/Applications/Descript.app/Contents/Resources/app.asar.unpacked/node_modules/beamcoder/build/Release/ffmpeg']
    for candidate in dict.fromkeys(candidates):
        if candidate and Path(candidate).is_file():
            try:
                subprocess.run([candidate, '-version'], check=True, capture_output=True, timeout=5)
                return str(Path(candidate).resolve())
            except (OSError, subprocess.SubprocessError):
                pass
    return None


def prepare_tool(video, scratch):
    """Give each worker a fixed input and an already resolved executable."""
    executable = find_ffmpeg()
    if not executable:
        return None
    helper = scratch / 'inspect_frames.py'
    helper.write_bytes(Path(__file__).read_bytes())
    config = scratch / 'frame-tool.json'
    config.write_text(json.dumps(dict(video=str(video.resolve()), scratch=str(scratch.resolve()),
                                     ffmpeg=executable), indent=2))
    return helper, config


def extract(config, timestamps):
    if not 1 <= len(timestamps) <= 12 or any(not math.isfinite(t) or t < 0 for t in timestamps):
        raise ValueError('Request 1–12 finite, nonnegative timestamps in video seconds')
    scratch = Path(config['scratch']).resolve()
    output = Path(tempfile.mkdtemp(prefix='frames-', dir=scratch))
    records = []
    deadline = time.monotonic() + 60
    for index, timestamp in enumerate(timestamps):
        frame = output / f'frame-{index:02d}.jpg'
        # Decode source timestamps from the beginning, selecting the first frame
        # at/after the request. showinfo supplies actual PTS instead of implying
        # that a requested timestamp is the exact decoded timestamp.
        command = [config['ffmpeg'], '-hide_banner', '-nostdin', '-i', config['video'],
                   '-vf', f'select=gte(t\\,{timestamp:.9f}),showinfo', '-vsync', '0',
                   '-frames:v', '1', '-q:v', '2', '-update', '1', str(frame)]
        remaining = deadline - time.monotonic()
        if remaining <= 0:
            raise ValueError('Frame inspection exceeded its 60-second budget; use the overview and report the limitation')
        result = subprocess.run(command, capture_output=True, text=True, timeout=min(20, remaining))
        match = re.search(r'\bpts_time:([0-9.eE+-]+)', result.stderr)
        if result.returncode or not frame.exists() or not match:
            raise ValueError('Could not decode the requested frame (possibly beyond the video end). '
                             'Do not search for other decoders; use the overview and disclose the limitation.')
        records.append(dict(file=str(frame), requested_seconds=timestamp, actual_seconds=float(match[1])))
    manifest = output / 'frames.json'
    manifest.write_text(json.dumps(records, indent=2))
    return dict(manifest=str(manifest), frames=records)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--config', type=Path, required=True)
    parser.add_argument('--times', type=float, nargs='+', required=True)
    args = parser.parse_args()
    try:
        print(json.dumps(extract(json.loads(args.config.read_text()), args.times), indent=2))
    except (OSError, ValueError, subprocess.SubprocessError) as error:
        parser.exit(1, f'Frame inspection failed: {error}\n')


if __name__ == '__main__':
    main()

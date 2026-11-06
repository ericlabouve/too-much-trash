"""Retrieve a tiny annotated egocentric pickup subset via HTTP tar ranges.

The source dataset's non-commercial license permits evaluation use. Keep the
downloaded videos and license outside Git; do not redistribute them.
"""

import argparse
import csv
import io
import json
from pathlib import Path
import tarfile
import zipfile

import httpx

BASE = 'https://ai2-public-datasets.s3-us-west-2.amazonaws.com/charades/'
ARCHIVE = BASE + 'CharadesEgo_v1_480.tar'
LICENSE = 'https://prior.allenai.org/projects/data/charades-ego/license.txt'
OBJECT_PROMPTS = ('cup', 'glass', 'bottle', 'book', 'box', 'bag', 'phone', 'paper', 'towel')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output', type=Path)
    parser.add_argument('--count', type=int, default=3)
    args = parser.parse_args()
    if not 1 <= args.count <= 10:
        parser.error('--count must be between 1 and 10')
    args.output.mkdir(parents=True, exist_ok=True)
    with httpx.Client(follow_redirects=True, timeout=60) as client:
        response = client.get(BASE + 'CharadesEgo.zip')
        response.raise_for_status()
        with zipfile.ZipFile(io.BytesIO(response.content)) as annotations:
            names = annotations.namelist()
            classes_name = next(n for n in names if n.endswith('Charades_v1_classes.txt'))
            classes = dict(line.split(' ', 1) for line in annotations.read(classes_name).decode().splitlines())
            rows = {}
            for name in names:
                if name.endswith(('_train.csv', '_test.csv')):
                    for row in csv.DictReader(io.StringIO(annotations.read(name).decode())):
                        if row['id'].endswith('EGO'):
                            rows[row['id']] = row
        license_response = client.get(LICENSE)
        license_response.raise_for_status()
        (args.output / 'license.txt').write_text(license_response.text)

        def get_range(start, size):
            with client.stream('GET', ARCHIVE, headers={'Range': f'bytes={start}-{start + size - 1}'}) as response:
                response.raise_for_status()
                if response.status_code != 206 or not response.headers.get('content-range', '').startswith(f'bytes {start}-'):
                    raise RuntimeError('Server did not honor byte range; refusing the full archive')
                data = response.read()
                if len(data) != size:
                    raise RuntimeError('Unexpected byte range length')
                return data

        offset = 0
        selected = []
        prompts = set()
        for _ in range(1200):
            header = get_range(offset, 512)
            if not any(header):
                break
            entry = tarfile.TarInfo.frombuf(header, 'utf-8', 'strict')
            video_id = Path(entry.name).stem
            row = rows.get(video_id)
            if entry.isfile() and row:
                actions = []
                for event in row['actions'].split(';'):
                    if not event:
                        continue
                    code, start, end = event.split()
                    label = classes[code]
                    objects = [p for p in OBJECT_PROMPTS if p in label.lower()]
                    if label.startswith('Taking ') and objects and 'picture' not in label.lower():
                        actions.append({'class': code, 'label': label, 'prompt': objects[0], 'start': float(start), 'end': float(end)})
                if actions:
                    action = next((a for a in actions if a['label'] not in prompts), actions[0])
                    if action['label'] not in prompts:
                        if entry.size > 30_000_000:
                            raise RuntimeError('Unexpectedly large sample video')
                        dest = args.output / f'{video_id}.mp4'
                        dest.write_bytes(get_range(offset + 512, entry.size))
                        selected.append({'id': video_id, 'path': str(dest.resolve()), 'source_archive': ARCHIVE, 'tar_offset': offset + 512, 'bytes': entry.size, 'action': action, 'script': row['script'], 'length': float(row['length'])})
                        prompts.add(action['label'])
                        print(json.dumps(selected[-1]), flush=True)
                        if len(selected) == args.count:
                            break
            offset += 512 + ((entry.size + 511) // 512) * 512
    manifest = {'dataset': 'Charades-Ego', 'source': 'https://prior.allenai.org/projects/charades-ego', 'license': LICENSE, 'videos': selected}
    (args.output / 'manifest.json').write_text(json.dumps(manifest, indent=2))
    if len(selected) != args.count:
        raise SystemExit(f'Only retrieved {len(selected)} videos')


if __name__ == '__main__':
    main()

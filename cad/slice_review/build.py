"""Package an audited slice's report and actual toolpaths as a standalone viewer.

CLI consumes the same report.json/paths.json schema used by the actuator audit.
The Python exporter accepts any part count, bed polygon, and ordered layer set.
This does not slice, validate G-code semantics, or contact a printer.
"""
import argparse
from collections import defaultdict
import json
import math
from pathlib import Path
import shutil
import struct

ASSETS = Path(__file__).parent
COLORS = {'model': '#d78942', 'support': '#1786cf', 'interface': '#953bc2', 'adhesion': '#58a36c'}


def save(path, value):
    path.write_text(json.dumps(value, indent=2, allow_nan=False) + '\n')


def export_toolpaths(output, segments, objects, bed_polygon):
    """Segments: (height_mm, object_key, role, (x1,y1), (x2,y2)).

    Parse G-code upstream, including G2/G3 interpolation or explicitly reject arcs.
    Coordinates are real millimetres. Object keys must be unique per instance.
    """
    output = Path(output)
    output.mkdir(parents=True, exist_ok=True)
    segments = list(segments)
    if not segments:
        raise ValueError('No extrusion paths to display')
    for h, name, role, p, q in segments:
        if name not in objects or role not in COLORS:
            raise ValueError(f'Unknown object or path role: {name}, {role}')
        if not all(math.isfinite(v) for v in (h, *p, *q)):
            raise ValueError('Non-finite path coordinate')
    heights = sorted({s[0] for s in segments})
    paths = {}
    for role, color in COLORS.items():
        selected = sorted((s for s in segments if s[2] == role), key=lambda s: s[0])
        payload = bytearray()
        counts = defaultdict(int)
        for h, _, _, p, q in selected:
            payload.extend(struct.pack('<6f', *p, h, *q, h))
            counts[h] += 2
        (output / f'{role}.bin').write_bytes(payload)
        end = 0
        ends = []
        for h in heights:
            end += counts[h]
            ends.append(end)
        paths[role] = {'file': f'{role}.bin', 'ends': ends, 'color': color}
    data = {'schema_version': 1, 'heights': heights, 'paths': paths,
            'objects': objects, 'bed_polygon_mm': bed_polygon}
    save(output / 'paths.json', data)
    return data


def validate_paths(data, directory):
    heights = data['heights']
    if not heights or heights != sorted(set(heights)) or not all(math.isfinite(h) for h in heights):
        raise ValueError('Heights must be nonempty, finite, unique and ascending')
    for name, path in data['paths'].items():
        filename = path['file']
        if Path(filename).name != filename:
            raise ValueError('Binary path must be a local basename')
        size = (directory / filename).stat().st_size
        ends = path['ends']
        if (size % 24 or len(ends) != len(heights) or ends != sorted(ends)
                or any(not isinstance(v, int) or v < 0 or v % 2 for v in ends)
                or ends[-1] != size // 12):
            raise ValueError(f'Invalid path buffer/counts: {name}')
    if not data['objects']:
        raise ValueError('No objects supplied')


def write_page(output, *, title='Plate slice review', subtitle='', notes=(), links=()):
    """Write reusable assets alongside review.json and paths.json.

    Notes are plain text. Links are local relative paths supplied by the caller.
    No stale claims about whether the physical job started are embedded.
    """
    output = Path(output)
    data = json.loads((output / 'paths.json').read_text())
    validate_paths(data, output)
    json.loads((output / 'review.json').read_text())
    save(output / 'viewer.json', {'title': title, 'subtitle': subtitle,
                                  'notes': list(notes), 'links': list(links)})
    for filename in ('index.html', 'viewer.js', 'viewer.css'):
        shutil.copyfile(ASSETS / filename, output / filename)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--job', type=Path, required=True, help='Audited directory containing review.json, paths.json, and path binaries')
    parser.add_argument('--output', type=Path, required=True, help='New directory; historical files are never replaced')
    parser.add_argument('--title', default='Plate slice review')
    parser.add_argument('--subtitle', default='Actual sliced extrusion paths')
    parser.add_argument('--bed-size', nargs=2, type=float, metavar=('X_MM', 'Y_MM'), help='Explicit rectangular bed for legacy paths without a bed polygon')
    args = parser.parse_args()
    job, output = args.job.resolve(), args.output.resolve()
    data = json.loads((job / 'paths.json').read_text())
    validate_paths(data, job)
    if args.bed_size:
        x, y = args.bed_size
        if not all(math.isfinite(v) and v > 0 for v in (x, y)):
            parser.error('Bed dimensions must be finite and positive')
        data['bed_polygon_mm'] = [[0, 0], [x, 0], [x, y], [0, y]]
    if not data.get('bed_polygon_mm'):
        parser.error('Supply --bed-size for a legacy job without bed geometry')
    output.mkdir(parents=True, exist_ok=False)
    shutil.copyfile(job / 'review.json', output / 'review.json')
    save(output / 'paths.json', data)
    for path in data['paths'].values():
        shutil.copyfile(job / path['file'], output / path['file'])
    write_page(output, title=args.title, subtitle=args.subtitle)
    print(output / 'index.html')


if __name__ == '__main__':
    main()

#!/usr/bin/env python3
"""Plan and run supported CAD tasks in disposable, isolated source snapshots."""
from __future__ import annotations

import argparse
import hashlib
import json
from functools import partial
from http.server import ThreadingHTTPServer
from pathlib import Path
import shutil
import shlex
import subprocess
import sys
from datetime import datetime, timezone

CAD = Path(__file__).resolve().parent
V3_ASSET = Path('versions/v3/source/clip_current/clip.stl')
VERSIONS = {
    'v1': {'source': 'source', 'viewer': 'viewer-v1.html', 'check': 'check_design.py',
           'report': 'print/validation.json'},
    'v2': {'source': 'versions/v2/source', 'viewer': 'versions/v2/viewer.html',
           'check': 'workspace_check.py', 'report': 'versions/v2/review/workspace-validation.json'},
    'v3': {'source': 'versions/v3/source', 'viewer': 'versions/v3/viewer.html',
           'check': 'workspace_check.py', 'report': 'versions/v3/review/workspace-validation.json'},
}


def output_path(version: str, operation: str, requested: str | None) -> Path:
    if requested:
        raw = Path(requested).expanduser()
        if raw.is_symlink():
            raise ValueError(f'output is a symlink: {raw}')
        path = raw.resolve()
    else:
        stamp = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%fZ')
        path = CAD / 'build' / version / f'{operation}-{stamp}'
    # Never allow a snapshot to replace any existing file or directory. Protect
    # the checked-in CAD tree even if the requested path does not exist yet.
    if path.exists() or path.is_symlink():
        raise ValueError(f'output already exists: {path}; choose a new path')
    if path == CAD or (CAD in path.parents and CAD / 'build' not in path.parents):
        raise ValueError('output inside cad/ must be under cad/build/')
    if path in CAD.parents:
        raise ValueError('output cannot be an ancestor of the CAD directory')
    return path


def describe(version: str, operation: str, dest: Path) -> tuple[Path, Path]:
    data = VERSIONS[version]
    cwd = dest / data['source']
    script = 'build.py' if operation == 'build' else data['check']
    print(f'Operation: {operation} {version}')
    print(f'Snapshot: {dest}')
    print(f'Copy: {CAD / "source"} -> {dest / "source"}')
    if version != 'v1':
        print(f'Copy: {CAD / data["source"]} -> {cwd}')
    if version != 'v1':
        print(f'Copy: {CAD / "workspace/check.py"} -> {cwd / "workspace_check.py"}')
    print(f'Working directory: {cwd}')
    command = [sys.executable, script] + ([version] if operation == 'check' and version != 'v1' else [])
    print(f'Command: {shlex.join(command)}')
    if operation == 'build':
        root = dest if version == 'v1' else dest / 'versions' / version
        print(f'Outputs: {root / "print"}' + (f', {root / "review"}, {root / "bom.md"}' if version != 'v1' else ''))
    else:
        print(f'Report: {dest / data["report"]}')
    print('Prerequisites: Python 3.12 and the CAD environment (cadquery, trimesh, matplotlib, shapely, scipy); source assets in snapshot.')
    print(f'Provenance: {dest / "workspace-run.json"}')
    if operation == 'check':
        print('Check scope: ' + {'v1': 'sampled design and rocker motion', 'v2': 'active build solid and sampled configuration checks', 'v3': 'active build solid and sampled configuration checks; phone fit conflicts are reported separately'}[version])
    print('Results are geometric checks or prototype exports, not physical validation; no slicing or printer operation.')
    return cwd, Path(script)


def snapshot(version: str, dest: Path) -> None:
    # copytree follows no source symlinks: an unexpected symlink is rejected
    # rather than allowing a builder to write through it into the repository.
    sources = [Path('source')]
    if version != 'v1':
        sources.append(Path(VERSIONS[version]['source']))
    for source in sources:
        for path in (CAD / source).rglob('*'):
            if path.is_symlink():
                raise ValueError(f'source contains symlink: {path}')
    dest.mkdir(parents=True, exist_ok=False)
    for source in sources:
        shutil.copytree(CAD / source, dest / source,
                        ignore=shutil.ignore_patterns('__pycache__', '*.pyc', '.DS_Store'))
    root = dest if version == 'v1' else dest / 'versions' / version
    if version != 'v1':
        shutil.copy2(CAD / 'workspace/check.py', dest / VERSIONS[version]['source'] / 'workspace_check.py')
    if version == 'v3' and not (dest / V3_ASSET).is_file():
        raise ValueError(f'missing required source asset: {CAD / V3_ASSET}')
    (root / 'print').mkdir(exist_ok=True)
    if version != 'v1':
        (root / 'review').mkdir(exist_ok=True)


def parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(description=__doc__)
    sub = p.add_subparsers(dest='command', required=True)
    sub.add_parser('list', help='list supported versions, checks and viewers')
    sub.add_parser('artifacts', help='list or restore preserved historical artifacts')
    inventory = sub.add_parser('inventory', help='summarize workspace files and classifications')
    inventory.add_argument('--git', action='store_true')
    inventory.add_argument('--tracked-only', action='store_true')
    inventory.add_argument('--json', nargs='?', const='-', metavar='FILE')
    explain = sub.add_parser('explain', help='explain a workspace path classification')
    explain.add_argument('path')
    for command in ('plan', 'build', 'check'):
        q = sub.add_parser(command, help='show a plan' if command == 'plan' else f'{command} in a new isolated snapshot')
        q.add_argument('version', choices=VERSIONS)
        if command == 'plan':
            q.add_argument('--operation', choices=('build', 'check'), default='build')
        q.add_argument('--output', help='new snapshot directory (default: unique cad/build/<version>/ directory)')
    q = sub.add_parser('build-site', help='build an isolated viewer site')
    q.add_argument('--versions', nargs='+', choices=[*VERSIONS, 'all'], default=['all'])
    q.add_argument('--output', help='new directory under cad/build/ (default: unique cad/build/site directory)')
    q = sub.add_parser('serve', help='serve a viewer site on loopback')
    q.add_argument('version', choices=VERSIONS, nargs='?', default='v3')
    q.add_argument('--port', type=int, default=8765)
    q.add_argument('--site', help='built site directory; omit to serve the legacy CAD tree')
    return p


def main() -> int:
    if len(sys.argv) > 1 and sys.argv[1] == 'artifacts':
        from workspace import artifacts
        return artifacts.main(sys.argv[2:])
    args = parser().parse_args()
    if args.command in ('inventory', 'explain'):
        import workspace_inventory
        if args.command == 'explain':
            return workspace_inventory.main(['--explain', args.path])
        options = (['--git'] if args.git else []) + (['--tracked-only'] if args.tracked_only else [])
        if args.json is not None:
            options += ['--json', args.json]
        return workspace_inventory.main(options)
    if args.command == 'list':
        for version, data in VERSIONS.items():
            check = f'{data["source"]}/{data["check"]}' if version == 'v1' else f'workspace/check.py {version} (copied into snapshot)'
            print(f'{version}: viewer={data["viewer"]}; build={data["source"]}/build.py; check={check}')
        return 0
    if args.command == 'build-site':
        from workspace.site import build_site
        versions = list(VERSIONS) if 'all' in args.versions else list(dict.fromkeys(args.versions))
        dest = output_path('site', 'site', args.output)
        if CAD / 'build' not in dest.parents:
            raise ValueError('site output must be a new directory under cad/build/ for artifact restoration')
        return build_site(CAD, dest, versions, VERSIONS)
    if args.command == 'serve':
        if not 0 <= args.port <= 65535:
            raise ValueError('port must be between 0 and 65535')
        from workspace.site import SiteHandler
        root = Path(args.site).expanduser().resolve() if args.site else CAD
        if not (root / VERSIONS[args.version]['viewer']).is_file():
            raise ValueError(f'missing viewer in {root}; run build-site --versions all and serve --site PATH')
        manifest = root / ('print/manifest.json' if args.version == 'v1' else f'versions/{args.version}/review/manifest.json')
        if not manifest.is_file():
            raise ValueError(f'missing viewer manifest {manifest}; run build-site --versions all and serve --site PATH')
        if not args.site:
            print('Serving legacy tree; if assets are missing, run build-site --versions all or restore historical artifacts.', flush=True)
        handler = partial(SiteHandler, directory=str(root))
        with ThreadingHTTPServer(('127.0.0.1', args.port), handler) as server:
            print(f'Open http://127.0.0.1:{server.server_port}/viewer.html?version={args.version}', flush=True)
            try:
                server.serve_forever()
            except KeyboardInterrupt:
                pass
        return 0
    operation = args.operation if args.command == 'plan' else args.command
    dest = output_path(args.version, operation, args.output)
    cwd, script = describe(args.version, operation, dest)
    if args.command == 'plan':
        return 0
    snapshot(args.version, dest)
    manifest_path = dest / 'workspace-run.json'
    inputs = {}
    for source in (dest / 'source', dest / VERSIONS[args.version]['source']):
        for path in source.rglob('*'):
            if path.is_file():
                inputs[str(path.relative_to(dest))] = hashlib.sha256(path.read_bytes()).hexdigest()
    if args.version == 'v3':
        inputs[str(V3_ASSET)] = hashlib.sha256((dest / V3_ASSET).read_bytes()).hexdigest()
    environment_files = {p.name: hashlib.sha256(p.read_bytes()).hexdigest()
                         for p in (CAD / 'pyproject.toml', CAD / 'uv.lock')}
    manifest = {'version': args.version, 'operation': operation,
                'source_sha256': inputs, 'environment_sha256': environment_files, 'working_directory': str(cwd),
                'command': [sys.executable, str(script)] + ([args.version] if operation == 'check' and args.version != 'v1' else []), 'python': sys.version,
                'started_utc': datetime.now(timezone.utc).isoformat(), 'status': 'running'}
    manifest_path.write_text(json.dumps(manifest, indent=2) + '\n')
    print('Running in isolated snapshot...', flush=True)
    result = subprocess.run(manifest['command'], cwd=cwd, check=False)
    manifest.update(status='completed' if result.returncode == 0 else 'failed',
                    returncode=result.returncode, finished_utc=datetime.now(timezone.utc).isoformat())
    manifest_path.write_text(json.dumps(manifest, indent=2) + '\n')
    return result.returncode


if __name__ == '__main__':
    try:
        raise SystemExit(main())
    except (OSError, ValueError) as exc:
        print(f'cad: {exc}', file=sys.stderr)
        raise SystemExit(2)

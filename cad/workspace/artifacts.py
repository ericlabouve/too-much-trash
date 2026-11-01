#!/usr/bin/env python3
"""Restore exact historical CAD artifacts from the pinned Git commit."""
import argparse
import hashlib
import json
import os
from pathlib import Path, PurePosixPath
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[2]
MANIFEST = ROOT / 'cad/workspace-artifacts.json'


def fail(message):
    raise ValueError(message)


def no_symlinks(path):
    # Reject symlinks even when they point back into the approved destination.
    for item in (path, *path.parents):
        if item.is_symlink():
            fail(f'symlink in destination path: {item}')


def digest(path):
    h = hashlib.sha256()
    with path.open('rb') as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b''):
            h.update(chunk)
    return h.hexdigest()


def restore(args):
    manifest = json.loads(MANIFEST.read_text())
    baseline = manifest['baseline']
    entries = {e['path']: e for e in manifest['artifacts']}
    if len(entries) != len(manifest['artifacts']):
        fail('duplicate manifest path')
    if args.site and args.prefix is None and not args.paths:
        fail('--site requires --prefix or explicit paths')
    if args.prefix is not None:
        if args.paths:
            fail('--prefix cannot be combined with explicit paths')
        prefix = args.prefix.rstrip('/')
        if not prefix or not any(name == prefix or name.startswith(prefix + '/') for name in entries):
            fail(f'no artifacts match prefix: {args.prefix}')
        selected = [name for name in entries if name == prefix or name.startswith(prefix + '/')]
    else:
        selected = args.paths or list(entries)
    for name in selected:
        path = PurePosixPath(name)
        if name not in entries or path.is_absolute() or '..' in path.parts or str(path) != name or not name.startswith('cad/'):
            fail(f'not an approved artifact path: {name}')
    if len(set(selected)) != len(selected):
        fail('duplicate requested path')
    # An alternate overlay is deliberately limited to ignored cad/build/.
    destination = Path(os.path.abspath(args.site or args.destination)) if (args.site or args.destination) else ROOT
    allowed = ROOT / 'cad/build'
    if destination != ROOT and (destination == allowed or allowed not in destination.parents):
        fail('destination must be the repository root or a directory under cad/build/')
    no_symlinks(destination)
    for name in selected:
        no_symlinks(destination / (name[4:] if args.site else name))
    check = subprocess.run(['git', 'cat-file', '-e', baseline + '^{commit}'], cwd=ROOT, capture_output=True)
    if check.returncode:
        fail(f'baseline {baseline} is unavailable; fetch that commit from the project Git remote before restoring')
    if args.dry_run:
        print(f'Would restore {len(selected)} artifacts ({sum(entries[p]["size"] for p in selected)} bytes) from {baseline} into {destination}')
        return
    # A live cat-file process streams one object at a time; no shell, archive extraction,
    # or caller-controlled repository paths are used.
    proc = subprocess.Popen(['git', 'cat-file', '--batch'], cwd=ROOT, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    try:
        for name in selected:
            entry = entries[name]
            target = destination / (name[4:] if args.site else name)
            no_symlinks(target)
            if target.exists():
                if not target.is_file() or target.stat().st_size != entry['size'] or digest(target) != entry['sha256']:
                    fail(f'refusing to overwrite different existing file: {target}')
                continue
            target.parent.mkdir(parents=True, exist_ok=True)
            no_symlinks(target)
            proc.stdin.write((baseline + ':' + name + '\n').encode())
            proc.stdin.flush()
            header = proc.stdout.readline().decode().rstrip('\n').rsplit(' ', 2)
            if len(header) != 3 or header[1] != 'blob' or int(header[2]) != entry['size']:
                fail(f'Git object is missing or wrong size: {name}')
            h = hashlib.sha256()
            remaining = entry['size']
            temp_name = None
            try:
                with tempfile.NamedTemporaryFile(dir=target.parent, prefix='.artifact-', delete=False) as temp:
                    temp_name = temp.name
                    while remaining:
                        block = proc.stdout.read(min(1024 * 1024, remaining))
                        if not block:
                            fail(f'truncated Git object: {name}')
                        temp.write(block)
                        h.update(block)
                        remaining -= len(block)
                if proc.stdout.read(1) != b'\n' or h.hexdigest() != entry['sha256']:
                    fail(f'hash mismatch: {name}')
                no_symlinks(target)
                # Hard linking fails if a target appears during restoration.
                os.link(temp_name, target)
            finally:
                if temp_name:
                    os.unlink(temp_name)
    finally:
        proc.stdin.close()
        proc.stdout.close()
        proc.wait()
    print(f'Verified {len(selected)} artifacts from {baseline} in {destination}')


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest='command', required=True)
    p = sub.add_parser('restore', help='restore exact bytes; existing differing files are never overwritten')
    location = p.add_mutually_exclusive_group()
    location.add_argument('--destination', help='repository root (default), or an overlay under cad/build/')
    location.add_argument('--site', help='viewer site under cad/build/; strip the leading cad/ from paths')
    p.add_argument('--dry-run', action='store_true')
    p.add_argument('--prefix', help='restore all artifacts in one cataloged directory')
    p.add_argument('paths', nargs='*', help='exact repository-relative manifest paths; omit for all')
    listing = sub.add_parser('list', help='list cataloged repository-relative artifact paths')
    listing.add_argument('prefix', nargs='?', default='', help='optional path prefix')
    args = parser.parse_args(argv)
    try:
        if args.command == 'list':
            manifest = json.loads(MANIFEST.read_text())
            for entry in manifest['artifacts']:
                if entry['path'].startswith(args.prefix):
                    print(entry['path'])
        else:
            restore(args)
    except (ValueError, OSError, KeyError, json.JSONDecodeError) as exc:
        print(f'artifacts: {exc}', file=sys.stderr)
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())

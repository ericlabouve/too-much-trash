"""Assemble an isolated, reproducible viewer site from CAD builds."""
from __future__ import annotations

import json
import html
import io
from http.server import SimpleHTTPRequestHandler
from pathlib import Path
import shlex
import shutil
import subprocess
import sys
import tempfile


class SiteHandler(SimpleHTTPRequestHandler):
    def list_directory(self, path):
        # SimpleHTTPRequestHandler calls this only when no index file exists.
        # Retained job metadata otherwise produces a misleading directory listing.
        root = Path(self.directory).resolve()
        try:
            parts = Path(path).resolve().relative_to(root).parts
        except ValueError:
            return super().list_directory(path)
        if (len(parts) >= 5 and parts[0] == 'versions' and
                parts[1] in ('v2', 'v3') and parts[2:4] == ('print', 'jobs')):
            prefix = 'cad/' + '/'.join(parts[:5])
            cad = Path(__file__).resolve().parents[1]
            catalog = json.loads((cad / 'workspace-artifacts.json').read_text())
            if any(entry['path'].startswith(prefix + '/') for entry in catalog['artifacts']):
                command = ['python3', 'cad/cad.py', 'artifacts', 'restore']
                if root != cad:
                    command.extend(['--site', str(root)])
                command.extend(['--prefix', prefix])
                body = ("<!doctype html><html><head><meta charset='utf-8'>"
                        "<title>Restore historical preview</title></head><body>"
                        "<h1>Restore historical preview</h1>"
                        "<p>This job's preview files are stored in Git history. "
                        "From the repository root, run:</p><pre>"
                        + html.escape(shlex.join(command)) + "</pre>"
                        "<p>Then reload this page. The pinned baseline commit must be available; "
                        "see cad/artifact-migration.md for recovery details.</p></body></html>")
                data = body.encode('utf-8')
                self.send_response(200)
                self.send_header('Content-type', 'text/html; charset=utf-8')
                self.send_header('Content-Length', str(len(data)))
                self.end_headers()
                return io.BytesIO(data)
        return super().list_directory(path)

    def send_error(self, code, message=None, explain=None):
        if code == 404:
            message = 'Asset missing: build a site or restore the relevant historical artifact'
            explain = 'Run cad.py build-site --versions all, or cad.py artifacts list and restore.'
        super().send_error(code, message, explain)


def copy_retained_review_assets(cad: Path, dest: Path, versions: list[str]) -> None:
    """Copy explicitly retained metadata; never copy cataloged artifact payloads.

    The list works in source archives without Git. Existing destination files
    are left intact so freshly generated reports take precedence.
    """
    catalog = json.loads((cad / 'workspace-artifacts.json').read_text())
    excluded = {entry['path'] for entry in catalog['artifacts']}
    retained = json.loads((cad / 'workspace-retained-assets.json').read_text())['paths']
    prefixes = [f'cad/versions/{version}/{folder}/' for version in versions
                if version != 'v1' for folder in ('review', 'print')]
    if 'v1' in versions:
        prefixes.append('cad/print/')
    allowed = {'.json', '.md', '.txt', '.html', '.js', '.css', '.py', '.toml', '.yaml', '.yml'}
    for name in retained:
        if name in excluded or not any(name.startswith(prefix) for prefix in prefixes):
            continue
        relative = Path(name).relative_to('cad')
        if '..' in relative.parts:
            raise ValueError(f'invalid retained asset path: {name}')
        source = cad / relative
        target = dest / relative
        if source.suffix.lower() not in allowed or source.is_symlink() or not source.is_file() or target.exists():
            continue
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, target)


def build_site(cad: Path, dest: Path, versions: list[str], definitions: dict) -> int:
    """Build versions in fresh snapshots; never use existing generated exports."""
    dest.mkdir(parents=True, exist_ok=False)
    build_root = cad / 'build'
    build_root.mkdir(exist_ok=True)
    runs = Path(tempfile.mkdtemp(prefix='site-runs-', dir=build_root))
    try:
        # Authored viewer resources and retained review records are separate
        # from cataloged historical exports, which require explicit restoration.
        for name in ('version_navigation.js', 'view_cube.js', 'component_navigation.js',
                     'material_strategy.js', 'viewer.html', 'viewer-v1.html', 'bom.md'):
            path = cad / name
            if path.is_file():
                shutil.copy2(path, dest / name)
        registry = json.loads((cad / 'versions.json').read_text())
        registry['versions'] = [entry for entry in registry['versions'] if entry['id'] in versions]
        if registry['default'] not in versions:
            registry['default'] = versions[0]
        (dest / 'versions.json').write_text(json.dumps(registry, indent=2) + '\n')
        copy_retained_review_assets(cad, dest, versions)
        for version in versions:
            if version != 'v1':
                source = cad / 'versions' / version
                target = dest / 'versions' / version
                target.mkdir(parents=True, exist_ok=True)
                for path in source.iterdir():
                    if path.is_file() and path.suffix.lower() in ('.html', '.js', '.css', '.md'):
                        shutil.copy2(path, target / path.name)
            run = runs / version
            result = subprocess.run([sys.executable, str(cad / 'cad.py'), 'build', version,
                                     '--output', str(run)], check=False)
            if result.returncode:
                print(f'Site build failed for {version}; site is incomplete: {dest}', file=sys.stderr)
                return result.returncode
            rel = Path('.') if version == 'v1' else Path('versions') / version
            for folder in ('print', 'review'):
                generated = run / rel / folder
                if generated.is_dir():
                    shutil.copytree(generated, dest / rel / folder, dirs_exist_ok=True)
            print_readme = cad / rel / 'print' / 'README.md'
            if print_readme.is_file():
                (dest / rel / 'print').mkdir(parents=True, exist_ok=True)
                shutil.copy2(print_readme, dest / rel / 'print' / 'README.md')
            bom = run / rel / 'bom.md'
            if bom.is_file():
                shutil.copy2(bom, dest / rel / 'bom.md')
        (dest / 'site-build.json').write_text(json.dumps({
            'versions': versions, 'snapshots': str(runs),
            'note': 'Historical studies and exact print jobs require artifact restoration.'
        }, indent=2) + '\n')
        print(f'Site: {dest}\nServe: {sys.executable} {cad / "cad.py"} serve {versions[-1]} --site {dest}', flush=True)
        return 0
    except Exception:
        print(f'Site is incomplete: {dest}', file=sys.stderr)
        raise

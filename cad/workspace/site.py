"""Assemble an isolated, reproducible viewer site from CAD builds."""
from __future__ import annotations

import json
from http.server import SimpleHTTPRequestHandler
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile


class SiteHandler(SimpleHTTPRequestHandler):
    def send_error(self, code, message=None, explain=None):
        if code == 404:
            message = 'Asset missing: build a site or restore the relevant historical artifact'
            explain = 'Run cad.py build-site --versions all, or cad.py artifacts list and restore.'
        super().send_error(code, message, explain)


def build_site(cad: Path, dest: Path, versions: list[str], definitions: dict) -> int:
    """Build versions in fresh snapshots; never use existing generated exports."""
    dest.mkdir(parents=True, exist_ok=False)
    build_root = cad / 'build'
    build_root.mkdir(exist_ok=True)
    runs = Path(tempfile.mkdtemp(prefix='site-runs-', dir=build_root))
    try:
        # Only authored top-level viewer resources and documentation. Historical
        # reviews/jobs are supplied explicitly by the artifact restore workflow.
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

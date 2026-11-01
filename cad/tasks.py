"""Convenient Invoke entry points for the CAD command-line interface."""
from pathlib import Path
import subprocess
import sys

from invoke import Collection, Exit, task


_CLI = Path(__file__).resolve().with_name('cad.py')


def _run(*args):
    result = subprocess.run([sys.executable, str(_CLI), *args], check=False)
    if result.returncode:
        raise Exit(code=result.returncode)


def _option(name, value):
    return [name, str(value)] if value is not None else []


@task(name='list', auto_shortflags=False)
def list_tasks(c):
    """List supported versions, checks and viewers."""
    _run('list')


@task(auto_shortflags=False)
def plan(c, version='v3', operation='build', output=None):
    """Show a build or check plan without running it."""
    _run('plan', version, '--operation', operation, *_option('--output', output))


@task(auto_shortflags=False)
def build(c, version='v3', output=None):
    """Build a version in a new isolated snapshot."""
    _run('build', version, *_option('--output', output))


@task(auto_shortflags=False)
def check(c, version='v3', output=None):
    """Check a version in a new isolated snapshot."""
    _run('check', version, *_option('--output', output))


@task(iterable=['versions'], auto_shortflags=False)
def build_site(c, versions=None, output=None):
    """Build a viewer site; repeat --versions to select multiple versions."""
    _run('build-site', '--versions', *(versions or ['all']), *_option('--output', output))


@task(auto_shortflags=False)
def serve(c, version='v3', port=8765, site=None):
    """Serve a viewer site on loopback."""
    _run('serve', version, '--port', str(port), *_option('--site', site))


@task(optional=['json'], auto_shortflags=False)
def inventory(c, git=False, tracked_only=False, json=None):
    """Summarize workspace classifications; --json optionally takes a file."""
    args = (['--git'] if git else []) + (['--tracked-only'] if tracked_only else [])
    if json is not None and json is not False:
        args += ['--json', '-' if json is True else json]
    _run('inventory', *args)


@task(positional=['path'], auto_shortflags=False)
def explain(c, path):
    """Explain the classification of a workspace path."""
    _run('explain', path)


@task(name='list', auto_shortflags=False)
def artifacts_list(c, prefix=''):
    """List cataloged artifacts, optionally filtered by prefix."""
    _run('artifacts', 'list', *([prefix] if prefix else []))


@task(iterable=['path'], auto_shortflags=False)
def artifacts_restore(c, prefix=None, site=None, destination=None, dry_run=False, path=None):
    """Restore cataloged artifacts; repeat --path for exact paths."""
    args = (_option('--prefix', prefix) + _option('--site', site)
            + _option('--destination', destination) + (['--dry-run'] if dry_run else []))
    _run('artifacts', 'restore', *args, *(path or []))


ns = Collection()
ns.add_task(list_tasks)
for _task in (plan, build, check, build_site, serve, inventory, explain):
    ns.add_task(_task)
artifacts = Collection('artifacts')
artifacts.add_task(artifacts_list)
artifacts.add_task(artifacts_restore, name='restore')
ns.add_collection(artifacts)

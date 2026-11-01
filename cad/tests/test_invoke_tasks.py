"""Exercise the Invoke entry points without running geometry builds."""
import importlib.util
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
import uuid
from unittest.mock import patch

CAD = Path(__file__).resolve().parents[1]
INV = CAD / '.venv/bin/inv'


def invoke(*args):
    return subprocess.run([str(INV), *map(str, args)], cwd=CAD, text=True,
                          capture_output=True)


class InvokeTasksTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        # Use the CAD interpreter so Invoke is available in the test environment.
        if not INV.exists():
            raise unittest.SkipTest('CAD Invoke environment is not installed')

    def test_cli_discovery_and_help(self):
        listing = invoke('--list')
        self.assertEqual(listing.returncode, 0, listing.stderr)
        for name in ('build', 'check', 'plan', 'build-site', 'serve', 'inventory',
                     'explain', 'artifacts.list', 'artifacts.restore'):
            self.assertIn(name, listing.stdout)
        help_result = invoke('--help', 'plan')
        self.assertEqual(help_result.returncode, 0, help_result.stderr)
        for flag in ('--operation', '--output', '--version'):
            self.assertIn(flag, help_result.stdout)

    def test_plan_preserves_spaced_path_and_makes_no_files(self):
        with tempfile.TemporaryDirectory() as tmp:
            dest = Path(tmp) / 'a snapshot with spaces'
            result = invoke('plan', '--version', 'v3', '--operation', 'check', '--output', dest)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn('Operation: check v3', result.stdout)
            self.assertIn(f'Snapshot: {dest.resolve()}', result.stdout)
            self.assertIn('workspace_check.py', result.stdout)
            self.assertNotIn('\\ ', result.stdout)
            self.assertFalse(dest.exists())
            default = invoke('plan')
            self.assertEqual(default.returncode, 0, default.stderr)
            self.assertIn('Operation: build v3', default.stdout)
            invalid = invoke('plan', '--version', 'not-a-version')
            self.assertNotEqual(invalid.returncode, 0)

    def test_list_explain_and_artifact_dry_run(self):
        listing = invoke('list')
        self.assertEqual(listing.returncode, 0, listing.stderr)
        for version in ('v1:', 'v2:', 'v3:'):
            self.assertIn(version, listing.stdout)
        explanation = invoke('explain', 'cad/reference/measurements.md')
        self.assertEqual(explanation.returncode, 0, explanation.stderr)
        self.assertIn('reference', explanation.stdout)
        artifact_list = invoke('artifacts.list', '--prefix', 'cad/archive/r2/print')
        self.assertEqual(artifact_list.returncode, 0, artifact_list.stderr)
        artifact = artifact_list.stdout.splitlines()[0]
        self.assertTrue(artifact.startswith('cad/archive/r2/print/'))
        # A new overlay is not created even when its parent contains spaces.
        dest = CAD / 'build' / f'invoke test dry run {uuid.uuid4().hex}'
        self.assertFalse(dest.exists())
        result = invoke('artifacts.restore', '--destination', dest, '--dry-run', '--path', artifact)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('Would restore 1 artifacts', result.stdout)
        self.assertFalse(dest.exists())

    def test_wrapper_argv_options_and_failure_status(self):
        try:
            from invoke import Exit
        except ImportError:
            self.skipTest('Invoke is not installed in this interpreter')
        spec = importlib.util.spec_from_file_location('cad_invoke_tasks', CAD / 'tasks.py')
        tasks = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(tasks)
        with patch.object(tasks.subprocess, 'run') as run:
            run.return_value.returncode = 0
            tasks.build.body(None, version='v2', output='/tmp/space dir/result')
            run.assert_called_once_with(
                [sys.executable, str(CAD / 'cad.py'), 'build', 'v2',
                 '--output', '/tmp/space dir/result'], check=False)
            run.reset_mock()
            tasks.inventory.body(None, git=True, tracked_only=True, json=True)
            self.assertEqual(run.call_args.args[0][2:],
                             ['inventory', '--git', '--tracked-only', '--json', '-'])
            run.reset_mock()
            tasks.artifacts_restore.body(None, dry_run=True, path=['cad/a', 'cad/b'])
            self.assertEqual(run.call_args.args[0][2:],
                             ['artifacts', 'restore', '--dry-run', 'cad/a', 'cad/b'])
            run.reset_mock()
            tasks.build_site.body(None, versions=['v1', 'v3'], output='/tmp/site dir')
            self.assertEqual(run.call_args.args[0][2:],
                             ['build-site', '--versions', 'v1', 'v3', '--output', '/tmp/site dir'])
            run.reset_mock()
            tasks.serve.body(None)
            self.assertEqual(run.call_args.args[0][2:], ['serve', 'v3', '--port', '8765'])
            run.return_value.returncode = 7
            with self.assertRaises(Exit) as error:
                tasks.check.body(None)
            self.assertEqual(error.exception.code, 7)


if __name__ == '__main__':
    unittest.main()

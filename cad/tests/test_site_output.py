"""Site output policy is compatible with selective artifact restoration."""
import importlib.util
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

CAD = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(CAD))
spec = importlib.util.spec_from_file_location('cad_cli_site_output', CAD / 'cad.py')
cli = importlib.util.module_from_spec(spec)
spec.loader.exec_module(cli)


class SiteOutputTests(unittest.TestCase):
    def test_external_site_rejected_before_creating_directory(self):
        with tempfile.TemporaryDirectory() as tmp:
            dest = Path(tmp) / 'site'
            result = subprocess.run([sys.executable, str(CAD / 'cad.py'), 'build-site',
                                     '--versions', 'v3', '--output', str(dest)],
                                    text=True, capture_output=True)
            self.assertNotEqual(result.returncode, 0)
            self.assertIn('site output must be a new directory under cad/build/', result.stderr)
            self.assertFalse(dest.exists())

    def test_default_site_path_is_under_build_and_does_not_create_it(self):
        dest = cli.output_path('site', 'site', None)
        self.assertIn(CAD / 'build', dest.parents)
        self.assertFalse(dest.exists())

    def test_internal_site_is_accepted_without_creating_it(self):
        dest = CAD / 'build' / 'test-site-output-not-created'
        self.assertFalse(dest.exists())
        with patch.object(sys, 'argv', ['cad.py', 'build-site', '--versions', 'v3',
                                      '--output', str(dest)]), \
             patch('workspace.site.build_site', return_value=0) as build:
            self.assertEqual(cli.main(), 0)
        self.assertEqual(build.call_args.args[1], dest)
        self.assertFalse(dest.exists())

    def test_external_snapshot_plan_remains_side_effect_free(self):
        with tempfile.TemporaryDirectory() as tmp:
            dest = Path(tmp) / 'snapshot'
            result = subprocess.run([sys.executable, str(CAD / 'cad.py'), 'plan', 'v3',
                                     '--output', str(dest)], text=True, capture_output=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertFalse(dest.exists())


if __name__ == '__main__':
    unittest.main()

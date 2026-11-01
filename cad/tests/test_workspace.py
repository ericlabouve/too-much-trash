"""Safety and provenance checks for the CAD workspace tools."""
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

CAD = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(CAD))
import workspace_inventory as inventory


def cli(*args):
    return subprocess.run([sys.executable, str(CAD / 'cad.py'), *map(str, args)],
                          text=True, capture_output=True)


class WorkspaceTests(unittest.TestCase):
    def test_classification_precedence_and_unknown(self):
        policy = inventory.load_policy()
        examples = {
            'cad/versions/v3/source/actuator_current/bracket.step': 'source-geometry',
            'cad/versions/v3/source/actuator_current/motion-paths.json': 'source-geometry',
            'cad/versions/v3/source/clip_current/clip.stl': 'source-geometry',
            'cad/versions/v3/print/jobs/example/model.stl': 'generated',
            'cad/versions/v3/print/jobs/example/start-record.json': 'physical-evidence',
            'cad/versions/v3/print/jobs/example/machine.json': 'config',
            'cad/reference/measurements.md': 'reference',
            'cad/renders/concept.spec.json': 'reference',
            'cad/versions/v3/review/manifest.json': 'review-needed',
            'cad/versions/v3/source/model.py': 'code',
            'cad/mystery.bin': 'review-needed',
        }
        for path, expected in examples.items():
            with self.subTest(path=path):
                category, reason, rule = inventory.classify(path, policy)
                self.assertEqual(category, expected)
                self.assertTrue(reason)
                if path.endswith('mystery.bin'):
                    self.assertIsNone(rule)
                else:
                    self.assertIsNotNone(rule)

    def test_plan_is_deterministic_and_has_no_side_effects(self):
        with tempfile.TemporaryDirectory() as tmp:
            dest = Path(tmp) / 'snapshot'
            first = cli('plan', 'v3', '--output', dest)
            second = cli('plan', 'v3', '--output', dest)
            self.assertEqual(first.returncode, 0, first.stderr)
            self.assertEqual(first.stdout, second.stdout)
            self.assertFalse(dest.exists())
            for text in ('Operation: build v3', 'versions/v3/source', 'build.py',
                         'source', 'review', 'print', 'bom.md'):
                self.assertIn(text, first.stdout)
            check = cli('plan', 'v3', '--operation', 'check', '--output', dest)
            self.assertEqual(check.returncode, 0, check.stderr)
            self.assertIn('workspace_check.py', check.stdout)
            self.assertIn('workspace-validation.json', check.stdout)
            self.assertFalse(dest.exists())

    def test_existing_and_protected_destinations_are_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            marker = root / 'keep.txt'
            marker.write_text('keep')
            for destination in (root, CAD / 'versions/v3/new-output'):
                result = cli('build', 'v3', '--output', destination)
                self.assertNotEqual(result.returncode, 0)
            self.assertEqual(marker.read_text(), 'keep')
            self.assertFalse((CAD / 'versions/v3/new-output').exists())

    def test_snapshot_contains_v3_source_dependencies_and_is_independent(self):
        spec = importlib.util.spec_from_file_location('cad_cli', CAD / 'cad.py')
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        with tempfile.TemporaryDirectory() as tmp:
            dest = Path(tmp) / 'snapshot'
            module.snapshot('v3', dest)
            for relative in ('source/parameters.py', 'source/assembly.py',
                             'versions/v3/source/model.py',
                             'versions/v3/source/actuator_current/motion-paths.json',
                             'versions/v3/source/clip_current/clip.stl'):
                self.assertTrue((dest / relative).is_file(), relative)
            source_steps = sorted((CAD / 'versions/v3/source/actuator_current').glob('*.step'))
            self.assertTrue(source_steps)
            for source in source_steps:
                self.assertEqual((dest / 'versions/v3/source/actuator_current' / source.name).read_bytes(),
                                 source.read_bytes())
            copied = dest / 'versions/v3/source/model.py'
            original = (CAD / 'versions/v3/source/model.py').read_bytes()
            copied.write_text('isolated')
            self.assertEqual((CAD / 'versions/v3/source/model.py').read_bytes(), original)
            self.assertTrue((dest / 'versions/v3/review').is_dir())
            self.assertTrue((dest / 'versions/v3/print').is_dir())

    def test_inventory_writes_json_to_new_nested_directory(self):
        with tempfile.TemporaryDirectory() as tmp:
            target = Path(tmp) / 'nested' / 'inventory.json'
            subprocess.run([sys.executable, str(CAD / 'workspace_inventory.py'),
                            '--git', '--json', str(target)], check=True, capture_output=True)
            report = json.loads(target.read_text())
            self.assertTrue(report['tracked_status_included'])
            self.assertEqual(report['totals']['files'], len(report['files']))
            self.assertEqual(report['totals']['bytes'], sum(f['bytes'] for f in report['files']))
            self.assertTrue(all('tracked' in f for f in report['files']))

    def test_site_uses_fresh_outputs_not_legacy_exports(self):
        from workspace.site import build_site
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / 'cad'
            root.mkdir()
            (root / 'workspace-artifacts.json').write_text(json.dumps({'artifacts': []}))
            (root / 'workspace-retained-assets.json').write_text(json.dumps({'paths': []}))
            (root / 'viewer.html').write_text('selector')
            (root / 'viewer-v1.html').write_text('viewer')
            (root / 'versions.json').write_text(json.dumps({
                'default': 'v1', 'versions': [{'id': 'v1'}]}))
            (root / 'print').mkdir()
            (root / 'print/manifest.json').write_text('stale legacy data')
            def fake_build(command, check):
                run = Path(command[command.index('--output') + 1])
                (run / 'print').mkdir(parents=True)
                (run / 'print/manifest.json').write_text('fresh output')
                return subprocess.CompletedProcess(command, 0)
            output = Path(tmp) / 'site'
            with patch('workspace.site.subprocess.run', side_effect=fake_build):
                self.assertEqual(build_site(root, output, ['v1'], {}), 0)
            self.assertEqual((output / 'print/manifest.json').read_text(), 'fresh output')
            self.assertEqual((output / 'viewer.html').read_text(), 'selector')

    def test_site_copies_retained_metadata_without_warm_or_cataloged_files(self):
        from workspace.site import copy_retained_review_assets
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            cad = root / 'cad'
            review = cad / 'versions/v2/review'
            review.mkdir(parents=True)
            retained = review / 'retained.json'
            cataloged = review / 'cataloged.json'
            warm = review / 'warm.json'
            for path in (retained, cataloged, warm):
                path.write_text(path.name)
            (cad / 'workspace-artifacts.json').write_text(json.dumps({'artifacts': [
                {'path': 'cad/versions/v2/review/cataloged.json'}]}))
            (cad / 'workspace-retained-assets.json').write_text(json.dumps({'paths': [
                'cad/versions/v2/review/retained.json',
                'cad/versions/v2/review/cataloged.json']}))
            site = root / 'site'
            copy_retained_review_assets(cad, site, ['v2'])
            out = site / 'versions/v2/review'
            self.assertEqual((out / 'retained.json').read_text(), 'retained.json')
            self.assertFalse((out / 'cataloged.json').exists())
            self.assertFalse((out / 'warm.json').exists())
            (out / 'retained.json').write_text('fresh report')
            copy_retained_review_assets(cad, site, ['v2'])
            self.assertEqual((out / 'retained.json').read_text(), 'fresh report')

    def test_explain_rejects_path_escape(self):
        script = CAD / 'workspace_inventory.py'
        result = subprocess.run([sys.executable, str(script), '--explain', '../outside'],
                                text=True, capture_output=True)
        self.assertNotEqual(result.returncode, 0)
        result = subprocess.run([sys.executable, str(script), '--explain', 'reference/measurements.md'],
                                text=True, capture_output=True, check=True)
        self.assertEqual(json.loads(result.stdout)['category'], 'reference')


if __name__ == '__main__':
    unittest.main()

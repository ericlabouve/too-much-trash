"""Check restoration of pinned historical artifacts and its write safeguards."""
import hashlib
import json
from pathlib import Path
import subprocess
import shutil
import sys
import tempfile
import unittest

CAD = Path(__file__).resolve().parents[1]
ROOT = CAD.parent
SCRIPT = CAD / 'workspace/artifacts.py'
EXAMPLES = {
    'cad/archive/r2/print/actuator_carriage.step': 'bfaf80453f969cd4fbb210a6937db27a170aa2ecc8d29413ad4e861c2b029842',
    'cad/archive/r2/print/actuator_carriage.stl': '0631491eeb9f5bf171f6d59f270ec30588ea54fd8db0401a1067545c4d8a830c',
}


def restore(*args):
    return subprocess.run([sys.executable, str(SCRIPT), 'restore', *map(str, args)],
                          cwd=ROOT, capture_output=True, text=True)


class ArtifactMigrationTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.manifest = json.loads((CAD / 'workspace-artifacts.json').read_text())
        result = subprocess.run(['git', 'cat-file', '-e', cls.manifest['baseline'] + '^{commit}'],
                                cwd=ROOT, capture_output=True)
        if result.returncode:
            raise unittest.SkipTest('Pinned Git baseline unavailable; fetch it to test exact artifact restoration')
        (CAD / 'build').mkdir(exist_ok=True)

    def test_restore_exact_bytes_and_refuse_changes(self):
        entries = {e['path']: e for e in self.manifest['artifacts']}
        with tempfile.TemporaryDirectory(dir=CAD / 'build', prefix='artifact-test-') as tmp:
            dest = Path(tmp) / 'overlay'
            args = ['--destination', dest, *EXAMPLES]
            dry = restore('--dry-run', *args)
            self.assertEqual(dry.returncode, 0, dry.stderr)
            self.assertFalse(dest.exists())
            result = restore(*args)
            self.assertEqual(result.returncode, 0, result.stderr)
            for name, expected in EXAMPLES.items():
                data = (dest / name).read_bytes()
                self.assertEqual(hashlib.sha256(data).hexdigest(), expected)
                self.assertEqual(entries[name]['sha256'], expected)
                self.assertEqual(len(data), entries[name]['size'])
            self.assertEqual(restore(*args).returncode, 0)
            target = dest / next(iter(EXAMPLES))
            target.write_bytes(b'keep this change')
            result = restore(*args)
            self.assertNotEqual(result.returncode, 0)
            self.assertIn('refusing to overwrite', result.stderr)
            self.assertEqual(target.read_bytes(), b'keep this change')

    def test_rejects_unapproved_paths_and_destinations(self):
        with tempfile.TemporaryDirectory(dir=CAD / 'build', prefix='artifact-test-') as tmp:
            dest = Path(tmp) / 'overlay'
            for path in ('../outside', 'cad/not-in-manifest', '/etc/passwd'):
                result = restore('--dry-run', '--destination', dest, '--', path)
                self.assertNotEqual(result.returncode, 0, path)
            self.assertNotEqual(restore('--destination', ROOT / 'outside', next(iter(EXAMPLES))).returncode, 0)
            dest.symlink_to(Path(tmp), target_is_directory=True)
            result = restore('--destination', dest, next(iter(EXAMPLES)))
            self.assertNotEqual(result.returncode, 0)
            self.assertIn('symlink', result.stderr)


class LocalFixtureTests(unittest.TestCase):
    def test_restore_from_small_local_git_repository(self):
        (CAD / 'build').mkdir(exist_ok=True)
        with tempfile.TemporaryDirectory(dir=CAD / 'build', prefix='fixture-git-') as tmp:
            root = Path(tmp)
            script = root / 'cad/workspace/artifacts.py'
            script.parent.mkdir(parents=True)
            shutil.copy2(SCRIPT, script)
            data = b'known historic artifact\n'
            artifact = root / 'cad/example.bin'
            artifact.write_bytes(data)
            def git(*args):
                return subprocess.run(['git', *args], cwd=root, check=True,
                                      stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True).stdout.strip()
            git('init', '-q')
            git('config', 'user.email', 'fixture@example.invalid')
            git('config', 'user.name', 'Fixture')
            git('add', 'cad/example.bin')
            git('commit', '-qm', 'Fixture')
            baseline = git('rev-parse', 'HEAD')
            (root / 'cad/workspace-artifacts.json').write_text(json.dumps({
                'schema': 1, 'baseline': baseline, 'artifacts': [{
                    'path': 'cad/example.bin', 'size': len(data),
                    'sha256': hashlib.sha256(data).hexdigest()}]}))
            artifact.unlink()
            result = subprocess.run([sys.executable, str(script), 'restore', 'cad/example.bin'],
                                    cwd=root, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(artifact.read_bytes(), data)
            site = root / 'cad/build/site'
            site.mkdir(parents=True)
            def run(*args):
                return subprocess.run([sys.executable, str(script), 'restore', *map(str, args)],
                                      cwd=root, capture_output=True, text=True)
            self.assertNotEqual(run('--site', site).returncode, 0)
            self.assertNotEqual(run('--site', site, '--prefix', 'cad/missing').returncode, 0)
            self.assertNotEqual(run('--site', site, '--prefix', 'cad', 'cad/example.bin').returncode, 0)
            self.assertEqual(run('--site', site, '--dry-run', '--prefix', 'cad').returncode, 0)
            self.assertFalse((site / 'example.bin').exists())
            result = run('--site', site, '--prefix', 'cad')
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual((site / 'example.bin').read_bytes(), data)


if __name__ == '__main__':
    unittest.main()

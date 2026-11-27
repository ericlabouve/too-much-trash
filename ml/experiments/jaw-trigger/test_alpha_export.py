"""Pin model identity and test real duplicate-symbol isolation without private data."""
import ctypes
from copy import deepcopy
import json
from pathlib import Path
import shutil
import subprocess
import sys
from tempfile import TemporaryDirectory
import unittest
from unittest.mock import patch

from alpha import export as alpha


class AlphaExportTests(unittest.TestCase):
    @unittest.skipUnless(shutil.which('clang++'), 'C++ compiler required')
    def test_two_sources_with_same_c_symbols_and_cpp_types_link_without_collision(self):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            wrappers = []
            for role, value in (('visual', 4), ('event', 7)):
                name = role + '.cpp'
                source = f'struct State {{int value={value};}};\nextern "C" int step(){{return State{{}}.value;}}\n'
                (root / name).write_text(source)
                wrapper, declarations = alpha.portable_wrapper(source, name, 'alpha_' + role)
                path = root / (role + '_portable.cpp'); path.write_text(wrapper); wrappers.append(str(path))
                self.assertIn(f'int alpha_{role}_step();', declarations)
            library = root / ('probe.dylib' if sys.platform == 'darwin' else 'probe.so')
            subprocess.run(['clang++', '-std=c++17', '-O3',
                            *(['-dynamiclib'] if sys.platform == 'darwin' else ['-shared', '-fPIC']),
                            *wrappers, '-o', str(library)], check=True, capture_output=True)
            module = ctypes.CDLL(str(library))
            self.assertEqual(module.alpha_visual_step(), 4)
            self.assertEqual(module.alpha_event_step(), 7)

    def fixture(self, root):
        code, package = root / 'code', root / 'package'
        (code / 'runtime').mkdir(parents=True); package.mkdir()
        names = list(alpha.read(alpha.HERE / 'selection.json')['sources'])
        sources = {}
        for name in names:
            path = code / 'runtime' / name
            path.write_text('extern "C" int step(){return 1;}\n' if name.endswith('.cpp') else 'import ctypes\n')
            sources[name] = {'sha256': alpha.digest(path)}
        model = {'weights': [1, 2]}
        selection = {'model_id': 'synthetic-alpha', 'candidate': {'name': 'frozen', 'method': 'one'},
                     'runtime_config': {'threshold': .8}, 'sources': sources,
                     'weights': {'one': {'filename': 'weights.json'}}}
        with patch.object(alpha, 'HERE', code):
            alpha.copy_runtime(selection, package / 'runtime')
        alpha.write(package / 'runtime/weights.json', model)
        selection['weights']['one']['runtime_sha256'] = alpha.digest(package / 'runtime/weights.json')
        alpha.write(package / 'runtime/config.json', {**selection['candidate'], **selection['runtime_config']})
        (package / 'fixtures').mkdir()
        (package / 'fixtures/validation-000.bin').write_bytes(b'private synthetic pixels')
        alpha.write(package / 'fixtures/index.json', {'clips': [{'file': 'validation-000.bin', 'expected_events': []}]})
        selection['conformance'] = {'fixture_count': 1, 'index_sha256': alpha.digest(package / 'fixtures/index.json'),
            'pixels': {'validation-000.bin': alpha.digest(package / 'fixtures/validation-000.bin')}}
        alpha.write(code / 'selection.json', selection); alpha.write(package / 'selection.json', selection)
        manifest = {'schema': 'jaw-alpha-package-v1', 'model_id': selection['model_id'],
                    'candidate': selection['candidate'], 'fixture_count': 1, 'test_read': False,
                    'fitting_performed': False, 'files': {str(p.relative_to(package)): alpha.digest(p)
                        for p in package.rglob('*') if p.is_file()}}
        alpha.write(package / 'manifest.json', manifest)
        return code, package

    def test_private_package_has_independent_pins_not_just_editable_manifest_hashes(self):
        for name in ('runtime/weights.json', 'runtime/config.json', 'runtime/exact_parent_native_adapter.py',
                     'fixtures/index.json', 'fixtures/validation-000.bin', 'selection.json'):
            with self.subTest(asset=name), TemporaryDirectory() as directory:
                code, package = self.fixture(Path(directory))
                with patch.object(alpha, 'HERE', code):
                    self.assertEqual(alpha.verify_package(package)['status'], 'verified')
                    path = package / name
                    if name.endswith('.json'):
                        value = alpha.read(path); value['tampered'] = True; alpha.write(path, value)
                    else:
                        path.write_bytes(path.read_bytes() + b' tampered')
                    manifest = alpha.read(package / 'manifest.json')
                    manifest['files'][name] = alpha.digest(path)
                    alpha.write(package / 'manifest.json', manifest)
                    with self.assertRaises(ValueError):
                        alpha.verify_package(package)

    def test_asset_paths_cannot_escape_declared_root(self):
        with TemporaryDirectory() as directory:
            root = Path(directory); (root / 'assets').mkdir(); (root / 'outside').write_text('secret')
            with self.assertRaises(ValueError):
                alpha.inside(root / 'assets', '../outside')

    def test_runtime_payload_removes_nested_training_metadata_without_changing_weights(self):
        original = {'weight': [1, 2], 'nested': {'fit_clip_ids': ['do-not-ship'], 'scale': [3]}, 'fit': 'private'}
        before = deepcopy(original)
        self.assertEqual(alpha.runtime_parameters(original), {'weight': [1, 2], 'nested': {'scale': [3]}})
        self.assertEqual(original, before)

    def test_unreviewed_native_exports_are_not_silently_wrapped(self):
        for source in ('int step(){return 1;}', 'extern "C" int step(){return 1;}\nextern "C" int step(){return 2;}',
                       '#include <unexpected>\nextern "C" int step(){return 1;}'):
            with self.subTest(source=source), self.assertRaises(ValueError):
                alpha.portable_wrapper(source, 'source.cpp', 'alpha')

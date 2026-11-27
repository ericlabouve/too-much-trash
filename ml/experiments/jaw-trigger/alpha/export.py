"""Export the explicitly pinned alpha, never whichever model happens to lead next.

Weights and real conformance inputs are private outputs outside the repository.
The portable C++ wrappers change symbol linkage only, preserving the audited
inference sources and isolating their overlapping C/C++ names in one iOS target.
"""
import argparse
from hashlib import sha256
import json
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile

HERE = Path(__file__).resolve().parent
REPOSITORY = HERE.parents[3]
DEFAULT_RUNS = Path('/Users/ericlabouve/Datasets/too-much-trash/working/runs')
EXPORTS = re.compile(r'extern "C"\s+([^{};]+?)\s*\{')
PRIVATE_KEYS = {'fit', 'fit_provenance', 'fit_clip_ids', 'training_clip_ids',
                'training_only', 'sampling', 'training_rows', 'training_collection_multipliers'}


def digest(path):
    h = sha256()
    with Path(path).open('rb') as stream:
        for block in iter(lambda: stream.read(8 * 1024 * 1024), b''):
            h.update(block)
    return h.hexdigest()


def read(path):
    return json.loads(Path(path).read_text())


def write(path, value):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2, allow_nan=False) + '\n')


def inside(root, name):
    root = Path(root).resolve(strict=True)
    path = (root / name).resolve(strict=True)
    if not path.is_relative_to(root) or not path.is_file():
        raise ValueError('Asset must be a regular file inside its declared root')
    return path


def runtime_parameters(value):
    if isinstance(value, dict):
        return {k: runtime_parameters(v) for k, v in value.items() if k not in PRIVATE_KEYS}
    if isinstance(value, list):
        return [runtime_parameters(v) for v in value]
    return value


def portable_wrapper(source, filename, prefix):
    """Namespace internal C++ types AND prefix C exports; raw sources stay exact."""
    declarations = []
    for match in EXPORTS.finditer(source):
        signature = ' '.join(match[1].split())
        symbol = re.search(r'\b([A-Za-z_]\w*)\s*\(', signature)
        if symbol is None:
            raise ValueError('Unsupported C ABI declaration')
        declarations.append((symbol[1], signature))
    names = [name for name, _ in declarations]
    if not names or len(set(names)) != len(names):
        raise ValueError('C ABI names must be nonempty and unique per source')
    includes = re.findall(r'^#include\s+(.+)$', source, re.MULTILINE)
    if any(name not in ('<cmath>', '<cstdint>', '<vector>', '<algorithm>') for name in includes):
        raise ValueError('Inspect new includes before wrapping the pinned runtime')
    preamble = '\n'.join('#include ' + name for name in includes)
    defines = '\n'.join(f'#define {name} {prefix}_{name}' for name in names)
    undefs = '\n'.join(f'#undef {name}' for name in names)
    wrapper = (f'// Linkage-only wrapper; do not edit the included audited source.\n{preamble}\n'
               f'{defines}\nnamespace {prefix}_implementation {{\n#include "{filename}"\n}}\n{undefs}\n')
    prototypes = [re.sub(r'\b' + re.escape(name) + r'\s*\(', prefix + '_' + name + '(', signature, count=1) + ';'
                  for name, signature in declarations]
    return wrapper, prototypes


def copy_runtime(selection, runtime):
    runtime.mkdir(parents=True)
    prototypes = []
    for name, record in selection['sources'].items():
        source = inside(HERE / 'runtime', name)
        if digest(source) != record['sha256']:
            raise ValueError(f'Pinned runtime source changed: {name}')
        shutil.copyfile(source, runtime / name)
    for component, filename in (('visual', 'baseline_native.cpp'), ('event', 'event_native.cpp')):
        wrapper, declarations = portable_wrapper((runtime / filename).read_text(), filename,
                                                 'tmt_alpha_' + component)
        (runtime / f'{component}_portable.cpp').write_text(wrapper)
        prototypes.extend(declarations)
    (runtime / 'alpha_c_api.h').write_text(
        '#pragma once\n#include <stdint.h>\n#ifdef __cplusplus\nextern "C" {\n#endif\n' +
        '\n'.join(prototypes) + '\n#ifdef __cplusplus\n}\n#endif\n')
    # Reference adapters retain all orchestration/math and change only library lookup.
    for filename in ('baseline_native_adapter.py', 'event_native_adapter.py'):
        path = runtime / filename
        path.write_text('from alpha_library import load as _alpha_load\n' +
                        path.read_text().replace('ctypes.CDLL(', '_alpha_load('))
    (runtime / 'alpha_library.py').write_text('''"""Host conformance adapter; the iPhone calls alpha_c_api.h directly."""
import ctypes, sys
from pathlib import Path
class Library:
 def __init__(self,prefix):
  self.prefix=prefix
  self.library=ctypes.CDLL(str(Path(__file__).parent/('alpha_native.dylib' if sys.platform=='darwin' else 'alpha_native.so')))
 def __getattr__(self,name):return getattr(self.library,self.prefix+name)
def load(path):
 name=Path(path).name
 if name=='baseline_native.dylib':return Library('tmt_alpha_visual_')
 if name=='event_native.dylib':return Library('tmt_alpha_event_')
 raise ValueError('Unknown alpha library')
''')


def copy_fixtures(job, report, output, per_dataset=2):
    """Export validation conformance examples, never reserved test examples."""
    trace = read(job / report['outputs']['path'])
    expected = {row['clip']: row for row in trace['splits']['validation']}
    provenance = read(job / 'fixture-provenance.json')
    fixtures = read(job / 'Fixtures/clips.json')
    counts, records = {}, []
    for fixture in fixtures:
        source = provenance[fixture['file']]
        if source['split'] != 'validation':
            continue
        dataset = source['clip'].split(':')[0]
        if counts.get(dataset, 0) >= per_dataset:
            continue
        counts[dataset] = counts.get(dataset, 0) + 1
        if Path(fixture['file']).name != fixture['file']:
            raise ValueError('Fixture filename must not escape its index')
        # Published fixtures may be read-only links to a shared immutable cache.
        # Copy actual pixels only after checking their frozen hash and shape.
        pixel_source = (job / 'Fixtures' / fixture['file']).resolve(strict=True)
        if not pixel_source.is_file() or pixel_source.stat().st_size != len(fixture['timestamps']) * 240 * 320:
            raise ValueError('Unexpected conformance pixel shape')
        if digest(pixel_source) != source['sha256']:
            raise ValueError('Validation conformance pixels changed')
        name = f'validation-{len(records):03d}.bin'
        target = output / 'fixtures' / name
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(pixel_source, target)
        native = expected[source['clip']]
        if native['sample_times_seconds'] != fixture['timestamps']:
            raise ValueError('Conformance timestamps differ from native evaluation')
        records.append({'file': name, 'source_clip': source['clip'], 'dataset': dataset,
                        'timestamps': fixture['timestamps'], 'sensors': fixture['sensors'],
                        'expected_scores': native['scores'], 'expected_events': native['events']})
    if not records:
        raise ValueError('No validation conformance fixtures')
    write(output / 'fixtures/index.json', {'split': 'validation', 'test_read': False,
                                          'role': 'host conformance only; never inference inputs', 'clips': records})
    return len(records)


def export(output, runs_root=DEFAULT_RUNS, *, build=True):
    # Delayed imports keep asset verification available without the full ML environment.
    sys.path[:0] = [str(REPOSITORY), str(HERE.parent)]
    from dashboard_agents import verify_publication
    from ml.evolution.model_parameters import parameters_for

    selection = read(HERE / 'selection.json')
    job = (Path(runs_root) / selection['source_job']).resolve(strict=True)
    source_result, result = verify_publication(job, require_review=True)
    if digest(source_result) != selection['source_result_sha256']:
        raise ValueError('Pinned publication changed; never silently export a different leader')
    candidate = selection['candidate']
    entries = result['incumbents'] + result['challengers']
    if not any(entry['candidate'] == candidate for entry in entries):
        raise ValueError('Pinned candidate is not in the audited result')
    spec = next(s for s in read(job / 'deployment-specs.json') if s['slug'] == selection['source_spec_slug'])
    canonical_spec = json.dumps(spec, sort_keys=True, separators=(',', ':')).encode()
    if sha256(canonical_spec).hexdigest() != selection['source_spec_sha256']:
        raise ValueError('Pinned deployment spec changed')
    if parameters_for(result, candidate, required=True) != read(job / spec['model_path']):
        raise ValueError('Candidate-scoped weights disagree with selected source')
    for record in [*selection['sources'].values(), *selection['weights'].values()]:
        if digest(inside(job, record['source_path'])) != record['sha256']:
            raise ValueError('Pinned model or implementation changed')
    output = Path(output).resolve()
    if output.is_relative_to(REPOSITORY) or output == REPOSITORY:
        raise ValueError('Export private model weights/fixtures outside the Git repository')
    if output.exists():
        raise ValueError('Use a fresh output directory; existing alpha packages are immutable')
    output.parent.mkdir(parents=True, exist_ok=True)
    staging = Path(tempfile.mkdtemp(prefix='.alpha-', dir=output.parent))
    try:
        copy_runtime(selection, staging / 'runtime')
        write(staging / 'selection.json', selection)
        for record in selection['weights'].values():
            write(staging / 'runtime' / record['filename'], runtime_parameters(read(job / record['source_path'])))
        # Top-level config must include runtime overrides, not only generic candidate knobs.
        write(staging / 'runtime/config.json', {**candidate, **selection['runtime_config']})
        evaluation = read(job / 'evaluation.json')
        report = read(job / evaluation['deployment_benchmarks'][candidate['name']]['path'])
        fixture_count = copy_fixtures(job, report, staging)
        if build:
            library = 'alpha_native.dylib' if sys.platform == 'darwin' else 'alpha_native.so'
            command = ['clang++', '-std=c++17', '-O3',
                       *(['-dynamiclib'] if sys.platform == 'darwin' else ['-shared', '-fPIC']),
                       str(staging / 'runtime/visual_portable.cpp'),
                       str(staging / 'runtime/event_portable.cpp'), '-o', str(staging / 'runtime' / library)]
            subprocess.run(command, check=True)
        records = {str(p.relative_to(staging)): digest(p) for p in sorted(staging.rglob('*')) if p.is_file()}
        write(staging / 'manifest.json', {'schema': 'jaw-alpha-package-v1',
            'model_id': selection['model_id'], 'candidate': candidate,
            'source_result_sha256': selection['source_result_sha256'], 'files': records,
            'fixture_count': fixture_count, 'host_library_is_not_an_ios_binary': True,
            'linkage_only_wrappers': True, 'fitting_performed': False, 'test_read': False,
            'iphone_port_validated': False, 'natural_continuous_validation': False})
        staging.rename(output)
    finally:
        if staging.exists():
            shutil.rmtree(staging)
    return verify_package(output)


def verify_package(output):
    output = Path(output).resolve(strict=True)
    manifest = read(output / 'manifest.json')
    selection = read(output / 'selection.json')
    if (manifest.get('schema') != 'jaw-alpha-package-v1' or manifest.get('candidate') != selection['candidate']
            or manifest.get('model_id') != selection['model_id'] or manifest.get('test_read') is not False
            or manifest.get('fitting_performed') is not False):
        raise ValueError('Invalid alpha package identity/provenance')
    for name, expected in manifest['files'].items():
        if digest(inside(output, name)) != expected:
            raise ValueError(f'Alpha asset changed: {name}')
    # The tracked selection is the independent trust anchor, not an editable package manifest.
    if selection != read(HERE / 'selection.json'):
        raise ValueError('Package is not the pinned alpha selection')
    if read(inside(output, 'runtime/config.json')) != {**selection['candidate'], **selection['runtime_config']}:
        raise ValueError('Runtime configuration differs from the pinned decoder')
    for record in selection['weights'].values():
        if digest(inside(output / 'runtime', record['filename'])) != record['runtime_sha256']:
            raise ValueError('Runtime weights differ from the independently pinned alpha')
    conformance = selection['conformance']
    if (manifest['fixture_count'] != conformance['fixture_count']
            or len(read(inside(output, 'fixtures/index.json'))['clips']) != conformance['fixture_count']):
        raise ValueError('Conformance fixture count changed')
    if digest(inside(output, 'fixtures/index.json')) != conformance['index_sha256']:
        raise ValueError('Expected parity outputs or fixture metadata changed')
    for filename, expected in conformance['pixels'].items():
        if digest(inside(output / 'fixtures', filename)) != expected:
            raise ValueError('Conformance pixels differ from the pinned validation fixtures')
    with tempfile.TemporaryDirectory() as directory:
        expected_runtime = Path(directory) / 'runtime'
        copy_runtime(selection, expected_runtime)
        for path in expected_runtime.iterdir():
            if digest(inside(output / 'runtime', path.name)) != digest(path):
                raise ValueError('Runtime source/adapter differs from the pinned implementation')
    return {'status': 'verified', 'model_id': manifest['model_id'], 'output': str(output),
            'assets': len(manifest['files']), 'fixture_count': manifest['fixture_count'],
            'test_read': False, 'iphone_port_validated': False}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--runs-root', type=Path, default=DEFAULT_RUNS)
    parser.add_argument('--verify-only', action='store_true')
    parser.add_argument('--no-build', action='store_true')
    args = parser.parse_args()
    print(json.dumps(verify_package(args.output) if args.verify_only else
                     export(args.output, args.runs_root, build=not args.no_build), indent=2))

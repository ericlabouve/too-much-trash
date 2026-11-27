"""Recover saved model bindings from a failed round, without fitting or admission.

The failed job remains immutable. The new package archives exact selected models
and their evidence; its canonical training audit still uses the original job as
the provenance root. A recovered package is NOT a completed/published round.
"""

import argparse
from collections import Counter
from hashlib import sha256
import json
from pathlib import Path
import shutil

from dashboard_integrity import hashed_artifact, local_artifact
from dashboard_training import verify_training_records
from ml.evolution.model_parameters import bind_parameters, parameters_for

PROTOCOL = 'saved-candidate-recovery-v1'


def read(path):
    return json.loads(Path(path).read_text())


def digest(path):
    return sha256(Path(path).read_bytes()).hexdigest()


def archive_file(root, filename):
    """Archive even empty build logs; canonical receipt/artifact gates stay strict."""
    path = (root / filename).resolve(strict=True)
    if not path.is_relative_to(root.resolve()) or not path.is_file():
        raise ValueError('Recovery evidence must remain inside its declared root')
    return path


def write(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    pending = path.with_suffix('.pending')
    pending.write_text(json.dumps(value, indent=2, allow_nan=False) + '\n')
    pending.replace(path)


def recover(job, output):
    job, output = Path(job).resolve(strict=True), Path(output).resolve()
    if output == job or output.is_relative_to(job) or job.is_relative_to(output):
        raise ValueError('Recovery must be separate from the original job')
    if output.exists():
        raise ValueError('Choose a new recovery directory; never overwrite a package')
    if read(job / 'status.json').get('state') not in ('failed', 'cancelled', 'canceled'):
        raise ValueError('Recover only a terminal failed/cancelled job')
    authors = [task for task in read(job / 'agents.json')['tasks'] if task['kind'] in ('parent', 'research')]
    if not authors or any(task['status'] != 'completed' for task in authors):
        raise ValueError('Recovery requires all original authors to have completed')
    config, specs = read(job / 'config.json'), read(job / 'deployment-specs.json')
    result = {'round': config['round_number'], 'incumbents': [], 'challengers': [],
              'candidate_metadata': {}, 'settings': config['settings']}
    evaluation = {'fitted_candidates': [], 'training_receipts': {}, 'test_evaluated': False}
    bindings, evidence_paths = [], set()

    def include(filename):
        path = archive_file(job, filename)
        evidence_paths.add(path.relative_to(job))
        return path

    def include_ref(ref):
        _, path, _ = hashed_artifact(job, ref)
        include(path)
        return read(path)

    for filename in ('config.json', 'status.json', 'agents.json', 'deployment-specs.json',
                     'train.json', 'validation.json', 'trials.jsonl'):
        include(filename)
    for spec in specs:
        candidate = spec['candidate']
        result['incumbents' if spec['incumbent'] else 'challengers'].append({'candidate': candidate})
        result['candidate_metadata'][candidate['name']] = spec['metadata']
        bindings.append((candidate, read(include(spec['model_path']))))
        for filename in spec.get('artifacts', {}):
            include(filename)
        if spec['learned']:
            evaluation['fitted_candidates'].append(candidate['name'])
            evaluation['training_receipts'][candidate['name']] = spec['receipt']
    result.update(bind_parameters(bindings))
    eligible = {candidate['name']: candidate for candidate, _ in bindings}
    # Audit EVERY completed/crashed attempt, not just the chosen successful fits.
    audit = verify_training_records(job, result, evaluation, config['settings'],
                                    {s: job / f'{s}.json' for s in ('train', 'validation')}, eligible)
    for line in (job / 'trials.jsonl').read_text().splitlines():
        event = json.loads(line)
        if event['status'] == 'started':
            include_ref(event['plan'])
        if event['status'] == 'completed':
            receipt = include_ref(event['receipt'])
            checkpoint = include_ref(receipt['checkpoint'])
            for ref in checkpoint['artifacts']:
                include(hashed_artifact(job, ref)[1])
            if receipt.get('history'):
                history = include_ref(receipt['history'])
                for point in history['points']:
                    for key in ('predictions', 'training_predictions'):
                        if key in point:
                            include_ref(point[key])
    # Preserve original bytes under evidence/. Absolute paths in those bytes
    # remain original provenance, rather than rewriting signed receipts.
    records = [{'path': str(path), 'sha256': digest(job / path)} for path in sorted(evidence_paths)]
    output.mkdir(parents=True, exist_ok=False)
    for record in records:
        destination = output / 'evidence' / record['path']
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(job / record['path'], destination)
        if digest(destination) != record['sha256']:
            raise ValueError('Source evidence changed during recovery')
    write(output / 'candidates.json', result)
    write(output / 'evaluation-binding.json', evaluation)
    write(output / 'training-audit.json', audit)
    collisions = {method: count for method, count in Counter(c['method'] for c, _ in bindings).items() if count > 1}
    manifest = {'protocol': PROTOCOL, 'source_job': str(job), 'round': config['round_number'],
                'status': 'recovered_pending_evaluation_and_review', 'source_evidence': records,
                'recovered_parents': len(result['incumbents']), 'recovered_challengers': len(result['challengers']),
                'shared_methods': collisions, 'fitting_performed': False, 'test_evaluated': False,
                'published': False, 'candidate_binding_sha256': digest(output / 'candidates.json'),
                'evaluation_binding_sha256': digest(output / 'evaluation-binding.json'),
                'training_audit_sha256': digest(output / 'training-audit.json')}
    write(output / 'recovery.json', manifest)
    verify_recovery(output)
    return manifest


def verify_recovery(output):
    output = Path(output).resolve(strict=True)
    manifest = read(output / 'recovery.json')
    if (manifest.get('protocol') != PROTOCOL or manifest.get('published') is not False
            or manifest.get('fitting_performed') is not False or manifest.get('test_evaluated') is not False):
        raise ValueError('Recovery is not training, test evaluation or admission')
    job = Path(manifest['source_job']).resolve(strict=True)
    for record in manifest['source_evidence']:
        if digest(archive_file(job, record['path'])) != record['sha256']:
            raise ValueError('Source recovery evidence hash changed')
        archived = archive_file(output / 'evidence', record['path'])
        if digest(archived) != record['sha256']:
            raise ValueError('Archived recovery evidence changed')
    for filename, key in (('candidates.json', 'candidate_binding_sha256'),
                          ('evaluation-binding.json', 'evaluation_binding_sha256'),
                          ('training-audit.json', 'training_audit_sha256')):
        if digest(output / filename) != manifest[key]:
            raise ValueError('Recovery binding/audit changed')
    result, evaluation = read(output / 'candidates.json'), read(output / 'evaluation-binding.json')
    specs = read(job / 'deployment-specs.json')
    expected = {'incumbents': [], 'challengers': []}
    for spec in specs:
        candidate = spec['candidate']
        expected['incumbents' if spec['incumbent'] else 'challengers'].append({'candidate': candidate})
        if parameters_for(result, candidate, required=True) != read(job / spec['model_path']):
            raise ValueError('Recovered weights differ from saved model')
    if any(result[group] != entries for group, entries in expected.items()):
        raise ValueError('Recovery must preserve every original candidate identity')
    audit = verify_training_records(job, result, evaluation, read(job / 'config.json')['settings'],
                                    {s: job / f'{s}.json' for s in ('train', 'validation')},
                                    {s['candidate']['name']: s['candidate'] for s in specs})
    if audit != read(output / 'training-audit.json'):
        raise ValueError('Recovery training audit no longer matches')
    return manifest


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--job', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--verify', action='store_true')
    args = parser.parse_args()
    if not args.verify and args.job is None:
        parser.error('--job is required to create a recovery')
    report = verify_recovery(args.output) if args.verify else recover(args.job, args.output)
    print(json.dumps({key: value for key, value in report.items() if key != 'source_evidence'}, indent=2))

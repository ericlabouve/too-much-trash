"""Preflight immutable candidate packages before spending reviewer allocations."""

from hashlib import sha256
import json
from pathlib import Path

PROTOCOL = 'frozen-bundle-v1'


def local_file(job, value):
    if not isinstance(value, str) or not value:
        raise ValueError('Review bundle paths must be nonempty')
    path = (Path(job) / value).resolve(strict=True)
    if not path.is_relative_to(Path(job).resolve()) or not path.is_file() or not path.stat().st_size:
        raise ValueError('Review bundle files must remain nonempty inside this job')
    return path


def artifact_graph(job, bundle, candidate_name):
    candidate = bundle.get('candidate', {})
    if candidate.get('name') != candidate_name or type(bundle.get('learned')) is not bool:
        raise ValueError('Review bundle must identify its exact candidate and learned status')
    files, roles = {}, set()
    for record in bundle.get('files', []):
        path = local_file(job, record.get('path'))
        key = str(path.relative_to(Path(job).resolve()))
        if key in files:
            raise ValueError(f'Duplicate frozen artifact path: {key}; use one record per file')
        digest = sha256(path.read_bytes()).hexdigest()
        if record.get('sha256') != digest:
            raise ValueError('Frozen review artifact hash is stale')
        role = record.get('role')
        if role not in {'implementation', 'evaluator', 'model', 'config', 'dependency'}:
            raise ValueError('Frozen artifact role is invalid')
        files[key] = {'sha256': digest, 'role': role}
        roles.add(role)
    if (not {'implementation', 'evaluator'} <= roles
            or (bundle['learned'] and 'model' not in roles)
            or (not bundle['learned'] and not {'model', 'config'} & roles)):
        raise ValueError('Review bundle requires implementation, evaluator and model/config artifacts')
    return {'candidate': candidate, 'learned': bundle['learned'], 'files': files}


def preflight_bundle(job, filename, candidate_name):
    path = local_file(job, filename)
    raw = path.read_bytes()
    envelope = json.loads(raw)
    if envelope.get('candidate', {}).get('name') != candidate_name:
        raise ValueError('Review package is scoped to a different candidate')
    graph = artifact_graph(job, envelope.get('artifact_bundle', {}), candidate_name)
    if graph['candidate'] != envelope['candidate']:
        raise ValueError('Review package candidate and frozen graph disagree')
    context = envelope.get('context', {}).get('context_sha256')
    if not isinstance(context, str) or len(context) != 64 or any(c not in '0123456789abcdef' for c in context):
        raise ValueError('Review package requires its frozen evaluation context hash')
    return {'path': str(path), 'sha256': sha256(raw).hexdigest(), 'graph': graph,
            'context_sha256': context}

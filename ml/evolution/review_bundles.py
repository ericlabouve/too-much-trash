"""Preflight immutable candidate packages before spending reviewer allocations."""

from hashlib import sha256
import json
from pathlib import Path

PROTOCOL = 'frozen-bundle-v1'


class ReviewReportError(ValueError):
    """A completed review needs report packaging correction, not new review work."""


def review_decision_digest(report):
    rows = report.get('candidates', []) if isinstance(report, dict) else []
    row = rows[0] if rows and isinstance(rows[0], dict) else {}
    decision = {key: row.get(key) for key in ('verdict', 'findings', 'checks', 'inspected_paths')}
    return sha256(json.dumps(decision, sort_keys=True, separators=(',', ':')).encode()).hexdigest()


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


def preflight_report(job, filename, pinned, reviewer_id):
    """Check report structure before a reviewer loses its live export context.

    This never approves a verdict or substitutes for the outer integrity audit.
    Both approved and rejected verdicts are valid exports.
    """
    report = json.loads(local_file(job, filename).read_text())
    candidate = pinned['graph']['candidate']
    rows = report.get('candidates') if isinstance(report, dict) else None
    if (not isinstance(rows, list) or len(rows) != 1 or not isinstance(rows[0], dict)
            or rows[0].get('candidate') != candidate):
        raise ReviewReportError('candidates[0].candidate must be the FULL exact candidate object from the frozen package, not its name string')
    if (report.get('reviewer_id') != reviewer_id or report.get('candidate_name') != candidate['name']
            or report.get('fresh_context') is not True
            or report.get('context_sha256') != pinned['context_sha256']):
        raise ReviewReportError('Review report must identify its actual reviewer, frozen candidate and context')
    expected = {key: value['sha256'] for key, value in pinned['graph']['files'].items()}
    if rows[0].get('artifact_hashes') != expected:
        raise ReviewReportError('Review report artifact_hashes must cover the exact dispatched frozen graph')
    if rows[0].get('verdict') not in ('approved', 'rejected'):
        raise ReviewReportError('Review report must preserve an explicit approved or rejected verdict')
    return report

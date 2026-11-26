"""Fail-closed receipts for independent, implementation-backed streaming integrity reviews.

These checks bind reviews to frozen artifacts and substantive probe evidence. They
cannot prove that a reviewer or arbitrary probe program is honest; independent
source inspection and execution by the reviewers remain part of the gate.
"""

from hashlib import sha256
import ast
from collections import Counter
import json
from math import isclose, isfinite
from pathlib import Path

POLICY_VERSION = 'continuous-v1'
REVIEW_PROTOCOL = 'per-candidate-v1'
PROBE_KINDS = ('timestamp_origin_shift', 'variable_prefix', 'continuous_multiple_events',
               'no_event_stream', 'prefix_causality')


def local_artifact(job, filename):
    path = Path(filename)
    path = (path if path.is_absolute() else job / path).resolve(strict=True)
    if not path.is_relative_to(job.resolve()) or not path.is_file() or not path.stat().st_size:
        raise ValueError('Integrity evidence must be a nonempty file inside this job')
    return path


def hashed_artifact(job, record):
    path = local_artifact(job, record['path'])
    digest = sha256(path.read_bytes()).hexdigest()
    if record.get('sha256') != digest:
        raise ValueError('Integrity review is stale: a frozen artifact hash changed')
    return str(path.relative_to(job.resolve())), path, digest


def nonempty_text(value):
    return isinstance(value, str) and bool(value.strip())


def review_context(job, result, settings, manifests, evaluation_path):
    """Bind reviews to the exact scoring context without reading reserved test inputs."""
    hashes = {'policy_version': POLICY_VERSION, 'round': result['round'],
              'settings_sha256': sha256(json.dumps(settings, sort_keys=True).encode()).hexdigest(),
              'evaluation_sha256': sha256(local_artifact(job, evaluation_path).read_bytes()).hexdigest(),
              **{f'{split}_manifest_sha256': sha256(local_artifact(job, manifests[split]).read_bytes()).hexdigest()
                 for split in ('train', 'validation')}}
    hashes['context_sha256'] = sha256(json.dumps(hashes, sort_keys=True).encode()).hexdigest()
    return hashes


def same_values(left, right):
    return len(left) == len(right) and all(isclose(a, b, rel_tol=0, abs_tol=1e-6) for a, b in zip(left, right))


def same_events(left, right):
    return len(left) == len(right) and all(a[0] == b[0] and isclose(a[1], b[1], rel_tol=0, abs_tol=1e-6)
                                         for a, b in zip(left, right))


def verify_probe(job, evidence_path, candidate_name, kind, frozen, context_sha256):
    evidence = json.loads(local_artifact(job, evidence_path).read_text())
    if (evidence.get('kind') != kind or evidence.get('candidate_name') != candidate_name
            or not nonempty_text(evidence.get('entrypoint'))
            or not nonempty_text(evidence.get('observations'))
            or evidence.get('artifact_hashes') != frozen or evidence.get('context_sha256') != context_sha256):
        raise ValueError('Streaming probe must identify the native candidate, frozen artifacts and observations')
    entry_key, entry_source, entry_digest = hashed_artifact(job, evidence['entrypoint_source'])
    symbol = evidence['entrypoint'].split('.')[-1]
    if (frozen.get(entry_key) != entry_digest or entry_source.suffix != '.py'
            or not any(isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)) and node.name == symbol
                       for node in ast.walk(ast.parse(entry_source.read_text())))):
        raise ValueError('Streaming probe entrypoint must name a native callable in the frozen implementation')
    _, runner, _ = hashed_artifact(job, evidence['runner'])
    command = evidence.get('command', [])
    if (not isinstance(command, list) or not command or not all(nonempty_text(item) for item in command)
            or not any(item in (str(runner), str(runner.relative_to(job.resolve()))) for item in command)):
        raise ValueError('Streaming probe requires its actual native runner invocation')
    inputs = evidence.get('inputs', [])
    if not inputs:
        raise ValueError('Streaming probe requires hashed input fixtures')
    for record in inputs:
        hashed_artifact(job, record)
    _, output_path, _ = hashed_artifact(job, evidence['outputs'])
    output = json.loads(output_path.read_text())
    streams = output.get('streams', [])
    if (output.get('kind') != kind or output.get('candidate_name') != candidate_name
            or type(output.get('native_calls')) is not int or output['native_calls'] < 1
            or not streams):
        raise ValueError('Streaming probe requires actual native-call and stream outputs, not a pass flag')
    for stream in streams:
        times = stream.get('sample_times_seconds', [])
        scores = stream.get('scores', [])
        if (type(stream.get('sample_count')) is not int or stream['sample_count'] < 2
                or not isinstance(stream.get('detections'), list)
                or len(times) != stream['sample_count'] or len(scores) != stream['sample_count']
                or any(type(value) not in (int, float) or not isfinite(value) for value in [*times, *scores])
                or any(b <= a for a, b in zip(times, times[1:]))):
            raise ValueError('Streaming probe outputs must contain sampled streams and native detections')
        for event in stream['detections']:
            if (not isinstance(event, list) or len(event) != 2 or event[0] not in ('close', 'open')
                    or type(event[1]) not in (int, float) or not isfinite(event[1])):
                raise ValueError('Streaming probe detections must be timestamped native close/open outputs')
    details = evidence.get('details', {})
    if kind == 'timestamp_origin_shift':
        offsets = details.get('offsets_seconds', [])
        if (len(streams) < 2 or len(offsets) != len(streams) or len(set(offsets)) < 2
                or any(type(value) not in (int, float) or not isfinite(value) for value in offsets)):
            raise ValueError('Timestamp-origin probe requires distinct offsets and translated-output comparison')
        baseline_times = [value - offsets[0] for value in streams[0]['sample_times_seconds']]
        baseline_events = [(kind, value - offsets[0]) for kind, value in streams[0]['detections']]
        for stream, offset in zip(streams[1:], offsets[1:]):
            if (not same_values(baseline_times, [value-offset for value in stream['sample_times_seconds']])
                    or not same_values(streams[0]['scores'], stream['scores'])
                    or not same_events(baseline_events, [(kind, value-offset) for kind, value in stream['detections']])):
                raise ValueError('Timestamp-translated native scores/detections are inconsistent')
    elif kind == 'variable_prefix':
        lengths = details.get('prefix_lengths_seconds', [])
        if (len(streams) < 2 or len(lengths) != len(streams) or len(set(lengths)) < 2
                or any(type(value) not in (int, float) or not isfinite(value) or value <= 0 for value in lengths)
                or len({stream['sample_count'] for stream in streams}) < 2
                or details.get('real_prefix_samples_inserted') is not True
                or not nonempty_text(details.get('padding_sensitivity_analysis'))):
            raise ValueError('Variable-prefix probe must insert different nonzero sample prefixes, not just shift timestamps')
        # Changed real inputs can legitimately affect adaptive state; don't equate
        # imperfect padding invariance or weaker accuracy with dishonest behavior.
        # Require observable prefix coverage plus an independent source-supported analysis.
        for stream, length in zip(streams, lengths):
            if stream['sample_times_seconds'][-1] - stream['sample_times_seconds'][0] <= length:
                raise ValueError('Inserted prefix must be followed by actual candidate samples')
    elif kind == 'continuous_multiple_events':
        references = details.get('reference_detections', [])
        boundaries = details.get('chunk_boundary_indices', [])
        if (len(streams) < 2 or details.get('state_reset_between_segments') is not False
                or type(details.get('segments')) is not int or details['segments'] < 2
                or type(details.get('reference_events')) is not int or details['reference_events'] < 4
                or details.get('native_state_persisted') is not True
                or details.get('arbitrary_chunk_boundaries') is not True
                or streams[0]['sample_count'] != streams[1]['sample_count']
                or not same_values(streams[0]['sample_times_seconds'], streams[1]['sample_times_seconds'])
                or not same_values(streams[0]['scores'], streams[1]['scores'])
                or not same_events(streams[0]['detections'], streams[1]['detections'])):
            raise ValueError('Continuous probe requires multiple event cycles with persistent native state and no boundary resets')
        times = streams[0]['sample_times_seconds']
        if (len(times) < 20 or len(references) < 4
                or any(not isinstance(event, list) or len(event) != 2 or event[0] not in ('close', 'open')
                       or type(event[1]) not in (int, float) or not isfinite(event[1])
                       or not times[0] <= event[1] <= times[-1] for event in references)
                or [event[0] for event in references[:4]] != ['close', 'open', 'close', 'open']
                or any(b[1] <= a[1] for a, b in zip(references, references[1:]))
                or not boundaries or any(type(index) is not int or not 0 < index < len(times) for index in boundaries)
                or streams[1].get('chunk_boundaries') != boundaries
                or not any(references[0][1] < times[index] < references[1][1] for index in boundaries)):
            raise ValueError('Continuous probe must record actual reference event times and a chunk boundary during a hold')
    elif kind == 'no_event_stream':
        duration = details.get('duration_seconds')
        if (len(streams) < 2 or type(duration) not in (int, float) or not isfinite(duration) or duration < 12
                or set(details.get('initial_states', [])) != {'open', 'closed'}
                or details.get('reference_events') != 0 or any(stream['detections'] for stream in streams)):
            raise ValueError('No-event probe requires an event-free stream of at least twelve seconds without timer triggers')
        for stream in streams:
            times = stream['sample_times_seconds']
            if stream['sample_count'] < 120 or times[-1] - times[0] < 12 or max(b-a for a,b in zip(times,times[1:])) > .25:
                raise ValueError('No-event probe must actually sample the full twelve-second interval')
    elif kind == 'prefix_causality':
        prefix = details.get('shared_prefix_samples')
        if (len(streams) < 2 or details.get('altered_future_suffix') is not True
                or type(prefix) is not int or prefix < 2 or any(prefix >= stream['sample_count'] for stream in streams)
                or details.get('matching_prefix_outputs') is not True):
            raise ValueError('Causality probe requires matching prefixes with genuinely changed future samples')
        cut = streams[0]['sample_times_seconds'][prefix - 1]
        if (not same_values(streams[0]['sample_times_seconds'][:prefix], streams[1]['sample_times_seconds'][:prefix])
                or not same_values(streams[0]['scores'][:prefix], streams[1]['scores'][:prefix])
                or not same_events([event for event in streams[0]['detections'] if event[1] <= cut],
                                   [event for event in streams[1]['detections'] if event[1] <= cut])):
            raise ValueError('Changed future inputs altered native prefix outputs')
    if output['native_calls'] < sum(stream['sample_count'] for stream in streams):
        raise ValueError('Streaming probe must call the native step for all recorded samples')
    return output_path


def verify_integrity_reviews(job, result, receipts, settings, context=None, learned_candidates=()):
    """Verify legacy shared reviews or fresh candidate-scoped review assignments."""
    if 'review_agents' not in settings:
        if 'review_protocol' in settings:
            raise ValueError('A configured final-review protocol requires its reviewer count')
        return None  # Historical receipt audit, never retroactive integrity approval.
    count = settings['review_agents']
    if type(count) is not int or not 1 <= count <= 5:
        raise ValueError('Final review_agents must be between one and five')
    protocol = settings.get('review_protocol')
    if protocol not in (None, REVIEW_PROTOCOL):
        raise ValueError('Unknown final-review protocol')
    per_candidate = protocol == REVIEW_PROTOCOL
    if not context or not nonempty_text(context.get('context_sha256')):
        raise ValueError('Integrity review requires the frozen scoring/split/evaluation context')
    candidates = {entry['candidate']['name']: entry['candidate'] for entry in result.get('challengers', [])}
    if per_candidate and not candidates:
        raise ValueError('Candidate-scoped final review requires at least one challenger')
    expected_count = count * len(candidates) if per_candidate else count
    bundles = result.get('candidate_artifacts', {})
    if set(bundles) != set(candidates):
        raise ValueError('Every challenger needs an exact frozen candidate artifact bundle')
    frozen = {}
    for name, candidate in candidates.items():
        bundle = bundles[name]
        if bundle.get('candidate') != candidate or type(bundle.get('learned')) is not bool:
            raise ValueError('Frozen integrity bundle must match the exact candidate configuration')
        if name in learned_candidates and not bundle['learned']:
            raise ValueError('A fitted candidate cannot omit its learned-model artifact')
        roles, files = set(), {}
        for record in bundle.get('files', []):
            key, _, digest = hashed_artifact(job, record)
            if key in files:
                raise ValueError('Frozen integrity artifact paths must be unique')
            files[key] = digest
            roles.add(record.get('role'))
        if (not {'implementation', 'evaluator'} <= roles or (bundle['learned'] and 'model' not in roles)
                or (not bundle['learned'] and not {'model', 'config'} & roles)):
            raise ValueError('Integrity bundle must freeze implementation, evaluator and learned model artifacts')
        frozen[name] = files
    tasks = receipts.get('tasks', [])
    reviewers = [task for task in tasks if task.get('kind') == 'integrity_review']
    reviewer_ids = {task.get('agent_id') for task in reviewers}
    author_ids = {task.get('agent_id') for task in tasks if task.get('kind') != 'integrity_review'}
    if (len(reviewers) != expected_count or len(reviewer_ids) != expected_count
            or not all(nonempty_text(identifier) for identifier in reviewer_ids)
            or reviewer_ids & author_ids or any(task.get('status') != 'completed' for task in reviewers)):
        raise ValueError('Final integrity reviewers must be distinct, completed and independent of all proposal/architecture agents')
    if per_candidate:
        if any(not nonempty_text(task.get('candidate_name')) for task in reviewers):
            raise ValueError('Every fresh final-review task needs one assigned candidate name')
        assignments = Counter(task.get('candidate_name') for task in reviewers)
        if assignments != Counter({name: count for name in candidates}):
            raise ValueError('Every challenger needs exactly the configured candidate-scoped reviewer assignments')
        for task in reviewers:
            if task.get('fresh_context') is not True:
                raise ValueError('Each candidate reviewer must start with a fresh independent context')
            local_artifact(job, task.get('prompt_path', ''))
    reviews = receipts.get('integrity_reviews', [])
    if len(reviews) != expected_count or {review.get('reviewer_id') for review in reviews} != reviewer_ids:
        raise ValueError('Every configured final reviewer needs an integrity report')
    candidate_reviewers = {name: [] for name in candidates}
    used_reports, used_probe_evidence, used_probe_outputs = set(), set(), set()
    for receipt in reviews:
        report_path = local_artifact(job, receipt['artifact'])
        if report_path in used_reports:
            raise ValueError('Independent reviewers need separate reports')
        used_reports.add(report_path)
        task = next(task for task in reviewers if task['agent_id'] == receipt['reviewer_id'])
        if report_path != local_artifact(job, task['artifact']):
            raise ValueError('Integrity report must match the reviewer task artifact')
        report = json.loads(report_path.read_text())
        reports = report.get('candidates', [])
        assigned = {task['candidate_name']} if per_candidate else set(candidates)
        if per_candidate:
            name = task['candidate_name']
            if (receipt.get('candidate_name') != name or report.get('candidate_name') != name
                    or report.get('fresh_context') is not True):
                raise ValueError('Candidate review task, receipt and fresh report must identify the same assigned candidate')
        if (report.get('reviewer_id') != receipt['reviewer_id'] or report.get('context_sha256') != context['context_sha256']
                or len(reports) != len(assigned)
                or {item.get('candidate', {}).get('name') for item in reports} != assigned):
            raise ValueError('Each candidate-scoped reviewer must review only its assigned challenger' if per_candidate
                             else 'Each final reviewer must review every challenger, including pruned proposals')
        for review in reports:
            name = review['candidate']['name']
            candidate_reviewers[name].append(receipt['reviewer_id'])
            if review['candidate'] != candidates[name] or review.get('artifact_hashes') != frozen[name]:
                raise ValueError('Final review does not cover the exact frozen candidate and implementation')
            if review.get('verdict') != 'approved':
                raise ValueError(f'Final integrity reviewer rejected {name}; preserve the prior pool')
            inspected = {str(local_artifact(job, path).relative_to(job.resolve())) for path in review.get('inspected_paths', [])}
            if not set(frozen[name]) <= inspected:
                raise ValueError('Final reviewer must inspect every frozen implementation/model/evaluator artifact')
            findings = review.get('findings', [])
            if not findings or not all(nonempty_text(finding) for finding in findings):
                raise ValueError('Final integrity review needs substantive source-inspection findings')
            checks = review.get('checks', [])
            if len(checks) != len(PROBE_KINDS) or {check.get('kind') for check in checks} != set(PROBE_KINDS):
                raise ValueError('Final integrity review requires all five distinct streaming counterfactual probes')
            for check in checks:
                if check.get('passed') is not True:
                    raise ValueError('An unsuccessful streaming probe blocks admission')
                evidence_path = local_artifact(job, check['evidence'])
                if evidence_path in used_probe_evidence:
                    raise ValueError('Final reviewers require separately recorded native probe evidence')
                used_probe_evidence.add(evidence_path)
                output = verify_probe(job, evidence_path, name, check['kind'], frozen[name], context['context_sha256'])
                if output in used_probe_outputs:
                    raise ValueError('Final reviewers require separately recorded native probe outputs')
                used_probe_outputs.add(output)
    statuses = {entry['candidate']['name']: 'legacy_unreviewed' for entry in result.get('incumbents', [])}
    statuses.update({name: 'approved' for name in candidates})
    return {'status': 'approved', 'scope': 'all_challengers', 'reviewers': sorted(reviewer_ids),
            'candidates': sorted(candidates), 'candidate_status': statuses, 'policy_version': POLICY_VERSION,
            'review_protocol': protocol or 'legacy-shared-review',
            'reviewers_per_candidate': count,
            'candidate_reviewers': {name: sorted(identifiers) for name, identifiers in candidate_reviewers.items()},
            'context': context}

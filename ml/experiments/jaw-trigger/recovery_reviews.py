"""Prepare fresh supervised reviews for an evaluated, immutable recovery job.

This module never starts author tasks, fits, inference, or a new breeding round.
The coordinator dispatches the returned plan through evolution_agents MCP only.
"""

import argparse
from collections import Counter
from copy import deepcopy
from hashlib import sha256
import json
from pathlib import Path
import sys
from tempfile import NamedTemporaryFile

from dashboard_integrity import PROBE_KINDS, review_context, local_artifact
from deployment_benchmark import verify_deployment_benchmarks
from ml.evolution.agent_briefs import EXPERIMENT_GUIDELINES
from ml.evolution.review_bundles import preflight_bundle, preflight_report

HERE = Path(__file__).resolve().parent
REPOSITORY = HERE.parents[2]


def _read(path):
    return json.loads(Path(path).read_text())


def _write_new(path, value):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    # Fresh plans cannot silently replace a frozen package or dispatched prompt.
    with path.open('x') as stream:
        stream.write(value if isinstance(value, str) else json.dumps(value, indent=2) + '\n')


def review_prompt(job, spec, bundle, folder, preflight, original_direction=''):
    name = spec['candidate']['name']
    mode = spec.get('input_mode', 'legacy-gray-v1')
    return f'''You are a freshly initialized independent final integrity reviewer assigned to EXACTLY ONE recovered candidate: {name}.
Read AGENTS.md and the project's evolve/ML skills and relevant READMEs. This is evaluation-only recovery of existing Round 60, not a new evolutionary round or permission to retrain. All original author allocations are closed. Inspect the frozen package {bundle} and write ONLY your own runner, fixtures, evidence and report under {folder}. Do not read another reviewer's findings or reuse another reviewer's outputs. No candidate/model edits, fitting, parameter search, benchmarks, reserved test manifest/media, native Goal, delegation or detached processes.

Independently run this canonical recovery preflight from the repository root before issuing a verdict:
{json.dumps(preflight)}
The gate checks the original immutable source/archive, whole training journal, selected model bindings and deployment evidence. Its success complements source inspection; it is not an independent review verdict. A failed canonical gate blocks approval. Do not replace it with a permissive handwritten checker or change original identities, receipt bytes or budgets.

Read the candidate's exact saved plan/receipt/checkpoint/history and relevant exploratory attempts and crashes. Inspect all learned components, original fitting code, checkpoint selection, data splits, regularization/control rationale and both inference-mode loss calculations. Verify bare saved model equals candidate_parameters[candidate.name] and its selected checkpoint. Different candidates can share an architecture method with different trained weights. Inspect actual deployed runtime plus preprocessing, decoder, source hashes and final native train/validation trace predictions/timings. The final deployment artifact alone supplies inference, including all model-specific crop/resize/color/features/fusion; Python prototype predictions are not a substitute.

Runtime input mode is {mode}. For paired-rgb-v1, every probe must call the ACTUAL RGB deployment step on raw TRAIN pixels, optional exact grayscale and causal sensor samples; do not claim RGB coverage from grayscale-only probes. Use current deployment-spec runtime_config, input_dispatch.py and the actual selected adapter. Raw buffer loading may be untimed, but all model-specific processing must be inside the deployed step. Mmap/frame-index recipes avoid giant repeated arrays. Ground truth and host clip IDs stay outside inference payloads.

Run all five distinct real native counterfactual probes, saving actual numeric sample times, scores, calls and detections with hash-bound runner/input/output evidence:
1. timestamp_origin_shift: translated timestamps and correspondingly aligned causal sensors must preserve scores and translated events.
2. variable_prefix: insert genuine different-length raw frame prefixes, not just timestamp offsets; document source-supported state/startup sensitivity.
3. continuous_multiple_events: the SAME persistent detector handles irregular alternating transitions across arbitrary chunk boundaries, including a held squeeze crossing a boundary. Save identical matching input streams processed monolithically and chunked without resetting; declare references outside inference.
4. no_event_stream: genuine static OPEN and CLOSED controls must EACH cover at least 12 seconds and 120 regularly sampled calls. Save the states' real source pixels and any causal sensor adaptation. Do not hand-copy scores.
5. prefix_causality: change actual FUTURE input pixels/sensors and verify unchanged earlier scores/events. For RGB change the future RGB frames, not merely an unused grayscale channel.

These are implementation integrity probes, NOT validation of natural uninterrupted hour-long field footage; none exists yet. A weak honest detector need not perfectly recognize every constructed repeated event. Do not confuse poor recognition with reward hacking, but reject episode clocks, 3s/-3s cues, source IDs, labels, future observations, one-pair quotas, ground-truth resets, unbounded state or backdated emitted events. Runtime state must be bounded and causal. Explain substantive findings with source references and actual probe outputs. Your location-adapted starter {folder / 'probe_runner.py'} supplies code only, NO outputs or verdict. Read its scaffold-provenance.json, independently inspect and adapt it, then run its prepare and five named probe commands yourself. It preserves deployment runtime_config and scanlines factory support. Entry-point evidence must name the ACTUAL bound step implementation and a frozen source file whose AST declares step, even when adapter_path only imports that class. The starter derives this with inspect.getsourcefile(detector.step), rejects non-frozen source paths, and does not treat an import-only wrapper as implementation. The optional review_report_template.py helper under {job} accepts your own findings and checks. The old shared review_audit_template.py has original folder assumptions and must not be run unmodified. No template supplies a verdict or evidence pass.

Your actual reviewer identity will be written by the coordinator to {folder / 'reviewer-identity.json'} after supervisor registration. Use its actual agent_id, never invent one. Inspect source while identity registration is pending. Final report path is {folder / 'report.json'}. Use ml.evolution.review_bundles.preflight_bundle and write_review_report to serialize YOUR OWN verdict, nonempty findings[str], all inspected frozen paths and exactly five kind/passed/evidence check records; call preflight_report before finishing. Put any other diagnostics outside checks. Preserve rejections and concrete reasons. No repair or new author allocation is permitted in this review.

You have the configured hard 20-minute review allocation from actual start; finish when your work is complete. Final response JSON: status ready or blocked, summary, artifact (absolute nonempty report path), candidate_name exactly {json.dumps(name)}. A structurally complete rejected report uses status ready; the separate verdict determines admission. If unable to complete honest checks, report blocked and concrete evidence rather than fabricate passes.

SHARED GUIDELINES (author instructions are context only; do not fit or evolve during review):
{EXPERIMENT_GUIDELINES}

ORIGINAL USER ROUND DIRECTION, VERBATIM (historical author context only; the recovery no-training/no-new-author restrictions above control your review):
{original_direction}
'''


def write_probe_starter(job, bundle, folder):
    """Adapt only known scaffolding; generate no inputs, outputs or decisions."""
    job, bundle, folder = Path(job).resolve(strict=True), Path(bundle).resolve(), Path(folder).resolve()
    if not folder.is_relative_to(job) or not bundle.is_relative_to(job):
        raise ValueError('Probe scaffolds and candidate bundles must stay inside the recovery job')
    source = local_artifact(job, 'probe_runner_template.py')
    template = source.read_text()
    replacements = [
        ('import sys,json,hashlib,importlib.util', 'import sys,json,hashlib,importlib.util,inspect'),
        ('J=Path(__file__).resolve().parents[2];D=Path(__file__).parent',
         f'J=Path({str(job)!r});D=Path(__file__).parent'),
        ("B=json.loads((J/'review-bundles'/(D.name+'.json')).read_text())",
         f'B=json.loads(Path({str(bundle)!r}).read_text())'),
        (" try:\n  edges=[0,*boundaries,len(recipe)]",
         " entry_source=Path(inspect.getsourcefile(d.step)).resolve(strict=True)\n"
         " if not entry_source.is_relative_to(J) or FROZEN.get(str(entry_source.relative_to(J)))!=sha(entry_source):\n"
         "  raise ValueError('Actual native step implementation must belong to the frozen candidate graph')\n"
         " entrypoint={'name':d.step.__qualname__,'source':rec(entry_source)}\n"
         " try:\n  edges=[0,*boundaries,len(recipe)]"),
        (" return {'sample_count':len(scores)", " return {'entrypoint':entrypoint,'sample_count':len(scores)"),
        (" out={'kind':kind", " assert all(s['entrypoint']==streams[0]['entrypoint'] for s in streams)\n out={'kind':kind"),
        ("'entrypoint':'NativeDetector.step','entrypoint_source':rec(J/B['spec']['adapter_path'])",
         "'entrypoint':streams[0]['entrypoint']['name'],'entrypoint_source':streams[0]['entrypoint']['source']"),
    ]
    for old, new in replacements:
        if template.count(old) != 1:
            raise ValueError('Probe starter template changed; adapt explicitly before dispatch')
        template = template.replace(old, new, 1)
    compile(template, str(folder / 'probe_runner.py'), 'exec')
    _write_new(folder / 'probe_runner.py', template)
    _write_new(folder / 'scaffold-provenance.json', {
        'source_path': str(source.relative_to(job)), 'source_sha256': sha256(source.read_bytes()).hexdigest(),
        'generated_path': str((folder / 'probe_runner.py').relative_to(job)),
        'generated_sha256': sha256(template.encode()).hexdigest(),
        'changes': ['explicit recovery job and candidate bundle paths',
                    'actual bound step implementation source rather than import-only adapter wrapper'],
        'contains_probe_outputs': False, 'contains_review_verdict': False})


def prepare_reviews(job, *, python=sys.executable, binary='codex', preflight_command=None):
    job = Path(job).resolve(strict=True)
    config, result, evaluation = (_read(local_artifact(job, filename))
                                  for filename in ('config.json', 'results.json', 'evaluation.json'))
    settings = deepcopy(config['settings'])
    if settings.get('review_protocol') != 'per-candidate-v1' or settings.get('review_bundle_protocol') != 'frozen-bundle-v1':
        raise ValueError('Recovery requires independent, frozen candidate-scoped reviews')
    if type(settings.get('review_agents')) is not int or not 1 <= settings['review_agents'] <= 5:
        raise ValueError('Recovery needs one to five reviewers per candidate')
    if settings.get('agent_minutes') != 20 or settings.get('agent_concurrency') != 6:
        raise ValueError('This recovery retains the approved 20-minute, six-agent settings')
    challengers = {row['candidate']['name']: row['candidate'] for row in result['challengers']}
    all_entries = [*result['incumbents'], *result['challengers']]
    all_candidates = {entry['candidate']['name']: entry['candidate'] for entry in all_entries}
    if not challengers or len(all_candidates) != len(all_entries):
        raise ValueError('Recovery needs unique frozen parent and challenger identities')
    specs = _read(local_artifact(job, 'deployment-specs.json'))
    challenger_specs = {spec['candidate']['name']: spec for spec in specs if not spec['incumbent']}
    if set(challenger_specs) != set(challengers) or any(challenger_specs[n]['candidate'] != c for n, c in challengers.items()):
        raise ValueError('Every challenger needs its unchanged exact deployment spec')
    manifests = {split: _read(local_artifact(job, f'{split}.json'))['clips'] for split in ('train', 'validation')}
    verify_deployment_benchmarks(job, evaluation, all_candidates,
                                  [r['clip'] for r in manifests['train']],
                                  [r['clip'] for r in manifests['validation']],
                                  result.get('candidate_artifacts', {}))
    context = review_context(job, result, settings, {s: job / f'{s}.json' for s in manifests}, job / 'evaluation.json')
    command = preflight_command or [python, str(HERE / 'recovery_completion.py'), '--job', str(job), '--preflight']
    if not isinstance(command, list) or not command or any(not isinstance(v, str) or not v for v in command):
        raise ValueError('Recovery reviews require an explicit trusted canonical preflight command')
    runtime = {'protocol': 'supervised-v1', 'job': str(job), 'repository': str(REPOSITORY),
               'binary': binary, 'settings': settings, 'review_report_probe_kinds': list(PROBE_KINDS),
               'review_preflight_command': command, 'parent_candidates': {},
               'expected': {'parent': [], 'research': 0, 'review': 0,
                            'integrity_review': len(challengers) * settings['review_agents']},
               'ledger_path': str(job.parent / '.agent-runtime' / f'{job.name}.json')}
    plan = []
    for name, candidate in challengers.items():
        spec = challenger_specs[name]
        slug = spec['slug']
        if not isinstance(slug, str) or not slug or Path(slug).name != slug:
            raise ValueError('Recovery review slugs must be simple directory names')
        bundle = job / 'review-bundles-recovery' / f'{slug}.json'
        package = {'candidate': candidate, 'artifact_bundle': result['candidate_artifacts'][name],
                   'metadata': result.get('candidate_metadata', {}).get(name, {}), 'context': context,
                   'settings': settings, 'train_manifest': 'train.json', 'validation_manifest': 'validation.json',
                   'evaluation_path': 'evaluation.json', 'evaluation_sha256': sha256((job / 'evaluation.json').read_bytes()).hexdigest(),
                   'training_receipt': evaluation.get('training_receipts', {}).get(name),
                   'training_predictions': evaluation['training_predictions'][name],
                   'validation_predictions': evaluation['predictions'][name],
                   'timings_ms': evaluation['timings_ms'][name],
                   'deployment_report': evaluation['deployment_benchmarks'][name], 'spec': spec,
                   'fixtures': 'Fixtures/clips.json', 'fixture_provenance': 'fixture-provenance.json',
                   'recovery': {'mode': 'evaluation_and_reviews_only', 'new_fitting_allowed': False,
                                'continuous_field_validation': 'pending_new_footage'}}
        _write_new(bundle, package)
        preflight_bundle(job, str(bundle), name)
        for slot in range(1, settings['review_agents'] + 1):
            folder = job / 'reviews-recovery' / f'{slug}-review-{slot}'
            prompt = folder / 'prompt.txt'
            write_probe_starter(job, bundle, folder)
            _write_new(prompt, review_prompt(job, spec, bundle, folder, command, settings.get('agent_prompt', '')))
            plan.append({'kind': 'integrity_review', 'candidate_name': name, 'review_slot': slot,
                         'folder': str(folder), 'review_bundle': str(bundle), 'prompt_path': str(prompt)})
    _write_new(job / 'runtime-config-recovery.json', runtime)
    _write_new(job / 'review-dispatch-plan.json', plan)
    return {'runtime_config': str(job / 'runtime-config-recovery.json'), 'tasks': plan,
            'author_tasks': 0, 'review_tasks': len(plan), 'context': context}


def index_completed_reviews(job):
    """Index sealed, actual completed reviews; never change reviewer decisions.

    Only metadata absent from a coordinator manifest is reconstructed. The
    private supervisor ledger and private first-turn event streams establish the
    actual identities, while frozen-bundle/report preflights establish scope.
    This is packaging, not approval: rejected reports remain rejected verbatim.
    """
    job = Path(job).resolve(strict=True)
    receipt = job.parent / '.verified-completions' / f'{job.name}.json'
    status = _read(local_artifact(job, 'status.json'))
    if receipt.exists() or status.get('state') == 'completed':
        raise ValueError('Published/completed jobs cannot refresh review indexes')
    config = _read(local_artifact(job, 'config.json'))
    proof = config.get('recovery', {})
    if proof.get('protocol') != 'saved-round-completion-v1':
        raise ValueError('Review indexing requires an explicit recovery job')
    runtime = _read(local_artifact(job, 'runtime-config-recovery.json'))
    private = job.parent / '.agent-runtime' / f'{job.name}.json'
    if (runtime.get('protocol') != 'supervised-v1' or Path(runtime.get('job', '')).resolve() != job
            or runtime.get('settings') != config.get('settings')
            or Path(runtime.get('ledger_path', '')).resolve(strict=True) != private.resolve(strict=True)):
        raise ValueError('Review runtime configuration must identify this job and its private ledger')
    ledger_path = local_artifact(job, 'agent-runtime.json')
    ledger_bytes = ledger_path.read_bytes()
    if ledger_bytes != private.read_bytes():
        raise ValueError('Copied review ledger differs from sealed private supervisor evidence')
    ledger = json.loads(ledger_bytes)
    if (ledger.get('protocol') != 'supervised-v1' or Path(ledger.get('job', '')).resolve() != job
            or ledger.get('watchdog_failure') is not None):
        raise ValueError('Only correctly supervised review ledgers can be indexed')
    source = Path(proof['source_job']).resolve(strict=True)
    original = local_artifact(source, 'agents.json')
    if sha256(original.read_bytes()).hexdigest() != proof.get('source_receipts_sha256'):
        raise ValueError('Original author identity evidence changed')
    authors = _read(original)['tasks']
    if not authors or any(row.get('kind') not in ('parent', 'research') or row.get('status') != 'completed' for row in authors):
        raise ValueError('Original author identity evidence must contain completed author tasks')
    author_ids = {row['agent_id'] for row in authors}
    tasks = ledger.get('tasks', [])
    result = _read(local_artifact(job, 'results.json'))
    candidates = {row['candidate']['name'] for row in result['challengers']}
    count = config['settings']['review_agents']
    assignments = Counter(task.get('candidate_name') for task in tasks)
    expected = {'parent': [], 'research': 0, 'review': 0, 'integrity_review': len(candidates) * count}
    if (not tasks or runtime.get('expected') != expected
            or assignments != Counter({name: count for name in candidates})):
        raise ValueError('Every challenger needs exactly the configured fresh review tasks')
    identities, task_ids, indexed_tasks, reports, report_hashes, event_hashes = set(), set(), [], [], [], []
    private_io = private.parent / f'.{private.stem}-io'
    for task in tasks:
        identifier, task_id = task.get('agent_id'), task.get('task_id')
        if (task.get('kind') != 'integrity_review' or task.get('status') != 'ready'
                or not isinstance(identifier, str) or not identifier or identifier != task.get('thread_id')
                or identifier in identities or identifier in author_ids
                or not isinstance(task_id, str) or not task_id or task_id in task_ids
                or len(task.get('cycles', [])) != 1
                or task.get('training_preflight', {}).get('status') != 'passed'):
            raise ValueError('Only distinct, ready, genuinely fresh review identities may be indexed')
        identities.add(identifier); task_ids.add(task_id)
        first = task.get('turns', [{}])[0]
        if first.get('number') != 1 or first.get('phase') != 'review' or first.get('cycle') != 1:
            raise ValueError('Fresh reviewer must start with its own initial review turn')
        mirror = local_artifact(job, first.get('events_path', ''))
        events_path = (private_io / f'{task_id}-turn-001.jsonl').resolve(strict=True)
        if not events_path.is_relative_to(private_io.resolve()) or mirror.read_bytes() != events_path.read_bytes():
            raise ValueError('First-review event mirror must equal private supervisor events')
        events = [json.loads(line) for line in events_path.read_text().splitlines() if line.strip()]
        started = [event.get('thread_id') for event in events if event.get('type') == 'thread.started']
        if not started or set(started) != {identifier}:
            raise ValueError('Freshness requires the actual matching initial thread.started identity')
        pinned = task.get('review_bundle', {})
        current = preflight_bundle(job, pinned.get('path'), task['candidate_name'])
        if current != pinned:
            raise ValueError('Review bundle changed after dispatch')
        report_path = local_artifact(job, task.get('artifact', ''))
        report_bytes = report_path.read_bytes()
        preflight_report(job, str(report_path), pinned, identifier, PROBE_KINDS)
        prompt = local_artifact(job, task.get('prompt_path', ''))
        if prompt != local_artifact(job, first.get('prompt_path', '')):
            raise ValueError('Manifest prompt must be the original supervised review prompt')
        last = task['turns'][-1]
        final = _read(local_artifact(job, last['final_path']))
        if (final.get('status') != 'ready' or final.get('candidate_name') != task['candidate_name']
                or local_artifact(job, final.get('artifact', '')) != report_path):
            raise ValueError('Review report must equal the actual final ready task export')
        indexed_tasks.append({'task_id': task_id, 'agent_id': identifier, 'thread_id': identifier,
                              'kind': 'integrity_review', 'candidate_name': task['candidate_name'],
                              'status': 'completed', 'artifact': str(report_path), 'prompt_path': str(prompt),
                              'summary': task.get('summary', ''), 'supervisor_status': 'ready', 'fresh_context': True})
        reports.append({'reviewer_id': identifier, 'candidate_name': task['candidate_name'], 'artifact': str(report_path)})
        report_hashes.append({'path': str(report_path.relative_to(job)), 'sha256': sha256(report_bytes).hexdigest()})
        event_hashes.append({'task_id': task_id, 'sha256': sha256(events_path.read_bytes()).hexdigest()})
    manifest_path = local_artifact(job, 'agents.json')
    original_bytes = manifest_path.read_bytes()
    manifest = json.loads(original_bytes)
    manifest.update(tasks=indexed_tasks, integrity_reviews=reports)
    # Check sealed source again immediately before the only metadata mutation.
    if private.read_bytes() != ledger_bytes or ledger_path.read_bytes() != ledger_bytes:
        raise ValueError('Supervisor evidence changed during review indexing')
    for record in report_hashes:
        if sha256((job / record['path']).read_bytes()).hexdigest() != record['sha256']:
            raise ValueError('Review report changed during indexing')
    if receipt.exists() or _read(local_artifact(job, 'status.json')).get('state') == 'completed':
        raise ValueError('Published/completed jobs cannot refresh review indexes')
    new_bytes = (json.dumps(manifest, indent=2) + '\n').encode()
    if new_bytes == original_bytes:
        return {'status': 'already_indexed', 'reviewers': len(indexed_tasks),
                'indexed_manifest_sha256': sha256(original_bytes).hexdigest(), 'review_decisions_modified': False}
    old_hash = sha256(original_bytes).hexdigest()
    archive = job / f'agents-before-review-index-{old_hash[:16]}.json'
    audit_path = job / f'review-index-audit-{old_hash[:16]}.json'
    if audit_path.exists():
        raise ValueError('This original manifest already has a review-index audit; preserve it')
    if archive.exists():
        if archive.read_bytes() != original_bytes:
            raise ValueError('Existing coordinator manifest archive has different bytes')
    else:
        with archive.open('xb') as stream:
            stream.write(original_bytes)
    with NamedTemporaryFile(mode='wb', dir=job, prefix='.review-index-', delete=False) as stream:
        stream.write(new_bytes)
        pending = Path(stream.name)
    pending.replace(manifest_path)
    audit = {'status': 'indexed', 'reviewers': len(indexed_tasks), 'archive_path': str(archive.relative_to(job)),
             'original_manifest_sha256': old_hash, 'indexed_manifest_sha256': sha256(manifest_path.read_bytes()).hexdigest(),
             'supervisor_ledger_sha256': sha256(ledger_bytes).hexdigest(), 'reports': report_hashes,
             'initial_private_event_streams': event_hashes, 'review_decisions_modified': False}
    _write_new(audit_path, audit)
    return audit


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--job', type=Path, required=True)
    parser.add_argument('--python', default=sys.executable)
    parser.add_argument('--binary', default='codex')
    parser.add_argument('--index-reports', action='store_true')
    args = parser.parse_args()
    report = (index_completed_reviews(args.job) if args.index_reports else
              prepare_reviews(args.job, python=args.python, binary=args.binary))
    print(json.dumps({key: value for key, value in report.items() if key != 'tasks'}, indent=2))

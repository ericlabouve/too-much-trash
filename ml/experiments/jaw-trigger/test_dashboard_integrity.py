"""Final-review receipts bind actual native-control outputs to immutable artifacts."""

from copy import deepcopy
from hashlib import sha256
import json
from pathlib import Path
import subprocess
import sys
from tempfile import TemporaryDirectory
import unittest
from unittest.mock import patch

from dashboard_integrity import PROBE_KINDS, REVIEW_PROTOCOL, review_context, verify_integrity_reviews
from dashboard_agents import execute, verify_publication, write_publication_receipt

MODEL = '''class Detector:
    def __init__(self, threshold):
        self.threshold, self.state, self.calls = threshold, None, 0
    def step(self, timestamp, value):
        self.calls += 1
        state = value > self.threshold
        event = None if self.state is None or state == self.state else ["close" if state else "open", timestamp]
        self.state = state
        return float(value), event
'''
RUNNER = '''import json,sys
from pathlib import Path
from detector import Detector
fixture=json.loads(Path(sys.argv[1]).read_text());threshold=json.loads(Path(__file__).with_name("model.json").read_text())["threshold"]
streams=[];calls=0
for case in fixture["streams"]:
    detector=Detector(threshold);events=[];scores=[]
    boundaries=case.get("chunk_boundaries",[])
    cuts=[0,*boundaries,len(case["samples"])]
    for start,end in zip(cuts,cuts[1:]):
        for timestamp,value in case["samples"][start:end]:
            score,event=detector.step(timestamp,value);scores.append(score)
            if event:events.append(event)
    calls+=detector.calls
    streams.append({"sample_count":len(scores),"sample_times_seconds":[row[0] for row in case["samples"]],"scores":scores,"detections":events,"chunk_boundaries":boundaries})
Path(sys.argv[2]).write_text(json.dumps({"kind":fixture["kind"],"candidate_name":fixture["candidate_name"],"native_calls":calls,"streams":streams}))
'''


class FinalIntegrityTests(unittest.TestCase):
    def candidate_scoped_fixture(self, job, count=1):
        settings, result, legacy, _ = self.fixture(job)
        settings.update(review_protocol=REVIEW_PROTOCOL, review_agents=count)
        first = result['challengers'][0]['candidate']
        second = {**first, 'name': 'second native control'}
        result['challengers'].append({'candidate': second})
        result['candidate_artifacts'][second['name']] = {
            **deepcopy(result['candidate_artifacts'][first['name']]), 'candidate': second}
        context = review_context(job, result, settings,
                                 {split: job / f'{split}.json' for split in ('train', 'validation')},
                                 job / 'evaluation.json')
        template = json.loads(Path(legacy['integrity_reviews'][0]['artifact']).read_text())
        base_review = template['candidates'][0]
        receipts = {'tasks': [legacy['tasks'][0]], 'integrity_reviews': []}
        def hashed(path):
            return {'path': str(path), 'sha256': sha256(path.read_bytes()).hexdigest()}
        for index, candidate in enumerate((first, second)):
            for slot in range(count):
                reviewer = f'candidate-{index}-reviewer-{slot}'
                directory = job / reviewer; directory.mkdir()
                checks = []
                for check in base_review['checks']:
                    evidence = json.loads(Path(check['evidence']).read_text())
                    fixture = json.loads(Path(evidence['inputs'][0]['path']).read_text())
                    fixture['candidate_name'] = candidate['name']
                    inputs = directory / f'{check["kind"]}-inputs.json'
                    inputs.write_text(json.dumps(fixture))
                    output = directory / f'{check["kind"]}-outputs.json'
                    command = [sys.executable, str(job / 'runner.py'), str(inputs), str(output)]
                    subprocess.run(command, cwd=job, check=True, capture_output=True)
                    evidence.update(candidate_name=candidate['name'], context_sha256=context['context_sha256'],
                                    inputs=[hashed(inputs)], outputs=hashed(output), command=command)
                    evidence_path = directory / f'{check["kind"]}-evidence.json'
                    evidence_path.write_text(json.dumps(evidence))
                    checks.append({'kind': check['kind'], 'passed': True, 'evidence': str(evidence_path)})
                report = {'reviewer_id': reviewer, 'candidate_name': candidate['name'], 'fresh_context': True,
                          'context_sha256': context['context_sha256'],
                          'candidates': [{**deepcopy(base_review), 'candidate': candidate, 'checks': checks}]}
                path = directory / 'report.json'; path.write_text(json.dumps(report))
                prompt = directory / 'prompt.txt'; prompt.write_text(f'Fresh independent context: review only {candidate["name"]}. No peer verdicts supplied.')
                receipts['tasks'].append({'kind': 'integrity_review', 'agent_id': reviewer,
                    'candidate_name': candidate['name'], 'fresh_context': True, 'status': 'completed',
                    'prompt_path': str(prompt), 'artifact': str(path)})
                receipts['integrity_reviews'].append({'reviewer_id': reviewer,
                    'candidate_name': candidate['name'], 'artifact': str(path)})
        return settings, result, receipts, context

    def test_fresh_review_assignments_cover_each_candidate_exactly(self):
        for count in (1, 2):
            with self.subTest(count=count), TemporaryDirectory() as directory:
                job = Path(directory).resolve()
                settings, result, receipts, context = self.candidate_scoped_fixture(job, count)
                audited = verify_integrity_reviews(job, result, receipts, settings, context)
                self.assertEqual(audited['review_protocol'], REVIEW_PROTOCOL)
                self.assertEqual(audited['reviewers_per_candidate'], count)
                self.assertEqual(len(audited['reviewers']), 2 * count)
                self.assertTrue(all(len(reviewers) == count for reviewers in audited['candidate_reviewers'].values()))
                self.assertEqual(len({reviewer for ids in audited['candidate_reviewers'].values() for reviewer in ids}), 2 * count)

    def test_explicit_review_protocol_cannot_silently_downgrade_to_missing_or_unknown_count(self):
        with self.assertRaisesRegex(ValueError, 'reviewer count'):
            verify_integrity_reviews(Path('.'), {}, {}, {'review_protocol': REVIEW_PROTOCOL})
        with self.assertRaisesRegex(ValueError, 'Unknown final-review protocol'):
            verify_integrity_reviews(Path('.'), {}, {}, {'review_protocol': 'reuse-shared', 'review_agents': 1})
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            (job / 'config.json').write_text(json.dumps({'settings': {'review_protocol': REVIEW_PROTOCOL}}))
            (job / 'status.json').write_text(json.dumps({'state': 'completed'}))
            (job / 'results.json').write_text('{}')
            with self.assertRaisesRegex(ValueError, 'downgrade'):
                verify_publication(job)

    def test_fresh_candidate_scope_identity_and_coverage_cannot_be_reused(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            settings, result, original, context = self.candidate_scoped_fixture(job)
            first_path = Path(original['integrity_reviews'][0]['artifact'])
            saved = first_path.read_text()
            for case in ('reused-id', 'author-id', 'fresh-task', 'task-candidate', 'missing-prompt',
                         'receipt-candidate', 'report-candidate', 'fresh-report', 'extra-report',
                         'missing-task', 'missing-report'):
                with self.subTest(case=case):
                    receipts = deepcopy(original)
                    report = json.loads(saved)
                    task = receipts['tasks'][1]
                    if case == 'reused-id': receipts['tasks'][2]['agent_id'] = task['agent_id']
                    elif case == 'author-id': task['agent_id'] = 'author'
                    elif case == 'fresh-task': task['fresh_context'] = False
                    elif case == 'task-candidate': task['candidate_name'] = 'second native control'
                    elif case == 'missing-prompt': task.pop('prompt_path')
                    elif case == 'receipt-candidate': receipts['integrity_reviews'][0]['candidate_name'] = 'second native control'
                    elif case == 'report-candidate': report['candidate_name'] = 'second native control'
                    elif case == 'fresh-report': report['fresh_context'] = False
                    elif case == 'extra-report': report['candidates'].append(deepcopy(report['candidates'][0]))
                    elif case == 'missing-task': receipts['tasks'].pop()
                    elif case == 'missing-report': receipts['integrity_reviews'].pop()
                    first_path.write_text(json.dumps(report))
                    try:
                        with self.assertRaises(ValueError):
                            verify_integrity_reviews(job, result, receipts, settings, context)
                    finally:
                        first_path.write_text(saved)

    def test_fresh_same_candidate_reviewers_need_distinct_native_probe_evidence(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            settings, result, receipts, context = self.candidate_scoped_fixture(job, 2)
            first = json.loads(Path(receipts['integrity_reviews'][0]['artifact']).read_text())
            second_path = Path(receipts['integrity_reviews'][1]['artifact'])
            second = json.loads(second_path.read_text())
            second['candidates'][0]['checks'][0]['evidence'] = first['candidates'][0]['checks'][0]['evidence']
            second_path.write_text(json.dumps(second))
            with self.assertRaisesRegex(ValueError, 'separately recorded native probe evidence'):
                verify_integrity_reviews(job, result, receipts, settings, context)

    def fixture(self, job):
        def save(name, value):
            path = job / name
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(json.dumps(value))
            return path
        def hashed(path, role=None):
            item = {'path': str(path), 'sha256': sha256(path.read_bytes()).hexdigest()}
            if role:
                item['role'] = role
            return item
        module = job / 'detector.py'
        module.write_text(MODEL)
        runner = job / 'runner.py'
        runner.write_text(RUNNER)
        model = save('model.json', {'threshold': .5})
        candidate = {'name': 'native control', 'method': 'control', 'threshold': .5}
        settings = {'review_agents': 2, 'evaluation_protocol': 'clip_replay-v1', 'seed': 0}
        result = {'round': 51, 'settings': settings, 'challengers': [{'candidate': candidate}],
                  'incumbents': [{'candidate': {'name': 'legacy'}}], 'candidate_artifacts': {candidate['name']: {
                      'candidate': candidate, 'learned': True,
                      'files': [hashed(module, 'implementation'), hashed(runner, 'evaluator'), hashed(model, 'model')]}}}
        train, validation, evaluation = [save(name + '.json', {'identity': name})
                                         for name in ('train', 'validation', 'evaluation')]
        context = review_context(job, result, settings, {'train': train, 'validation': validation}, evaluation)
        frozen = {str(Path(item['path']).relative_to(job)): item['sha256']
                  for item in result['candidate_artifacts'][candidate['name']]['files']}
        receipts = {'tasks': [{'kind': 'research', 'agent_id': 'author', 'status': 'completed'}],
                    'integrity_reviews': []}
        values = [0] * 20 + [1] * 20 + [0] * 20 + [1] * 20 + [0] * 20
        samples = lambda rows, offset=0: [[index / 10 + offset, value] for index, value in enumerate(rows)]
        cases = {
            'timestamp_origin_shift': ([{'samples': samples(values)}, {'samples': samples(values, 100)}],
                                       {'offsets_seconds': [0, 100]}),
            'variable_prefix': ([{'samples': samples([0] * 10 + values)}, {'samples': samples([0] * 30 + values)}],
                                {'prefix_lengths_seconds': [1, 3], 'real_prefix_samples_inserted': True,
                                 'padding_sensitivity_analysis': 'Native control follows observed state changes after inserted idle values, independent of startup time.'}),
            'continuous_multiple_events': ([{'samples': samples(values)}, {'samples': samples(values), 'chunk_boundaries': [33, 67]}],
                                           {'state_reset_between_segments': False, 'segments': 3, 'reference_events': 4,
                                            'native_state_persisted': True, 'arbitrary_chunk_boundaries': True,
                                            'reference_detections': [['close', 2], ['open', 4], ['close', 6], ['open', 8]],
                                            'chunk_boundary_indices': [33, 67]}),
            'no_event_stream': ([{'samples': samples([0] * 131)}, {'samples': samples([1] * 131)}],
                                {'duration_seconds': 13, 'reference_events': 0, 'initial_states': ['open', 'closed']}),
            'prefix_causality': ([{'samples': samples(values)}, {'samples': samples(values[:30] + [0] * 70)}],
                                 {'shared_prefix_samples': 30, 'altered_future_suffix': True, 'matching_prefix_outputs': True}),
        }
        for reviewer in ('reviewer-a', 'reviewer-b'):
            checks = []
            for kind in PROBE_KINDS:
                streams, details = cases[kind]
                fixture = save(f'{reviewer}/{kind}-inputs.json', {'kind': kind, 'candidate_name': candidate['name'], 'streams': streams})
                output = job / reviewer / f'{kind}-outputs.json'
                command = [sys.executable, str(runner), str(fixture), str(output)]
                subprocess.run(command, cwd=job, check=True, capture_output=True)
                evidence = save(f'{reviewer}/{kind}-evidence.json', {
                    'kind': kind, 'candidate_name': candidate['name'], 'entrypoint': 'detector.Detector.step',
                    'entrypoint_source': hashed(module), 'context_sha256': context['context_sha256'],
                    'artifact_hashes': frozen, 'runner': hashed(runner), 'command': command,
                    'inputs': [hashed(fixture)], 'outputs': hashed(output), 'details': details,
                    'observations': 'Executed frozen native Detector.step over actual synthetic inputs; emitted scores and transition events are retained.'})
                checks.append({'kind': kind, 'passed': True, 'evidence': str(evidence)})
            report = save(f'{reviewer}/report.json', {'reviewer_id': reviewer, 'context_sha256': context['context_sha256'],
                                                    'candidates': [{'candidate': candidate, 'verdict': 'approved',
                                                        'artifact_hashes': frozen, 'inspected_paths': [str(module), str(runner), str(model)],
                                                        'findings': ['Native state transition source uses observed values and supports initially closed state without phantom event.'],
                                                        'checks': checks}]})
            receipts['tasks'].append({'kind': 'integrity_review', 'agent_id': reviewer,
                                      'status': 'completed', 'artifact': str(report)})
            receipts['integrity_reviews'].append({'reviewer_id': reviewer, 'artifact': str(report)})
        return settings, result, receipts, context

    def test_actual_native_control_passes_but_legacy_pool_is_not_approved(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            settings, result, receipts, context = self.fixture(job)
            verified = verify_integrity_reviews(job, result, receipts, settings, context, ['native control'])
            self.assertEqual(verified['candidate_status'], {'legacy': 'legacy_unreviewed', 'native control': 'approved'})
            self.assertEqual(verified['reviewers'], ['reviewer-a', 'reviewer-b'])
            self.assertIsNone(verify_integrity_reviews(job, result, receipts, {}))

    def test_missing_independence_coverage_rejection_and_stale_artifacts_fail(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            settings, original, receipts, context = self.fixture(job)
            for case in ('missing', 'author', 'coverage', 'rejected', 'config', 'hash', 'findings', 'context', 'learned'):
                with self.subTest(case=case):
                    result, reviews = deepcopy(original), deepcopy(receipts)
                    report_path = Path(receipts['integrity_reviews'][0]['artifact'])
                    saved = report_path.read_text()
                    report = json.loads(saved)
                    if case == 'missing': reviews['integrity_reviews'].pop()
                    elif case == 'author': reviews['tasks'][-1]['agent_id'] = 'author'
                    elif case == 'coverage': report['candidates'] = []
                    elif case == 'rejected': report['candidates'][0]['verdict'] = 'rejected'
                    elif case == 'config': report['candidates'][0]['candidate']['threshold'] = .9
                    elif case == 'hash': result['candidate_artifacts']['native control']['files'][0]['sha256'] = '0' * 64
                    elif case == 'findings': report['candidates'][0]['findings'] = []
                    elif case == 'context': report['context_sha256'] = 'stale'
                    elif case == 'learned': result['candidate_artifacts']['native control']['learned'] = False
                    report_path.write_text(json.dumps(report))
                    try:
                        with self.assertRaises(ValueError):
                            verify_integrity_reviews(job, result, reviews, settings, context, ['native control'])
                    finally: report_path.write_text(saved)

    def test_contradictory_observable_probe_outputs_fail(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            settings, result, receipts, context = self.fixture(job)
            report = json.loads(Path(receipts['integrity_reviews'][0]['artifact']).read_text())
            for kind in ('timestamp_origin_shift', 'continuous_multiple_events', 'prefix_causality'):
                with self.subTest(kind=kind):
                    check = next(item for item in report['candidates'][0]['checks'] if item['kind'] == kind)
                    evidence_path = Path(check['evidence'])
                    saved = evidence_path.read_text(); evidence = json.loads(saved)
                    output_path = Path(evidence['outputs']['path']); original = output_path.read_text()
                    output = json.loads(original); output['streams'][1]['scores'][0] = 123.
                    output_path.write_text(json.dumps(output))
                    evidence['outputs']['sha256'] = sha256(output_path.read_bytes()).hexdigest()
                    evidence_path.write_text(json.dumps(evidence))
                    try:
                        with self.assertRaises(ValueError): verify_integrity_reviews(job, result, receipts, settings, context)
                    finally:
                        output_path.write_text(original); evidence_path.write_text(saved)

    def test_new_execute_cannot_opt_out_of_review(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            config = job / 'config.json'
            config.write_text(json.dumps({'settings': {}, 'prior': 'unused'}))
            with self.assertRaisesRegex(ValueError, 'final integrity reviewers'):
                execute(config)
            self.assertEqual(json.loads((job / 'status.json').read_text())['state'], 'failed')

    def test_publication_requires_finished_worker_and_unchanged_outer_receipt(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve() / 'dashboard-native'; job.mkdir()
            (job / 'config.json').write_text(json.dumps({'settings': {'review_agents': 2}}))
            (job / 'status.json').write_text(json.dumps({'state': 'completed'}))
            final = {key: str(job / name) for key, name in (
                ('results_path', 'results.json'), ('agent_manifest_path', 'agents.json'),
                ('evaluation_path', 'evaluation.json'))}
            for path in final.values(): Path(path).write_text('{}')
            (job / 'agent-final.json').write_text(json.dumps(final))
            with self.assertRaises(FileNotFoundError): verify_publication(job)
            write_publication_receipt(job, final, {})
            with patch('dashboard_agents.os.kill', return_value=None):
                with self.assertRaisesRegex(ValueError, 'not finished'): verify_publication(job)
            with patch('dashboard_agents.os.kill', side_effect=ProcessLookupError), \
                 patch('dashboard_agents.verify_completion', return_value=(job / 'results.json', {'approved': True})) as verify:
                self.assertEqual(verify_publication(job)[1], {'approved': True})
                verify.assert_called_once()
                (job / 'evaluation.json').write_text('{"changed":true}')
                with self.assertRaisesRegex(ValueError, 'changed'): verify_publication(job)
                verify.assert_called_once()

    def test_context_changes_invalidate_saved_reviews(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            settings, result, receipts, _ = self.fixture(job)
            (job / 'validation.json').write_text('{"identity":"different split"}')
            changed = review_context(job, result, settings,
                                     {split: job / f'{split}.json' for split in ('train', 'validation')},
                                     job / 'evaluation.json')
            with self.assertRaises(ValueError):
                verify_integrity_reviews(job, result, receipts, settings, changed)

    def test_registered_job_cannot_downgrade_to_legacy_after_another_job_starts(self):
        with TemporaryDirectory() as directory:
            root = Path(directory).resolve()
            job = root / 'dashboard-old-gated'; job.mkdir()
            (job / 'config.json').write_text(json.dumps({'settings': {}}))
            (job / 'status.json').write_text(json.dumps({'state': 'completed'}))
            (job / 'results.json').write_text(json.dumps({'settings': {}}))
            (root / '.review-required').mkdir()
            (root / '.review-required' / f'{job.name}.json').write_text(json.dumps({'job': str(job), 'config_sha256': 'old'}))
            (root / 'dashboard-active.json').write_text(json.dumps({'job_directory': str(root / 'another-job')}))
            with self.assertRaisesRegex(ValueError, 'downgrade'):
                verify_publication(job)


if __name__ == '__main__':
    unittest.main()

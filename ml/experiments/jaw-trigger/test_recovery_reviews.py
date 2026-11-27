from copy import deepcopy
from hashlib import sha256
import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from recovery_reviews import prepare_reviews, index_completed_reviews
from dashboard_integrity import PROBE_KINDS
from ml.evolution.review_bundles import preflight_bundle, write_review_report
import test_deployment_benchmark as benchmark_tests


class RecoveryReviewTests(unittest.TestCase):
    def fixture(self, job):
        candidate, evaluation, _, _ = benchmark_tests.DeploymentBenchmarkTests().fixture(job)
        def save(filename, value):
            path = job / filename
            path.write_text(json.dumps(value))
            return {'path': filename, 'sha256': sha256(path.read_bytes()).hexdigest()}
        evaluator = save('evaluator.json', {'contract': 'fixture evaluator'})
        model = save('model.json', {'weight': 1})
        runner = {'path': 'runner.json', 'sha256': sha256((job / 'runner.json').read_bytes()).hexdigest()}
        settings = {'review_agents': 1, 'review_protocol': 'per-candidate-v1',
                    'review_bundle_protocol': 'frozen-bundle-v1', 'agent_minutes': 20,
                    'agent_concurrency': 6, 'agent_prompt': 'Exact original direction.\nDo not change this context.'}
        result = {'round': 60, 'settings': settings, 'incumbents': [],
                  'challengers': [{'candidate': candidate}],
                  'candidate_artifacts': {'control': {'candidate': candidate, 'learned': True, 'files': [
                      {**runner, 'role': 'implementation'}, {**evaluator, 'role': 'evaluator'},
                      {**model, 'role': 'model'}]}}}
        save('config.json', {'settings': settings})
        save('results.json', result)
        save('evaluation.json', evaluation)
        save('train.json', {'clips': [{'clip': 'train'}]})
        save('validation.json', {'clips': [{'clip': 'validation'}]})
        save('deployment-specs.json', [{'candidate': candidate, 'slug': 'fresh', 'incumbent': False,
                                        'model_path': 'model.json', 'learned': True}])
        (job / 'probe_runner_template.py').write_text('''import sys,json,hashlib,importlib.util
from pathlib import Path
J=Path(__file__).resolve().parents[2];D=Path(__file__).parent
B=json.loads((J/'review-bundles'/(D.name+'.json')).read_text())
FROZEN={}
def stream(recipe,boundaries=()):
 d=A.create_detector(CONFIG,MODEL);scores=[]
 try:
  edges=[0,*boundaries,len(recipe)]
 finally:d.close()
 return {'sample_count':len(scores)}
def run(kind):
 streams=[]
 out={'kind':kind}
 evidence={'entrypoint':'NativeDetector.step','entrypoint_source':rec(J/B['spec']['adapter_path'])}
''')
        return result, evaluation

    def test_prepares_only_fresh_reviews_after_deployment_evidence_is_verified(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            self.fixture(job)
            prepared = prepare_reviews(job, python='/test/python', binary='/test/codex')
            runtime = json.loads((job / 'runtime-config-recovery.json').read_text())
            self.assertEqual(runtime['expected'], {'parent': [], 'research': 0, 'review': 0, 'integrity_review': 1})
            self.assertEqual(runtime['review_preflight_command'][-3:], ['--job', str(job), '--preflight'])
            self.assertEqual(prepared['author_tasks'], 0)
            self.assertEqual(prepared['review_tasks'], 1)
            self.assertFalse((job / 'agent-runtime').exists())  # No Supervisor was launched.
            task = prepared['tasks'][0]
            prompt = Path(task['prompt_path']).read_text()
            for phrase in ('no_event_stream', '12 seconds', '120 regularly sampled',
                           'candidate_parameters[candidate.name]', 'pending', 'original author allocations are closed'):
                self.assertIn(phrase, prompt)
            self.assertIn(runtime['settings']['agent_prompt'], prompt)
            self.assertIn('reviews-recovery', task['folder'])
            scaffold = (Path(task['folder']) / 'probe_runner.py').read_text()
            self.assertIn(f'J=Path({str(job)!r})', scaffold)
            self.assertIn(f'B=json.loads(Path({task["review_bundle"]!r}).read_text())', scaffold)
            self.assertNotIn("D.name+'.json'", scaffold)
            self.assertIn('inspect.getsourcefile(d.step)', scaffold)
            self.assertIn("'entrypoint':streams[0]['entrypoint']['name']", scaffold)
            self.assertNotIn("'entrypoint':'NativeDetector.step'", scaffold)
            compile(scaffold, 'probe_runner.py', 'exec')
            provenance = json.loads((Path(task['folder']) / 'scaffold-provenance.json').read_text())
            self.assertFalse(provenance['contains_probe_outputs'])
            self.assertFalse(provenance['contains_review_verdict'])
            bundle = json.loads(Path(task['review_bundle']).read_text())
            self.assertEqual(bundle['recovery']['continuous_field_validation'], 'pending_new_footage')
            with self.assertRaises(FileExistsError):
                prepare_reviews(job)

    def test_incomplete_native_evaluation_blocks_review_plan(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            _, evaluation = self.fixture(job)
            evaluation['deployment_benchmarks'] = {}
            (job / 'evaluation.json').write_text(json.dumps(evaluation))
            with self.assertRaisesRegex(ValueError, 'Every evaluated candidate'):
                prepare_reviews(job)
            self.assertFalse((job / 'runtime-config-recovery.json').exists())
            self.assertFalse((job / 'review-bundles-recovery').exists())

    def test_changed_deployment_spec_cannot_assign_a_different_candidate(self):
        with TemporaryDirectory() as directory:
            job = Path(directory).resolve()
            result, _ = self.fixture(job)
            spec = json.loads((job / 'deployment-specs.json').read_text())
            spec[0]['candidate'] = deepcopy(result['challengers'][0]['candidate'])
            spec[0]['candidate']['method'] = 'different-model'
            (job / 'deployment-specs.json').write_text(json.dumps(spec))
            with self.assertRaisesRegex(ValueError, 'unchanged exact deployment spec'):
                prepare_reviews(job)

    def index_fixture(self, root, *, verdict='approved'):
        job, source = root / 'recovery', root / 'source'
        job.mkdir(); source.mkdir()
        self.fixture(job)
        prepared = prepare_reviews(job)
        task_plan = prepared['tasks'][0]
        candidate_name, folder = task_plan['candidate_name'], Path(task_plan['folder'])
        source_manifest = source / 'agents.json'
        source_manifest.write_text(json.dumps({'tasks': [{'agent_id': 'old-author', 'kind': 'parent', 'status': 'completed'}]}))
        config_path = job / 'config.json'; config = json.loads(config_path.read_text())
        config['recovery'] = {'protocol': 'saved-round-completion-v1', 'source_job': str(source),
                              'source_receipts_sha256': sha256(source_manifest.read_bytes()).hexdigest()}
        config_path.write_text(json.dumps(config))
        (job / 'status.json').write_text('{"state":"failed"}')
        pinned = preflight_bundle(job, task_plan['review_bundle'], candidate_name)
        checks = []
        for kind in PROBE_KINDS:
            evidence = folder / f'{kind}.json'; evidence.write_text('{"synthetic":"packaging fixture, not actual inference"}')
            checks.append({'kind': kind, 'passed': verdict == 'approved', 'evidence': str(evidence)})
        report = folder / 'report.json'
        write_review_report(job, str(report), pinned, 'reviewer-one', verdict=verdict,
                            findings=['Synthetic reviewer decision must remain verbatim.'], checks=checks,
                            inspected_paths=list(pinned['graph']['files']), required_probe_kinds=PROBE_KINDS)
        runtime = json.loads((job / 'runtime-config-recovery.json').read_text())
        private = Path(runtime['ledger_path']); private.parent.mkdir(parents=True, exist_ok=True)
        private_io = private.parent / f'.{private.stem}-io'; private_io.mkdir()
        task_id = 'actual-task-one'; task_folder = job / 'agent-runtime' / task_id; task_folder.mkdir(parents=True)
        prompt = task_folder / 'turn-001.prompt.txt'; prompt.write_text(Path(task_plan['prompt_path']).read_text())
        events = task_folder / 'turn-001.events.jsonl'; events.write_text('{"type":"thread.started","thread_id":"reviewer-one"}\n')
        (private_io / f'{task_id}-turn-001.jsonl').write_bytes(events.read_bytes())
        final = task_folder / 'turn-001.final.json'
        final.write_text(json.dumps({'status': 'ready', 'artifact': str(report), 'candidate_name': candidate_name, 'summary': 'Finished review'}))
        task = {'task_id': task_id, 'agent_id': 'reviewer-one', 'thread_id': 'reviewer-one',
                'kind': 'integrity_review', 'candidate_name': candidate_name, 'status': 'ready',
                'artifact': str(report), 'prompt_path': str(prompt), 'summary': 'Finished review',
                'cycles': [{'cycle': 1}], 'turns': [{'number': 1, 'phase': 'review', 'cycle': 1,
                'events_path': str(events), 'prompt_path': str(prompt), 'final_path': str(final)}],
                'review_bundle': pinned, 'training_preflight': {'status': 'passed'}}
        ledger = {'protocol': 'supervised-v1', 'job': str(job), 'tasks': [task]}
        private.write_text(json.dumps(ledger)); (job / 'agent-runtime.json').write_bytes(private.read_bytes())
        (job / 'agents.json').write_text(json.dumps({'tasks': [{'task_id': task_id, 'agent_id': 'reviewer-one'}]}))
        return job, private, private_io, report, ledger

    def test_index_repairs_only_metadata_from_sealed_fresh_identity_evidence(self):
        with TemporaryDirectory() as directory:
            root = Path(directory).resolve(); job, _, _, report, _ = self.index_fixture(root)
            before, old = report.read_bytes(), (job / 'agents.json').read_bytes()
            audit = index_completed_reviews(job)
            manifest = json.loads((job / 'agents.json').read_text())
            self.assertTrue(manifest['tasks'][0]['fresh_context'])
            self.assertEqual(manifest['tasks'][0]['status'], 'completed')
            self.assertEqual(manifest['integrity_reviews'][0]['reviewer_id'], 'reviewer-one')
            self.assertEqual((job / audit['archive_path']).read_bytes(), old)
            self.assertEqual(report.read_bytes(), before)
            self.assertFalse(audit['review_decisions_modified'])
            self.assertEqual(index_completed_reviews(job)['status'], 'already_indexed')

    def test_index_preserves_rejection_verbatim(self):
        with TemporaryDirectory() as directory:
            job, _, _, report, _ = self.index_fixture(Path(directory).resolve(), verdict='rejected')
            before = report.read_bytes(); index_completed_reviews(job)
            self.assertEqual(report.read_bytes(), before)
            self.assertEqual(json.loads(report.read_text())['candidates'][0]['verdict'], 'rejected')

    def test_index_refuses_bad_seal_unready_identity_or_published_job_without_mutation(self):
        for corruption in ('self-seal', 'ledger', 'unready', 'event-identity', 'author-identity', 'completed', 'published'):
            with self.subTest(corruption=corruption), TemporaryDirectory() as directory:
                job, private, private_io, _, ledger = self.index_fixture(Path(directory).resolve())
                task = ledger['tasks'][0]
                if corruption == 'self-seal':
                    p = job / 'runtime-config-recovery.json'; runtime = json.loads(p.read_text())
                    runtime['ledger_path'] = str(job / 'agent-runtime.json'); p.write_text(json.dumps(runtime))
                elif corruption == 'ledger':
                    (job / 'agent-runtime.json').write_text('{}')
                elif corruption == 'unready':
                    task['status'] = 'blocked'
                elif corruption == 'event-identity':
                    raw = '{"type":"thread.started","thread_id":"different-reviewer"}\n'
                    Path(task['turns'][0]['events_path']).write_text(raw)
                    (private_io / f'{task["task_id"]}-turn-001.jsonl').write_text(raw)
                elif corruption == 'author-identity':
                    task['agent_id'] = task['thread_id'] = 'old-author'
                elif corruption == 'completed':
                    (job / 'status.json').write_text('{"state":"completed"}')
                else:
                    receipt = job.parent / '.verified-completions' / f'{job.name}.json'
                    receipt.parent.mkdir(); receipt.write_text('{}')
                if corruption in ('unready', 'author-identity'):
                    private.write_text(json.dumps(ledger)); (job / 'agent-runtime.json').write_bytes(private.read_bytes())
                before = (job / 'agents.json').read_bytes()
                with self.assertRaises(ValueError):
                    index_completed_reviews(job)
                self.assertEqual((job / 'agents.json').read_bytes(), before)
                self.assertFalse(list(job.glob('agents-before-review-index-*')))

    def test_index_requires_distinct_actual_reviewer_identities(self):
        with TemporaryDirectory() as directory:
            job, private, _, _, ledger = self.index_fixture(Path(directory).resolve())
            duplicate = deepcopy(ledger['tasks'][0]); duplicate['task_id'] = 'second-task'
            ledger['tasks'].append(duplicate)
            for name in ('config.json', 'runtime-config-recovery.json'):
                p = job / name; value = json.loads(p.read_text()); value['settings']['review_agents'] = 2
                if name.startswith('runtime'):
                    value['expected']['integrity_review'] = 2
                p.write_text(json.dumps(value))
            private.write_text(json.dumps(ledger)); (job / 'agent-runtime.json').write_bytes(private.read_bytes())
            with self.assertRaisesRegex(ValueError, 'distinct, ready, genuinely fresh'):
                index_completed_reviews(job)

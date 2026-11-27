"""Recovery keeps original authors separate from fresh review supervision."""

from copy import deepcopy
from hashlib import sha256
import json
from pathlib import Path
import shutil
from tempfile import TemporaryDirectory
import unittest
from unittest.mock import patch

from ml.evolution.training import write
from recover_saved_candidates import recover
from recovery_completion import make_recovery_proof, preflight, recovery_context, finalize_recovery
import test_dashboard_training as training_tests


class RecoveryCompletionTests(unittest.TestCase):
    def fixture(self, root):
        root = root.resolve()
        source, job, archive = root / 'failed', root / 'continued', root / 'archive'
        source.mkdir()
        settings, _, result, evaluation, eligible = training_tests.TrainingAuditTests().fixture(source)
        write(source / 'config.json', {'round_number': 60, 'settings': settings, 'prior': str(root / 'prior.json')})
        write(source / 'status.json', {'state': 'failed'})
        (source / 'author-prompt.txt').write_text('Original frozen author direction')
        write(source / 'proposal.json', {'candidate': eligible['Model']})
        task = {'agent_id': 'original-author', 'kind': 'research', 'status': 'completed',
                'artifact': str(source / 'proposal.json'), 'prompt_path': str(source / 'author-prompt.txt'),
                'proposal_candidate': 'Model'}
        write(source / 'agents.json', {'tasks': [task]})
        ledger = {'job': str(source), 'tasks': [{'agent_id': 'original-author', 'kind': 'research',
                    'cycles': [{'ended_monotonic': 10.}]}]}
        write(source / 'agent-runtime.json', ledger)
        private = root / '.agent-runtime' / 'failed.json'
        private.parent.mkdir()
        shutil.copyfile(source / 'agent-runtime.json', private)
        write(source / 'runtime-config.json', {'job': str(source), 'ledger_path': str(private)})
        write(source / 'model.json', result['feature_parameters']['state_model'])
        (source / 'empty.log').write_text('')
        spec = {'candidate': eligible['Model'], 'model_path': 'model.json', 'metadata': {},
                'incumbent': False, 'learned': True, 'receipt': evaluation['training_receipts']['Model'],
                'artifacts': {'model.json': ['model'], 'empty.log': ['dependency']}}
        write(source / 'deployment-specs.json', [spec])
        recover(source, archive)
        shutil.copytree(source, job)
        current = json.loads((archive / 'candidates.json').read_text())
        config = json.loads((source / 'config.json').read_text())
        config['recovery'] = make_recovery_proof(source, archive)
        write(job / 'config.json', config)
        normalized = deepcopy(spec); del normalized['artifacts']['empty.log']
        write(job / 'deployment-specs.json', [normalized])
        self.native(job, current, evaluation, eligible['Model'])
        return source, job, config, current

    def native(self, job, result, evaluation, candidate):
        def ref(name):
            return {'path': name, 'sha256': sha256((job / name).read_bytes()).hexdigest()}
        (job / 'runner.py').write_text('# Synthetic native receipt schema fixture; not executed\n')
        runtime = {'mobile_target': 'iOS', 'format': 'native', 'engine': 'fixture',
                   'device': 'fixture-host', 'compute_units': 'CPU', 'precision': 'float64'}
        artifact = {**ref('runner.py'), 'roles': ['runtime', 'model', 'preprocessor', 'decoder']}
        predictions = {split: {split: [['close', 1.]]} for split in ('train', 'validation')}
        trace = {'candidate': candidate, 'runtime': runtime, 'artifact_hashes': {'runner.py': artifact['sha256']},
                 'preparation_complete': True, 'warmup_complete': True, 'thermal_nominal': True,
                 'same_preprocessing_and_decoder': True, 'test_evaluated': False,
                 'started_uptime_seconds': 20., 'finished_uptime_seconds': 30.,
                 'splits': {s: [{'clip': s, 'sample_times_seconds': [0., 1.], 'scores': [0., 1.],
                                 'timings_ms': [.1, .2], 'events': predictions[s][s]}]
                            for s in ('train', 'validation')}}
        write(job / 'trace.json', trace)
        report = {'protocol': 'deployment-v1', 'candidate': candidate, 'runtime': runtime,
                  'artifacts': [artifact], 'runner': ref('runner.py'),
                  'command': ['fixture', 'runner.py'], 'outputs': ref('trace.json')}
        write(job / 'report.json', report)
        evaluation.update(deployment_benchmarks={'Model': ref('report.json')},
                          training_predictions={'Model': predictions['train']},
                          predictions={'Model': predictions['validation']}, timings_ms={'Model': [.1, .2]})
        write(job / 'evaluation.json', evaluation)
        result['candidate_artifacts'] = {'Model': {'files': [{**ref('runner.py'), 'role': 'implementation'}]}}
        write(job / 'results.json', result)
        write(job / 'agent-runtime.json', {'tasks': [{'cycles': [{'started_monotonic': 31.}]}]})

    def test_preflight_validates_original_training_and_new_native_without_reopening_authors(self):
        with TemporaryDirectory() as directory:
            source, job, config, result = self.fixture(Path(directory))
            before = {str(p): sha256(p.read_bytes()).hexdigest() for p in source.rglob('*') if p.is_file()}
            with patch('recovery_completion.verify_agent_budgets', return_value={'tasks': 1}) as budgets:
                report = preflight(job)
            self.assertEqual(report['native_evaluations'], 1)
            self.assertEqual(report['trials'], 1)
            self.assertEqual(budgets.call_args.args[0], source)
            self.assertEqual(before, {str(p): sha256(p.read_bytes()).hexdigest() for p in source.rglob('*') if p.is_file()})

    def test_final_audits_two_actual_ledgers_and_only_virtual_joined_tasks(self):
        with TemporaryDirectory() as directory:
            source, job, config, result = self.fixture(Path(directory))
            reviews = {'tasks': [{'kind': 'integrity_review', 'agent_id': 'fresh-reviewer'}]}
            with patch('recovery_completion.verify_agent_budgets', return_value={'tasks': 1}) as budgets:
                context = recovery_context(job, config, result, reviews, final=True)
            self.assertEqual([call.args[0] for call in budgets.call_args_list], [source, job])
            self.assertEqual([task['agent_id'] for task in context['receipts']['tasks']],
                             ['original-author', 'fresh-reviewer'])
            self.assertEqual(context['receipts']['tasks'][0]['artifact'], 'proposal.json')
            self.assertEqual(len(reviews['tasks']), 1)

    def test_cannot_change_source_weights_metadata_specs_or_frozen_files(self):
        for corruption in ('weight', 'metadata', 'spec', 'implementation', 'private_ledger'):
            with TemporaryDirectory() as directory:
                source, job, config, result = self.fixture(Path(directory))
                if corruption == 'weight':
                    result['candidate_parameters']['Model'] = {'value': 99}
                elif corruption == 'metadata':
                    result['candidate_metadata']['Model'] = {'family': 'Cheat'}
                elif corruption == 'spec':
                    specs = json.loads((job / 'deployment-specs.json').read_text())
                    specs[0]['candidate']['method'] = 'replacement'
                    write(job / 'deployment-specs.json', specs)
                elif corruption == 'implementation':
                    write(job / 'model.json', {'value': 99})
                else:
                    write(source.parent / '.agent-runtime/failed.json', {'tasks': []})
                with self.subTest(corruption=corruption), \
                     patch('recovery_completion.verify_agent_budgets', return_value={'tasks': 1}), \
                     self.assertRaises(ValueError):
                    recovery_context(job, config, result, {'tasks': []})

    def test_no_new_authors_no_reused_review_identity_and_native_bindings_are_required(self):
        for corruption in ('author', 'identity', 'training_binding', 'native_missing', 'early_review'):
            with TemporaryDirectory() as directory:
                _, job, config, result = self.fixture(Path(directory))
                review = {'kind': 'integrity_review', 'agent_id': 'fresh-reviewer'}
                if corruption == 'author': review['kind'] = 'parent'
                if corruption == 'identity': review['agent_id'] = 'original-author'
                if corruption in ('training_binding', 'native_missing'):
                    evaluation = json.loads((job / 'evaluation.json').read_text())
                    evaluation['training_receipts' if corruption == 'training_binding' else 'deployment_benchmarks'] = {}
                    write(job / 'evaluation.json', evaluation)
                if corruption == 'early_review':
                    write(job / 'agent-runtime.json', {'tasks': [{'cycles': [{'started_monotonic': 21.}]}]})
                with self.subTest(corruption=corruption), \
                     patch('recovery_completion.verify_agent_budgets', return_value={'tasks': 1}), \
                     self.assertRaises(ValueError):
                    recovery_context(job, config, result, {'tasks': [review]}, final=True)

    def finalization_fixture(self, root):
        source, job, config, result = self.fixture(root)
        config['settings']['target_f1'] = .95
        write(job / 'config.json', config)
        write(Path(config['prior']), {'history': [{'round': 59}]})
        entry = result['challengers'][0]
        entry.update(development={'f1': .9}, fitness=.92, p95_ms=.2,
                     split_scores={'train': {'f1': 1.}, 'validation': {'f1': .9}, 'test': None})
        write(job / 'results.json', result)
        reviewers = {'tasks': [{'kind': 'integrity_review', 'agent_id': 'fresh-reviewer'}]}
        write(job / 'agents.json', reviewers)
        context = {'source': source, 'archive': root / 'archive', 'receipts': reviewers,
                   'author_budget_audit': {'tasks': 1}, 'training_audit': {'trials': 1, 'crashes': 0}}
        selection = {'ranked': [entry], 'next_pool': [entry['candidate']]}
        return source, job, context, selection

    def test_rejected_review_stops_before_selection_or_any_result_write(self):
        with TemporaryDirectory() as directory:
            source, job, context, selection = self.finalization_fixture(Path(directory))
            original = (job / 'results.json').read_bytes()
            source_bytes = (source / 'agents.json').read_bytes()
            with patch('recovery_completion.recovery_context', return_value=context), \
                 patch('dashboard_integrity.verify_integrity_reviews', side_effect=ValueError('rejected')), \
                 patch('dashboard_selection.select_evaluated') as select, \
                 patch('dashboard_agents.verify_completion') as verify, \
                 self.assertRaisesRegex(ValueError, 'rejected'):
                finalize_recovery(job)
            select.assert_not_called()
            verify.assert_not_called()
            self.assertEqual((job / 'results.json').read_bytes(), original)
            self.assertEqual((source / 'agents.json').read_bytes(), source_bytes)
            self.assertFalse((job / 'agent-final.json').exists())

    def test_success_saves_canonical_audits_but_never_outer_receipt_or_status(self):
        with TemporaryDirectory() as directory:
            source, job, context, selection = self.finalization_fixture(Path(directory))
            source_snapshot = {str(p): sha256(p.read_bytes()).hexdigest() for p in source.rglob('*') if p.is_file()}
            status = (job / 'status.json').read_bytes()
            def verified(job, final, config, manifests):
                path = job / 'results.json'
                return path, {**json.loads(path.read_text()), 'training_audit': {'selected': 'raw-history-ref'}}
            with patch('recovery_completion.recovery_context', return_value=context), \
                 patch('dashboard_integrity.verify_integrity_reviews', return_value={'status': 'approved'}), \
                 patch('dashboard_selection.select_evaluated', return_value=selection), \
                 patch('dashboard_agents.verify_completion', side_effect=verified):
                completed = finalize_recovery(job)
            saved = json.loads((job / 'results.json').read_text())
            self.assertEqual(saved['training_audit'], {'selected': 'raw-history-ref'})
            self.assertEqual(saved['history'][0], {'round': 59})
            self.assertEqual(saved['history'][1]['round'], 60)
            self.assertFalse(saved['target_reached'])
            self.assertEqual(completed['final']['status'], 'completed')
            self.assertEqual(completed['summary']['leader'], 'Model')
            self.assertFalse(completed['summary']['test_evaluated'])
            self.assertEqual((job / 'status.json').read_bytes(), status)
            self.assertFalse((job.parent / '.verified-completions').exists())
            self.assertEqual(source_snapshot, {str(p): sha256(p.read_bytes()).hexdigest()
                                               for p in source.rglob('*') if p.is_file()})

    def test_later_canonical_failure_restores_pending_result_bytes(self):
        with TemporaryDirectory() as directory:
            _, job, context, selection = self.finalization_fixture(Path(directory))
            original = (job / 'results.json').read_bytes()
            with patch('recovery_completion.recovery_context', return_value=context), \
                 patch('dashboard_integrity.verify_integrity_reviews', return_value={'status': 'approved'}), \
                 patch('dashboard_selection.select_evaluated', return_value=selection), \
                 patch('dashboard_agents.verify_completion', side_effect=ValueError('ordinary gate rejected')), \
                 self.assertRaisesRegex(ValueError, 'ordinary gate rejected'):
                finalize_recovery(job)
            self.assertEqual((job / 'results.json').read_bytes(), original)
            self.assertFalse((job / 'agent-final.json').exists())


if __name__ == '__main__':
    unittest.main()

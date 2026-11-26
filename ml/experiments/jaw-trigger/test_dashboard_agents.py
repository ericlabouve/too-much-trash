"""Reject incomplete or inconsistent agent receipts without running an agent."""

from dataclasses import asdict, replace
import json
from copy import deepcopy
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from dashboard_agents import (FINAL_SCHEMA, agent_counts, coordinator_prompt, evolution_parents,
                              round_allocation_seconds, verify_architecture_reviews, verify_completion)
from run_joint_round import JointCandidate


class AgentReceiptTests(unittest.TestCase):
    def test_candidate_scoped_reviews_cannot_hide_extra_stale_research_challengers(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            config, manifests, final, result, _, _ = self.fixture(job)
            config['settings'].update(review_protocol='per-candidate-v1', review_agents=1)
            stale = deepcopy(result['challengers'][-1])
            stale['candidate'].update(name='stale extra idea', created_round=48, threshold=.4)
            result['challengers'].append(stale)
            (job / 'results.json').write_text(json.dumps(result))
            with self.assertRaisesRegex(ValueError, 'no extra challengers'):
                verify_completion(job, final, config, manifests)
    def test_final_review_count_and_budget_scale_per_candidate_without_reinterpreting_legacy(self):
        pool = [asdict(JointCandidate(f'parent-{index}', 'imu', .1 + index * .01)) for index in range(10)]
        prior = {'next_pool': pool}
        settings = {'family': 'all', 'pool_size': 10, 'research_slots': 3,
                    'reproduction_protocol': 'all-pool-v1', 'review_agents': 1,
                    'review_protocol': 'per-candidate-v1', 'agent_minutes': 30, 'agent_concurrency': 3}
        self.assertEqual(agent_counts(prior, settings)['integrity_review'], 13)
        settings['review_agents'] = 2
        self.assertEqual(agent_counts(prior, settings)['integrity_review'], 26)
        legacy = {key: value for key, value in settings.items() if key != 'review_protocol'}
        self.assertEqual(agent_counts(prior, legacy)['integrity_review'], 2)
        self.assertGreater(round_allocation_seconds(prior, settings), round_allocation_seconds(prior, legacy))
        settings['family'] = 'new_family'
        self.assertEqual(agent_counts(prior, settings)['integrity_review'], 6)

    def test_new_selection_gate_recomputes_admission_and_cannot_trust_forged_coverage(self):
        from dashboard_selection import select_evaluated
        import round_one
        with TemporaryDirectory() as directory:
            job = Path(directory)
            config, manifests, final, result, evaluation, _ = self.fixture(job)
            config['settings'].update(selection_protocol='portfolio-v1', protected_slots=3,
                                      mutation_attempts=3, family_limit=3)
            for entry in [*result['incumbents'], *result['challengers']]:
                entry.update(clip_f1=[1.], worst_clip_accuracy=1., zero_jaw_clips=0)
            prior = json.loads(Path(config['prior']).read_text())
            result.update(select_evaluated(result['incumbents'], result['challengers'], prior, config['settings']))
            (job / 'results.json').write_text(json.dumps(result))
            _, audited = verify_completion(job, final, config, manifests)
            self.assertTrue(audited['selection_audit']['coverage_verified'])
            result['challengers'][-1]['clip_f1'] = [0.]
            (job / 'results.json').write_text(json.dumps(result))
            with self.assertRaisesRegex(ValueError, 'coverage and rank diagnostics'):
                verify_completion(job, final, config, manifests)

    def test_new_protocol_accepts_best_epoch_and_rejects_exporting_last_epoch(self):
        from hashlib import sha256
        from ml.evolution.training import TrainingMonitor, policy_for
        with TemporaryDirectory() as directory:
            job = Path(directory)
            config, manifests, final, result, evaluation, _ = self.fixture(job)
            settings = config['settings']
            settings['training_protocol'] = 'validation-checkpoints-v1'
            name = 'Threshold research'
            context = {f'{split}_manifest_sha256': sha256(path.read_bytes()).hexdigest()
                       for split, path in manifests.items()}
            plan = {'candidate_name': name, 'kind': 'iterative', 'seed': 0,
                    'hypothesis': 'Synthetic checkpoint selection fixture', 'objective': 'BCE',
                    'capacity': 'One synthetic weight', 'regularization': 'None in synthetic fixture',
                    'resources': {'device': 'synthetic CPU', 'threads': 1},
                    'max_epochs': 3, 'selection_decoder': {'threshold': .3}}
            now = [0.]
            monitor = TrainingMonitor(job, 'synthetic', plan, context,
                                      policy=policy_for(settings), clock=lambda: now[0])
            for epoch, val_loss in enumerate((.5, .2, .9), 1):
                now[0] = float(epoch)
                monitor.observe(train_loss=.5 / epoch, validation_loss=val_loss,
                                validation_score=1., validation_predictions={
                                    'validation:uuid': [['close', 3.], ['open', 5.]]},
                                parameters={'weight': epoch})
            evaluation['fitted_candidates'] = [name]
            evaluation['training_receipts'] = {name: monitor.finish()}
            result['feature_parameters'] = {'imu': monitor.selected_checkpoint()['parameters']}
            (job / 'results.json').write_text(json.dumps(result))
            (job / 'evaluation.json').write_text(json.dumps(evaluation))
            _, verified = verify_completion(job, final, config, manifests)
            self.assertEqual(verified['training_audit']['candidates'][name]['selected_epoch'], 2)
            result['feature_parameters']['imu'] = {'weight': 3}
            (job / 'results.json').write_text(json.dumps(result))
            with self.assertRaisesRegex(ValueError, 'selected validation checkpoint'):
                verify_completion(job, final, config, manifests)

    def test_checkpoint_protocol_cannot_publish_a_fitted_model_without_training_evidence(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            config, manifests, final, result, evaluation, _ = self.fixture(job)
            config['settings']['training_protocol'] = 'validation-checkpoints-v1'
            evaluation['fitted_candidates'] = ['Threshold research']
            (job / 'results.json').write_text(json.dumps(result))
            (job / 'evaluation.json').write_text(json.dumps(evaluation))
            with self.assertRaisesRegex(ValueError, 'training|receipt|journal'):
                verify_completion(job, final, config, manifests)

    def test_protected_source_snapshot_cannot_change_during_a_round(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            config, manifests, final, _, _, _ = self.fixture(job)
            source = job / 'protected-source' / 'evaluator.py'
            source.parent.mkdir()
            source.write_text('original evaluator')
            from hashlib import sha256
            config['_trusted_input_hashes'] = {'protected-source/evaluator.py': sha256(source.read_bytes()).hexdigest()}
            verify_completion(job, final, config, manifests)
            source.write_text('changed evaluator')
            with self.assertRaisesRegex(ValueError, 'Pinned input'):
                verify_completion(job, final, config, manifests)

    def test_final_schema_satisfies_strict_output_contract(self):
        # Structured-output providers require every property, including failure_kind.
        self.assertEqual(set(FINAL_SCHEMA['required']), set(FINAL_SCHEMA['properties']))
        self.assertIn('none', FINAL_SCHEMA['properties']['failure_kind']['enum'])

    def test_new_deployment_round_cannot_mix_prototype_metrics(self):
        with TemporaryDirectory() as directory:
            job=Path(directory).resolve()
            config,manifests,final,result,_,_=self.fixture(job)
            config['settings']['benchmark_protocol']='deployment-v1'
            result['benchmark_protocol']='deployment-v1'
            (job/'results.json').write_text(json.dumps(result))
            with self.assertRaisesRegex(ValueError,'deployment benchmark report'):
                verify_completion(job,final,config,manifests)

    def review_dialogue(self, job, receipts, candidate, verdicts, family='Convolutional'):
        cycles = []
        feedback = ''
        for attempt, verdict in enumerate(verdicts, 1):
            paths = {key: job / f'{key}-{attempt}.json' for key in
                     ('proposal_artifact', 'research_prompt_path', 'review_prompt_path', 'review_artifact')}
            paths['proposal_artifact'].write_text(json.dumps({'candidate': candidate, 'revision': attempt}))
            paths['research_prompt_path'].write_text(f'Revise the proposal. {feedback}')
            paths['review_prompt_path'].write_text(f'Reassess proposal revision {attempt}')
            feedback = f'Feedback on revision {attempt}: distinguish the runtime architecture.'
            paths['review_artifact'].write_text(json.dumps({
                'proposal_artifact': str(paths['proposal_artifact']), 'verdict': verdict,
                'feedback': feedback, 'candidate': candidate, 'family': family}))
            cycles.append({'attempt': attempt, **{key: str(path) for key, path in paths.items()}})
        receipts['architecture_reviews'] = [{
            'proposal_candidate': candidate['name'], 'research_agent_id': 'fixture-research',
            'review_agent_id': 'fixture-review', 'cycles': cycles}]
        return cycles

    def fixture(self, job):
        def save(name, data):
            path = job / name
            path.write_text(json.dumps(data))
            return path
        candidate = asdict(JointCandidate('Threshold parent', 'imu', .2))
        prior = save('prior.json', {'round': 48, 'next_pool': [candidate]})
        settings = {'family': 'all', 'pool_size': 1, 'research_slots': 1, 'agent_minutes': 30,
                    'agent_concurrency': 3, 'jaw_weight': .8, 'target_f1': .95,
                    'match_seconds': .5, 'full_speed_ms': 4.1666666667,
                    'frame_budget_ms': 16.6666666667}
        config = {'prior': str(prior), 'settings': settings}
        labels = {'close': 3., 'open': 5.}
        validation = save('validation.json', {'clips': [{'clip': 'validation:uuid', 'jaw_reference': labels}]})
        train = save('train.json', {'clips': [{'clip': 'train:uuid', 'jaw_reference': labels}]})
        metrics = {'matched': 2, 'missed': 0, 'false_positives': 0, 'f1': 1.}
        entry = {'candidate': candidate, 'development': metrics,
                 'split_scores': {'train': dict(metrics), 'validation': dict(metrics), 'test': None}, 'p95_ms': .1,
                 'speed_score': 1., 'fitness': 1.}
        child = deepcopy(entry)
        child['candidate'] = asdict(replace(JointCandidate(**candidate), name='Threshold child',
                                            threshold=.21, parent=candidate['name'], created_round=49))
        research = deepcopy(entry)
        research['candidate'] = asdict(replace(JointCandidate(**candidate), name='Threshold research',
                                               threshold=.3, created_round=49))
        result = {'round': 49, 'mode': 'agent_guided', 'reporting': 'validation', 'settings': settings,
                  'fitness_weights': {'jaw_f1': .8, 'speed_score': 1-.8},
                  'ranked': [entry], 'incumbents': [deepcopy(entry)], 'next_pool': [candidate],
                  'challengers': [child, research]}
        result_path = save('results.json', result)
        task_path = save('proposal.json', {'explanation': 'Deterministic test fixture; no inference was run.'})
        receipts = {'tasks': [{'kind': kind, 'parent': candidate['name'] if kind == 'parent' else None,
                              'proposal_candidate': research['candidate']['name'] if kind == 'research' else None,
                              'agent_id': f'fixture-{kind}', 'status': 'completed', 'artifact': str(task_path)}
                             for kind in ('parent', 'research')]}
        receipts_path = save('agents.json', receipts)
        evaluation = {'training_clip_ids': ['train:uuid'], 'validation_clip_ids': ['validation:uuid'],
                      'fitted_candidates': [], 'predictions': {candidate['name']: {'validation:uuid': list(labels.items())}},
                      'timings_ms': {candidate['name']: [.1, .1, .1]}}
        for challenger in result['challengers']:
            name = challenger['candidate']['name']
            evaluation['predictions'][name] = {'validation:uuid': list(labels.items())}
            evaluation['timings_ms'][name] = [.1, .1, .1]
        evaluation['training_predictions'] = {entry['candidate']['name']: {'train:uuid': list(labels.items())}
                                              for entry in result['ranked'] + result['challengers']}
        evaluation_path = save('evaluation.json', evaluation)
        final = {'status': 'completed', 'message': 'Fixture', 'results_path': str(result_path),
                 'agent_manifest_path': str(receipts_path), 'evaluation_path': str(evaluation_path)}
        return config, {'train': train, 'validation': validation}, final, result, evaluation, receipts

    def test_complete_receipts_and_prompt_contract(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            config, manifests, final, result, _, _ = self.fixture(job)
            _, actual = verify_completion(job, final, config, manifests)
            self.assertEqual(actual, result)
            prompt = coordinator_prompt(config, job, manifests)
            self.assertIn('Use actual subagents', prompt)
            self.assertIn('Refit ALL', prompt)
            self.assertIn('never test', prompt)
            self.assertIn('Each research agent independently', prompt)
            self.assertIn('exactly ONE fresh proposal', prompt)
            self.assertIn('Known Python runtime command:', prompt)
            self.assertIn("Do not recursively\nscan the user's home", prompt)

    def test_legacy_top_evolution_parents_preserve_historical_allocation(self):
        pool = [asdict(JointCandidate(name, method, .2)) for name, method in
                [('weak', 'imu'), ('strong', 'imu'), ('other', 'bilateral')]]
        prior = {'next_pool': pool, 'ranked': [{'candidate': candidate, 'fitness': fitness}
                                             for candidate, fitness in zip(pool, [.2, .9, .8])]}
        settings = {'family': 'all', 'evolution_agents': 1, 'pool_size': 1, 'research_slots': 3}
        self.assertEqual([candidate['name'] for candidate in evolution_parents(prior, settings)], ['strong'])
        self.assertEqual(agent_counts(prior, settings), {'evolution': 1, 'research': 3, 'review': 0, 'integrity_review': 0, 'coordinator': 1})
        settings.update(family='Threshold', evolution_agents=10)
        self.assertEqual([candidate['name'] for candidate in evolution_parents(prior, settings)], ['strong', 'weak'])
        settings['family'] = 'new_family'
        self.assertEqual(agent_counts(prior, settings), {'evolution': 0, 'research': 3, 'review': 1, 'integrity_review': 0, 'coordinator': 1})

    def test_all_pool_reproduction_includes_low_rank_protected_and_scoped_members(self):
        pool = [asdict(JointCandidate(f'parent-{i}', 'imu', .1 + .01 * i)) for i in range(10)]
        proposal = asdict(JointCandidate('catalog-reentry', 'imu', .4))
        prior = {'next_pool': pool,
                 'ranked': [{'candidate': candidate, 'fitness': 1 - .05 * i} for i, candidate in enumerate(pool)],
                 'challengers': [{'candidate': proposal, 'fitness': .01}],
                 'protected': [{'name': pool[-1]['name'], 'root': pool[-1]['name'], 'attempts': 1}]}
        settings = {'family': 'all', 'pool_size': 3, 'research_slots': 3,
                    'reproduction_protocol': 'all-pool-v1'}
        self.assertEqual(len(evolution_parents(prior, settings)), 10)
        self.assertIn(pool[-1], evolution_parents(prior, settings))
        self.assertEqual(agent_counts(prior, settings)['evolution'], 10)
        # Target capacity applies to survivors, so the next smaller actual pool
        # naturally produces fewer children without hidden transition pruning.
        reduced = {**prior, 'next_pool': pool[:3]}
        self.assertEqual(len(evolution_parents(reduced, settings)), 3)
        settings['family'] = 'Threshold'
        self.assertEqual(len(evolution_parents(prior, settings)), 11)
        settings['family'] = 'new_family'
        self.assertEqual(evolution_parents(prior, settings), [])
        self.assertEqual(agent_counts(prior, settings)['evolution'], 0)
        with self.assertRaisesRegex(ValueError, 'no top-X'):
            evolution_parents(prior, {**settings, 'evolution_agents': 0})

    def test_all_pool_completion_requires_one_child_for_each_incumbent(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            config, manifests, final, result, evaluation, receipts = self.fixture(job)
            config['settings']['reproduction_protocol'] = 'all-pool-v1'
            prior = json.loads(Path(config['prior']).read_text())
            weak = asdict(JointCandidate('Threshold weak', 'imu', .25))
            prior['next_pool'].append(weak)
            prior['protected'] = [{'name': weak['name'], 'root': weak['name'], 'attempts': 1}]
            Path(config['prior']).write_text(json.dumps(prior))
            weak_entry = deepcopy(result['incumbents'][0])
            missed = {'matched': 0, 'missed': 2, 'false_positives': 0, 'f1': 0.}
            weak_entry.update(candidate=weak, development=missed,
                              split_scores={'train': dict(missed), 'validation': dict(missed), 'test': None},
                              fitness=.2)
            result['incumbents'].append(weak_entry)
            child = deepcopy(weak_entry)
            child['candidate'] = asdict(replace(JointCandidate(**weak), name='Weak child',
                                                threshold=.26, parent=weak['name'], created_round=49))
            result['challengers'].append(child)
            for name in (weak['name'], child['candidate']['name']):
                evaluation['predictions'][name] = {'validation:uuid': []}
                evaluation['training_predictions'][name] = {'train:uuid': []}
                evaluation['timings_ms'][name] = [.1, .1, .1]
            receipts['tasks'].append({**receipts['tasks'][0], 'parent': weak['name'], 'agent_id': 'fixture-weak'})
            def publish():
                (job / 'results.json').write_text(json.dumps(result))
                (job / 'evaluation.json').write_text(json.dumps(evaluation))
                (job / 'agents.json').write_text(json.dumps(receipts))
            publish()
            verify_completion(job, final, config, manifests)
            self.assertEqual(len(evolution_parents(prior, config['settings'])), 2)
            result['challengers'].pop()
            publish()
            with self.assertRaisesRegex(ValueError, 'exactly one evaluated child'):
                verify_completion(job, final, config, manifests)
            result['challengers'].append(child)
            duplicate = deepcopy(result['challengers'][0])
            duplicate['candidate'].update(name='Duplicate child', threshold=.22)
            result['challengers'].append(duplicate)
            publish()
            with self.assertRaisesRegex(ValueError, 'exactly one evaluated child'):
                verify_completion(job, final, config, manifests)

    def test_rank_only_candidate_cannot_bypass_challenger_gate(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            config, manifests, final, result, _, _ = self.fixture(job)
            unreviewed = deepcopy(result['ranked'][0]['candidate'])
            unreviewed['name'] = 'rank-only intruder'
            result['ranked'][0]['candidate'] = unreviewed
            result['next_pool'] = [unreviewed]
            (job / 'results.json').write_text(json.dumps(result))
            with self.assertRaisesRegex(ValueError, 'unchanged incumbent or a reviewed challenger'):
                verify_completion(job, final, config, manifests)

    def test_specific_family_can_reenter_a_reviewed_nonretained_proposal(self):
        parent = asdict(JointCandidate('retained', 'imu', .2))
        proposal = asdict(JointCandidate('Extra Trees proposal', 'extra_trees49', .3))
        prior = {'next_pool': [parent], 'ranked': [{'candidate': parent, 'fitness': .4}],
                 'challengers': [{'candidate': proposal, 'fitness': .77}],
                 'candidate_metadata': {proposal['name']: {'family': 'Extra Trees'}}}
        settings = {'family': 'Extra Trees', 'research_slots': 1}
        self.assertEqual(evolution_parents(prior, settings), [proposal])
        settings['family'] = 'all'
        self.assertEqual(evolution_parents(prior, settings), [parent])

    def test_separate_research_agent_required_for_each_proposal(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            config, manifests, final, result, evaluation, receipts = self.fixture(job)
            config['settings'].update(research_slots=2, evolution_agents=0)
            result['challengers'] = result['challengers'][1:]
            second = deepcopy(result['challengers'][0])
            second['candidate'].update(name='Second research', threshold=.4)
            result['challengers'].append(second)
            evaluation['predictions'][second['candidate']['name']] = {'validation:uuid': [('close', 3), ('open', 5)]}
            evaluation['training_predictions'][second['candidate']['name']] = {'train:uuid': [('close', 3), ('open', 5)]}
            evaluation['timings_ms'][second['candidate']['name']] = [.1, .1, .1]
            receipts['tasks'] = receipts['tasks'][1:]
            second_task = dict(receipts['tasks'][0], agent_id='second-research', proposal_candidate='Second research')
            def publish():
                (job / 'results.json').write_text(json.dumps(result))
                (job / 'agents.json').write_text(json.dumps(receipts))
                (job / 'evaluation.json').write_text(json.dumps(evaluation))
            publish()
            with self.assertRaisesRegex(ValueError, 'own completed research agent'):
                verify_completion(job, final, config, manifests)
            receipts['tasks'].append(second_task)
            publish()
            verify_completion(job, final, config, manifests)
            receipts['tasks'][1]['proposal_candidate'] = receipts['tasks'][0]['proposal_candidate']
            publish()
            with self.assertRaisesRegex(ValueError, 'own completed research agent'):
                verify_completion(job, final, config, manifests)

    def test_round_direction_is_required_in_each_child_prompt(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            config, manifests, final, result, _, receipts = self.fixture(job)
            direction = 'Research temporal models.\nUse causal inference.'
            config['settings']['agent_prompt'] = direction
            result['settings'] = config['settings']
            (job / 'results.json').write_text(json.dumps(result))
            self.assertIn(direction, coordinator_prompt(config, job, manifests))
            with self.assertRaises(ValueError):
                verify_completion(job, final, config, manifests)
            for index, task in enumerate(receipts['tasks']):
                path = job / f'child-prompt-{index}.txt'
                path.write_text('Task instructions\n' + direction)
                task['prompt_path'] = str(path)
            (job / 'agents.json').write_text(json.dumps(receipts))
            verify_completion(job, final, config, manifests)

    def test_scores_test_inclusion_and_missing_agent_are_rejected(self):
        for case in ('scores', 'test_clip', 'missing_agent', 'nonfinite', 'wrong_weights',
                     'no_challengers', 'unchanged_child', 'missing_research', 'missing_child_predictions',
                     'missing_incumbent', 'missing_novel_metadata', 'wrong_train_score', 'premature_test_score'):
            with self.subTest(case=case), TemporaryDirectory() as directory:
                job = Path(directory)
                config, manifests, final, result, evaluation, receipts = self.fixture(job)
                if case == 'scores':
                    result['ranked'][0]['development']['matched'] = 1
                elif case == 'test_clip':
                    evaluation['predictions']['Threshold parent']['test:uuid'] = []
                elif case == 'missing_agent':
                    receipts['tasks'] = receipts['tasks'][1:]
                elif case == 'nonfinite':
                    result['ranked'][0]['p95_ms'] = float('nan')
                elif case == 'wrong_weights':
                    result['fitness_weights']['jaw_f1'] = .5
                elif case == 'no_challengers':
                    result['challengers'] = []
                elif case == 'unchanged_child':
                    result['challengers'][0]['candidate']['threshold'] = .2
                elif case == 'missing_research':
                    result['challengers'] = result['challengers'][:1]
                elif case == 'missing_child_predictions':
                    del evaluation['predictions']['Threshold child']
                elif case == 'missing_incumbent':
                    result['incumbents'] = []
                elif case == 'wrong_train_score':
                    result['ranked'][0]['split_scores']['train']['f1'] = .1
                elif case == 'premature_test_score':
                    result['ranked'][0]['split_scores']['test'] = {'f1': 1.}
                else:
                    result['challengers'][1]['candidate']['method'] = 'new_conv'
                (job / 'results.json').write_text(json.dumps(result))
                (job / 'evaluation.json').write_text(json.dumps(evaluation))
                (job / 'agents.json').write_text(json.dumps(receipts))
                with self.assertRaises(ValueError):
                    verify_completion(job, final, config, manifests)


    def test_new_family_needs_novel_method_and_reviewed_architecture(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            config, manifests, final, result, evaluation, receipts = self.fixture(job)
            config['settings']['family'] = 'new_family'
            receipts['new_families'] = ['Convolutional']
            receipts['tasks'] = receipts['tasks'][1:]
            receipts['tasks'].append({'kind': 'review', 'parent': None, 'agent_id': 'fixture-review',
                                       'status': 'completed', 'artifact': str(job / 'proposal.json')})
            result['challengers'] = result['challengers'][1:]
            research = result['challengers'][0]
            research['candidate']['method'] = 'new_conv'
            result['candidate_metadata'] = {research['candidate']['name']: {
                'family': 'Convolutional', 'differentiator': 'Compact spatial feature extractor',
                'architecture': [['Frame', 'Grayscale crop'], ['Convolution', 'Learned local spatial features']]}}
            evaluation['fitted_candidates'] = [research['candidate']['name']]
            self.review_dialogue(job, receipts, research['candidate'], ['accepted'])
            def publish():
                (job / 'results.json').write_text(json.dumps(result))
                (job / 'agents.json').write_text(json.dumps(receipts))
                (job / 'evaluation.json').write_text(json.dumps(evaluation))
            publish()
            verify_completion(job, final, config, manifests)
            evaluation['fitted_candidates'] = []
            publish()
            with self.assertRaisesRegex(ValueError, 'training-only refit'):
                verify_completion(job, final, config, manifests)
            evaluation['fitted_candidates'] = [research['candidate']['name']]
            receipts['tasks'].pop()
            publish()
            with self.assertRaisesRegex(ValueError, 'reviewed architecture'):
                verify_completion(job, final, config, manifests)

    def test_architecture_feedback_revisions_and_minimum_failure_cycles(self):
        for count in (1, 2, 3):
            with self.subTest(cycles=count), TemporaryDirectory() as directory:
                job = Path(directory)
                config, manifests, final, result, _, receipts = self.fixture(job)
                config['settings']['family'] = 'new_family'
                candidate = result['challengers'][-1]['candidate']
                receipts['tasks'] = receipts['tasks'][1:]
                receipts['tasks'].append({'kind': 'review', 'agent_id': 'fixture-review', 'status': 'completed'})
                self.review_dialogue(job, receipts, candidate, ['changes_requested'] * count)
                (job / 'agents.json').write_text(json.dumps(receipts))
                final.update(status='failed', failure_kind='architecture_review', message='Novelty unresolved')
                expected = 'at least three' if count < 3 else 'Novelty unresolved'
                with self.assertRaisesRegex(ValueError, expected):
                    verify_completion(job, final, config, manifests)

    def test_review_acceptance_after_revisions_audits_feedback_and_final_version(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            config, _, _, result, _, receipts = self.fixture(job)
            candidate = result['challengers'][-1]['candidate']
            receipts['tasks'] = receipts['tasks'][1:]
            receipts['tasks'].append({'kind': 'review', 'agent_id': 'fixture-review', 'status': 'completed'})
            cycles = self.review_dialogue(job, receipts, candidate,
                                         ['changes_requested', 'changes_requested', 'accepted'])
            kwargs = {'candidates': {candidate['name']: candidate},
                      'metadata': {candidate['name']: {'family': 'Convolutional'}}}
            verify_architecture_reviews(job, receipts, config['settings'], **kwargs)
            review_path = Path(cycles[-1]['review_artifact'])
            review = json.loads(review_path.read_text())
            review['candidate']['threshold'] = .9
            review_path.write_text(json.dumps(review))
            with self.assertRaisesRegex(ValueError, 'exact final candidate'):
                verify_architecture_reviews(job, receipts, config['settings'], **kwargs)
            review['candidate'] = candidate
            review_path.write_text(json.dumps(review))
            Path(cycles[1]['research_prompt_path']).write_text('Ignore the previous review')
            with self.assertRaisesRegex(ValueError, 'feedback must reach'):
                verify_architecture_reviews(job, receipts, config['settings'], **kwargs)

    def test_review_cycle_budget_and_operational_stop(self):
        with TemporaryDirectory() as directory:
            job = Path(directory)
            config, manifests, final, _, _, _ = self.fixture(job)
            prior = json.loads(Path(config['prior']).read_text())
            ordinary = round_allocation_seconds(prior, config['settings'])
            config['settings']['family'] = 'new_family'
            self.assertGreater(round_allocation_seconds(prior, config['settings']), ordinary)
            prompt = coordinator_prompt(config, job, manifests)
            self.assertIn('3 proposal/revision -> review cycles', prompt)
            final.update(status='failed', failure_kind='operational', message='Authentication unavailable')
            with self.assertRaisesRegex(ValueError, 'Authentication unavailable'):
                verify_completion(job, final, config, manifests)


if __name__ == '__main__':
    unittest.main()

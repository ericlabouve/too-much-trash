"""Round API rejection and concurrency guarantees without starting a training job."""

import json
from pathlib import Path
from tempfile import TemporaryDirectory
from threading import Thread
import unittest
from unittest.mock import Mock, patch
from urllib.error import HTTPError
from urllib.request import Request, urlopen
from http.server import ThreadingHTTPServer

from dashboard_server import DashboardHandler, Jobs, validate_settings


class RoundServiceTests(unittest.TestCase):
    def test_smaller_defaults_reduce_future_agent_counts_without_skipping_current_parents(self):
        from dashboard_agents import agent_counts
        from dataclasses import asdict
        from run_joint_round import JointCandidate
        settings = validate_settings({})
        self.assertEqual([settings[key] for key in
                          ('pool_size', 'research_slots', 'protected_slots', 'mutation_attempts', 'family_limit')],
                         [8, 2, 2, 2, 2])
        self.assertEqual(settings['agent_minutes'], 20)
        pool = [asdict(JointCandidate(f'parent-{index}', 'imu', .1)) for index in range(10)]
        transition = agent_counts({'next_pool': pool}, settings)
        steady = agent_counts({'next_pool': pool[:8]}, settings)
        self.assertEqual((transition['evolution'], transition['research'], transition['integrity_review']), (10, 2, 12))
        self.assertEqual((steady['evolution'], steady['research'], steady['integrity_review']), (8, 2, 10))

    def test_breeding_parameters_are_persisted_and_cannot_bypass_the_selector(self):
        settings = validate_settings({'protected_slots': 0, 'mutation_attempts': 7, 'family_limit': 2})
        self.assertEqual((settings['protected_slots'], settings['mutation_attempts'], settings['family_limit']), (0, 7, 2))
        self.assertEqual(settings['selection_protocol'], 'portfolio-v1')
        for update in ({'protected_slots': True}, {'protected_slots': 10},
                       {'mutation_attempts': 0}, {'mutation_attempts': 21},
                       {'family_limit': 0}, {'family_limit': 11},
                       {'selection_protocol': 'manual'}):
            with self.subTest(update=update), self.assertRaises(ValueError):
                validate_settings(update)

    def test_new_round_defaults_require_checkpoint_protocol(self):
        self.assertEqual(validate_settings({})['training_protocol'], 'validation-checkpoints-v1')
        with self.assertRaisesRegex(ValueError, 'validation checkpoints'):
            validate_settings({'training_protocol': 'last-epoch'})

    def setUp(self):
        datasets = patch('dashboard_server.discover_datasets', return_value=[
            {'name': 'beach', 'clip_count': 242}, {'name': 'home', 'clip_count': 5},
            {'name': 'park', 'clip_count': 57}])
        datasets.start()
        self.addCleanup(datasets.stop)
        auth = patch('dashboard_server.readiness', return_value={'ready': True})
        auth.start()
        self.addCleanup(auth.stop)

    def test_settings_reject_invalid_or_unapplied_values(self):
        for settings in ({'family': '../MLP'}, {'pool_size': True}, {'clip_limit': -1},
                         {'evolution_agents': 11}, {'evolution_agents': True}, {'research_slots': 0},
                         {'jaw_weight': float('nan')}, {'full_speed_ms': 30},
                         {'target_basis': 'withheld'}, {'command': 'echo'},
                         {'agent_concurrency': 6}, {'agent_prompt': 123}, {'agent_prompt': 'x' * 8001},
                         {'review_agents': 0}, {'review_agents': 6}, {'review_agents': True},
                         {'mode': 'bounded_mutations'}):
            with self.subTest(settings=settings), self.assertRaises(ValueError):
                validate_settings(settings)

    def test_agent_counts_are_independent_settings(self):
        settings = validate_settings({'research_slots': 5, 'pool_size': 10})
        self.assertNotIn('evolution_agents', settings)
        self.assertEqual(settings['research_slots'], 5)
        self.assertEqual(validate_settings({})['reproduction_protocol'], 'all-pool-v1')
        self.assertEqual(validate_settings({})['review_agents'], 1)
        self.assertEqual(validate_settings({})['review_protocol'], 'per-candidate-v1')
        self.assertEqual(validate_settings({'agent_concurrency': 5})['agent_concurrency'], 5)

    def test_obsolete_reproduction_cap_cannot_silently_limit_a_new_round(self):
        with self.assertRaisesRegex(ValueError, 'obsolete.*every selected pool candidate'):
            validate_settings({'evolution_agents': 7})
        with self.assertRaisesRegex(ValueError, 'all-pool-v1'):
            validate_settings({'reproduction_protocol': 'top-seven'})
        with self.assertRaisesRegex(ValueError, 'per-candidate-v1'):
            validate_settings({'review_protocol': 'shared'})

    def test_frame_fraction_bounds_derive_consistent_saved_times(self):
        settings=validate_settings({'target_fps':60,'full_speed_frame_fraction':.25,'zero_speed_frame_fraction':1})
        self.assertAlmostEqual(settings['full_speed_ms'],1000/60/4)
        self.assertAlmostEqual(settings['frame_budget_ms'],1000/60)
        slower=validate_settings({'target_fps':30,'full_speed_frame_fraction':.25,'zero_speed_frame_fraction':.75})
        self.assertAlmostEqual(slower['full_speed_ms'],1000/30/4)
        self.assertAlmostEqual(slower['frame_budget_ms'],25)
        for bad in ({'full_speed_frame_fraction':1,'zero_speed_frame_fraction':.25},
                    {'target_fps':0},{'target_fps':True},{'zero_speed_frame_fraction':float('nan')},
                    {'target_fps':60,'frame_budget_ms':25}):
            with self.subTest(bad=bad),self.assertRaises(ValueError):validate_settings(bad)
        legacy=validate_settings({'frame_budget_ms':25})
        self.assertAlmostEqual(legacy['zero_speed_frame_fraction'],1.5)

    def test_common_dataset_rate_is_derived_and_cannot_be_overridden(self):
        datasets=[{'name':'beach','clip_count':242,'frame_rate':{'nominal_fps':60}},
                  {'name':'home','clip_count':5,'frame_rate':{'nominal_fps':60}},
                  {'name':'park','clip_count':57,'frame_rate':{'nominal_fps':None}}]
        with patch('dashboard_server.discover_datasets',return_value=datasets):
            settings=validate_settings({'datasets':['beach','home']})
            self.assertEqual(settings['target_fps'],60)
            with self.assertRaisesRegex(ValueError,'derived'):
                validate_settings({'datasets':['beach','home'],'target_fps':30})
            self.assertEqual(validate_settings({'target_fps':30})['target_fps'],30)

    def test_completed_new_family_advances_round_and_discovers_nonretained_family(self):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            output = root / 'runs'
            job = output / 'dashboard-001'
            job.mkdir(parents=True)
            parent = {'name': 'retained', 'method': 'imu'}
            proposal = {'name': 'new trees', 'method': 'extra_trees49'}
            prior_path = root / 'prior.json'
            prior_path.write_text(json.dumps({'round': 48, 'next_pool': [parent]}))
            result = {'round': 49, 'next_pool': [parent], 'ranked': [{'candidate': parent, 'fitness': .8}],
                      'challengers': [{'candidate': proposal, 'fitness': .77}],
                      'candidate_metadata': {proposal['name']: {'family': 'Extra Trees'}}}
            (job / 'results.json').write_text(json.dumps(result))
            (job / 'config.json').write_text(json.dumps({'settings': {'family': 'new_family', 'clip_limit': 0}}))
            (job / 'status.json').write_text(json.dumps({'state': 'completed', 'mode': 'agent_guided',
                                                        'result': {'subset': True}}))
            (output / 'dashboard-active.json').write_text(json.dumps({'pid': 123, 'job_directory': str(job)}))
            jobs = Jobs(root, prior_path, output)
            state = jobs.snapshot()
            self.assertEqual(state['next_round'], 50)
            self.assertEqual(jobs.prior, (job / 'results.json').resolve())
            self.assertIn({'value': 'Extra Trees', 'label': 'Extra Trees'}, state['families'])
            self.assertEqual(state['family_candidate_counts']['Extra Trees'], 1)
            self.assertEqual(state['retained_candidate_count'], 1)
            self.assertFalse(state['result']['subset'])
            self.assertEqual(validate_settings({'family': 'Extra Trees'}, ['Extra Trees'])['family'], 'Extra Trees')
            self.assertEqual(json.loads((output / 'dashboard-current.json').read_text())['results_path'], str((job / 'results.json').resolve()))

    def test_handwritten_gated_completion_cannot_promote(self):
        with TemporaryDirectory() as directory:
            root = Path(directory); output = root / 'runs'; job = output / 'dashboard-forged'
            job.mkdir(parents=True)
            prior = root / 'prior.json'
            prior.write_text(json.dumps({'round': 50, 'next_pool': [{'name': 'baseline', 'method': 'imu'}]}))
            (job / 'config.json').write_text(json.dumps({'settings': {'review_agents': 2, 'family': 'all', 'clip_limit': 0}}))
            (job / 'status.json').write_text(json.dumps({'state': 'completed', 'mode': 'agent_guided',
                                                        'result': {'subset': False}}))
            (job / 'results.json').write_text(json.dumps({'round': 51, 'next_pool': [{'name': 'unreviewed'}]}))
            (output / 'dashboard-active.json').write_text(json.dumps({'pid': 99999999, 'job_directory': str(job)}))
            jobs = Jobs(root, prior, output)
            with patch('dashboard_server.os.kill', side_effect=ProcessLookupError):
                state = jobs.snapshot()
            self.assertEqual(state['state'], 'failed')
            self.assertEqual(state['phase'], 'integrity_review')
            self.assertEqual(jobs.prior.resolve(), prior.resolve())
            self.assertFalse((output / 'dashboard-current.json').exists())

    def test_same_origin_and_single_worker(self):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            prior = root / 'prior.json'
            prior.write_text(json.dumps({'round': 48, 'next_pool': [{'name': 'Threshold parent', 'method': 'imu'}]}))
            jobs = Jobs(root, prior, root / 'runs')
            server = ThreadingHTTPServer(('127.0.0.1', 0), DashboardHandler)
            server.jobs = jobs
            thread = Thread(target=server.serve_forever, daemon=True)
            thread.start()
            address = f'http://127.0.0.1:{server.server_port}/api/round'
            def post(origin):
                request = Request(address, data=json.dumps({'family': 'Threshold', 'clip_limit': 2,
                                                          'agent_prompt': 'Explore temporal models.\nKeep inference causal.'}).encode(),
                                  headers={'Content-Type': 'application/json', 'Origin': origin})
                return urlopen(request)
            try:
                with self.assertRaises(HTTPError) as denied:
                    post('https://unrelated.example')
                self.assertEqual(denied.exception.code, 403)
                denied.exception.close()
                worker = Mock()
                worker.pid = 12345
                worker.poll.return_value = None
                with patch('dashboard_server.subprocess.Popen', return_value=worker) as spawn:
                    preview = Request(address + '/preview',
                                      data=json.dumps({'agent_prompt': 'Explore temporal models.\nKeep inference causal.'}).encode(),
                                      headers={'Content-Type': 'application/json',
                                               'Origin': address.removesuffix('/api/round')})
                    with urlopen(preview) as response:
                        disclosure = json.load(response)
                    self.assertIn('Explore temporal models.\nKeep inference causal.', disclosure['prompt'])
                    self.assertIn('Pass this additional research direction verbatim', disclosure['prompt'])
                    spawn.assert_not_called()
                    with post(address.removesuffix('/api/round')) as response:
                        state = json.load(response)
                    self.assertEqual(state['state'], 'running')
                    self.assertEqual(state['next_round'], 49)
                    self.assertEqual(state['families'][0]['value'], 'all')
                    with self.assertRaises(HTTPError) as conflict:
                        post(address.removesuffix('/api/round'))
                    self.assertEqual(conflict.exception.code, 409)
                    conflict.exception.close()
                    spawn.assert_called_once()
                config = json.loads(next((root / 'runs').glob('*/config.json')).read_text())
                self.assertEqual(config['settings']['clip_limit'], 2)
                self.assertEqual(config['settings']['agent_prompt'], 'Explore temporal models.\nKeep inference causal.')
            finally:
                server.shutdown()
                server.server_close()


if __name__ == '__main__':
    unittest.main()

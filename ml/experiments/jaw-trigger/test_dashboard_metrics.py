"""Keep fitness history comparable and choose leaders from measured validation scores."""

from copy import deepcopy
from hashlib import sha256
import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from dashboard_metrics import LeaderHistory, leader_context


class LeaderMetricTests(unittest.TestCase):
    def fixture(self):
        def entry(name, f1):
            return {'candidate': {'name': name}, 'development': {'f1': f1},
                    'split_scores': {'train': {'f1': .99}, 'validation': {'f1': f1}, 'test': None},
                    'p95_ms': 1., 'fitness': -999}
        result = {'round': 49, 'reporting': 'validation', 'settings': {
            'family': 'new_family', 'seed': 0, 'jaw_weight': .8, 'match_seconds': .5,
            'full_speed_ms': 4., 'frame_budget_ms': 16., 'datasets': ['beach'],
            'clip_limit': 0, 'train_percent': 60, 'validation_percent': 20, 'test_percent': 20},
            'ranked': [entry('old winner', .5)], 'challengers': [entry('fresh winner', .75)]}
        inputs = {'snapshot_sha256': sha256(b'fixture').hexdigest(), 'datasets': ['beach'],
                  'splits': {name: [{'clip': name + ':uuid'}] for name in ('train', 'validation', 'test')},
                  'counts': {'train': 1, 'validation': 1, 'test': 1}}
        return result, inputs, {'round_one.py': 'hash-a', 'joint_fitness.py': 'hash-b'}

    def test_selects_measured_validation_leader_and_recomputes_fitness(self):
        result, inputs, protocol = self.fixture()
        context = leader_context(result, inputs, 'job', protocol)
        point = context['points'][0]
        self.assertEqual(point['name'], 'fresh winner')
        self.assertEqual(point['jaw'], .75)
        self.assertAlmostEqual(point['fitness'], .8)
        self.assertFalse(point['isolated'])
        result['settings']['clip_limit'] = 3
        self.assertTrue(leader_context(result, inputs, 'job', protocol)['points'][0]['isolated'])
        result['reporting'] = 'in_sample'
        self.assertIsNone(leader_context(result, inputs, 'job', protocol))

    def test_snapshot_split_scoring_protocol_and_scope_invalidate_comparison(self):
        result, inputs, protocol = self.fixture()
        identifier = leader_context(result, inputs, 'job', protocol)['id']
        for key, value in [('seed', 1), ('jaw_weight', .6), ('match_seconds', .2),
                           ('full_speed_ms', 3), ('frame_budget_ms', 20), ('family', 'MLP')]:
            with self.subTest(setting=key):
                changed = deepcopy(result)
                changed['settings'][key] = value
                self.assertNotEqual(identifier, leader_context(changed, inputs, 'job', protocol)['id'])
        changed = deepcopy(inputs)
        changed['splits']['validation'][0]['clip'] = 'other:uuid'
        self.assertNotEqual(identifier, leader_context(result, changed, 'job', protocol)['id'])
        changed = deepcopy(inputs)
        changed['snapshot_sha256'] = 'new-snapshot'
        self.assertNotEqual(identifier, leader_context(result, changed, 'job', protocol)['id'])
        self.assertNotEqual(identifier, leader_context(result, inputs, 'job', {**protocol, 'round_one.py': 'new'})['id'])
        result['settings'].update(family='all', target_f1=.99, research_slots=3)
        self.assertEqual(identifier, leader_context(result, inputs, 'another-job', protocol)['id'])

    def test_only_completed_jobs_and_current_snapshot_can_supply_table_scores(self):
        result, inputs, protocol = self.fixture()
        result['benchmark_protocol'] = 'deployment-v1'
        with TemporaryDirectory() as directory:
            root = Path(directory)
            snapshot = root / 'SNAPSHOT.json'
            snapshot.write_bytes(b'fixture')
            job = root / 'dashboard-001'
            (job / 'evaluator-source').mkdir(parents=True)
            files = {'status.json': {'state': 'running', 'mode': 'agent_guided'},
                     'config.json': {'settings': result['settings']},
                     'results.json': result, 'inputs.json': inputs,
                     'evaluator-source/sha256.json': protocol}
            for name, value in files.items():
                (job / name).write_text(json.dumps(value))
            history = LeaderHistory(root, snapshot)
            self.assertEqual(history.snapshot(), [])
            (job / 'status.json').write_text(json.dumps({'state': 'completed', 'mode': 'agent_guided'}))
            self.assertEqual(len(history.snapshot()), 1)
            self.assertEqual(len(history.views), 1)
            self.assertEqual(len(history.views[0]['entries']), 2)
            self.assertEqual(history.views[0]['benchmark_protocol'], 'deployment-v1')
            self.assertEqual(len(history.snapshot()[0]['points']), 1)  # cache doesn't duplicate points
            snapshot.write_bytes(b'new-frozen-snapshot')
            self.assertEqual(len(history.snapshot()), 1)  # historical chart remains available
            self.assertEqual(history.views, [])  # current table can't inherit old-snapshot scores

    def test_supervised_source_snapshots_supply_history_without_legacy_hash_manifest(self):
        result, inputs, _ = self.fixture()
        result['round'] = 51
        result['settings']['clip_limit'] = 12
        with TemporaryDirectory() as directory:
            root = Path(directory); snapshot = root / 'SNAPSHOT.json'; snapshot.write_bytes(b'fixture')
            job = root / 'dashboard-001'
            source = job / 'protected-source/ml/experiments/jaw-trigger'; source.mkdir(parents=True)
            for name in ('round_one.py', 'joint_fitness.py'):
                (source / name).write_text('frozen evaluator fixture')
            for name, value in {'status.json': {'state': 'completed', 'mode': 'agent_guided'},
                                'config.json': {'settings': result['settings']},
                                'results.json': result, 'inputs.json': inputs}.items():
                (job / name).write_text(json.dumps(value))
            contexts = LeaderHistory(root, snapshot).snapshot()
            self.assertEqual(contexts[0]['points'][0]['round'], 51)
            self.assertTrue(contexts[0]['points'][0]['isolated'])
            self.assertEqual(contexts[0]['identity']['protocol']['round_one.py'], sha256(b'frozen evaluator fixture').hexdigest())

    def test_source_hash_key_style_does_not_split_comparable_rounds(self):
        result, inputs, protocol = self.fixture()
        with TemporaryDirectory() as directory:
            root = Path(directory)
            snapshot = root / 'SNAPSHOT.json'
            snapshot.write_bytes(b'fixture')
            for index in range(2):
                job = root / f'dashboard-{index}'
                (job / 'evaluator-source').mkdir(parents=True)
                result['round'] = 49 + index
                hashes = protocol if index == 0 else {f'ml/experiments/jaw-trigger/{key}': value for key, value in protocol.items()}
                for name, value in {'status.json': {'state': 'completed', 'mode': 'agent_guided'},
                                    'config.json': {'settings': result['settings']},
                                    'results.json': result, 'inputs.json': inputs,
                                    'evaluator-source/sha256.json': hashes}.items():
                    (job / name).write_text(json.dumps(value))
            contexts = LeaderHistory(root, snapshot).snapshot()
            self.assertEqual(len(contexts), 1)
            self.assertEqual([point['round'] for point in contexts[0]['points']], [49, 50])

    def test_cached_history_cannot_publish_a_self_stamped_integrity_approval(self):
        result, inputs, protocol = self.fixture()
        result['integrity_review'] = {'status': 'approved', 'candidate_status': {'fresh winner': 'approved'}}
        with TemporaryDirectory() as directory:
            root = Path(directory)
            snapshot = root / 'SNAPSHOT.json'
            snapshot.write_bytes(b'fixture')
            job = root / 'dashboard-001'
            (job / 'evaluator-source').mkdir(parents=True)
            for name, value in {'status.json': {'state': 'completed', 'mode': 'agent_guided'},
                                'config.json': {'settings': result['settings']},
                                'results.json': result, 'inputs.json': inputs,
                                'evaluator-source/sha256.json': protocol}.items():
                (job / name).write_text(json.dumps(value))
            history = LeaderHistory(root, snapshot)
            self.assertEqual(history.snapshot()[0]['points'][0]['integrity'], 'legacy_unreviewed')
            self.assertIsNone(history.views[0]['integrity_review'])
            # A gated job must have a genuine outer-worker receipt, even if its
            # status, result and an earlier cached chart all look successful.
            result['settings']['review_agents'] = 2
            (job / 'config.json').write_text(json.dumps({'settings': result['settings']}))
            (job / 'results.json').write_text(json.dumps(result))
            self.assertEqual(history.snapshot(), [])
            self.assertEqual(history.views, [])

    def test_recovery_directory_cannot_hide_a_later_round(self):
        result, inputs, protocol = self.fixture()
        with TemporaryDirectory() as directory:
            root = Path(directory)
            snapshot = root / 'SNAPSHOT.json'; snapshot.write_bytes(b'fixture')
            for name, number in (('dashboard-recovery-r60', 60), ('dashboard-20261128-r61', 61)):
                job = root / name; (job / 'evaluator-source').mkdir(parents=True)
                current = {**result, 'round': number}
                for filename, value in {'status.json': {'state': 'completed', 'mode': 'agent_guided'},
                                        'config.json': {'settings': current['settings']},
                                        'results.json': current, 'inputs.json': inputs,
                                        'evaluator-source/sha256.json': protocol}.items():
                    (job / filename).write_text(json.dumps(value))
            history = LeaderHistory(root, snapshot)
            contexts = history.snapshot()
            self.assertEqual([point['round'] for point in contexts[0]['points']], [60, 61])
            self.assertEqual(history.views[0]['round'], 61)
            self.assertEqual(history.views[0]['job'], 'dashboard-20261128-r61')


if __name__ == '__main__':
    unittest.main()

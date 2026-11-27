"""Dataset identity and partition integrity without decoding or changing source footage."""

import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest
from uuid import NAMESPACE_URL, uuid5

from dashboard_datasets import build_split_manifest, discover_datasets, validate_split_settings, common_frame_rate


class DatasetSplitTests(unittest.TestCase):
    def setUp(self):
        self.temporary = TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        (self.root / 'SNAPSHOT.json').write_text(json.dumps({'created_at': 'frozen-fixture'}))
        for name, count in [('beach', 10), ('home', 5)]:
            items = []
            for index in range(count):
                directory = self.root / name / 'episodes' / f'{index + 1:03}'
                directory.mkdir(parents=True)
                uuid = str(uuid5(NAMESPACE_URL, f'{name}/{index}'))
                capture = {'episode_id': uuid.upper(), 'complete': False,
                           'timing': {'start': 100, 'press': 103, 'release': 105, 'end': 108}}
                (directory / 'manifest.json').write_text(json.dumps(capture))
                for filename in ['video.mp4', 'imu.jsonl', 'poses.jsonl']:
                    (directory / filename).touch()
                items.append({'id': f'clip-{index + 1:03}', 'episode_id': uuid,
                              'files': {key: f'episodes/{index + 1:03}/{filename}'
                                        for key, filename in [('video', 'video.mp4'), ('imu', 'imu.jsonl'),
                                                              ('poses', 'poses.jsonl'), ('manifest', 'manifest.json')]}})
            (self.root / name / 'labels.json').write_text(json.dumps({'items': items}))
        self.settings = {'datasets': ['home', 'beach'], 'train_percent': 60,
                         'validation_percent': 20, 'test_percent': 20, 'seed': 7, 'clip_limit': 0}

    def test_seeded_disjoint_partitions_and_global_identity(self):
        first = build_split_manifest(self.settings, self.root)
        second = build_split_manifest(self.settings | {'datasets': ['beach', 'home']}, self.root)
        self.assertEqual(first, second)
        self.assertEqual(first['counts'], {'train': 9, 'validation': 3, 'test': 3})
        ids = [row['clip'] for split in first['splits'].values() for row in split]
        self.assertEqual(len(ids), len(set(ids)))
        self.assertEqual(len(ids), 15)
        self.assertEqual(first['clips'][0]['jaw_reference'], {'close': 3, 'open': 5})
        self.assertTrue(all(Path(row['video']).is_absolute() for row in first['clips']))
        changed = build_split_manifest(self.settings | {'seed': 8}, self.root)
        self.assertNotEqual(first['splits'], changed['splits'])
        self.assertEqual(set(ids), {row['clip'] for row in changed['clips']})

    def test_selection_and_limit_apply_before_partitioning(self):
        self.assertEqual(discover_datasets(self.root)[0]['clip_count'], 10)
        result = build_split_manifest(self.settings | {'datasets': ['beach'], 'clip_limit': 5}, self.root)
        self.assertEqual(result['counts'], {'train': 3, 'validation': 1, 'test': 1})
        self.assertTrue(all(row['dataset'] == 'beach' for row in result['clips']))
        with self.assertRaisesRegex(ValueError, 'Too few'):
            build_split_manifest(self.settings | {'clip_limit': 2}, self.root)

    def test_discovery_counts_effective_labels_including_future_labels(self):
        path = self.root / 'beach' / 'labels.json'
        data = json.loads(path.read_text())
        values = ['confirmed'] * 6 + ['not_deposited', 'uncertain', 'held_item', None]
        for item, label in zip(data['items'], values, strict=True):
            item['label'] = label
            item['ai'] = {'prediction': 'not_deposited'}
        data['summary'] = {'labels': {'confirmed': 999}}
        path.write_text(json.dumps(data))
        dataset = next(row for row in discover_datasets(self.root) if row['name'] == 'beach')
        self.assertEqual(dataset['label_counts'], {
            'confirmed': 6, 'not_deposited': 1, 'uncertain': 1, 'held_item': 1, 'unlabeled': 1})
        self.assertEqual(sum(dataset['label_counts'].values()), dataset['clip_count'])

    def test_invalid_split_configuration(self):
        available = discover_datasets(self.root)
        for changes in ({'datasets': []}, {'datasets': ['unknown']}, {'datasets': ['beach', 'beach']},
                        {'train_percent': True}, {'test_percent': 40}, {'train_percent': 0, 'test_percent': 80}):
            with self.subTest(changes=changes), self.assertRaises(ValueError):
                validate_split_settings(self.settings | changes, available)

    def test_frame_rates_normalize_sixty_with_five_percent_tolerance(self):
        for collection,rates in [('beach',[57,58,59,60,61,62,63,60,60,60]),('home',[30]*5)]:
            for index,rate in enumerate(rates,1):
                path=self.root/collection/f'episodes/{index:03d}/manifest.json'
                capture=json.loads(path.read_text())
                capture['sensor_metadata']={'videoSegmentJoins':[{'estimatedFrameInterval':1/rate}]}
                path.write_text(json.dumps(capture))
        datasets=discover_datasets(self.root)
        beach=next(row for row in datasets if row['name']=='beach')
        self.assertEqual(beach['frame_rate']['counts'],{'60':10})
        self.assertEqual(common_frame_rate(['beach'],datasets),60)
        self.assertEqual(common_frame_rate(['home'],datasets),30)
        self.assertIsNone(common_frame_rate(['beach','home'],datasets))

    def test_unknown_source_cadence_prevents_automatic_frame_rate(self):
        for index in range(1,11):
            path=self.root/'beach'/f'episodes/{index:03d}/manifest.json'
            capture=json.loads(path.read_text());rate=56.9 if index==1 else 60
            capture['sensor_metadata']={'videoSegmentJoins':[{'estimatedFrameInterval':1/rate}]}
            path.write_text(json.dumps(capture))
        datasets=discover_datasets(self.root)
        self.assertIsNone(common_frame_rate(['beach'],datasets))
        self.assertEqual(next(row for row in datasets if row['name']=='beach')['frame_rate']['unknown_clips'],1)

    def test_uuid_mismatch_and_source_escape_are_rejected(self):
        labels = self.root / 'home' / 'labels.json'
        source = json.loads(labels.read_text())
        source['items'][0]['episode_id'] = str(uuid5(NAMESPACE_URL, 'different'))
        labels.write_text(json.dumps(source))
        with self.assertRaisesRegex(ValueError, 'UUID'):
            build_split_manifest(self.settings, self.root)
        source['items'][0]['files']['video'] = '../SNAPSHOT.json'
        labels.write_text(json.dumps(source))
        with self.assertRaisesRegex(ValueError, 'inside'):
            build_split_manifest(self.settings, self.root)

    def test_repeated_capture_cannot_enter_multiple_partitions(self):
        labels = self.root / 'home' / 'labels.json'
        source = json.loads(labels.read_text())
        source['items'][0]['episode_id'] = source['items'][1]['episode_id']
        source['items'][0]['files'] = source['items'][1]['files']
        labels.write_text(json.dumps(source))
        with self.assertRaisesRegex(ValueError, 'duplicate capture UUIDs'):
            build_split_manifest(self.settings, self.root)


if __name__ == '__main__':
    unittest.main()

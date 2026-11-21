"""Synthetic regression coverage for organized and legacy dataset layouts."""
import hashlib
import json
from pathlib import Path
import sys
import tempfile
import time
import unittest
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).parent))
import layout
from workspace import Dataset, Workspace, atomic_json, is_dataset
from predictions import Jobs, prediction_history
from serve import load_manifest


class OrganizedLayoutTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = (Path(self.temp.name) / 'collection').resolve()
        self.root.mkdir()
        self.run = self.root / 'audit/runs/test'
        self.run.mkdir(parents=True)
        self.manifest = self.run / 'predictions.json'
        self.decisions = self.run / 'human-reviews.json'
        self.items = []
        for number in (1, 2):
            key = f'clip-{number:03d}'
            folder = self.root / 'episodes' / key
            folder.mkdir(parents=True)
            for name in ('video.mp4', 'imu.jsonl', 'poses.jsonl'):
                (folder / name).write_bytes(f'original-{key}-{name}'.encode())
            atomic_json(folder / 'manifest.json', dict(timing=dict(start=100, press=103, release=104, end=107)))
            self.items.append(dict(id=key, media=f'episodes/{key}/video.mp4',
                                   prediction='uncertain', confidence='medium',
                                   note=f'Evidence for {key}\nLimitations: Synthetic footage',
                                   run_id='test', model='fixture-model'))
        atomic_json(self.manifest, dict(title='Organized fixture', source='Synthetic', items=self.items))
        atomic_json(self.decisions, {})
        atomic_json(self.root / 'metadata/dataset.json',
                    dict(layout_version=2, active_prediction_manifest='audit/runs/test/predictions.json'))
        atomic_json(self.root / 'metadata/clip-index.json',
                    dict(clips=[dict(clip=f'clip-{i:03d}', episode_id=f'uuid-{i}') for i in (1, 2)]))

    def workspace(self, path=None, state='history.json'):
        return Workspace(path or self.root, state=Path(self.temp.name) / state)

    def test_frozen_dataset_selection_and_reads_never_write_annotations(self):
        workspace = self.workspace()
        original = {p:p.read_bytes() for p in self.root.rglob('*.json')}
        frozen = dict(kind='reference', label='Frozen Reference', read_only=True)
        with patch('workspace.storage_info', return_value=frozen), patch('labels.export_labels') as export:
            workspace.select(self.root)
            workspace.current.refresh()
            export.assert_not_called()
            with self.assertRaisesRegex(ValueError, 'read-only'):
                workspace.current.record('clip-001','uncertain','deny','confirmed')
            with self.assertRaisesRegex(ValueError, 'read-only'):
                Jobs(workspace).start(workspace.current, 1)
        for path,data in original.items():
            self.assertEqual(path.read_bytes(),data)

    def test_catalog_discovers_local_reference_and_working_datasets_without_history(self):
        home = Path(self.temp.name)/'home'
        expected = []
        for group in ('reference/current','working/review'):
            dataset = home/'Datasets/too-much-trash'/group/'beach'
            folder = dataset/'episodes/001'; folder.mkdir(parents=True)
            (folder/'video.mp4').write_bytes(b'fixture')
            expected.append(str(dataset))
        workspace = self.workspace()
        with patch('workspace.Path.home',return_value=home):
            choices = {x['path']:x for x in workspace.catalog()}
        for path in expected:
            self.assertTrue(choices[path]['available'])
            self.assertIsNotNone(choices[path]['storage'])

    def test_numeric_episode_folders_preserve_review_ids_and_worker_selection(self):
        rows = []
        for number, item in enumerate(self.items, 1):
            directory = f'{number:03d}'
            (self.root/'episodes'/item['id']).rename(self.root/'episodes'/directory)
            item['media'] = f'episodes/{directory}/video.mp4'
            rows.append(dict(clip=item['id'], directory=directory, episode_id=f'uuid-{number}'))
        atomic_json(self.root/'metadata/clip-index.json', dict(clips=rows))
        atomic_json(self.manifest, dict(items=self.items))
        review = dict(prediction='uncertain', decision='deny', corrected_label='confirmed')
        atomic_json(self.decisions, {'clip-001': review})
        workspace = self.workspace()
        videos, counts = Jobs(workspace).selection(workspace.current)
        self.assertEqual([v.parent.name for v in videos], ['002'])
        self.assertEqual(layout.sample_id(self.root, videos[0]), 'clip-002')
        labels = json.loads((self.root/'labels.json').read_text())['items']
        self.assertEqual(labels[0]['human_review'], review)
        self.assertEqual(labels[0]['files']['video'], 'episodes/001/video.mp4')
        self.assertEqual(counts['human_reviewed'], 1)

    def test_migrated_legacy_csv_enriches_only_original_review_run(self):
        config_path = self.root/'metadata/dataset.json'
        config = json.loads(config_path.read_text())
        config.update(legacy_review_manifest='audit/runs/test/predictions.json',
                      legacy_review_csv='metadata/review.csv')
        atomic_json(config_path, config)
        (self.root/'metadata/review.csv').write_text('clip,prediction_confidence\nclip-001,low\n')
        self.assertEqual(self.workspace().current.samples['clip-001']['confidence'], 'low')
        other = self.root/'audit/runs/new/predictions.json'
        atomic_json(other, dict(items=self.items))
        self.assertEqual(Dataset(self.root, other).samples['clip-001']['confidence'], 'medium')

    def test_layout_helpers_find_episode_media_manifests_and_review_logs(self):
        self.assertTrue(is_dataset(self.root))
        self.assertEqual(layout.episode_root(self.root), self.root / 'episodes')
        self.assertEqual([p.parent.name for p in layout.videos(self.root)], ['clip-001', 'clip-002'])
        self.assertEqual(layout.runs_root(self.root), self.root / 'audit/runs')
        self.assertIn(self.manifest, layout.manifests(self.root))
        self.assertIn(self.decisions, layout.review_logs(self.root))
        self.assertEqual(layout.dataset_root(self.root), self.root)
        self.assertEqual(layout.dataset_root(self.manifest), self.root)
        self.assertEqual(layout.default_manifest(self.root), self.manifest)
        self.assertEqual(layout.decisions_path(self.manifest), self.decisions)
        self.assertEqual(layout.relative(self.manifest, self.root), 'audit/runs/test/predictions.json')

    def test_root_and_nested_manifest_open_same_dataset_without_rewriting_sources(self):
        before = self.manifest.read_bytes()
        root_workspace = self.workspace()
        explicit_workspace = self.workspace(self.manifest, 'explicit-history.json')
        for workspace in (root_workspace, explicit_workspace):
            dataset = workspace.current
            self.assertEqual(dataset.root, self.root)
            self.assertEqual(dataset.manifest, self.manifest)
            self.assertEqual(dataset.decisions_path, self.decisions)
            self.assertEqual(dataset.media['clip-001'][0], self.root / 'episodes/clip-001/video.mp4')
            self.assertEqual(dataset.samples['clip-001']['start'], 2)
        self.assertEqual(self.manifest.read_bytes(), before)
        # Fresh local history still discovers the selected run through dataset metadata.
        self.assertEqual(self.workspace(state='fresh-history.json').current.manifest, self.manifest)

    def test_consolidation_preserves_human_precedence_and_root_relative_provenance(self):
        old = self.root / 'audit/runs/old/human-reviews.json'
        review = dict(prediction='uncertain', decision='deny', corrected_label='not_deposited')
        atomic_json(old, {'clip-001': review})
        workspace = self.workspace()
        labels = json.loads((self.root / 'labels.json').read_text())
        rows = {row['id']: row for row in labels['items']}
        self.assertEqual(rows['clip-001']['label'], 'not_deposited')
        self.assertEqual(rows['clip-001']['label_source'], 'human')
        self.assertEqual(rows['clip-001']['human_review'], review)
        self.assertEqual(rows['clip-001']['human_review_source'], 'audit/runs/old/human-reviews.json')
        self.assertEqual(rows['clip-001']['episode_id'], 'uuid-1')
        self.assertEqual(rows['clip-002']['files']['video'], 'episodes/clip-002/video.mp4')
        self.assertEqual(labels['prediction_manifest'], 'audit/runs/test/predictions.json')
        self.assertEqual(labels['human_decisions'], 'audit/runs/test/human-reviews.json')
        workspace.current.record('clip-002', 'uncertain', 'deny', 'confirmed')
        saved = json.loads(self.decisions.read_text())
        self.assertEqual(saved['clip-002']['corrected_label'], 'confirmed')
        self.assertEqual(Jobs(workspace).selection(workspace.current)[1]['eligible'], 0)

    def test_nested_manifest_media_cannot_escape_dataset_boundary(self):
        outside = Path(self.temp.name).resolve() / 'outside.mp4'
        outside.write_bytes(b'outside media')
        self.items[0]['media'] = '../outside.mp4'
        atomic_json(self.manifest, dict(items=self.items))
        with self.assertRaises(ValueError):
            load_manifest(self.manifest)

    def test_old_manifest_and_decision_bookmarks_remap_to_preserved_audit_run(self):
        old_manifest = self.root / 'label-review.agent-20261118-test.json'
        old_decisions = old_manifest.with_suffix('.decisions.json')
        metadata = json.loads((self.root / 'metadata/dataset.json').read_text())
        metadata['legacy_paths'] = {
            old_manifest.name: 'audit/runs/test/predictions.json',
            old_decisions.name: 'audit/runs/test/human-reviews.json',
        }
        atomic_json(self.root / 'metadata/dataset.json', metadata)
        review = dict(prediction='uncertain', decision='deny', corrected_label='confirmed')
        atomic_json(self.decisions, {'clip-001': review})
        manifest_bytes, decision_bytes = self.manifest.read_bytes(), self.decisions.read_bytes()

        workspace = Workspace(old_manifest, decisions=old_decisions,
                              state=Path(self.temp.name) / 'old-bookmark-history.json')

        self.assertEqual(workspace.current.root, self.root)
        self.assertEqual(workspace.current.manifest, self.manifest)
        self.assertEqual(workspace.current.decisions_path, self.decisions)
        self.assertEqual(workspace.current.decisions['clip-001'], review)
        self.assertEqual(workspace.current.media['clip-001'][0],
                         self.root / 'episodes/clip-001/video.mp4')
        self.assertFalse(old_manifest.exists())
        self.assertFalse(old_decisions.exists())
        self.assertEqual(self.manifest.read_bytes(), manifest_bytes)
        self.assertEqual(self.decisions.read_bytes(), decision_bytes)

    def test_saved_dataset_bookmark_remaps_missing_flat_manifest_on_reopen_and_select(self):
        old_manifest = self.root / 'label-review.agent-saved.json'
        metadata_path = self.root / 'metadata/dataset.json'
        metadata = json.loads(metadata_path.read_text())
        metadata['legacy_paths'] = {old_manifest.name: 'audit/runs/test/predictions.json'}
        atomic_json(metadata_path, metadata)
        state = Path(self.temp.name) / 'saved-bookmark-history.json'
        old_entry = dict(path=str(self.root), manifest=str(old_manifest))
        atomic_json(state, [old_entry])

        workspace = Workspace(self.root, state=state)
        self.assertEqual(workspace.current.manifest, self.manifest)
        self.assertEqual(workspace.current.decisions_path, self.decisions)
        self.assertEqual(json.loads(state.read_text())[0]['manifest'], str(self.manifest))
        # The dataset dropdown can also encounter a historical entry in a running process.
        workspace.history = [old_entry]
        selected = workspace.select(self.root)
        self.assertEqual(selected.manifest, self.manifest)
        self.assertEqual(selected.media['clip-002'][0],
                         self.root / 'episodes/clip-002/video.mp4')

    def test_legacy_bookmark_mapping_cannot_escape_dataset_boundary(self):
        old_manifest = self.root / 'label-review.agent-old.json'
        metadata_path = self.root / 'metadata/dataset.json'
        metadata = json.loads(metadata_path.read_text())
        metadata['legacy_paths'] = {old_manifest.name: '../outside/predictions.json'}
        atomic_json(metadata_path, metadata)
        with self.assertRaisesRegex(ValueError, 'inside dataset root'):
            self.workspace(old_manifest)

    def test_new_prediction_run_stays_inside_audit_and_keeps_organized_media_paths(self):
        # A historical human label must prevent that clip from receiving another agent.
        atomic_json(self.root / 'audit/runs/old/human-reviews.json',
                    {'clip-001': dict(prediction='uncertain', decision='deny', corrected_label='confirmed')})
        original_manifest = self.manifest.read_bytes()
        original_decisions = self.decisions.read_bytes()
        originals = {p: hashlib.sha256(p.read_bytes()).hexdigest()
                     for folder in (self.root / 'episodes').iterdir() for p in folder.iterdir()}
        workspace = self.workspace()
        jobs = Jobs(workspace)
        commands = []

        class Process:
            def __init__(self, command, **kwargs):
                commands.append(command)
                atomic_json(Path(command[command.index('-o') + 1]),
                            dict(prediction='confirmed', confidence='high', evidence='Fixture evidence', limitations='Synthetic fixture'))
            def wait(self, timeout=None): return 0
            def terminate(self): pass

        with patch('predictions.shutil.which', return_value='/fixture/tool'), \
                patch('predictions.subprocess.run'), patch('predictions.prepare_tool', return_value=None), \
                patch('predictions.subprocess.Popen', Process):
            job = jobs.start(workspace.current, 2)
            deadline = time.monotonic() + 5
            while jobs.status()['state'] == 'running' and time.monotonic() < deadline:
                time.sleep(.01)
        self.assertEqual(jobs.status()['state'], 'completed', jobs.status())
        self.assertEqual(jobs.status()['completed'], 1)
        self.assertEqual(job['sample_ids'], ['clip-002'])
        run = Path(job['run_path'])
        self.assertTrue(run.is_relative_to(self.root / 'audit/runs'))
        self.assertEqual(Path(job['manifest']), run / 'predictions.json')
        self.assertTrue((run / 'human-reviews.json').is_file())
        self.assertEqual(len(commands), 1)
        command = commands[0]
        self.assertEqual(Path(command[command.index('-o') + 1]).parent, run / 'responses')
        self.assertEqual(Path(command[command.index('-i') + 1]).parent, run / 'contact-sheets')
        self.assertTrue(Path(command[command.index('-C') + 1]).is_relative_to(run / 'scratch'))
        self.assertEqual(len(list((run / 'prompts').glob('clip-002*'))), 1)
        self.assertEqual(len(list((run / 'logs').glob('clip-002*'))), 1)
        self.assertEqual(len(list((run / 'context').glob('clip-002*'))), 1)
        published = json.loads((run / 'predictions.json').read_text())
        self.assertEqual({item['media'] for item in published['items']},
                         {'episodes/clip-001/video.mp4', 'episodes/clip-002/video.mp4'})
        self.assertEqual(self.manifest.read_bytes(), original_manifest)
        self.assertEqual(self.decisions.read_bytes(), original_decisions)
        for path, digest in originals.items():
            self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(), digest)
        # The new run is discoverable on reopening without relying on a local registry.
        reopened = self.workspace(state='new-machine-history.json')
        self.assertEqual(reopened.current.manifest, run / 'predictions.json')
        self.assertEqual(reopened.current.media['clip-002'][0], self.root / 'episodes/clip-002/video.mp4')
        prior = prediction_history(reopened.current)
        self.assertTrue(any(row['evidence'] == 'Fixture evidence' for row in prior['clip-002']))

    def test_legacy_flat_collection_remains_supported(self):
        legacy = (Path(self.temp.name) / 'legacy').resolve()
        (legacy / 'clip-001').mkdir(parents=True)
        (legacy / 'clip-001/video.mp4').write_bytes(b'legacy original')
        atomic_json(legacy / 'label-review.json', dict(items=[
            dict(id='clip-001', media='clip-001/video.mp4', prediction='confirmed')]))
        workspace = Workspace(legacy, state=Path(self.temp.name) / 'legacy-history.json')
        self.assertEqual(workspace.current.root, legacy)
        self.assertEqual(layout.episode_root(legacy), legacy)
        self.assertEqual(layout.runs_root(legacy), legacy / '.review/runs')
        self.assertEqual(workspace.current.media['clip-001'][0], legacy / 'clip-001/video.mp4')


if __name__ == '__main__':
    unittest.main()

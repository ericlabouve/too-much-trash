"""Local dataset discovery, immutable prediction runs, and decision isolation."""
import csv
import hashlib
import json
import os
from pathlib import Path
from threading import RLock
import layout

FILES = ('video.mp4', 'imu.jsonl', 'poses.jsonl', 'manifest.json')


def storage_info(root):
    root = Path(root).resolve()
    read_only = bool(os.statvfs(root).f_flag & os.ST_RDONLY) or not os.access(root, os.W_OK)
    if root.is_relative_to(Path('/Volumes/ERICS_DRIVE')):
        kind, label = 'golden', 'Golden set'
    elif read_only:
        kind, label = 'reference', 'Frozen Reference'
    elif root.is_relative_to(Path.home()/'Datasets/too-much-trash/working'):
        kind, label = 'working', 'Working copy'
    else:
        kind, label = 'local', 'Local dataset'
    return dict(kind=kind, label=label, read_only=read_only)


def atomic_json(path, value):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    pending = path.with_suffix(path.suffix + '.tmp')
    pending.write_text(json.dumps(value, indent=2, ensure_ascii=False) + '\n')
    pending.replace(path)


def is_dataset(path):
    return path.is_dir() and ((path / 'label-review.json').is_file() or
           bool(layout.videos(path)))


class Dataset:
    def __init__(self, root, manifest=None, decisions=None):
        self.root = Path(root).expanduser().resolve()
        if not is_dataset(self.root) and manifest is None:
            raise ValueError('Choose a dataset containing clip folders or label-review.json')
        self.manifest = layout.remap(Path(manifest), self.root) if manifest else layout.default_manifest(self.root)
        self.decisions_path = layout.remap(Path(decisions), self.root) if decisions else layout.decisions_path(self.manifest)
        # Park's original decision log uses this historical name; resume it intact.
        if not decisions and self.manifest.name == 'label-review.json' and not self.decisions_path.exists():
            legacy = self.root / 'deposit-prediction-validation.json'
            if legacy.exists():
                self.decisions_path = legacy
        self.key = hashlib.sha256((str(self.root) + '\0' + str(self.manifest)).encode()).hexdigest()
        self.lock = RLock()
        self.refresh()

    def refresh(self):
        from serve import load_manifest, capture_review_timing
        with self.lock:
            if self.manifest.exists():
                self.title, self.source, self.samples, self.media = load_manifest(self.manifest, self.root)
            else:
                self.title, self.source = self.root.name, 'No agent predictions yet'
                self.samples, self.media = {}, {}
                for video in layout.videos(self.root):
                    folder = video.parent
                    if not folder.is_dir() or not (folder / 'video.mp4').is_file():
                        continue
                    item = layout.sample_id(self.root, video)
                    start, timing = capture_review_timing(folder / 'video.mp4', 0, '')
                    self.samples[item] = dict(id=item, prediction=None, label='Awaiting prediction', kind='video', start=start,
                                              timing=timing, note='', confidence=None)
                    self.media[item] = ((folder / 'video.mp4').resolve(), 'video/mp4')
            # Confidence is optional in the historical manifest; join the original CSV.
            csv_path = self.root / 'review.csv'
            legacy_csv = self.manifest.name == 'label-review.json'
            if layout.organized(self.root):
                config = json.loads((self.root/'metadata/dataset.json').read_text())
                self.title = config.get('display_name', self.title)
                if config.get('legacy_review_manifest') == layout.relative(self.manifest, self.root):
                    csv_path = layout.checked(self.root, config['legacy_review_csv'])
                    legacy_csv = True
            if csv_path.exists() and legacy_csv:
                for row in csv.DictReader(csv_path.open()):
                    if row.get('clip') in self.samples:
                        self.samples[row['clip']]['confidence'] = row.get('prediction_confidence') or None
            self.decisions = json.loads(self.decisions_path.read_text()) if self.decisions_path.exists() else {}
            if not isinstance(self.decisions, dict):
                raise ValueError('Decision log must be keyed by sample ID')
            from labels import export_labels
            if not storage_info(self.root)['read_only']:
                export_labels(self)

    def record(self, item, prediction, decision, corrected_label=None):
        with self.lock:
            if storage_info(self.root)['read_only']:
                raise ValueError('Frozen references are read-only; select a working copy to edit labels')
            if not prediction or self.samples[item]['prediction'] != prediction:
                raise ValueError('Prediction changed; reload before reviewing')
            if decision not in ('approve', 'deny'):
                raise ValueError('Invalid review decision')
            record = dict(prediction=prediction, decision=decision)
            if prediction == 'uncertain' and corrected_label is None:
                raise ValueError('Choose Deposited or Not deposited for an uncertain prediction')
            if corrected_label is not None:
                if corrected_label not in ('confirmed', 'not_deposited'):
                    raise ValueError('Choose Deposited or Not deposited')
                expected = 'approve' if corrected_label == prediction else 'deny'
                if decision != expected:
                    raise ValueError('Review decision does not match the selected correct label')
                record['corrected_label'] = corrected_label
            updated = {**self.decisions, item: record}
            atomic_json(self.decisions_path, updated)
            self.decisions = updated
            from labels import export_labels
            export_labels(self)
            return updated


class Workspace:
    def __init__(self, initial, decisions=None, state=None):
        self.state = state or Path.home() / '.local/state/too-much-trash-review/datasets.json'
        self.lock = RLock()
        self.history = json.loads(self.state.read_text()) if self.state.exists() else []
        initial = Path(initial).expanduser().resolve()
        previous = next((x for x in self.history if x['path'] == str(initial)), None)
        saved = Path(previous['manifest']) if previous else None
        root = layout.dataset_root(initial)
        mapped = layout.remap(initial, root) if initial != root else initial
        self.current = Dataset(root, mapped, decisions) if mapped.is_file() else Dataset(root, saved, decisions)
        self.remember(self.current)

    def remember(self, dataset):
        entry = dict(path=str(dataset.root), manifest=str(dataset.manifest))
        if layout.organized(dataset.root) and not storage_info(dataset.root)['read_only']:
            config_path = dataset.root/'metadata/dataset.json'
            config = json.loads(config_path.read_text())
            selected = layout.relative(dataset.manifest, dataset.root)
            if config.get('active_prediction_manifest') != selected:
                config['active_prediction_manifest'] = selected
                atomic_json(config_path, config)
        with self.lock:
            self.history = [entry] + [x for x in self.history if x['path'] != entry['path']]
            atomic_json(self.state, self.history[:30])

    def select(self, path):
        path = Path(path).expanduser().resolve()
        previous = next((x for x in self.history if x['path'] == str(path)), None)
        manifest = previous and Path(previous['manifest'])
        dataset = Dataset(path, manifest)
        with self.lock:
            self.current = dataset
            self.remember(dataset)
        return dataset

    def catalog(self):
        paths = [x['path'] for x in self.history]
        local = Path.home()/'Datasets/too-much-trash'
        for parent in (local/'reference/current', local/'working/review'):
            try:
                paths.extend(str(x) for x in parent.iterdir() if is_dataset(x))
            except OSError:
                pass
        volumes = Path('/Volumes')
        if volumes.exists():
            for volume in volumes.iterdir():
                if volume.is_dir() and not volume.is_symlink():
                    try:
                        paths.extend(str(x) for x in volume.iterdir() if is_dataset(x))
                    except OSError:
                        pass
        choices = []
        for p in dict.fromkeys(paths):
            available = Path(p).is_dir()
            if Path(p).is_relative_to(Path('/Volumes/ERICS_DRIVE')) and not available:
                continue
            choices.append(dict(path=p, available=available, storage=storage_info(Path(p)) if available else None))
        return choices

    def browse(self, path):
        root = Path(path or '/Volumes').expanduser().resolve()
        if not root.is_dir():
            raise ValueError('Directory unavailable')
        entries = []
        for child in sorted(root.iterdir(), key=lambda x: x.name.lower()):
            if child.name.startswith('.') or not child.is_dir():
                continue
            try:
                entries.append(dict(name=child.name, path=str(child), dataset=is_dataset(child)))
            except OSError:
                pass
        return dict(path=str(root), parent=str(root.parent), dataset=is_dataset(root), directories=entries)

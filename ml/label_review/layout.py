"""Dataset paths for organized v2 archives and preserved flat collections."""
import json
from functools import lru_cache
from pathlib import Path


def organized(root):
    return (root / 'metadata/dataset.json').is_file()


def relative(path, root):
    return str(Path(path).resolve().relative_to(Path(root).resolve()))


def episode_root(root):
    return root / 'episodes' if (root / 'episodes').is_dir() else root


def videos(root):
    return sorted(p for p in episode_root(root).glob('*/video.mp4')
                  if p.parent.name.isdecimal() or p.parent.name.startswith('clip-'))


@lru_cache(maxsize=32)
def _directories(path, mtime, size):
    return {x['clip']: x.get('directory', x['clip']) for x in json.loads(path.read_text()).get('clips', [])}


def directories(root):
    path = index_path(root)
    if not path.exists():
        return {}
    stat = path.stat()
    return _directories(path, stat.st_mtime_ns, stat.st_size)


def episode_folder(root, item):
    return checked(episode_root(root), directories(root).get(item, item))


def sample_id(root, video):
    return next((key for key, directory in directories(root).items()
                 if directory == video.parent.name), video.parent.name)


def runs_root(root):
    return root / ('audit/runs' if organized(root) else '.review/runs')


def manifests(root):
    return sorted(set(root.glob('label-review*.json')) - set(root.glob('*.decisions.json'))) + sorted(root.glob('audit/runs/*/predictions.json'))


def review_logs(root):
    return set(root.glob('label-review*.decisions.json')) | set(root.glob('audit/runs/*/human-reviews.json')) | {root/'deposit-prediction-validation.json'}


def dataset_root(path):
    path = Path(path).expanduser().resolve()
    for ancestor in (path, *path.parents):
        if organized(ancestor):
            return ancestor
    return path.parent if path.is_file() else path


def checked(root, value):
    path = (root / value).resolve()
    if not path.is_relative_to(root.resolve()):
        raise ValueError('Dataset path must stay inside dataset root')
    return path


def remap(path, root):
    path = Path(path).resolve()
    if path.exists() or not organized(root):
        return path
    config = json.loads((root/'metadata/dataset.json').read_text())
    old = relative(path, root)
    replacement = config.get('legacy_paths', {}).get(old)
    return checked(root, replacement) if replacement else path


def default_manifest(root):
    if organized(root):
        config = json.loads((root/'metadata/dataset.json').read_text())
        return checked(root, config['active_prediction_manifest'])
    return root/'label-review.json'


def decisions_path(manifest):
    return manifest.with_name('human-reviews.json') if manifest.name == 'predictions.json' else manifest.with_suffix('.decisions.json')


def index_path(root):
    return root/'metadata/clip-index.json' if organized(root) else root/'clip-index.json'


def run_artifact(run, item, role):
    """Role-specific filenames; legacy run paths stay unchanged."""
    # run is <root>/audit/runs/<id> for v2.
    if run.parent.name == 'runs' and run.parent.parent.name == 'audit':
        directory, suffix = {'response':('responses','.json'),'prompt':('prompts','.prompt.txt'),
                             'log':('logs','.log'),'history':('context','.history.json'),
                             'sheet':('contact-sheets','.jpg'),'error':('logs','.error.json'),
                             'scratch':('scratch','')}[role]
        path = run/directory/(item+suffix)
    else:
        suffix = {'response':'.json','prompt':'.prompt.txt','log':'.log','history':'.history.json',
                  'sheet':'.jpg','error':'.error.json','scratch':'-scratch'}[role]
        path = run/(item+suffix)
    path.parent.mkdir(parents=True, exist_ok=True)
    return path

"""Read only the public model catalog and non-secret Codex preferences."""
import json
from pathlib import Path


def model_options():
    home = Path.home() / '.codex'
    models = []
    try:
        cache = json.loads((home / 'models_cache.json').read_text())
        for item in cache.get('models', []):
            if item.get('visibility') != 'list' or 'image' not in item.get('input_modalities', []):
                continue
            models.append(dict(id=item['slug'], name=item.get('display_name', item['slug']),
                               efforts=[x['effort'] for x in item.get('supported_reasoning_levels', [])],
                               default_effort=item.get('default_reasoning_level')))
    except (OSError, ValueError, KeyError, TypeError):
        pass
    defaults = {}
    try:
        import tomllib
        config = tomllib.loads((home / 'config.toml').read_text())
        defaults = {k: config.get(k) for k in ('model', 'model_reasoning_effort')}
    except (ImportError, OSError, ValueError):
        pass
    return dict(models=models, default_model=defaults.get('model'),
                default_effort=defaults.get('model_reasoning_effort'))


def validate_options(model, effort):
    if model is None and effort is None:
        return
    chosen = next((x for x in model_options()['models'] if x['id'] == model), None)
    if not chosen or effort not in chosen['efforts']:
        raise ValueError('Choose a listed image-capable model and supported thinking level')

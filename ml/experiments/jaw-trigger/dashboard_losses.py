"""Read recorded learning curves tied to the exact evaluated model; never refit."""

from hashlib import sha256
import json
from math import isfinite
from pathlib import Path
from dashboard_event_curves import event_f1
from ml.evolution.model_parameters import parameters_for

F1_FIELDS = ('train_squeeze_f1', 'train_release_f1', 'validation_squeeze_f1', 'validation_release_f1')


def normalize_history(record):
    """Keep missing values missing and reject misleading/invalid epoch traces."""
    if not isinstance(record, dict):
        raise ValueError('Loss history must describe its metric and points')
    metric = record.get('metric')
    points = record.get('points')
    if not isinstance(metric, str) or not metric.strip() or len(metric) > 2048:
        raise ValueError('A loss metric label is required')
    if not isinstance(points, list) or not 1 <= len(points) <= 5000:
        raise ValueError('Record 1–5000 loss measurements')
    clean, previous = [], 0
    for point in points:
        epoch = point['epoch']
        if type(epoch) is not int or epoch <= previous:
            raise ValueError('Epochs must be positive and strictly increasing')
        previous = epoch
        row = {'epoch': epoch}
        for field in ('train_loss', 'validation_loss'):
            value = point.get(field)
            if value is not None and (type(value) not in (int, float) or not isfinite(value) or value < 0):
                raise ValueError('Losses must be finite nonnegative numbers or null')
            row[field] = value
        for field in F1_FIELDS:
            value = point.get(field)
            if value is not None and (type(value) not in (int, float) or not isfinite(value) or not 0 <= value <= 1):
                raise ValueError('Event F1 must be a finite fraction or null')
            row[field] = value
        if row['train_loss'] is None and row['validation_loss'] is None:
            raise ValueError('Every epoch must contain a measured loss')
        clean.append(row)
    note = record.get('note', '')
    return {'metric': metric.strip(), 'points': clean,
            'note': note[:2500] if isinstance(note, str) else ''}


def _read(job, reference):
    path = (job / reference).resolve(strict=True)
    if not path.is_relative_to(job.resolve()) or path.stat().st_size > 8_000_000:
        raise ValueError('Loss evidence must be a small file inside this job')
    raw = path.read_bytes()
    return json.loads(raw), sha256(raw).hexdigest()


def _event_history(job, history, record):
    """Read only train/validation, hash-bound to the exact fit's declared context."""
    enriched = {**history, 'points': [dict(row) for row in history['points']]}
    try:
        plan, _ = _read(job, str(Path(record['history']['path']).parent / 'plan.json'))
        config, _ = _read(job, 'config.json')
        tolerance = config['settings']['match_seconds']
        if type(tolerance) not in (int, float) or not isfinite(tolerance) or tolerance <= 0:
            raise ValueError('Invalid event tolerance')
        for split, key in (('train', 'training_predictions'), ('validation', 'predictions')):
            manifest, digest = _read(job, f'{split}.json')
            if digest != plan['context'][f'{split}_manifest_sha256']:
                raise ValueError('Event curve split changed since fitting')
            for row in enriched['points']:
                if key not in row:
                    continue  # Historical training predictions were not saved.
                values, digest = _read(job, row[key]['path'])
                if digest != row[key]['sha256']:
                    raise ValueError('Event predictions changed since fitting')
                for kind, score in event_f1(values, manifest['clips'], tolerance).items():
                    row[f'{split}_{kind}_f1'] = score
        enriched['event_note'] = ('Same fixed checkpoint-selection decoder for both splits; '
                                 'squeeze and release match same-kind button cues one-to-one. '
                                 'Missing historical training epochs remain unplotted. Test excluded.')
    except (OSError, ValueError, KeyError, TypeError):
        # Loss evidence can still be valid if separate prediction evidence is missing.
        for row in enriched['points']:
            for field in F1_FIELDS:
                row.pop(field, None)
    return enriched


def load_training_histories(job, result):
    """Prefer explicit hashed histories, with a narrow adapter for saved R50 BCE."""
    job = Path(job)
    candidates = {entry['candidate']['name']: entry['candidate'] for entry in
                  [*result.get('incumbents', []), *result.get('challengers', []), *result.get('ranked', [])]}
    histories = {}
    for name, record in result.get('training_audit', {}).get('candidates', {}).items():
        candidate = candidates.get(name)
        if not candidate or record.get('kind') != 'iterative':
            continue
        try:
            history, history_hash = _read(job, record['history']['path'])
            checkpoint, checkpoint_hash = _read(job, record['checkpoint']['path'])
            if (history_hash != record['history']['sha256'] or checkpoint_hash != record['checkpoint']['sha256']
                    or checkpoint.get('parameters') != parameters_for(result, candidate)):
                continue
            enriched = _event_history(job, history, record)
            histories[name] = {**normalize_history(enriched), 'event_note': enriched.get('event_note', ''), 'candidate': candidate,
                               'source': record['history']['path'], 'sha256': history_hash,
                               'model_sha256': checkpoint_hash,
                               'selected_epoch': record.get('selected_epoch'),
                               'possible_overfitting': record.get('possible_overfitting', False)}
        except (OSError, ValueError, KeyError, TypeError):
            continue
    for name, candidate in candidates.items():
        if name in histories:
            continue
        spec = result.get('candidate_metadata', {}).get(name, {}).get('training_history')
        if not isinstance(spec, dict):
            continue
        try:
            history, digest = _read(job, spec['path'])
            model, model_digest = _read(job, spec['model_path'])
            if digest != spec['sha256'] or model_digest != spec['model_sha256']:
                continue
            if model != parameters_for(result, candidate):
                continue
            histories[name] = {**normalize_history(history), 'candidate': candidate,
                               'source': str(spec['path']), 'sha256': digest, 'model_sha256': model_digest}
        except (OSError, ValueError, KeyError, TypeError):
            continue

    # This historical artifact recorded minibatch weighted BCE only. Its sibling
    # evaluation binds it to the fitted model; directory/parent names do not.
    for path in sorted(job.glob('*/fit-history.json')):
        try:
            evaluation, _ = _read(job, str(path.parent / 'evaluation.json'))
            candidate = evaluation['candidate']
            name = candidate['name']
            if name in histories or candidate != candidates.get(name):
                continue
            model, model_digest = _read(job, evaluation['model_path'])
            if model != parameters_for(result, candidate):
                continue
            saved, digest = _read(job, str(path))
            record = {'metric': 'Weighted binary cross-entropy',
                      'points': [{'epoch': row['epoch'], 'train_loss': row['weighted_bce']}
                                 for row in saved],
                      'note': 'Training minibatch loss includes dropout and input noise. Validation loss was not recorded.'}
            histories[name] = {**normalize_history(record), 'candidate': candidate,
                               'source': str(path.relative_to(job)), 'sha256': digest,
                               'model_sha256': model_digest}
        except (OSError, ValueError, KeyError, TypeError):
            continue
    return histories


def load_loss_diagnostics(output, prior, result):
    """Overlay reproduced histories only when the frozen checkpoint matches exactly."""
    try:
        output, prior = Path(output), Path(prior)
        pointer = json.loads((output / 'training-loss-current.json').read_text())
        source_hash = sha256(prior.read_bytes()).hexdigest()
        if pointer['source_result_sha256'] != source_hash:
            return {}
        summary, digest = _read(output, pointer['summary_path'])
        if (digest != pointer['summary_sha256'] or summary['source_result_sha256'] != source_hash
                or summary.get('status') != 'exact_checkpoint_reproduction'):
            return {}
        root = (output / pointer['summary_path']).resolve().parent
        candidates = {entry['candidate']['name']: entry['candidate'] for entry in
                      [*result.get('incumbents', []), *result.get('challengers', []), *result.get('ranked', [])]}
        loaded = {}
        for name, record in summary['candidates'].items():
            candidate = candidates.get(name)
            if candidate != record['candidate'] or record.get('exact_model_match') is not True:
                continue
            history, history_hash = _read(root, record['history_path'])
            model, model_hash = _read(root, record['model_path'])
            if (history_hash != record['history_sha256'] or model_hash != record['model_sha256']
                    or model != parameters_for(result, candidate)):
                continue
            loaded[name] = {**normalize_history(history), 'candidate': candidate,
                            'source': str(root / record['history_path']), 'sha256': history_hash,
                            'model_sha256': model_hash, 'reproduced': True}
        return loaded
    except (OSError, ValueError, KeyError, TypeError):
        return {}

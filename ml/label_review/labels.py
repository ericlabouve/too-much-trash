"""Derived dataset labels: explicit human outcomes take precedence over AI."""
import json
from collections import Counter
import layout


def human_reviews(dataset):
    logs = layout.review_logs(dataset.root)
    logs.add(dataset.root/'deposit-prediction-validation.json')
    logs.add(dataset.decisions_path)
    candidates = {}
    for path in sorted(logs):
        if not path.exists():
            continue
        for key, review in json.loads(path.read_text()).items():
            candidates.setdefault(key, []).append((review, layout.relative(path, dataset.root)))
    chosen = {}
    for key, values in candidates.items():
        if key in dataset.decisions:
            chosen[key] = (dataset.decisions[key], layout.relative(dataset.decisions_path, dataset.root))
            continue
        resolved = [(r, source) for r, source in values if r.get('corrected_label') is not None or r.get('decision') == 'approve']
        labels = {r.get('corrected_label', r.get('prediction')) for r, source in resolved}
        if len(labels) > 1:
            raise ValueError(f'Conflicting historical human labels for {key}; select an authoritative review log')
        chosen[key] = (resolved or values)[0]
    return chosen


def consolidated_labels(dataset):
    originals = {}
    if dataset.manifest.exists():
        originals = {x['id']: x for x in json.loads(dataset.manifest.read_text())['items']}
    index = layout.index_path(dataset.root)
    ids = {x['clip']: x['episode_id'] for x in json.loads(index.read_text()).get('clips', [])} if index.exists() else {}
    reviews = human_reviews(dataset)
    rows = []
    for key, sample in dataset.samples.items():
        original = originals.get(key, {})
        review, review_source = reviews.get(key, (None, None))
        if review:
            label = review.get('corrected_label')
            if label is None and review.get('decision') == 'approve':
                label = review.get('prediction')
            source = 'human'
        else:
            label, source = sample['prediction'], 'ai' if sample['prediction'] else None
        evidence, _, limitations = sample.get('note','').partition('\nLimitations: ')
        folder = layout.episode_folder(dataset.root, key)
        rows.append(dict(id=key, episode_id=ids.get(key), label=label, label_source=source,
                         files={role: layout.relative(folder/name, dataset.root) for role, name in [('video','video.mp4'),('imu','imu.jsonl'),('poses','poses.jsonl'),('manifest','manifest.json')]
                                if (folder/name).is_file()},
                         ai=dict(prediction=sample['prediction'], confidence=sample.get('confidence'),
                                 evidence=evidence, limitations=limitations, model=original.get('model'),
                                 thinking_level=original.get('thinking_level'), run_id=original.get('run_id')),
                         human_review=review, human_review_source=review_source))
    return dict(schema_version=1, task='bucket_deposit_outcome', dataset=dataset.root.name,
                prediction_manifest=layout.relative(dataset.manifest, dataset.root), human_decisions=layout.relative(dataset.decisions_path, dataset.root),
                label_definitions=dict(confirmed='Deposited into the collection bucket',not_deposited='Not deposited into the collection bucket',uncertain='AI outcome unresolved'),
                summary=dict(items=len(rows), labels=dict(Counter(x['label'] for x in rows if x['label'] is not None)),
                             sources=dict(Counter(x['label_source'] for x in rows if x['label_source'])),
                             unresolved=sum(x['label'] in (None, 'uncertain') for x in rows)), items=rows)


def export_labels(dataset):
    from workspace import atomic_json
    value = consolidated_labels(dataset)
    output = dataset.root / 'labels.json'
    # This file is derived; avoid rewriting it on every polling refresh.
    if not output.exists() or json.loads(output.read_text()) != value:
        atomic_json(output, value)
    return value

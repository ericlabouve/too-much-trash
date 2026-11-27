"""Reproduce the R50 top-two fits while observing epoch losses without RNG changes.

This is a diagnostic replay, not an evolution round or checkpoint promotion.
Only an exact reproduction of the frozen model may supply its historical curve.
"""

import argparse
import ast
from hashlib import sha256
import json
from pathlib import Path
import pickle
import time

import cv2
import numpy as np
import torch
from ml.evolution.model_parameters import parameters_for


def write(path, value):
    temporary = path.with_suffix('.pending')
    temporary.write_text(json.dumps(value, allow_nan=False, indent=2) + '\n')
    temporary.replace(path)


def digest(path):
    return sha256(path.read_bytes()).hexdigest()


def load(path):
    # Inputs are the existing locally generated, trusted preparation cache.
    with Path(path).open('rb') as stream:
        return pickle.load(stream)


def instrument(source, namespace, target):
    """Add an observer after the scheduler step; leave optimizer operations intact."""
    tree = ast.parse(source.read_text())
    count = 0
    for node in ast.walk(tree):
        if isinstance(node, ast.FunctionDef) and node.name == 'fit':
            for loop in ast.walk(node):
                if not isinstance(loop, ast.For):
                    continue
                for index, statement in enumerate(list(loop.body)):
                    if (isinstance(statement, ast.Expr) and isinstance(statement.value, ast.Call)
                            and isinstance(statement.value.func, ast.Attribute)
                            and statement.value.func.attr == 'step'
                            and isinstance(statement.value.func.value, ast.Name)
                            and statement.value.func.value.id in ('schedule', 'scheduler')):
                        loop.body.insert(index + 1, ast.parse('_observe_epoch(locals())').body[0])
                        count += 1
    if count != 1:
        raise ValueError('Expected exactly one epoch scheduler step')
    # Do not execute old CLI/import-time job setup. Keep the historical fit and
    # pure feature/state helpers; dependencies are supplied by this runner.
    if source.name == 'temporal50.py':
        tree.body = [node for node in tree.body if isinstance(node, ast.FunctionDef)
                     and node.name in ('states', 'fit')]
    else:
        tree.body = [node for node in tree.body if isinstance(node, ast.FunctionDef) and node.name == 'fit']
    ast.fix_missing_locations(tree)
    target.write_text(ast.unparse(tree) + '\n')
    exec(compile(tree, str(target), 'exec'), namespace)
    return namespace['fit']


def clip_weights(timestamps, label, strength, start):
    closed = (timestamps >= label['close']) & (timestamps < label['open'])
    active = closed[start:]
    distance = np.minimum(abs(timestamps - label['close']), abs(timestamps - label['open']))
    weights = np.where(closed, 1 / max(1, int(active.sum())),
                       1 / max(1, int((~active).sum())))
    weights *= 1 + strength * (distance < .24)
    weights[:start] = 0
    weights /= weights.sum()
    return closed.astype(np.float32), weights


def validation_tensors(paths, reference_rows, namespace, state, kind):
    features, labels, weights = [], [], []
    for path, expected in zip(paths, reference_rows, strict=True):
        data = load(path)
        if data['row']['clip'] != expected['clip']:
            raise ValueError('Preparation cache order differs from the pinned split')
        timestamps, rows, _ = zip(*namespace['_feature_rows'](data['frames'], data['sensors']['imu']), strict=True)
        rows, timestamps = np.asarray(rows), np.asarray(timestamps)
        target, weight = clip_weights(timestamps, data['row']['jaw_reference'], .75 if kind == 'lagged' else .5, 8)
        if kind == 'lagged':
            values = namespace['_lagged_matrix'](rows)[8:]
            values = np.clip((values - state['mean']) / state['scale'], -8, 8)
            # Match fit(): compute each clip's state weights AFTER warmup removal.
            target, weight = clip_weights(timestamps[8:], data['row']['jaw_reference'], .75, 0)
        else:
            values = namespace['states'](np.clip((rows - state['mean']) / state['scale'], -8, 8))
        features.append(values)
        labels.append(target)
        weights.append(weight)
    weight = np.concatenate(weights)
    return (torch.from_numpy(np.concatenate(features)), torch.from_numpy(np.concatenate(labels)),
            torch.tensor(weight / weight.mean(), dtype=torch.float32))


def objective(model, inputs, targets, weights):
    total = 0.
    for start in range(0, len(inputs), 512):
        stop = start + 512
        logits = model(inputs[start:stop])
        errors = torch.nn.functional.binary_cross_entropy_with_logits(logits, targets[start:stop], reduction='none')
        total += float((errors * weights[start:stop]).sum())
    return total / len(inputs)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('prior', type=Path)
    parser.add_argument('output', type=Path)
    args = parser.parse_args()
    prior, output = args.prior.resolve(strict=True), args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    job = prior.parent
    source = job / 'evaluator-source/ml/experiments/jaw-trigger/temporal47.py'
    multiscale_source = job / 'parent-temporal-champion/temporal50.py'
    result = json.loads(prior.read_text())
    index = json.loads((job / 'prepared-index.json').read_text())
    if set(index) != {'train', 'validation'}:
        raise ValueError('Diagnostic inputs may not include test')
    rows = {split: json.loads((job / f'{split}.json').read_text())['clips'] for split in index}
    if any(len(rows[split]) != len(index[split]) for split in rows):
        raise ValueError('Pinned split/cache mismatch')
    candidates = [entry['candidate'] for entry in sorted(result['ranked'], key=lambda entry: -entry['fitness'])[:2]]
    if [candidate['method'] for candidate in candidates] != ['temporal50_hysteresis', 'temporal50_multiscale']:
        raise ValueError('This diagnostic supports the current R50 top-two architectures only')
    cv2.setNumThreads(1)
    torch.set_num_threads(2)
    provenance = {'source_result': str(prior), 'source_result_sha256': digest(prior),
                  'input_sha256': {name: digest(job / name) for name in ('inputs.json', 'train.json', 'validation.json', 'prepared-index.json')},
                  'source_sha256': {str(path): digest(path) for path in (source, multiscale_source, Path(__file__).resolve())},
                  'counts': {split: len(paths) for split, paths in index.items()},
                  'test_evaluated': False, 'pool_changed': False, 'seed': result['seed'], 'epochs': 100,
                  'runtime': {'torch': torch.__version__, 'numpy': np.__version__, 'threads': 2, 'device': 'cpu'},
                  'purpose': 'Reproduce existing fits with observation only; no tuning, early stopping or promotion.'}
    write(output / 'provenance.json', provenance)
    namespace = {'__name__': 'loss_observation', 'np': np}
    # The unmodified frozen feature pipeline supplies both fits.
    exec(compile(source.read_text(), str(source), 'exec'), namespace)
    native_rows = namespace['_feature_rows']
    summary = {'status': 'running', 'source_result_sha256': provenance['source_result_sha256'], 'candidates': {}}
    write(output / 'summary.json', summary)
    for position, candidate in enumerate(candidates):
        name, method = candidate['name'], candidate['method']
        own = output / method
        own.mkdir()
        kind = 'lagged' if position == 0 else 'multiscale'
        history, validation = [], None
        started = time.monotonic()

        def observe(state):
            nonlocal validation
            if validation is None:
                validation = validation_tensors(index['validation'], rows['validation'],
                                                namespace, state, kind)
            model = state['model']
            training_mode = model.training
            random_state = torch.get_rng_state()
            model.eval()
            try:
                with torch.inference_mode():
                    train = objective(model, state['inputs'], state['targets'], state['weights' if kind == 'lagged' else 'w'])
                    valid = objective(model, *validation)
            finally:
                model.train(training_mode)
                torch.set_rng_state(random_state)
            history.append({'epoch': len(history) + 1, 'train_loss': train, 'validation_loss': valid})
            record = {'metric': 'Weighted binary cross-entropy', 'points': history,
                      'note': 'Reproduced fixed 100-epoch fit. Both losses measured after each epoch in eval mode, without dropout/input noise; equal clip/state weighting and original transition emphasis. No tuning or test evaluation.'}
            write(own / 'loss-history.json', record)
            if len(history) == 1 or len(history) % 10 == 0:
                print(f'{method}: epoch {len(history)}/100 · train {train:.6f} · validation {valid:.6f} · {time.monotonic()-started:.1f}s', flush=True)

        namespace['_observe_epoch'] = observe
        if kind == 'lagged':
            def lazy_rows(frames, samples):
                if isinstance(frames, str):
                    data = load(frames)
                    yield from native_rows(data['frames'], data['sensors']['imu'])
                else:
                    yield from native_rows(frames, samples)
            namespace['_feature_rows'] = lazy_rows
            fit = instrument(source, namespace, own / 'observed-fit.py')
            # Verify each trusted cache's identity as it is read for fitting.
            def checked_paths():
                for path, row in zip(index['train'], rows['train'], strict=True):
                    data = load(path)
                    if data['row']['clip'] != row['clip']:
                        raise ValueError('Training cache identity mismatch')
                    del data
                    yield path
            base = fit(checked_paths(), [None] * len(rows['train']),
                       [row['jaw_reference'] for row in rows['train']], seed=result['seed'], epochs=100)
            original = parameters_for(result, candidate, required=True)
            regenerated = {**original, 'base': base}
        else:
            namespace['_feature_rows'] = native_rows
            # Match the old module's globals while executing only its fit/state functions.
            from types import SimpleNamespace
            namespace.update(torch=torch, ALPHAS=(.5, .12), OWN=own, write=write,
                             load=load, temporal47=SimpleNamespace(_feature_rows=native_rows))
            fit = instrument(multiscale_source, namespace, own / 'observed-fit.py')
            regenerated = fit(index)
            original = parameters_for(result, candidate, required=True)
        write(own / 'model.json', regenerated)
        exact = regenerated == original
        summary['candidates'][name] = {'candidate': candidate, 'exact_model_match': exact,
                                      'history_path': str((own / 'loss-history.json').relative_to(output)),
                                      'history_sha256': digest(own / 'loss-history.json'),
                                      'model_path': str((own / 'model.json').relative_to(output)),
                                      'model_sha256': digest(own / 'model.json'),
                                      'epochs': len(history), 'final': history[-1],
                                      'elapsed_seconds': time.monotonic() - started}
        write(output / 'summary.json', summary)
        print(f'{method}: exact frozen-model reproduction={exact}', flush=True)
        if not exact:
            raise ValueError('Refit differs from frozen checkpoint; do not attach as its history')
        validation = None
    if digest(prior) != provenance['source_result_sha256']:
        raise ValueError('Source pool changed during diagnostics')
    summary['status'] = 'exact_checkpoint_reproduction'
    write(output / 'summary.json', summary)
    write(output.parent / 'training-loss-current.json', {'summary_path': str(output / 'summary.json'),
          'summary_sha256': digest(output / 'summary.json'), 'source_result_sha256': provenance['source_result_sha256']})
    print(f'Saved top-two curves: {output}', flush=True)


if __name__ == '__main__':
    main()

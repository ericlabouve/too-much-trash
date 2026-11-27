"""Parameter-bound portfolio admission from independently measured validation data."""

from dataclasses import replace
from math import isclose, isfinite

from ml.evolution import Policy
from ml.evolution.portfolio import Portfolio
from dashboard_round import candidate_family
from run_joint_round import SPACE

PROTOCOL = 'portfolio-v1'
DEFAULTS = {'protected_slots': 2, 'mutation_attempts': 2, 'family_limit': 2}


def _family_key(value):
    if not isinstance(value, str) or not value.strip():
        raise ValueError('Architecture family must be a nonempty name')
    return ' '.join(value.split()).casefold()


def selection_parameters(settings, available=None):
    """Keep submitted values; bound their effective limits to this pool's size."""
    requested = {key: settings.get(key, value) for key, value in DEFAULTS.items()}
    for key, low, high in [('protected_slots', 0, 9), ('mutation_attempts', 1, 20), ('family_limit', 1, 10)]:
        if type(requested[key]) is not int or not low <= requested[key] <= high:
            raise ValueError(f'{key} must be an integer between {low} and {high}')
    pool_size = settings['pool_size']
    if type(pool_size) is not int or not 1 <= pool_size <= 10:
        raise ValueError('Pool size must be between one and ten')
    target = min(pool_size, available) if available is not None else pool_size
    if target < 1:
        raise ValueError('Portfolio selection requires measured candidates')
    effective = {**requested, 'protected_slots': min(requested['protected_slots'], target - 1),
                 'family_limit': min(requested['family_limit'], target), 'pool_size': target}
    return {'protocol': PROTOCOL, 'requested': requested, 'effective': effective}


def portfolio_for_settings(settings, available=None):
    limits = selection_parameters(settings, available)['effective']
    return Portfolio(objectives=lambda entry: (('jaw specialist', entry['development']['f1']),),
                     coverage=lambda entry: entry['clip_f1'],
                     family_limit=limits['family_limit'], protected_slots=limits['protected_slots'],
                     mutation_attempts=limits['mutation_attempts'])


def select_evaluated(incumbents, challengers, prior, settings, candidate_metadata=None):
    """Use this adapter in jobs; the completion gate repeats it independently.

    Existing protected leads are trimmed only when knobs/scope/pool size require
    it. Changing protection does not automatically change parent scheduling.
    """
    entries = [*incumbents, *challengers]
    names = [entry['candidate']['name'] for entry in entries]
    if len(names) != len(set(names)) or not entries:
        raise ValueError('Portfolio inputs require distinct evaluated candidates')
    parent_names = {entry['candidate']['name'] for entry in incumbents}
    children, ideas = [], []
    for entry in challengers:
        parent = entry['candidate'].get('parent')
        if parent is None:
            ideas.append(entry)
        elif parent in parent_names:
            children.append(entry)
        else:
            raise ValueError('Portfolio children must refer to an evaluated incumbent')
    if len({entry['candidate']['parent'] for entry in children}) != len(children):
        raise ValueError('Portfolio accepts one child per selected parent')
    policy = selection_parameters(settings, len(entries))
    limits = policy['effective']
    metadata = {**prior.get('candidate_metadata', {}), **(candidate_metadata or {})}
    for entry in incumbents:
        name = entry['candidate']['name']
        old_family = candidate_family(entry['candidate'], prior)
        declared = candidate_family(entry['candidate'], {'candidate_metadata': metadata})
        if _family_key(declared) != _family_key(old_family):
            raise ValueError('Incumbent family identity must match its frozen prior')
    family_source = {'candidate_metadata': metadata}
    space = replace(SPACE, family=lambda candidate: _family_key(candidate_family(
        {'name': candidate.name, 'method': candidate.method}, family_source)))
    by_name = {entry['candidate']['name']: entry for entry in incumbents}
    lanes, seen = [], set()
    for lane in prior.get('protected', []):
        if (not isinstance(lane, dict) or not isinstance(lane.get('name'), str)
                or type(lane.get('attempts')) is not int or lane['attempts'] < 0
                or not isinstance(lane.get('root'), str) or not lane['root']):
            raise ValueError('Protected lineage evidence is invalid')
        if lane['name'] in seen:
            raise ValueError('Protected lineage names must be unique')
        seen.add(lane['name'])
        if lane['name'] in by_name and lane['attempts'] < limits['mutation_attempts']:
            lanes.append(dict(lane))
    lanes.sort(key=lambda lane: space.rank_key(by_name[lane['name']]))
    lanes = lanes[:limits['protected_slots']]
    portfolio = portfolio_for_settings(settings, len(entries))
    # Research slots govern proposals, not how many slots selection must reserve.
    ranked, removed, admission = portfolio.select(
        incumbents, children, ideas, space, Policy(pool_size=limits['pool_size'], research_slots=0), lanes)
    return {'ranked': ranked, 'next_pool': [entry['candidate'] for entry in ranked],
            'pruned': [entry['candidate'] for entry in removed], 'pruned_scores': removed,
            **admission, 'selection_policy': policy}


def _same_number(actual, expected):
    return type(actual) in (int, float) and isfinite(actual) and isclose(actual, expected, rel_tol=0, abs_tol=1e-12)


def verify_selection(result, prior, settings, validation, predictions):
    import round_one
    previous = round_one.MATCH_SECONDS
    round_one.MATCH_SECONDS = settings['match_seconds']
    try:
        return _verify_selection(result, prior, settings, validation, predictions)
    finally:
        round_one.MATCH_SECONDS = previous


def _verify_selection(result, prior, settings, validation, predictions):
    """Rebuild coverage and rank diagnostics before replaying admission rules."""
    if settings.get('selection_protocol') != PROTOCOL:
        raise ValueError('Unknown portfolio selection protocol')
    import round_one
    ids = [row['clip'] for row in validation]
    labels = [row['jaw_reference'] for row in validation]
    if not ids or len(ids) != len(set(ids)):
        raise ValueError('Portfolio selection needs a unique validation split')
    groups = ('incumbents', 'challengers', 'ranked')
    derived = {}
    for group in groups:
        for entry in result.get(group, []):
            name = entry['candidate']['name']
            observed = predictions.get(name, {})
            if set(observed) != set(ids):
                raise ValueError('Portfolio coverage requires every validation prediction')
            metrics = [round_one.accuracy([observed[clip]], [label]) for clip, label in zip(ids, labels, strict=True)]
            f1 = [item['f1'] for item in metrics]
            worst = min(round_one.precision_weighted_accuracy(item) for item in metrics)
            zero = sum(item['matched'] == 0 for item in metrics)
            if (not isinstance(entry.get('clip_f1'), list) or len(entry['clip_f1']) != len(f1)
                    or any(not _same_number(a, b) for a, b in zip(entry['clip_f1'], f1, strict=True))
                    or not _same_number(entry.get('worst_clip_accuracy'), worst)
                    or type(entry.get('zero_jaw_clips')) is not int or entry['zero_jaw_clips'] != zero):
                raise ValueError('Portfolio coverage and rank diagnostics must match saved validation predictions')
            derived[name] = {**entry, 'clip_f1': f1, 'worst_clip_accuracy': worst, 'zero_jaw_clips': zero}
    expected = select_evaluated([derived[entry['candidate']['name']] for entry in result['incumbents']],
                                [derived[entry['candidate']['name']] for entry in result['challengers']],
                                prior, settings, result.get('candidate_metadata', {}))
    for key in ('next_pool', 'protected', 'roles', 'selection_policy'):
        if result.get(key) != expected[key]:
            raise ValueError(f'Published {key} must match the configured independent portfolio selection')
    if [entry['candidate']['name'] for entry in result['ranked']] != [entry['candidate']['name'] for entry in expected['ranked']]:
        raise ValueError('Published ranking must match independent portfolio admission')
    return {'protocol': PROTOCOL, 'policy': expected['selection_policy'],
            'coverage_verified': True, 'candidates_evaluated': len(result['incumbents']) + len(result['challengers'])}

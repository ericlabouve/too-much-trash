"""Adapt candidate-scoped weights to the older feature-extraction API."""

from ml.evolution.model_parameters import parameters_for


def _key(candidate):
    method = candidate['method'] if isinstance(candidate, dict) else candidate.method
    if method in ('linear_hog_refit', 'linear_hog_refit_median'):
        return 'linear_hog_refit'
    if method in ('linear_hog', 'linear_hog_median', 'linear_hog_rearm', 'linear_hog_slope'):
        return 'linear_hog'
    return method


def feature_table(result, candidate):
    if 'candidate_parameters' not in result and 'model_binding_protocol' not in result:
        return result.get('feature_parameters', {})
    model = parameters_for(result, candidate)
    # Historical HOG variants share a feature implementation key. This is a
    # dispatch alias only; weights still come from this exact candidate's entry.
    return {_key(candidate): model}


def feature_model(result, candidate):
    if 'candidate_parameters' in result or 'model_binding_protocol' in result:
        return parameters_for(result, candidate)
    return result.get('feature_parameters', {}).get(_key(candidate), {})

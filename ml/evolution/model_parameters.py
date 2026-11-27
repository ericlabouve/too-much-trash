"""Bind learned weights to a candidate, independently of its algorithm family.

Several candidates may dispatch through the same method with different weights.
Historical results used a method-keyed table; read that format only when the new
candidate-scoped table is absent. Never fall back from a broken scoped binding.
"""

PROTOCOL = 'candidate-scoped-v1'


def _identity(candidate):
    if not isinstance(candidate, dict):
        candidate = vars(candidate)
    name, method = candidate.get('name'), candidate.get('method')
    if not isinstance(name, str) or not name.strip() or not isinstance(method, str) or not method.strip():
        raise ValueError('Model binding requires a named candidate and method')
    return name, method


def parameters_for(result, candidate, *, required=False):
    name, method = _identity(candidate)
    if 'candidate_parameters' in result or 'model_binding_protocol' in result:
        if result.get('model_binding_protocol') != PROTOCOL:
            raise ValueError('Unknown candidate model binding protocol')
        models = result.get('candidate_parameters')
        if not isinstance(models, dict) or name not in models:
            raise ValueError(f'Missing candidate-scoped model parameters: {name}')
        return models[name]
    models = result.get('feature_parameters', {})
    if required and method not in models:
        raise ValueError(f'Missing legacy model parameters: {name}')
    return models.get(method, {})


def bind_parameters(bindings):
    """Build a result fragment from (candidate, bare parameters) pairs, fail closed."""
    models = {}
    for candidate, parameters in bindings:
        name, _ = _identity(candidate)
        if name in models:
            raise ValueError(f'Duplicate candidate model binding: {name}')
        models[name] = parameters
    return {'model_binding_protocol': PROTOCOL, 'candidate_parameters': models}

"""Optional NumPy reference measurements for comparable learning curves.

These measure inference outputs, not gradients, regularization or task fitness.
Importing the shared runner still needs only the standard library.
"""


def binary_data_loss(labels, probabilities, sample_weight=None, *, epsilon=1e-7):
    """Return sum(weight * BCE) / sum(weight), with an explicit denominator.

    Use the same epsilon and weighting policy for both fixed splits. Derive
    fitted preprocessing/class weights from training only. This function does
    not estimate weights or decide which metric an experiment should optimize.
    """
    import numpy as np

    y = np.asarray(labels, dtype=np.float64)
    p = np.asarray(probabilities, dtype=np.float64)
    if (y.ndim != 1 or not y.size or p.shape != y.shape
            or not np.isfinite(y).all() or not np.isfinite(p).all()
            or not np.isin(y, (0., 1.)).all() or ((p < 0) | (p > 1)).any()):
        raise ValueError('Use equal nonempty vectors of binary labels and finite probabilities in [0, 1]')
    if type(epsilon) not in (int, float) or not np.isfinite(epsilon) or not 0 < epsilon < .5:
        raise ValueError('Use a finite clipping epsilon in (0, 0.5)')
    w = np.ones_like(y) if sample_weight is None else np.asarray(sample_weight, dtype=np.float64)
    if w.shape != y.shape or not np.isfinite(w).all() or (w < 0).any():
        raise ValueError('Use finite nonnegative weights with the same shape')
    denominator = float(w.sum())
    if not np.isfinite(denominator) or denominator <= 0:
        raise ValueError('Loss measurements need positive finite weight mass')
    p = np.clip(p, epsilon, 1 - epsilon)
    per_example = -(y * np.log(p) + (1 - y) * np.log1p(-p))
    numerator = float(np.dot(w, per_example))
    if not np.isfinite(numerator):
        raise ValueError('Weighted loss sum must be finite')
    return {'value': numerator / denominator, 'weighted_loss_sum': numerator,
            'weight_sum': denominator, 'examples': int(y.size),
            'epsilon': epsilon, 'metric': 'Weighted mean BCE data loss'}

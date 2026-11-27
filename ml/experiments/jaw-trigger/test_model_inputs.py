import unittest

from model_inputs import feature_model, feature_table
from ml.evolution.model_parameters import bind_parameters


class FeatureBindingTests(unittest.TestCase):
    def test_legacy_hog_dispatch_aliases_keep_original_weights(self):
        result = {'feature_parameters': {'linear_hog': [1], 'linear_hog_refit': [2]}}
        for method in ('linear_hog', 'linear_hog_median', 'linear_hog_rearm', 'linear_hog_slope'):
            candidate = {'name': method, 'method': method}
            self.assertEqual(feature_model(result, candidate), [1])
            self.assertEqual(feature_table(result, candidate), result['feature_parameters'])
        self.assertEqual(feature_model(result, {'name': 'refit', 'method': 'linear_hog_refit_median'}), [2])

    def test_scoped_hog_aliases_do_not_share_weights(self):
        parent = {'name': 'parent', 'method': 'linear_hog_median'}
        child = {'name': 'child', 'method': 'linear_hog_median'}
        result = bind_parameters([(parent, [1]), (child, [2])])
        self.assertEqual(feature_table(result, parent), {'linear_hog': [1]})
        self.assertEqual(feature_table(result, child), {'linear_hog': [2]})
        self.assertEqual(feature_model(result, child), [2])

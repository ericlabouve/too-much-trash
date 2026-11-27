import unittest

from ml.evolution.model_parameters import bind_parameters, parameters_for, PROTOCOL


class ModelParameterTests(unittest.TestCase):
    def test_same_method_has_distinct_candidate_weights(self):
        parent = {'name': 'parent', 'method': 'network'}
        child = {'name': 'child', 'method': 'network'}
        result = bind_parameters([(parent, {'weight': 1}), (child, {'weight': 2})])
        self.assertEqual(parameters_for(result, parent), {'weight': 1})
        self.assertEqual(parameters_for(result, child), {'weight': 2})

    def test_scoped_binding_cannot_fall_back_to_legacy_weights(self):
        candidate = {'name': 'child', 'method': 'network'}
        for result in ({'model_binding_protocol': PROTOCOL, 'candidate_parameters': {}},
                       {'candidate_parameters': {'child': 1}},
                       {'model_binding_protocol': 'unknown', 'candidate_parameters': {'child': 1}}):
            result['feature_parameters'] = {'network': {'weight': 2}}
            with self.subTest(result=result), self.assertRaises(ValueError):
                parameters_for(result, candidate)

    def test_duplicate_names_fail_before_overwriting(self):
        with self.assertRaisesRegex(ValueError, 'Duplicate'):
            bind_parameters([({'name': 'same', 'method': 'one'}, 1),
                             ({'name': 'same', 'method': 'two'}, 2)])

    def test_historical_method_table_remains_readable(self):
        c = {'name': 'old', 'method': 'network'}
        self.assertEqual(parameters_for({'feature_parameters': {'network': 3}}, c), 3)
        self.assertEqual(parameters_for({}, c), {})
        with self.assertRaises(ValueError):
            parameters_for({}, c, required=True)

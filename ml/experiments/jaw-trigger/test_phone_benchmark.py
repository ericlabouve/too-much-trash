import copy
from hashlib import sha256
import json
from pathlib import Path
import tempfile
import unittest

from phone_benchmark import validate, load_phone_timing


class PhoneBenchmarkTests(unittest.TestCase):
    def fixture(self):
        candidate = {'name':'a','method':'imu'}
        pool = {'suite':'jaw-pool-native-v1','round':50,'result_sha256':'result','pool_sha256':'pool',
                'repeats':3,'candidates':[{'candidate':candidate,'model_sha256':'model'}]}
        clips = [{'file':'clip-00.bin','timestamps':[0.,1.,2.]}]
        reference = {'clip-00':{'candidates':{'a':{'scores':[0.,1.,0.], 'events':[['close',1.],['open',2.]]}}}}
        records = [{'candidate':candidate,'model_sha256':'model','pass':i,'thermal_start':0,'thermal_end':0,
                    'started_uptime_seconds':i*10.,'finished_uptime_seconds':i*10.+1,
                    'clips':[{'file':'clip-00.bin','sample_count':3,'scores':[0.,1.,0.],
                              'events':[['close',1.],['open',2.]],'ms':[.1,.2,.3]}]} for i in range(3)]
        result = {'suite':pool['suite'],'round':50,'result_sha256':'result','pool_sha256':'pool',
                  'interrupted':False,'low_power':False,'thermal_start':0,'thermal_end':0,
                  'model':'iPhone16,1','os':'27','scope':'prepared native CPU','elapsed_ms':100.,'results':records}
        return result,pool,clips,reference

    def test_accepts_complete_serial_parity_checked_measurements(self):
        summary = validate(*self.fixture())
        self.assertAlmostEqual(summary['candidates']['a']['phone_p95_ms'],.3)
        self.assertEqual(summary['candidates']['a']['samples'],9)

    def test_laptop_results_have_a_distinct_platform_and_metric(self):
        summary=validate(*self.fixture(),platform='laptop-native')
        self.assertEqual(summary['platform'],'laptop-native')
        self.assertAlmostEqual(summary['candidates']['a']['laptop_native_p95_ms'],.3)
        self.assertNotIn('phone_p95_ms',summary['candidates']['a'])

    def test_rejects_overlap_interruption_thermal_and_incomplete_outputs(self):
        source,pool,clips,reference = self.fixture()
        for mutation in ('overlap','interrupted','thermal','missing','frame'):
            result = copy.deepcopy(source)
            if mutation == 'overlap': result['results'][1]['started_uptime_seconds'] = .5
            elif mutation == 'interrupted': result['interrupted'] = True
            elif mutation == 'thermal': result['results'][1]['thermal_start'] = 1
            elif mutation == 'missing': result['results'].pop()
            else: result['results'][0]['clips'][0]['scores'].pop()
            with self.subTest(mutation=mutation),self.assertRaises(ValueError):
                validate(result,pool,clips,reference)

    def test_rejects_score_event_and_identity_drift(self):
        source,pool,clips,reference = self.fixture()
        for mutation in ('score','event','identity'):
            result = copy.deepcopy(source)
            if mutation == 'score': result['results'][0]['clips'][0]['scores'][1] = .8
            elif mutation == 'event': result['results'][0]['clips'][0]['events'][0][1] = 1.2
            else: result['pool_sha256'] = 'different'
            with self.subTest(mutation=mutation),self.assertRaises(ValueError):
                validate(result,pool,clips,reference)

    def test_keeps_timer_quantization_but_rejects_unmeasurable_p95(self):
        result,pool,clips,reference = self.fixture()
        result['results'][0]['clips'][0]['ms'][0] = 0.
        self.assertEqual(validate(result,pool,clips,reference)['candidates']['a']['zero_duration_samples'],1)
        result['results'][0]['clips'][0]['ms'] = [0.,0.,0.]
        with self.assertRaises(ValueError):validate(result,pool,clips,reference)

    def test_hides_timings_when_result_or_summary_changes(self):
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory);prior=root/'results.json';prior.write_text('{}')
            summary=root/'summary.json';summary.write_text(json.dumps({'status':'validated','source_result_sha256':sha256(prior.read_bytes()).hexdigest()}))
            (root/'phone-timing-current.json').write_text(json.dumps({'summary_path':str(summary),'summary_sha256':sha256(summary.read_bytes()).hexdigest()}))
            self.assertIsNotNone(load_phone_timing(root,prior))
            prior.write_text('{"refitted":true}')
            self.assertIsNone(load_phone_timing(root,prior))
            prior.write_text('{}');summary.write_text('{}')
            self.assertIsNone(load_phone_timing(root,prior))


if __name__ == '__main__':
    unittest.main()

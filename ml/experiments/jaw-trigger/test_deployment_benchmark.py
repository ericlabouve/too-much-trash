"""Contract fixtures: these test metric provenance, not model accuracy/speed."""
from copy import deepcopy
from hashlib import sha256
import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from deployment_benchmark import verify_deployment_benchmarks


class DeploymentBenchmarkTests(unittest.TestCase):
    def fixture(self,job):
        def save(name,value):
            p=job/name;p.write_text(json.dumps(value));return p
        def hashed(p,**kw):return {'path':str(p),'sha256':sha256(p.read_bytes()).hexdigest(),**kw}
        candidate={'name':'control','method':'control'}
        runtime={'mobile_target':'iOS','format':'coreml','engine':'Core ML','device':'fixture-host','compute_units':'CPU','precision':'float32'}
        runner=save('runner.json',{'fixture':'not executable; schema test only'})
        artifacts=[hashed(runner,roles=['runtime','model','preprocessor','decoder'])]
        trace={'candidate':candidate,'runtime':runtime,'artifact_hashes':{'runner.json':artifacts[0]['sha256']},
               'preparation_complete':True,'warmup_complete':True,'thermal_nominal':True,'same_preprocessing_and_decoder':True,
               'test_evaluated':False,'started_uptime_seconds':1.,'finished_uptime_seconds':2.,
               'splits':{split:[{'clip':split,'sample_times_seconds':[0.,1.],'scores':[0.,1.],
                                'timings_ms':[.1,.2],'events':[['close',1.]]}] for split in ('train','validation')}}
        output=save('trace.json',trace)
        report={'candidate':candidate,'protocol':'deployment-v1','runtime':runtime,'artifacts':artifacts,
                'runner':hashed(runner),'command':['fixture',str(runner)],'outputs':hashed(output)}
        report_path=save('report.json',report)
        evaluation={'deployment_benchmarks':{'control':hashed(report_path)},
                    'predictions':{'control':{'validation':[['close',1.]]}},
                    'training_predictions':{'control':{'train':[['close',1.]]}},'timings_ms':{'control':[.1,.2]}}
        return candidate,evaluation,report,trace

    def test_same_artifact_contract_accepts_coreml_without_cpp_requirement(self):
        with TemporaryDirectory() as directory:
            job=Path(directory).resolve();candidate,evaluation,_,_=self.fixture(job)
            result=verify_deployment_benchmarks(job,evaluation,{'control':candidate},['train'],['validation'])
            self.assertEqual(result['protocol'],'deployment-v1')

    def test_rejects_prototype_predictions_or_timings_mixed_with_native_outputs(self):
        with TemporaryDirectory() as directory:
            job=Path(directory).resolve();candidate,evaluation,_,_=self.fixture(job)
            for case in ('prediction','timing','train_prediction','missing'):
                altered=deepcopy(evaluation)
                if case=='prediction':altered['predictions']['control']['validation']=[]
                elif case=='timing':altered['timings_ms']['control']=[.01,.02]
                elif case=='train_prediction':altered['training_predictions']['control']['train']=[]
                else:altered['deployment_benchmarks']={}
                with self.subTest(case=case),self.assertRaises(ValueError):
                    verify_deployment_benchmarks(job,altered,{'control':candidate},['train'],['validation'])

    def test_rejects_changed_frozen_artifact_and_unreviewed_bundle(self):
        with TemporaryDirectory() as directory:
            job=Path(directory).resolve();candidate,evaluation,_,_=self.fixture(job)
            with self.assertRaisesRegex(ValueError,'exact deployed artifact'):
                verify_deployment_benchmarks(job,evaluation,{'control':candidate},['train'],['validation'],{'control':{'files':[]}})
            (job/'runner.json').write_text('changed')
            with self.assertRaises(ValueError):verify_deployment_benchmarks(job,evaluation,{'control':candidate},['train'],['validation'])


if __name__=='__main__':unittest.main()

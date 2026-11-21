import json
import sys
import tempfile
import threading
import unittest
import urllib.request
import urllib.error
from pathlib import Path
from unittest.mock import patch

sys.path.insert(0,str(Path(__file__).parent))
from serve import ReviewServer
from workspace import atomic_json


class WorkspaceTests(unittest.TestCase):
    def setUp(self):
        self.temp=tempfile.TemporaryDirectory()
        self.root=Path(self.temp.name)
        self.a=self.make('park',predicted=True)
        self.b=self.make('beach',predicted=False)
        self.server=ReviewServer(0,self.a,state=self.root/'history.json')
        self.thread=threading.Thread(target=self.server.serve_forever,daemon=True);self.thread.start()
        self.url=f'http://127.0.0.1:{self.server.server_port}'
    def tearDown(self):
        self.server.shutdown();self.server.server_close();self.temp.cleanup()
    def make(self,name,predicted):
        root=self.root/name;folder=root/'clip-001';folder.mkdir(parents=True);(folder/'video.mp4').write_bytes(b'fixture-video')
        if predicted:
            atomic_json(root/'label-review.json',dict(items=[dict(id='clip-001',prediction='confirmed',media='clip-001/video.mp4',confidence='low')]))
            atomic_json(root/'deposit-prediction-validation.json',{'clip-001':dict(prediction='confirmed',decision='approve')})
        return root
    def request(self,path,body=None,origin=True):
        req=urllib.request.Request(self.url+path,data=json.dumps(body).encode() if body is not None else None,
                                  headers={'Origin':self.url} if origin else {})
        return urllib.request.urlopen(req)
    def data(self):return json.load(self.request('/data'))
    def test_switch_preserves_legacy_decisions_and_pending_is_not_a_prediction(self):
        old=self.data();self.assertEqual(old['decisions']['clip-001']['decision'],'approve');self.assertTrue(old['clips'][0]['human_evaluated'])
        self.request('/datasets/select',dict(path=str(self.b)))
        new=self.data();self.assertIsNone(new['clips'][0]['prediction']);self.assertEqual(new['decisions'],{});self.assertFalse(new['clips'][0]['human_evaluated'])
        with self.assertRaises(urllib.error.HTTPError) as stale:
            self.request('/prediction-review',dict(dataset=old['dataset'],clip='clip-001',prediction='confirmed',decision='deny'))
        self.assertEqual(stale.exception.code,409)
        with self.assertRaises(urllib.error.HTTPError):
            self.request('/prediction-review',dict(dataset=new['dataset'],clip='clip-001',prediction=None,decision='approve'))
        self.request('/datasets/select',dict(path=str(self.a)))
        self.assertEqual(self.data()['decisions'],old['decisions'])
        history=json.loads((self.root/'history.json').read_text());self.assertEqual(len(history),2)
    def test_origin_guard_and_media_range_and_confidence(self):
        with self.assertRaises(urllib.error.HTTPError) as blocked:self.request('/datasets/select',dict(path=str(self.b)),False)
        self.assertEqual(blocked.exception.code,403)
        data=self.data();self.assertEqual(data['clips'][0]['confidence'],'low')
        req=urllib.request.Request(self.url+'/media/clip-001?dataset='+data['dataset'],headers={'Range':'bytes=0-3'})
        with urllib.request.urlopen(req) as r:self.assertEqual(r.status,206);self.assertEqual(r.read(),b'fixt')
    def test_save_isolated_and_reloads_existing_log(self):
        data=self.data();self.request('/prediction-review',dict(dataset=data['dataset'],clip='clip-001',prediction='confirmed',decision='deny'))
        self.assertEqual(self.data()['decisions']['clip-001']['decision'],'deny')
        self.assertEqual(json.loads((self.a/'deposit-prediction-validation.json').read_text())['clip-001']['decision'],'deny')
        self.assertFalse((self.b/'label-review.decisions.json').exists())
    def test_invalid_worker_count_does_not_start_a_run(self):
        with self.assertRaises(urllib.error.HTTPError):self.request('/jobs/start',dict(dataset=self.data()['dataset'],workers=0))
        self.assertIsNone(self.server.jobs.status())

    def test_prediction_settings_include_eligibility_and_pass_choices(self):
        catalog=dict(models=[dict(id='fixture',name='Fixture',efforts=['high'],default_effort='high')],default_model='fixture',default_effort='high')
        with patch('serve.model_options',return_value=catalog):
            options=json.load(self.request('/prediction-options'))
        self.assertEqual(options['selection']['eligible'],0)
        self.assertEqual(options['selection']['human_reviewed'],1)
        self.assertEqual(options['models'],catalog['models'])
        self.request('/datasets/select',dict(path=str(self.b)))
        data=self.data()
        with patch.object(self.server.jobs,'start',return_value={'state':'running'}) as start:
            self.request('/jobs/start',dict(dataset=data['dataset'],workers=3,model='fixture',effort='high'))
        self.assertEqual(start.call_args.args[1:],(3,'fixture','high',None))

    def test_explicit_correction_is_saved_separately_from_original_prediction(self):
        self.request('/datasets/select',dict(path=str(self.b)))
        manifest=self.b/'label-review.json'
        atomic_json(manifest,dict(items=[dict(id='clip-001',prediction='uncertain',media='clip-001/video.mp4',confidence='medium')]))
        original=manifest.read_bytes();data=self.data()
        self.request('/prediction-review',dict(dataset=data['dataset'],clip='clip-001',prediction='uncertain',decision='deny',corrected_label='confirmed'))
        saved=self.data()
        self.assertEqual(saved['clips'][0]['prediction'],'uncertain')
        self.assertEqual(saved['decisions']['clip-001'],dict(prediction='uncertain',decision='deny',corrected_label='confirmed'))
        self.assertTrue(saved['clips'][0]['human_evaluated'])
        self.assertEqual(manifest.read_bytes(),original)
        self.request('/datasets/select',dict(path=str(self.a)))
        self.request('/datasets/select',dict(path=str(self.b)))
        self.assertEqual(self.data()['decisions']['clip-001']['corrected_label'],'confirmed')
        self.assertEqual(self.server.jobs.selection(self.server.workspace.current)[1]['eligible'],0)

    def test_invalid_or_inconsistent_correction_cannot_replace_existing_review(self):
        data=self.data();original=self.a/'deposit-prediction-validation.json';before=original.read_bytes()
        for label,decision in [('invented','deny'),('uncertain','approve'),('confirmed','deny')]:
            with self.assertRaises(urllib.error.HTTPError) as rejected:
                self.request('/prediction-review',dict(dataset=data['dataset'],clip='clip-001',prediction='confirmed',decision=decision,corrected_label=label))
            self.assertEqual(rejected.exception.code,400)
            self.assertEqual(original.read_bytes(),before)

    def test_review_playback_uses_squeeze_press_not_release_and_preserves_manifest(self):
        capture=self.a/'clip-001/manifest.json'
        atomic_json(capture,dict(timing=dict(start=100,press=103,release=105,end=108)))
        original=(self.a/'label-review.json').read_bytes()
        data=self.data();self.assertAlmostEqual(data['clips'][0]['start'],2)
        self.assertIn('Squeeze at 3.00 s',data['clips'][0]['timing'])
        self.assertEqual((self.a/'label-review.json').read_bytes(),original)
        atomic_json(capture,dict(timing=dict(start=100,press=100.5,release=102,end=105)))
        self.assertEqual(self.data()['clips'][0]['start'],0)
        atomic_json(capture,dict(timing=dict(start=100,press=99,release=102,end=105)))
        self.assertEqual(self.data()['clips'][0]['start'],0)
        self.request('/datasets/select',dict(path=str(self.b)))
        atomic_json(self.b/'clip-001/manifest.json',dict(timing=dict(start=200,press=203,release=204,end=207)))
        self.assertEqual(self.data()['clips'][0]['start'],2)

    def test_reviewers_cannot_submit_uncertain_as_a_new_human_label(self):
        self.request('/datasets/select',dict(path=str(self.b)))
        atomic_json(self.b/'label-review.json',dict(items=[dict(id='clip-001',prediction='uncertain',media='clip-001/video.mp4')]))
        data=self.data()
        for extra in ({},{'corrected_label':'uncertain'}):
            with self.assertRaises(urllib.error.HTTPError):
                self.request('/prediction-review',dict(dataset=data['dataset'],clip='clip-001',prediction='uncertain',decision='approve',**extra))
        self.assertEqual(self.data()['decisions'],{})

if __name__=='__main__':unittest.main()

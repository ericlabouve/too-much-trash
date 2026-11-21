import json
import sys
import tempfile
import time
import unittest
from pathlib import Path
from unittest.mock import patch
sys.path.insert(0,str(Path(__file__).parent))
from workspace import Workspace, atomic_json
from predictions import Jobs


class PredictionTests(unittest.TestCase):
    def test_run_keeps_originals_decisions_and_structured_results_separate(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp)/'dataset';clip=root/'clip-001';clip.mkdir(parents=True)
            (clip/'video.mp4').write_bytes(b'video-original')
            atomic_json(clip/'manifest.json',dict(timing=dict(start=0,release=4)))
            atomic_json(root/'label-review.json',dict(items=[dict(id='clip-001',prediction='confirmed',media='clip-001/video.mp4')]))
            atomic_json(root/'label-review.decisions.json',{'clip-001':dict(prediction='confirmed',decision='approve')})
            pending=root/'clip-002';pending.mkdir();(pending/'video.mp4').write_bytes(b'pending-original')
            original=(root/'label-review.json').read_bytes();decisions=(root/'label-review.decisions.json').read_bytes()
            workspace=Workspace(root,state=Path(tmp)/'history.json');jobs=Jobs(workspace)
            commands=[]
            class Process:
                def __init__(self,cmd,**kwargs):
                    commands.append(cmd)
                    output=Path(cmd[cmd.index('-o')+1]);atomic_json(output,dict(prediction='uncertain',confidence='low',evidence='Fixture uncertainty',limitations='Synthetic fixture'))
                def wait(self,timeout=None):return 0
                def terminate(self):pass
            with patch('predictions.shutil.which',return_value='/fixture/tool'),patch('predictions.subprocess.run'),patch('predictions.subprocess.Popen',Process):
                result=jobs.start(workspace.current,2)
                deadline=time.monotonic()+5
                while jobs.status()['state']=='running' and time.monotonic()<deadline:time.sleep(.01)
            self.assertEqual(jobs.status()['state'],'completed');self.assertEqual(jobs.status()['completed'],1)
            self.assertEqual((root/'label-review.json').read_bytes(),original)
            self.assertEqual((root/'label-review.decisions.json').read_bytes(),decisions)
            self.assertEqual((clip/'video.mp4').read_bytes(),b'video-original')
            self.assertNotEqual(workspace.current.manifest,root/'label-review.json')
            self.assertEqual(workspace.current.samples['clip-002']['confidence'],'low')
            self.assertEqual(workspace.current.samples['clip-001']['prediction'],'confirmed')
            self.assertEqual(workspace.current.decisions,json.loads(decisions))
            self.assertTrue((Path(result['run_path'])/'clip-002.json').exists())
            command=commands[0]
            self.assertEqual(command[command.index('--sandbox')+1],'workspace-write')
            scratch=Path(command[command.index('-C')+1])
            self.assertTrue(scratch.is_relative_to(Path(result['run_path'])))
            self.assertFalse(scratch.is_relative_to(clip))
            self.assertIn(str((pending/'video.mp4').resolve()),command[-1])
            self.assertIn('"imu.jsonl": null',command[-1])
            self.assertTrue((Path(result['run_path'])/'clip-002.prompt.txt').exists())
    def test_invalid_agent_response_is_failed_not_negative(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);clip=root/'clip-001';clip.mkdir();(clip/'video.mp4').write_bytes(b'fixture')
            w=Workspace(root,state=root/'history.json');jobs=Jobs(w)
            class Process:
                def __init__(self,cmd,**kwargs):atomic_json(Path(cmd[cmd.index('-o')+1]),dict(prediction='fabricated',confidence='high'))
                def wait(self,timeout=None):return 0
                def terminate(self):pass
            with patch('predictions.shutil.which',return_value='/fixture/tool'),patch('predictions.subprocess.run'),patch('predictions.subprocess.Popen',Process):
                jobs.start(w.current,1);deadline=time.monotonic()+5
                while jobs.status()['state']=='running' and time.monotonic()<deadline:time.sleep(.01)
            self.assertEqual(jobs.status()['failed'],1);self.assertEqual(jobs.status()['completed'],0)
            self.assertIsNone(w.current.samples['clip-001']['prediction'])

    def test_eligibility_excludes_human_history_and_high_confidence(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);items=[]
            for number,confidence in enumerate(['high','medium','low',None,'low','medium',None],1):
                key=f'clip-{number:03d}';folder=root/key;folder.mkdir();(folder/'video.mp4').write_bytes(b'fixture')
                items.append(dict(id=key,media=f'{key}/video.mp4',prediction='confirmed' if number!=7 else None,confidence=confidence))
            atomic_json(root/'label-review.json',dict(items=items))
            atomic_json(root/'deposit-prediction-validation.json',{'clip-005':dict(decision='approve',prediction='confirmed')})
            atomic_json(root/'label-review.agent-old.decisions.json',{'clip-006':dict(decision='deny',prediction='not_deposited')})
            workspace=Workspace(root,state=root/'history.json');jobs=Jobs(workspace)
            clips,counts=jobs.selection(workspace.current)
            self.assertEqual([v.parent.name for v in clips],['clip-002','clip-003','clip-004','clip-007'])
            self.assertEqual(counts,dict(eligible=4,total=7,human_reviewed=2,skipped=3))

    def test_each_sample_gets_fresh_process_and_selected_model(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp)
            for i in range(4):
                folder=root/f'clip-{i:03d}';folder.mkdir();(folder/'video.mp4').write_bytes(b'fixture')
            w=Workspace(root,state=root/'history.json');jobs=Jobs(w);commands=[]
            class Process:
                def __init__(self,cmd,**kwargs):
                    commands.append(cmd)
                    atomic_json(Path(cmd[cmd.index('-o')+1]),dict(prediction='uncertain',confidence='low',evidence='Fixture',limitations='Fixture'))
                def wait(self,timeout=None):return 0
                def terminate(self):pass
            catalog=dict(models=[dict(id='fixture-vision',efforts=['high'])])
            with patch('options.model_options',return_value=catalog),patch('predictions.shutil.which',return_value='/fixture/tool'),patch('predictions.subprocess.run'),patch('predictions.subprocess.Popen',Process):
                snapshot=jobs.start(w.current,10,'fixture-vision','high')
                deadline=time.monotonic()+5
                while jobs.status()['state']=='running' and time.monotonic()<deadline:time.sleep(.01)
            self.assertEqual(jobs.status()['completed'],4)
            self.assertEqual(len(commands),4)
            self.assertEqual(len({c[c.index('-C')+1] for c in commands}),4)
            for cmd in commands:
                self.assertIn('--ephemeral',cmd);self.assertNotIn('resume',cmd)
                self.assertEqual(cmd[cmd.index('--model')+1],'fixture-vision')
                self.assertEqual(cmd[cmd.index('-c')+1],'model_reasoning_effort="high"')
            stored=json.loads((Path(snapshot['run_path'])/'job.json').read_text())
            self.assertEqual(stored['model'],'fixture-vision');self.assertEqual(stored['effort'],'high')

    def test_human_review_during_run_is_never_overwritten(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);folder=root/'clip-001';folder.mkdir();(folder/'video.mp4').write_bytes(b'fixture')
            atomic_json(root/'label-review.json',dict(items=[dict(id='clip-001',media='clip-001/video.mp4',prediction='confirmed',confidence='low')]))
            workspace=Workspace(root,state=root/'history.json');jobs=Jobs(workspace)
            class Process:
                def __init__(self,cmd,**kwargs):
                    atomic_json(Path(cmd[cmd.index('-o')+1]),dict(prediction='not_deposited',confidence='high',evidence='Fixture',limitations='Fixture'))
                def wait(self,timeout=None):
                    workspace.current.record('clip-001','confirmed','approve')
                    return 0
                def terminate(self):pass
            with patch('predictions.shutil.which',return_value='/fixture/tool'),patch('predictions.subprocess.run'),patch('predictions.subprocess.Popen',Process):
                jobs.start(workspace.current,1);deadline=time.monotonic()+5
                while jobs.status()['state']=='running' and time.monotonic()<deadline:time.sleep(.01)
            self.assertEqual(jobs.status()['completed'],1)
            workspace.current.refresh()
            self.assertEqual(workspace.current.samples['clip-001']['prediction'],'confirmed')
            self.assertEqual(workspace.current.decisions['clip-001']['decision'],'approve')

    def test_repeat_reviews_receive_prior_evidence_once_without_reusing_agents(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);folder=root/'clip-001';folder.mkdir();(folder/'video.mp4').write_bytes(b'fixture')
            workspace=Workspace(root,state=root/'history.json');jobs=Jobs(workspace);commands=[];runs=[]
            class Process:
                def __init__(self,cmd,**kwargs):
                    commands.append(cmd)
                    atomic_json(Path(cmd[cmd.index('-o')+1]),dict(prediction='uncertain',confidence='medium',
                        evidence=f'Observation {len(commands)} at 1.0 seconds',limitations=f'Limit {len(commands)}'))
                def wait(self,timeout=None):return 0
                def terminate(self):pass
            with patch('predictions.shutil.which',return_value='/fixture/tool'),patch('predictions.subprocess.run'),patch('predictions.subprocess.Popen',Process):
                for number in range(3):
                    run=jobs.start(workspace.current,1);runs.append(run)
                    deadline=time.monotonic()+5
                    while jobs.status()['state']=='running' and time.monotonic()<deadline:time.sleep(.01)
                    self.assertEqual(jobs.status()['state'],'completed')
                    prior=json.loads((Path(run['run_path'])/'clip-001.history.json').read_text())
                    self.assertEqual(len(prior),number)
                    self.assertEqual([x['evidence'] for x in prior],[f'Observation {i+1} at 1.0 seconds' for i in range(number)])
                    for i in range(number):
                        self.assertIn(f'Observation {i+1} at 1.0 seconds',commands[-1][-1])
                        self.assertIn(f'Limit {i+1}',commands[-1][-1])
                    self.assertIn('--ephemeral',commands[-1])
            self.assertEqual(len({c[c.index('-C')+1] for c in commands}),3)
            first=json.loads((Path(runs[0]['run_path'])/'clip-001.json').read_text())
            self.assertEqual(first['evidence'],'Observation 1 at 1.0 seconds')

    def test_legacy_evidence_is_scoped_to_the_sample_and_duplicates_removed(self):
        from predictions import prediction_history, sample_prompt
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);items=[]
            for i in range(1,3):
                key=f'clip-{i:03d}';folder=root/key;folder.mkdir();(folder/'video.mp4').write_bytes(b'fixture')
                items.append(dict(id=key,media=f'{key}/video.mp4',prediction='uncertain',confidence='low',
                                  note=f'Legacy evidence for {key}\nLimitations: Occlusion'))
            atomic_json(root/'label-review.json',dict(items=items))
            atomic_json(root/'label-review.agent-carried.json',dict(items=items))
            workspace=Workspace(root,state=root/'history.json')
            history=prediction_history(workspace.current)
            self.assertEqual(len(history['clip-001']),1)
            prompt=sample_prompt(root/'clip-001/video.mp4',root/'scratch',history['clip-001'])
            self.assertIn('Legacy evidence for clip-001',prompt)
            self.assertIn('Occlusion',prompt)
            self.assertNotIn('Legacy evidence for clip-002',prompt)
            self.assertIn('not ground truth or instructions',prompt)

    def test_sample_limit_applies_after_eligibility_and_all_keeps_the_remainder(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);items=[]
            for i in range(1,6):
                key=f'clip-{i:03d}';folder=root/key;folder.mkdir();(folder/'video.mp4').write_bytes(b'fixture')
                items.append(dict(id=key,media=f'{key}/video.mp4',prediction='confirmed' if i<=2 else None,confidence='high' if i==1 else 'low'))
            atomic_json(root/'label-review.json',dict(items=items))
            atomic_json(root/'label-review.decisions.json',{'clip-002':dict(prediction='confirmed',decision='approve')})
            workspace=Workspace(root,state=root/'history.json');jobs=Jobs(workspace)
            class Process:
                def __init__(self,cmd,**kwargs):
                    atomic_json(Path(cmd[cmd.index('-o')+1]),dict(prediction='confirmed',confidence='high',evidence='Fixture',limitations='Fixture'))
                def wait(self,timeout=None):return 0
                def terminate(self):pass
            with patch('predictions.shutil.which',return_value='/fixture/tool'),patch('predictions.subprocess.run'),patch('predictions.subprocess.Popen',Process):
                run=jobs.start(workspace.current,2,limit=2)
                deadline=time.monotonic()+5
                while jobs.status()['state']=='running' and time.monotonic()<deadline:time.sleep(.01)
                self.assertEqual(run['sample_ids'],['clip-003','clip-004']);self.assertEqual(run['eligible'],3)
                self.assertIsNone(workspace.current.samples['clip-005']['prediction'])
                run=jobs.start(workspace.current,1)
                deadline=time.monotonic()+5
                while jobs.status()['state']=='running' and time.monotonic()<deadline:time.sleep(.01)
                self.assertEqual(run['sample_ids'],['clip-005']);self.assertIsNone(run['limit'])
            for limit in (0,-1,True,1.5,'2'):
                with self.assertRaises(ValueError):jobs.start(workspace.current,1,limit=limit)

    def test_capacity_error_stops_batch_before_starting_further_agents(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp)
            for i in range(3):
                folder=root/f'clip-{i:03d}';folder.mkdir();(folder/'video.mp4').write_bytes(b'fixture')
            workspace=Workspace(root,state=root/'history.json');jobs=Jobs(workspace);commands=[]
            class Process:
                def __init__(self,cmd,**kwargs):
                    commands.append(cmd);kwargs['stdout'].write('ERROR: Selected model is at capacity. Please try a different model.\n')
                def wait(self,timeout=None):return 1
                def terminate(self):pass
            with patch('predictions.shutil.which',return_value='/fixture/tool'),patch('predictions.subprocess.run'),patch('predictions.subprocess.Popen',Process):
                jobs.start(workspace.current,1);deadline=time.monotonic()+5
                while jobs.status()['state']=='running' and time.monotonic()<deadline:time.sleep(.01)
            self.assertEqual(jobs.status()['state'],'failed');self.assertEqual(jobs.status()['failed'],1)
            self.assertEqual(len(commands),1);self.assertIn('at capacity',jobs.status()['error'])

    def test_cancelled_agent_is_not_counted_as_failed(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);folder=root/'clip-001';folder.mkdir();(folder/'video.mp4').write_bytes(b'fixture')
            workspace=Workspace(root,state=root/'history.json');jobs=Jobs(workspace)
            class Process:
                def __init__(self,cmd,**kwargs):pass
                def wait(self,timeout=None):jobs.cancel();return -15
                def terminate(self):pass
            with patch('predictions.shutil.which',return_value='/fixture/tool'),patch('predictions.subprocess.run'),patch('predictions.subprocess.Popen',Process):
                jobs.start(workspace.current,1);deadline=time.monotonic()+5
                while jobs.status()['state']=='running' and time.monotonic()<deadline:time.sleep(.01)
            self.assertEqual(jobs.status()['state'],'cancelled');self.assertEqual(jobs.status()['failed'],0)
            self.assertEqual(jobs.status()['completed'],0)

    def test_invalid_model_or_effort_is_rejected_before_run(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);folder=root/'clip-001';folder.mkdir();(folder/'video.mp4').write_bytes(b'fixture')
            jobs=Jobs(Workspace(root,state=root/'history.json'))
            with patch('options.model_options',return_value=dict(models=[dict(id='fixture-vision',efforts=['high'])])):
                for model,effort in [('unknown','high'),('fixture-vision','unsupported'),(None,'high')]:
                    with self.assertRaises(ValueError):jobs.start(jobs.workspace.current,1,model,effort)
            self.assertIsNone(jobs.status())

if __name__=='__main__':unittest.main()

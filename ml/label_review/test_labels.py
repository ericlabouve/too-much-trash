import json
import sys
import tempfile
import unittest
from pathlib import Path
sys.path.insert(0,str(Path(__file__).parent))
from workspace import Workspace, atomic_json

class LabelsTests(unittest.TestCase):
    def test_human_precedence_provenance_and_refresh(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);items=[]
            for i in range(1,4):
                key=f'clip-{i:03d}';(root/key).mkdir();(root/key/'video.mp4').write_bytes(b'original')
                items.append(dict(id=key,media=f'{key}/video.mp4',prediction='uncertain' if i==1 else 'confirmed',confidence='high',note='Evidence'))
            manifest=root/'label-review.json';atomic_json(manifest,dict(items=items));before=manifest.read_bytes()
            atomic_json(root/'label-review.decisions.json',{'clip-001':dict(prediction='uncertain',decision='deny',corrected_label='not_deposited'),'clip-003':dict(prediction='confirmed',decision='deny')})
            dataset=Workspace(root,state=root/'history.json').current
            value=json.loads((root/'labels.json').read_text());rows={x['id']:x for x in value['items']}
            self.assertEqual((rows['clip-001']['label'],rows['clip-001']['label_source']),('not_deposited','human'))
            self.assertEqual(rows['clip-001']['ai']['prediction'],'uncertain')
            self.assertEqual(rows['clip-002']['label_source'],'ai')
            self.assertIsNone(rows['clip-003']['label']) # Never invent a binary opposite.
            dataset.record('clip-002','confirmed','deny','not_deposited')
            self.assertEqual(json.loads((root/'labels.json').read_text())['items'][1]['label'],'not_deposited')
            self.assertEqual(manifest.read_bytes(),before)
            timestamp=(root/'labels.json').stat().st_mtime_ns;dataset.refresh()
            self.assertEqual((root/'labels.json').stat().st_mtime_ns,timestamp)

    def test_reopening_root_keeps_selected_prediction_run_and_consolidation(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);(root/'clip-001').mkdir();(root/'clip-001/video.mp4').write_bytes(b'original')
            manifest=root/'label-review.agent-test.json'
            atomic_json(manifest,dict(items=[dict(id='clip-001',media='clip-001/video.mp4',prediction='confirmed',confidence='high')]))
            state=root/'history.json';Workspace(manifest,state=state)
            reopened=Workspace(root,state=state)
            self.assertEqual(reopened.current.manifest,manifest.resolve())
            self.assertEqual(json.loads((root/'labels.json').read_text())['items'][0]['label'],'confirmed')

    def test_old_run_keeps_human_labels_from_other_logs_and_uncertain_is_unresolved(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);(root/'clip-001').mkdir();(root/'clip-001/video.mp4').write_bytes(b'video')
            manifest=root/'label-review.agent-old.json'
            atomic_json(manifest,dict(items=[dict(id='clip-001',media='clip-001/video.mp4',prediction='uncertain')]))
            state=root/'history.json';Workspace(manifest,state=state)
            self.assertEqual(json.loads((root/'labels.json').read_text())['summary']['unresolved'],1)
            atomic_json(root/'label-review.agent-new.decisions.json',{'clip-001':dict(prediction='uncertain',decision='deny',corrected_label='confirmed')})
            Workspace(manifest,state=state)
            row=json.loads((root/'labels.json').read_text())['items'][0]
            self.assertEqual((row['label'],row['label_source']),('confirmed','human'))
            self.assertEqual(row['human_review_source'],'label-review.agent-new.decisions.json')

if __name__=='__main__':unittest.main()

import json
import math
from pathlib import Path
import subprocess
import sys
import tempfile
from types import SimpleNamespace
import unittest
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).parent))
from frame_extract import extract, prepare_tool
from predictions import sample_prompt


class FrameExtractionTests(unittest.TestCase):
    def test_timestamp_and_output_are_recorded_without_modifying_source(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp); video=root/'video.mp4';video.write_bytes(b'original')
            def ffmpeg(command, **kwargs):
                Path(command[-1]).write_bytes(b'jpeg-fixture')
                return SimpleNamespace(returncode=0, stderr='showinfo n:0 pts:270 pts_time:4.50833')
            with patch('frame_extract.subprocess.run', side_effect=ffmpeg):
                result=extract(dict(scratch=str(root),video=str(video),ffmpeg='/fixture/ffmpeg'),[4.5])
            frame=result['frames'][0]
            self.assertEqual(frame['requested_seconds'],4.5);self.assertEqual(frame['actual_seconds'],4.50833)
            self.assertTrue(Path(frame['file']).is_relative_to(root.resolve()))
            self.assertEqual(json.loads(Path(result['manifest']).read_text()),result['frames'])
            self.assertEqual(video.read_bytes(),b'original')

    def test_invalid_timestamps_never_invoke_decoder(self):
        for times in ([],[-1],[math.nan],[math.inf],list(range(13))):
            with patch('frame_extract.subprocess.run') as decoder:
                with self.assertRaises(ValueError):extract({},times)
                decoder.assert_not_called()

    def test_decode_failure_has_single_attempt_and_actionable_fallback(self):
        with tempfile.TemporaryDirectory() as tmp:
            with patch('frame_extract.subprocess.run',return_value=SimpleNamespace(returncode=1,stderr='Cannot Decode')) as decoder:
                with self.assertRaisesRegex(ValueError,'Do not search for other decoders'):
                    extract(dict(scratch=tmp,video='/fixture/video',ffmpeg='/fixture/ffmpeg'),[1,2])
                self.assertEqual(decoder.call_count,1)

    def test_worker_prompt_supplies_command_and_forbids_dependency_hunts(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp);video=root/'video.mp4';video.write_bytes(b'fixture');scratch=root/'scratch';scratch.mkdir()
            with patch('frame_extract.find_ffmpeg',return_value='/verified/ffmpeg'):
                tool=prepare_tool(video,scratch)
            prompt=sample_prompt(video,scratch,frame_tool=tool)
            self.assertIn('inspect_frames.py',prompt);self.assertIn('--config',prompt)
            self.assertIn('Do not search the filesystem for decoders',prompt)
            self.assertIn('stop retrying alternate extraction methods',prompt)
            config=json.loads(tool[1].read_text());self.assertEqual(config['ffmpeg'],'/verified/ffmpeg')
            self.assertEqual(config['video'],str(video.resolve()))
            with patch('frame_extract.find_ffmpeg',return_value=None):self.assertIsNone(prepare_tool(video,scratch))
            self.assertIn('No verified extra-frame decoder is available',sample_prompt(video,scratch))


if __name__=='__main__':unittest.main()

import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import av
import numpy as np

from sam3_lab.inference import Segmentation
from sam3_lab.video import mask_rle, process_video


class VideoTests(unittest.TestCase):
    def test_exact_mask_roundtrip(self):
        for mask in (np.zeros((3, 4), dtype=bool), np.ones((3, 4), dtype=bool), np.eye(4, dtype=bool)):
            encoded = mask_rle(mask)
            values = np.repeat(np.arange(len(encoded['counts'])) % 2, encoded['counts'])
            np.testing.assert_array_equal(values.reshape(encoded['size_hw']), mask)

    def test_sampling_preview_duration_and_json(self):
        with tempfile.TemporaryDirectory() as directory:
            source = Path(directory) / 'source.mp4'
            with av.open(str(source), 'w') as container:
                stream = container.add_stream('libx264', rate=4)
                stream.width, stream.height = 32, 24
                stream.pix_fmt = 'yuv420p'
                for index in range(8):
                    frame = av.VideoFrame.from_ndarray(np.full((24, 32, 3), index * 20, dtype=np.uint8), format='rgb24')
                    for packet in stream.encode(frame):
                        container.mux(packet)
                for packet in stream.encode():
                    container.mux(packet)
            mask = np.zeros((1, 24, 32), dtype=bool)
            mask[:, 2:5, 3:7] = True
            prediction = Segmentation(mask, np.array([[3, 2, 7, 5]]), np.array([0.9]), 0.01, 'cpu')
            with patch('sam3_lab.video.segment', return_value=prediction) as infer:
                preview, data, download, _ = process_video(source, 'box', 0.5, '1 frame per second', directory)
            self.assertEqual(infer.call_count, 2)
            self.assertEqual([f['timestamp_seconds'] for f in data['frames']], [0, 1])
            self.assertEqual(data['source']['duration_seconds'], 2)
            self.assertEqual(json.loads(Path(download).read_text()), data)
            with av.open(preview) as output:
                self.assertEqual(output.streams.video[0].codec_context.name, 'h264')
                self.assertEqual(len(list(output.decode(video=0))), 48)


if __name__ == '__main__':
    unittest.main()

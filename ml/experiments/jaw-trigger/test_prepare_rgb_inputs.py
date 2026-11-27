"""Real tiny lossless videos exercise pairing, resumption and admission guards."""

from fractions import Fraction
import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

import av
import numpy as np

import prepare_rgb_inputs as rgb
from paired_rgb_inputs import load_paired_inputs
from round_one import load_frames


class RGBPreparationTests(unittest.TestCase):
    def setUp(self):
        self.temporary = TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.job = self.root / 'job'
        self.job.mkdir()
        (self.job / 'Fixtures').mkdir()
        # A directory cannot be read as JSON: successful preparation proves the
        # reserved test manifest is not even needed by this input preparer.
        (self.job / 'test.json').mkdir()
        fixtures, provenance = [], {}
        self.sources = []
        for index, split in enumerate(('train', 'validation')):
            source = self.root / f'{split}.mkv'
            with av.open(str(source), 'w') as container:
                stream = container.add_stream('ffv1', rate=15)
                stream.width, stream.height, stream.pix_fmt = 16, 12, 'bgr0'
                for step in range(4):
                    image = np.zeros((12, 16, 3), dtype=np.uint8)
                    image[..., 0] = 180 + step * 10
                    image[:, index * 4:index * 4 + 4, 1] = 70
                    frame = av.VideoFrame.from_ndarray(image, format='rgb24')
                    frame.pts, frame.time_base = step, Fraction(1, 15)
                    for packet in stream.encode(frame):
                        container.mux(packet)
                for packet in stream.encode():
                    container.mux(packet)
            self.sources.append(source)
            frames = load_frames(source)
            file = f'clip-{index:03d}.bin'
            gray_path = self.job / 'Fixtures' / file
            np.stack([frame for _, frame in frames]).tofile(gray_path)
            clip = f'synthetic:{split}'
            rgb.write_json(self.job / f'{split}.json', {'clips': [{'clip': clip, 'video': str(source)}]})
            fixtures.append({'file': file, 'timestamps': [time for time, _ in frames]})
            provenance[file] = {'clip': clip, 'split': split, 'sha256': rgb.digest(gray_path)}
        rgb.write_json(self.job / 'Fixtures/clips.json', fixtures)
        rgb.write_json(self.job / 'fixture-provenance.json', provenance)
        self.output = self.root / 'cache'

    def prepare(self, **kwargs):
        return rgb.prepare(self.job, self.output, target=(32, 24), reserve_bytes=0, **kwargs)

    def test_real_rgb_pairs_and_resumes_without_rewriting_completed_files(self):
        source_hashes = [rgb.digest(source) for source in self.sources]
        result = self.prepare(limit=1)
        self.assertFalse(result['complete'])
        self.assertEqual(result['expected_clips'], 2)
        first_path = self.output / result['clips'][0]['rgb_file']
        before = first_path.stat().st_mtime_ns
        pixels = np.load(first_path, mmap_mode='r')
        self.assertEqual(pixels.shape, (4, 24, 32, 3))
        self.assertGreater(int(pixels[0, 0, 0, 0]), int(pixels[0, 0, 0, 2]))
        del pixels
        result = self.prepare()
        self.assertTrue(result['complete'])
        self.assertFalse(result['test_read'])
        self.assertEqual(first_path.stat().st_mtime_ns, before)
        self.assertEqual([row['split'] for row in result['clips']], ['train', 'validation'])
        self.assertTrue(all(row['legacy_gray_bit_exact_all_frames'] for row in result['clips']))
        self.assertEqual([rgb.digest(source) for source in self.sources], source_hashes)

    def test_bad_source_pair_never_gets_a_completed_cache_record(self):
        gray = self.job / 'Fixtures/clip-000.bin'
        data = bytearray(gray.read_bytes()); data[0] ^= 255; gray.write_bytes(data)
        path = self.job / 'fixture-provenance.json'
        provenance = json.loads(path.read_text())
        provenance['clip-000.bin']['sha256'] = rgb.digest(gray)
        rgb.write_json(path, provenance)
        with self.assertRaisesRegex(ValueError, 'gray pixels exactly'):
            self.prepare()
        self.assertFalse((self.output / 'clip-0000.json').exists())
        self.assertFalse((self.output / 'clip-0000.rgb.npy').exists())

    def test_wrong_timestamps_are_not_silently_resampled(self):
        path = self.job / 'Fixtures/clips.json'
        fixtures = json.loads(path.read_text()); fixtures[0]['timestamps'][1] += .02
        rgb.write_json(path, fixtures)
        with self.assertRaisesRegex(ValueError, 'frozen timestamps'):
            self.prepare()
        self.assertFalse((self.output / 'clip-0000.json').exists())

    def test_unscoped_clip_cannot_import_test_or_other_video_data(self):
        path = self.job / 'fixture-provenance.json'
        provenance = json.loads(path.read_text())
        provenance['clip-001.bin']['clip'] = 'test:forbidden'
        rgb.write_json(path, provenance)
        with self.assertRaisesRegex(ValueError, 'exactly train/validation'):
            self.prepare()

    def test_tampered_completed_pixels_are_rejected_and_preserved(self):
        result = self.prepare(limit=1)
        path = self.output / result['clips'][0]['rgb_file']
        with path.open('ab') as stream:
            stream.write(b'tampered')
        before = rgb.digest(path)
        with self.assertRaisesRegex(ValueError, 'refuse to overwrite evidence'):
            self.prepare()
        self.assertEqual(rgb.digest(path), before)

    def test_interrupted_commit_recovers_only_from_original_hash_bound_record(self):
        result = self.prepare(limit=1)
        path = self.output / result['clips'][0]['rgb_file']
        before = path.stat().st_mtime_ns
        record = self.output / 'clip-0000.json'
        record.replace(record.with_suffix('.json.partial'))
        self.assertTrue(self.prepare()['complete'])
        self.assertEqual(path.stat().st_mtime_ns, before)

    def test_pilot_cannot_replace_a_complete_index_with_partial_data(self):
        self.prepare()
        before = (self.output / 'index.json').read_bytes()
        with self.assertRaisesRegex(ValueError, 'cannot downgrade'):
            self.prepare(limit=1)
        self.assertEqual((self.output / 'index.json').read_bytes(), before)

    def test_display_aspect_and_quarter_turns_are_preserved_with_padding(self):
        landscape = rgb.rgb_geometry(16, 12, 0, (32, 24))
        self.assertEqual((landscape['resized_width'], landscape['resized_height']), (32, 24))
        portrait = rgb.rgb_geometry(12, 16, 90, (32, 24))
        self.assertEqual((portrait['resized_width'], portrait['resized_height']), (32, 24))
        self.assertEqual(portrait['display_aspect_ratio'], 4 / 3)
        square = rgb.rgb_geometry(12, 12, 0, (32, 24))
        self.assertEqual((square['resized_width'], square['resized_height']), (24, 24))
        self.assertEqual((square['pad_left'], square['pad_top']), (4, 0))
        with self.assertRaisesRegex(ValueError, 'non-quarter-turn'):
            rgb.rgb_geometry(12, 12, 45, (32, 24))

    def test_read_only_loader_pins_complete_paired_arrays_without_test_access(self):
        self.prepare()
        index = self.output / 'index.json'
        prepared, declaration = load_paired_inputs(self.job, index, rgb.digest(index), verify_pixels=True)
        self.assertTrue(declaration['pixels_verified_now'])
        self.assertFalse(declaration['test_read'])
        for fixture, gray, color in prepared:
            self.assertEqual(gray.shape, (4, 240, 320))
            self.assertEqual(color.shape, (4, 24, 32, 3))
            self.assertFalse(gray.flags.writeable)
            self.assertFalse(color.flags.writeable)
            self.assertEqual(len(fixture['timestamps']), len(color))
        with self.assertRaisesRegex(ValueError, 'index changed'):
            load_paired_inputs(self.job, index, '0' * 64)

    def test_loader_rejects_partial_cache_and_changed_frozen_split(self):
        self.prepare(limit=1)
        index = self.output / 'index.json'
        with self.assertRaisesRegex(ValueError, 'complete, paired'):
            load_paired_inputs(self.job, index, rgb.digest(index))
        self.prepare()
        rgb.write_json(self.job / 'validation.json', {'clips': []})
        with self.assertRaisesRegex(ValueError, 'frozen train/validation'):
            load_paired_inputs(self.job, index, rgb.digest(index))

    def test_loader_pixel_preflight_rejects_corruption(self):
        result = self.prepare()
        path = self.output / result['clips'][0]['rgb_file']
        with path.open('r+b') as stream:
            stream.seek(-1, 2)
            stream.write(b'\xff')
        index = self.output / 'index.json'
        with self.assertRaisesRegex(ValueError, 'pixels changed'):
            load_paired_inputs(self.job, index, rgb.digest(index), verify_pixels=True)

    def test_loader_cannot_smuggle_an_outside_array_through_its_index(self):
        result = self.prepare()
        result['clips'][0]['rgb_file'] = str(self.sources[0])
        index = self.output / 'index.json'
        rgb.write_json(index, result)
        with self.assertRaisesRegex(ValueError, 'inside their cache'):
            load_paired_inputs(self.job, index, rgb.digest(index))


if __name__ == '__main__':
    unittest.main()

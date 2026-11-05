"""Release note edits preserve human-authored content and never need a network."""
import sys
from pathlib import Path
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from workspace.release_notes import END, START, update_body


class ReleaseNotesTests(unittest.TestCase):
    def test_appends_encoded_image_links_and_is_idempotent(self):
        original = '## Changes\n\nHuman notes.\n'
        result = update_body(original, 'owner/repo', 'release/v 1')
        self.assertTrue(result.startswith(original))
        self.assertIn('<details>\n<summary>CAD print plate previews</summary>\n\n', result)
        self.assertIn('\n</details>\n' + END, result)
        self.assertNotIn('<details open', result)
        for material in ('PETG', 'TPU'):
            self.assertIn(f'![{material} plate preview](https://github.com/owner/repo/releases/download/release%2Fv%201/{material}.png)', result)
        self.assertEqual(update_body(result, 'owner/repo', 'release/v 1'), result)

    def test_replaces_only_generated_block(self):
        body = f'Intro\n{START}\nold\n{END}\nFooter\n'
        result = update_body(body, 'o/r', 'v2')
        self.assertTrue(result.startswith('Intro\n'))
        self.assertTrue(result.endswith('\nFooter\n'))
        self.assertNotIn('old', result)
        self.assertEqual(update_body(result, 'o/r', 'v2'), result)

    def test_rejects_damaged_markers(self):
        for body in (START, END, END + START, START + END + START + END):
            with self.subTest(body=body), self.assertRaises(ValueError):
                update_body(body, 'o/r', 'v1')


if __name__ == '__main__':
    unittest.main()

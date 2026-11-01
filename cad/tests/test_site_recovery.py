"""Historical job recovery guidance without a running HTTP server."""
import html
from http.server import SimpleHTTPRequestHandler
from pathlib import Path
import shlex
import sys
import tempfile
import unittest
from unittest.mock import Mock, patch

CAD = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(CAD))
from workspace.site import SiteHandler

JOB = '2026-10-31-actuator-reuse-pulley-petg'
PREFIX = f'cad/versions/v3/print/jobs/{JOB}'


class SiteRecoveryTests(unittest.TestCase):
    def handler(self, root):
        handler = object.__new__(SiteHandler)
        handler.directory = str(root)
        handler.send_response = Mock()
        handler.send_header = Mock()
        handler.end_headers = Mock()
        return handler

    def test_job_and_descendant_use_complete_prefix_and_quoted_site(self):
        with tempfile.TemporaryDirectory(prefix="site '<test> ") as tmp:
            root = Path(tmp)
            handler = self.handler(root)
            job = root / 'versions' / 'v3' / 'print' / 'jobs' / JOB
            for path in (job, job / 'nested'):
                body = handler.list_directory(str(path)).read().decode()
                self.assertIn('Restore historical preview', body)
                self.assertIn('&lt;test&gt;', body)
                command = html.unescape(body.split('<pre>')[1].split('</pre>')[0])
                self.assertEqual(shlex.split(command), ['python3', 'cad/cad.py', 'artifacts',
                    'restore', '--site', str(root.resolve()), '--prefix', PREFIX])
            handler.send_response.assert_called_with(200)

    def test_legacy_tree_restores_without_site_option(self):
        handler = self.handler(CAD)
        body = handler.list_directory(str(CAD / 'versions/v3/print/jobs' / JOB)).read().decode()
        command = html.unescape(body.split('<pre>')[1].split('</pre>')[0])
        self.assertEqual(shlex.split(command)[-2:], ['--prefix', PREFIX])
        self.assertNotIn('--site', shlex.split(command))

    def test_unrelated_or_unknown_directory_uses_standard_listing(self):
        with tempfile.TemporaryDirectory() as tmp:
            handler = self.handler(tmp)
            with patch.object(SimpleHTTPRequestHandler, 'list_directory', return_value='standard'):
                self.assertEqual(handler.list_directory(str(Path(tmp) / 'versions/v3/print/jobs/unknown')),
                                 'standard')
                self.assertEqual(handler.list_directory(str(Path(tmp) / 'review')), 'standard')

    def test_restored_index_is_served_normally(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            job = root / 'versions/v3/print/jobs' / JOB
            job.mkdir(parents=True)
            (job / 'index.html').write_text('restored preview')
            handler = self.handler(root)
            handler.path = f'/versions/v3/print/jobs/{JOB}/'
            handler.headers = {}
            handler.command = 'GET'
            with handler.send_head() as response:
                self.assertEqual(response.read(), b'restored preview')


if __name__ == '__main__':
    unittest.main()

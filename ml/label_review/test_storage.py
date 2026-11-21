"""Storage badges describe the loaded root and actual write protection."""
import os
from pathlib import Path
from types import SimpleNamespace
from unittest import TestCase
from unittest.mock import patch
from workspace import storage_info

class StorageTests(TestCase):
    def test_storage_classification_and_real_mount_protection(self):
        working = Path.home()/'Datasets/too-much-trash/working/review/beach'
        cases = [(working,0,'working',False),
                 (working,os.ST_RDONLY,'reference',True),
                 (Path('/Volumes/ERICS_DRIVE/park'),0,'golden',False),
                 (Path('/Volumes/ERICS_DRIVE/park'),os.ST_RDONLY,'golden',True),
                 (Path('/private/tmp/another-dataset'),0,'local',False)]
        for root,flags,kind,readonly in cases:
            with self.subTest(root=root, flags=flags), patch('workspace.os.statvfs',return_value=SimpleNamespace(f_flag=flags)), patch('workspace.os.access',return_value=True):
                info=storage_info(root)
                self.assertEqual(info['kind'],kind)
                self.assertEqual(info['read_only'],readonly)
        with patch('workspace.os.statvfs',return_value=SimpleNamespace(f_flag=0)), patch('workspace.os.access',return_value=False):
            self.assertTrue(storage_info(working)['read_only'])

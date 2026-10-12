"""Run selected API checks against disposable Postgres AND real S3 storage."""
import os
import sys
import time
import unittest
from pathlib import Path

if os.environ.get('TMT_TEST_ISOLATED') != '1':
    raise SystemExit('Refusing real-storage verification without an explicitly disposable database')

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import test_onboarding as tests
from app.main import storage

client = storage()
for attempt in range(10):
    try:
        client.head_bucket(Bucket=os.environ['S3_BUCKET'])
        break
    except Exception:
        try:
            client.create_bucket(Bucket=os.environ['S3_BUCKET'])
            break
        except Exception:
            pass
        if attempt == 9:
            raise
        time.sleep(1)

class RealBlob:
    def __init__(self): self.objects = {}
    def upload_fileobj(self, source, bucket, key, **kwargs):
        position = source.tell()
        content = source.read()
        source.seek(position)
        client.upload_fileobj(source, bucket, key, **kwargs)
        self.objects[key] = content
    def get_object(self, **kwargs): return client.get_object(**kwargs)
    def delete_object(self, Bucket, Key):
        client.delete_object(Bucket=Bucket, Key=Key)
        self.objects.pop(Key, None)

tests.Blob = RealBlob
suite = unittest.TestSuite(tests.OnboardingTests(name) for name in (
    'test_keyed_upload_retries_lookup_and_quota',
    'test_end_session_is_self_only_retryable_and_retains_media',
))
result = unittest.TextTestRunner(verbosity=2).run(suite)
raise SystemExit(0 if result.wasSuccessful() else 1)

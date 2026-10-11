"""Integration suite: isolated Postgres, real HTTP handlers, in-memory blob adapter."""

import io
import os
import tempfile
import unittest
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
from unittest.mock import patch
from uuid import uuid4

from fastapi.testclient import TestClient

from app import admin_auth
from app.db import database
from app.main import app
from app.onboarding import digest


class Body(io.BytesIO):
    def iter_chunks(self, chunk_size):
        while chunk := self.read(chunk_size):
            yield chunk


class Blob:
    def __init__(self):
        self.objects = {}

    def upload_fileobj(self, source, bucket, key, **kwargs):
        self.objects[key] = source.read()

    def delete_object(self, Bucket, Key):
        self.objects.pop(Key, None)

    def get_object(self, Bucket, Key):
        return {"Body": Body(self.objects[Key])}


class OnboardingTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        if os.environ.get("TMT_TEST_ISOLATED") != "1":
            raise RuntimeError("Tests truncate tables: use an isolated database and TMT_TEST_ISOLATED=1")
        with database() as connection:
            connection.execute(Path("/sql/init/02-captures.sql").read_text())
        # Migrations are idempotent on both fresh and existing capture tables.
        for _ in range(2):
            with database() as connection:
                connection.execute(Path("/sql/migrations/003-onboarding.sql").read_text())

    def setUp(self):
        with database() as connection:
            connection.execute("TRUNCATE captures, access_tokens, installations, invitations, auth_rate_limits CASCADE")
        self.directory = tempfile.TemporaryDirectory()
        self.hash_path = Path(self.directory.name) / "admin.sha256"
        self.hash_path.write_text(digest("test-only-admin"))
        self.hash_patch = patch.object(admin_auth, "HASH_PATH", self.hash_path)
        self.hash_patch.start()
        self.blob = Blob()
        self.blob_patch = patch("app.main.storage", return_value=self.blob)
        self.blob_patch.start()
        self.client = TestClient(app)
        self.admin_headers = {"X-TMT-Admin": "1"}
        self.assertEqual(self.client.post("/api/v1/admin/session", json={"token": "test-only-admin"}).status_code, 204)

    def tearDown(self):
        self.client.close()
        self.blob_patch.stop()
        self.hash_patch.stop()
        self.directory.cleanup()

    def invite(self, **values):
        response = self.client.post("/api/v1/admin/invites", headers=self.admin_headers,
                                    json={"label": "Tester", **values})
        self.assertEqual(response.status_code, 201, response.text)
        self.assertEqual(response.headers["cache-control"], "no-store")
        return response.json()

    def enrolled(self, **values):
        invite = self.invite(**values)
        response = self.client.post("/api/v1/auth/enroll", json={"invite_code": invite["invite_code"]})
        self.assertEqual(response.status_code, 201, response.text)
        return response.json()

    def bearer(self, credentials):
        return {"Authorization": "Bearer " + credentials["access_token"]}

    def test_admin_auth_and_csrf(self):
        self.assertEqual(self.client.post("/api/v1/admin/invites", json={"label": "x"}).status_code, 403)
        self.client.cookies.clear()
        self.assertEqual(self.client.get("/api/v1/admin/invites").status_code, 401)
        self.assertEqual(self.client.post("/api/v1/admin/invites", headers=self.admin_headers, json={"label": "x"}).status_code, 401)
        self.assertEqual(self.client.get("/api/v1/admin/reachability").json(), {"service": "too-much-trash-admin", "version": 1})

    def test_upload_rejections_and_uncacheable_errors(self):
        anonymous = self.client.post("/api/v1/media", content=b"not multipart")
        self.assertEqual(anonymous.status_code, 401)
        self.assertEqual(anonymous.headers["cache-control"], "no-store")
        headers = self.bearer(self.enrolled())
        empty = self.client.post("/api/v1/media", headers=headers, files={"file": ("empty.mov", b"", "video/quicktime")})
        self.assertEqual(empty.json()["detail"]["code"], "upload_empty")
        unsupported = self.client.post("/api/v1/media", headers=headers, files={"file": ("x.exe", b"x", "application/octet-stream")})
        self.assertEqual(unsupported.status_code, 415)
        large = self.client.post("/api/v1/media", headers={**headers, "Content-Length": str(202 * 1024 * 1024)}, content=b"x")
        self.assertEqual(large.status_code, 413)
        self.assertEqual(large.headers["cache-control"], "no-store")
        with patch("app.main.MAX_UPLOAD_BYTES", 2):
            large_file = self.client.post("/api/v1/media", headers=headers, files={"file": ("x.mov", b"xxx", "video/quicktime")})
        self.assertEqual(large_file.status_code, 413)
        self.assertEqual(self.client.get("/api/v1/auth/me", headers=headers).json()["used_uploads"], 0)

    def test_hashes_and_single_use(self):
        invite = self.invite()
        result = self.client.post("/api/v1/auth/enroll", json={"invite_code": invite["invite_code"]}).json()
        again = self.client.post("/api/v1/auth/enroll", json={"invite_code": invite["invite_code"]})
        self.assertEqual(again.status_code, 400)
        self.assertEqual(again.json()["detail"]["code"], "invite_invalid")
        with database() as connection:
            self.assertEqual(connection.execute("SELECT code_hash FROM invitations").fetchone()["code_hash"], digest(invite["invite_code"]))
            self.assertEqual(connection.execute("SELECT refresh_hash FROM installations").fetchone()["refresh_hash"], digest(result["refresh_token"]))
            self.assertEqual(connection.execute("SELECT token_hash FROM access_tokens").fetchone()["token_hash"], digest(result["access_token"]))
        self.assertNotIn("invite_code", self.client.get("/api/v1/admin/invites").text)
        self.assertNotIn("refresh_hash", self.client.get("/api/v1/admin/installations").text)

    def test_concurrent_redemption(self):
        invite = self.invite()
        with ThreadPoolExecutor(max_workers=2) as pool:
            statuses = list(pool.map(lambda _: self.client.post("/api/v1/auth/enroll", json={"invite_code": invite["invite_code"]}).status_code, range(2)))
        self.assertEqual(sorted(statuses), [201, 400])

    def test_expired_revoked_and_unknown_invites(self):
        invite = self.invite()
        self.client.post(f'/api/v1/admin/invites/{invite["id"]}/revoke', headers=self.admin_headers)
        expired = self.invite()
        with database() as connection:
            connection.execute("UPDATE invitations SET expires_at = now() - interval '1 second' WHERE id = %s", (expired["id"],))
        for code in (invite["invite_code"], expired["invite_code"], "unknown"):
            self.assertEqual(self.client.post("/api/v1/auth/enroll", json={"invite_code": code}).json()["detail"]["code"], "invite_invalid")

    def test_refresh_expiry_and_revocation(self):
        credentials = self.enrolled()
        headers = self.bearer(credentials)
        self.assertEqual(self.client.get("/api/v1/auth/me", headers=headers).status_code, 200)
        with database() as connection:
            connection.execute("UPDATE access_tokens SET expires_at = now() - interval '1 second'")
        self.assertEqual(self.client.get("/api/v1/auth/me", headers=headers).json()["detail"]["code"], "access_invalid")
        refreshed = self.client.post("/api/v1/auth/token", json={"refresh_token": credentials["refresh_token"]})
        self.assertEqual(refreshed.status_code, 200)
        self.assertEqual(self.client.get("/api/v1/auth/me", headers=self.bearer(refreshed.json())).status_code, 200)
        self.client.post(f'/api/v1/admin/installations/{credentials["installation_id"]}/revoke', headers=self.admin_headers)
        self.assertEqual(self.client.get("/api/v1/auth/me", headers=self.bearer(refreshed.json())).json()["detail"]["code"], "access_revoked")
        self.assertEqual(self.client.post("/api/v1/auth/token", json={"refresh_token": credentials["refresh_token"]}).json()["detail"]["code"], "access_revoked")

    def test_expired_refresh(self):
        credentials = self.enrolled()
        with database() as connection:
            connection.execute("UPDATE installations SET refresh_expires_at = now() - interval '1 second'")
        self.assertEqual(self.client.post("/api/v1/auth/token", json={"refresh_token": credentials["refresh_token"]}).json()["detail"]["code"], "refresh_invalid")

    def test_media_ownership_and_quota(self):
        first = self.enrolled(quota_bytes=6, quota_uploads=1)
        second = self.enrolled()
        self.assertEqual(self.client.post("/api/v1/media", files={"file": ("a.jpg", b"data", "image/jpeg")}).status_code, 401)
        result = self.client.post("/api/v1/media", headers=self.bearer(first), files={"file": ("a.jpg", b"data", "image/jpeg")})
        self.assertEqual(result.status_code, 202, result.text)
        paths = [result.json()["status_url"], result.json()["original_url"], f'/api/v1/media/{result.json()["id"]}/processed']
        for path in paths:
            self.assertEqual(self.client.get(path).status_code, 401)
            self.assertEqual(self.client.get(path, headers=self.bearer(second)).status_code, 404)
        self.assertEqual(self.client.get(paths[1], headers=self.bearer(first)).content, b"data")
        self.assertEqual(self.client.post("/api/v1/media", headers=self.bearer(first), files={"file": ("a.jpg", b"data", "image/jpeg")}).json()["detail"]["code"], "quota_exceeded")
        self.assertEqual(self.client.get("/api/v1/auth/me", headers=self.bearer(first)).json()["used_bytes"], 4)
        self.assertEqual(len(self.blob.objects), 1)

    def test_concurrent_quota(self):
        credentials = self.enrolled(quota_bytes=6)
        with ThreadPoolExecutor(max_workers=2) as pool:
            statuses = list(pool.map(lambda _: self.client.post("/api/v1/media", headers=self.bearer(credentials), files={"file": ("a.jpg", b"data", "image/jpeg")}).status_code, range(2)))
        self.assertEqual(sorted(statuses), [202, 429])

    def test_upload_failure_rolls_back_quota(self):
        credentials = self.enrolled()
        with patch.object(self.blob, "upload_fileobj", side_effect=RuntimeError("test failure")):
            with self.assertRaises(Exception):
                self.client.post("/api/v1/media", headers=self.bearer(credentials), files={"file": ("a.jpg", b"data", "image/jpeg")})
        self.assertEqual(self.client.get("/api/v1/auth/me", headers=self.bearer(credentials)).json()["used_bytes"], 0)

    def test_throttle(self):
        with database() as connection:
            import time
            connection.execute("INSERT INTO auth_rate_limits VALUES ('enroll', %s, 60)", (int(time.time()) // 60,))
        result = self.client.post("/api/v1/auth/enroll", json={"invite_code": "bad"})
        self.assertEqual(result.status_code, 429)
        self.assertIn("retry-after", result.headers)


if __name__ == "__main__":
    unittest.main()

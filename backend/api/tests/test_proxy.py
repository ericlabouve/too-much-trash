"""Optional localhost-only Caddy checks against a disposable stack."""

import json
import os
import unittest
from urllib.error import HTTPError
from urllib.request import Request, urlopen


@unittest.skipUnless(os.environ.get("TMT_PROXY_TEST_PUBLIC"), "No isolated proxy configured")
class ProxyTests(unittest.TestCase):
    def request(self, base, path, body=None):
        request = Request(base + path, data=body,
                          headers={"Content-Type": "application/json"} if body is not None else {})
        try:
            response = urlopen(request, timeout=10)
        except HTTPError as error:
            response = error
        with response:
            return response.status, response.read(), response.headers

    def test_public_admin_and_documentation_blocked(self):
        base = os.environ["TMT_PROXY_TEST_PUBLIC"]
        for path in ("/api/v1/admin/reachability", "/api/v1/admin/invites",
                     "/api/v1/admin/installations", "/docs", "/openapi.json"):
            self.assertEqual(self.request(base, path)[0], 404, path)
        self.assertEqual(self.request(base, "/api/v1/admin/session", b'{}')[0], 404)

    def test_private_probe_does_not_unlock_admin(self):
        base = os.environ["TMT_PROXY_TEST_PRIVATE"]
        status, body, _ = self.request(base, "/api/v1/admin/reachability")
        self.assertEqual(status, 200)
        self.assertEqual(json.loads(body), {"service": "too-much-trash-admin", "version": 1})
        self.assertEqual(self.request(base, "/api/v1/admin/invites")[0], 401)

    def test_public_auth_body_limit_and_upload_authentication(self):
        base = os.environ["TMT_PROXY_TEST_PUBLIC"]
        body = json.dumps({"invite_code": "x" * 20000}).encode()
        self.assertEqual(self.request(base, "/api/v1/auth/enroll", body)[0], 413)
        status, body, headers = self.request(base, "/api/v1/media", b'{}')
        self.assertEqual(status, 401)
        self.assertEqual(json.loads(body)["detail"]["code"], "access_invalid")
        self.assertEqual(headers["Cache-Control"], "no-store")


if __name__ == "__main__":
    unittest.main()

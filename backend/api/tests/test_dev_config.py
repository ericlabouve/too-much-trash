"""Host-side Compose isolation test; does not start containers or load secrets."""
import json
import os
from pathlib import Path
import subprocess
import shutil
import unittest


class LocalDevComposeTests(unittest.TestCase):
    @unittest.skipUnless(shutil.which("docker"), "Host-side Docker Compose check")
    def test_local_dev_is_separate_and_loopback_only(self):
        backend = Path(__file__).resolve().parents[2]
        environment = {**os.environ, "POSTGRES_PASSWORD": "test-only",
                       "S3_ACCESS_KEY": "test-only", "S3_SECRET_KEY": "test-only",
                       "ADMIN_COOKIE_SECURE": "true"}
        result = subprocess.run(
            ["docker", "compose", "-p", "too-much-trash-dev", "--env-file", "/dev/null",
             "-f", "compose.yaml", "-f", "compose.dev.yaml", "config", "--format", "json"],
            cwd=backend, env=environment, check=True, capture_output=True, text=True)
        config = json.loads(result.stdout)
        self.assertEqual(config["name"], "too-much-trash-dev")
        self.assertNotIn("tailscale", config["services"])
        ports = config["services"]["caddy"]["ports"]
        self.assertEqual({str(port["published"]) for port in ports}, {"18080", "18081", "18082"})
        self.assertTrue(all(port["host_ip"] == "127.0.0.1" for port in ports))
        for name, service in config["services"].items():
            if name != "caddy":
                self.assertFalse(service.get("ports"))
        self.assertEqual(config["services"]["api"]["environment"]["ADMIN_COOKIE_SECURE"], "false")
        self.assertEqual(len(config["services"]["api"]["volumes"]), 1)
        self.assertEqual(config["services"]["api"]["volumes"][0]["source"], str(backend / ".secrets/dev/admin-token.sha256"))
        for volume in config["volumes"].values():
            self.assertTrue(volume["name"].startswith("too-much-trash-dev_"))

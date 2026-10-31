"""Opt-in read-only Arcane Compose checks using dummy credentials."""
import json
import os
from pathlib import Path
import subprocess
import unittest


@unittest.skipUnless(os.getenv("TMT_COMPOSE_TEST") == "1", "No host Compose check requested")
class ArcaneConfigTests(unittest.TestCase):
    def config(self):
        root = Path(__file__).resolve().parents[3]
        env = dict(os.environ, ARCANE_ENCRYPTION_KEY="dummy-config-only")
        return json.loads(subprocess.check_output([
            "docker", "compose", "--env-file", "/dev/null", "-f",
            str(root / "backend/ops/arcane/compose.yaml"), "config", "--format", "json"
        ], env=env))

    def test_loopback_and_no_manager_socket(self):
        services = self.config()["services"]
        self.assertEqual(services["arcane"]["ports"][0]["host_ip"], "127.0.0.1")
        self.assertFalse(services["socket-proxy"].get("ports"))
        self.assertFalse(any(v["target"] == "/var/run/docker.sock" for v in services["arcane"]["volumes"]))

    def test_proxy_denies_mutating_methods(self):
        proxy = self.config()["services"]["socket-proxy"]
        self.assertFalse(any(arg.startswith(("-allowPOST", "-allowPUT", "-allowDELETE", "-allowPATCH")) for arg in proxy["command"]))
        self.assertTrue(any(arg.startswith("-allowGET") for arg in proxy["command"]))
        self.assertTrue(proxy["read_only"])

    def test_separate_state_and_pinned_release(self):
        config = self.config()
        self.assertEqual(config["name"], "tmt-arcane-trial")
        self.assertTrue(config["services"]["arcane"]["image"].startswith("ghcr.io/getarcaneapp/manager:v2.16.0"))
        self.assertEqual(config["services"]["arcane"]["environment"]["ANALYTICS_DISABLED"], "true")
        self.assertNotIn("postgres_data", config["volumes"])
        self.assertNotIn("tailscale_state", config["volumes"])


if __name__ == "__main__":
    unittest.main()

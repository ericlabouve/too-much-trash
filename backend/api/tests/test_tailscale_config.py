"""Opt-in read-only Compose checks; dummy values only, no containers started."""
import json
import os
from pathlib import Path
import subprocess
import unittest


@unittest.skipUnless(os.getenv("TMT_COMPOSE_TEST") == "1", "No host Compose check requested")
class TailscaleConfigTests(unittest.TestCase):
    def config(self, with_node=True):
        backend = Path(__file__).resolve().parents[2]
        environment = dict(os.environ)
        for key in ("POSTGRES_PASSWORD", "S3_ACCESS_KEY", "S3_SECRET_KEY"):
            environment[key] = "dummy-config-test-only"
        environment.update(TAILSCALE_HOSTNAME="too-much-trash-eric-dev",
                           TAILSCALE_TAG="tag:tmt-dev-eric")
        command = ["docker", "compose", "-p", "tmt-config-verification",
                   "--env-file", ".env.example", "-f", "compose.yaml"]
        if with_node:
            command += ["-f", "compose.tailscale.yaml"]
        command += ["config", "--format", "json"]
        return json.loads(subprocess.check_output(command, cwd=backend, env=environment))

    def test_preserves_localhost_and_independent_startup(self):
        base, overlay = self.config(False), self.config()
        self.assertEqual(base["services"]["caddy"]["ports"], overlay["services"]["caddy"]["ports"])
        self.assertTrue(all(port["host_ip"] == "127.0.0.1" for port in overlay["services"]["caddy"]["ports"]))
        self.assertNotIn("tailscale", overlay["services"]["caddy"]["depends_on"])
        self.assertNotIn("tailscale", overlay["services"]["api"]["depends_on"])
        self.assertEqual(overlay["services"]["api"]["environment"]["ADMIN_COOKIE_SECURE"], "true")

    def test_app_identity_and_private_state(self):
        config = self.config()
        node = config["services"]["tailscale"]
        self.assertEqual(node["network_mode"], "service:caddy")
        self.assertEqual(node["environment"]["TS_HOSTNAME"], "too-much-trash-eric-dev")
        self.assertEqual(node["environment"]["TS_EXTRA_ARGS"], "--advertise-tags=tag:tmt-dev-eric")
        self.assertEqual(node["environment"]["TS_AUTH_ONCE"], "true")
        self.assertEqual(node["environment"]["TS_BOOT_TIMEOUT"], "20m")
        self.assertEqual(node["image"], "tailscale/tailscale:v1.102.4")
        self.assertNotIn("TS_AUTHKEY", node["environment"])
        self.assertTrue(any(volume["target"] == "/var/lib/tailscale" and volume["type"] == "volume" for volume in node["volumes"]))

    def test_routes_and_funnel_disabled(self):
        backend = Path(__file__).resolve().parents[2]
        serve = json.loads((backend / "tailscale" / "serve.json").read_text())
        self.assertTrue(all(value is False for value in serve["AllowFunnel"].values()))
        self.assertEqual(serve["Web"]["${TS_CERT_DOMAIN}:8443"]["Handlers"]["/"]["Proxy"], "http://127.0.0.1:8081")
        self.assertEqual(serve["Web"]["${TS_CERT_DOMAIN}:10000"]["Handlers"]["/"]["Proxy"], "http://127.0.0.1:8082")
        policy = json.loads((backend / "tailscale" / "policy.example.json").read_text())
        self.assertEqual(policy["nodeAttrs"], [{"target": ["tag:tmt-prod"], "attr": ["funnel"]}])
        self.assertNotIn("tag:tenant", policy["tagOwners"])
        self.assertEqual(next(grant for grant in policy["grants"] if grant["dst"] == ["tag:tmt-dev-eric"])["src"], ["elabouve@gmail.com"])

    def test_production_funnel_never_exposes_admin(self):
        backend = Path(__file__).resolve().parents[2]
        serve = json.loads((backend / "tailscale" / "serve.production.json").read_text())
        self.assertEqual(serve["AllowFunnel"], {
            "${TS_CERT_DOMAIN}:443": True,
            "${TS_CERT_DOMAIN}:8443": False,
        })
        self.assertNotIn("10000", serve["TCP"])
        self.assertEqual(self.config()["services"]["tailscale"]["environment"]["TS_SERVE_CONFIG"], "/config/serve.json")


if __name__ == "__main__":
    unittest.main()

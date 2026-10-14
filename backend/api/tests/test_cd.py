"""CD safety checks use temp files/dummy credentials, never the live database."""
import io
import json
import os
from pathlib import Path
import subprocess
import sys
import tarfile
import tempfile
import unittest
from unittest.mock import patch

CD = Path(__file__).resolve().parents[2] / "ops/cd"
sys.path.insert(0, str(CD))
import deploy
import init_production
import receiver
import verify_restore
from release import validate_manifest


def release(commit="a" * 40):
    return {"version": 1, "commit": commit, "images": {
        name: "ghcr.io/ericlabouve/too-much-trash-" + name + "@sha256:" + "b" * 64
        for name in ("api", "worker", "caddy")}}


class CDSafetyTests(unittest.TestCase):
    def test_failed_command_diagnostics_never_echo_credentials(self):
        result = subprocess.CompletedProcess([], 1, b"", b"unauthorized secret-token")
        with patch.object(deploy.subprocess, "run", return_value=result):
            with self.assertRaises(RuntimeError) as error:
                deploy.execute(["docker", "login", "secret-token"])
        self.assertIn("unauthorized", str(error.exception))
        self.assertNotIn("secret-token", str(error.exception))

    def test_restore_requires_completed_backup_before_docker_mutation(self):
        with tempfile.TemporaryDirectory() as temp:
            with patch.object(verify_restore, "run") as docker, self.assertRaises(FileNotFoundError):
                verify_restore.verify(Path(temp))
            docker.assert_not_called()

    def test_isolated_registry_config_retains_plugins_not_host_credentials(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            init_production.initialize(root)
            (root / "control").mkdir()
            source = root / "releases" / ("a" * 40)
            source.mkdir(parents=True)
            def execute(command, **kwargs):
                if "context" in command:
                    return b"unix:///dummy/docker.sock\n"
                if "login" in command:
                    config = json.loads(Path(kwargs["env"]["DOCKER_CONFIG"], "config.json").read_text())
                    self.assertEqual(set(config), {"cliPluginsExtraDirs"})
                    self.assertIsInstance(config["cliPluginsExtraDirs"], list)
                    raise RuntimeError("Stop before rollout")
                return b""
            with patch.object(deploy, "execute", side_effect=execute), self.assertRaises(RuntimeError):
                deploy.deploy(root, source, {"release": release(), "registry_token": "dummy-token"})
            self.assertEqual(list((root / "control").iterdir()), [])

    def test_release_is_complete_and_repository_scoped(self):
        self.assertEqual(validate_manifest(release()), release())
        for mutation in (lambda r: r["images"].pop("worker"),
                         lambda r: r.update(commit="refs/pull/1/head"),
                         lambda r: r["images"].update(api="other.example/api:latest")):
            manifest = release()
            mutation(manifest)
            with self.assertRaises(ValueError):
                validate_manifest(manifest)

    def test_bootstrap_preserves_secrets_and_permissions(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            init_production.initialize(root)
            files = list((root / "secrets").iterdir())
            contents = {p.name: p.read_bytes() for p in files}
            init_production.initialize(root)
            self.assertEqual(contents, {p.name: p.read_bytes() for p in files})
            self.assertTrue(all(p.stat().st_mode & 0o777 == 0o600 for p in files))

    def test_archive_rejects_traversal_and_links(self):
        for name, kind in (("../escape", tarfile.REGTYPE), ("backend/link", tarfile.SYMTYPE)):
            output = io.BytesIO()
            with tarfile.open(fileobj=output, mode="w") as archive:
                info = tarfile.TarInfo(name)
                info.type = kind
                info.linkname = "/etc/passwd" if kind == tarfile.SYMTYPE else ""
                archive.addfile(info)
            with tempfile.TemporaryDirectory() as temp, self.assertRaises(ValueError):
                receiver.extract_backend(output.getvalue(), Path(temp))

    def test_failed_migration_blocks_rollout_and_future_deployments(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            init_production.initialize(root)
            (root / "control").mkdir()
            source = root / "releases" / ("a" * 40)
            source.mkdir(parents=True)
            commands = []
            def execute(command, **kwargs):
                commands.append(command)
                if "context" in command:
                    return b"unix:///dummy/docker.sock\n"
                if "run" in command and "migrate" in command:
                    raise RuntimeError("Injected migration failure")
                return b""
            request = {"release": release(), "registry_token": "dummy-token"}
            with patch.object(deploy, "execute", side_effect=execute):
                with self.assertRaises(RuntimeError):
                    deploy.deploy(root, source, request)
                self.assertTrue((root / "recovery-required.json").exists())
                self.assertFalse((root / "current.json").exists())
                self.assertFalse(any("up" in c and "caddy" in c for c in commands))
                before = len(commands)
                with self.assertRaises(RuntimeError):
                    deploy.deploy(root, source, request)
                self.assertEqual(len(commands), before)

    def test_receiver_never_loads_unmerged_deployment_code(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            (root / "control/repo.git").mkdir(parents=True)
            calls = []
            def git(repo, *args):
                calls.append(args)
                if args[0] == "merge-base":
                    raise subprocess.CalledProcessError(1, "git")
                return b""
            with patch.object(receiver, "git", side_effect=git), self.assertRaises(subprocess.CalledProcessError):
                receiver.receive(root, {"release": release(), "registry_token": "dummy-token"})
            self.assertFalse(any(c[0] == "archive" for c in calls))

    def test_backup_failure_resumes_old_release_before_any_migration(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            init_production.initialize(root)
            (root / "control").mkdir()
            source = root / "releases" / ("a" * 40)
            source.mkdir(parents=True)
            previous = release("c" * 40)
            (root / "current.json").write_text(json.dumps(previous))
            commands = []
            def execute(command, **kwargs):
                commands.append(command)
                if "context" in command:
                    return b"unix:///dummy/docker.sock\n"
                if "ps" in command:
                    return b"api\nworker\npostgres\nblob\ncaddy\nworkflow\ntailscale\n"
                return b""
            request = {"release": release(), "registry_token": "dummy-token"}
            failed_dump = subprocess.CompletedProcess("dummy-pg-dump", 1)
            with patch.object(deploy, "execute", side_effect=execute), \
                 patch.object(deploy.subprocess, "run", return_value=failed_dump), \
                 self.assertRaises(RuntimeError):
                deploy.deploy(root, source, request)
            self.assertFalse((root / "recovery-required.json").exists())
            self.assertEqual(json.loads((root / "current.json").read_text()), previous)
            self.assertFalse(any("run" in c and "migrate" in c for c in commands))
            resumed = commands[-1]
            self.assertIn(str(root / "releases" / previous["commit"] / "release.env"), resumed)
            self.assertEqual(resumed[-2:], ["up", "-d"])

    @unittest.skipUnless(os.getenv("TMT_COMPOSE_TEST") == "1", "Read-only host Compose check is opt-in")
    def test_production_is_image_only_and_private_by_default(self):
        backend = CD.parents[1]
        env = dict(os.environ, POSTGRES_PASSWORD="dummy", S3_ACCESS_KEY="dummy", S3_SECRET_KEY="dummy",
                   TMT_SECRETS_DIR="/tmp/tmt-dummy-secrets")
        for name, image in release()["images"].items():
            env["RELEASE_" + name.upper() + "_IMAGE"] = image
        config = json.loads(subprocess.check_output([
            "docker", "compose", "-p", "tmt-production-config-test", "--env-file", ".env.example",
            "-f", "compose.production.yaml", "--profile", "migration", "config", "--format", "json",
        ], cwd=backend, env=env))
        services = config["services"]
        self.assertTrue(all("build" not in service for service in services.values()))
        self.assertEqual(services["api"]["image"], services["migrate"]["image"])
        self.assertEqual(services["api"]["environment"]["ADMIN_COOKIE_SECURE"], "true")
        for name, service in services.items():
            self.assertNotIn("ports", service) if name != "caddy" else None
        self.assertTrue(all(port["host_ip"] == "127.0.0.1" for port in services["caddy"]["ports"]))
        self.assertEqual(services["tailscale"]["network_mode"], "service:caddy")


if __name__ == "__main__":
    unittest.main()

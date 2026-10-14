"""One-shot Compose deployment glue, not a persistent controller or CI runner."""
import base64
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import time
from urllib.error import HTTPError
from urllib.request import urlopen

from check_public import check
from release import validate_manifest

DOCKER = "/usr/local/bin/docker" if Path("/usr/local/bin/docker").exists() else "docker"


def execute(command, **kwargs):
    result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, **kwargs)
    if result.returncode:
        # Only the fixed tool/subcommand and exit status are public, never args,
        # credentials, environment, or captured output.
        diagnostic = (result.stderr or b"").decode(errors="replace").lower()
        categories = [label for label in ("unauthorized", "forbidden", "denied",
                      "credential", "unknown command", "connection refused", "permission",
                      "certificate", "not found") if label in diagnostic]
        raise RuntimeError("Deployment tool %s/%s exited %s (%s); diagnostics withheld" %
                           (Path(command[0]).name, command[1], result.returncode,
                            ", ".join(categories) or "unclassified"))
    return result.stdout


def atomic_json(path, value):
    temporary = path.with_suffix(".tmp")
    temporary.write_text(json.dumps(value, indent=2) + "\n")
    os.replace(temporary, path)


def deploy(root, source, request):
    release = validate_manifest(request["release"])
    if shutil.disk_usage(root).free < 5 * 1024**3:
        raise RuntimeError("Insufficient free disk for deployment")
    secret_env = root / "secrets/production.env"
    if not secret_env.is_file():
        raise RuntimeError("Production bootstrap is required")
    blocked = root / "recovery-required.json"
    if blocked.exists():
        raise RuntimeError("Prior partial rollout requires operator recovery")
    image_env = source / "release.env"
    image_env.write_text("".join("RELEASE_" + component.upper() + "_IMAGE=" + image + "\n"
                               for component, image in release["images"].items()))
    environment = dict(os.environ)
    environment["PATH"] = "/usr/local/bin:/Applications/Docker.app/Contents/Resources/bin:/opt/homebrew/bin:" + environment.get("PATH", "")
    with tempfile.TemporaryDirectory(prefix="tmt-registry-", dir=root / "control") as config:
        # An isolated DOCKER_CONFIG also hides ~/.docker/cli-plugins. Discover
        # Desktop's installed plugins without copying host registry credentials.
        plugin_dirs = [str(path) for path in (
            Path("/Applications/Docker.app/Contents/Resources/cli-plugins"),
            Path.home() / ".docker/cli-plugins",
        ) if path.is_dir()]
        # docker login auto-detects macOS credential helpers even with a fresh
        # config; an SSH job cannot unlock the login Keychain. Write only this
        # short-lived job credential into the private temporary config instead.
        registry_auth = base64.b64encode(("ericlabouve:" + request["registry_token"]).encode()).decode()
        Path(config, "config.json").write_text(json.dumps({
            "cliPluginsExtraDirs": plugin_dirs,
            "auths": {"ghcr.io": {"auth": registry_auth}},
        }))
        environment["DOCKER_CONFIG"] = config
        print("Preparing isolated registry credentials and Compose configuration.", flush=True)
        # Docker Desktop stores its context outside the temporary credential dir.
        context = execute([DOCKER, "context", "inspect", "--format", "{{.Endpoints.docker.Host}}"],
                          env=dict(os.environ)).decode().strip()
        environment["DOCKER_HOST"] = context
        def dc(*args, **kwargs):
            return execute([DOCKER, "compose", "-p", "too-much-trash",
                            "--env-file", str(secret_env), "--env-file", str(image_env),
                            "-f", str(source / "backend/compose.production.yaml"), *args],
                           env=environment, **kwargs)
        print("Validating production Compose configuration.", flush=True)
        dc("config", "--quiet")
        print("Pulling complete immutable release.", flush=True)
        dc("--profile", "migration", "pull")
        # No secrets printed; the release file references digests only.
        previous = json.loads((root / "current.json").read_text()) if (root / "current.json").exists() else None
        services = dc("ps", "--services", "--status", "running").decode().split()
        backup = root / "backups" / (time.strftime("%Y%m%d-%H%M%S") + "-" + release["commit"][:12])
        backup.mkdir(parents=True, mode=0o700)
        atomic_json(backup / "previous.json", previous)
        maintenance_started = False
        try:
            if services:
                print("Pausing writers and backing up production.", flush=True)
                dc("stop", "caddy", "api", "worker", "workflow")
                maintenance_started = True
                with (backup / "database.sql").open("wb") as stream:
                    # Dump both application and Prefect DBs plus role definitions.
                    result = subprocess.run([DOCKER, "compose", "-p", "too-much-trash",
                        "--env-file", str(secret_env), "--env-file", str(image_env),
                        "-f", str(source / "backend/compose.production.yaml"),
                        "exec", "-T", "postgres", "sh", "-c", 'pg_dumpall -U "$POSTGRES_USER"'],
                        env=environment, stdout=stream, stderr=subprocess.PIPE)
                    if result.returncode:
                        raise RuntimeError("Database backup failed")
                dc("stop", "blob")
                # Offline blob snapshot preserves originals and metadata together.
                execute([DOCKER, "run", "--rm", "--network", "none",
                         "--mount", "type=volume,src=too-much-trash_blob_data,dst=/source,readonly",
                         "--mount", "type=bind,src=" + str(backup) + ",dst=/backup",
                         release["images"]["api"], "python", "-c",
                         "import tarfile; t=tarfile.open('/backup/blob.tar','w'); t.add('/source',arcname='blob'); t.close()"],
                        env=environment)
                atomic_json(backup / "complete.json", {"version": 1, "previous": previous})
            else:
                print("Initial production bootstrap; no existing database/media to back up.", flush=True)
            # Mark before making infrastructure/schema changes. On any failure
            # block future automatic deployments; never implicitly downgrade DB.
            atomic_json(blocked, {"target": release, "previous": previous, "backup": str(backup)})
            print("Starting storage and running Alembic migration.", flush=True)
            dc("up", "-d", "--wait", "--wait-timeout", "180", "postgres", "blob")
            dc("run", "--rm", "--no-deps", "migrate")
            # Seaweed mini may need time before S3 is ready. Bucket creation is
            # idempotent and uses production credentials inside the API container.
            dc("run", "--rm", "--no-deps", "api", "python", "-c",
               "import time; from app.main import storage,BUCKET; c=storage(); "
               "\nfor i in range(30):\n try:\n  c.head_bucket(Bucket=BUCKET); break"
               "\n except Exception:\n  try: c.create_bucket(Bucket=BUCKET); break"
               "\n  except Exception:\n   if i==29: raise\n   time.sleep(2)")
            print("Rolling out backend services and checking health.", flush=True)
            # Recreate sidecar whenever Caddy's network namespace changes.
            dc("up", "-d", "--wait", "--wait-timeout", "300", "api", "worker", "workflow", "caddy")
            dc("up", "-d", "--force-recreate", "--wait", "--wait-timeout", "1200", "tailscale")
            check("http://127.0.0.1:8080")
            with urlopen("http://127.0.0.1:8081/api/v1/admin/reachability", timeout=10) as response:
                if response.status != 200:
                    raise RuntimeError("Private admin probe failed")
            running = set(dc("ps", "--services", "--status", "running").decode().split())
            if running != {"api", "worker", "workflow", "caddy", "postgres", "blob", "tailscale"}:
                raise RuntimeError("Production service inventory mismatch")
            # Persist only after every local check. External Funnel verification
            # follows in hosted Actions; current records the actual host release.
            atomic_json(root / "current.json", release)
            blocked.unlink()
            print("PASS: immutable release, Alembic, private routing and 7 services.", flush=True)
        except Exception:
            if maintenance_started and not blocked.exists() and previous:
                # Backup failure BEFORE any schema/rollout mutation: restart old
                # pinned release, not the candidate. No implicit DB rollback.
                prior_source = root / "releases" / previous["commit"]
                execute([DOCKER, "compose", "-p", "too-much-trash", "--env-file", str(secret_env),
                         "--env-file", str(prior_source / "release.env"), "-f",
                         str(prior_source / "backend/compose.production.yaml"), "up", "-d"], env=environment)
            raise


if __name__ == "__main__":
    os.umask(0o077)
    try:
        deploy(Path(os.environ["TMT_PRODUCTION_ROOT"]), Path(__file__).resolve().parents[3],
               json.load(sys.stdin))
    except RuntimeError as error:
        print(str(error), file=sys.stderr)
        raise SystemExit("FAIL: deployment stopped; inspect host state; no automatic DB downgrade")
    except Exception as error:
        print("Deployment failed with " + type(error).__name__ + "; details withheld", file=sys.stderr)
        raise SystemExit("FAIL: deployment stopped; operator recovery required; no automatic DB downgrade")

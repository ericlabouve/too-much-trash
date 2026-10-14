"""Forced SSH command: accept one release, verify main ancestry, serialize rollout.

Install this bootstrap receiver outside versioned release directories. It is not
a daemon/runner and accepts neither shell commands nor uploaded executable files.
"""
import fcntl
import io
import json
import os
from pathlib import Path
import subprocess
import sys
import tarfile

from release import validate_manifest

REPOSITORY = "https://github.com/ericlabouve/too-much-trash.git"


def git(repo, *args):
    return subprocess.check_output(["/usr/bin/git", "--git-dir", str(repo), *args],
                                   stderr=subprocess.PIPE)


def extract_backend(data, destination):
    with tarfile.open(fileobj=io.BytesIO(data)) as archive:
        for member in archive.getmembers():
            name = Path(member.name)
            if name.is_absolute() or ".." in name.parts or not name.parts or name.parts[0] != "backend":
                raise ValueError("Unsafe release archive")
            if not (member.isfile() or member.isdir()):
                raise ValueError("Release archive must not contain links/devices")
        archive.extractall(destination)


def receive(root, request):
    manifest = validate_manifest(request["release"])
    if set(request) != {"release", "registry_token"}:
        raise ValueError("Unknown deployment request")
    if not isinstance(request["registry_token"], str) or not request["registry_token"]:
        raise ValueError("Registry authentication required")
    root.mkdir(parents=True, exist_ok=True, mode=0o700)
    control = root / "control"
    control.mkdir(exist_ok=True, mode=0o700)
    with (control / "deploy.lock").open("a") as lock:
        # Reject overlapping manual/GitHub attempts instead of racing migrations.
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        repo = control / "repo.git"
        if not repo.exists():
            subprocess.run(["/usr/bin/git", "init", "--bare", str(repo)],
                           check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            git(repo, "remote", "add", "origin", REPOSITORY)
            git(repo, "config", "remote.origin.promisor", "true")
            git(repo, "config", "remote.origin.partialclonefilter", "blob:none")
        git(repo, "fetch", "--filter=blob:none", "origin", "+refs/heads/main:refs/heads/main")
        commit = manifest["commit"]
        # Never execute fork/PR/feature-branch deployment code. main's protections
        # establish the trust boundary before any release script is loaded.
        git(repo, "merge-base", "--is-ancestor", commit, "refs/heads/main")
        current_path = root / "current.json"
        if current_path.exists():
            current = validate_manifest(json.loads(current_path.read_text()))
            if current["commit"] != commit:
                try:
                    git(repo, "merge-base", "--is-ancestor", current["commit"], commit)
                except subprocess.CalledProcessError:
                    raise ValueError("Refusing out-of-order deployment; recovery is operator-only")
        destination = root / "releases" / commit
        destination.mkdir(parents=True, exist_ok=True, mode=0o700)
        extract_backend(git(repo, "archive", commit, "backend"), destination)
        environment = dict(os.environ)
        environment["TMT_PRODUCTION_ROOT"] = str(root)
        # Stream short-lived token only to the release child, never to logs/disk.
        result = subprocess.run([sys.executable, str(destination / "backend/ops/cd/deploy.py")],
                                input=json.dumps(request), text=True, env=environment)
        if result.returncode:
            raise RuntimeError("Deployment failed; inspect private host state before recovery")


if __name__ == "__main__":
    os.umask(0o077)
    if os.environ.get("SSH_ORIGINAL_COMMAND") != "deploy":
        raise SystemExit("This key permits only the deployment receiver; no shell/forwarding")
    if len(sys.argv) != 2:
        raise SystemExit("Production root must be installed by the operator")
    # Bound input before parsing; a complete manifest/request is only a few KiB.
    payload = sys.stdin.buffer.read(65537)
    if len(payload) > 65536:
        raise SystemExit("Deployment request too large")
    try:
        receive(Path(sys.argv[1]).resolve(), json.loads(payload))
    except Exception:
        # Do not leak credentials, subprocess environment, or DB diagnostics.
        raise SystemExit("Deployment rejected or failed; operator recovery may be required")

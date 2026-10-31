"""Restore a completed CD backup into disposable, network-isolated containers.

Never replaces production volumes. Run on the Docker host after a successful
update has produced a complete SQL/blob backup; originals remain untouched.
"""
import json
import os
from pathlib import Path
import secrets
import subprocess
import sys
import time
import uuid

from release import validate_manifest

DOCKER = "/usr/local/bin/docker" if Path("/usr/local/bin/docker").exists() else "docker"
POSTGRES = "postgres:16@sha256:ca0bd484cb98bf4b24eb1010e73fb3fcbd6714d240fbc1a10eea5b7dbecb641d"


def run(*args, **kwargs):
    result = subprocess.run([DOCKER, *args], stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE, **kwargs)
    if result.returncode:
        raise RuntimeError("Disposable restore check failed; diagnostics withheld")
    return result.stdout


def verify(backup):
    record = json.loads((backup / "complete.json").read_text())
    release = validate_manifest(record["previous"])
    if not all((backup / name).is_file() for name in ("database.sql", "blob.tar")):
        raise ValueError("Incomplete backup")
    prefix = "tmt-cd-restore-" + uuid.uuid4().hex[:12]
    database, volume = prefix + "-postgres", prefix + "-blob"
    try:
        run("volume", "create", volume)
        run("run", "-d", "--name", database, "--network", "none",
            "--env", "POSTGRES_USER=tmt_restore", "--env",
            "POSTGRES_PASSWORD=" + secrets.token_hex(32), POSTGRES)
        for attempt in range(60):
            ready = subprocess.run([DOCKER, "exec", database, "pg_isready", "-U", "tmt_restore"],
                                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            if ready.returncode == 0:
                break
            time.sleep(1)
        else:
            raise RuntimeError("Disposable database did not start")
        with (backup / "database.sql").open("rb") as stream:
            run("exec", "-i", database, "psql", "-U", "tmt_restore", "-d", "postgres",
                "-v", "ON_ERROR_STOP=1", stdin=stream)
        schema = run("exec", database, "psql", "-U", "tmt_restore", "-d", "trash", "-Atc",
                     "SELECT version_num FROM alembic_version; SELECT count(*) FROM captures;").decode().splitlines()
        if len(schema) != 2 or not schema[0] or not schema[1].isdigit():
            raise RuntimeError("Application schema/data restore failed")
        prefect = run("exec", database, "psql", "-U", "tmt_restore", "-d", "prefect", "-Atc",
                      "SELECT count(*) FROM information_schema.tables WHERE table_schema='public';").decode().strip()
        if not prefect.isdigit() or int(prefect) < 1:
            raise RuntimeError("Workflow database restore failed")
        # Extract into a new volume, then hash every file against the archive.
        run("run", "--rm", "--network", "none", "--mount",
            "type=bind,src=" + str(backup) + ",dst=/backup,readonly", "--mount",
            "type=volume,src=" + volume + ",dst=/restore", release["images"]["api"],
            "python", "-c",
            "import hashlib,pathlib,tarfile; t=tarfile.open('/backup/blob.tar'); "
            "t.extractall('/restore',filter='data'); "
            "\nfor m in t.getmembers():\n if m.isfile():\n  a=t.extractfile(m); "
            "b=open(pathlib.Path('/restore')/m.name,'rb'); "
            "assert hashlib.file_digest(a,'sha256').digest()==hashlib.file_digest(b,'sha256').digest()")
        print("PASS: application/workflow SQL and all blob bytes restored in isolated disposable containers.")
    finally:
        subprocess.run([DOCKER, "rm", "-f", "-v", database], stdout=subprocess.DEVNULL,
                       stderr=subprocess.DEVNULL)
        subprocess.run([DOCKER, "volume", "rm", volume], stdout=subprocess.DEVNULL,
                       stderr=subprocess.DEVNULL)


if __name__ == "__main__":
    os.umask(0o077)
    if len(sys.argv) != 2:
        raise SystemExit("Usage: verify_restore.py /absolute/path/to/completed/backup")
    verify(Path(sys.argv[1]).resolve())

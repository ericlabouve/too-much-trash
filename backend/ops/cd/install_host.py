"""Operator-only initial installation; stdin contains the dedicated PUBLIC key."""
import os
from pathlib import Path
import re
import shutil
import sys

from init_production import initialize


def install(root, public_key):
    root = root.resolve()
    if re.search(r'[\s"\\]', str(root)):
        raise ValueError("Use a simple absolute production root")
    if not re.fullmatch(r"ssh-ed25519 [A-Za-z0-9+/=]+(?: [A-Za-z0-9_-]+)?", public_key):
        raise ValueError("A dedicated Ed25519 public key is required")
    initialize(root)
    control = root / "control"
    control.mkdir(mode=0o700, exist_ok=True)
    for name in ("receiver.py", "release.py"):
        source = Path(__file__).with_name(name)
        destination = control / name
        if not destination.exists():
            shutil.copyfile(source, destination)
            os.chmod(destination, 0o600)
    ssh = Path.home() / ".ssh"
    ssh.mkdir(mode=0o700, exist_ok=True)
    os.chmod(ssh, 0o700)
    authorized = ssh / "authorized_keys"
    key_body = public_key.split()[1]
    existing = authorized.read_text() if authorized.exists() else ""
    if key_body not in existing:
        backup = control / "authorized_keys.before-tmt"
        if not backup.exists():
            backup.write_text(existing)
            os.chmod(backup, 0o600)
        command = "/usr/bin/python3 " + str(control / "receiver.py") + " " + str(root)
        with authorized.open("a") as stream:
            stream.write(("\n" if existing and not existing.endswith("\n") else "")
                         + 'restrict,command="' + command + '" ' + public_key + "\n")
        os.chmod(authorized, 0o600)
    print("Dedicated forced-command deployment key installed; existing keys preserved.")


if __name__ == "__main__":
    os.umask(0o077)
    install(Path(sys.argv[1]), sys.stdin.read().strip())

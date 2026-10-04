"""Create or rotate a local admin token; only its hash is mounted in the API."""

import argparse
import hashlib
import os
import secrets
from pathlib import Path

directory = Path(__file__).resolve().parents[2] / ".secrets"
token_path = directory / "admin-token"
hash_path = directory / "admin-token.sha256"

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("--rotate", action="store_true", help="replace the existing token and end current sessions")
args = parser.parse_args()

if (token_path.exists() or hash_path.exists()) and not args.rotate:
    parser.error(f"Token already exists at {token_path}; use --rotate to replace it")

directory.mkdir(mode=0o700, exist_ok=True)
os.chmod(directory, 0o700)
token = secrets.token_urlsafe(48)
for path, content in (
    (token_path, token + "\n"),
    (hash_path, hashlib.sha256(token.encode()).hexdigest() + "\n"),
):
    temporary = path.with_suffix(path.suffix + ".tmp")
    descriptor = os.open(temporary, os.O_WRONLY | os.O_CREAT | os.O_TRUNC, 0o600)
    with os.fdopen(descriptor, "w") as stream:
        stream.write(content)
    os.replace(temporary, path)
    os.chmod(path, 0o600)

print(f"Admin token saved to {token_path}")
print("Keep this file private. Paste its contents at the local admin /unlock page.")

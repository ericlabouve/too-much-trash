"""Initialize NEW production secrets without importing/rotating development data."""
import hashlib
import os
from pathlib import Path
import secrets
import sys


def initialize(root):
    root = root.resolve()
    directory = root / "secrets"
    directory.mkdir(parents=True, exist_ok=True, mode=0o700)
    os.chmod(directory, 0o700)
    paths = [directory / name for name in ("production.env", "admin-token", "admin-token.sha256")]
    if any(path.exists() for path in paths):
        if not all(path.is_file() for path in paths):
            raise RuntimeError("Incomplete production secrets; manual recovery required")
        print("Existing production secrets preserved.")
        return
    token = secrets.token_urlsafe(48)
    contents = (
        "POSTGRES_USER=trash\nPOSTGRES_DB=trash\nPOSTGRES_PASSWORD=" + secrets.token_urlsafe(32)
        + "\nS3_ACCESS_KEY=" + secrets.token_hex(16)
        + "\nS3_SECRET_KEY=" + secrets.token_urlsafe(32)
        + "\nS3_BUCKET=captures\nTMT_SECRETS_DIR=" + str(directory) + "\n",
        token + "\n", hashlib.sha256(token.encode()).hexdigest() + "\n",
    )
    for path, content in zip(paths, contents):
        descriptor = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
        with os.fdopen(descriptor, "w") as stream:
            stream.write(content)
    print("Fresh production secrets initialized privately; no invitations created.")


if __name__ == "__main__":
    initialize(Path(sys.argv[1]))

"""Initialize independent local-dev credentials; never read/rotate pilot secrets."""
import hashlib
import os
from pathlib import Path
import secrets

directory = Path(__file__).resolve().parents[2] / ".secrets" / "dev"
paths = [directory / name for name in ("compose.env", "admin-token", "admin-token.sha256")]
if any(path.exists() for path in paths):
    if not all(path.is_file() for path in paths):
        raise SystemExit("Incomplete local-dev credentials; inspect private files before recovery")
    print("Existing local-dev credentials preserved; no rotation performed.")
    raise SystemExit(0)

directory.mkdir(mode=0o700, parents=True, exist_ok=True)
os.chmod(directory, 0o700)
token = secrets.token_urlsafe(48)
contents = (
    "POSTGRES_USER=trash\nPOSTGRES_DB=trash\nPOSTGRES_PASSWORD=" + secrets.token_urlsafe(32)
    + "\nS3_ACCESS_KEY=" + secrets.token_hex(16)
    + "\nS3_SECRET_KEY=" + secrets.token_urlsafe(32)
    + "\nS3_BUCKET=captures-dev\nADMIN_COOKIE_SECURE=false\n",
    token + "\n",
    hashlib.sha256(token.encode()).hexdigest() + "\n",
)
for path, content in zip(paths, contents):
    descriptor = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
    with os.fdopen(descriptor, "w") as stream:
        stream.write(content)
print("Local-dev credentials saved privately under backend/.secrets/dev.")
print("No invites created. Pilot credentials and data were not changed.")

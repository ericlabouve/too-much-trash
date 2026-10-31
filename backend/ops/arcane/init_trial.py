"""Create trial-only credentials privately, without printing or rotating secrets."""
import os
from pathlib import Path
import secrets


def main():
    directory = Path(__file__).resolve().parents[2] / ".secrets" / "arcane-trial"
    directory.mkdir(parents=True, exist_ok=True, mode=0o700)
    os.chmod(directory, 0o700)
    path = directory / "compose.env"
    if path.exists():
        if not path.is_file() or path.is_symlink():
            raise SystemExit("Unsafe credential path; inspect locally before continuing")
        print("Existing Arcane trial credentials preserved.")
        return
    descriptor = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
    with os.fdopen(descriptor, "w") as stream:
        stream.write(f"ARCANE_ENCRYPTION_KEY={secrets.token_hex(32)}\n")
        stream.write(f"ARCANE_ADMIN_PASSWORD=Aa1!{secrets.token_urlsafe(32)}\n")
    print("Arcane trial credentials saved under backend/.secrets/arcane-trial.")


if __name__ == "__main__":
    main()

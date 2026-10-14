"""Check only the localhost Arcane trial; never print credentials or API bodies."""
import json
import os
from pathlib import Path
import secrets
from urllib.error import HTTPError
from urllib.request import Request, urlopen


def main():
    credential_file = Path(__file__).resolve().parents[2] / ".secrets" / "arcane-trial" / "compose.env"
    credentials = dict(line.split("=", 1) for line in credential_file.read_text().splitlines() if "=" in line)
    base = "http://localhost:3552/api"
    session_token = None

    def request(path, body=None, authenticated=True, token=None):
        headers = {"Authorization": "Bearer " + session_token} if authenticated and session_token else {}
        if token:
            headers = {"Authorization": "Bearer " + token}
        if body is not None:
            headers["Content-Type"] = "application/json"
        call = Request(base + path, data=json.dumps(body).encode() if body is not None else None, headers=headers)
        try:
            response = urlopen(call, timeout=15)
        except HTTPError as error:
            response = error
        with response:
            raw = response.read()
            return response.status, json.loads(raw) if raw else None

    # Preserve the existing trial password on repeated checks. Only bootstrap a
    # fresh built-in account that still has the publicly documented default.
    status, login = request("/auth/login", {"username": "arcane", "password": credentials["ARCANE_ADMIN_PASSWORD"]}, False)
    if status != 200:
        status, login = request("/auth/login", {"username": "arcane", "password": "arcane-admin"}, False)
        if status != 200:
            raise SystemExit("Trial login requires operator review; no reset attempted")
        password = credentials["ARCANE_ADMIN_PASSWORD"]
        if not (any(c.isupper() for c in password) and any(c.islower() for c in password)
                and any(c.isdigit() for c in password) and any(not c.isalnum() for c in password)):
            # Only repair the unestablished trial password after proving the
            # built-in account still accepts its public default. Never rotate an
            # existing working password or the encryption/API keys.
            credentials["ARCANE_ADMIN_PASSWORD"] = "Aa1!" + secrets.token_urlsafe(32)
            descriptor = os.open(credential_file, os.O_WRONLY | os.O_TRUNC | os.O_NOFOLLOW)
            with os.fdopen(descriptor, "w") as stream:
                stream.write("".join(f"{key}={value}\n" for key, value in credentials.items()))
        token = login.get("token") or login.get("data", {}).get("token")
        if not token:
            raise SystemExit("No trial login token returned; no reset attempted")
        status, _ = request("/auth/password", {"currentPassword": "arcane-admin", "newPassword": credentials["ARCANE_ADMIN_PASSWORD"]}, token=token)
        if status != 200:
            raise SystemExit(f"Trial password setup failed (HTTP {status}); credentials not printed")
        status, login = request("/auth/login", {"username": "arcane", "password": credentials["ARCANE_ADMIN_PASSWORD"]}, False)
    assert status == 200, "Private trial login failed"
    session_token = login.get("token") or login.get("data", {}).get("token")
    assert session_token, "No private trial session returned"
    print("Private trial login: PASS")
    status, _ = request("/auth/login", {"username": "arcane", "password": "arcane-admin"}, False)
    assert status == 401, "Public default password was not rejected"
    print("Default password rejected: PASS")
    status, body = request("/environments/0/containers")
    assert status == 200, f"Docker inventory failed: HTTP {status}"
    print("Authenticated Docker inventory: PASS")
    status, _ = request("/environments/0/containers", authenticated=False)
    assert status == 401, "Anonymous Docker inventory unexpectedly available"
    print("Anonymous inventory denied: PASS")


if __name__ == "__main__":
    main()

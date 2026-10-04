"""Temporary local admin token exchange and browser session verification."""

import hashlib
import hmac
import os
import secrets
import time
from pathlib import Path

from fastapi import APIRouter, HTTPException, Request, Response
from fastapi.responses import RedirectResponse
from pydantic import BaseModel

router = APIRouter(prefix="/api/v1/admin")
COOKIE = "tmt_admin_session"
LIFETIME_SECONDS = 12 * 60 * 60
HASH_PATH = Path(os.environ.get("ADMIN_TOKEN_HASH_FILE", "/run/secrets/admin-token.sha256"))


class TokenExchange(BaseModel):
    token: str


def token_hash() -> str:
    return HASH_PATH.read_text().strip()


def session_valid(cookie: str | None) -> bool:
    if not cookie:
        return False
    try:
        expiry_text, signature = cookie.split(".", 1)
        expiry = int(expiry_text)
    except (ValueError, TypeError):
        return False
    if expiry < time.time():
        return False
    expected = hmac.new(token_hash().encode(), expiry_text.encode(), hashlib.sha256).hexdigest()
    return secrets.compare_digest(signature, expected)


def require_admin(request: Request) -> None:
    if not session_valid(request.cookies.get(COOKIE)):
        raise HTTPException(401, "Admin session required")


@router.post("/session", status_code=204)
def create_session(payload: TokenExchange, response: Response):
    received = hashlib.sha256(payload.token.encode()).hexdigest()
    if not secrets.compare_digest(received, token_hash()):
        raise HTTPException(401, "Invalid admin token")
    expiry = str(int(time.time()) + LIFETIME_SECONDS)
    signature = hmac.new(token_hash().encode(), expiry.encode(), hashlib.sha256).hexdigest()
    response.set_cookie(
        COOKIE,
        f"{expiry}.{signature}",
        max_age=LIFETIME_SECONDS,
        httponly=True,
        secure=os.environ.get("ADMIN_COOKIE_SECURE", "false").lower() == "true",
        samesite="strict",
        path="/",
    )


@router.delete("/session", status_code=204)
def delete_session(response: Response):
    response.delete_cookie(COOKIE, path="/")


@router.get("/auth/check")
def check_admin(request: Request):
    if not session_valid(request.cookies.get(COOKIE)):
        return RedirectResponse("/unlock", status_code=302)
    return Response(status_code=204)

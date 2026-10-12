"""Invite-only installation access. This is authentication, not app attestation."""

import hashlib
import secrets
import time
from uuid import UUID, uuid4

from fastapi import APIRouter, Depends, HTTPException, Request, Response
from pydantic import BaseModel, Field

from app.admin_auth import require_admin
from app.db import database
from app.invite_words import generate_invite_code, normalize_invite_code

router = APIRouter(prefix="/api/v1")
ACCESS_SECONDS = 900
REFRESH_SECONDS = 2592000
INVITE_GENERATION_ATTEMPTS = 16


def fail(status: int, code: str, message: str, headers=None):
    raise HTTPException(status, {"code": code, "message": message}, headers=headers)


def digest(value: str) -> str:
    return hashlib.sha256(value.encode()).hexdigest()


def throttle(bucket: str, limit: int):
    """Global DB-backed fixed windows; works across API processes, no trusted-IP assumption."""
    window = int(time.time()) // 60
    with database() as connection:
        connection.execute("DELETE FROM auth_rate_limits WHERE window_id < %s", (window - 2,))
        row = connection.execute(
            """INSERT INTO auth_rate_limits(bucket, window_id, attempts) VALUES (%s, %s, 1)
               ON CONFLICT (bucket, window_id) DO UPDATE SET attempts = auth_rate_limits.attempts + 1
               RETURNING attempts""", (bucket, window),
        ).fetchone()
    if row["attempts"] > limit:
        fail(429, "rate_limited", "Try again later", {"Retry-After": str(60 - int(time.time()) % 60)})


def no_store(response: Response):
    response.headers["Cache-Control"] = "no-store"


def require_admin_write(request: Request):
    require_admin(request)
    # Browser cross-origin forms cannot supply this header; CORS is not enabled.
    if request.headers.get("X-TMT-Admin") != "1":
        fail(403, "admin_header_required", "Admin mutation header required")


class InviteCreate(BaseModel):
    label: str = Field(min_length=1, max_length=80)
    expires_in_hours: int = Field(default=24, ge=1, le=168)
    quota_bytes: int = Field(default=1073741824, ge=1, le=107374182400)
    quota_uploads: int = Field(default=100, ge=1, le=10000)


class Enrollment(BaseModel):
    invite_code: str = Field(min_length=1, max_length=256)
    installation_name: str = Field(default="iPhone", min_length=1, max_length=80)


class Refresh(BaseModel):
    refresh_token: str = Field(min_length=1, max_length=256)


def mint_access(connection, installation_id):
    token = secrets.token_urlsafe(32)
    connection.execute("DELETE FROM access_tokens WHERE expires_at <= now()")
    connection.execute(
        "INSERT INTO access_tokens VALUES (%s, %s, now() + %s * interval '1 second')",
        (digest(token), installation_id, ACCESS_SECONDS),
    )
    return {"access_token": token, "token_type": "Bearer", "expires_in": ACCESS_SECONDS}


@router.post("/admin/invites", status_code=201, dependencies=[Depends(require_admin_write)])
def create_invite(payload: InviteCreate, response: Response):
    no_store(response)
    with database() as connection:
        for _ in range(INVITE_GENERATION_ATTEMPTS):
            code = generate_invite_code()
            row = connection.execute(
                """INSERT INTO invitations(id, code_hash, label, expires_at, quota_bytes, quota_uploads)
                   VALUES (%s, %s, %s, now() + %s * interval '1 hour', %s, %s)
                   ON CONFLICT (code_hash) DO NOTHING
                   RETURNING id, label, expires_at, quota_bytes, quota_uploads""",
                (uuid4(), digest(code), payload.label, payload.expires_in_hours,
                 payload.quota_bytes, payload.quota_uploads),
            ).fetchone()
            if row:
                return {**row, "invite_code": code}
    fail(503, "invite_generation_unavailable", "Could not allocate unique invite words; try again later")


@router.get("/admin/invites", dependencies=[Depends(require_admin)])
def list_invites(response: Response):
    no_store(response)
    with database() as connection:
        return connection.execute(
            """SELECT id, label, expires_at, quota_bytes, quota_uploads, created_at,
               redeemed_at, revoked_at FROM invitations ORDER BY created_at DESC LIMIT 200"""
        ).fetchall()


@router.post("/admin/invites/{invite_id}/revoke", status_code=204,
             dependencies=[Depends(require_admin_write)])
def revoke_invite(invite_id: UUID):
    with database() as connection:
        row = connection.execute(
            "UPDATE invitations SET revoked_at = COALESCE(revoked_at, now()) WHERE id = %s RETURNING id",
            (invite_id,),
        ).fetchone()
    if not row:
        fail(404, "invite_not_found", "Invitation not found")


@router.get("/admin/installations", dependencies=[Depends(require_admin)])
def list_installations(response: Response):
    no_store(response)
    with database() as connection:
        return connection.execute(
            """SELECT id, invitation_id, installation_name, created_at, revoked_at,
               refresh_expires_at, quota_bytes, quota_uploads, used_bytes, used_uploads
               FROM installations ORDER BY created_at DESC LIMIT 200"""
        ).fetchall()


@router.post("/admin/installations/{installation_id}/revoke", status_code=204,
             dependencies=[Depends(require_admin_write)])
def revoke_installation(installation_id: UUID):
    with database() as connection:
        row = connection.execute(
            "UPDATE installations SET revoked_at = COALESCE(revoked_at, now()) WHERE id = %s RETURNING id",
            (installation_id,),
        ).fetchone()
    if not row:
        fail(404, "installation_not_found", "Installation not found")


@router.post("/auth/enroll", status_code=201)
def enroll(payload: Enrollment, response: Response):
    no_store(response)
    code = normalize_invite_code(payload.invite_code)
    if code is None:
        fail(400, "invite_invalid", "Invite is invalid or no longer available")
    installation_id, refresh = uuid4(), secrets.token_urlsafe(32)
    with database() as connection:
        invite = connection.execute(
            """UPDATE invitations SET redeemed_at = now()
               WHERE code_hash = %s AND expires_at > now() AND revoked_at IS NULL
               AND redeemed_at IS NULL RETURNING id, quota_bytes, quota_uploads""",
            (digest(code),),
        ).fetchone()
        if not invite:
            fail(400, "invite_invalid", "Invite is invalid or no longer available")
        connection.execute(
            """INSERT INTO installations(id, invitation_id, installation_name, refresh_hash,
               refresh_expires_at, quota_bytes, quota_uploads)
               VALUES (%s, %s, %s, %s, now() + %s * interval '1 second', %s, %s)""",
            (installation_id, invite["id"], payload.installation_name, digest(refresh),
             REFRESH_SECONDS, invite["quota_bytes"], invite["quota_uploads"]),
        )
        access = mint_access(connection, installation_id)
    return {**access, "installation_id": installation_id, "refresh_token": refresh,
            "refresh_expires_in": REFRESH_SECONDS}


@router.post("/auth/token")
def refresh_access(payload: Refresh, response: Response):
    throttle("refresh", 120)
    no_store(response)
    with database() as connection:
        row = connection.execute(
            "SELECT id, revoked_at, refresh_expires_at > now() AS valid FROM installations WHERE refresh_hash = %s FOR UPDATE",
            (digest(payload.refresh_token),),
        ).fetchone()
        if row and row["revoked_at"]:
            fail(401, "access_revoked", "Installation access has been revoked")
        if not row or not row["valid"]:
            fail(401, "refresh_invalid", "Refresh credential is invalid or expired")
        return mint_access(connection, row["id"])


@router.post("/auth/end-session")
def end_session(payload: Refresh, response: Response):
    no_store(response)
    # Possession of this installation's strong secret authenticates ONLY
    # revocation. Keep recognizing it after expiry/revocation for lost-response
    # retries; this endpoint never grants access or needs an admin session.
    with database() as connection:
        row = connection.execute(
            """UPDATE installations SET revoked_at=COALESCE(revoked_at,now())
               WHERE refresh_hash=%s RETURNING id""", (digest(payload.refresh_token),),
        ).fetchone()
        if not row:
            fail(401, "refresh_invalid", "Session credential is invalid")
    return {"installation_id": str(row["id"]), "revoked": True}


def require_installation(request: Request):
    scheme, _, token = request.headers.get("Authorization", "").partition(" ")
    if scheme.lower() != "bearer" or not token or len(token) > 256:
        fail(401, "access_invalid", "Bearer access credential required")
    with database() as connection:
        row = connection.execute(
            """SELECT i.*, t.expires_at > now() AS access_valid FROM access_tokens t
               JOIN installations i ON i.id = t.installation_id WHERE t.token_hash = %s""",
            (digest(token),),
        ).fetchone()
    if row and row["revoked_at"]:
        fail(401, "access_revoked", "Installation access has been revoked")
    if not row or not row["access_valid"]:
        fail(401, "access_invalid", "Access credential is invalid or expired")
    return row


@router.get("/auth/me")
def me(response: Response, installation=Depends(require_installation)):
    no_store(response)
    return {"installation_id": installation["id"], "media_contract_version": 1, **{
        key: installation[key] for key in
        ("installation_name", "quota_bytes", "quota_uploads", "used_bytes", "used_uploads")}}


@router.get("/admin/reachability")
def reachability(response: Response):
    # Caddy exposes this ONLY on the private admin listener, never the public API.
    no_store(response)
    return {"service": "too-much-trash-admin", "version": 1}

"""Client-facing upload, job status, and asset download API."""

import os
import asyncio
import logging
import hashlib
import json
import math
import tempfile
from contextlib import ExitStack
from pathlib import Path
from uuid import UUID, uuid4, uuid5, NAMESPACE_URL

import boto3
from fastapi import Depends, FastAPI, File, Header, HTTPException, Request, UploadFile
from fastapi.responses import JSONResponse, StreamingResponse
from starlette.concurrency import run_in_threadpool

from app.admin_auth import router as admin_router
from app.db import database
from app.enrollment_limit import require_enrollment_permit
from app.onboarding import fail, require_installation, router as onboarding_router
from app.episode_transfer import check_quota, router as episode_transfer_router, sweep_expired

app = FastAPI(title="Too Much Trash API", version="0.2.0")
app.include_router(admin_router)
app.include_router(onboarding_router)
app.include_router(episode_transfer_router)
BUCKET = os.environ["S3_BUCKET"]
MAX_UPLOAD_BYTES = 200 * 1024 * 1024
MEDIA_TYPES = {
    "image/jpeg": "image",
    "image/png": "image",
    "image/webp": "image",
    "image/heic": "image",
    "video/mp4": "video",
    "video/quicktime": "video",
    "video/webm": "video",
}


@app.on_event("startup")
async def start_transfer_sweeper():
    async def run():
        while True:
            try:
                await run_in_threadpool(sweep_expired)
            except Exception:
                logging.getLogger(__name__).exception("Resumable transfer cleanup failed; it will be retried")
            await asyncio.sleep(3600)
    app.state.transfer_sweeper = asyncio.create_task(run())


@app.on_event("shutdown")
async def stop_transfer_sweeper():
    task = getattr(app.state, "transfer_sweeper", None)
    if task:
        task.cancel()


def storage():
    return boto3.client(
        "s3",
        endpoint_url=os.environ["S3_ENDPOINT_URL"],
        aws_access_key_id=os.environ["S3_ACCESS_KEY"],
        aws_secret_access_key=os.environ["S3_SECRET_KEY"],
        region_name="us-east-1",
    )


@app.middleware("http")
async def guard_sensitive_body(request: Request, call_next):
    # Count admitted enrollment POSTs before JSON/Pydantic validation.
    if request.method == "POST" and request.url.path == "/api/v1/auth/enroll":
        try:
            await run_in_threadpool(require_enrollment_permit)
        except HTTPException as exc:
            return JSONResponse({"detail": exc.detail}, status_code=exc.status_code,
                                headers={**(exc.headers or {}), "Cache-Control": "no-store"})
    if request.method == "POST" and request.url.path.startswith("/api/v1/episodes/") and request.url.path.endswith("/transfer"):
        # Authentication and an explicit small limit precede JSON parsing.
        try:
            request.state.installation = await run_in_threadpool(require_installation, request)
        except HTTPException as exc:
            return JSONResponse({"detail": exc.detail}, status_code=exc.status_code, headers={**(exc.headers or {}), "Cache-Control": "no-store"})
        length = request.headers.get("Content-Length", "")
        if not length.isdigit() or int(length) > 8192 or request.headers.get("Transfer-Encoding"):
            return JSONResponse({"detail": {"code": "upload_too_large", "message": "Transfer metadata exceeds request limit"}}, status_code=413, headers={"Cache-Control": "no-store"})
    # Reject unauthorized uploads before FastAPI parses/spools multipart content.
    if request.method == "POST" and request.url.path in ("/api/v1/media", "/api/v1/episodes"):
        try:
            request.state.installation = await run_in_threadpool(require_installation, request)
        except HTTPException as exc:
            return JSONResponse({"detail": exc.detail}, status_code=exc.status_code, headers={**(exc.headers or {}), "Cache-Control": "no-store"})
        length = request.headers.get("Content-Length")
        if length and (not length.isdigit() or int(length) > MAX_UPLOAD_BYTES + 1024 * 1024):
            return JSONResponse({"detail": {"code": "upload_too_large", "message": "Upload exceeds request limit"}}, status_code=413, headers={"Cache-Control": "no-store"})
    response = await call_next(request)
    if request.url.path.startswith("/api/"):
        response.headers["Cache-Control"] = "no-store"
    return response


@app.get("/api/v1/health")
def health() -> dict[str, str]:
    return {"status": "ok"}


@app.post("/api/v1/media", status_code=202)
def upload_media(file: UploadFile = File(...), installation=Depends(require_installation),
                 idempotency_key: UUID | None = Header(default=None)):
    content_type = (file.content_type or "").lower()
    kind = MEDIA_TYPES.get(content_type)
    if kind is None:
        fail(415, "media_type_unsupported", "Supported types: JPEG, PNG, WebP, HEIC, MP4, MOV, WebM")

    capture_id = keyed_capture_id(installation["id"], idempotency_key) if idempotency_key else uuid4()
    filename = Path(file.filename or "upload").name
    key = f"originals/{capture_id}"
    size = 0
    fingerprint = hashlib.sha256()
    with tempfile.TemporaryFile() as staged:
        while chunk := file.file.read(1024 * 1024):
            size += len(chunk)
            if size > MAX_UPLOAD_BYTES:
                fail(413, "upload_too_large", "Upload exceeds 200 MiB")
            staged.write(chunk)
            fingerprint.update(chunk)
        if size == 0:
            fail(400, "upload_empty", "Upload is empty")
        staged.seek(0)
        if idempotency_key:
            # Existing object-key column carries immutable client/fingerprint
            # metadata; original_key remains opaque to clients and workers.
            key = f"originals/{capture_id}/client-{idempotency_key}/sha256-{fingerprint.hexdigest()}"
        client = storage()
        uploaded = False
        try:
            with database() as connection:
                # Lock the owner for quota checks, reservation, and revocation ordering.
                owner = connection.execute("SELECT * FROM installations WHERE id = %s FOR UPDATE", (installation["id"],)).fetchone()
                if owner["revoked_at"]:
                    fail(401, "access_revoked", "Installation access has been revoked")
                if idempotency_key:
                    existing = connection.execute("SELECT * FROM captures WHERE id=%s AND installation_id=%s", (capture_id, owner["id"])).fetchone()
                    if existing:
                        if (existing["original_key"] != key or existing["size_bytes"] != size
                                or existing["content_type"] != content_type or existing["filename"] != filename):
                            fail(409, "idempotency_conflict", "Capture key was already accepted with different content")
                        return receipt_from_row(existing)
                check_quota(connection, owner, size)
                client.upload_fileobj(staged, BUCKET, key, ExtraArgs={"ContentType": content_type})
                uploaded = True
                connection.execute(
                    """INSERT INTO captures (id, filename, content_type, media_kind, original_key, size_bytes, installation_id)
                       VALUES (%s, %s, %s, %s, %s, %s, %s)""",
                    (capture_id, filename, content_type, kind, key, size, installation["id"]),
                )
                connection.execute("UPDATE installations SET used_bytes = used_bytes + %s, used_uploads = used_uploads + 1 WHERE id = %s", (size, installation["id"]))
        except Exception:
            # A keyed request may have committed despite a lost DB response, or
            # a concurrent retry may now own this same object. Never delete its
            # deterministic key as compensation; reconcile via receipt lookup.
            if uploaded and not idempotency_key:
                client.delete_object(Bucket=BUCKET, Key=key)
            raise
    return capture_response(capture_id, installation["id"])


def keyed_capture_id(installation_id: UUID, client_capture_id: UUID) -> UUID:
    # Frozen namespace mapping; IDs are opaque identifiers, not credentials.
    return uuid5(NAMESPACE_URL, f"too-much-trash:capture:{installation_id}:{client_capture_id}")


EPISODE_FILES = {"video": ("video.mp4", "video/mp4"), "imu": ("imu.jsonl", "application/x-ndjson"),
                 "poses": ("poses.jsonl", "application/x-ndjson"), "manifest": ("manifest.json", "application/json")}


def validate_episode_manifest(raw: bytes, client_id: UUID):
    try:
        data = json.loads(raw)
        if not isinstance(data, dict) or data.get("schema_version") != 1 or UUID(data["episode_id"]) != client_id:
            raise ValueError()
        timing = data["timing"]
        start, press, end = (timing[key] for key in ("start", "press", "end"))
        release = timing.get("release")
        if not all(isinstance(x, (int, float)) and not isinstance(x, bool) and math.isfinite(x) for x in (start, press, end)):
            raise ValueError()
        if not start <= press <= end:
            raise ValueError()
        if release is not None and (not isinstance(release, (int, float)) or isinstance(release, bool) or not math.isfinite(release) or not press <= release <= end):
            raise ValueError()
        if data.get("complete") is True and (release is None or press - start < 3 or end - release < 3):
            raise ValueError()
        if not isinstance(data.get("complete"), bool) or not isinstance(data.get("sensor_metadata"), dict):
            raise ValueError()
        if data.get("files") != {name: item[0] for name, item in EPISODE_FILES.items() if name != "manifest"}:
            raise ValueError()
    except (ValueError, KeyError, TypeError, json.JSONDecodeError, AttributeError):
        fail(400, "episode_manifest_invalid", "Invalid episode manifest")


@app.post("/api/v1/episodes", status_code=202)
def upload_episode(video: UploadFile = File(...), imu: UploadFile = File(...), poses: UploadFile = File(...),
                   manifest: UploadFile = File(...), installation=Depends(require_installation),
                   idempotency_key: UUID = Header(...)):
    """Atomically publish four immutable files under one installation and quota."""
    sources = {"video": video, "imu": imu, "poses": poses, "manifest": manifest}
    if any((sources[name].content_type or "").lower() != kind for name, (_, kind) in EPISODE_FILES.items()):
        fail(415, "episode_type_invalid", "Invalid episode file content type")
    capture_id = keyed_capture_id(installation["id"], idempotency_key)
    digest = hashlib.sha256()
    total = 0
    with ExitStack() as stack:
        staged = {}
        for name in EPISODE_FILES:
            target = stack.enter_context(tempfile.TemporaryFile())
            staged[name] = target
            part_digest = hashlib.sha256()
            part_size = 0
            while chunk := sources[name].file.read(1024 * 1024):
                total += len(chunk)
                part_size += len(chunk)
                if total > MAX_UPLOAD_BYTES:
                    fail(413, "upload_too_large", "Episode exceeds 200 MiB")
                target.write(chunk)
                part_digest.update(chunk)
            if part_size == 0:
                fail(400, "upload_empty", "An episode file is empty")
            digest.update(name.encode() + b"\0" + str(part_size).encode() + b"\0" + part_digest.digest())
            target.seek(0)
        if staged["manifest"].seek(0, 2) > 1024 * 1024:
            fail(413, "episode_manifest_too_large", "Manifest exceeds 1 MiB")
        staged["manifest"].seek(0)
        validate_episode_manifest(staged["manifest"].read(), idempotency_key)
        staged["manifest"].seek(0)
        checksum = digest.hexdigest()
        original_key = f"originals/{capture_id}/client-{idempotency_key}/episode-{checksum}"
        prefix = f"episodes/{capture_id}/{checksum}"
        client = storage()
        with database() as connection:
            owner = connection.execute("SELECT * FROM installations WHERE id=%s FOR UPDATE", (installation["id"],)).fetchone()
            if not owner or owner["revoked_at"]:
                fail(401, "access_revoked", "Installation access has been revoked")
            existing = connection.execute("SELECT * FROM captures WHERE id=%s AND installation_id=%s", (capture_id, owner["id"])).fetchone()
            if existing:
                if existing["original_key"] != original_key or existing["size_bytes"] != total:
                    fail(409, "idempotency_conflict", "Episode key was already accepted with different content")
                return receipt_from_row(existing)
            check_quota(connection, owner, total)
            for name, (filename, content_type) in EPISODE_FILES.items():
                key = original_key if name == "video" else f"{prefix}/{filename}"
                client.upload_fileobj(staged[name], BUCKET, key, ExtraArgs={"ContentType": content_type})
            connection.execute("""INSERT INTO captures (id, filename, content_type, media_kind, original_key, size_bytes, installation_id)
                VALUES (%s,%s,'video/mp4','video',%s,%s,%s)""", (capture_id, "video.mp4", original_key, total, owner["id"]))
            connection.execute("UPDATE installations SET used_bytes=used_bytes+%s, used_uploads=used_uploads+1 WHERE id=%s", (total, owner["id"]))
    return capture_response(capture_id, installation["id"])


@app.get("/api/v1/episodes/{client_episode_id}/files/{name}")
def download_episode_file(client_episode_id: UUID, name: str, installation=Depends(require_installation)):
    if name not in EPISODE_FILES:
        fail(404, "media_not_found", "Episode file not found")
    capture_id = keyed_capture_id(installation["id"], client_episode_id)
    with database() as connection:
        row = connection.execute("SELECT original_key FROM captures WHERE id=%s AND installation_id=%s", (capture_id, installation["id"])).fetchone()
    prefix = f"originals/{capture_id}/client-{client_episode_id}/episode-"
    if not row or not row["original_key"].startswith(prefix):
        fail(404, "media_not_found", "Episode file not found")
    checksum = row["original_key"][len(prefix):]
    if len(checksum) != 64 or any(ch not in "0123456789abcdef" for ch in checksum):
        fail(404, "media_not_found", "Episode file not found")
    filename, content_type = EPISODE_FILES[name]
    key = row["original_key"] if name == "video" else f"episodes/{capture_id}/{checksum}/{filename}"
    body = storage().get_object(Bucket=BUCKET, Key=key)["Body"]
    def chunks():
        try:
            yield from body.iter_chunks(chunk_size=1024 * 1024)
        finally:
            body.close()
    return StreamingResponse(chunks(), media_type=content_type)


def capture_response(capture_id: UUID, installation_id: UUID):
    with database() as connection:
        row = connection.execute("SELECT * FROM captures WHERE id = %s AND installation_id = %s", (capture_id, installation_id)).fetchone()
    if row is None:
        fail(404, "media_not_found", "Media capture not found")
    return receipt_from_row(row)


def receipt_from_row(row):
    capture_id = row["id"]
    parts = row["original_key"].split("/")
    client_id = str(UUID(parts[2][7:])) if len(parts) == 4 and parts[2].startswith("client-") else None
    base = f"/api/v1/media/{capture_id}"
    return {
        "id": str(capture_id),
        "client_capture_id": client_id,
        "status": row["status"],
        "filename": row["filename"],
        "content_type": row["content_type"],
        "size_bytes": row["size_bytes"],
        "result": row["result"],
        "error": row["error"],
        "status_url": base,
        "original_url": f"{base}/original",
        "processed_url": f"{base}/processed" if row["processed_key"] else None,
        "episode_bundle_sha256": parts[3][8:] if len(parts) == 4 and parts[3].startswith("episode-") else None,
    }


@app.get("/api/v1/media/by-client/{client_capture_id}")
def get_media_by_client(client_capture_id: UUID, installation=Depends(require_installation)):
    return capture_response(keyed_capture_id(installation["id"], client_capture_id), installation["id"])


@app.get("/api/v1/media/{capture_id}")
def get_media(capture_id: UUID, installation=Depends(require_installation)):
    return capture_response(capture_id, installation["id"])


@app.get("/api/v1/media/{capture_id}/{variant}")
def download_media(capture_id: UUID, variant: str, installation=Depends(require_installation)):
    if variant not in ("original", "processed"):
        fail(404, "media_not_found", "Media capture not found")
    with database() as connection:
        row = connection.execute(
            "SELECT original_key, content_type, processed_key, processed_content_type FROM captures WHERE id = %s AND installation_id = %s",
            (capture_id, installation["id"]),
        ).fetchone()
    if row is None:
        fail(404, "media_not_found", "Media capture not found")
    key = row["original_key"] if variant == "original" else row["processed_key"]
    if key is None:
        fail(404, "media_not_ready", "Processed asset is not ready")
    content_type = row["content_type"] if variant == "original" else row["processed_content_type"]
    body = storage().get_object(Bucket=BUCKET, Key=key)["Body"]

    def chunks():
        try:
            yield from body.iter_chunks(chunk_size=1024 * 1024)
        finally:
            body.close()

    return StreamingResponse(chunks(), media_type=content_type)

"""Client-facing upload, job status, and asset download API."""

import os
import tempfile
from pathlib import Path
from uuid import UUID, uuid4

import boto3
from fastapi import Depends, FastAPI, File, HTTPException, Request, UploadFile
from fastapi.responses import JSONResponse, StreamingResponse
from starlette.concurrency import run_in_threadpool

from app.admin_auth import router as admin_router
from app.db import database
from app.onboarding import fail, require_installation, router as onboarding_router

app = FastAPI(title="Too Much Trash API", version="0.2.0")
app.include_router(admin_router)
app.include_router(onboarding_router)
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


def storage():
    return boto3.client(
        "s3",
        endpoint_url=os.environ["S3_ENDPOINT_URL"],
        aws_access_key_id=os.environ["S3_ACCESS_KEY"],
        aws_secret_access_key=os.environ["S3_SECRET_KEY"],
        region_name="us-east-1",
    )


@app.middleware("http")
async def guard_media_body(request: Request, call_next):
    # Reject unauthorized uploads before FastAPI parses/spools multipart content.
    if request.method == "POST" and request.url.path == "/api/v1/media":
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
def upload_media(file: UploadFile = File(...), installation=Depends(require_installation)):
    content_type = (file.content_type or "").lower()
    kind = MEDIA_TYPES.get(content_type)
    if kind is None:
        fail(415, "media_type_unsupported", "Supported types: JPEG, PNG, WebP, HEIC, MP4, MOV, WebM")

    capture_id = uuid4()
    filename = Path(file.filename or "upload").name
    key = f"originals/{capture_id}"
    size = 0
    with tempfile.TemporaryFile() as staged:
        while chunk := file.file.read(1024 * 1024):
            size += len(chunk)
            if size > MAX_UPLOAD_BYTES:
                fail(413, "upload_too_large", "Upload exceeds 200 MiB")
            staged.write(chunk)
        if size == 0:
            fail(400, "upload_empty", "Upload is empty")
        staged.seek(0)
        client = storage()
        uploaded = False
        try:
            with database() as connection:
                # Lock the owner for quota checks, reservation, and revocation ordering.
                owner = connection.execute("SELECT * FROM installations WHERE id = %s FOR UPDATE", (installation["id"],)).fetchone()
                if owner["revoked_at"]:
                    fail(401, "access_revoked", "Installation access has been revoked")
                if owner["used_bytes"] + size > owner["quota_bytes"] or owner["used_uploads"] >= owner["quota_uploads"]:
                    fail(429, "quota_exceeded", "Installation upload quota reached")
                client.upload_fileobj(staged, BUCKET, key, ExtraArgs={"ContentType": content_type})
                uploaded = True
                connection.execute(
                    """INSERT INTO captures (id, filename, content_type, media_kind, original_key, size_bytes, installation_id)
                       VALUES (%s, %s, %s, %s, %s, %s, %s)""",
                    (capture_id, filename, content_type, kind, key, size, installation["id"]),
                )
                connection.execute("UPDATE installations SET used_bytes = used_bytes + %s, used_uploads = used_uploads + 1 WHERE id = %s", (size, installation["id"]))
        except Exception:
            if uploaded:
                client.delete_object(Bucket=BUCKET, Key=key)
            raise
    return capture_response(capture_id, installation["id"])


def capture_response(capture_id: UUID, installation_id: UUID):
    with database() as connection:
        row = connection.execute("SELECT * FROM captures WHERE id = %s AND installation_id = %s", (capture_id, installation_id)).fetchone()
    if row is None:
        fail(404, "media_not_found", "Media capture not found")
    base = f"/api/v1/media/{capture_id}"
    return {
        "id": str(capture_id),
        "status": row["status"],
        "filename": row["filename"],
        "content_type": row["content_type"],
        "size_bytes": row["size_bytes"],
        "result": row["result"],
        "error": row["error"],
        "status_url": base,
        "original_url": f"{base}/original",
        "processed_url": f"{base}/processed" if row["processed_key"] else None,
    }


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

"""Client-facing upload, job status, and asset download API."""

import os
import tempfile
from contextlib import contextmanager
from pathlib import Path
from uuid import UUID, uuid4

import boto3
import psycopg
from fastapi import FastAPI, File, HTTPException, UploadFile
from fastapi.responses import StreamingResponse
from psycopg.rows import dict_row

app = FastAPI(title="Too Much Trash API", version="0.2.0")
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


@contextmanager
def database():
    with psycopg.connect(os.environ["DATABASE_URL"], row_factory=dict_row) as connection:
        yield connection


@app.get("/api/v1/health")
def health() -> dict[str, str]:
    return {"status": "ok"}


@app.post("/api/v1/media", status_code=202)
def upload_media(file: UploadFile = File(...)):
    content_type = (file.content_type or "").lower()
    kind = MEDIA_TYPES.get(content_type)
    if kind is None:
        raise HTTPException(415, "Supported types: JPEG, PNG, WebP, HEIC, MP4, MOV, WebM")

    capture_id = uuid4()
    filename = Path(file.filename or "upload").name
    key = f"originals/{capture_id}"
    size = 0
    with tempfile.TemporaryFile() as staged:
        while chunk := file.file.read(1024 * 1024):
            size += len(chunk)
            if size > MAX_UPLOAD_BYTES:
                raise HTTPException(413, "Upload exceeds 200 MiB")
            staged.write(chunk)
        if size == 0:
            raise HTTPException(400, "Upload is empty")
        staged.seek(0)
        client = storage()
        client.upload_fileobj(staged, BUCKET, key, ExtraArgs={"ContentType": content_type})

    try:
        with database() as connection:
            connection.execute(
                """INSERT INTO captures (id, filename, content_type, media_kind, original_key, size_bytes)
                   VALUES (%s, %s, %s, %s, %s, %s)""",
                (capture_id, filename, content_type, kind, key, size),
            )
    except Exception:
        client.delete_object(Bucket=BUCKET, Key=key)
        raise
    return capture_response(capture_id)


def capture_response(capture_id: UUID):
    with database() as connection:
        row = connection.execute("SELECT * FROM captures WHERE id = %s", (capture_id,)).fetchone()
    if row is None:
        raise HTTPException(404, "Media capture not found")
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
def get_media(capture_id: UUID):
    return capture_response(capture_id)


@app.get("/api/v1/media/{capture_id}/{variant}")
def download_media(capture_id: UUID, variant: str):
    if variant not in ("original", "processed"):
        raise HTTPException(404, "Unknown asset variant")
    with database() as connection:
        row = connection.execute(
            "SELECT original_key, content_type, processed_key, processed_content_type FROM captures WHERE id = %s",
            (capture_id,),
        ).fetchone()
    if row is None:
        raise HTTPException(404, "Media capture not found")
    key = row["original_key"] if variant == "original" else row["processed_key"]
    if key is None:
        raise HTTPException(404, "Processed asset is not ready")
    content_type = row["content_type"] if variant == "original" else row["processed_content_type"]
    body = storage().get_object(Bucket=BUCKET, Key=key)["Body"]

    def chunks():
        try:
            yield from body.iter_chunks(chunk_size=1024 * 1024)
        finally:
            body.close()

    return StreamingResponse(chunks(), media_type=content_type)

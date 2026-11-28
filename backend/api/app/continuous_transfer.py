"""Resumable immutable full-session bundles; no pickup-event interpretation."""
import hashlib
import io
import json
import logging
import math
import re
import tempfile
from uuid import UUID
from fastapi import APIRouter, Depends, Request
from pydantic import BaseModel, ConfigDict, Field
from psycopg.types.json import Jsonb
from starlette.concurrency import run_in_threadpool
from app.db import database
from app.onboarding import fail, require_installation, require_development_keys
from app.episode_transfer import FileInfo, owner_locked, check_quota

router = APIRouter(prefix="/api/v1/continuous", tags=["full recordings"])
CHUNK_SIZE = 4 * 1024 * 1024
STREAMS = {"imu.jsonl", "poses.jsonl", "references.jsonl", "predictions.jsonl", "diagnostics.jsonl"}

class FileDescriptor(FileInfo):
    size: int = Field(ge=0, le=512 * 1024 * 1024, strict=True)

class Bundle(BaseModel):
    model_config = ConfigDict(extra="forbid")
    files: dict[str, FileDescriptor] = Field(min_length=7, max_length=50000)

def validate_files(files):
    if not {"session.json", *STREAMS} < set(files) or any(
        n not in {"session.json", *STREAMS} and not re.fullmatch(r"[a-zA-Z0-9_-]{1,100}\.mp4", n) for n in files
    ) or files["session.json"]["size"] > 16 * 1024 * 1024 or not files["session.json"]["size"]:
        fail(400, "continuous_files_invalid", "Invalid full recording files")
    total = sum(f["size"] for f in files.values())
    if total > 64 * 1024**3:
        fail(413, "upload_too_large", "Full recording exceeds upload limit")
    return total

def digest(files):
    h = hashlib.sha256()
    for name in sorted(files):
        f = files[name]
        h.update(name.encode() + b"\0" + str(f["size"]).encode() + b"\0" + bytes.fromhex(f["sha256"]))
    return h.hexdigest()

def key(owner, recording, name, index):
    return f"continuous/{owner}/{recording}/{name}/chunks/{index:08d}"

def reject_deleted(c, owner, recording):
    if c.execute("SELECT 1 FROM continuous_deletions WHERE installation_id=%s AND recording_id=%s", (owner, recording)).fetchone():
        fail(409, "capture_deleted", "Full recording was deleted")

def row_locked(c, owner, recording):
    reject_deleted(c, owner, recording)
    row = c.execute("SELECT * FROM continuous_recordings WHERE installation_id=%s AND id=%s FOR UPDATE", (owner, recording)).fetchone()
    if not row: fail(404, "transfer_not_found", "Full recording not found")
    return row

def receipt(row):
    return {"recording_id": row["id"], "bundle_sha256": row["bundle_sha256"], "size_bytes": row["total_size"], "complete": row["complete"]}

@router.post("/{recording}/transfer")
def begin(recording: UUID, body: Bundle, installation=Depends(require_installation)):
    files = {n: v.model_dump() for n, v in body.files.items()}
    total = validate_files(files)
    with database() as c:
        owner = owner_locked(c, installation)
        reject_deleted(c, owner["id"], recording)
        row = c.execute("SELECT * FROM continuous_recordings WHERE installation_id=%s AND id=%s FOR UPDATE", (owner["id"], recording)).fetchone()
        if row and row["files"] != files:
            fail(409, "idempotency_conflict", "Recording ID already used for different bytes")
        if not row:
            check_quota(c, owner, total)
            c.execute("INSERT INTO continuous_recordings(installation_id,id,files,total_size,bundle_sha256) VALUES(%s,%s,%s,%s,%s)", (owner["id"], recording, Jsonb(files), total, digest(files)))
            row = row_locked(c, owner["id"], recording)
        if not row["complete"]:
            c.execute("UPDATE continuous_recordings SET expires_at=now()+interval '7 days' WHERE installation_id=%s AND id=%s", (owner["id"], recording))
        chunks = {n: [] for n in files}
        for chunk in c.execute("SELECT file_name,chunk_index FROM continuous_chunks WHERE installation_id=%s AND recording_id=%s", (owner["id"], recording)).fetchall():
            chunks[chunk["file_name"]].append(chunk["chunk_index"])
        return {**receipt(row), "chunk_size": CHUNK_SIZE, "chunks": chunks}

def store(installation, recording, name, index, data):
    from app.main import storage, BUCKET
    with database() as c:
        owner = owner_locked(c, installation)
        row = row_locked(c, owner["id"], recording)
        f = row["files"].get(name)
        if not f or index < 0 or index >= math.ceil(f["size"] / CHUNK_SIZE) or len(data) != min(CHUNK_SIZE, f["size"] - index * CHUNK_SIZE):
            fail(400, "chunk_invalid", "Invalid chunk")
        old = c.execute("SELECT * FROM continuous_chunks WHERE installation_id=%s AND recording_id=%s AND file_name=%s AND chunk_index=%s", (owner["id"], recording, name, index)).fetchone()
        sha = hashlib.sha256(data).hexdigest()
        if old:
            if old["sha256"] != sha: fail(409, "idempotency_conflict", "Chunk bytes differ")
            return {"accepted": True}
        if row["complete"]: fail(409, "idempotency_conflict", "Recording is immutable")
        storage().upload_fileobj(io.BytesIO(data), BUCKET, key(owner["id"], recording, name, index))
        c.execute("UPDATE continuous_recordings SET expires_at=now()+interval '7 days' WHERE installation_id=%s AND id=%s", (owner["id"], recording))
        c.execute("INSERT INTO continuous_chunks VALUES(%s,%s,%s,%s,%s,%s)", (owner["id"], recording, name, index, sha, len(data)))
    return {"accepted": True}

@router.put("/{recording}/transfer/{name}/{index}")
async def chunk(recording: UUID, name: str, index: int, request: Request, installation=Depends(require_installation)):
    if request.headers.get("content-type") != "application/octet-stream": fail(415, "media_type_unsupported", "Expected binary chunk")
    data = bytearray()
    async for part in request.stream():
        if len(data) + len(part) > CHUNK_SIZE: fail(413, "upload_too_large", "Chunk exceeds limit")
        data.extend(part)
    return await run_in_threadpool(store, installation, recording, name, index, bytes(data))

def validate_manifest(data, recording, files):
    try:
        m = json.loads(data)
        expected = {p["file"] for p in m["video_parts"]} | set(m["streams"].values()) | {"session.json"}
        valid = (m["schema"] == "tmt-continuous-session-v1" and m["session_id"] == f"continuous-{recording}"
            and m["finalized"] is True and m["audio"] is False and expected == set(files)
            and set(m["streams"].values()) == STREAMS and math.isfinite(m["start"]) and math.isfinite(m["end"]) and m["end"] >= m["start"])
        if not valid: raise ValueError()
    except (KeyError, ValueError, TypeError, AttributeError):
        fail(400, "continuous_manifest_invalid", "Invalid full recording manifest")

@router.post("/{recording}/transfer/finish", status_code=202)
def finish(recording: UUID, installation=Depends(require_installation)):
    from app.main import storage, BUCKET
    with database() as c:
        owner = owner_locked(c, installation)
        row = row_locked(c, owner["id"], recording)
        if row["complete"]: return receipt(row)
        # The accepted reservation is included in quota accounting until this commit.
        client = storage()
        for name, descriptor in sorted(row["files"].items()):
            sha = hashlib.sha256()
            with tempfile.TemporaryFile() as target:
                for index in range(math.ceil(descriptor["size"] / CHUNK_SIZE)):
                    chunk = c.execute("SELECT * FROM continuous_chunks WHERE installation_id=%s AND recording_id=%s AND file_name=%s AND chunk_index=%s", (owner["id"], recording, name, index)).fetchone()
                    if not chunk: fail(409, "transfer_incomplete", "Full recording has missing chunks")
                    response = client.get_object(Bucket=BUCKET, Key=key(owner["id"], recording, name, index))
                    try: data = response["Body"].read()
                    finally: response["Body"].close()
                    if len(data) != chunk["size_bytes"] or hashlib.sha256(data).hexdigest() != chunk["sha256"]:
                        fail(409, "transfer_corrupt", "Stored chunk failed verification")
                    target.write(data); sha.update(data)
                if target.tell() != descriptor["size"] or sha.hexdigest() != descriptor["sha256"]:
                    fail(409, "transfer_corrupt", "Stored file failed verification")
                target.seek(0)
                if name == "session.json":
                    validate_manifest(target.read(), recording, row["files"]); target.seek(0)
                # Deterministic, immutable destination; retries after uncertain DB commits are safe.
                client.upload_fileobj(target, BUCKET, f"continuous/{owner['id']}/{recording}/files/{name}")
        c.execute("UPDATE continuous_recordings SET complete=true,completed_at=now() WHERE installation_id=%s AND id=%s", (owner["id"], recording))
        c.execute("UPDATE installations SET used_bytes=used_bytes+%s,used_uploads=used_uploads+1 WHERE id=%s", (row["total_size"], owner["id"]))
        row["complete"] = True
        return receipt(row)


def sweep_staging():
    """Owner-locked cleanup; final copies survive and expired retries can restart."""
    from app.main import storage, BUCKET
    sweep_full_deletions()
    with database() as c:
        owners = c.execute("SELECT DISTINCT installation_id FROM continuous_recordings WHERE complete OR expires_at < now()").fetchall()
    for item in owners:
        try:
            with database() as c:
                owner = item["installation_id"]
                c.execute("SELECT id FROM installations WHERE id=%s FOR UPDATE", (owner,)).fetchone()
                rows = c.execute("SELECT * FROM continuous_recordings WHERE installation_id=%s AND (complete OR expires_at < now()) FOR UPDATE", (owner,)).fetchall()
                client = storage()
                for row in rows:
                    chunks = c.execute("SELECT 1 FROM continuous_chunks WHERE installation_id=%s AND recording_id=%s LIMIT 1", (owner, row["id"])).fetchone()
                    if row["complete"] and not chunks: continue
                    # Include possible S3 writes whose DB transactions rolled back.
                    for name, f in row["files"].items():
                        for index in range(math.ceil(f["size"] / CHUNK_SIZE)):
                            client.delete_object(Bucket=BUCKET, Key=key(owner, row["id"], name, index))
                        if not row["complete"]:
                            client.delete_object(Bucket=BUCKET, Key=f"continuous/{owner}/{row['id']}/files/{name}")
                    c.execute("DELETE FROM continuous_chunks WHERE installation_id=%s AND recording_id=%s", (owner, row["id"]))
                    if not row["complete"]: c.execute("DELETE FROM continuous_recordings WHERE installation_id=%s AND id=%s", (owner, row["id"]))
        except Exception:
            logging.getLogger(__name__).exception("Full-recording staging cleanup will retry")


def finish_full_deletion(owner, recording):
    from app.main import storage, BUCKET
    with database() as c:
        c.execute("SELECT id FROM installations WHERE id=%s FOR UPDATE", (owner,)).fetchone()
        row = c.execute("SELECT pending_keys FROM continuous_deletions WHERE installation_id=%s AND recording_id=%s", (owner, recording)).fetchone()
        if not row or row["pending_keys"] is None:
            return
        client = storage()
        for object_key in row["pending_keys"]:
            client.delete_object(Bucket=BUCKET, Key=object_key)
        c.execute("UPDATE continuous_deletions SET pending_keys=NULL WHERE installation_id=%s AND recording_id=%s", (owner, recording))


def sweep_full_deletions():
    with database() as c:
        pending = c.execute("SELECT installation_id,recording_id FROM continuous_deletions WHERE pending_keys IS NOT NULL").fetchall()
    for row in pending:
        try:
            finish_full_deletion(row["installation_id"], row["recording_id"])
        except Exception:
            logging.getLogger(__name__).exception("Full-recording deletion will retry")


@router.delete("/{recording}", dependencies=[Depends(require_development_keys)])
def delete_full(recording: UUID, installation=Depends(require_installation)):
    owner_id = installation["id"]
    with database() as c:
        owner = owner_locked(c, installation)
        if owner["development_key_id"] is None:
            fail(403, "development_required", "Development login required")
        tombstone = c.execute("SELECT 1 FROM continuous_deletions WHERE installation_id=%s AND recording_id=%s", (owner_id, recording)).fetchone()
        if not tombstone:
            row = row_locked(c, owner_id, recording)
            keys = []
            for name, descriptor in row["files"].items():
                keys.append(f"continuous/{owner_id}/{recording}/files/{name}")
                keys.extend(key(owner_id, recording, name, index) for index in range(math.ceil(descriptor["size"] / CHUNK_SIZE)))
            c.execute("INSERT INTO continuous_deletions(installation_id,recording_id,pending_keys) VALUES(%s,%s,%s)", (owner_id, recording, keys))
            c.execute("DELETE FROM continuous_chunks WHERE installation_id=%s AND recording_id=%s", (owner_id, recording))
            c.execute("DELETE FROM continuous_recordings WHERE installation_id=%s AND id=%s", (owner_id, recording))
            # Deliberately preserve captures, walk metadata and cumulative usage counters.
    finish_full_deletion(owner_id, recording)
    return {"recording_id": recording, "deleted": True}

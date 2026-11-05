"""Installation-scoped, durable chunk staging for episode uploads."""
import hashlib
import io
import math
import logging
import tempfile
from contextlib import ExitStack
from uuid import UUID

from fastapi import APIRouter, Depends, Request
from pydantic import BaseModel, ConfigDict, Field
from psycopg.types.json import Jsonb
from botocore.exceptions import ClientError as StorageError
from starlette.concurrency import run_in_threadpool

from app.db import database
from app.onboarding import fail, require_installation

router = APIRouter(prefix="/api/v1/episodes", tags=["episode transfers"])
CHUNK_SIZE = 1024 * 1024
MAX_SIZE = 200 * 1024 * 1024
NAMES = ("video", "imu", "poses", "manifest")


class FileInfo(BaseModel):
    model_config = ConfigDict(extra="forbid")
    size: int = Field(gt=0, strict=True)
    sha256: str = Field(pattern=r"^[0-9a-f]{64}$")


class TransferInfo(BaseModel):
    model_config = ConfigDict(extra="forbid")
    files: dict[str, FileInfo]


def reserved(connection, owner_id, *, excluding=None):
    row = connection.execute("""SELECT COALESCE(sum(total_size),0) AS bytes, count(*) AS count
        FROM episode_transfers WHERE installation_id=%s AND status='active'
        AND (%s::uuid IS NULL OR episode_id<>%s::uuid)""", (owner_id, excluding, excluding)).fetchone()
    return row["bytes"], row["count"]


def check_quota(connection, owner, size, *, excluding=None):
    pending_bytes, pending_count = reserved(connection, owner["id"], excluding=excluding)
    if owner["used_bytes"] + pending_bytes + size > owner["quota_bytes"] or owner["used_uploads"] + pending_count >= owner["quota_uploads"]:
        fail(429, "quota_exceeded", "Installation upload quota reached")


def object_key(owner_id, episode_id, name, index):
    return f"episode-staging/{owner_id}/{episode_id}/{name}/{index:08d}"


def delete_transfer(connection, owner_id, episode_id):
    # Delete each deterministic object before removing its durable index. If a
    # delete or transaction fails, retrying the sweep is safe (S3 delete is idempotent).
    from app.main import BUCKET, EPISODE_FILES, keyed_capture_id, storage
    row = connection.execute("SELECT files FROM episode_transfers WHERE installation_id=%s AND episode_id=%s", (owner_id, episode_id)).fetchone()
    if not row:
        return
    client = storage()
    # Include possible objects whose DB insert failed after the S3 write.
    for name in NAMES:
        for index in range(math.ceil(row["files"][name]["size"] / CHUNK_SIZE)):
            client.delete_object(Bucket=BUCKET, Key=object_key(owner_id, episode_id, name, index))
    # A process may die after publishing final objects but before its DB
    # transaction commits. Delete those only after proving no committed row
    # references this deterministic bundle under the same owner lock.
    capture_id = keyed_capture_id(owner_id, episode_id)
    checksum = expected_bundle(row["files"])
    original_key = f"originals/{capture_id}/client-{episode_id}/episode-{checksum}"
    capture = connection.execute("SELECT original_key FROM captures WHERE id=%s AND installation_id=%s", (capture_id, owner_id)).fetchone()
    if not capture or capture["original_key"] != original_key:
        client.delete_object(Bucket=BUCKET, Key=original_key)
        for name, (filename, _) in EPISODE_FILES.items():
            if name != "video":
                client.delete_object(Bucket=BUCKET, Key=f"episodes/{capture_id}/{checksum}/{filename}")
    connection.execute("DELETE FROM episode_transfers WHERE installation_id=%s AND episode_id=%s", (owner_id, episode_id))


def sweep_owner(connection, owner_id):
    for row in connection.execute("""SELECT episode_id FROM episode_transfers
        WHERE installation_id=%s AND expires_at < now() FOR UPDATE""", (owner_id,)).fetchall():
        delete_transfer(connection, owner_id, row["episode_id"])


def sweep_expired():
    with database() as connection:
        owners = connection.execute("SELECT DISTINCT installation_id FROM episode_transfers WHERE expires_at < now()").fetchall()
    swept = 0
    for item in owners:
        try:
            with database() as connection:
                owner_id = item["installation_id"]
                connection.execute("SELECT id FROM installations WHERE id=%s FOR UPDATE", (owner_id,)).fetchone()
                sweep_owner(connection, owner_id)
            swept += 1
        except Exception:
            logging.getLogger(__name__).exception("Could not clean expired episode transfers; will retry")
    return swept


def owner_locked(connection, installation):
    owner = connection.execute("SELECT * FROM installations WHERE id=%s FOR UPDATE", (installation["id"],)).fetchone()
    if not owner or owner["revoked_at"]:
        fail(401, "access_revoked", "Installation access has been revoked")
    return owner


def transfer_locked(connection, owner_id, episode_id):
    row = connection.execute("""SELECT * FROM episode_transfers
        WHERE installation_id=%s AND episode_id=%s FOR UPDATE""", (owner_id, episode_id)).fetchone()
    if row is None:
        fail(404, "transfer_not_found", "Transfer not found")
    return row


def expected_bundle(files):
    digest = hashlib.sha256()
    for name in NAMES:
        info = files[name]
        digest.update(name.encode() + b"\0" + str(info["size"]).encode() + b"\0" + bytes.fromhex(info["sha256"]))
    return digest.hexdigest()


@router.post("/{episode_id}/transfer")
def begin(episode_id: UUID, body: TransferInfo, installation=Depends(require_installation)):
    from app.main import BUCKET, keyed_capture_id, storage
    if set(body.files) != set(NAMES):
        fail(400, "episode_files_invalid", "Episode must contain exactly four files")
    files = {name: body.files[name].model_dump() for name in NAMES}
    size = sum(item["size"] for item in files.values())
    if size > MAX_SIZE or files["manifest"]["size"] > CHUNK_SIZE:
        fail(413, "upload_too_large", "Episode exceeds upload limit")
    with database() as connection:
        owner = owner_locked(connection, installation)
        sweep_owner(connection, owner["id"])
        capture = connection.execute("SELECT * FROM captures WHERE id=%s AND installation_id=%s",
            (keyed_capture_id(owner["id"], episode_id), owner["id"])).fetchone()
        if capture:
            if not capture["original_key"].endswith("/episode-" + expected_bundle(files)) or capture["size_bytes"] != size:
                fail(409, "idempotency_conflict", "Episode key was already used with different content")
            return {"complete": True, "chunk_size": CHUNK_SIZE, "chunks": {}}
        row = connection.execute("SELECT * FROM episode_transfers WHERE installation_id=%s AND episode_id=%s FOR UPDATE", (owner["id"], episode_id)).fetchone()
        if row and row["files"] != files:
            fail(409, "idempotency_conflict", "Transfer key was already used with different content")
        if not row:
            check_quota(connection, owner, size)
            connection.execute("INSERT INTO episode_transfers (installation_id,episode_id,files,total_size) VALUES (%s,%s,%s,%s)",
                (owner["id"], episode_id, Jsonb(files), size))
        else:
            connection.execute("UPDATE episode_transfers SET expires_at=now()+interval '7 days' WHERE installation_id=%s AND episode_id=%s", (owner["id"], episode_id))
        chunks = {name: [] for name in NAMES}
        client = storage()
        for part in connection.execute("SELECT file_name,chunk_index FROM episode_transfer_chunks WHERE installation_id=%s AND episode_id=%s", (owner["id"], episode_id)).fetchall():
            try:
                client.head_object(Bucket=BUCKET, Key=object_key(owner["id"], episode_id, part["file_name"], part["chunk_index"]))
            except StorageError as error:
                if str(error.response.get("Error", {}).get("Code")) not in ("404", "NoSuchKey", "NotFound"):
                    raise
                # A prior cleanup may have deleted storage and crashed before
                # committing its DB transaction. Ask the client to resend it.
                connection.execute("""DELETE FROM episode_transfer_chunks WHERE installation_id=%s
                    AND episode_id=%s AND file_name=%s AND chunk_index=%s""",
                    (owner["id"], episode_id, part["file_name"], part["chunk_index"]))
                continue
            chunks[part["file_name"]].append(part["chunk_index"])
        return {"complete": False, "chunk_size": CHUNK_SIZE, "chunks": chunks}


def store_chunk(installation, episode_id, name, index, data):
    from app.main import BUCKET, storage
    if name not in NAMES or index < 0:
        fail(404, "transfer_not_found", "Transfer not found")
    with database() as connection:
        owner = owner_locked(connection, installation)
        transfer = transfer_locked(connection, owner["id"], episode_id)
        info = transfer["files"][name]
        count = math.ceil(info["size"] / CHUNK_SIZE)
        expected = min(CHUNK_SIZE, info["size"] - index * CHUNK_SIZE)
        if transfer["status"] != "active" or index >= count or len(data) != expected:
            fail(400, "chunk_invalid", "Invalid chunk")
        digest = hashlib.sha256(data).hexdigest()
        old = connection.execute("""SELECT * FROM episode_transfer_chunks WHERE
            installation_id=%s AND episode_id=%s AND file_name=%s AND chunk_index=%s""",
            (owner["id"], episode_id, name, index)).fetchone()
        if old:
            if old["sha256"] != digest or old["size_bytes"] != len(data):
                fail(409, "idempotency_conflict", "Chunk differs from the accepted bytes")
            return {"accepted": True}
        storage().upload_fileobj(io.BytesIO(data), BUCKET, object_key(owner["id"], episode_id, name, index))
        connection.execute("""INSERT INTO episode_transfer_chunks
            (installation_id,episode_id,file_name,chunk_index,size_bytes,sha256) VALUES (%s,%s,%s,%s,%s,%s)""",
            (owner["id"], episode_id, name, index, len(data), digest))
        connection.execute("UPDATE episode_transfers SET expires_at=now()+interval '7 days' WHERE installation_id=%s AND episode_id=%s", (owner["id"], episode_id))
    return {"accepted": True}


@router.put("/{episode_id}/transfer/{name}/{index}")
async def put_chunk(episode_id: UUID, name: str, index: int, request: Request, installation=Depends(require_installation)):
    if request.headers.get("content-type") != "application/octet-stream":
        fail(415, "media_type_unsupported", "Expected binary chunk")
    data = bytearray()
    async for part in request.stream():
        data.extend(part)
        if len(data) > CHUNK_SIZE:
            fail(413, "upload_too_large", "Chunk exceeds upload limit")
    return await run_in_threadpool(store_chunk, installation, episode_id, name, index, bytes(data))


@router.post("/{episode_id}/transfer/finish", status_code=202)
def finish(episode_id: UUID, installation=Depends(require_installation)):
    from app.main import BUCKET, EPISODE_FILES, keyed_capture_id, receipt_from_row, storage, validate_episode_manifest
    capture_id = keyed_capture_id(installation["id"], episode_id)
    with database() as connection:
        owner = owner_locked(connection, installation)
        existing = connection.execute("SELECT * FROM captures WHERE id=%s AND installation_id=%s", (capture_id, owner["id"])).fetchone()
        if existing:
            return receipt_from_row(existing)
        transfer = transfer_locked(connection, owner["id"], episode_id)
        if transfer["status"] != "active":
            fail(409, "idempotency_conflict", "Transfer already completed")
        check_quota(connection, owner, transfer["total_size"], excluding=episode_id)
        client = storage()
        with ExitStack() as stack:
            files = {}
            for name in NAMES:
                descriptor = transfer["files"][name]
                target = stack.enter_context(tempfile.TemporaryFile())
                digest = hashlib.sha256()
                for index in range(math.ceil(descriptor["size"] / CHUNK_SIZE)):
                    row = connection.execute("""SELECT * FROM episode_transfer_chunks WHERE
                        installation_id=%s AND episode_id=%s AND file_name=%s AND chunk_index=%s""",
                        (owner["id"], episode_id, name, index)).fetchone()
                    if not row:
                        fail(409, "transfer_incomplete", "Episode still has missing chunks")
                    content = client.get_object(Bucket=BUCKET, Key=object_key(owner["id"], episode_id, name, index))["Body"].read()
                    if len(content) != row["size_bytes"] or hashlib.sha256(content).hexdigest() != row["sha256"]:
                        fail(409, "transfer_corrupt", "Stored chunk failed integrity verification")
                    target.write(content)
                    digest.update(content)
                if target.tell() != descriptor["size"] or digest.hexdigest() != descriptor["sha256"]:
                    fail(409, "transfer_corrupt", "Stored file failed integrity verification")
                target.seek(0)
                files[name] = target
            validate_episode_manifest(files["manifest"].read(), episode_id)
            files["manifest"].seek(0)
            checksum = expected_bundle(transfer["files"])
            original_key = f"originals/{capture_id}/client-{episode_id}/episode-{checksum}"
            prefix = f"episodes/{capture_id}/{checksum}"
            for name, (filename, content_type) in EPISODE_FILES.items():
                client.upload_fileobj(files[name], BUCKET, original_key if name == "video" else f"{prefix}/{filename}", ExtraArgs={"ContentType": content_type})
            connection.execute("""INSERT INTO captures (id,filename,content_type,media_kind,original_key,size_bytes,installation_id)
                VALUES (%s,'video.mp4','video/mp4','video',%s,%s,%s)""", (capture_id, original_key, transfer["total_size"], owner["id"]))
            connection.execute("UPDATE installations SET used_bytes=used_bytes+%s,used_uploads=used_uploads+1 WHERE id=%s", (transfer["total_size"], owner["id"]))
            connection.execute("UPDATE episode_transfers SET status='complete',expires_at=now()+interval '7 days' WHERE installation_id=%s AND episode_id=%s", (owner["id"], episode_id))
            row = connection.execute("SELECT * FROM captures WHERE id=%s", (capture_id,)).fetchone()
            return receipt_from_row(row)


@router.delete("/{episode_id}/transfer", status_code=204)
def cancel(episode_id: UUID, installation=Depends(require_installation)):
    with database() as connection:
        owner = owner_locked(connection, installation)
        transfer = connection.execute("SELECT * FROM episode_transfers WHERE installation_id=%s AND episode_id=%s FOR UPDATE", (owner["id"], episode_id)).fetchone()
        if transfer:
            delete_transfer(connection, owner["id"], episode_id)

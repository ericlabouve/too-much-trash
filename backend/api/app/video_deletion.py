"""Delete developer videos while preserving a tombstone for idempotent retries."""

import logging
from uuid import UUID

from fastapi import APIRouter, Depends

from app.db import database
from app.onboarding import fail, require_development_keys, require_installation

router = APIRouter(prefix="/api/v1/media", tags=["media"])


def deletion_row(connection, owner_id, client_capture_id):
    return connection.execute("""SELECT pending_keys FROM dev_video_deletions
        WHERE installation_id=%s AND client_capture_id=%s""", (owner_id, client_capture_id)).fetchone()


def reject_deleted_video(connection, owner, client_capture_id):
    if owner["development_key_id"] is not None and deletion_row(connection, owner["id"], client_capture_id):
        fail(409, "capture_deleted", "This video was deleted")


def finish_deletion(owner_id, client_capture_id):
    from app.episode_transfer import delete_transfer
    from app.main import BUCKET, storage

    with database() as connection:
        # Serialize with upload, retry and expiry cleanup, even after revocation.
        connection.execute("SELECT id FROM installations WHERE id=%s FOR UPDATE", (owner_id,)).fetchone()
        row = deletion_row(connection, owner_id, client_capture_id)
        if row is None or row["pending_keys"] is None:
            return
        client = storage()
        for key in row["pending_keys"]:
            client.delete_object(Bucket=BUCKET, Key=key)
        delete_transfer(connection, owner_id, client_capture_id)
        connection.execute("""UPDATE dev_video_deletions SET pending_keys=NULL
            WHERE installation_id=%s AND client_capture_id=%s""", (owner_id, client_capture_id))


def sweep_deletions():
    with database() as connection:
        pending = connection.execute("""SELECT installation_id, client_capture_id
            FROM dev_video_deletions WHERE pending_keys IS NOT NULL""").fetchall()
    for row in pending:
        try:
            finish_deletion(row["installation_id"], row["client_capture_id"])
        except Exception:
            logging.getLogger(__name__).exception("Could not finish developer video deletion; will retry")


@router.delete("/by-client/{client_capture_id}", dependencies=[Depends(require_development_keys)])
def delete_video(client_capture_id: UUID, installation=Depends(require_installation)):
    from app.episode_transfer import owner_locked
    from app.main import EPISODE_FILES, keyed_capture_id, receipt_from_row

    owner_id = installation["id"]
    with database() as connection:
        owner = owner_locked(connection, installation)
        if owner["development_key_id"] is None:
            fail(403, "development_required", "Development login required")
        if deletion_row(connection, owner_id, client_capture_id) is None:
            capture_id = keyed_capture_id(owner_id, client_capture_id)
            capture = connection.execute("""SELECT * FROM captures WHERE id=%s AND installation_id=%s
                AND media_kind='video' FOR UPDATE""", (capture_id, owner_id)).fetchone()
            if capture is None:
                fail(404, "media_not_found", "Video not found")
            if capture["status"] == "processing":
                fail(409, "capture_processing", "Wait for backend processing to finish, then retry deletion")
            # A worker can have uploaded the deterministic poster just before
            # its result transaction failed.
            keys = [capture["original_key"], f"processed/{capture_id}/poster.jpg"]
            if capture["processed_key"] and capture["processed_key"] not in keys:
                keys.append(capture["processed_key"])
            if checksum := receipt_from_row(capture)["episode_bundle_sha256"]:
                keys.extend(f"episodes/{capture_id}/{checksum}/{filename}"
                            for name, (filename, _) in EPISODE_FILES.items() if name != "video")
            connection.execute("""INSERT INTO dev_video_deletions (installation_id, client_capture_id, pending_keys)
                VALUES (%s,%s,%s)""", (owner_id, client_capture_id, keys))
            connection.execute("DELETE FROM captures WHERE id=%s", (capture_id,))
    finish_deletion(owner_id, client_capture_id)
    return {"client_capture_id": client_capture_id, "deleted": True}

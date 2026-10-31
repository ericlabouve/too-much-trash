"""Claim durable capture jobs and run media extraction as Prefect flows."""

import json
import logging
import os
import subprocess
import tempfile
import time
import urllib.request
from pathlib import Path

import boto3
import psycopg
from PIL import Image, ImageOps
from pillow_heif import register_heif_opener
from prefect import flow
from psycopg.types.json import Jsonb

register_heif_opener()
logging.basicConfig(level=logging.INFO)
log = logging.getLogger("capture-worker")
BUCKET = os.environ["S3_BUCKET"]


def storage():
    return boto3.client(
        "s3",
        endpoint_url=os.environ["S3_ENDPOINT_URL"],
        aws_access_key_id=os.environ["S3_ACCESS_KEY"],
        aws_secret_access_key=os.environ["S3_SECRET_KEY"],
        region_name="us-east-1",
    )


def claim_job():
    with psycopg.connect(os.environ["DATABASE_URL"]) as connection:
        with connection.cursor() as cursor:
            cursor.execute(
                """UPDATE captures SET status = 'processing', processing_started_at = now(), updated_at = now()
                   WHERE id = (
                       SELECT id FROM captures
                       WHERE status = 'queued'
                          OR (status = 'processing' AND processing_started_at < now() - interval '30 minutes')
                       ORDER BY created_at FOR UPDATE SKIP LOCKED LIMIT 1
                   )
                   RETURNING id, original_key, content_type, media_kind"""
            )
            return cursor.fetchone()


@flow(name="process-capture", log_prints=True)
def process_capture(capture_id: str, original_key: str, content_type: str, kind: str):
    client = storage()
    with tempfile.TemporaryDirectory() as directory:
        source = Path(directory) / "source"
        client.download_file(BUCKET, original_key, str(source))
        poster = Path(directory) / "poster.jpg"
        if kind == "image":
            with Image.open(source) as opened:
                image = ImageOps.exif_transpose(opened)
                width, height = image.size
                image.thumbnail((1280, 1280))
                image.convert("RGB").save(poster, "JPEG", quality=85)
            result = {"width": width, "height": height}
        else:
            probe = subprocess.run(
                ["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "json", str(source)],
                check=True, capture_output=True, text=True, timeout=60,
            )
            duration = float(json.loads(probe.stdout)["format"]["duration"])
            subprocess.run(
                ["ffmpeg", "-y", "-v", "error", "-i", str(source), "-frames:v", "1", str(poster)],
                check=True, capture_output=True, timeout=120,
            )
            result = {"duration_seconds": duration}
        key = f"processed/{capture_id}/poster.jpg"
        client.upload_file(str(poster), BUCKET, key, ExtraArgs={"ContentType": "image/jpeg"})
        return key, result


def main():
    while True:
        try:
            urllib.request.urlopen(os.environ["PREFECT_API_URL"] + "/health", timeout=3).close()
        except Exception:
            log.info("Waiting for Prefect API")
            time.sleep(5)
            continue
        try:
            job = claim_job()
        except Exception:
            log.exception("Unable to claim capture")
            time.sleep(5)
            continue
        if job is None:
            time.sleep(2)
            continue
        capture_id, original_key, content_type, kind = job
        log.info("Processing capture %s", capture_id)
        try:
            key, result = process_capture(str(capture_id), original_key, content_type, kind)
            with psycopg.connect(os.environ["DATABASE_URL"]) as connection:
                connection.execute(
                    """UPDATE captures SET status = 'completed', processed_key = %s,
                       processed_content_type = 'image/jpeg', result = %s, error = NULL, updated_at = now()
                       WHERE id = %s""",
                    (key, Jsonb(result), capture_id),
                )
        except Exception as exc:
            log.exception("Capture %s failed", capture_id)
            with psycopg.connect(os.environ["DATABASE_URL"]) as connection:
                connection.execute(
                    "UPDATE captures SET status = 'failed', error = %s, updated_at = now() WHERE id = %s",
                    (str(exc)[:500], capture_id),
                )


if __name__ == "__main__":
    main()

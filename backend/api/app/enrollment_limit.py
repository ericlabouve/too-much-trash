"""Global rolling enrollment permits, committed before request validation."""
import math

from fastapi import HTTPException

from app.db import database

BUCKET = "enroll_rolling_us"
LIMIT = 3
WINDOW_US = 60_000_000
LOCK_KEY = 7248032


def database_now_us(connection) -> int:
    # Read after acquiring the lock: every API process shares this DB clock.
    return connection.execute(
        "SELECT floor(extract(epoch FROM clock_timestamp()) * 1000000)::bigint AS now_us"
    ).fetchone()["now_us"]


def require_enrollment_permit() -> None:
    retry_after = None
    with database() as connection:
        connection.execute("SELECT pg_advisory_xact_lock(%s)", (LOCK_KEY,))
        now_us = database_now_us(connection)
        # Namespaced bucket uses microsecond timestamps in existing bigint
        # window_id; login/refresh retain separate fixed-minute buckets.
        connection.execute("DELETE FROM auth_rate_limits WHERE bucket=%s AND window_id<=%s",
                           (BUCKET, now_us - WINDOW_US))
        row = connection.execute(
            "SELECT COALESCE(sum(attempts),0) AS n, min(window_id) AS oldest FROM auth_rate_limits WHERE bucket=%s",
            (BUCKET,),
        ).fetchone()
        if row["n"] >= LIMIT:
            retry_after = max(1, math.ceil((row["oldest"] + WINDOW_US - now_us) / 1_000_000))
        else:
            connection.execute(
                """INSERT INTO auth_rate_limits(bucket,window_id,attempts) VALUES (%s,%s,1)
                   ON CONFLICT (bucket,window_id) DO UPDATE SET attempts=auth_rate_limits.attempts+1""",
                (BUCKET, now_us),
            )
    # Later validation/redemption failure cannot roll back an admitted attempt.
    # Rejected requests do not extend cooldown or consume additional permits.
    if retry_after is not None:
        raise HTTPException(429, {"code": "rate_limited", "message": "Try again later"},
                            headers={"Retry-After": str(retry_after)})

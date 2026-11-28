"""Owner-scoped cleanup context, separate from media and HealthKit metrics."""
from uuid import UUID
from typing import Literal
from fastapi import APIRouter, Depends
from pydantic import BaseModel, ConfigDict, Field, model_validator
from psycopg.types.json import Jsonb
from app.db import database
from app.onboarding import fail, require_installation
from app.episode_transfer import owner_locked

router = APIRouter(prefix="/api/v1/cleanup-sessions", tags=["cleanup sessions"])

class Location(BaseModel):
    model_config = ConfigDict(extra="forbid", allow_inf_nan=False)
    latitude: float = Field(ge=-90, le=90)
    longitude: float = Field(ge=-180, le=180)
    accuracy_m: float = Field(ge=0, le=100000)
    altitude_m: float
    timestamp: float = Field(ge=0)
    uptime: float = Field(ge=0)

class CleanupDocument(BaseModel):
    model_config = ConfigDict(extra="forbid", allow_inf_nan=False)
    id: UUID
    revision: int = Field(ge=1, strict=True)
    name: str = Field(max_length=120)
    description: str = Field(max_length=4000)
    started_at: float = Field(ge=0)
    started_uptime: float | None = Field(default=None, ge=0)
    start_time_reference: Literal["phone_callback_uptime", "watch_wall_clock_estimate"] = "phone_callback_uptime"
    ended_at: float | None = Field(default=None, ge=0)
    record_route: bool = False
    marked_location: Location | None = None
    route: list[Location] = Field(default_factory=list, max_length=100000)
    route_notes: list[str] = Field(default_factory=list, max_length=100)

    @model_validator(mode="after")
    def timing(self):
        if self.ended_at is not None and self.ended_at < self.started_at:
            raise ValueError("End precedes start")
        if any(b.timestamp < a.timestamp for a, b in zip(self.route, self.route[1:])):
            raise ValueError("Route timestamps must be ordered")
        if any(len(note) > 256 for note in self.route_notes):
            raise ValueError("Route note too long")
        return self

@router.put("/{session_id}")
def save(session_id: UUID, body: CleanupDocument, installation=Depends(require_installation)):
    if body.id != session_id: fail(400, "cleanup_session_invalid", "Session ID mismatch")
    document = body.model_dump(mode="json")
    with database() as c:
        owner = owner_locked(c, installation)
        row = c.execute("SELECT * FROM cleanup_sessions WHERE installation_id=%s AND id=%s FOR UPDATE", (owner["id"], session_id)).fetchone()
        if row:
            if row["revision"] > body.revision:
                fail(409, "idempotency_conflict", "A newer session revision is saved")
            if row["revision"] == body.revision and row["document"] != document:
                fail(409, "idempotency_conflict", "Session revision has different contents")
            previous = row["document"]
            if previous["started_at"] != body.started_at or previous["started_uptime"] != body.started_uptime:
                fail(409, "idempotency_conflict", "Session start is immutable")
            if previous.get("ended_at") is not None and previous["ended_at"] != body.ended_at:
                fail(409, "idempotency_conflict", "A stopped session cannot restart")
        elif c.execute("SELECT count(*) AS n FROM cleanup_sessions WHERE installation_id=%s", (owner["id"],)).fetchone()["n"] >= 10000:
            fail(409, "cleanup_session_limit", "Cleanup session limit reached")
        c.execute("""INSERT INTO cleanup_sessions(installation_id,id,revision,document) VALUES(%s,%s,%s,%s)
            ON CONFLICT(installation_id,id) DO UPDATE SET revision=EXCLUDED.revision,document=EXCLUDED.document,updated_at=now()""", (owner["id"], session_id, body.revision, Jsonb(document)))
    return {"session_id": session_id, "revision": body.revision, "saved": True}

@router.get("/{session_id}")
def read(session_id: UUID, installation=Depends(require_installation)):
    with database() as c:
        owner = owner_locked(c, installation)
        row = c.execute("SELECT document FROM cleanup_sessions WHERE installation_id=%s AND id=%s", (owner["id"], session_id)).fetchone()
        if not row: fail(404, "cleanup_session_not_found", "Cleanup session not found")
        return row["document"]

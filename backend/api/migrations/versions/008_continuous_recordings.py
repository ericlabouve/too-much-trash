"""Keep full recordings separate from bounded pickup episodes."""
from alembic import op
revision = "008_continuous_recordings"
down_revision = "007_dev_video_deletion"
branch_labels = None
depends_on = None

CLEANUP_SESSIONS_SQL = """CREATE TABLE IF NOT EXISTS cleanup_sessions (
    installation_id uuid NOT NULL REFERENCES installations(id), id uuid NOT NULL,
    revision integer NOT NULL CHECK(revision > 0), document jsonb NOT NULL,
    updated_at timestamptz NOT NULL DEFAULT now(), PRIMARY KEY(installation_id,id))"""

CONTINUOUS_DELETIONS_SQL = """CREATE TABLE IF NOT EXISTS continuous_deletions (
    installation_id uuid NOT NULL REFERENCES installations(id), recording_id uuid NOT NULL,
    pending_keys text[], created_at timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY(installation_id,recording_id))"""

def upgrade():
    op.execute(CLEANUP_SESSIONS_SQL)
    op.execute(CONTINUOUS_DELETIONS_SQL)
    op.execute("""CREATE TABLE continuous_recordings (
        installation_id uuid NOT NULL REFERENCES installations(id), id uuid NOT NULL,
        files jsonb NOT NULL, total_size bigint NOT NULL CHECK(total_size > 0),
        bundle_sha256 text NOT NULL, complete boolean NOT NULL DEFAULT false,
        created_at timestamptz NOT NULL DEFAULT now(), completed_at timestamptz,
        expires_at timestamptz NOT NULL DEFAULT now() + interval '7 days',
        PRIMARY KEY(installation_id,id))""")
    op.execute("""CREATE TABLE continuous_chunks (
        installation_id uuid NOT NULL, recording_id uuid NOT NULL,
        file_name text NOT NULL, chunk_index integer NOT NULL CHECK(chunk_index >= 0),
        sha256 text NOT NULL, size_bytes integer NOT NULL,
        PRIMARY KEY(installation_id,recording_id,file_name,chunk_index),
        FOREIGN KEY(installation_id,recording_id) REFERENCES continuous_recordings(installation_id,id))""")

def downgrade():
    op.execute("DROP TABLE continuous_deletions")
    op.execute("DROP TABLE cleanup_sessions")
    op.execute("DROP TABLE continuous_chunks")
    op.execute("DROP TABLE continuous_recordings")

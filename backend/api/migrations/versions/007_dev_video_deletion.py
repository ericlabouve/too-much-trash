"""Keep durable developer video deletion state for retries and old uploads."""
from alembic import op

revision = "007_dev_video_deletion"
down_revision = "006_episode_chunk_size"
branch_labels = None
depends_on = None


def upgrade():
    op.execute("""CREATE TABLE dev_video_deletions (
        installation_id uuid NOT NULL REFERENCES installations(id),
        client_capture_id uuid NOT NULL,
        pending_keys text[],
        PRIMARY KEY (installation_id, client_capture_id)
    )""")
    op.execute("""CREATE INDEX dev_video_deletions_pending_idx
        ON dev_video_deletions (installation_id, client_capture_id) WHERE pending_keys IS NOT NULL""")


def downgrade():
    op.execute("""DO $$ BEGIN
        IF EXISTS (SELECT 1 FROM dev_video_deletions WHERE pending_keys IS NOT NULL) THEN
            RAISE EXCEPTION 'Finish pending developer video deletions before downgrade';
        END IF;
    END $$""")
    op.execute("DROP TABLE dev_video_deletions")

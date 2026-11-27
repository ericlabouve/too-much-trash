"""Persist the byte layout of each resumable transfer."""
from alembic import op

revision = "006_episode_chunk_size"
down_revision = "005_episode_transfers"
branch_labels = None
depends_on = None


def upgrade():
    op.execute("""ALTER TABLE episode_transfers
        ADD COLUMN chunk_size integer NOT NULL DEFAULT 1048576
        CHECK (chunk_size IN (1048576, 4194304))""")


def downgrade():
    # Completed captures are independent of staging. Active large-chunk
    # transfers must finish or be cancelled before their layout can be dropped.
    op.execute("""DO $$
    BEGIN
        IF EXISTS (SELECT 1 FROM episode_transfers WHERE chunk_size <> 1048576)
        THEN RAISE EXCEPTION 'Sweep completed and finish or cancel active 4 MiB episode transfers before downgrade';
        END IF;
    END $$""")
    op.execute("ALTER TABLE episode_transfers DROP COLUMN chunk_size")

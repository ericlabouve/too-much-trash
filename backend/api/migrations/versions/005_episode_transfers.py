"""Reserve bounded storage for resumable episode transfers."""
from alembic import op

revision = "005_episode_transfers"
down_revision = "004_development_keys"
branch_labels = None
depends_on = None


def upgrade():
    op.execute("""CREATE TABLE episode_transfers (
        installation_id uuid NOT NULL REFERENCES installations(id),
        episode_id uuid NOT NULL,
        files jsonb NOT NULL,
        total_size bigint NOT NULL CHECK (total_size > 0),
        status text NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'complete')),
        expires_at timestamptz NOT NULL DEFAULT now() + interval '7 days',
        PRIMARY KEY (installation_id, episode_id)
    )""")
    op.execute("""CREATE TABLE episode_transfer_chunks (
        installation_id uuid NOT NULL,
        episode_id uuid NOT NULL,
        file_name text NOT NULL,
        chunk_index integer NOT NULL CHECK (chunk_index >= 0),
        size_bytes integer NOT NULL CHECK (size_bytes > 0),
        sha256 text NOT NULL,
        PRIMARY KEY (installation_id, episode_id, file_name, chunk_index),
        FOREIGN KEY (installation_id, episode_id)
          REFERENCES episode_transfers(installation_id, episode_id) ON DELETE CASCADE
    )""")
    op.execute("CREATE INDEX episode_transfers_expiry_idx ON episode_transfers(expires_at)")


def downgrade():
    op.execute("DROP TABLE episode_transfer_chunks")
    op.execute("DROP TABLE episode_transfers")

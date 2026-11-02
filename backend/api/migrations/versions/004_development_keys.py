"""Add scoped development enrollment keys and installation provenance."""
from alembic import op

revision = "004_development_keys"
down_revision = "003_onboarding"
branch_labels = None
depends_on = None


def upgrade():
    op.execute("""CREATE TABLE development_keys (
        id uuid PRIMARY KEY, key_hash text NOT NULL UNIQUE, label text NOT NULL,
        created_at timestamptz NOT NULL DEFAULT now(), last_used_at timestamptz,
        revoked_at timestamptz
    )""")
    op.execute("ALTER TABLE installations ADD COLUMN development_key_id uuid REFERENCES development_keys(id)")


def downgrade():
    op.execute("ALTER TABLE installations DROP COLUMN development_key_id")
    op.execute("DROP TABLE development_keys")

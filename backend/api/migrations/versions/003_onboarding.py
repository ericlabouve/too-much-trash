"""Invite-only onboarding; adopt the previously deployed pilot schema safely.

The captures baseline is created by postgres/init/02-captures.sql. IF NOT EXISTS
allows this first Alembic revision to adopt the pre-Alembic pilot without deleting
invitations, credentials, ownership, or captures. Subsequent revisions should use
normal explicit operations rather than rerunning an untracked SQL directory.
"""
from alembic import op

revision = "003_onboarding"
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    for statement in SCHEMA.split(";"):
        if statement.strip():
            op.execute(statement)


def downgrade():
    # Explicit downgrade destroys access/ownership records; back up first.
    op.execute("DROP INDEX captures_owner_idx")
    op.execute("ALTER TABLE captures DROP COLUMN installation_id")
    for table in ("access_tokens", "auth_rate_limits", "installations", "invitations"):
        op.drop_table(table)


SCHEMA = """
CREATE TABLE IF NOT EXISTS invitations (
    id uuid PRIMARY KEY,
    code_hash text NOT NULL UNIQUE,
    label text NOT NULL,
    expires_at timestamptz NOT NULL,
    quota_bytes bigint NOT NULL CHECK (quota_bytes > 0),
    quota_uploads integer NOT NULL CHECK (quota_uploads > 0),
    created_at timestamptz NOT NULL DEFAULT now(),
    redeemed_at timestamptz,
    revoked_at timestamptz
);
CREATE TABLE IF NOT EXISTS installations (
    id uuid PRIMARY KEY,
    invitation_id uuid NOT NULL UNIQUE REFERENCES invitations(id),
    installation_name text NOT NULL,
    refresh_hash text NOT NULL UNIQUE,
    refresh_expires_at timestamptz NOT NULL,
    quota_bytes bigint NOT NULL CHECK (quota_bytes > 0),
    quota_uploads integer NOT NULL CHECK (quota_uploads > 0),
    used_bytes bigint NOT NULL DEFAULT 0 CHECK (used_bytes >= 0),
    used_uploads integer NOT NULL DEFAULT 0 CHECK (used_uploads >= 0),
    created_at timestamptz NOT NULL DEFAULT now(),
    revoked_at timestamptz
);
CREATE TABLE IF NOT EXISTS access_tokens (
    token_hash text PRIMARY KEY,
    installation_id uuid NOT NULL REFERENCES installations(id),
    expires_at timestamptz NOT NULL
);
CREATE INDEX IF NOT EXISTS access_tokens_expiry_idx ON access_tokens(expires_at);
CREATE TABLE IF NOT EXISTS auth_rate_limits (
    bucket text NOT NULL,
    window_id bigint NOT NULL,
    attempts integer NOT NULL,
    PRIMARY KEY (bucket, window_id)
);
ALTER TABLE captures ADD COLUMN IF NOT EXISTS installation_id uuid REFERENCES installations(id);
CREATE INDEX IF NOT EXISTS captures_owner_idx ON captures(installation_id, created_at);
"""

"""Alembic verification on a disposable database, never the live pilot."""
import os
from pathlib import Path
from uuid import uuid4
import unittest

from alembic import command
from alembic.config import Config

from app.db import database


class MigrationTests(unittest.TestCase):
    def test_upgrade_and_legacy_adoption_preserve_records(self):
        if os.environ.get("TMT_TEST_ISOLATED") != "1":
            raise RuntimeError("Migration tests require a disposable database")
        config = Config("alembic.ini")
        with database() as connection:
            connection.execute(Path("/sql/init/02-captures.sql").read_text())
        command.upgrade(config, "head")
        invite, installation, capture = uuid4(), uuid4(), uuid4()
        with database() as connection:
            connection.execute("INSERT INTO invitations(id,code_hash,label,expires_at,quota_bytes,quota_uploads) VALUES (%s,%s,'Migration test',now()+interval '1 hour',1024,1)", (invite, str(invite)))
            connection.execute("INSERT INTO installations(id,invitation_id,installation_name,refresh_hash,refresh_expires_at,quota_bytes,quota_uploads) VALUES (%s,%s,'Migration test',%s,now()+interval '1 day',1024,1)", (installation, invite, str(installation)))
            connection.execute("INSERT INTO captures(id,filename,content_type,media_kind,original_key,size_bytes,installation_id) VALUES (%s,'test.png','image/png','image','test',1,%s)", (capture, installation))
            connection.execute("DROP TABLE alembic_version")
        # Represents the already-deployed pilot: schema/data but no Alembic ledger.
        command.upgrade(config, "head")
        command.upgrade(config, "head")
        with database() as connection:
            self.assertEqual(connection.execute("SELECT version_num FROM alembic_version").fetchone()["version_num"], "003_onboarding")
            self.assertEqual(connection.execute("SELECT installation_id FROM captures WHERE id=%s", (capture,)).fetchone()["installation_id"], installation)
            self.assertEqual(connection.execute("SELECT invitation_id FROM installations WHERE id=%s", (installation,)).fetchone()["invitation_id"], invite)
            self.assertEqual(connection.execute("SELECT code_hash FROM invitations WHERE id=%s", (invite,)).fetchone()["code_hash"], str(invite))
        # Test destructive downgrade only in this disposable DB; captures survive.
        command.downgrade(config, "base")
        with database() as connection:
            self.assertIsNotNone(connection.execute("SELECT id FROM captures WHERE id=%s", (capture,)).fetchone())
        command.upgrade(config, "head")

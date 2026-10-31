"""Alembic environment: private configuration and serialized transactional DDL."""
import os

from alembic import context
from sqlalchemy import create_engine, text
from sqlalchemy.engine import make_url
from sqlalchemy.pool import NullPool

url = make_url(os.environ["DATABASE_URL"]).set(drivername="postgresql+psycopg")

if context.is_offline_mode():
    context.configure(url=url, literal_binds=True, dialect_opts={"paramstyle": "named"})
    with context.begin_transaction():
        context.run_migrations()
else:
    engine = create_engine(url, poolclass=NullPool)
    try:
        with engine.connect() as connection, connection.begin():
            connection.execute(text("SELECT pg_advisory_xact_lock(7248031)"))
            context.configure(connection=connection)
            context.run_migrations()
    finally:
        engine.dispose()

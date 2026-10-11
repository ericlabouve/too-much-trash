"""Apply ordered idempotent migrations to existing and new databases."""

import os
from pathlib import Path

import psycopg


def main():
    directory = Path(os.environ.get("MIGRATIONS_DIR", "/migrations"))
    migrations = sorted(directory.glob("*.sql"))
    if not migrations:
        raise RuntimeError(f"No migrations found in {directory}")
    with psycopg.connect(os.environ["DATABASE_URL"], autocommit=True) as connection:
        connection.execute("SELECT pg_advisory_lock(7248031)")
        try:
            for path in migrations:
                connection.execute(path.read_text())
                print(f"Applied {path.name}")
        finally:
            connection.execute("SELECT pg_advisory_unlock(7248031)")


if __name__ == "__main__":
    main()

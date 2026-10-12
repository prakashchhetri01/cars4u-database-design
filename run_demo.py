"""Build a new demo database and execute example queries with Python's SQLite."""
from pathlib import Path
import sqlite3


def main():
    root = Path(__file__).resolve().parent
    target = root / "cars4u.db"
    if target.exists():
        raise SystemExit("cars4u.db already exists. Rename or remove it before rebuilding the demo.")
    with sqlite3.connect(target) as connection:
        connection.execute("PRAGMA foreign_keys = ON")
        for filename in ("01_schema.sql", "02_sample_data.sql"):
            connection.executescript((root / "sql" / filename).read_text())
        queries = (root / "sql/03_example_queries.sql").read_text()
        for query in queries.split(";"):
            if query.strip():
                cursor = connection.execute(query)
                print(" | ".join(column[0] for column in cursor.description))
                for row in cursor:
                    print(row)
                print()
    print("Created", target.name)


if __name__ == "__main__":
    main()

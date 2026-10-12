# Cars4U Relational Database Design

A relational database design for a multi-location car rental business, developed by **Prakash Bahadur G C** for **CIS2360: Relational Databases and Web Integration**, University of Huddersfield. Original coursework submitted on **31 October 2025**.


## Model

The design covers locations, car classes, cars, customers, employees, promotions, location-pair drop-off charges and rentals. An `EmployeeRole` lookup table completes the role relationship described in the report.

## Skills demonstrated

Entity relationship modelling, relational mapping, primary and candidate keys, composite keys, foreign keys, normalization analysis, integrity constraints, SQL joins and aggregation.

## Files

| File | Purpose |
| --- | --- |
| `sql/01_schema.sql` | Corrected SQLite table definitions. |
| `sql/02_sample_data.sql` | Fictional records for a small working example. |
| `sql/03_example_queries.sql` | Rental details, fleet counts and drop-off charge lookup. |
| `docs/design-notes.md` | Relationships, changes and design limitations. |
| `run_demo.py` | Build the demo database using Python's standard library. |

## Run locally

Install Python 3.8 or newer; no third-party packages are required. From the repository root:

```bash
python run_demo.py
```

Use `python3` if that is your Python command. The script creates `cars4u.db` and prints query results. It refuses to overwrite an existing database. To rebuild, first rename or remove the generated demo database. You can also run the SQL files in numeric order using a SQLite client against a new database.

Enable `PRAGMA foreign_keys = ON` on **every SQLite connection** before modifying data.

## Enforced rules

- Each rental has exactly one renter: customer or employee.
- Employee rentals cannot use promotions.
- Foreign keys reference existing entities.
- Rental and promotion end dates cannot precede start dates when ISO dates are used.
- Promotion discounts fall between 0 and 100.
- Drop-off charges are non-negative and unique per class/location pair.
- Returned mileage cannot be lower than outgoing mileage.

## Scope

This is a database design portfolio, not a complete rental application. The original report discusses normalization, including BCNF; this repository does not claim that BCNF has been formally proved without a complete set of business functional dependencies. See the design notes for remaining business rules and SQLite limitations.

The original assessment PDF, student identifier and declaration are not included in the upload package.

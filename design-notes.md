# Design notes

## Relationships

| Parent | Child / foreign key | Relationship |
| --- | --- | --- |
| Location | Car.current_location_id | One location to many cars. |
| CarClass | Car.class_id | One class to many cars. |
| Location | Employee.location_id | One location to many employees. |
| EmployeeRole | Employee.role_id | One role to many employees. |
| CarClass | Promotion.class_id | One class to many promotions. |
| CarClass and Location | DropOffCharge.class_id, fromLocation_id, toLocation_id | Charge identified by class and directional location pair. |
| Customer or Employee | Rental.customer_id or employee_id | Each rental has exactly one renter. |
| Car | Rental.car_id | One car to many rentals over time. |
| Location | Rental.pickup_locationid and dropoff_locationid | Separate pickup and drop-off relationships. |
| Promotion | Rental.promotion_id | Optional promotion, restricted to customer rentals. |

## Changes from the report

Corrected `city/town` identifiers, missing/trailing commas, `toTocation_id`, the incomplete Rental statement and inconsistent fuel-level spelling. Added employee/location and drop-off/location foreign keys. Completed the described employee-role relationship with `EmployeeRole`. Added SQL checks for the XOR renter rule, employee promotion restriction and mileage consistency. Phone numbers use strings to preserve leading zeros. SQLite foreign-key enforcement is explicitly enabled.

The original ER diagram shows a smaller model than the full table definitions, omitting some promotion, role and charge details. The relationship table above describes the runnable edition.

## Remaining limitations

- Rental overlap prevention, promotion eligibility by car class/date, staff discount calculations and free-upgrade pricing are not implemented.
- Only the upgrade flag is stored; there is no booked/requested car class to establish the upgrade or original price.
- Car locations do not update automatically when rentals finish.
- Exactly one headquarters is not enforced.
- ISO `YYYY-MM-DD` dates are assumed; date syntax is not fully validated.
- SQLite uses dynamic typing and does not enforce declared VARCHAR lengths or fixed DECIMAL precision. This edition is not a validated MySQL deployment.
- Foreign-key checks require enabling the pragma for each connection.
- The report's normalization claims require a full functional-dependency analysis. Surrogate primary keys alone do not prove BCNF.

## Future work

Document functional dependencies, validate rates and dates more strictly, model booked versus allocated class, enforce booking conflicts, calculate prices, add transactional return processing and implement an application interface.

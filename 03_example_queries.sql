-- New illustrative queries, not extracted from the original coursework.
-- Rental details with the appropriate renter.
SELECT r.rental_id, COALESCE(c.first_name || ' ' || c.last_name, e.first_name || ' ' || e.last_name) AS renter,
       car.license_plate, p.city AS pickup_city, d.city AS dropoff_city
FROM Rental r
LEFT JOIN Customer c ON c.customer_id = r.customer_id
LEFT JOIN Employee e ON e.employee_id = r.employee_id
JOIN Car car ON car.car_id = r.car_id
JOIN Location p ON p.location_id = r.pickup_locationid
JOIN Location d ON d.location_id = r.dropoff_locationid;

-- Stored fleet counts by location, including locations with no cars.
SELECT l.location_id, l.city, COUNT(c.car_id) AS car_count
FROM Location l LEFT JOIN Car c ON c.current_location_id = l.location_id
GROUP BY l.location_id, l.city;

-- Configured drop-off charges for recorded rentals (not a billing calculation).
SELECT r.rental_id, dc.amount_charge
FROM Rental r JOIN Car c ON c.car_id = r.car_id
LEFT JOIN DropOffCharge dc ON dc.class_id = c.class_id
 AND dc.fromLocation_id = r.pickup_locationid AND dc.toLocation_id = r.dropoff_locationid;

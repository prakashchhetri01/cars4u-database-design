-- SQLite adaptation of the October 2025 coursework schema.
PRAGMA foreign_keys = ON;

CREATE TABLE Location (

 location_id     INT PRIMARY KEY,

 street_no       VARCHAR(50) NOT NULL,

 city          VARCHAR(80) NOT NULL,
 postal_code      VARCHAR(20) NOT NULL,

 is_headquarters BOOLEAN          NOT NULL DEFAULT FALSE

);

CREATE TABLE CarClass (

 class_id      INT PRIMARY KEY,

 class_name      VARCHAR(40) UNIQUE NOT NULL,

 rank       INT NOT NULL,

 rate_perday      DECIMAL(10,2) NOT NULL,

 rate_perweek       DECIMAL(10,2) NOT NULL,

 rate_permonth      DECIMAL(10,2) NOT NULL

);

CREATE TABLE Car (

 car_id          INT PRIMARY KEY,

 vin         VARCHAR(50) UNIQUE NOT NULL,

 license_plate     VARCHAR(20) UNIQUE NOT NULL,

 manufacturer           VARCHAR(60) NOT NULL,

 model           VARCHAR(60) NOT NULL,

 year_made          INT NOT NULL,

 colour          VARCHAR(30) NOT NULL,

 mileage          INT NOT NULL,

 class_id        INT NOT NULL,

 current_location_id INT NOT NULL,

 FOREIGN KEY (class_id) REFERENCES CarClass(class_id),

 FOREIGN KEY (current_location_id) REFERENCES Location(location_id)

);

CREATE TABLE Customer (
 customer_id     INT PRIMARY KEY,

 first_name     VARCHAR(60) NOT NULL,

 last_name      VARCHAR(60) NOT NULL,

 street_no     VARCHAR(50) NOT NULL,

 city        VARCHAR(80) NOT NULL,

 postal_code     VARCHAR(20) NOT NULL,

 license_number VARCHAR(50) UNIQUE NOT NULL,

phone_no VARCHAR(30) NOT NULL

);

CREATE TABLE EmployeeRole (
 role_id INTEGER PRIMARY KEY,
 role_name VARCHAR(60) UNIQUE NOT NULL
);

CREATE TABLE Employee (

 employee_id     INT PRIMARY KEY,

 first_name     VARCHAR(60) NOT NULL,

 last_name      VARCHAR(60) NOT NULL,

 street_no     VARCHAR(50) NOT NULL,

 city        VARCHAR(80) NOT NULL,

 postal_code     VARCHAR(20) NOT NULL,
 license_number VARCHAR(50) UNIQUE NOT NULL,

 role_id       INT NOT NULL,

 location_id    INT NOT NULL,

 phone_no VARCHAR(30) NOT NULL,
 FOREIGN KEY (role_id) REFERENCES EmployeeRole(role_id),
 FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

CREATE TABLE Promotion (

 promotion_id     INT PRIMARY KEY,

 class_id      INT NOT NULL,

 week_start      DATE NOT NULL,

 week_end        DATE NOT NULL,

 discount_percent DECIMAL(5,2) NOT NULL DEFAULT 60.00,

 FOREIGN KEY (class_id) REFERENCES CarClass(class_id),

 CHECK (discount_percent >= 0 AND discount_percent <= 100),

 CHECK (week_end >= week_start)

);

CREATE TABLE DropOffCharge (

 class_id      INT NOT NULL,

 fromLocation_id INT NOT NULL,

 toLocation_id INT NOT NULL,

 amount_charge     DECIMAL(10,2) NOT NULL,

 PRIMARY KEY (class_id, fromLocation_id, toLocation_id),

 FOREIGN KEY (class_id) REFERENCES CarClass(class_id),

 FOREIGN KEY (fromLocation_id) REFERENCES Location(location_id),
 FOREIGN KEY (toLocation_id) REFERENCES Location(location_id),
 CHECK (amount_charge >= 0)

);

CREATE TABLE Rental (

 rental_id       INT PRIMARY KEY,
customer_id          INT NULL,

employee_id          INT NULL,

car_id         INT NOT NULL,

is_upgrade          BOOLEAN NOT NULL DEFAULT FALSE,

start_date          DATE NOT NULL,

end_date            DATE NOT NULL,

pickup_locationid INT NOT NULL,

dropoff_locationid INT NOT NULL,

mileage_out          INT NOT NULL,

mileage_in          INT NULL, -- in on return

fuel_level     VARCHAR(20) NULL, -- {Empty,Quarter,Half,ThreeQuarters,Full}

promotion_id         INT NULL, -- must be NULL for employee rentals

FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),

FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),

FOREIGN KEY (car_id) REFERENCES Car(car_id),

FOREIGN KEY (pickup_locationid) REFERENCES Location(location_id),

FOREIGN KEY (dropoff_locationid) REFERENCES Location(location_id),

FOREIGN KEY (promotion_id) REFERENCES Promotion(promotion_id),

CHECK (end_date >= start_date),

CHECK (fuel_level IN ('Empty','Quarter','Half','ThreeQuarters','Full') OR fuel_level IS NULL),
 CHECK ((customer_id IS NOT NULL AND employee_id IS NULL) OR
        (customer_id IS NULL AND employee_id IS NOT NULL)),
 CHECK (employee_id IS NULL OR promotion_id IS NULL),
 CHECK (mileage_out >= 0),
 CHECK (mileage_in IS NULL OR mileage_in >= mileage_out)
);

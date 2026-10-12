-- Fictional demonstration data added for the GitHub edition.
PRAGMA foreign_keys = ON;
INSERT INTO Location VALUES (1, '1 Example Street', 'Huddersfield', 'DEMO1', 1), (2, '2 Example Road', 'Leeds', 'DEMO2', 0);
INSERT INTO CarClass VALUES (1, 'Economy', 1, 30, 180, 600), (2, 'SUV', 2, 60, 360, 1200);
INSERT INTO EmployeeRole VALUES (1, 'Rental assistant');
INSERT INTO Car VALUES (1, 'DEMO-VIN-001', 'DEMO-001', 'Example Motors', 'City', 2024, 'Blue', 12000, 1, 1), (2, 'DEMO-VIN-002', 'DEMO-002', 'Example Motors', 'Trail', 2024, 'Silver', 9000, 2, 2);
INSERT INTO Customer VALUES (1, 'Demo', 'Customer', '3 Sample Street', 'Huddersfield', 'DEMO3', 'DEMO-LIC-001', '00000000001');
INSERT INTO Employee VALUES (1, 'Demo', 'Employee', '4 Sample Street', 'Leeds', 'DEMO4', 'DEMO-LIC-002', 1, 1, '00000000002');
INSERT INTO Promotion VALUES (1, 1, '2025-10-01', '2025-10-31', 10);
INSERT INTO DropOffCharge VALUES (1, 1, 2, 25), (2, 2, 1, 40);
INSERT INTO Rental VALUES (1, 1, NULL, 1, 0, '2025-10-10', '2025-10-12', 1, 2, 12000, 12200, 'Full', 1), (2, NULL, 1, 2, 0, '2025-10-20', '2025-10-21', 2, 1, 9000, NULL, NULL, NULL);

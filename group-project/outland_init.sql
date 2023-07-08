-- drop database user if exists 
DROP USER IF EXISTS 'outland_user'@'localhost';

-- create outland_user
CREATE USER 'outland_user'@'localhost' IDENTIFIED WITH mysql_native_password BY 'adventures';

-- grant all privileges to the outland_adventures database to user outland_user on localhost 
GRANT ALL PRIVILEGES ON outland_adventures.* TO 'outland_user'@'localhost';

-- drop tables if they are present
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS Trip;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Location;


-- Create Location table
CREATE TABLE Location (

    location_id    INT  NOT NULL  AUTO_INCREMENT,
    location_name    VARCHAR(50)  NOT NULL,
    season    VARCHAR(6)  NOT NULL,
    total_bookings    INT,
    
    PRIMARY KEY(location_id)

);


-- Create Inventory table
CREATE TABLE Inventory ( 

    inventory_id    INT  NOT NULL  AUTO_INCREMENT,
    category    VARCHAR(50)  NOT NULL,
    quantity    INT  NOT NULL,
    total_sales    INT,
    
    PRIMARY KEY(inventory_id)

);


-- Create Employee table
CREATE TABLE Employee ( 

    employee_id    INT  NOT NULL  AUTO_INCREMENT,
    employee_name    VARCHAR(100)  NOT NULL,
    job_title    VARCHAR(50),
    employee_visa    VARCHAR(20),
    employee_passport    VARCHAR(20),
    employee_airfare    VARCHAR(20),
    
    PRIMARY KEY(employee_id)

);


-- Create Trip table
CREATE TABLE Trip (

    trip_id    INT  NOT NULL  AUTO_INCREMENT,
    trip_type    VARCHAR(50)  NOT NULL,
    start_date    DATE  NOT NULL,
    end_date    DATE  NOT NULL,
    number_of_bookings    INT,
    location_id    INT  NOT NULL,
    employee_id    INT  NOT NULL,
    
    PRIMARY KEY(trip_id),
    
    CONSTRAINT fk_location
    FOREIGN KEY (location_id)
        REFERENCES Location(location_id),
    
    CONSTRAINT fk_employee
    FOREIGN KEY (employee_id)
        REFERENCES Employee(employee_id)

);


-- Create Equipment table
CREATE TABLE Equipment ( 

    equipment_id    INT  NOT NULL  AUTO_INCREMENT,
    equipment_name    VARCHAR(100)  NOT NULL,
    type    VARCHAR(6),
    purchase_date    DATE  NOT NULL,
    inventory_id    INT  NOT NULL,
    
    PRIMARY KEY(equipment_id),
    
    CONSTRAINT fk_inventory
    FOREIGN KEY (inventory_id)
        REFERENCES Inventory(inventory_id) 

);


-- Create Customer table
CREATE TABLE Customer (

    customer_id    INT  NOT NULL  AUTO_INCREMENT,
    first_name    VARCHAR(50)  NOT NULL,
    last_name    VARCHAR(50)  NOT NULL,
    email    VARCHAR(100),
    phone    VARCHAR(20),
    address    VARCHAR(200),
    visa_status    VARCHAR(20),
    passport_status    VARCHAR(20),
    airfare_status    VARCHAR(20),
    equipment_id    INT,
    trip_id    INT,

    PRIMARY KEY(customer_id),
    
    CONSTRAINT fk_equipment
    FOREIGN KEY(equipment_id)
        REFERENCES Equipment(equipment_id),
    
    CONSTRAINT fk_trip
    FOREIGN KEY(trip_id)
        REFERENCES Trip(trip_id)

);


-- Insert data into Location table
INSERT INTO Location (location_name, season, total_bookings)  
    VALUES  
    ('Africa', 'Spring', 22),
    ('Asia','Spring', 38),
    ('Europe', 'Spring', 25),
    ('Africa', 'Fall', 7),
    ('Asia', 'Fall', 30),
    ('Europe', 'Fall', 17); 


-- Insert data into Inventory table
INSERT INTO Inventory (category, quantity, total_sales)
    VALUES
    ('Tents', 19, 22),
    ('Backpacks', 25, 7),
    ('Jackets', 43, 43),
    ('Pants', 18, 37),
    ('Hiking Gear', 15, 12),
    ('Sleeping Gear', 24, 26),
    ('Misc. Gear', 38, 9);
  

-- Insert data into Employee table 
INSERT INTO Employee (employee_name, job_title, employee_visa, employee_passport, employee_airfare)
    VALUES
    ('Blythe Timmerson', 'Owner', 'Valid', 'Valid', 'Scheduled'),
    ('Jim Ford', 'Owner', 'Valid', 'Valid', 'Scheduled'),
    ('John MacNell', 'Camping Guide', 'Valid', 'Valid', 'Scheduled'),
    ('D.B. Marland', 'Hiking Guide', 'Valid', 'Valid', 'Scheduled'),
    ('Anita Gallegos', 'Marketing Manager', 'Valid', 'Valid', 'Not Scheduled'),
    ('Dimitrios Stravopolous', 'Inventory Manager', 'Valid', 'Valid', 'Not Scheduled'),
    ('Mei Wong', 'Website Manager', 'Valid', 'Valid', 'Not Scheduled');


-- Insert data into Trip table
INSERT INTO Trip (trip_type, start_date, end_date, number_of_bookings, location_id, employee_id)
    VALUES  
    ('Camping', '2022-04-08', '2022-04-23', 12, 1, 3),
    ('Hiking', '2022-04-29', '2022-05-14', 21, 2, 4),
    ('Hiking', '2022-05-27', '2022-06-11', 25, 3, 4),
    ('Camping', '2022-09-02', '2022-09-17', 7, 4, 3),
    ('Camping', '2022-09-30', '2022-10-15', 12, 5, 3),
    ('Hiking', '2022-10-28', '2022-11-12', 17, 6, 4),
    ('Hiking', '2023-04-07', '2023-04-22', 10, 1, 4),
    ('Camping', '2023-05-05', '2023-05-20', 17, 2, 3),
    ('Hiking', '2023-10-02', '2023-10-17', 18, 5, 4); 


-- Insert data into Equipment table  
INSERT INTO Equipment (equipment_name, type, purchase_date, inventory_id)
    VALUES
    ('Tent', 'Rental', '2019-06-27', 1),
    ('Ruck Sack', 'Rental', '2021-06-26', 2),
    ('Camel Back', NULL, '2022-06-25', 2),
    ('Walking Cane', 'Rental', '2022-06-25', 5),
    ('Rain Jacket', NULL, '2019-06-27', 3),
    ('Rain Slacks', 'Rental', '2019-06-27', 4),
    ('Sleeping Bag', 'Rental', '2017-06-29', 6); 


-- Insert data into Customer table
INSERT INTO Customer (first_name, last_name, email, phone, address, visa_status, passport_status, airfare_status, equipment_id, trip_id)
    VALUES
    ('Randy', 'Miles', 'rmiles@duelue.com', '1(555)987-6543', '123 Blanc Ave., Huntsville, Alabama, 00000', 'Valid', 'Valid', 'Scheduled', 3, 7),
    ('Sandy', 'Scott', 'sscot@duelue.com', '1(555)845-9173', '1823 Beach Drive, 	Bellevue, Nebraska, 22341', 'Valid', 'Invalid', 'Scheduled', 4, 2),
    ('Wulf', 'Vasquez', 'wvasquez@duelue.com', '1(555)747-5584', '01 Dutch Blv., 	Sitka, Alaska, 11112', 'Valid', 'Valid', 'Not Scheduled', 1, 4),
    ('Brunhilda', 'Walsh', 'bwalsh@duelue.com', '1(555)889-1766', '1550 Marcus 	Drive, Seattle, Washington', 'Valid', 'Valid', 'Scheduled', 6, 1),
    ('Sandy', 'Scott', 'sscot@duelue.com', '1(555)845-9173', '1823 Beach Drive, Bellevue, Nebraska, 22341', 'Valid', 'Invalid', 'Scheduled', 2, 3),
    ('Yeska', 'Wushan', 'ywushan@duelue.com', '1(555)189-1278', '841 Valor Road, Colorado Springs, Colorado, 67673', 'Not Valid', 'Valid', 'Scheduled', NULL, 8);



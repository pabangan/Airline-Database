##### Stored Procedures #####

USE `Airplanes_Project` ;

#### Aircraft and Flights #####


# (1) Insert new Aircraft and assign it to a Flight # w/ Time

DELIMITER //
CREATE PROCEDURE AssignAircraftToFlight(IN Aircraft_Num INT, IN Flight_Num INT, IN CompanyName VARCHAR(45), IN NewStatus VARCHAR(45),
 IN Dep_Time DATETIME, IN Arr_time DATETIME)

BEGIN

INSERT INTO Aircraft(`idAircraft`,`Company`,`Status`)
VALUES
(Aircraft_Num, CompanyName, NewStatus) ;

INSERT INTO Flights
VALUES 
(Flight_Num,Aircraft_Num, Dep_Time, Arr_Time) ;

END //

DELIMITER ;

# Test it - make some data

CALL AssignAircraftToFlight(54,249,"American", "Not Available",'2018-07-14 16:30:00','2018-07-14 18:30:00') ;

CALL AssignAircraftToFlight(16,154,"Delta", "Not Available",'2019-07-19 16:0:00','2019-07-19 19:30:00') ;


# (2)  Aircraft Table - Grab first N records of table

DELIMITER //
CREATE PROCEDURE FirstNAircrafts(IN var1 INT)

BEGIN

	SELECT  *
		FROM Aircraft
	LIMIT var1 ;

END //


DELIMITER ;

# Check it

CALL FirstNAircrafts(1) ;


# (3) Flights Table - Get all flights arriving between two specific times

DELIMITER //

CREATE PROCEDURE SearchTimeFlights(IN startDate DATETIME, IN endDate DATETIME)

BEGIN

	SELECT  *
		FROM Flights
	WHERE `Arrival Time` BETWEEN startDate AND endDate ;

END //


DELIMITER ;

# Check it - Flights Arriving in 2018

CALL SearchTimeFlights('2018-01-01', '2019-01-01') ;


#### AA Account & AA Log-In #####

# (1) Create new account

DELIMITER //
CREATE PROCEDURE CreateUser(IN email VARCHAR(45), IN FirstName VARCHAR(45), IN LastName VARCHAR(45), IN DOB DATE,
 IN Gender VARCHAR(45), IN Phone VARCHAR(20), IN Password_id VARCHAR(45))

BEGIN

INSERT INTO Users(`Primary Email`,`First Name`,`Last Name`, `Date of Birth`, `Gender`, `Primary Phone #`,
`Password`)
VALUES
(email, FirstName, LastName, DOB, Gender, Phone, Password_id) ;

END //

DELIMITER ;

# Get some data to test

CALL CreateUser("testing123@gmail.com", "Bill", "Smith", "1995-03-09", "Male", "589-429-1029","password") ;

CALL CreateUser("sql_lover21@gmail.com", "Sarah", "Jones", "1984-09-28", "Female", "212-009-8390","CRUD_Anomalies") ;


# (2) Update User password

DELIMITER //
CREATE PROCEDURE UpdateUser(IN  user_email VARCHAR(45), update_pass VARCHAR(45))

BEGIN
 
 UPDATE Users
 SET `Password` = update_pass
 WHERE `Primary Email` = user_email ;

END //

DELIMITER ;

# Check it

CALL UpdateUser("testing123@gmail.com", "StrongerPassword!") ;

#### Your Trips ####

# (1) Book a trip for a User


DELIMITER //
CREATE PROCEDURE BookFlight(IN user_email VARCHAR(45), IN Flight_Num INT, IN Time_ordered DATETIME)

BEGIN
 
INSERT INTO Bookings
VALUES
(Flight_Num,user_email, Time_ordered) ;

END //

DELIMITER ;

# Check - add data 

# Q? Is there a function which when you create data will make an attribute with when it was created?

CALL BookFlight("testing123@gmail.com", 16, '2019-05-12 19:03:21') ;
CALL BookFlight("sql_lover21@gmail.com", 54, '2018-02-12 10:01:01') ;
CALL BookFlight("testing123@gmail.com", 54, '2017-05-12 16:02:58') ;


# (2) Retrieve all of a User's Flights

DELIMITER //
CREATE PROCEDURE GetTrips(IN  user_email VARCHAR(45))

BEGIN
 
 SELECT * 
 FROM Bookings
 WHERE `Users_Primary Email` = user_email ;

END //

DELIMITER ;

# Check

CALL GetTrips("testing123@gmail.com") ;

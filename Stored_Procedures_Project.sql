##### Stored Procedures #####

USE `Airplanes_Project` ;

# FK CHECKS ON
SET FOREIGN_KEY_CHECKS=1 ;

#### Make a bunch of data ####

DELIMITER //
CREATE PROCEDURE CreateData()
BEGIN

    DECLARE i INT DEFAULT 001 ;
    WHILE i <= 1000 DO
		/* Aircraft Strong Entity */
        INSERT INTO Aircraft VALUES (i, "Delta",NULL,NULL,NULL,NULL,NULL,NULL, "Available");
        /* Employee Strong Entity */
        INSERT INTO Employee VALUES (i, "John","Doe","American");
        /* Users Strong Entity */
        INSERT INTO Users VALUES (CONCAT("myemail",i,"@gmail.com"), "Bill","Smith",NULL,'1995-03-10',"Male","123-456-7890","Password!",NULL);
        SET i = i + 1;        
	END WHILE ;
    
END //

CALL CreateData() ;


/* Airports Strong Entity - Make several ones for Big Cities */

INSERT INTO Airports 
VALUES (1, "Cedar Rapids", "Iowa", NULL), (2, "Orlando", "Florida",NULL), (3, "Dallas", "Texas", NULL), (4, "Minneapolis", "Minnesota", NULL),
(5, "San Francisco", "California", NULL), (6, "Cincinnati", "Ohio", NULL), (7, "Chicago", "Illinois", NULL),
(8, "Denver", "Colorado", NULL), (9, "Boston", "Massachusetts",NULL), (10, "Lincoln", "Nebraska", NULL),
(11, "Detroit", "Michigan", NULL), (12, "Philadelphia", "Pennsylvania", NULL), (13, "Atlanta", "Georgia", NULL) ;

# *EXTRA* For given Aircraft, Populate Seats with ID and Section 

DELIMITER //
CREATE PROCEDURE Seats_Aircraft(IN Aircraft_Num INT, IN Rows_on_Plane INT)
BEGIN

    DECLARE i INT DEFAULT 001 ;
	REPEAT
        INSERT INTO Seats VALUES (i,Aircraft_Num, "A", i);
        INSERT INTO Seats VALUES (i + Rows_on_Plane,Aircraft_Num, "B", i);
        INSERT INTO Seats VALUES (i + 2*Rows_on_Plane,Aircraft_Num, "C", i);
        INSERT INTO Seats VALUES (i+ 3*Rows_on_Plane,Aircraft_Num, "D", i);
        INSERT INTO Seats VALUES (i+ 4*Rows_on_Plane,Aircraft_Num, "E", i);
        INSERT INTO Seats VALUES (i+ 5*Rows_on_Plane,Aircraft_Num, "F", i);
        SET i = i + 1 ;
		UNTIL i > Rows_on_Plane
	END REPEAT ;
    
END //

# Fill some in
CALL Seats_Aircraft(1,25) ;
CALL Seats_Aircraft(2,25) ;
CALL Seats_Aircraft(154,40) ;
CALL Seats_Aircraft(249,35) ;


#### Aircraft and Flights - SP #####


# (1) Update specific Aircraft  to a Flight # w/ Time - update Aircraft as needed

DELIMITER //
CREATE PROCEDURE AssignAircraftToFlight(IN Flight_Num INT, IN Aircraft_Num INT,  IN CompanyName VARCHAR(45), IN NewStatus VARCHAR(45),
 IN Dep_Time DATETIME, IN Arr_time DATETIME)

BEGIN

UPDATE Aircraft
SET  `Company` = CompanyName, `Status` = NewStatus
WHERE `idAircraft` = Aircraft_Num ;

INSERT INTO Flights
VALUES 
(Flight_Num,Aircraft_Num, Dep_Time, Arr_Time) ;

END //

DELIMITER ;


# Test it - make some data

CALL AssignAircraftToFlight(54,249,"American", "Not Available",'2018-07-14 16:30:00','2018-07-14 18:30:00') ;

CALL AssignAircraftToFlight(16,154,"Delta", "Not Available",'2019-07-19 16:0:00','2019-07-19 19:30:00') ;


# Extra SP - Flight Destinations

DELIMITER //
CREATE PROCEDURE InsertFlightDestinations(IN Flight_Num INT, IN AirportID INT,
IN Location VARCHAR(45))

BEGIN

INSERT INTO `Flight Destinations`
VALUES 
(Flight_Num,AirportID, Location) ;

END //

DELIMITER ;

# Test it
CALL InsertFlightDestinations(16,1,"Departing") ;
CALL InsertFlightDestinations(16,2,"Arriving") ;

CALL InsertFlightDestinations(54,6,"Departing") ;
CALL InsertFlightDestinations(54,13,"Arriving") ;


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

CALL FirstNAircrafts(14) ;


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

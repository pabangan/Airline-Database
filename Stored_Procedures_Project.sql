##### Stored Procedures #####

# (1)  Aircraft Table - Grab first N records of table

DELIMITER //
CREATE PROCEDURE FirstNAircrafts(IN var1 INT)

BEGIN

	SELECT  *
		FROM Aircraft
	LIMIT var1 ;

END //



DELIMITER ;


# (2) Employees - Select all employees from a given Airline Company (like Delta)


DELIMITER //
CREATE PROCEDURE AllCompanyEmps(IN companyName varchar(45))

BEGIN

	SELECT  *
		FROM Employee
	WHERE `Company` = companyName ;

END //


DELIMITER ;

CALL AllCompanyEmps("Delta") ;


# (3) Flights Table - Get all flights arriving between two specific times

DELIMITER //

CREATE PROCEDURE SearchTimeFlights(IN startDate DATETIME, IN endDate DATETIME)

BEGIN

	SELECT  *
		FROM Flights
	WHERE `Arrival Time` BETWEEN startDate AND endDate ;

END //


DELIMITER ;

CALL SearchTimeFlights('2018-01-01', '2019-01-01') ;



##### Make sure final one works - add in data to flights table #####

INSERT INTO Flights
VALUES 
('1','21','2018-06-02 14:30:00','2018-06-02 12:30:00'), 
('2','24','2017-06-02 14:30:00','2017-06-02 12:30:00') ;

# It does sweet!

# Now delete this - we need to insert a bunch of data into our tables
# Test out basics - booking a flight
# Changing flight time
# Log-in
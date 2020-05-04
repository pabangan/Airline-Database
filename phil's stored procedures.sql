-- BEGINING OF PHIL'S STORED PROCEDURES ---------------------------------------------------------------------------------------------------
-- news about vacations----------------------------------------------------
DELIMITER //
CREATE PROCEDURE spRetrieveNewsByAirportID(IN input_idAirports INT)
BEGIN
	SELECT News
    FROM Airports
    WHERE idAirports = input_idAirports;
    
END //

DELIMITER ;

# Test it - make some data
#INSERT INTO Airports(`idAirports`,`City`,`State`, `News`)
#VALUES
#(1, 'Chicago', 'Illinois',"News about O'Hare International Airport") ;

CALL spRetrieveNewsByAirportID(1) ;

-- Contact Us ------------------------------------------------------------------ Data not stored b/c contact info stored in users

-- About Us ------------------------------------------------------------------ No data stored for About Us. Will be front end.

-- Advanced Search ---------------------------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE spSearchFlightsByCityDestination(IN input_FlightCityDestination VARCHAR(45))
BEGIN
	SELECT *
    FROM Flights
    WHERE idFlights IN (SELECT Flights_idFlights from `Flight Destinations` where Airports_idAirports IN (SELECT idAirports from Airports where City = input_FlightCityDestination));
END //

DELIMITER ;
# Test it - make some data
#INSERT INTO Airports(`idAirports`,`City`,`State`, `News`) VALUES (1, 'Chicago', 'Illinois',"News about O'Hare International Airport") ;
#INSERT INTO Aircraft(`idAircraft`,`Company`,`Status`) VALUES (16, "Not Available", "Not Available") ;
#INSERT INTO Flights VALUES (16,154,"Delta", "Not Available",'2019-07-19 16:0:00','2019-07-19 19:30:00');

CALL spSearchFlightsByCityDestination('Chicago') ;

------------------------------------------------------------------------------------------------

DELIMITER //
CREATE PROCEDURE spSearchFlightsByCityandTime(IN input_FlightCityDestination VARCHAR(45), IN input_BeginningTime DATETIME, IN input_EndTime DATETIME) 
BEGIN
	SELECT *
    FROM Flights
    
    
    WHERE 
		(`Departure Time` <= input_BeginningTime) -- beginning from this condition and
		AND (`Arrival Time` >= input_EndTime) -- ending before this condition
		AND (idFlights IN (SELECT Flights_idFlights from `Flight Destinations` where Airports_idAirports IN (SELECT idAirports from Airports where City = input_FlightCityDestination))); -- City condition
END //

DELIMITER ;
# Test it - make some data
#INSERT INTO Airports(`idAirports`,`City`,`State`, `News`) VALUES (1, 'Chicago', 'Illinois',"News about O'Hare International Airport") ;
#INSERT INTO Aircraft(`idAircraft`,`Company`,`Status`) VALUES (16, "Not Available", "Not Available") ;
#INSERT INTO Flights VALUES (16,154,"Delta", "Not Available",'2019-07-19 16:0:00','2019-07-19 19:30:00');

CALL spSearchFlightsByCityandTime('Chicago', '2010-07-19 19:30:00', '2050-07-19 19:30:00') ;


-- Trip cancellation or change ------------------------------------------------------------------ 
DELIMITER //
CREATE PROCEDURE spDelFlightFromUser(IN input_userEmail INT, IN input_flightID INT)
BEGIN
	DELETE `Flights_idFlights`, `Users_Primary Email`, `Time Ordered`
    FROM Bookings
    WHERE Flights_idFlights=input_flightID AND `Users_Primary Email`=input_userEmail;
END //

DELIMITER ;
# Test it - make some data
#INSERT INTO Airports(`idAirports`,`City`,`State`, `News`) VALUES (1, 'Chicago', 'Illinois',"News about O'Hare International Airport") ;
#INSERT INTO Aircraft(`idAircraft`,`Company`,`Status`) VALUES (16, "Not Available", "Not Available") ;
#INSERT INTO Flights(`idFlights`, `Aircraft_idAircraft`, `Departure Time`, `Arrival TIme`) 
#	VALUES (16,154,"Delta", "Not Available",'2019-07-19 16:0:00','2019-07-19 19:30:00');
#INSERT INTO Users(`Primary Email`, `First Name`, `Last Name`, `Middle Name`, `Date of Birth`, `Gender`, `Primary Phone #`, `Password`, `Known Travelor #`) 
#	VALUES ('test@test.com', 'TestFirst', 'TestLast', 'TestMiddle', '1996-02-08 16:0:00', 'Male', '1234567899', 'password', 1);
#INSERT INTO Bookings(`Flights_idFlights`, `Users_Primary Email`, `Time Ordered`) VALUES (16, 'test@test.com', '2019-07-19 16:0:00');
#INSERT INTO Ticket(`Seats_idSeats`, `Bookings_Flights_idFlights`, `Bookings_Users_Primary Email`, `Amenities`, `Cost`) VALUES (); 

CALL spDelFlightFromUser('myemail1@gmail.com',16) ;

-- END OF PHIL'S STORED PROCEDURES -------------------------------------------------------------------------------------------------------

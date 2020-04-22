# Given passenger ID and date/type of trip selected, assign passenger to a flight ID that has
# open seats for that trip
# assume 10 is ticket price
DELIMITER //
CREATE PROCEDURE  assignFlight(IN  user_email VARCHAR(45), IN flightNum int)
BEGIN
insert into bookings values(flightNum,user_email,now());
update users set credit = credit+10 where user_email=`Primary Email`;
END //
DELIMITER ;

# • Given flight number, extract all the filled seats of the flight.
DELIMITER //
CREATE PROCEDURE  extractFilledSeats(IN  flightNumber int )
BEGIN
select * from ticket where Bookings_Flights_idFlights= flightNumber;
END //
DELIMITER ;

# • Given the date, then extract the flight available.
DELIMITER //
CREATE PROCEDURE  searchAvailableFlight(IN  date date )
BEGIN
select * from flights where date(`Departure Time`)=date;
END //
DELIMITER ;

# Given selected locations, list Departure city, arrival city or multi city.
DELIMITER //
CREATE PROCEDURE  searchLocation(IN  cityName varchar(45) )
BEGIN
select * from airports where City=cityName;
END //
DELIMITER ;

# Select number of passengers
DELIMITER //
CREATE PROCEDURE  passengersNum(IN  flight int )
BEGIN
select count(*) from ticket where Bookings_Flights_idFlights=flight;
END //
DELIMITER ;

# Select number of passengers
DELIMITER //
CREATE PROCEDURE  passengersNum(IN  flight int )
BEGIN
select count(*) from ticket where Bookings_Flights_idFlights=flight;
END //
DELIMITER ;

# Given passengers ID, extract award credit, and list miles that you earn.
DELIMITER //
CREATE PROCEDURE  passengersNum(IN  email varchar(30) )
BEGIN
select credit from users where `Primary Email` = email;
END //
DELIMITER ;


# Given departure city and arrival city, and date, then extract all the flight status on that day


# Given check status, then extract flight numbers, departure time, arrival time, departure city,
# arrival city, terminal number, gate number.
DELIMITER //
CREATE PROCEDURE  extract(IN  status varchar(30) )
BEGIN
select * from aircraft where Status=status;
END //
DELIMITER ;

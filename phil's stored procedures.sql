-- MySQL Script generated by MySQL Workbench
-- Mon Apr 20 11:19:26 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Aircraft`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Aircraft` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Aircraft` (
  `idAircraft` INT NOT NULL,
  `Company` VARCHAR(45) NOT NULL,
  `Plane Type` VARCHAR(45) NULL,
  `Seat Count` VARCHAR(45) NULL,
  `Seat Pitch` VARCHAR(45) NULL,
  `Seat Width` VARCHAR(45) NULL,
  `Wi-Fi` VARCHAR(45) NULL,
  `Entertainment` VARCHAR(45) NULL,
  PRIMARY KEY (`idAircraft`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Airports`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Airports` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Airports` (
  `idAirports` INT NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `News` VARCHAR(1000) NULL,
  PRIMARY KEY (`idAirports`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `idAirports_UNIQUE` ON `mydb`.`Airports` (`idAirports` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Airports_copy1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Airports_copy1` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Airports_copy1` (
  `idAirports` INT NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `News` VARCHAR(1000) NULL,
  `State` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAirports`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Bookings` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Bookings` (
  `Flights_idFlights` INT NOT NULL,
  `Users_Primary Email` INT NOT NULL,
  `Time Ordered` DATETIME NOT NULL,
  PRIMARY KEY (`Flights_idFlights`, `Users_Primary Email`),
  CONSTRAINT `fk_Flights_has_Users_Flights1`
    FOREIGN KEY (`Flights_idFlights`)
    REFERENCES `mydb`.`Flights` (`idFlights`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flights_has_Users_Users1`
    FOREIGN KEY (`Users_Primary Email`)
    REFERENCES `mydb`.`Users` (`Primary Email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_Flights_has_Users_Users1_idx` ON `mydb`.`Bookings` (`Users_Primary Email` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_Flights_has_Users_Flights1_idx` ON `mydb`.`Bookings` (`Flights_idFlights` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Employee` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `idEmployee` INT NOT NULL,
  `First Name` VARCHAR(45) NOT NULL,
  `Last Name` VARCHAR(45) NOT NULL,
  `Company` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmployee`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Flight Crew`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Flight Crew` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Flight Crew` (
  `Flights_idFlights` INT NOT NULL,
  `Employee_idEmployee` INT NOT NULL,
  `Position` VARCHAR(45) NOT NULL,
  `Pay` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Flights_idFlights`, `Employee_idEmployee`),
  CONSTRAINT `fk_Flights_has_Employee_Flights1`
    FOREIGN KEY (`Flights_idFlights`)
    REFERENCES `mydb`.`Flights` (`idFlights`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flights_has_Employee_Employee1`
    FOREIGN KEY (`Employee_idEmployee`)
    REFERENCES `mydb`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_Flights_has_Employee_Employee1_idx` ON `mydb`.`Flight Crew` (`Employee_idEmployee` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_Flights_has_Employee_Flights1_idx` ON `mydb`.`Flight Crew` (`Flights_idFlights` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Flight Destinations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Flight Destinations` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Flight Destinations` (
  `Flights_idFlights` INT NOT NULL,
  `Airports_idAirports` INT NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Flights_idFlights`, `Airports_idAirports`),
  CONSTRAINT `fk_Flights_has_Airports_Flights1`
    FOREIGN KEY (`Flights_idFlights`)
    REFERENCES `mydb`.`Flights` (`idFlights`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flights_has_Airports_Airports1`
    FOREIGN KEY (`Airports_idAirports`)
    REFERENCES `mydb`.`Airports` (`idAirports`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_Flights_has_Airports_Airports1_idx` ON `mydb`.`Flight Destinations` (`Airports_idAirports` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_Flights_has_Airports_Flights1_idx` ON `mydb`.`Flight Destinations` (`Flights_idFlights` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Flights`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Flights` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Flights` (
  `idFlights` INT NOT NULL,
  `Aircraft_idAircraft` INT NOT NULL,
  `Departure Time` DATETIME NOT NULL,
  `Arrival Time` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFlights`),
  CONSTRAINT `fk_Flights_Aircraft`
    FOREIGN KEY (`Aircraft_idAircraft`)
    REFERENCES `mydb`.`Aircraft` (`idAircraft`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_Flights_Aircraft_idx` ON `mydb`.`Flights` (`Aircraft_idAircraft` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Seat Designation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Seat Designation` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Seat Designation` (
  `Flights_idFlights` INT NOT NULL,
  `Seats_idSeats` INT NOT NULL,
  `Zone` VARCHAR(45) NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Flights_idFlights`, `Seats_idSeats`),
  CONSTRAINT `fk_Flights_has_Seats_Flights1`
    FOREIGN KEY (`Flights_idFlights`)
    REFERENCES `mydb`.`Flights` (`idFlights`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flights_has_Seats_Seats1`
    FOREIGN KEY (`Seats_idSeats`)
    REFERENCES `mydb`.`Seats` (`idSeats`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_Flights_has_Seats_Seats1_idx` ON `mydb`.`Seat Designation` (`Seats_idSeats` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_Flights_has_Seats_Flights1_idx` ON `mydb`.`Seat Designation` (`Flights_idFlights` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Seats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Seats` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Seats` (
  `idSeats` INT NOT NULL,
  `Aircraft_idAircraft` INT NOT NULL,
  `Section` VARCHAR(45) NOT NULL,
  `Number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSeats`, `Aircraft_idAircraft`),
  CONSTRAINT `fk_Seats_Aircraft1`
    FOREIGN KEY (`Aircraft_idAircraft`)
    REFERENCES `mydb`.`Aircraft` (`idAircraft`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_Seats_Aircraft1_idx` ON `mydb`.`Seats` (`Aircraft_idAircraft` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Ticket` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Ticket` (
  `Seats_idSeats` INT NOT NULL,
  `Bookings_Flights_idFlights` INT NOT NULL,
  `Bookings_Users_Primary Email` INT NOT NULL,
  `Amenities` VARCHAR(45) NULL,
  `Cost` DECIMAL NOT NULL,
  PRIMARY KEY (`Seats_idSeats`, `Bookings_Flights_idFlights`, `Bookings_Users_Primary Email`),
  CONSTRAINT `fk_Seats_has_Bookings_Seats1`
    FOREIGN KEY (`Seats_idSeats`)
    REFERENCES `mydb`.`Seats` (`idSeats`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Seats_has_Bookings_Bookings1`
    FOREIGN KEY (`Bookings_Flights_idFlights` , `Bookings_Users_Primary Email`)
    REFERENCES `mydb`.`Bookings` (`Flights_idFlights` , `Users_Primary Email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_Seats_has_Bookings_Bookings1_idx` ON `mydb`.`Ticket` (`Bookings_Flights_idFlights` ASC, `Bookings_Users_Primary Email` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_Seats_has_Bookings_Seats1_idx` ON `mydb`.`Ticket` (`Seats_idSeats` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Users` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `Primary Email` INT NOT NULL,
  `First Name` VARCHAR(45) NOT NULL,
  `Last Name` VARCHAR(45) NOT NULL,
  `Middle Name` VARCHAR(45) NULL,
  `Date of Birth` DATE NOT NULL,
  `Gender` VARCHAR(45) NOT NULL,
  `Userscol` VARCHAR(45) NULL,
  `Primary Phone #` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Known Traveler #` VARCHAR(45) NULL,
  PRIMARY KEY (`Primary Email`))
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

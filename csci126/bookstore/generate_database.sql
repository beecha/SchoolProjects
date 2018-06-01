-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema photography
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema photography
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `photography` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `photography` ;

-- -----------------------------------------------------
-- Table `photography`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `photography`.`users` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL,
  PRIMARY KEY (`userID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `photography`.`rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `photography`.`rating` (
  `picID` INT NOT NULL,
  `userID` INT NOT NULL,
  `rating` ENUM('1','2','3','4','5') NULL DEFAULT '1',
  `comment` VARCHAR(200) NULL,
  INDEX `userID_idx` (`userID` ASC),
  UNIQUE INDEX `picID_UNIQUE` (`picID` ASC),
  PRIMARY KEY (`userID`),
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `photography`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `photography`.`manufacturers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `photography`.`manufacturers` (
  `compID` INT NOT NULL AUTO_INCREMENT,
  `compName` VARCHAR(45) NULL,
  PRIMARY KEY (`compID`),
  UNIQUE INDEX `compID_UNIQUE` (`compID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `photography`.`cameras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `photography`.`cameras` (
  `cameraID` INT NOT NULL AUTO_INCREMENT,
  `maker` INT NOT NULL,
  `model` VARCHAR(45) NULL,
  PRIMARY KEY (`cameraID`, `maker`),
  UNIQUE INDEX `cameraID_UNIQUE` (`cameraID` ASC),
  UNIQUE INDEX `maker_UNIQUE` (`maker` ASC),
  CONSTRAINT `maker`
    FOREIGN KEY (`maker`)
    REFERENCES `photography`.`manufacturers` (`compID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `photography`.`lens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `photography`.`lens` (
  `lensID` INT NOT NULL AUTO_INCREMENT,
  `companyID` INT NOT NULL,
  `model` VARCHAR(45) NULL,
  PRIMARY KEY (`lensID`, `companyID`),
  UNIQUE INDEX `company_UNIQUE` (`companyID` ASC),
  UNIQUE INDEX `lensID_UNIQUE` (`lensID` ASC),
  CONSTRAINT `companyID`
    FOREIGN KEY (`companyID`)
    REFERENCES `photography`.`manufacturers` (`compID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `photography`.`Pictures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `photography`.`Pictures` (
  `pictureID` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `camera` INT NOT NULL,
  `date` DATE NULL,
  `aperture` FLOAT NULL,
  `focal` FLOAT NULL,
  `exposure` VARCHAR(10) NULL,
  `iso` INT NULL,
  `lens` INT NOT NULL,
  `ownerID` INT NOT NULL,
  PRIMARY KEY (`pictureID`, `ownerID`, `camera`, `lens`),
  UNIQUE INDEX `pictureID_UNIQUE` (`pictureID` ASC),
  INDEX `ownerID_idx` (`ownerID` ASC),
  INDEX `camera_idx` (`camera` ASC),
  INDEX `lens_idx` (`lens` ASC),
  CONSTRAINT `ownerID`
    FOREIGN KEY (`ownerID`)
    REFERENCES `photography`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pictureID`
    FOREIGN KEY (`pictureID`)
    REFERENCES `photography`.`rating` (`picID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `camera`
    FOREIGN KEY (`camera`)
    REFERENCES `photography`.`cameras` (`cameraID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `lens`
    FOREIGN KEY (`lens`)
    REFERENCES `photography`.`lens` (`lensID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `photography` ;

-- -----------------------------------------------------
-- Placeholder table for view `photography`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `photography`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `photography`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `photography`.`view1`;
USE `photography`;

CREATE USER 'admin' IDENTIFIED BY 'csci126';
GRANT ALL ON `photography`.* TO 'admin';
GRANT SELECT ON TABLE `photography`.* TO 'admin';
GRANT SELECT, INSERT, TRIGGER ON TABLE `photography`.* TO 'admin';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `photography`.* TO 'admin';
camerascamerascameras
CREATE USER 'manager' IDENTIFIED BY 'csci126';
GRANT SELECT ON TABLE `photography`.* TO 'manager';
GRANT SELECT, INSERT, TRIGGER ON TABLE `photography`.* TO 'manager';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `photography`.* TO 'manager';

CREATE USER 'student';
GRANT SELECT ON TABLE `photography`.* TO 'student';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

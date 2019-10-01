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
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Airplane`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Airplane` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Airplane` (
  `airplaneId` INT NOT NULL,
  `airplaneModel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`airplaneId`),
  UNIQUE INDEX `airplaneCode_UNIQUE` (`airplaneId` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Seats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Seats` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Seats` (
  `seatsId` INT NOT NULL,
  `Airplane_airplaneId` INT NOT NULL,
  PRIMARY KEY (`seatsId`),
  UNIQUE INDEX `numberOfSeats_UNIQUE` (`seatsId` ASC) VISIBLE,
  INDEX `fk_Seats_Airplane1_idx` (`Airplane_airplaneId` ASC) VISIBLE,
  CONSTRAINT `fk_Seats_Airplane1`
    FOREIGN KEY (`Airplane_airplaneId`)
    REFERENCES `mydb`.`Airplane` (`airplaneId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PaintBuyer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PaintBuyer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PaintBuyer` (
  `idPaintBuyer` INT NOT NULL,
  `buyersName` VARCHAR(45) NULL,
  PRIMARY KEY (`idPaintBuyer`),
  UNIQUE INDEX `idPaintBuyer_UNIQUE` (`idPaintBuyer` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Paints`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Paints` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Paints` (
  `paintsId` INT NOT NULL,
  `paintPrice` DECIMAL(13,2) NOT NULL,
  `paintAuthor` VARCHAR(45) NULL,
  `PaintBuyer_idPaintBuyer` INT NOT NULL,
  PRIMARY KEY (`paintsId`),
  UNIQUE INDEX `paintsId_UNIQUE` (`paintsId` ASC) VISIBLE,
  INDEX `fk_Paints_PaintBuyer1_idx` (`PaintBuyer_idPaintBuyer` ASC) VISIBLE,
  CONSTRAINT `fk_Paints_PaintBuyer1`
    FOREIGN KEY (`PaintBuyer_idPaintBuyer`)
    REFERENCES `mydb`.`PaintBuyer` (`idPaintBuyer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StubeUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`StubeUser` ;

CREATE TABLE IF NOT EXISTS `mydb`.`StubeUser` (
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `userName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`userName`),
  UNIQUE INDEX `userName_UNIQUE` (`userName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Videos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Videos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Videos` (
  `videoDescription` TEXT NOT NULL,
  `videoTitle` VARCHAR(45) NOT NULL,
  `videoURL` VARCHAR(100) NOT NULL,
  `videoID` VARCHAR(45) NOT NULL,
  `User_userName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`videoID`),
  UNIQUE INDEX `videoURL_UNIQUE` (`videoURL` ASC) VISIBLE,
  UNIQUE INDEX `videoID_UNIQUE` (`videoID` ASC) VISIBLE,
  INDEX `fk_Videos_User1_idx` (`User_userName` ASC) VISIBLE,
  CONSTRAINT `fk_Videos_User1`
    FOREIGN KEY (`User_userName`)
    REFERENCES `mydb`.`StubeUser` (`userName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Author` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Author` (
  `authorName` VARCHAR(45) NOT NULL,
  `authorAddress` VARCHAR(45) NOT NULL,
  `numberOfBooks` INT NOT NULL,
  PRIMARY KEY (`authorName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BookUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BookUser` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BookUser` (
  `userName` VARCHAR(45) NOT NULL,
  `userEmail` VARCHAR(45) NOT NULL,
  `userPassword` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`userName`),
  UNIQUE INDEX `userName_UNIQUE` (`userName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BookInvoice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BookInvoice` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BookInvoice` (
  `invoiceNumber` INT NOT NULL AUTO_INCREMENT,
  `BookUser_userName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`invoiceNumber`),
  UNIQUE INDEX `receiptNumber_UNIQUE` (`invoiceNumber` ASC) VISIBLE,
  INDEX `fk_BookInvoice_BookUser1_idx` (`BookUser_userName` ASC) VISIBLE,
  CONSTRAINT `fk_BookInvoice_BookUser1`
    FOREIGN KEY (`BookUser_userName`)
    REFERENCES `mydb`.`BookUser` (`userName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Books`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Books` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Books` (
  `idBooks` INT NOT NULL AUTO_INCREMENT,
  `unitsAvailables` INT NOT NULL,
  `booksPrice` DECIMAL(13,2) NOT NULL,
  `Author_authorName` VARCHAR(45) NOT NULL,
  `BookInvoice_invoiceNumber` INT NOT NULL,
  PRIMARY KEY (`idBooks`),
  UNIQUE INDEX `idBooks_UNIQUE` (`idBooks` ASC) VISIBLE,
  INDEX `fk_Books_Author1_idx` (`Author_authorName` ASC) VISIBLE,
  INDEX `fk_Books_BookInvoice1_idx` (`BookInvoice_invoiceNumber` ASC) VISIBLE,
  CONSTRAINT `fk_Books_Author1`
    FOREIGN KEY (`Author_authorName`)
    REFERENCES `mydb`.`Author` (`authorName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Books_BookInvoice1`
    FOREIGN KEY (`BookInvoice_invoiceNumber`)
    REFERENCES `mydb`.`BookInvoice` (`invoiceNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PictureUser`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PictureUser` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PictureUser` (
  `userName` VARCHAR(45) NOT NULL,
  `userPassword` VARCHAR(45) NOT NULL,
  `userEmail` VARCHAR(45) NOT NULL,
  `userID` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `userEmail_UNIQUE` (`userEmail` ASC) VISIBLE,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `userID_UNIQUE` (`userID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pictures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pictures` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pictures` (
  `pictureId` INT NOT NULL AUTO_INCREMENT,
  `pictureUrl` VARCHAR(255) NULL,
  `PictureUser_userID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pictureId`),
  UNIQUE INDEX `pictureId_UNIQUE` (`pictureId` ASC) VISIBLE,
  INDEX `fk_Pictures_PictureUser1_idx` (`PictureUser_userID` ASC) VISIBLE,
  CONSTRAINT `fk_Pictures_PictureUser1`
    FOREIGN KEY (`PictureUser_userID`)
    REFERENCES `mydb`.`PictureUser` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Relationship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Relationship` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Relationship` (
  `relationship` VARCHAR(45) NOT NULL,
  `PictureUser_userID` VARCHAR(45) NOT NULL,
  `PictureUser_userID1` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`relationship`),
  INDEX `fk_Relationship_PictureUser1_idx` (`PictureUser_userID` ASC) VISIBLE,
  INDEX `fk_Relationship_PictureUser2_idx` (`PictureUser_userID1` ASC) VISIBLE,
  CONSTRAINT `fk_Relationship_PictureUser1`
    FOREIGN KEY (`PictureUser_userID`)
    REFERENCES `mydb`.`PictureUser` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Relationship_PictureUser2`
    FOREIGN KEY (`PictureUser_userID1`)
    REFERENCES `mydb`.`PictureUser` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Address` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Address` (
  `idAddress` INT NOT NULL,
  `streetType` VARCHAR(45) NOT NULL,
  `number` VARCHAR(45) NOT NULL,
  `floorNumber` VARCHAR(45) NOT NULL,
  `appartment` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zipCode` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAddress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vendor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Vendor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Vendor` (
  `vendorId` INT NOT NULL,
  `vendorName` VARCHAR(45) NOT NULL,
  `vendorPhone` INT NOT NULL,
  `vendorFax` INT NOT NULL,
  `vendorNif` VARCHAR(45) NOT NULL,
  `Address_idAddress` INT NOT NULL,
  PRIMARY KEY (`vendorId`),
  UNIQUE INDEX `vendorId_UNIQUE` (`vendorId` ASC) VISIBLE,
  INDEX `fk_Vendor_Address1_idx` (`Address_idAddress` ASC) VISIBLE,
  CONSTRAINT `fk_Vendor_Address1`
    FOREIGN KEY (`Address_idAddress`)
    REFERENCES `mydb`.`Address` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Glasess`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Glasess` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Glasess` (
  `idGlasess` INT NOT NULL,
  `glasessBrand` VARCHAR(45) NOT NULL,
  `glasessgraduation` VARCHAR(10) NOT NULL,
  `mountColor` VARCHAR(45) NOT NULL,
  `glasessColor` VARCHAR(45) NOT NULL,
  `glasessPrice` DECIMAL(6,2) NOT NULL,
  `glasessMountType` VARCHAR(45) NOT NULL,
  `Vendor_vendorId` INT NOT NULL,
  PRIMARY KEY (`idGlasess`),
  UNIQUE INDEX `idGlasess_UNIQUE` (`idGlasess` ASC) VISIBLE,
  INDEX `fk_Glasess_Vendor1_idx` (`Vendor_vendorId` ASC) VISIBLE,
  CONSTRAINT `fk_Glasess_Vendor1`
    FOREIGN KEY (`Vendor_vendorId`)
    REFERENCES `mydb`.`Vendor` (`vendorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Customer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `idCustomer` INT NOT NULL,
  `customerEmail` VARCHAR(45) NOT NULL,
  `customerPhone` INT NOT NULL,
  `customerResgistrationDate` DATE NOT NULL,
  `Referral` VARCHAR(45) NULL,
  `Address_idAddress` INT NOT NULL,
  PRIMARY KEY (`idCustomer`),
  UNIQUE INDEX `idCustomer_UNIQUE` (`idCustomer` ASC) VISIBLE,
  INDEX `fk_Customer_Address1_idx` (`Address_idAddress` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_Address1`
    FOREIGN KEY (`Address_idAddress`)
    REFERENCES `mydb`.`Address` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Employee` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  `employeeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmployee`),
  UNIQUE INDEX `idEmployee_UNIQUE` (`idEmployee` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`GlassesInvoice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`GlassesInvoice` ;

CREATE TABLE IF NOT EXISTS `mydb`.`GlassesInvoice` (
  `idInvoice` INT NOT NULL AUTO_INCREMENT,
  `Employee_idEmployee` INT NOT NULL,
  `Glasess_idGlasess` INT NOT NULL,
  `Customer_idCustomer` INT NOT NULL,
  PRIMARY KEY (`idInvoice`),
  UNIQUE INDEX `idInvoice_UNIQUE` (`idInvoice` ASC) VISIBLE,
  INDEX `fk_GlassesInvoice_Employee1_idx` (`Employee_idEmployee` ASC) VISIBLE,
  INDEX `fk_GlassesInvoice_Glasess1_idx` (`Glasess_idGlasess` ASC) VISIBLE,
  INDEX `fk_GlassesInvoice_Customer1_idx` (`Customer_idCustomer` ASC) VISIBLE,
  CONSTRAINT `fk_GlassesInvoice_Employee1`
    FOREIGN KEY (`Employee_idEmployee`)
    REFERENCES `mydb`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GlassesInvoice_Glasess1`
    FOREIGN KEY (`Glasess_idGlasess`)
    REFERENCES `mydb`.`Glasess` (`idGlasess`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_GlassesInvoice_Customer1`
    FOREIGN KEY (`Customer_idCustomer`)
    REFERENCES `mydb`.`Customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

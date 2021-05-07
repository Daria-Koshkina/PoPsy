-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema popsy
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema popsy
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `popsy` DEFAULT CHARACTER SET utf8 ;
USE `popsy` ;

-- -----------------------------------------------------
-- Table `popsy`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`User` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Surname` VARCHAR(45) NULL,
  `Photo` VARCHAR(150) NULL,
  `Email` VARCHAR(50) NULL,
  `Phone` VARCHAR(20) NULL,
  `Age` INT NULL,
  `Password` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Diary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Diary` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `UserId` INT NOT NULL,
  PRIMARY KEY (`ID`, `UserId`),
  INDEX `fk_Diary_User_idx` (`UserId` ASC) VISIBLE,
  CONSTRAINT `fk_Diary_User`
    FOREIGN KEY (`UserId`)
    REFERENCES `popsy`.`User` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Record` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DiaryID` INT NOT NULL,
  `Date` DATETIME NULL,
  `Type` VARCHAR(45) NULL,
  `Content` MEDIUMTEXT NULL,
  PRIMARY KEY (`ID`, `DiaryID`),
  INDEX `fk_Record_Diary1_idx` (`DiaryID` ASC) VISIBLE,
  CONSTRAINT `fk_Record_Diary1`
    FOREIGN KEY (`DiaryID`)
    REFERENCES `popsy`.`Diary` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Premium_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Premium_user` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `EndSubscription` DATETIME NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Premium_user_User1_idx` (`UserID` ASC) VISIBLE,
  UNIQUE INDEX `UserID_UNIQUE` (`UserID` ASC) VISIBLE,
  CONSTRAINT `fk_Premium_user_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `popsy`.`User` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Psychologist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Psychologist` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `Photo` VARCHAR(150) NULL,
  `Email` VARCHAR(50) NULL,
  `Info` MEDIUMTEXT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Consultation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Consultation` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Date` DATETIME NULL,
  `UserID` INT NOT NULL,
  `PsychologistID` INT NOT NULL,
  `Price` INT NULL,
  PRIMARY KEY (`ID`, `UserID`, `PsychologistID`),
  INDEX `fk_Consultation_Premium_user1_idx` (`UserID` ASC) VISIBLE,
  INDEX `fk_Consultation_Psychologist1_idx` (`PsychologistID` ASC) VISIBLE,
  CONSTRAINT `fk_Consultation_Premium_user1`
    FOREIGN KEY (`UserID`)
    REFERENCES `popsy`.`Premium_user` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Consultation_Psychologist1`
    FOREIGN KEY (`PsychologistID`)
    REFERENCES `popsy`.`Psychologist` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Test`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Test` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(45) NULL,
  `Photo` VARCHAR(150) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Question` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TestID` INT NOT NULL,
  `Text` VARCHAR(240) NULL,
  `Photo` VARCHAR(150) NULL,
  PRIMARY KEY (`ID`, `TestID`),
  INDEX `fk_Question_Test1_idx` (`TestID` ASC) VISIBLE,
  CONSTRAINT `fk_Question_Test1`
    FOREIGN KEY (`TestID`)
    REFERENCES `popsy`.`Test` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Variant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Variant` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `QuestionID` INT NOT NULL,
  `Text` VARCHAR(240) NULL,
  `Photo` VARCHAR(150) NULL,
  `Value` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`, `QuestionID`),
  INDEX `fk_Variant_Question1_idx` (`QuestionID` ASC) VISIBLE,
  CONSTRAINT `fk_Variant_Question1`
    FOREIGN KEY (`QuestionID`)
    REFERENCES `popsy`.`Question` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Categories` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(100) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Test_has_Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Test_has_Categories` (
  `Test_ID` INT NOT NULL,
  `Categories_ID` INT NOT NULL,
  PRIMARY KEY (`Test_ID`, `Categories_ID`),
  INDEX `fk_Test_has_Categories_Categories1_idx` (`Categories_ID` ASC) VISIBLE,
  INDEX `fk_Test_has_Categories_Test1_idx` (`Test_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Test_has_Categories_Test1`
    FOREIGN KEY (`Test_ID`)
    REFERENCES `popsy`.`Test` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Test_has_Categories_Categories1`
    FOREIGN KEY (`Categories_ID`)
    REFERENCES `popsy`.`Categories` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Test_result`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Test_result` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TestID` INT NOT NULL,
  `UserID` INT NOT NULL,
  `TestResult` VARCHAR(240) NULL,
  PRIMARY KEY (`ID`, `TestID`, `UserID`),
  INDEX `fk_Test_result_Test1_idx` (`TestID` ASC) VISIBLE,
  INDEX `fk_Test_result_User1_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `fk_Test_result_Test1`
    FOREIGN KEY (`TestID`)
    REFERENCES `popsy`.`Test` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Test_result_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `popsy`.`User` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`AudioList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`AudioList` (
  `ID` INT NOT NULL,
  `Title` VARCHAR(240) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Multimedia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Multimedia` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Content` VARCHAR(240) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Multimedia_has_AudioList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Multimedia_has_AudioList` (
  `MultimediaID` INT NOT NULL,
  `AudioListID` INT NOT NULL,
  PRIMARY KEY (`MultimediaID`, `AudioListID`),
  INDEX `fk_Multimedia_has_AudioList_AudioList1_idx` (`AudioListID` ASC) VISIBLE,
  INDEX `fk_Multimedia_has_AudioList_Multimedia1_idx` (`MultimediaID` ASC) VISIBLE,
  CONSTRAINT `fk_Multimedia_has_AudioList_Multimedia1`
    FOREIGN KEY (`MultimediaID`)
    REFERENCES `popsy`.`Multimedia` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Multimedia_has_AudioList_AudioList1`
    FOREIGN KEY (`AudioListID`)
    REFERENCES `popsy`.`AudioList` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`VideoList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`VideoList` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(240) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Multimedia_has_VideoList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Multimedia_has_VideoList` (
  `MultimediaID` INT NOT NULL,
  `VideoListID` INT NOT NULL,
  PRIMARY KEY (`MultimediaID`, `VideoListID`),
  INDEX `fk_Multimedia_has_VideoList_VideoList1_idx` (`VideoListID` ASC) VISIBLE,
  INDEX `fk_Multimedia_has_VideoList_Multimedia1_idx` (`MultimediaID` ASC) VISIBLE,
  CONSTRAINT `fk_Multimedia_has_VideoList_Multimedia1`
    FOREIGN KEY (`MultimediaID`)
    REFERENCES `popsy`.`Multimedia` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Multimedia_has_VideoList_VideoList1`
    FOREIGN KEY (`VideoListID`)
    REFERENCES `popsy`.`VideoList` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Article` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(240) NULL,
  `Content` LONGTEXT NULL,
  `Author` VARCHAR(240) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Notification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Notification` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(240) NULL,
  `Text` MEDIUMTEXT NULL,
  `Link` MEDIUMTEXT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Notification_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Notification_view` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `UserID` INT NOT NULL,
  `NotificationID` INT NOT NULL,
  `Date` DATETIME NULL,
  PRIMARY KEY (`ID`, `UserID`, `NotificationID`),
  INDEX `fk_Notification_view_User1_idx` (`UserID` ASC) VISIBLE,
  INDEX `fk_Notification_view_Notification1_idx` (`NotificationID` ASC) VISIBLE,
  CONSTRAINT `fk_Notification_view_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `popsy`.`User` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Notification_view_Notification1`
    FOREIGN KEY (`NotificationID`)
    REFERENCES `popsy`.`Notification` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`AudioList_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`AudioList_view` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `UserID` INT NOT NULL,
  `AudioListID` INT NOT NULL,
  `Date` DATETIME NULL,
  PRIMARY KEY (`ID`, `UserID`, `AudioListID`),
  INDEX `fk_AudioList_view_User1_idx` (`UserID` ASC) VISIBLE,
  INDEX `fk_AudioList_view_AudioList1_idx` (`AudioListID` ASC) VISIBLE,
  CONSTRAINT `fk_AudioList_view_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `popsy`.`User` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_AudioList_view_AudioList1`
    FOREIGN KEY (`AudioListID`)
    REFERENCES `popsy`.`AudioList` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`VideoList_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`VideoList_view` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `UserID` INT NOT NULL,
  `VideoListID` INT NOT NULL,
  `Date` DATETIME NULL,
  PRIMARY KEY (`ID`, `UserID`, `VideoListID`),
  INDEX `fk_VideoList_view_User1_idx` (`UserID` ASC) VISIBLE,
  INDEX `fk_VideoList_view_VideoList1_idx` (`VideoListID` ASC) VISIBLE,
  CONSTRAINT `fk_VideoList_view_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `popsy`.`User` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_VideoList_view_VideoList1`
    FOREIGN KEY (`VideoListID`)
    REFERENCES `popsy`.`VideoList` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `popsy`.`Article_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `popsy`.`Article_view` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `UserID` INT NOT NULL,
  `ArticleID` INT NOT NULL,
  `Date` DATETIME NULL,
  PRIMARY KEY (`ID`, `UserID`, `ArticleID`),
  INDEX `fk_Article_view_User1_idx` (`UserID` ASC) VISIBLE,
  INDEX `fk_Article_view_Article1_idx` (`ArticleID` ASC) VISIBLE,
  CONSTRAINT `fk_Article_view_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `popsy`.`User` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Article_view_Article1`
    FOREIGN KEY (`ArticleID`)
    REFERENCES `popsy`.`Article` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

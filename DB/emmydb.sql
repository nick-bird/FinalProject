-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema emmydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `emmydb` ;

-- -----------------------------------------------------
-- Schema emmydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `emmydb` DEFAULT CHARACTER SET utf8 ;
USE `emmydb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `email` TEXT NOT NULL,
  `role` VARCHAR(45) NOT NULL DEFAULT 'user',
  `is_restriced` TINYINT NOT NULL DEFAULT 0,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `soundboard`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `soundboard` ;

CREATE TABLE IF NOT EXISTS `soundboard` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_soundboard_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_soundboard_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `expression`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `expression` ;

CREATE TABLE IF NOT EXISTS `expression` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phrase` TEXT NOT NULL,
  `soundboard_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_expression_soundboard1_idx` (`soundboard_id` ASC),
  CONSTRAINT `fk_expression_soundboard1`
    FOREIGN KEY (`soundboard_id`)
    REFERENCES `soundboard` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `image` ;

CREATE TABLE IF NOT EXISTS `image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `img_url` TEXT NOT NULL,
  `user_id` INT NOT NULL,
  `expression_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_image_library_user_idx` (`user_id` ASC),
  INDEX `fk_image_library_expression1_idx` (`expression_id` ASC),
  CONSTRAINT `fk_image_library_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_image_library_expression1`
    FOREIGN KEY (`expression_id`)
    REFERENCES `expression` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS user@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'user'@'localhost' IDENTIFIED BY 'user';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'user'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `emmydb`;
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `is_restriced`, `is_active`, `first_name`, `last_name`) VALUES (1, 'admin', 'admin', 'testemail@test.test', 'admin', 0, 1, 'admin', 'admin');

COMMIT;


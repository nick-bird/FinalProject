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
  `is_restricted` TINYINT NOT NULL DEFAULT 0,
  `is_active` TINYINT NOT NULL DEFAULT 1,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `image` ;

CREATE TABLE IF NOT EXISTS `image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` TEXT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_image_library_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_image_library_user`
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
  `image_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_expression_image1_idx` (`image_id` ASC),
  CONSTRAINT `fk_expression_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `soundboard`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `soundboard` ;

CREATE TABLE IF NOT EXISTS `soundboard` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  `is_public` TINYINT NOT NULL DEFAULT 0,
  `description` VARCHAR(45) NOT NULL,
  `create_date` DATETIME NULL,
  `is_default` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_soundboard_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_soundboard_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `soundboard_expression`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `soundboard_expression` ;

CREATE TABLE IF NOT EXISTS `soundboard_expression` (
  `soundboard_id` INT NOT NULL,
  `expression_id` INT NOT NULL,
  `position_id` INT NOT NULL,
  PRIMARY KEY (`soundboard_id`, `expression_id`),
  INDEX `fk_soundboard_has_expression_expression1_idx` (`expression_id` ASC),
  INDEX `fk_soundboard_has_expression_soundboard1_idx` (`soundboard_id` ASC),
  CONSTRAINT `fk_soundboard_has_expression_soundboard1`
    FOREIGN KEY (`soundboard_id`)
    REFERENCES `soundboard` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_soundboard_has_expression_expression1`
    FOREIGN KEY (`expression_id`)
    REFERENCES `expression` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE TABLE IF NOT EXISTS `category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `soundboard_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `soundboard_category` ;

CREATE TABLE IF NOT EXISTS `soundboard_category` (
  `category_id` INT NOT NULL,
  `soundboard_id` INT NOT NULL,
  PRIMARY KEY (`category_id`, `soundboard_id`),
  INDEX `fk_category_has_soundboard_soundboard1_idx` (`soundboard_id` ASC),
  INDEX `fk_category_has_soundboard_category1_idx` (`category_id` ASC),
  CONSTRAINT `fk_category_has_soundboard_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_category_has_soundboard_soundboard1`
    FOREIGN KEY (`soundboard_id`)
    REFERENCES `soundboard` (`id`)
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
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `is_restricted`, `is_active`, `first_name`, `last_name`) VALUES (1, 'admin', 'admin', 'testemail@test.test', 'admin', 0, 1, 'admin', 'admin');

COMMIT;


-- -----------------------------------------------------
-- Data for table `image`
-- -----------------------------------------------------
START TRANSACTION;
USE `emmydb`;
INSERT INTO `image` (`id`, `image_url`, `user_id`) VALUES (1, 'https://i.pinimg.com/originals/5c/d1/c4/5cd1c48588d9a83f16cbddbbcb2bfaad.png', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `expression`
-- -----------------------------------------------------
START TRANSACTION;
USE `emmydb`;
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`) VALUES (1, 'More', 'More', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `soundboard`
-- -----------------------------------------------------
START TRANSACTION;
USE `emmydb`;
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (1, 'ASL Signs', 1, 0, 'American Sign Language', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `soundboard_expression`
-- -----------------------------------------------------
START TRANSACTION;
USE `emmydb`;
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `category`
-- -----------------------------------------------------
START TRANSACTION;
USE `emmydb`;
INSERT INTO `category` (`id`, `name`, `description`) VALUES (1, 'ASL', 'American Sign Language');

COMMIT;


-- -----------------------------------------------------
-- Data for table `soundboard_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `emmydb`;
INSERT INTO `soundboard_category` (`category_id`, `soundboard_id`) VALUES (1, 1);

COMMIT;


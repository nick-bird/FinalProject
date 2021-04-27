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
  `image_url` TEXT BINARY NOT NULL,
  PRIMARY KEY (`id`))
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
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_expression_image1_idx` (`image_id` ASC),
  INDEX `fk_expression_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_expression_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_expression_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
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
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `is_restricted`, `is_active`, `first_name`, `last_name`) VALUES (1, 'Default', '$2a$10$4SMKDcs9jT18dbFxqtIqDeLEynC7MUrCEUbv1a/bhO.x9an9WGPvm', 'testemail@test.test', 'admin', 0, 1, 'admin', 'admin');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `is_restricted`, `is_active`, `first_name`, `last_name`) VALUES (2, 'Tylor', '$2a$10$PTFGbNR5TUuTJwqtbfh3luyILyr9GoSx2EI7ZEF8lxVgrI4Yx1sTK', 'tylorshearn95@gmail.com', 'admin', 0, 1, 'Tylor', 'Shearn');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `is_restricted`, `is_active`, `first_name`, `last_name`) VALUES (3, 'Nick', '$2a$10$RlNlZhIO2Zclil2XULGuteclyTG/pCPrNKmgmDIchlqe7PXGwBb9a', 'bird.nick.95@gmail.com', 'admin', 0, 1, 'Nick', 'Bird');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `is_restricted`, `is_active`, `first_name`, `last_name`) VALUES (4, 'Karen', '$2a$10$Vw2IDIjXPdG7QMxhE32awOvvc/BMRE.B66yNUALK6a48KrOPVRfcG', 'solorzanolisseth83@gmail.com', 'admin', 0, 1, 'Karen', 'Mena');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `is_restricted`, `is_active`, `first_name`, `last_name`) VALUES (5, 'Justin', '$2a$10$e9QQt3GFUaAL06wpSqNowOsMUPyoUVlXyzMpOnPwMZEhTzc/QS3Ju', 'justin.adams314@gmail.com', 'admin', 0, 1, 'Justin', 'Adams');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `is_restricted`, `is_active`, `first_name`, `last_name`) VALUES (6, 'John', '$2a$10$ql2Wv72zY0a9Y0MVBP2qNOvWb1X4Lz3RV07eEiZ2BKjZbE3N3Tnnq', 'johnjacobs@email', 'admin', 1, 1, 'John', 'Jacobs');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `is_restricted`, `is_active`, `first_name`, `last_name`) VALUES (7, 'Bob', '$2a$10$MLfvpywwwA4mwBkTF1ptBOgBsgxP65Fit9XPARcge.A9EPl5RAYWS', 'bobevan@email', 'admin', 1, 0, 'Bob', 'Evan');
INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `is_restricted`, `is_active`, `first_name`, `last_name`) VALUES (8, 'Webster', '$2a$10$gMyf8YIP5M/1SyRLSIgzGe7DEJtmxaAh.HDRVtYSkOAzgCMea5QMy', 'webmonsterthelab@email', 'admin', 0, 0, 'Webster', 'Shearn');

COMMIT;


-- -----------------------------------------------------
-- Data for table `image`
-- -----------------------------------------------------
START TRANSACTION;
USE `emmydb`;
INSERT INTO `image` (`id`, `image_url`) VALUES (1, 'assets/images/momsl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (2, 'assets/images/momaltsl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (3, 'assets/images/dadaltsl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (4, 'assets/images/grandmasl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (5, 'assets/images/grandpasl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (6, 'assets/images/sistersl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (7, 'assets/images/brothersl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (8, 'assets/images/babysl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (9, 'assets/images/friendsl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (10, 'assets/images/iloveyousl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (11, 'assets/images/happysl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (12, 'assets/images/sadsl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (13, 'assets/images/grumpysl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (14, 'assets/images/gentlesl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (15, 'assets/images/sorrysl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (16, 'assets/images/helpsl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (17, 'assets/images/hurtsl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (18, 'assets/images/diapersl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (19, 'assets/images/changesl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (20, 'assets/images/pottysl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (21, 'assets/images/cleansl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (22, 'assets/images/dirtysl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (23, 'assets/images/milksl.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (24, 'assets/images/plane.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (25, 'assets/images/car.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (26, 'assets/images/motorcycle.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (27, 'assets/images/boat.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (28, 'assets/images/kayak.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (29, 'assets/images/bicycle.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (30, 'assets/images/vegetables.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (31, 'assets/images/burger.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (32, 'assets/images/donuts.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (33, 'assets/images/taco.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (34, 'assets/images/chicken.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (35, 'assets/images/spaghetti.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (36, 'assets/images/milk.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (37, 'assets/images/water.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (38, 'assets/images/soda.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (39, 'assets/images/happy.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (40, 'assets/images/excited.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (41, 'assets/images/sad.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (42, 'assets/images/calm.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (43, 'assets/images/anxious.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (44, 'assets/images/play.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (45, 'assets/images/park.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (46, 'assets/images/swings.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (47, 'assets/images/police.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (48, 'assets/images/fire.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (49, 'assets/images/flood.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (50, 'assets/images/tornado.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (51, 'assets/images/ambulance.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (52, 'assets/images/sick.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (53, 'assets/images/tooth.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (54, 'assets/images/doctor.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (55, 'assets/images/dentist.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (56, 'assets/images/makeup.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (57, 'assets/images/hair.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (58, 'assets/images/stylingtools.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (59, 'assets/images/hairspray.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (60, 'assets/images/hairproducts.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (61, 'assets/images/shirt.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (62, 'assets/images/pants.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (63, 'assets/images/hats.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (64, 'assets/images/shoes.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (65, 'assets/images/shopping.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (66, 'assets/images/hello.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (67, 'assets/images/goodbye.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (68, 'assets/images/thankyou.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (69, 'assets/images/nothankyou.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (70, 'assets/images/cellphone.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (71, 'assets/images/amusementpark.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (72, 'assets/images/carnival.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (73, 'assets/images/zoo.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (74, 'assets/images/party.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (75, 'assets/images/trees.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (76, 'assets/images/mountains.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (77, 'assets/images/beach.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (78, 'assets/images/feedingdog.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (79, 'assets/images/takingdogout.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (80, 'assets/images/vet.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (81, 'assets/images/groceryshopping.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (82, 'assets/images/grocerybasket.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (83, 'assets/images/checkout.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (84, 'assets/images/store.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (85, 'assets/images/mom.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (86, 'assets/images/dad.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (87, 'assets/images/brothersister.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (88, 'assets/images/football.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (89, 'assets/images/soccer.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (90, 'assets/images/swimming.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (91, 'assets/images/jogging.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (92, 'assets/images/dinnermenu.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (93, 'assets/images/orderfood.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (94, 'assets/images/bill.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `expression`
-- -----------------------------------------------------
START TRANSACTION;
USE `emmydb`;
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (1, 'Mom', 'Mom', 1, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (2, 'Mom (Alternative)', 'Mom', 2, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (3, 'Dad (Alternative)', 'Dad', 3, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (4, 'Grandma', 'Grandma', 4, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (5, 'Grandpa', 'Grandpa', 5, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (6, 'Sister', 'Sister', 6, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (7, 'Brother', 'Brother', 7, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (8, 'Baby', 'Baby', 8, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (9, 'Friend', 'Friend', 9, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (10, 'I Love You', 'I love you', 10, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (11, 'Happy', 'Happy', 11, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (12, 'Sad', 'Sad', 12, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (13, 'Grumpy', 'Grumpy', 13, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (14, 'Gentle', 'Gentle', 14, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (15, 'Sorry', 'Sorry', 15, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (16, 'Help', 'Help', 16, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (17, 'Hurt', 'Hurt', 17, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (18, 'Diaper', 'Diaper', 18, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (19, 'Change', 'Change', 19, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (20, 'Potty', 'Potty', 20, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (21, 'Clean', 'Clean', 21, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (22, 'Dirty', 'Dirty', 22, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (23, 'Milk', 'Milk', 23, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (24, 'Plane', 'What time do we board the plane?', 24, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (25, 'Car', 'I\'ll take the car.', 25, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (26, 'Motorcycle', 'Can we ride the motorcycle?', 26, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (27, 'Boat', 'When does the boat leave?', 27, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (28, 'Kayak', 'Can we go kayaking?', 28, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (29, 'Bicycle', 'I\'ll ride my bike.', 29, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (30, 'Vegetables', 'What\'s your favorite vegetable?', 30, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (31, 'Burger', 'How do you like your burger cooked?', 31, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (32, 'Donuts', 'I want a donut.', 32, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (33, 'Taco', 'Can we make tacos tonight?', 33, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (34, 'Chicken', 'Did you cook the chicken?', 34, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (35, 'Spaghetti', 'Do you have any spaghetti left?', 35, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (36, 'Milk', 'We need more milk.', 36, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (37, 'Water', 'Did you get water at the store?', 37, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (38, 'Soda', 'What kind of soda do we have?', 38, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (39, 'Happy', 'I\'m happy.', 39, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (40, 'Excited', 'I\'m excited.', 40, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (41, 'Sad', 'I\'m sad.', 41, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (42, 'Calm', 'I feel calm.', 42, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (43, 'Anxious', 'I feel anxious.', 43, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (44, 'Play', 'Do you want to go play?', 44, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (45, 'Park', 'Do you want to go to the park?', 45, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (46, 'Swings', 'Do you want to go on the swings?', 46, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (47, 'Police', 'Call the police.', 47, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (48, 'Fire', 'Something is on fire.', 48, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (49, 'Flood', 'It\'s going to flood.', 49, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (50, 'Tornado', 'There is an active tornado warning.', 50, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (51, 'Ambulance', 'We need an ambulance.', 51, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (52, 'Sick', 'I think I\'m sick.', 52, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (53, 'Tooth', 'I have a tooth ache.', 53, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (54, 'Doctor', 'I need to go to the doctor.', 54, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (55, 'Dentist', 'I need to go to the dentist.', 55, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (56, 'Makeup', 'I\'m going to put on my makeup.', 56, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (57, 'Hair', 'I need to do my hair.', 57, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (58, 'Styling Tools', 'Can you hand me my straightener?', 58, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (59, 'Hair Spray', 'Can you get some hair spray at the store?', 59, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (60, 'Hair Products', 'I need to put some gel in my hair.', 60, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (61, 'Shirt', 'Do you like this shirt?', 61, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (62, 'Pants', 'Do you like these pants?', 62, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (63, 'Hats', 'Let me grab my hat before we leave.', 63, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (64, 'Shoes', 'I\'m going to put my shoes on.', 64, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (65, 'Shopping', 'Let\'s go shopping.', 65, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (66, 'Hello', 'Hello.', 66, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (67, 'Goodbye', 'Goodbye.', 67, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (68, 'Thank You', 'Thank you.', 68, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (69, 'No Thank You', 'No thank you.', 69, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (70, 'Cell Phone', 'Can I barrow your phone?', 70, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (71, 'Amusement Park', 'Want to go to the amusement park?', 71, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (72, 'Carnival', 'There is a carnival next week.', 72, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (73, 'Zoo', 'Are we going to the zoo this weekend?', 73, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (74, 'Party', 'What time does the party start?', 74, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (75, 'Trees', 'The trees here are really tall.', 75, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (76, 'Mountains', 'The mountains are beautiful.', 76, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (77, 'Beach', 'I love the smell of the ocean.', 77, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (78, 'Feed The Dog', 'I have to go feed the dog.', 78, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (79, 'Taking Dog Out', 'I\'m going to go let the dog out.', 79, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (80, 'Vet', 'When does the vet open?', 80, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (81, 'Grocery Shopping', 'We need to go grocery shopping.', 81, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (82, 'Grocery Basket', 'Can you grab a basket?', 82, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (83, 'Check Out', 'Are you ready to check out?', 83, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (84, 'Store', 'What store are we going to?', 84, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (85, 'Mom', 'How is mom doing?', 85, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (86, 'Dad', 'Where\'s dad?', 86, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (87, 'Brother/Sister', 'My siblings are coming into town this weekend.', 87, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (88, 'Football', 'Do you want to play football?', 88, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (89, 'Soccer', 'Can we play soccer?', 89, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (90, 'Swimming', 'I\'m going for a swim.', 90, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (91, 'Jogging', 'Let\'s go for a jog.', 91, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (92, 'Dinner Menu', 'Can I have a menu?', 92, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (93, 'Order Food', 'Are you ready to order?', 93, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (94, 'Bill', 'Can we have the bill?', 94, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `soundboard`
-- -----------------------------------------------------
START TRANSACTION;
USE `emmydb`;
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (1, 'ASL Signs', 1, 1, 'American Sign Language', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (2, 'Animals', 1, 0, 'Animals', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (3, 'Nick\'s Soundboard', 3, 0, 'Nick\'s Soundboard', NULL, 0);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (4, 'Karen\'s Soundboard', 4, 0, 'Karen\'s Soundboard', NULL, 0);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (5, 'Justin\'s Soundboard', 5, 0, 'Justin\'s Soundboard', NULL, 0);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (6, 'Travelling', 1, 1, 'Soundboard For Travelling', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (7, 'Commuting', 1, 1, 'Soundboard For Commuting', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (8, 'Food/Drink', 1, 1, 'Soundboard For Food/Drinks', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (9, 'Feelings', 1, 1, 'Soundboard For Feelings', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (10, 'Play', 1, 1, 'Soundboard For Play', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (11, 'Emergencies', 1, 1, 'Soundboard For Emergencies', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (12, 'Health', 1, 1, 'Soundboard For Health', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (13, 'Beauty', 1, 1, 'Soundboard For Beauty', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (14, 'Clothing', 1, 1, 'Soundboard For Clothing', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (15, 'Shopping', 1, 1, 'Soundboard For Shopping', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (16, 'General Communication', 1, 1, 'Soundboard For General Communication', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (17, 'Amusement', 1, 1, 'Soundboard For Amusement', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (18, 'Nature', 1, 1, 'Soundboard For Nature', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (19, 'Petcare', 1, 1, 'Soundboard For Petcare', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (20, 'Grocery Shopping', 1, 1, 'Soundboard For Grocery Shopping', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (21, 'Family', 1, 1, 'Soundboard For Family Members', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (22, 'Exercise', 1, 1, 'Soundboard For Exercise', NULL, 1);
INSERT INTO `soundboard` (`id`, `name`, `user_id`, `is_public`, `description`, `create_date`, `is_default`) VALUES (23, 'Dinner', 1, 1, 'Soundboard For Dinner', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `soundboard_expression`
-- -----------------------------------------------------
START TRANSACTION;
USE `emmydb`;
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 1, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 2, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 3, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 4, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 5, 5);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 6, 6);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 7, 7);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 8, 8);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 9, 9);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 10, 10);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 11, 11);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 12, 12);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 13, 13);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 14, 14);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 15, 15);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 16, 16);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 17, 17);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 18, 18);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 19, 19);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 20, 20);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 21, 21);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 22, 22);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (1, 23, 23);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (6, 24, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (6, 25, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (6, 26, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (6, 27, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (6, 28, 5);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (6, 29, 6);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (7, 25, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (7, 26, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (7, 29, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 30, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 31, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 32, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 33, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 34, 5);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 35, 6);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 36, 7);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 37, 8);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 38, 9);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (9, 39, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (9, 40, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (9, 41, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (9, 42, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (9, 43, 5);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (10, 44, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (10, 45, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (10, 46, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (11, 47, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (11, 48, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (11, 49, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (11, 50, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (11, 51, 5);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (12, 52, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (12, 53, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (12, 54, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (12, 55, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (13, 56, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (13, 57, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (13, 58, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (13, 59, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (13, 60, 5);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (14, 61, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (14, 62, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (14, 63, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (14, 64, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (15, 65, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (16, 66, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (16, 67, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (16, 68, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (16, 69, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (16, 70, 5);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (17, 71, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (17, 72, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (17, 73, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (17, 74, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (18, 75, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (18, 76, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (18, 77, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (19, 78, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (19, 79, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (19, 80, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (20, 81, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (20, 82, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (20, 83, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (20, 84, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (21, 85, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (21, 86, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (21, 87, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (22, 88, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (22, 89, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (22, 90, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (22, 91, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (23, 92, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (23, 93, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (23, 94, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `category`
-- -----------------------------------------------------
START TRANSACTION;
USE `emmydb`;
INSERT INTO `category` (`id`, `name`, `description`) VALUES (1, 'ASL', 'American Sign Language');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (2, 'Travel', 'Travel');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (3, 'Commuting', 'Commuting');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (4, 'Food/Drink', 'Food/Drink');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (5, 'Feelings', 'Feelings');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (6, 'Play', 'Play');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (7, 'Emergency', 'Emergencies');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (8, 'Health', 'Health');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (9, 'Beauty', 'Beauty');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (10, 'Clothing', 'Clothing');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (11, 'Shopping', 'Shopping');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (12, 'General Communication', 'General Communication');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (13, 'Amusement', 'Amusement');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (14, 'Nature', 'Nature');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (15, 'Petcare', 'Petcare');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (16, 'Grocery Store', 'Grocery Store');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (17, 'Family Members', 'Family Members');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (18, 'Exercise', 'Exercise');
INSERT INTO `category` (`id`, `name`, `description`) VALUES (19, 'Dinner', 'Dinner');

COMMIT;


-- -----------------------------------------------------
-- Data for table `soundboard_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `emmydb`;
INSERT INTO `soundboard_category` (`category_id`, `soundboard_id`) VALUES (1, 1);

COMMIT;


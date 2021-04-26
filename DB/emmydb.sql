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
INSERT INTO `image` (`id`, `image_url`) VALUES (1, 'https://i.pinimg.com/originals/5c/d1/c4/5cd1c48588d9a83f16cbddbbcb2bfaad.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (2, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4Y7NeszyTA4SFbiuXOtnLViL_wagbgNC6xcL2-WUee8Tj6Yr66BUwO1Z4nI_RpN0EJhw&usqp=CAU');
INSERT INTO `image` (`id`, `image_url`) VALUES (3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQERyImY05L3A-NvdLsYaJJ7aIIcXDEL1BoQXXRpmCOQ1Q3J4l74zhFuki9jEIu18ntXUk&usqp=CAU');
INSERT INTO `image` (`id`, `image_url`) VALUES (4, 'https://www.netclipart.com/pp/m/22-227997_thank-you-clipart-transparent-clip-art-thank-you.png');
INSERT INTO `image` (`id`, `image_url`) VALUES (5, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpR1q87EcJF92x1G9WcNBtfNMnDxasyuiiX0BsW3ul4OfeGzto27H5LI6ZOtTNBQ9aW6I&usqp=CAU');
INSERT INTO `image` (`id`, `image_url`) VALUES (6, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuyEjV1WVqmiAjEOYVJ5eqHWUkVVs9HGFHX0JCxvTS2qftxOjloiAJCCJJiYXO0cAA-1A&usqp=CAU');
INSERT INTO `image` (`id`, `image_url`) VALUES (7, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8VIvnJfTyuK7Yeho5D6mjiSu6ShMjSWXasPWbc_8DNp4IfgCSbneEv4b9ZOZER_sNIa8&usqp=CAU');
INSERT INTO `image` (`id`, `image_url`) VALUES (8, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4gQo6tfPDjddJ_mwVMeZYagu6XqIkQP1yFxH-XYaU2VGDoYv2hbVVcppORPJlGimSCNo&usqp=CAU');
INSERT INTO `image` (`id`, `image_url`) VALUES (9, 'https://www.vecteezy.com/vector-art/550668-airplane-flying-vector-icon');
INSERT INTO `image` (`id`, `image_url`) VALUES (10, 'https://www.vecteezy.com/vector-art/550435-stylized-convertible-sports-car');
INSERT INTO `image` (`id`, `image_url`) VALUES (11, 'https://www.vecteezy.com/vector-art/363916-motorcycle-bike-vector-design-illustration-template');
INSERT INTO `image` (`id`, `image_url`) VALUES (12, 'https://www.vecteezy.com/vector-art/169875-trawler-ship-illustration');
INSERT INTO `image` (`id`, `image_url`) VALUES (13, 'https://www.vecteezy.com/vector-art/245383-kayaking-first-person-view-vector-illustration');
INSERT INTO `image` (`id`, `image_url`) VALUES (14, 'https://www.vecteezy.com/vector-art/268354-bicycle-vector');
INSERT INTO `image` (`id`, `image_url`) VALUES (15, 'https://www.vecteezy.com/vector-art/555006-healthy-food-vector');
INSERT INTO `image` (`id`, `image_url`) VALUES (16, 'https://www.vecteezy.com/vector-art/225103-realistic-fast-food');
INSERT INTO `image` (`id`, `image_url`) VALUES (17, 'https://www.vecteezy.com/vector-art/218539-delicious-donuts-vector-set');
INSERT INTO `image` (`id`, `image_url`) VALUES (18, 'https://www.vecteezy.com/vector-art/553519-taco-vector-illustration');
INSERT INTO `image` (`id`, `image_url`) VALUES (19, 'https://www.vecteezy.com/vector-art/294187-full-roast-chicken-on-plate');
INSERT INTO `image` (`id`, `image_url`) VALUES (20, 'https://www.vecteezy.com/vector-art/965991-spaghetti-meal-set');
INSERT INTO `image` (`id`, `image_url`) VALUES (21, 'https://www.vecteezy.com/vector-art/474712-milk-cartons-and-bottle');
INSERT INTO `image` (`id`, `image_url`) VALUES (22, 'https://www.vecteezy.com/vector-art/296790-water-bottles-and-glass-with-drinking-water');
INSERT INTO `image` (`id`, `image_url`) VALUES (23, 'https://www.vecteezy.com/vector-art/1268671-soda-can-isolated');
INSERT INTO `image` (`id`, `image_url`) VALUES (24, 'https://www.vecteezy.com/vector-art/380758-happy-emoji-vector-icon');
INSERT INTO `image` (`id`, `image_url`) VALUES (25, 'https://www.vecteezy.com/vector-art/664399-man-excited-about-growing-money-tree');
INSERT INTO `image` (`id`, `image_url`) VALUES (26, 'https://www.vecteezy.com/vector-art/559288-sad-little-girl-crying');
INSERT INTO `image` (`id`, `image_url`) VALUES (27, 'https://www.vecteezy.com/vector-art/663944-meditating-businessman');
INSERT INTO `image` (`id`, `image_url`) VALUES (28, 'https://www.vecteezy.com/vector-art/301166-a-girl-having-anxious');
INSERT INTO `image` (`id`, `image_url`) VALUES (29, 'https://www.vecteezy.com/vector-art/419493-cute-children-playing-at-park-vector-flat-illustration');
INSERT INTO `image` (`id`, `image_url`) VALUES (30, 'https://www.vecteezy.com/vector-art/217310-urban-park');
INSERT INTO `image` (`id`, `image_url`) VALUES (31, 'https://www.vecteezy.com/vector-art/432936-empty-swing-set-playground-background');
INSERT INTO `image` (`id`, `image_url`) VALUES (32, 'https://www.vecteezy.com/vector-art/144953-police-lights-vector-icons-set');
INSERT INTO `image` (`id`, `image_url`) VALUES (33, 'https://www.vecteezy.com/vector-art/294898-modern-house-on-fire');
INSERT INTO `image` (`id`, `image_url`) VALUES (34, 'https://www.vecteezy.com/vector-art/417540-a-flood-in-the-village');
INSERT INTO `image` (`id`, `image_url`) VALUES (35, 'https://www.vecteezy.com/vector-art/295651-a-tornado-in-nature');
INSERT INTO `image` (`id`, `image_url`) VALUES (36, 'https://www.vecteezy.com/vector-art/663689-ambulance');
INSERT INTO `image` (`id`, `image_url`) VALUES (37, 'https://www.vecteezy.com/vector-art/171449-free-affliction-illustrarion');
INSERT INTO `image` (`id`, `image_url`) VALUES (38, 'https://www.vecteezy.com/vector-art/553427-tooth-vector-icon');
INSERT INTO `image` (`id`, `image_url`) VALUES (39, 'https://www.vecteezy.com/vector-art/127133-doctor-with-prescription-pad-flat-vector');
INSERT INTO `image` (`id`, `image_url`) VALUES (40, 'https://www.vecteezy.com/vector-art/141720-free-scary-dentista-illustration');
INSERT INTO `image` (`id`, `image_url`) VALUES (41, 'https://www.vecteezy.com/vector-art/173128-vector-hand-drawn-makeup-collection');
INSERT INTO `image` (`id`, `image_url`) VALUES (42, 'https://www.vecteezy.com/vector-art/603876-hair-woman-and-face-logo-and-symbols');
INSERT INTO `image` (`id`, `image_url`) VALUES (43, 'https://www.vecteezy.com/vector-art/236635-realistic-salon-tools');
INSERT INTO `image` (`id`, `image_url`) VALUES (44, 'https://www.vecteezy.com/vector-art/583823-hair-spray-icon-vector');
INSERT INTO `image` (`id`, `image_url`) VALUES (45, 'https://www.vecteezy.com/vector-art/2004033-shampoo-bottle-vector-design-illustration-set-isolated-on-white-background');
INSERT INTO `image` (`id`, `image_url`) VALUES (46, 'https://www.vecteezy.com/vector-art/229742-t-shirt-vector-front-side-and-back-side-mock-up-template');
INSERT INTO `image` (`id`, `image_url`) VALUES (47, 'https://www.vecteezy.com/vector-art/125119-free-vector-sweatpants-illustration');
INSERT INTO `image` (`id`, `image_url`) VALUES (48, 'https://www.vecteezy.com/vector-art/148486-trucker-hat-vector-icons');
INSERT INTO `image` (`id`, `image_url`) VALUES (49, 'https://www.vecteezy.com/vector-art/162913-flat-shoes-vectors');
INSERT INTO `image` (`id`, `image_url`) VALUES (50, 'https://www.vecteezy.com/vector-art/1267303-shopping-people-set');
INSERT INTO `image` (`id`, `image_url`) VALUES (51, 'https://www.vecteezy.com/vector-art/223666-hello-retro-typography');
INSERT INTO `image` (`id`, `image_url`) VALUES (52, 'https://www.vecteezy.com/vector-art/2143828-young-men-of-different-races-waving-hands-greeting-or-saying-goodbye-isolated-on-white-background-cartoon-male-characters-with-welcoming-gesture-in-vector-illustration');
INSERT INTO `image` (`id`, `image_url`) VALUES (53, 'https://www.vecteezy.com/vector-art/223708-thank-you-retro-lettering-typography');
INSERT INTO `image` (`id`, `image_url`) VALUES (54, 'https://www.vecteezy.com/vector-art/553585-thumbs-down-vector-icon');
INSERT INTO `image` (`id`, `image_url`) VALUES (55, 'https://www.vecteezy.com/vector-art/351222-cell-phone-vector-icon');
INSERT INTO `image` (`id`, `image_url`) VALUES (56, 'https://www.vecteezy.com/vector-art/190666-amusement-park-with-rollercoaster-in-the-city-vector');
INSERT INTO `image` (`id`, `image_url`) VALUES (57, 'https://www.vecteezy.com/vector-art/190838-carnival-poster-illustration');
INSERT INTO `image` (`id`, `image_url`) VALUES (58, 'https://www.vecteezy.com/vector-art/298979-scene-at-the-zoo-with-zookeeper-and-animals');
INSERT INTO `image` (`id`, `image_url`) VALUES (59, 'https://www.vecteezy.com/vector-art/133767-party-favors-icons');
INSERT INTO `image` (`id`, `image_url`) VALUES (60, 'https://www.vecteezy.com/vector-art/217388-vector-nature-landscape-illustration');
INSERT INTO `image` (`id`, `image_url`) VALUES (61, 'https://www.vecteezy.com/vector-art/124675-free-vector-mount-everest-illustration');
INSERT INTO `image` (`id`, `image_url`) VALUES (62, 'https://www.vecteezy.com/vector-art/133980-paddle-background-vector');
INSERT INTO `image` (`id`, `image_url`) VALUES (63, 'https://www.vecteezy.com/vector-art/1842448-little-dog-pug-with-food-canine-cartoon-pets');
INSERT INTO `image` (`id`, `image_url`) VALUES (64, 'https://www.vecteezy.com/vector-art/238949-boy-walking-with-his-dog');
INSERT INTO `image` (`id`, `image_url`) VALUES (65, 'https://www.vecteezy.com/vector-art/367694-vet-examining-dog-with-stethoscope');
INSERT INTO `image` (`id`, `image_url`) VALUES (66, 'https://www.vecteezy.com/vector-art/247823-grocery-shopping-illustration');
INSERT INTO `image` (`id`, `image_url`) VALUES (67, 'https://www.vecteezy.com/vector-art/1831497-basket-with-carrot-eggs-water-bottle-and-cheese-grocery-purchases');
INSERT INTO `image` (`id`, `image_url`) VALUES (68, 'https://www.vecteezy.com/vector-art/156553-shop-at-the-mall');
INSERT INTO `image` (`id`, `image_url`) VALUES (69, 'https://www.vecteezy.com/vector-art/618815-store-and-market-background');
INSERT INTO `image` (`id`, `image_url`) VALUES (70, 'https://www.vecteezy.com/vector-art/141845-young-beautiful-mom-with-her-newborn-baby-vector');
INSERT INTO `image` (`id`, `image_url`) VALUES (71, 'https://www.vecteezy.com/vector-art/202793-superhero-dad');
INSERT INTO `image` (`id`, `image_url`) VALUES (72, 'https://www.vecteezy.com/vector-art/240190-cute-children-silhouettes');
INSERT INTO `image` (`id`, `image_url`) VALUES (73, 'https://www.vecteezy.com/vector-art/106120-free-american-football-field-vector');
INSERT INTO `image` (`id`, `image_url`) VALUES (74, 'https://www.vecteezy.com/vector-art/206726-awesome-abstract-soccer-player-vectors');
INSERT INTO `image` (`id`, `image_url`) VALUES (75, 'https://www.vecteezy.com/vector-art/666443-swimming-postures');
INSERT INTO `image` (`id`, `image_url`) VALUES (76, 'https://www.vecteezy.com/vector-art/660782-couple-jogging-together');
INSERT INTO `image` (`id`, `image_url`) VALUES (77, 'https://www.vecteezy.com/vector-art/183843-thailand-food-menu-vector-template');
INSERT INTO `image` (`id`, `image_url`) VALUES (78, 'https://www.vecteezy.com/vector-art/273761-online-food-order-vector-illustration');
INSERT INTO `image` (`id`, `image_url`) VALUES (79, 'https://www.vecteezy.com/vector-art/548427-bill-line-black-icon');

COMMIT;


-- -----------------------------------------------------
-- Data for table `expression`
-- -----------------------------------------------------
START TRANSACTION;
USE `emmydb`;
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (1, 'More', 'More', 1, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (2, 'Please', 'Please', 2, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (3, 'Want', 'Want', 3, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (4, 'Thank you', 'Thank you', 4, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (5, 'Goodbye', 'Goodbye', 5, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (6, 'Play', 'Play', 6, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (7, 'Water', 'Water', 7, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (8, 'Which', 'Which', 8, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (9, 'Airplane', 'What time do we board the plane?', 9, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (10, 'Car', 'I\'ll take the car.', 10, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (11, 'Motorcycle', 'Can we take the motorcycle?', 11, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (12, 'Boat', 'Can we go out on the boat?', 12, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (13, 'Kayak', 'Can we go kayaking?', 13, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (14, 'Bicycle', 'I\'ll take my bike.', 14, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (15, 'Vegetables', 'I want some vegetables.', 15, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (16, 'Burger', 'I want a burger.', 16, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (17, 'Donuts', 'I want some donuts.', 17, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (18, 'Tacos', 'I want tacos.', 18, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (19, 'Chicken', 'I want chicken.', 19, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (20, 'Spaghetti', 'I want spaghetti.', 20, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (21, 'Milk', 'I want some milk.', 21, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (22, 'Water', 'I want some water.', 22, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (23, 'Soda', 'I want some soda.', 23, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (24, 'Happy', 'I feel happy.', 24, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (25, 'Excited', 'I feel excited.', 25, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (26, 'Sad', 'I feel sad.', 26, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (27, 'Calm', 'I feel calm.', 27, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (28, 'Anxious', 'I feel anxious.', 28, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (29, 'Play', 'Can we go play?', 29, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (30, 'Park', 'Can we go to the park?', 30, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (31, 'Swings', 'I want to swing.', 31, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (32, 'Police', 'Can you call the police?', 32, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (33, 'Fire', 'Something is on fire.', 33, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (34, 'Flood', 'It\'s starting to flood.', 34, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (35, 'Tornado', 'There is a tornado watch.', 35, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (36, 'Ambulance', 'I need an ambulance.', 36, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (37, 'Sick', 'I\'m sick.', 37, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (38, 'Tooth', 'My tooth hurts.', 38, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (39, 'Doctor', 'I need to go to the doctor.', 39, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (40, 'Dentist', 'I need to go to the dentist.', 40, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (41, 'Makeup', 'I\'m going to put on my makeup.', 41, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (42, 'Hair', 'I\'m going to do my hair.', 42, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (43, 'Styling Tools', 'I need my straightener.', 43, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (44, 'Hair Spray', 'I need the hair spray.', 44, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (45, 'Hair Product', 'I need my hair gel.', 45, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (46, 'Shirt', 'I\'m going to wear this shirt.', 46, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (47, 'Pants', 'Do these pants look good?', 47, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (48, 'Hats', 'I like this hat.', 48, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (49, 'Shoes', 'Do you like these shoes?', 49, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (50, 'Shopping', 'Can we go shopping?', 50, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (51, 'Hello', 'Hello', 51, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (52, 'Goodbye', 'Goodbye', 52, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (53, 'Thank You', 'Thank you', 53, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (54, 'No Thank You', 'No thank you', 54, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (55, 'Cell Phone', 'Have you seen my phone?', 55, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (56, 'Amusement Park', 'Do you want to go to the amusement park?', 56, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (57, 'Carnival', 'Want to go to the carnival?', 57, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (58, 'Zoo', 'I want to go to the zoo.', 58, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (59, 'Party', 'Are you going to the party?', 59, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (60, 'Trees', 'I love how those trees look.', 60, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (61, 'Mountains', 'The mountains are beautiful.', 61, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (62, 'Beach', 'I love the beach.', 62, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (63, 'Feeding The Dog', 'I\'m feeding the dog.', 63, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (64, 'Dog On Leash', 'I\'m taking the dog out.', 64, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (65, 'Vet', 'We need to go to the vet.', 65, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (66, 'Grocery Shopping', 'We need to go grocery shopping.', 66, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (67, 'Crocery Basket', 'Can you grab a basket?', 67, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (68, 'Check Out', 'Are we ready to check out?', 68, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (69, 'Store', 'What store are we going to?', 69, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (70, 'Mom', 'Where\'s mom?', 70, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (71, 'Dad', 'Where\'s dad?', 71, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (72, 'Brother/Sister', 'I\'m going to see my siblings.', 72, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (73, 'Football', 'We\'ll play football.', 73, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (74, 'Soccer', 'Want to play soccer?', 74, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (75, 'Swimming', 'I\'m going for a swim.', 75, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (76, 'Jogging', 'Let\'s go for a jog.', 76, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (77, 'Dinner Menu', 'Can I see your menu, please?', 77, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (78, 'Order Food', 'Are you ready to order?', 78, 1);
INSERT INTO `expression` (`id`, `name`, `phrase`, `image_id`, `user_id`) VALUES (79, 'Dinner Bill', 'Can we have the bill, please?', 79, 1);

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
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (6, 9, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (6, 10, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (6, 11, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (6, 12, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (6, 13, 5);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (6, 14, 6);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (7, 10, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (7, 11, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (7, 14, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 15, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 16, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 17, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 18, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 19, 5);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 20, 6);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 21, 7);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 22, 8);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (8, 23, 9);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (9, 24, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (9, 25, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (9, 26, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (9, 27, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (9, 28, 5);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (10, 29, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (10, 30, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (10, 31, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (11, 32, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (11, 33, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (11, 34, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (11, 35, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (11, 36, 5);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (12, 37, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (12, 38, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (12, 39, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (12, 40, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (13, 41, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (13, 42, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (13, 43, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (13, 44, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (13, 45, 5);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (14, 46, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (14, 47, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (14, 48, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (14, 49, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (15, 50, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (16, 51, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (16, 52, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (16, 53, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (16, 54, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (16, 55, 5);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (17, 56, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (17, 57, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (17, 58, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (17, 59, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (18, 60, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (18, 61, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (18, 62, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (19, 63, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (19, 64, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (19, 65, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (20, 66, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (20, 67, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (20, 68, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (20, 69, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (21, 70, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (21, 71, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (21, 72, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (22, 73, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (22, 74, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (22, 75, 3);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (22, 76, 4);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (23, 77, 1);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (23, 78, 2);
INSERT INTO `soundboard_expression` (`soundboard_id`, `expression_id`, `position_id`) VALUES (23, 79, 3);

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


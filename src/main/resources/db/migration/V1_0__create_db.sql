-- Schema BOOK_MY_YOGA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BOOK_MY_YOGA` DEFAULT CHARACTER SET utf8mb4;
USE `BOOK_MY_YOGA`;

-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`package_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`package_category`
(
    `id`   INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45)      NOT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`package`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`package`
(
    `id`          INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`        INT(10) UNSIGNED NOT NULL,
    `price`       VARCHAR(45)      NOT NULL,
    `title`       VARCHAR(45)      NOT NULL,
    `description` VARCHAR(45)      NOT NULL,
    `category`    INT(10) UNSIGNED NOT NULL,
    `image`       INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_package_category_id`
        FOREIGN KEY (`category`)
            REFERENCES `BOOK_MY_YOGA`.`package_category` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`country`
(
    `id`   INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45)      NOT NULL,
    `code` VARCHAR(45)      NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`state`
(
    `id`      INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`    VARCHAR(45)      NOT NULL,
    `country` INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_state_country_id`
        FOREIGN KEY (`country`)
            REFERENCES `BOOK_MY_YOGA`.`country` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`city`
(
    `id`    INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`  VARCHAR(45)      NOT NULL,
    `state` INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_city_state_id`
        FOREIGN KEY (`state`)
            REFERENCES `BOOK_MY_YOGA`.`state` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`address`
(
    `id`      INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `address` VARCHAR(255)     NULL DEFAULT NULL,
    `city`    INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_address_city_id`
        FOREIGN KEY (`city`)
            REFERENCES `BOOK_MY_YOGA`.`city` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`user`
(
    `id`                 INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `first_name`         VARCHAR(45)      NOT NULL,
    `last_name`          VARCHAR(45)      NOT NULL,
    `mobile_no`          VARCHAR(45)      NULL     DEFAULT NULL,
    `email_id`           VARCHAR(45)      NOT NULL,
    `password`           VARCHAR(45)      NOT NULL,
    `created_by`         VARCHAR(45)      NULL     DEFAULT NULL,
    `updated_by`         VARCHAR(45)      NULL     DEFAULT NULL,
    `created_at`         DATETIME         NOT NULL,
    `updated_at`         TIMESTAMP        NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    `email_verified`     TINYINT(3)       NOT NULL DEFAULT 0,
    `address`            INT(10) UNSIGNED NULL     DEFAULT NULL,
    `active`             TINYINT(3)       NOT NULL DEFAULT 0,
    `last_login_at`      DATETIME         NOT NULL,
    `last_ip`            VARCHAR(45)      NOT NULL,
    `verification_token` VARCHAR(45)      NULL     DEFAULT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_user_address_id`
        FOREIGN KEY (`address`)
            REFERENCES `BOOK_MY_YOGA`.`address` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`add_to_cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`add_to_cart`
(
    `id`      INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `package` INT(10) UNSIGNED NOT NULL,
    `user`    INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_add_to_cart_package_id`
        FOREIGN KEY (`package`)
            REFERENCES `BOOK_MY_YOGA`.`package` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_add_to_cart_user_id`
        FOREIGN KEY (`user`)
            REFERENCES `BOOK_MY_YOGA`.`user` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`status`
(
    `id`   INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45)      NOT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`booking`
(
    `id`           INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `package`      INT(10) UNSIGNED NOT NULL,
    `user`         INT(10) UNSIGNED NOT NULL,
    `created_at`   DATETIME         NOT NULL,
    `reupdated_at` DATETIME         NULL DEFAULT NULL,
    `status`       INT(10) UNSIGNED NOT NULL,
    `booking_id`   VARCHAR(45)      NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_booking_package_id`
        FOREIGN KEY (`package`)
            REFERENCES `BOOK_MY_YOGA`.`package` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_booking_user_id`
        FOREIGN KEY (`user`)
            REFERENCES `BOOK_MY_YOGA`.`user` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_booking_status_id`
        FOREIGN KEY (`status`)
            REFERENCES `BOOK_MY_YOGA`.`status` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`hotel`
(
    `id`          INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`        VARCHAR(45)      NOT NULL,
    `address`     VARCHAR(45)      NOT NULL,
    `city`        INT(11)          NOT NULL,
    `phone`       VARCHAR(45)      NOT NULL,
    `email`       VARCHAR(45)      NOT NULL,
    `image`       VARCHAR(45)      NOT NULL,
    `description` TEXT             NOT NULL,
    `available`   INT(11)          NOT NULL DEFAULT 1,
    `lat`         VARCHAR(45)      NULL     DEFAULT NULL,
    `long`        VARCHAR(45)      NULL     DEFAULT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`inclusions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`inclusions`
(
    `id`   INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45)      NOT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`package_hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`package_hotel`
(
    `id`      INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `package` INT(10) UNSIGNED NOT NULL,
    `hotel`   INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`package_inclusions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`package_inclusions`
(
    `id`         INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `package`    INT(10) UNSIGNED NOT NULL,
    `inclusions` INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`payment_transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`payment_transaction`
(
    `id`               INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `booking`          INT(10) UNSIGNED NOT NULL,
    `mode`             VARCHAR(45)      NULL DEFAULT NULL,
    `amount`           VARCHAR(45)      NULL DEFAULT NULL,
    `currency`         VARCHAR(45)      NULL DEFAULT NULL,
    `reference_id`     VARCHAR(45)      NULL DEFAULT NULL,
    `transaction_date` DATETIME         NOT NULL,
    `status`           INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_payment_transaction_booking_id`
        FOREIGN KEY (`booking`)
            REFERENCES `BOOK_MY_YOGA`.`booking` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_payment_transaction_status_id`
        FOREIGN KEY (`status`)
            REFERENCES `BOOK_MY_YOGA`.`status` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`rating`
(
    `id`         INT(11)          NOT NULL AUTO_INCREMENT,
    `package`    INT(10) UNSIGNED NOT NULL,
    `user`       INT(10) UNSIGNED NOT NULL,
    `created_at` DATETIME         NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_rating_package_id`
        FOREIGN KEY (`package`)
            REFERENCES `BOOK_MY_YOGA`.`package` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_rating_user_id`
        FOREIGN KEY (`user`)
            REFERENCES `BOOK_MY_YOGA`.`user` (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`role`
(
    `id`   INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45)      NOT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`register_role_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`register_role_user`
(
    `id`   INT(11)          NOT NULL AUTO_INCREMENT,
    `role` INT(10) UNSIGNED NOT NULL,
    `user` INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_register_role_id`
        FOREIGN KEY (`role`)
            REFERENCES `BOOK_MY_YOGA`.`role` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_register_user_id`
        FOREIGN KEY (`user`)
            REFERENCES `BOOK_MY_YOGA`.`user` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `BOOK_MY_YOGA`.`visitor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BOOK_MY_YOGA`.`visitor`
(
    `id`         INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `ip_address` VARCHAR(45)      NULL DEFAULT NULL,
    `count`      INT(10) UNSIGNED NOT NULL,
    `date_time`  DATETIME         NOT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8mb4;
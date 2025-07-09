-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema sistema_ventas_4e
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sistema_ventas_4e
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sistema_ventas_4e` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `sistema_ventas_4e` ;

-- -----------------------------------------------------
-- Table `sistema_ventas_4e`.`tipo_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_ventas_4e`.`tipo_usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` INT NULL DEFAULT NULL,
  `updated_by` INT NULL DEFAULT NULL,
  `deleted` TINYINT(1) NULL DEFAULT '0',
  `descripcion_tipo` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistema_ventas_4e`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_ventas_4e`.`usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(100) NOT NULL,
  `email` VARCHAR(200) NULL DEFAULT NULL,
  `tipo_usuario_id` INT NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` INT NULL DEFAULT NULL,
  `updated_by` INT NULL DEFAULT NULL,
  `deleted` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `correo` (`email` ASC) VISIBLE,
  INDEX `fk_usuario_tipo_usuario` (`tipo_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_tipo_usuario`
    FOREIGN KEY (`tipo_usuario_id`)
    REFERENCES `sistema_ventas_4e`.`tipo_usuarios` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistema_ventas_4e`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_ventas_4e`.`ventas` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NULL DEFAULT NULL,
  `fecha` DATE NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` INT NULL DEFAULT NULL,
  `updated_by` INT NULL DEFAULT NULL,
  `deleted` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`id_venta`),
  INDEX `fk_producto_id_usuario` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_producto_id_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `sistema_ventas_4e`.`usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistema_ventas_4e`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_ventas_4e`.`productos` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre_producto` VARCHAR(100) NOT NULL,
  `precio` FLOAT NULL DEFAULT NULL,
  `stock` INT NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` INT NULL DEFAULT NULL,
  `updated_by` INT NULL DEFAULT NULL,
  `deleted` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`id_producto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistema_ventas_4e`.`detalle_ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema_ventas_4e`.`detalle_ventas` (
  `id_detalle` INT NOT NULL AUTO_INCREMENT,
  `venta_id` INT NULL DEFAULT NULL,
  `producto_id` INT NULL DEFAULT NULL,
  `cantidad` INT NULL DEFAULT NULL,
  `precio_unitario` FLOAT NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` INT NULL DEFAULT NULL,
  `updated_by` INT NULL DEFAULT NULL,
  `deleted` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`id_detalle`),
  INDEX `fk_detalle_ventas_ventas` (`venta_id` ASC) VISIBLE,
  INDEX `fk_ventas_ventas_productos` (`producto_id` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_ventas_ventas`
    FOREIGN KEY (`venta_id`)
    REFERENCES `sistema_ventas_4e`.`ventas` (`id_venta`),
  CONSTRAINT `fk_ventas_ventas_productos`
    FOREIGN KEY (`producto_id`)
    REFERENCES `sistema_ventas_4e`.`productos` (`id_producto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Arriendo_bicicletas_urbanas` DEFAULT CHARACTER SET utf8 ;
USE `Arriendo_bicicletas_urbanas` ;

-- -----------------------------------------------------
-- Table `mydb`.`Tipo_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Arriendo_bicicletas_urbanas`.`Tipo_usuarios` (
  `id_tipo` INT NOT NULL AUTO_INCREMENT,
  `descripcion_tipo` VARCHAR(60) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  PRIMARY KEY (`id_tipo`),
  UNIQUE INDEX `id_tipo_UNIQUE` (`id_tipo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Arriendo_bicicletas_urbanas`.`Usuarios` (
  `id_usuarios` INT NOT NULL AUTO_INCREMENT,
  `Tipo_usuario_id` INT NOT NULL,
  `nombre` VARCHAR(60) NOT NULL,
  `rut` VARCHAR(15) NOT NULL,
  `correo` VARCHAR(80) NOT NULL check (correo like '%@%.%'),
  `password` VARCHAR(32) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL check(fecha_nacimiento <= '2025-12-31' and fecha_nacimiento >= '1900-01-01'), 
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  PRIMARY KEY (`id_usuarios`, `Tipo_usuario_id`),
  UNIQUE INDEX `id_usuarios_UNIQUE` (`id_usuarios` ASC) VISIBLE,
  INDEX `fk_Usuarios_Tipo_usuarios_idx` (`Tipo_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_Usuarios_Tipo_usuarios`
    FOREIGN KEY (`Tipo_usuario_id`)
    REFERENCES `Arriendo_bicicletas_urbanas`.`Tipo_usuarios` (`id_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Arriendo_bicicletas_urbanas`.`Estaciones` (
  `id_estacione` INT NOT NULL AUTO_INCREMENT,
  `nombre_estacion` VARCHAR(120) NOT NULL,
  `direccion` VARCHAR(150) NOT NULL,
  `capacidad_maxima` INT NOT NULL,
  `estado` VARCHAR(30) NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  PRIMARY KEY (`id_estacione`),
  UNIQUE INDEX `id_estacione_UNIQUE` (`id_estacione` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bicicletas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Arriendo_bicicletas_urbanas`.`Bicicletas` (
  `id_bicicleta` INT NOT NULL AUTO_INCREMENT,
  `tipo_bicicleta` VARCHAR(100) NOT NULL,
  `estado` VARCHAR(100) NOT NULL,
  `estacion_asignada` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  `Estaciones_id_estacione` INT NOT NULL,
  PRIMARY KEY (`id_bicicleta`, `Estaciones_id_estacione`),
  UNIQUE INDEX `id_bicicleta_UNIQUE` (`id_bicicleta` ASC) VISIBLE,
  INDEX `fk_Bicicletas_Estaciones1_idx` (`Estaciones_id_estacione` ASC) VISIBLE,
  CONSTRAINT `fk_Bicicletas_Estaciones1`
    FOREIGN KEY (`Estaciones_id_estacione`)
    REFERENCES `Arriendo_bicicletas_urbanas`.`Estaciones` (`id_estacione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Arriendos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Arriendo_bicicletas_urbanas`.`Arriendos` (
  `id_arriendo` INT NOT NULL AUTO_INCREMENT,
  `id_bicicleta` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `fecha_inicio` DATETIME NULL,
  `fecha_fin` DATETIME NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  `estacion_inicio` INT NULL,
  `estacion_fin` INT NULL,
  PRIMARY KEY (`id_arriendo`, `id_bicicleta`, `id_usuario`),
  UNIQUE INDEX `id_arriendo_UNIQUE` (`id_arriendo` ASC) VISIBLE,
  INDEX `fk_Arriendos_Bicicletas1_idx` (`id_bicicleta` ASC) VISIBLE,
  INDEX `fk_Arriendos_Usuarios1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Arriendos_Bicicletas1`
    FOREIGN KEY (`id_bicicleta`)
    REFERENCES `Arriendo_bicicletas_urbanas`.`Bicicletas` (`id_bicicleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arriendos_Usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `Arriendo_bicicletas_urbanas`.`Usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Historial_uso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Arriendo_bicicletas_urbanas`.`Historial_uso` (
  `id_Historial` INT NOT NULL AUTO_INCREMENT,
  `Bicicletas_id_bicicleta` INT NOT NULL,
  `Historial_descripcion` VARCHAR(500) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  PRIMARY KEY (`id_Historial`, `Bicicletas_id_bicicleta`),
  UNIQUE INDEX `id_Historial_UNIQUE` (`id_Historial` ASC) VISIBLE,
  INDEX `fk_Historial_uso_Bicicletas1_idx` (`Bicicletas_id_bicicleta` ASC) VISIBLE,
  CONSTRAINT `fk_Historial_uso_Bicicletas1`
    FOREIGN KEY (`Bicicletas_id_bicicleta`)
    REFERENCES `Arriendo_bicicletas_urbanas`.`Bicicletas` (`id_bicicleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Multas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Arriendo_bicicletas_urbanas`.`Multas` (
  `id_Multa` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  `multa_desc` VARCHAR(500) NULL,
  PRIMARY KEY (`id_Multa`),
  UNIQUE INDEX `id_Multa_UNIQUE` (`id_Multa` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuarios_has_Multas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Arriendo_bicicletas_urbanas`.`Usuarios_has_Multas` (
  `id_usuarios` INT NOT NULL,
  `id_Multa` INT NOT NULL,
  PRIMARY KEY (`id_usuarios`, `id_Multa`),
  INDEX `fk_Usuarios_has_Multas_Multas1_idx` (`id_Multa` ASC) VISIBLE,
  INDEX `fk_Usuarios_has_Multas_Usuarios1_idx` (`id_usuarios` ASC) VISIBLE,
  CONSTRAINT `fk_Usuarios_has_Multas_Usuarios1`
    FOREIGN KEY (`id_usuarios`)
    REFERENCES `Arriendo_bicicletas_urbanas`.`Usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_has_Multas_Multas1`
    FOREIGN KEY (`id_Multa`)
    REFERENCES `Arriendo_bicicletas_urbanas`.`Multas` (`id_Multa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

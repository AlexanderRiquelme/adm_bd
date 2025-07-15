-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema arriendo_bicicletas_urbanas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema arriendo_bicicletas_urbanas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `arriendo_bicicletas_urbanas` DEFAULT CHARACTER SET utf8 ;
USE `arriendo_bicicletas_urbanas` ;

-- -----------------------------------------------------
-- Table `arriendo_bicicletas_urbanas`.`Tipo_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arriendo_bicicletas_urbanas`.`Tipo_usuarios` (
  `id_tipo` INT NOT NULL AUTO_INCREMENT,
  `descripcion_tipo` VARCHAR(60) NOT NULL check(descripcion_tipo in('Cliente','Usuario','Administrador')),
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  PRIMARY KEY (`id_tipo`),
  UNIQUE INDEX `id_tipo_UNIQUE` (`id_tipo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `arriendo_bicicletas_urbanas`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arriendo_bicicletas_urbanas`.`Usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `Tipo_usuario_id` INT NOT NULL,
  `nombre` VARCHAR(60) NOT NULL,
  `rut` VARCHAR(15) NOT NULL,
  `correo` VARCHAR(80) NOT NULL check(correo like '%@%.%'),
  `password` VARCHAR(32) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  PRIMARY KEY (`id_usuario`, `Tipo_usuario_id`),
  UNIQUE INDEX `id_usuarios_UNIQUE` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_Usuarios_Tipo_usuarios_idx` (`Tipo_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_Usuarios_Tipo_usuarios`
    FOREIGN KEY (`Tipo_usuario_id`)
    REFERENCES `arriendo_bicicletas_urbanas`.`Tipo_usuarios` (`id_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `arriendo_bicicletas_urbanas`.`Estaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arriendo_bicicletas_urbanas`.`Estaciones` (
  `id_estacione` INT NOT NULL AUTO_INCREMENT,
  `nombre_estacion` VARCHAR(120) NOT NULL,
  `direccion` VARCHAR(150) NOT NULL,
  `capacidad_maxima` INT NOT NULL check(capacidad_maxima >= 1),
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
-- Table `arriendo_bicicletas_urbanas`.`tipo_bicicletas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arriendo_bicicletas_urbanas`.`tipo_bicicletas` (
  `id_tipo_bicicletas` INT NOT NULL AUTO_INCREMENT,
  `descripcion_tipo` VARCHAR(16) NULL check(descripcion_tipo in('Carretera','Montaña','Hibridas','Urbanas','plegables','BMX','Electricas')),
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  PRIMARY KEY (`id_tipo_bicicletas`),
  UNIQUE INDEX `id_tipo_bicicletas_UNIQUE` (`id_tipo_bicicletas` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `arriendo_bicicletas_urbanas`.`estado_bicicletas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arriendo_bicicletas_urbanas`.`estado_bicicletas` (
  `id_estado_bicicleta` INT NOT NULL AUTO_INCREMENT,
  `descripcion_estado` VARCHAR(16) NULL check(descripcion_estado in('Disponible','En uso','No disponible','En reparacion')),
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  PRIMARY KEY (`id_estado_bicicleta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `arriendo_bicicletas_urbanas`.`Bicicletas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arriendo_bicicletas_urbanas`.`Bicicletas` (
  `id_bicicleta` INT NOT NULL AUTO_INCREMENT,
  `estacion_asignada` INT NOT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  `id_estacion` INT NOT NULL,
  `id_tipo_bicicletas` INT NOT NULL,
  `id_estado_bicicleta` INT NOT NULL,
  `id_usuario_dueño` INT NOT NULL,
  PRIMARY KEY (`id_bicicleta`, `id_estacion`, `id_tipo_bicicletas`, `id_estado_bicicleta`, `id_usuario_dueño`),
  UNIQUE INDEX `id_bicicleta_UNIQUE` (`id_bicicleta` ASC) VISIBLE,
  INDEX `fk_Bicicletas_Estaciones1_idx` (`id_estacion` ASC) VISIBLE,
  INDEX `fk_Bicicletas_tipo_bicicletas1_idx` (`id_tipo_bicicletas` ASC) VISIBLE,
  INDEX `fk_Bicicletas_estado_bicicletas1_idx` (`id_estado_bicicleta` ASC) VISIBLE,
  INDEX `fk_Bicicletas_Usuarios1_idx` (`id_usuario_dueño` ASC) VISIBLE,
  CONSTRAINT `fk_Bicicletas_Estaciones1`
    FOREIGN KEY (`id_estacion`)
    REFERENCES `arriendo_bicicletas_urbanas`.`Estaciones` (`id_estacione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bicicletas_tipo_bicicletas1`
    FOREIGN KEY (`id_tipo_bicicletas`)
    REFERENCES `arriendo_bicicletas_urbanas`.`tipo_bicicletas` (`id_tipo_bicicletas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bicicletas_estado_bicicletas1`
    FOREIGN KEY (`id_estado_bicicleta`)
    REFERENCES `arriendo_bicicletas_urbanas`.`estado_bicicletas` (`id_estado_bicicleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bicicletas_Usuarios1`
    FOREIGN KEY (`id_usuario_dueño`)
    REFERENCES `arriendo_bicicletas_urbanas`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `arriendo_bicicletas_urbanas`.`Arriendos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arriendo_bicicletas_urbanas`.`Arriendos` (
  `id_arriendo` INT NOT NULL AUTO_INCREMENT,
  `id_bicicleta` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `fecha_inicio` DATETIME NULL,
  `fecha_fin` DATETIME NULL check(fecha_fin > fecha_inicio),
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  `id_estacion_inicio` INT NOT NULL,
  `Estaciones_id_estacione1` INT NOT NULL,
  PRIMARY KEY (`id_arriendo`, `id_bicicleta`, `id_usuario`, `id_estacion_inicio`, `Estaciones_id_estacione1`),
  UNIQUE INDEX `id_arriendo_UNIQUE` (`id_arriendo` ASC) VISIBLE,
  INDEX `fk_Arriendos_Bicicletas1_idx` (`id_bicicleta` ASC) VISIBLE,
  INDEX `fk_Arriendos_Usuarios1_idx` (`id_usuario` ASC) VISIBLE,
  INDEX `fk_Arriendos_Estaciones1_idx` (`id_estacion_inicio` ASC) VISIBLE,
  INDEX `fk_Arriendos_Estaciones2_idx` (`Estaciones_id_estacione1` ASC) VISIBLE,
  CONSTRAINT `fk_Arriendos_Bicicletas1`
    FOREIGN KEY (`id_bicicleta`)
    REFERENCES `arriendo_bicicletas_urbanas`.`Bicicletas` (`id_bicicleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arriendos_Usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `arriendo_bicicletas_urbanas`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arriendos_Estaciones1`
    FOREIGN KEY (`id_estacion_inicio`)
    REFERENCES `arriendo_bicicletas_urbanas`.`Estaciones` (`id_estacione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arriendos_Estaciones2`
    FOREIGN KEY (`Estaciones_id_estacione1`)
    REFERENCES `arriendo_bicicletas_urbanas`.`Estaciones` (`id_estacione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `arriendo_bicicletas_urbanas`.`Historial_uso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arriendo_bicicletas_urbanas`.`Historial_uso` (
  `id_Historial` INT NOT NULL AUTO_INCREMENT,
  `id_bicicleta` INT NOT NULL,
  `registro_historial` VARCHAR(500) NULL check(char_length(registro_historial) > 12),
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  PRIMARY KEY (`id_Historial`, `id_bicicleta`),
  UNIQUE INDEX `id_Historial_UNIQUE` (`id_Historial` ASC) VISIBLE,
  INDEX `fk_Historial_uso_Bicicletas1_idx` (`id_bicicleta` ASC) VISIBLE,
  UNIQUE INDEX `id_bicicleta_UNIQUE` (`id_bicicleta` ASC) VISIBLE,
  CONSTRAINT `fk_Historial_uso_Bicicletas1`
    FOREIGN KEY (`id_bicicleta`)
    REFERENCES `arriendo_bicicletas_urbanas`.`Bicicletas` (`id_bicicleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `arriendo_bicicletas_urbanas`.`Multas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `arriendo_bicicletas_urbanas`.`Multas` (
  `id_Multa` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `descripcion_multa` VARCHAR(120) NULL check(char_length(descipcion_multa) > 16),
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `created_by` INT NULL,
  `updated_by` INT NULL,
  `deleted` TINYINT NULL,
  PRIMARY KEY (`id_Multa`, `id_usuario`),
  UNIQUE INDEX `id_Multa_UNIQUE` (`id_Multa` ASC) VISIBLE,
  INDEX `fk_Multas_Usuarios1_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Multas_Usuarios1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `arriendo_bicicletas_urbanas`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

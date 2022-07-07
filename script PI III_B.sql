-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema healthis
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema healthis
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `healthis` DEFAULT CHARACTER SET utf8 ;
USE `healthis` ;

-- -----------------------------------------------------
-- Table `healthis`.`PaginaWeb1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `healthis`.`PaginaWeb1` (
  `DataInicio` INT NOT NULL,
  `GrupoCrianca` VARCHAR(45) NULL,
  `Grupoi` VARCHAR(45) NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `healthis`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `healthis`.`endereco` (
  `id_endereco` INT NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `cep` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `uf` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_endereco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `healthis`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `healthis`.`usuario` (
  `id_usuario` INT NOT NULL,
  `nome_usuario` VARCHAR(100) NOT NULL,
  `cpf` INT NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `dt_nascimento` DATE NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `endereco_id_endereco` INT NULL,
  PRIMARY KEY (`id_usuario`, `endereco_id_endereco`),
  INDEX `fk_usuario_endereco1_idx` (`endereco_id_endereco` ASC),
  CONSTRAINT `fk_usuario_endereco1`
    FOREIGN KEY (`endereco_id_endereco`)
    REFERENCES `healthis`.`endereco` (`id_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `healthis`.`unidade_saude`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `healthis`.`unidade_saude` (
  `id_unidade_saude` INT NOT NULL,
  `nome_unidade` VARCHAR(45) NOT NULL,
  `endereco_id_endereco` INT NOT NULL,
  PRIMARY KEY (`id_unidade_saude`, `endereco_id_endereco`),
  INDEX `fk_unidade_saude_endereco1_idx` (`endereco_id_endereco` ASC) VISIBLE,
  CONSTRAINT `fk_unidade_saude_endereco1`
    FOREIGN KEY (`endereco_id_endereco`)
    REFERENCES `healthis`.`endereco` (`id_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `healthis`.`vacinacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `healthis`.`vacinacao` (
  `id_vacinacao` INT NOT NULL,
  `dt_vacinacao` DATE NOT NULL,
  `dt_proxima_dose` DATE NOT NULL,
  `reacao` VARCHAR(45) NOT NULL,
  `descricao_reacao` VARCHAR(2000) NOT NULL,
  `unidade_saude_id_unidade_saude` INT NOT NULL,
  `unidade_saude_endereco_id_endereco` INT NOT NULL,
  PRIMARY KEY (`id_vacinacao`, `unidade_saude_id_unidade_saude`, `unidade_saude_endereco_id_endereco`),
  INDEX `fk_vacinacao_unidade_saude1_idx` (`unidade_saude_id_unidade_saude` ASC, `unidade_saude_endereco_id_endereco` ASC) VISIBLE,
  CONSTRAINT `fk_vacinacao_unidade_saude1`
    FOREIGN KEY (`unidade_saude_id_unidade_saude` , `unidade_saude_endereco_id_endereco`)
    REFERENCES `healthis`.`unidade_saude` (`id_unidade_saude` , `endereco_id_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `healthis`.`usuario_has_vacinacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `healthis`.`usuario_has_vacinacao` (
  `usuario_id_usuario` INT NULL,
  `vacinacao_id_vacinacao` INT NULL,
  PRIMARY KEY (`usuario_id_usuario`, `vacinacao_id_vacinacao`),
  INDEX `fk_usuario_has_vacinacao_vacinacao1_idx` (`vacinacao_id_vacinacao` ASC) VISIBLE,
  INDEX `fk_usuario_has_vacinacao_usuario_idx` (`usuario_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_has_vacinacao_usuario`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `healthis`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_vacinacao_vacinacao1`
    FOREIGN KEY (`vacinacao_id_vacinacao`)
    REFERENCES `healthis`.`vacinacao` (`id_vacinacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `healthis`.`vacina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `healthis`.`vacinas` (
  `id_vacina` INT NOT NULL,
  `nome_vacina` VARCHAR(45) NOT NULL,
  `quantidade_dose` INT NOT NULL,
  `validade` DATE NOT NULL,
  `lote` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_vacina`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `healthis`.`vacina_has_vacinacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `healthis`.`vacina_has_vacinacao` (
  `vacina_id_vacina` INT NOT NULL,
  `vacinacao_id_vacinacao` INT NOT NULL,
  PRIMARY KEY (`vacina_id_vacina`, `vacinacao_id_vacinacao`),
  INDEX `fk_vacina_has_vacinacao_vacinacao1_idx` (`vacinacao_id_vacinacao` ASC) VISIBLE,
  INDEX `fk_vacina_has_vacinacao_vacina1_idx` (`vacina_id_vacina` ASC) VISIBLE,
  CONSTRAINT `fk_vacina_has_vacinacao_vacina1`
    FOREIGN KEY (`vacina_id_vacina`)
    REFERENCES `healthis`.`vacina` (`id_vacina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vacina_has_vacinacao_vacinacao1`
    FOREIGN KEY (`vacinacao_id_vacinacao`)
    REFERENCES `healthis`.`vacinacao` (`id_vacinacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

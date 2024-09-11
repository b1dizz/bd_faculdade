-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema halloween
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema halloween
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `halloween` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `halloween` ;

-- -----------------------------------------------------
-- Table `halloween`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `halloween`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `idade` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 10001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `halloween` ;

-- -----------------------------------------------------
-- procedure InsereUsuariosAleatorios
-- -----------------------------------------------------

DELIMITER $$
USE `halloween`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsereUsuariosAleatorios`()
BEGIN
    DECLARE i INT DEFAULT 0;

    -- Loop para inserir 10.000 registros
    WHILE i < 10000 DO
        -- Gere dados aleatórios para os campos
        SET @nome = CONCAT('Usuario', i);
        SET @email = CONCAT('usuario', i, '@exemplo.com');
        SET @idade = FLOOR(RAND() * 80) + 18;  -- Gera uma idade entre 18 e 97 anos

        -- Insira o novo registro na tabela de usuários
        INSERT INTO usuarios (nome, email, idade) VALUES (@nome, @email, @idade);

        -- Incrementa o contador
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

CALL InsereUsuariosAleatorios(); 

-- Conta o número total de registros na tabela 'usuarios'
SELECT COUNT(*) FROM usuarios;

-- Seleciona os primeiros 10 registros da tabela 'usuarios'
SELECT * FROM usuarios LIMIT 10;

-- Agrupa os registros por idade e conta a quantidade de usuários para cada idade
SELECT idade, COUNT(*) AS quantidade FROM usuarios GROUP BY idade;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

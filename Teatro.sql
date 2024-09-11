-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema teatro
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema teatro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `teatro` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `teatro` ;

-- -----------------------------------------------------
-- Table `teatro`.`pecas_teatro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `teatro`.`pecas_teatro` (
  `id_peca` INT NOT NULL AUTO_INCREMENT,
  `nome_peca` VARCHAR(100) NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `duracao` INT NULL DEFAULT NULL,
  `data_hora` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id_peca`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `teatro` ;

-- -----------------------------------------------------
-- function calcular_media_duracao
-- -----------------------------------------------------

DELIMITER $$
USE `teatro`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_media_duracao`(id INT) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE media DECIMAL(10,2);
    SELECT AVG(duracao) INTO media
    FROM pecas_teatro
    WHERE id_peca = id;
    RETURN media;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function verificar_disponibilidade
-- -----------------------------------------------------

DELIMITER $$
USE `teatro`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `verificar_disponibilidade`(p_data_hora DATETIME) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    DECLARE existe INT;
    
    -- Contar quantas entradas existem para a data e hora fornecidas
    SELECT COUNT(*) INTO existe
    FROM pecas_teatro
    WHERE data_hora = p_data_hora;
    
    -- Verificar se existe alguma entrada para a data e hora fornecidas
    IF existe > 0 THEN
        RETURN FALSE;  -- Não está disponível
    ELSE
        RETURN TRUE;   -- Está disponível
    END IF;
END$$

DELIMITER ;

INSERT INTO pecas_teatro (nome_peca, descricao, duracao, data_hora)
VALUES 
('A Morte de um Caixeiro Viajante', 'Uma peça dramática que explora o colapso emocional e financeiro de um vendedor.', 120, '2024-10-01 15:00:00'),
('O Doente Imaginário', 'Comédia clássica de Molière sobre um homem que se finge de doente.', 90, '2024-10-15 21:00:00'),
('Romeu e Julieta', 'A famosa tragédia de Shakespeare sobre dois jovens amantes cujas famílias estão em conflito. A peça explora temas de amor, ódio e destino.', 150, '2024-10-05 20:00:00'),
('O Rei Lear', 'Tragédia shakespeariana sobre um rei que divide seu reino entre suas filhas e sofre as consequências de suas decisões.', 180, '2024-12-01 18:00:00'),
('Hamlet', 'Uma tragédia de Shakespeare sobre um príncipe que busca vingar a morte de seu pai.', 150, '2024-12-15 19:30:00');


-- Testar a função verificar_disponibilidade
SELECT verificar_disponibilidade('2024-10-01 19:00:00'); -- Deve retornar FALSE (0) porque essa data e hora estão ocupadas
SELECT verificar_disponibilidade('2024-10-05 19:00:00'); -- Deve retornar TRUE (1) porque essa data e hora não estão ocupadas


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

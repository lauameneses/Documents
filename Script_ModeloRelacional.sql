SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE DATABASE db_vuelo CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE db_vuelo;

#CREACIÓN DE LA TABLA CON INFORMACIÓN DEL AVIÓN
CREATE TABLE IF NOT EXISTS `db_vuelo`.`avion` (
  `matricula` VARCHAR(30) NOT NULL,
  `modelo` VARCHAR(30) NOT NULL,
  `capacidad` VARCHAR(30) NOT NULL,
  `fabricante` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`matricula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

#CREACIÓN DE LA TABLA CON INFORMACIÓN PERSONAL DE LOS PASAJEROS
CREATE TABLE IF NOT EXISTS `db_vuelo`.`pasajeros` (
  `identificacion` VARCHAR(20) NOT NULL,
  `nombre_completo` VARCHAR(50) NOT NULL,
  `telefono` BIGINT NOT NULL,
  `edad` INT NULL DEFAULT NULL,
  `vacunacion` TINYINT(1) NOT NULL,
  `lugar_origen` VARCHAR(20) NULL DEFAULT NULL,
  `asiento` VARCHAR(20) NOT NULL,
  `id_pasajero` INT NOT NULL AUTO_INCREMENT,
  UNIQUE INDEX `identificacion` (`identificacion` ASC) VISIBLE,
  UNIQUE INDEX `asiento` (`asiento` ASC) VISIBLE,
  PRIMARY KEY (`id_pasajero`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


#CREACIÓN DE LA TABLA CON INFORMACIÓN DEL VUELO
CREATE TABLE IF NOT EXISTS `db_vuelo`.`info_vuelo` (
  `id_vuelo` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE,
  `num_pasajeros` INT NOT NULL,
  `aerolinea` VARCHAR(20) NOT NULL,
  `ciudadPais_origen` VARCHAR(50) NOT NULL,
  `ciudadPais_destino` VARCHAR(50) NOT NULL,
  `aeropuerto_origen` VARCHAR(30) NOT NULL,
  `aeropuerto_destino` VARCHAR(30) NOT NULL,
  `hora_salida` TIME NULL DEFAULT '00:00:00',
  `hora_llegada` TIME NULL DEFAULT '00:00:00',
  `pasajeros_id_pasajero` INT NOT NULL,
  `avion_matricula` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_vuelo`, `pasajeros_id_pasajero`, `avion_matricula`),
  INDEX `fk_info_vuelo_pasajeros1_idx` (`pasajeros_id_pasajero` ASC) VISIBLE,
  INDEX `fk_info_vuelo_avion1_idx` (`avion_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_info_vuelo_pasajeros1`
    FOREIGN KEY (`pasajeros_id_pasajero`)
    REFERENCES `db_vuelo`.`pasajeros` (`id_pasajero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_info_vuelo_avion1`
    FOREIGN KEY (`avion_matricula`)
    REFERENCES `db_vuelo`.`avion` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

SHOW COLUMNS FROM info_vuelo;
SHOW TABLES;
SHOW COLUMNS FROM avion;
SHOW COLUMNS FROM pasajeros;


#INSERCIÓN DE LOS DATOS
INSERT INTO avion VALUES('FAK-123', 'B-747', '550', 'Boeing'),
('ES-431', 'B-749', '679', 'Boeing'),
('CP-35', 'AIR-678', '150', 'Airbus'),
('CC-456', 'CRJ-900', '550', 'Bombardier'),
('HK-909', 'AER-211', '270', 'Embraer');

INSERT INTO info_vuelo (fecha, num_pasajeros, aerolinea, ciudadPais_origen, ciudadPais_destino, aeropuerto_origen, aeropuerto_destino, hora_salida, hora_llegada, pasajeros_id_pasajero, avion_matricula) 
VALUES('2021-06-29', 5, 'Avianca', 'Bogotá, Colombia', 'Madrid, España', 'El Dorado', 'Adolfo Suárez', '23:40:00', '08:40:00', 1, 'FAK-123'),
('2021-07-05', 5, 'Air New Zealand', 'Bogotá, Colombia', 'Wellington, New Zeland', 'El Dorado', 'Adolfo Suárez', '12:40:00', '16:30:00', 2, 'ES-431'),
('2021-07-06', 6, 'Singapore Airlines', 'Singapur, Singapur', 'Bogotá, Colombia', 'Jewel Changi', 'El Dorado', '08:23:00', '14:44:00', 3, 'CP-35'),
('2021-07-07', 4, 'Emirates', 'Bogotá, Colombia', 'Abu Dhabi, Emiratos', 'El Dorado', 'AUH', '21:20:00', '10:40:00', 4, 'CC-456'),
('2021-07-08', 3, 'Qantas', 'Canberra, Australia', 'Bogotá, Colombia', 'CIA', 'El Dorado', '23:40:00', '11:35:00', 5, 'HK-909');

INSERT INTO pasajeros(identificacion, nombre_completo, telefono, edad, vacunacion, lugar_origen, asiento) 
VALUES(1037650103, 'Laura Victoria Meneses Linares', 3213713064, 24, 0, 'Armenia', 'A03'),
(28722591, 'Salomé Beltrán Linares', 3024841477, 17, 0, 'Cali', 'A05'),
(28794567, 'Juan Camilo Castaño ', 3213713056, 24, 0, 'Calarcá', 'A01'),
(1094959657, 'Nohemy Linares Trujillo', 3213713045, 68, 1, 'Ibagué', 'B06'),
(1037650123, 'Ninfa Linares Trujillo', 3212313064, 51, 1, 'Roncesvalles', 'C05'),
(28765456, 'Maria Camila Meneses Cabezas', 3023713064, 23, 0, 'Ibagué', 'F01'),
(1094567899, 'Leandro Meneses Murcia', 3223813064, 56, 1, 'Armenia', 'K07'),
(28734567, 'Sarita Meneses Tellez', 3213714567, 14, 0, 'Armenia', 'B03'),
(28722890, 'Juan Manuel Rios', 3223456134, 21, 0, 'Ibagué', 'D02'),
(1037650107, 'Yeison Fabián Sánchez Linares', 3145673456, 21, 0, 'Roncesvalles', 'J06');


#RESETEO DE LA TABLA INFO_VIAJE
SET FOREIGN_KEY_CHECKS=0;
TRUNCATE TABLE info_vuelo;
SET FOREIGN_KEY_CHECKS=1;

#VISUALIZACIÓN DE LAS TABLAS
SELECT * FROM pasajeros;
SELECT * FROM info_vuelo;
SELECT * FROM avion;


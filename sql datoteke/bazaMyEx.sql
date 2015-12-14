-- --------------------------------------------------------
-- Strežnik:                     127.0.0.1
-- Server version:               5.7.10-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Različica:           9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for estudent
CREATE DATABASE IF NOT EXISTS `estudent` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `estudent`;


-- Dumping structure for tabela estudent.izpitnirok
CREATE TABLE IF NOT EXISTS `izpitnirok` (
  `idIzpitniRok` int(11) NOT NULL AUTO_INCREMENT,
  `idPredmeta` int(11) NOT NULL,
  `stRoka` int(11) NOT NULL,
  `datum` date NOT NULL,
  `prostor` varchar(45) NOT NULL,
  `komentar` varchar(256) NOT NULL,
  `zakljucen` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idIzpitniRok`),
  KEY `fk_IzpitniRok_Predmet1_idx` (`idPredmeta`),
  CONSTRAINT `fk_IzpitniRok_Predmet1` FOREIGN KEY (`idPredmeta`) REFERENCES `predmet` (`idPredmet`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table estudent.izpitnirok: ~0 rows (približno)
DELETE FROM `izpitnirok`;
/*!40000 ALTER TABLE `izpitnirok` DISABLE KEYS */;
/*!40000 ALTER TABLE `izpitnirok` ENABLE KEYS */;


-- Dumping structure for tabela estudent.ocena
CREATE TABLE IF NOT EXISTS `ocena` (
  `idOcena` int(11) NOT NULL AUTO_INCREMENT,
  `idStudenta` int(11) NOT NULL,
  `idPredmeta` int(11) NOT NULL,
  `idIzpitnegaRoka` int(11) NOT NULL,
  `sTock` int(11) NOT NULL,
  `ocena` int(11) NOT NULL,
  PRIMARY KEY (`idOcena`),
  KEY `fk_Ocena_Uporabnik1_idx` (`idStudenta`),
  KEY `fk_Ocena_Predmet1_idx` (`idPredmeta`),
  KEY `fk_Ocena_IzpitniRok1_idx` (`idIzpitnegaRoka`),
  CONSTRAINT `fk_Ocena_IzpitniRok1` FOREIGN KEY (`idIzpitnegaRoka`) REFERENCES `izpitnirok` (`idIzpitniRok`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ocena_Predmet1` FOREIGN KEY (`idPredmeta`) REFERENCES `predmet` (`idPredmet`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ocena_Uporabnik1` FOREIGN KEY (`idStudenta`) REFERENCES `uporabnik` (`idUporabnik`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table estudent.ocena: ~0 rows (približno)
DELETE FROM `ocena`;
/*!40000 ALTER TABLE `ocena` DISABLE KEYS */;
/*!40000 ALTER TABLE `ocena` ENABLE KEYS */;


-- Dumping structure for tabela estudent.predmet
CREATE TABLE IF NOT EXISTS `predmet` (
  `idPredmet` int(11) NOT NULL AUTO_INCREMENT,
  `imePredmeta` varchar(45) NOT NULL,
  `idIzvajalca` int(11) NOT NULL,
  `stKreditnih` int(11) NOT NULL,
  PRIMARY KEY (`idPredmet`),
  KEY `fk_Predmet_Uporabnik_idx` (`idIzvajalca`),
  CONSTRAINT `idIzvajalca` FOREIGN KEY (`idIzvajalca`) REFERENCES `uporabnik` (`idUporabnik`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table estudent.predmet: ~0 rows (približno)
DELETE FROM `predmet`;
/*!40000 ALTER TABLE `predmet` DISABLE KEYS */;
/*!40000 ALTER TABLE `predmet` ENABLE KEYS */;


-- Dumping structure for tabela estudent.studentpredmet
CREATE TABLE IF NOT EXISTS `studentpredmet` (
  `idStudentPredmet` int(11) NOT NULL AUTO_INCREMENT,
  `idStudenta` int(11) NOT NULL,
  `idPredmeta` int(11) NOT NULL,
  `opravljen` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idStudentPredmet`),
  KEY `fk_StudentPredmet_Uporabnik1_idx` (`idStudenta`),
  KEY `fk_StudentPredmet_Predmet1_idx` (`idPredmeta`),
  CONSTRAINT `fk_StudentPredmet_Predmet1` FOREIGN KEY (`idPredmeta`) REFERENCES `predmet` (`idPredmet`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_StudentPredmet_Uporabnik1` FOREIGN KEY (`idStudenta`) REFERENCES `uporabnik` (`idUporabnik`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table estudent.studentpredmet: ~0 rows (približno)
DELETE FROM `studentpredmet`;
/*!40000 ALTER TABLE `studentpredmet` DISABLE KEYS */;
/*!40000 ALTER TABLE `studentpredmet` ENABLE KEYS */;


-- Dumping structure for tabela estudent.uporabnik
CREATE TABLE IF NOT EXISTS `uporabnik` (
  `idUporabnik` int(11) NOT NULL AUTO_INCREMENT,
  `vpisnaStevilka` int(11) DEFAULT NULL,
  `ime` varchar(45) NOT NULL,
  `priimek` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `geslo` varchar(45) NOT NULL,
  `mobi` varchar(45) NOT NULL,
  `spol` char(1) NOT NULL,
  `letnikStudija` int(11) DEFAULT NULL,
  `datumRegistracije` datetime NOT NULL,
  `zadnjiDostop` datetime NOT NULL,
  `idVloge` int(11) NOT NULL,
  PRIMARY KEY (`idUporabnik`),
  UNIQUE KEY `idUporabnik_UNIQUE` (`idUporabnik`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `vpisnaStevilka_UNIQUE` (`vpisnaStevilka`),
  KEY `fk_Uporabnik_Vloga1_idx` (`idVloge`),
  CONSTRAINT `fk_Uporabnik_Vloga1` FOREIGN KEY (`idVloge`) REFERENCES `vloga` (`idVloga`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table estudent.uporabnik: ~0 rows (približno)
DELETE FROM `uporabnik`;
/*!40000 ALTER TABLE `uporabnik` DISABLE KEYS */;
/*!40000 ALTER TABLE `uporabnik` ENABLE KEYS */;


-- Dumping structure for tabela estudent.vloga
CREATE TABLE IF NOT EXISTS `vloga` (
  `idVloga` int(11) NOT NULL AUTO_INCREMENT,
  `nazivVloge` varchar(45) NOT NULL,
  PRIMARY KEY (`idVloga`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Dumping data for table estudent.vloga: ~0 rows (približno)
DELETE FROM `vloga`;
/*!40000 ALTER TABLE `vloga` DISABLE KEYS */;
INSERT INTO `vloga` (`idVloga`, `nazivVloge`) VALUES
	(1, 'student'),
	(2, 'profesor'),
	(3, 'referat');
/*!40000 ALTER TABLE `vloga` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

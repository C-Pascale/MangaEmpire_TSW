CREATE DATABASE  IF NOT EXISTS `website` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `website`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: website
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appartiene`
--

DROP TABLE IF EXISTS `appartiene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appartiene` (
  `prodotto` varchar(13) NOT NULL,
  `categoria` varchar(15) NOT NULL,
  KEY `categoria_idx` (`categoria`),
  KEY `prodotto_idx` (`prodotto`),
  CONSTRAINT `categoria` FOREIGN KEY (`categoria`) REFERENCES `categoria` (`nome`),
  CONSTRAINT `prodotto` FOREIGN KEY (`prodotto`) REFERENCES `prodotto` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appartiene`
--

LOCK TABLES `appartiene` WRITE;
/*!40000 ALTER TABLE `appartiene` DISABLE KEYS */;
INSERT INTO `appartiene` VALUES ('12334','action'),('12334','comedy'),('343341','action'),('262145221','action'),('291145221','action'),('291145221','comedy'),('1234','fantasy'),('1234','horror'),('121145221','comedy'),('121145221','slice of life'),('152145221','comedy'),('152145221','action'),('1111111111111','horror'),('1111111111111','fantasy'),('282145221','action'),('282145221','comedy');
/*!40000 ALTER TABLE `appartiene` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `nome` varchar(15) NOT NULL,
  PRIMARY KEY (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES ('action'),('comedy'),('ecchi'),('fantascienza'),('fantasy'),('horror'),('isekai'),('mecha'),('romakome'),('romcom'),('slice of life'),('spokon'),('thriller');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordinato`
--

DROP TABLE IF EXISTS `ordinato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordinato` (
  `ISBNprodotto` varchar(13) NOT NULL,
  `ordine` varchar(9) NOT NULL,
  PRIMARY KEY (`ISBNprodotto`,`ordine`),
  KEY `ordine_idx` (`ordine`),
  CONSTRAINT `ISBNprodotto` FOREIGN KEY (`ISBNprodotto`) REFERENCES `prodotto` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ordine` FOREIGN KEY (`ordine`) REFERENCES `ordine` (`codice`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordinato`
--

LOCK TABLES `ordinato` WRITE;
/*!40000 ALTER TABLE `ordinato` DISABLE KEYS */;
INSERT INTO `ordinato` VALUES ('12334','1'),('262145221','1'),('12334','10'),('12334','12'),('262145221','12'),('291145221','13'),('343341','17'),('291145221','18'),('343341','18'),('1234','19'),('343341','20'),('291145221','23'),('1234','24'),('262145221','24'),('12334','25'),('1234','27'),('121145221','28'),('1234','28'),('251146221','4'),('251146221','5'),('262145221','5'),('262145221','6'),('252145220','7'),('343341','8'),('251146221','9'),('343341','9');
/*!40000 ALTER TABLE `ordinato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordine`
--

DROP TABLE IF EXISTS `ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordine` (
  `codice` varchar(9) NOT NULL,
  `totale` float NOT NULL,
  `indirizzo` varchar(45) NOT NULL,
  `data` date NOT NULL,
  `costospedizione` float NOT NULL,
  `status` varchar(15) NOT NULL,
  `arrivoprevisto` date NOT NULL,
  `utente` varchar(50) NOT NULL,
  PRIMARY KEY (`codice`),
  KEY `utente_idx` (`utente`),
  CONSTRAINT `utente` FOREIGN KEY (`utente`) REFERENCES `utente` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordine`
--

LOCK TABLES `ordine` WRITE;
/*!40000 ALTER TABLE `ordine` DISABLE KEYS */;
INSERT INTO `ordine` VALUES ('1',1154.69,'Via NomeRandom, Numero','2022-08-19',4.99,'in Lavorazione','2022-08-21','m.giella4@studenti.unisa.it'),('10',14,'Piazze Auriggemma 6','2022-08-28',4.99,'in Lavorazione','2022-08-30','c.pascale15@studenti.unisa.it'),('11',6.99,'Piazze Auriggemma 6','2022-08-28',4.99,'in Lavorazione','2022-08-30','c.pascale15@studenti.unisa.it'),('12',25.98,'Via corso vittorio emanuele 13','2022-09-02',4.99,'in Lavorazione','2022-09-04','fmalanga@gmail.com'),('13',26.98,'Via corso vittorio emanuele 13	83100','2022-09-03',0,'in Lavorazione','2022-09-08','m.giella4@studenti.unisa.it'),('14',0,'Via corso vittorio emanuele 13	83100','2022-09-03',0,'in Lavorazione','2022-09-08','m.giella4@studenti.unisa.it'),('15',4.99,'Via corso vittorio emanuele 13	83100','2022-09-03',0,'in Lavorazione','2022-09-08','m.giella4@studenti.unisa.it'),('16',0,'Via corso vittorio emanuele 13	83100','2022-09-03',0,'in Lavorazione','2022-09-08','m.giella4@studenti.unisa.it'),('17',14,'Via corso vittorio emanuele	83100','2022-09-04',4.99,'in Lavorazione','2022-09-06','c.pascale15@studenti.unisa.it'),('18',39.98,'Via corso vittorio emanuele 13	83100','2022-09-04',0,'in Lavorazione','2022-09-09','m.giella4@studenti.unisa.it'),('19',11.23,'Via corso vittorio emanuele 13	83100','2022-09-04',4.99,'in Lavorazione','2022-09-06','m.giella4@studenti.unisa.it'),('20',742,'Via corso vittorio emanuele 13	83100','2022-09-04',0,'in Lavorazione','2022-09-09','m.giella4@studenti.unisa.it'),('21',0,'Via corso vittorio emanuele 13	83100','2022-09-04',0,'in Lavorazione','2022-09-09','m.giella4@studenti.unisa.it'),('22',0,'Via corso vittorio emanuele 13	83100','2022-09-04',0,'in Lavorazione','2022-09-09','m.giella4@studenti.unisa.it'),('23',688.47,'Via corso vittorio emanuele 13	83100','2022-09-04',4.99,'in Lavorazione','2022-09-06','m.giella4@studenti.unisa.it'),('24',36.18,'Via corso vittorio emanuele 13	83100','2022-09-04',0,'in Lavorazione','2022-09-09','m.giella4@studenti.unisa.it'),('25',14,'Via corso vittorio emanuele 13	83100','2022-09-06',4.99,'in Lavorazione','2022-09-08','m.giella4@studenti.unisa.it'),('26',0,'Via corso vittorio emanuele 13	83100','2022-09-06',4.99,'in Lavorazione','2022-09-08','m.giella4@studenti.unisa.it'),('27',11.23,'Via corso vittorio emanuele 13	83100','2022-09-06',0,'in Lavorazione','2022-09-11','m.giella4@studenti.unisa.it'),('28',924.64,'Via corso vittorio emanuele 13	83100','2022-09-07',0,'in Lavorazione','2022-09-12','m.giella4@studenti.unisa.it'),('4',10.25,'Via NomeRandom, Numero','2022-05-13',4.99,'in Lavorazione','2022-05-18','m.giella4@studenti.unisa.it'),('5',11.21,'Via corso vittorio emanuele','2022-05-13',0,'in Lavorazione','2022-05-18','fmalanga@gmail.com'),('6',23.14,'Via NomeRandom, Numero','2022-05-16',4.99,'in Lavorazione','2022-05-18','m.giella4@studenti.unisa.it'),('7',5.12,'Via NomeRandom, Numero','2022-05-16',0,'in Lavorazione','2022-05-21','m.giella4@studenti.unisa.it'),('8',14,'Via NomeRandom, Numero','2022-07-09',0,'in Lavorazione','2022-07-14','m.giella4@studenti.unisa.it'),('9',35,'Via NomeRandom, Numero','2022-08-19',4.99,'in Lavorazione','2022-08-21','m.giella4@studenti.unisa.it');
/*!40000 ALTER TABLE `ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodottiacquistati`
--

DROP TABLE IF EXISTS `prodottiacquistati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodottiacquistati` (
  `idprodotto` char(9) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `quantità` int NOT NULL,
  `costo` float NOT NULL,
  `iva` decimal(5,2) NOT NULL,
  `numeroordine` varchar(9) NOT NULL,
  PRIMARY KEY (`idprodotto`),
  KEY `numeroordine_idx` (`numeroordine`),
  CONSTRAINT `numeroordine` FOREIGN KEY (`numeroordine`) REFERENCES `ordine` (`codice`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodottiacquistati`
--

LOCK TABLES `prodottiacquistati` WRITE;
/*!40000 ALTER TABLE `prodottiacquistati` DISABLE KEYS */;
INSERT INTO `prodottiacquistati` VALUES ('0','HxH 1',2,4.2,22.00,'4'),('10','Jojo Vento Aureo 4',1,14,3.08,'10'),('11','Dragon Ball Z 20',1,6.99,1.54,'11'),('12','Kaiju No.8 2',1,4.99,1.10,'12'),('13','Jojo Vento Aureo 4',1,14,3.08,'12'),('14','Dragon Ball Z 20',1,6.99,1.54,'12'),('15','Naruto 18',1,12.99,2.86,'13'),('16','Dragon Ball Z 20',1,6.99,1.54,'13'),('17','Le bizzarre avventure di JoJo  1',1,7,1.54,'13'),('18','Naruto 16',1,4.99,1.10,'15'),('19','HxH 33',1,14,3.08,'17'),('2','Kaiju No.8 2',1,4.99,22.00,'5'),('20','Naruto 18',2,12.99,2.86,'18'),('21','HxH 33',1,14,3.08,'18'),('22','Berserk 23',1,11.23,2.47,'19'),('23','HxH 33',53,14,3.08,'20'),('24','Naruto 18',53,12.99,2.86,'23'),('25','Berserk 23',1,11.23,2.47,'24'),('26','Naruto 16',4,4.99,1.10,'24'),('27','Kaiju No.8 2',1,4.99,1.10,'24'),('28','Jojo Vento Aureo 4',1,14,3.08,'25'),('29','Berserk 23',1,11.23,2.47,'27'),('3','Kaiju No.8 2',1,4.99,22.00,'6'),('30','Dragon Ball Z 20',112,6.99,1.54,'28'),('31','Berserk 23',12,11.23,2.47,'28'),('32','Le bizzarre avventure di JoJo  1',1,7,1.54,'28'),('4','Dragon Ball Z 20',2,6.99,22.00,'6'),('5','HxH 5',1,4.2,22.00,'7'),('6','HxH 33',1,14,3.08,'8'),('7','HxH 33',1,14,3.08,'9'),('8','HxH 1',5,4.2,0.92,'9'),('9','Dragon Ball Z 20',1,6.99,1.54,'1');
/*!40000 ALTER TABLE `prodottiacquistati` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto` (
  `isbn` varchar(13) NOT NULL,
  `prezzo` float NOT NULL,
  `autore` varchar(45) NOT NULL,
  `quantità` int NOT NULL,
  `iva` decimal(5,2) NOT NULL,
  `serie` varchar(60) NOT NULL,
  `volume` int NOT NULL,
  `descrizione` varchar(300) NOT NULL,
  `copertina` varchar(400) NOT NULL,
  `dataInserimento` datetime DEFAULT NULL,
  PRIMARY KEY (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
INSERT INTO `prodotto` VALUES ('1111111111111',11.23,'Kentar&#333; Miura',1234,2.47,'Berserk',24,'noooo','https://images-na.ssl-images-amazon.com/images/I/51DLXjb+QSL._SY344_BO1,204,203,200_.jpg','2022-09-06 00:00:00'),('121145221',7,'Hirohiko Araki',43,1.54,'Le bizzarre avventure di JoJo ',1,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec.','https://mangayo.it/736-large_default/le-bizzarre-avventure-di-jojo-phantom-blood-1.jpg','2022-09-04 00:00:00'),('12334',14,'Araki',329,3.08,'Jojo Vento Aureo',4,'Lorem Ipsum','https://i.ebayimg.com/images/g/4akAAOSwHTlgjFMC/s-l500.jpg','2022-08-24 00:00:00'),('1234',11.23,'Kentar&#333; Miura',1219,2.47,'Berserk',23,'lorem','https://images-na.ssl-images-amazon.com/images/I/91+5iK08evL.jpg','2022-09-04 00:00:00'),('152145221',4.99,'Masashi Kishimoto',40,1.10,'Naruto',16,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec.','https://images-na.ssl-images-amazon.com/images/I/91761707AYL.jpg','2022-09-06 00:00:00'),('251146221',4.2,'Yoshihiro Togashi',46,22.00,'HxH',1,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec.','https://upload.wikimedia.org/wikipedia/it/7/77/Hunter_X_Hunter.jpg','2022-05-02 00:00:00'),('252145220',4.2,'Yoshihiro Togashi',20,22.00,'HxH',5,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec.','https://www.panini.it/media/catalog/product/cache/a5b5dd3adfe0d321084804c738f29601/m/h/mhuxh005r4_0_etdgvggmzsr5i896.jpg','1999-09-11 00:00:00'),('262145221',4.99,'Naoya Matsumoto',233,22.00,'Kaiju No.8',2,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec.','https://images-na.ssl-images-amazon.com/images/I/519AR9ifXRL._SX327_BO1,204,203,200_.jpg','2019-02-20 00:00:00'),('282145221',6.99,'Akira Toriyama',0,1.54,'Dragon Ball Z',20,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec.','https://images-eu.ssl-images-amazon.com/images/I/617m5jUXi-L._SX342_SY445_QL70_ML2_.jpg','2022-09-07 00:00:00'),('291145221',12.99,'Masashi Kishimoto',0,22.00,'Naruto',18,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec.','https://images-na.ssl-images-amazon.com/images/I/51pZJ371nIL._SX330_BO1,204,203,200_.jpg','2022-05-03 00:00:00'),('343341',14,'Togashi',0,3.08,'HxH',33,'descrizione','https://images-na.ssl-images-amazon.com/images/I/51VJB47FrpS._SX318_BO1,204,203,200_.jpg','2022-07-08 00:00:00');
/*!40000 ALTER TABLE `prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utente`
--

DROP TABLE IF EXISTS `utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utente` (
  `email` varchar(50) NOT NULL,
  `nome` varchar(15) NOT NULL,
  `cognome` varchar(20) NOT NULL,
  `paese` varchar(30) NOT NULL,
  `telefono` int DEFAULT NULL,
  `psw` varchar(16) NOT NULL,
  `Indirizzodispedizione` varchar(50) NOT NULL,
  `indirizzodifatturazione` varchar(50) DEFAULT NULL,
  `admin` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utente`
--

LOCK TABLES `utente` WRITE;
/*!40000 ALTER TABLE `utente` DISABLE KEYS */;
INSERT INTO `utente` VALUES ('aaaa@libe.it','a','a','Malta',123,'aa','aa 83122','',0),('c.pascale15@studenti.unisa.it','Carmine','Pascale','Lituania',1111111222,'45','Via corso vittorio emanuele	83100','Via corso vittorio emanuele 13	83100',1),('fmalanga@gmail.com','Francesco','Malanga','Italia',1,'1111','Via corso vittorio emanuele 13','Via corso vittorio emanuele 13	83100',0),('jilll@live.com','jill','jill','AT',123,'12','jill 83122','  AT',0),('m.giella@studenti.unisa.it','Mattia','Giella','AF',1111111222,'3','via Filippo Visconti 56  83100','Via Aurigemma 12 344 AF',0),('m.giella4@studenti.unisa.it','mattia Giuseppe','Giella','Lituania',1111111221,'12','Via corso vittorio emanuele 13	83100','Via corso vittorio emanuele 13 83100 Regno Unito',1),('malangaF@live.it','Francesco','Malanga','IT',1234,'no','Indirizzoo','Indirizzoo',0),('matti@live.it','Mattia','Giella','AM',123,'11','via Filippo Visconti 56  83100','via Filippo Visconti 56  83100 AM',0),('mattiagiella@live.com','Mattia','Giella','IT',12345678,'1234','via filippo visconti 56','via filippo visconti 56',0),('mbeee@gmail.com','Mattia','Giella','IT',123455667,'1234','via Filippo Visconti 56 ',NULL,0),('vincenzogiella@libero.it','vincenzo','giella','IT',1111111222,'1234','via Filippo Visconti 56  83100','via Filippo Visconti 56  83100',0);
/*!40000 ALTER TABLE `utente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-13 13:00:41

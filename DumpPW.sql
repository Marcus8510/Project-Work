-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: compagniaaerea
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `aereo`
--

DROP TABLE IF EXISTS `aereo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aereo` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `produttore` varchar(32) NOT NULL,
  `modello` varchar(32) NOT NULL,
  `capacitaPasseggeri` int NOT NULL,
  `capacitaValigieStiva` int NOT NULL,
  `rangeOperativo` int NOT NULL,
  `annoMessaServizio` year NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `CHK_Aereo` CHECK (((`capacitaPasseggeri` > 0) and (`capacitaValigieStiva` > 0) and (`rangeOperativo` > 0)))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aereo`
--

LOCK TABLES `aereo` WRITE;
/*!40000 ALTER TABLE `aereo` DISABLE KEYS */;
INSERT INTO `aereo` VALUES (1,'Airbus','A320',180,150,6200,2020),(2,'Airbus','A319',140,120,6950,2022);
/*!40000 ALTER TABLE `aereo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aeroporto`
--

DROP TABLE IF EXISTS `aeroporto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aeroporto` (
  `CodiceIATA` varchar(3) NOT NULL,
  `nome` varchar(64) NOT NULL,
  `codiceStato` varchar(4) NOT NULL,
  `città` varchar(32) NOT NULL,
  `indirizzo` varchar(64) NOT NULL,
  PRIMARY KEY (`CodiceIATA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aeroporto`
--

LOCK TABLES `aeroporto` WRITE;
/*!40000 ALTER TABLE `aeroporto` DISABLE KEYS */;
INSERT INTO `aeroporto` VALUES ('FCO','Aeroporto Internazionale di Roma-Fiumicino \"Leonardo da Vinci\"','IT','Roma','00054'),('LIS','Aeroporto Humberto Delgado','PT','Lisbona','Alameda das Comunidades Portuguesas'),('TRN','Aeroporto di Torino-Caselle \"Sandro Pertini\"','IT','Caselle Torinese','Strada Aeroporto 12');
/*!40000 ALTER TABLE `aeroporto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carta_imbarco`
--

DROP TABLE IF EXISTS `carta_imbarco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carta_imbarco` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `prezzoTotale` float NOT NULL,
  `dataAcquisto` datetime NOT NULL,
  `utilizzato` tinyint(1) NOT NULL DEFAULT '0',
  `QRCode` varchar(50) DEFAULT NULL,
  `numeroBagStiva` int NOT NULL,
  `numeroBagMano` int NOT NULL DEFAULT '1',
  `numeroBagManoGrande` int NOT NULL,
  `IdPasseggero` int NOT NULL,
  `IdPosto` int NOT NULL,
  `IdVolo` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IdPasseggero` (`IdPasseggero`),
  KEY `IdPosto` (`IdPosto`),
  KEY `IdVolo` (`IdVolo`),
  KEY `QRCode` (`QRCode`),
  CONSTRAINT `carta_imbarco_ibfk_1` FOREIGN KEY (`IdPasseggero`) REFERENCES `passeggero` (`CodiceCliente`),
  CONSTRAINT `carta_imbarco_ibfk_2` FOREIGN KEY (`IdPosto`) REFERENCES `posto` (`Id`),
  CONSTRAINT `carta_imbarco_ibfk_3` FOREIGN KEY (`IdVolo`) REFERENCES `volo` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carta_imbarco`
--

LOCK TABLES `carta_imbarco` WRITE;
/*!40000 ALTER TABLE `carta_imbarco` DISABLE KEYS */;
INSERT INTO `carta_imbarco` VALUES (5,150,'2025-04-15 00:00:00',1,'aaabbbccc',1,1,0,4,1,4),(6,100,'2025-04-15 00:00:00',0,'aaabbbddd',1,1,0,4,59,5);
/*!40000 ALTER TABLE `carta_imbarco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lounge`
--

DROP TABLE IF EXISTS `lounge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lounge` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `capacita` int NOT NULL,
  `IdAeroporto` varchar(3) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IdAeroporto` (`IdAeroporto`),
  CONSTRAINT `lounge_ibfk_1` FOREIGN KEY (`IdAeroporto`) REFERENCES `aeroporto` (`CodiceIATA`),
  CONSTRAINT `CHK_Lounge` CHECK ((`capacita` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lounge`
--

LOCK TABLES `lounge` WRITE;
/*!40000 ALTER TABLE `lounge` DISABLE KEYS */;
INSERT INTO `lounge` VALUES (1,100,'TRN'),(2,500,'FCO'),(3,200,'LIS');
/*!40000 ALTER TABLE `lounge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passeggero`
--

DROP TABLE IF EXISTS `passeggero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passeggero` (
  `CodiceCliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(32) NOT NULL,
  `cognome` varchar(32) NOT NULL,
  `IDNumber` varchar(16) NOT NULL,
  `passportID` varchar(64) DEFAULT NULL,
  `sesso` enum('M','F') DEFAULT NULL,
  `dataNascita` date NOT NULL,
  `statoNascita` varchar(4) NOT NULL,
  `luogoNascita` varchar(32) NOT NULL,
  `nazionalita` varchar(4) NOT NULL,
  `secondaNazionalita` varchar(4) DEFAULT NULL,
  `statoResidenza` varchar(4) DEFAULT NULL,
  `cittaResidenza` varchar(32) DEFAULT NULL,
  `indirizzoResidenza` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`CodiceCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passeggero`
--

LOCK TABLES `passeggero` WRITE;
/*!40000 ALTER TABLE `passeggero` DISABLE KEYS */;
INSERT INTO `passeggero` VALUES (1,'Alice','Zhang','CN25106AY','AB8940257','F','2003-10-01','CHN','Wenzhou','CHN','','IT','Rivarolo Canavese','Via Torino 15'),(2,'Marco','Rossi','AZ15695TQ','FF4582368','M','2000-12-15','IT','Ciriè','IT','','IT','Caselle Torinese','Strada Settimo 400'),(3,'Patricia','Ravensburger','DF15795ZD','GF2882793','F','1967-03-10','DE','Ravensburg','DE','IT','IT','Torino','Corso Lecce 15'),(4,'Dario','Lenghen','GR83195HG','AH8193254','M','1960-12-28','CH','Zurigo','IT','CH','IT','Ciriè','Corso Emanuele II 125');
/*!40000 ALTER TABLE `passeggero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posto`
--

DROP TABLE IF EXISTS `posto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posto` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `numeroPosto` varchar(6) NOT NULL,
  `classe` enum('Economy','Business','Prima') NOT NULL,
  `IdAereo` int NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IdAereo` (`IdAereo`),
  CONSTRAINT `posto_ibfk_1` FOREIGN KEY (`IdAereo`) REFERENCES `aereo` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=321 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posto`
--

LOCK TABLES `posto` WRITE;
/*!40000 ALTER TABLE `posto` DISABLE KEYS */;
INSERT INTO `posto` VALUES (1,'1A','Prima',1),(2,'1B','Prima',1),(3,'2A','Prima',1),(4,'2B','Prima',1),(5,'3A','Prima',1),(6,'3B','Prima',1),(7,'4A','Prima',1),(8,'4B','Prima',1),(9,'5A','Prima',1),(10,'5B','Prima',1),(11,'6A','Prima',1),(12,'6B','Prima',1),(13,'7A','Prima',1),(14,'7B','Prima',1),(15,'8A','Prima',1),(16,'8B','Prima',1),(17,'9A','Prima',1),(18,'9B','Prima',1),(19,'10A','Prima',1),(20,'10B','Prima',1),(21,'11A','Business',1),(22,'11B','Business',1),(23,'12A','Business',1),(24,'12B','Business',1),(25,'13A','Business',1),(26,'13B','Business',1),(27,'14A','Business',1),(28,'14B','Business',1),(29,'15A','Business',1),(30,'15B','Business',1),(31,'16A','Business',1),(32,'16B','Business',1),(33,'17A','Business',1),(34,'17B','Business',1),(35,'18A','Business',1),(36,'18B','Business',1),(37,'19A','Business',1),(38,'19B','Business',1),(39,'20A','Business',1),(40,'20B','Business',1),(41,'21A','Business',1),(42,'21B','Business',1),(43,'22A','Business',1),(44,'22B','Business',1),(45,'23A','Business',1),(46,'23B','Business',1),(47,'24A','Business',1),(48,'24B','Business',1),(49,'25A','Business',1),(50,'25B','Business',1),(51,'26A','Business',1),(52,'26B','Business',1),(53,'27A','Business',1),(54,'27B','Business',1),(55,'28A','Business',1),(56,'28B','Business',1),(57,'29A','Business',1),(58,'29B','Business',1),(59,'30A','Economy',1),(60,'30B','Economy',1),(61,'31A','Economy',1),(62,'31B','Economy',1),(63,'32A','Economy',1),(64,'32B','Economy',1),(65,'33A','Economy',1),(66,'33B','Economy',1),(67,'34A','Economy',1),(68,'34B','Economy',1),(69,'35A','Economy',1),(70,'35B','Economy',1),(71,'36A','Economy',1),(72,'36B','Economy',1),(73,'37A','Economy',1),(74,'37B','Economy',1),(75,'38A','Economy',1),(76,'38B','Economy',1),(77,'39A','Economy',1),(78,'39B','Economy',1),(79,'40A','Economy',1),(80,'40B','Economy',1),(81,'41A','Economy',1),(82,'41B','Economy',1),(83,'42A','Economy',1),(84,'42B','Economy',1),(85,'43A','Economy',1),(86,'43B','Economy',1),(87,'44A','Economy',1),(88,'44B','Economy',1),(89,'45A','Economy',1),(90,'45B','Economy',1),(91,'46A','Economy',1),(92,'46B','Economy',1),(93,'47A','Economy',1),(94,'47B','Economy',1),(95,'48A','Economy',1),(96,'48B','Economy',1),(97,'49A','Economy',1),(98,'49B','Economy',1),(99,'50A','Economy',1),(100,'50B','Economy',1),(101,'51A','Economy',1),(102,'51B','Economy',1),(103,'52A','Economy',1),(104,'52B','Economy',1),(105,'53A','Economy',1),(106,'53B','Economy',1),(107,'54A','Economy',1),(108,'54B','Economy',1),(109,'55A','Economy',1),(110,'55B','Economy',1),(111,'56A','Economy',1),(112,'56B','Economy',1),(113,'57A','Economy',1),(114,'57B','Economy',1),(115,'58A','Economy',1),(116,'58B','Economy',1),(117,'59A','Economy',1),(118,'59B','Economy',1),(119,'60A','Economy',1),(120,'60B','Economy',1),(121,'61A','Economy',1),(122,'61B','Economy',1),(123,'62A','Economy',1),(124,'62B','Economy',1),(125,'63A','Economy',1),(126,'63B','Economy',1),(127,'64A','Economy',1),(128,'64B','Economy',1),(129,'65A','Economy',1),(130,'65B','Economy',1),(131,'66A','Economy',1),(132,'66B','Economy',1),(133,'67A','Economy',1),(134,'67B','Economy',1),(135,'68A','Economy',1),(136,'68B','Economy',1),(137,'69A','Economy',1),(138,'69B','Economy',1),(139,'70A','Economy',1),(140,'70B','Economy',1),(141,'71A','Economy',1),(142,'71B','Economy',1),(143,'72A','Economy',1),(144,'72B','Economy',1),(145,'73A','Economy',1),(146,'73B','Economy',1),(147,'74A','Economy',1),(148,'74B','Economy',1),(149,'75A','Economy',1),(150,'75B','Economy',1),(151,'76A','Economy',1),(152,'76B','Economy',1),(153,'77A','Economy',1),(154,'77B','Economy',1),(155,'78A','Economy',1),(156,'78B','Economy',1),(157,'79A','Economy',1),(158,'79B','Economy',1),(159,'80A','Economy',1),(160,'80B','Economy',1),(161,'81A','Economy',1),(162,'81B','Economy',1),(163,'82A','Economy',1),(164,'82B','Economy',1),(165,'83A','Economy',1),(166,'83B','Economy',1),(167,'84A','Economy',1),(168,'84B','Economy',1),(169,'85A','Economy',1),(170,'85B','Economy',1),(171,'86A','Economy',1),(172,'86B','Economy',1),(173,'87A','Economy',1),(174,'87B','Economy',1),(175,'88A','Economy',1),(176,'88B','Economy',1),(177,'89A','Economy',1),(178,'89B','Economy',1),(179,'90A','Economy',1),(180,'90B','Economy',1),(181,'1A','Prima',2),(182,'1B','Prima',2),(183,'2A','Prima',2),(184,'2B','Prima',2),(185,'3A','Prima',2),(186,'3B','Prima',2),(187,'4A','Prima',2),(188,'4B','Prima',2),(189,'5A','Prima',2),(190,'5B','Prima',2),(191,'6A','Prima',2),(192,'6B','Prima',2),(193,'7A','Prima',2),(194,'7B','Prima',2),(195,'8A','Prima',2),(196,'8B','Prima',2),(197,'9A','Prima',2),(198,'9B','Prima',2),(199,'10A','Prima',2),(200,'10B','Prima',2),(201,'11A','Business',2),(202,'11B','Business',2),(203,'12A','Business',2),(204,'12B','Business',2),(205,'13A','Business',2),(206,'13B','Business',2),(207,'14A','Business',2),(208,'14B','Business',2),(209,'15A','Business',2),(210,'15B','Business',2),(211,'16A','Business',2),(212,'16B','Business',2),(213,'17A','Business',2),(214,'17B','Business',2),(215,'18A','Business',2),(216,'18B','Business',2),(217,'19A','Business',2),(218,'19B','Business',2),(219,'20A','Business',2),(220,'20B','Business',2),(221,'21A','Business',2),(222,'21B','Business',2),(223,'22A','Business',2),(224,'22B','Business',2),(225,'23A','Business',2),(226,'23B','Business',2),(227,'24A','Business',2),(228,'24B','Business',2),(229,'25A','Business',2),(230,'25B','Business',2),(231,'26A','Business',2),(232,'26B','Business',2),(233,'27A','Business',2),(234,'27B','Business',2),(235,'28A','Business',2),(236,'28B','Business',2),(237,'29A','Business',2),(238,'29B','Business',2),(239,'30A','Economy',2),(240,'30B','Economy',2),(241,'31A','Economy',2),(242,'31B','Economy',2),(243,'32A','Economy',2),(244,'32B','Economy',2),(245,'33A','Economy',2),(246,'33B','Economy',2),(247,'34A','Economy',2),(248,'34B','Economy',2),(249,'35A','Economy',2),(250,'35B','Economy',2),(251,'36A','Economy',2),(252,'36B','Economy',2),(253,'37A','Economy',2),(254,'37B','Economy',2),(255,'38A','Economy',2),(256,'38B','Economy',2),(257,'39A','Economy',2),(258,'39B','Economy',2),(259,'40A','Economy',2),(260,'40B','Economy',2),(261,'41A','Economy',2),(262,'41B','Economy',2),(263,'42A','Economy',2),(264,'42B','Economy',2),(265,'43A','Economy',2),(266,'43B','Economy',2),(267,'44A','Economy',2),(268,'44B','Economy',2),(269,'45A','Economy',2),(270,'45B','Economy',2),(271,'46A','Economy',2),(272,'46B','Economy',2),(273,'47A','Economy',2),(274,'47B','Economy',2),(275,'48A','Economy',2),(276,'48B','Economy',2),(277,'49A','Economy',2),(278,'49B','Economy',2),(279,'50A','Economy',2),(280,'50B','Economy',2),(281,'51A','Economy',2),(282,'51B','Economy',2),(283,'52A','Economy',2),(284,'52B','Economy',2),(285,'53A','Economy',2),(286,'53B','Economy',2),(287,'54A','Economy',2),(288,'54B','Economy',2),(289,'55A','Economy',2),(290,'55B','Economy',2),(291,'56A','Economy',2),(292,'56B','Economy',2),(293,'57A','Economy',2),(294,'57B','Economy',2),(295,'58A','Economy',2),(296,'58B','Economy',2),(297,'59A','Economy',2),(298,'59B','Economy',2),(299,'60A','Economy',2),(300,'60B','Economy',2),(301,'61A','Economy',2),(302,'61B','Economy',2),(303,'62A','Economy',2),(304,'62B','Economy',2),(305,'63A','Economy',2),(306,'63B','Economy',2),(307,'64A','Economy',2),(308,'64B','Economy',2),(309,'65A','Economy',2),(310,'65B','Economy',2),(311,'66A','Economy',2),(312,'66B','Economy',2),(313,'67A','Economy',2),(314,'67B','Economy',2),(315,'68A','Economy',2),(316,'68B','Economy',2),(317,'69A','Economy',2),(318,'69B','Economy',2),(319,'70A','Economy',2),(320,'70B','Economy',2);
/*!40000 ALTER TABLE `posto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posto_volo`
--

DROP TABLE IF EXISTS `posto_volo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posto_volo` (
  `IdPosto` int NOT NULL,
  `IdVolo` int NOT NULL,
  `disponibile` tinyint(1) NOT NULL DEFAULT '1',
  `prezzo` float NOT NULL,
  PRIMARY KEY (`IdPosto`,`IdVolo`),
  KEY `IdVolo` (`IdVolo`),
  CONSTRAINT `posto_volo_ibfk_1` FOREIGN KEY (`IdPosto`) REFERENCES `posto` (`Id`),
  CONSTRAINT `posto_volo_ibfk_2` FOREIGN KEY (`IdVolo`) REFERENCES `volo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posto_volo`
--

LOCK TABLES `posto_volo` WRITE;
/*!40000 ALTER TABLE `posto_volo` DISABLE KEYS */;
INSERT INTO `posto_volo` VALUES (1,4,0,100),(1,5,1,100),(2,4,1,100),(2,5,1,100),(3,4,1,100),(3,5,1,100),(4,4,1,100),(4,5,1,100),(5,4,1,100),(5,5,1,100),(6,4,1,100),(6,5,1,100),(7,4,1,100),(7,5,1,100),(8,4,1,100),(8,5,1,100),(9,4,1,100),(9,5,1,100),(10,4,1,100),(10,5,1,100),(11,4,1,100),(11,5,1,100),(12,4,1,100),(12,5,1,100),(13,4,1,100),(13,5,1,100),(14,4,1,100),(14,5,1,100),(15,4,1,100),(15,5,1,100),(16,4,1,100),(16,5,1,100),(17,4,1,100),(17,5,1,100),(18,4,1,100),(18,5,1,100),(19,4,1,100),(19,5,1,100),(20,4,1,100),(20,5,1,100),(21,4,1,80),(21,5,1,80),(22,4,1,80),(22,5,1,80),(23,4,1,80),(23,5,1,80),(24,4,1,80),(24,5,1,80),(25,4,1,80),(25,5,1,80),(26,4,1,80),(26,5,1,80),(27,4,1,80),(27,5,1,80),(28,4,1,80),(28,5,1,80),(29,4,1,80),(29,5,1,80),(30,4,1,80),(30,5,1,80),(31,4,1,80),(31,5,1,80),(32,4,1,80),(32,5,1,80),(33,4,1,80),(33,5,1,80),(34,4,1,80),(34,5,1,80),(35,4,1,80),(35,5,1,80),(36,4,1,80),(36,5,1,80),(37,4,1,80),(37,5,1,80),(38,4,1,80),(38,5,1,80),(39,4,1,80),(39,5,1,80),(40,4,1,80),(40,5,1,80),(41,4,1,80),(41,5,1,80),(42,4,1,80),(42,5,1,80),(43,4,1,80),(43,5,1,80),(44,4,1,80),(44,5,1,80),(45,4,1,80),(45,5,1,80),(46,4,1,80),(46,5,1,80),(47,4,1,80),(47,5,1,80),(48,4,1,80),(48,5,1,80),(49,4,1,80),(49,5,1,80),(50,4,1,80),(50,5,1,80),(51,4,1,80),(51,5,1,80),(52,4,1,80),(52,5,1,80),(53,4,1,80),(53,5,1,80),(54,4,1,80),(54,5,1,80),(55,4,1,80),(55,5,1,80),(56,4,1,80),(56,5,1,80),(57,4,1,80),(57,5,1,80),(58,4,1,80),(58,5,1,80),(59,4,1,50),(59,5,0,50),(60,4,1,50),(60,5,1,50),(61,4,1,50),(61,5,1,50),(62,4,1,50),(62,5,1,50),(63,4,1,50),(63,5,1,50),(64,4,1,50),(64,5,1,50),(65,4,1,50),(65,5,1,50),(66,4,1,50),(66,5,1,50),(67,4,1,50),(67,5,1,50),(68,4,1,50),(68,5,1,50),(69,4,1,50),(69,5,1,50),(70,4,1,50),(70,5,1,50),(71,4,1,50),(71,5,1,50),(72,4,1,50),(72,5,1,50),(73,4,1,50),(73,5,1,50),(74,4,1,50),(74,5,1,50),(75,4,1,50),(75,5,1,50),(76,4,1,50),(76,5,1,50),(77,4,1,50),(77,5,1,50),(78,4,1,50),(78,5,1,50),(79,4,1,50),(79,5,1,50),(80,4,1,50),(80,5,1,50),(81,4,1,50),(81,5,1,50),(82,4,1,50),(82,5,1,50),(83,4,1,50),(83,5,1,50),(84,4,1,50),(84,5,1,50),(85,4,1,50),(85,5,1,50),(86,4,1,50),(86,5,1,50),(87,4,1,50),(87,5,1,50),(88,4,1,50),(88,5,1,50),(89,4,1,50),(89,5,1,50),(90,4,1,50),(90,5,1,50),(91,4,1,50),(91,5,1,50),(92,4,1,50),(92,5,1,50),(93,4,1,50),(93,5,1,50),(94,4,1,50),(94,5,1,50),(95,4,1,50),(95,5,1,50),(96,4,1,50),(96,5,1,50),(97,4,1,50),(97,5,1,50),(98,4,1,50),(98,5,1,50),(99,4,1,50),(99,5,1,50),(100,4,1,50),(100,5,1,50),(101,4,1,50),(101,5,1,50),(102,4,1,50),(102,5,1,50),(103,4,1,50),(103,5,1,50),(104,4,1,50),(104,5,1,50),(105,4,1,50),(105,5,1,50),(106,4,1,50),(106,5,1,50),(107,4,1,50),(107,5,1,50),(108,4,1,50),(108,5,1,50),(109,4,1,50),(109,5,1,50),(110,4,1,50),(110,5,1,50),(111,4,1,50),(111,5,1,50),(112,4,1,50),(112,5,1,50),(113,4,1,50),(113,5,1,50),(114,4,1,50),(114,5,1,50),(115,4,1,50),(115,5,1,50),(116,4,1,50),(116,5,1,50),(117,4,1,50),(117,5,1,50),(118,4,1,50),(118,5,1,50),(119,4,1,50),(119,5,1,50),(120,4,1,50),(120,5,1,50),(121,4,1,50),(121,5,1,50),(122,4,1,50),(122,5,1,50),(123,4,1,50),(123,5,1,50),(124,4,1,50),(124,5,1,50),(125,4,1,50),(125,5,1,50),(126,4,1,50),(126,5,1,50),(127,4,1,50),(127,5,1,50),(128,4,1,50),(128,5,1,50),(129,4,1,50),(129,5,1,50),(130,4,1,50),(130,5,1,50),(131,4,1,50),(131,5,1,50),(132,4,1,50),(132,5,1,50),(133,4,1,50),(133,5,1,50),(134,4,1,50),(134,5,1,50),(135,4,1,50),(135,5,1,50),(136,4,1,50),(136,5,1,50),(137,4,1,50),(137,5,1,50),(138,4,1,50),(138,5,1,50),(139,4,1,50),(139,5,1,50),(140,4,1,50),(140,5,1,50),(141,4,1,50),(141,5,1,50),(142,4,1,50),(142,5,1,50),(143,4,1,50),(143,5,1,50),(144,4,1,50),(144,5,1,50),(145,4,1,50),(145,5,1,50),(146,4,1,50),(146,5,1,50),(147,4,1,50),(147,5,1,50),(148,4,1,50),(148,5,1,50),(149,4,1,50),(149,5,1,50),(150,4,1,50),(150,5,1,50),(151,4,1,50),(151,5,1,50),(152,4,1,50),(152,5,1,50),(153,4,1,50),(153,5,1,50),(154,4,1,50),(154,5,1,50),(155,4,1,50),(155,5,1,50),(156,4,1,50),(156,5,1,50),(157,4,1,50),(157,5,1,50),(158,4,1,50),(158,5,1,50),(159,4,1,50),(159,5,1,50),(160,4,1,50),(160,5,1,50),(161,4,1,50),(161,5,1,50),(162,4,1,50),(162,5,1,50),(163,4,1,50),(163,5,1,50),(164,4,1,50),(164,5,1,50),(165,4,1,50),(165,5,1,50),(166,4,1,50),(166,5,1,50),(167,4,1,50),(167,5,1,50),(168,4,1,50),(168,5,1,50),(169,4,1,50),(169,5,1,50),(170,4,1,50),(170,5,1,50),(171,4,1,50),(171,5,1,50),(172,4,1,50),(172,5,1,50),(173,4,1,50),(173,5,1,50),(174,4,1,50),(174,5,1,50),(175,4,1,50),(175,5,1,50),(176,4,1,50),(176,5,1,50),(177,4,1,50),(177,5,1,50),(178,4,1,50),(178,5,1,50),(179,4,1,50),(179,5,1,50),(180,4,1,50),(180,5,1,50),(181,3,1,100),(182,3,1,100),(183,3,1,100),(184,3,1,100),(185,3,1,100),(186,3,1,100),(187,3,1,100),(188,3,1,100),(189,3,1,100),(190,3,1,100),(191,3,1,100),(192,3,1,100),(193,3,1,100),(194,3,1,100),(195,3,1,100),(196,3,1,100),(197,3,1,100),(198,3,1,100),(199,3,1,100),(200,3,1,100),(201,3,1,80),(202,3,1,80),(203,3,1,80),(204,3,1,80),(205,3,1,80),(206,3,1,80),(207,3,1,80),(208,3,1,80),(209,3,1,80),(210,3,1,80),(211,3,1,80),(212,3,1,80),(213,3,1,80),(214,3,1,80),(215,3,1,80),(216,3,1,80),(217,3,1,80),(218,3,1,80),(219,3,1,80),(220,3,1,80),(221,3,1,80),(222,3,1,80),(223,3,1,80),(224,3,1,80),(225,3,1,80),(226,3,1,80),(227,3,1,80),(228,3,1,80),(229,3,1,80),(230,3,1,80),(231,3,1,80),(232,3,1,80),(233,3,1,80),(234,3,1,80),(235,3,1,80),(236,3,1,80),(237,3,1,80),(238,3,1,80),(239,3,1,50),(240,3,1,50),(241,3,1,50),(242,3,1,50),(243,3,1,50),(244,3,1,50),(245,3,1,50),(246,3,1,50),(247,3,1,50),(248,3,1,50),(249,3,1,50),(250,3,1,50),(251,3,1,50),(252,3,1,50),(253,3,1,50),(254,3,1,50),(255,3,1,50),(256,3,1,50),(257,3,1,50),(258,3,1,50),(259,3,1,50),(260,3,1,50),(261,3,1,50),(262,3,1,50),(263,3,1,50),(264,3,1,50),(265,3,1,50),(266,3,1,50),(267,3,1,50),(268,3,1,50),(269,3,1,50),(270,3,1,50),(271,3,1,50),(272,3,1,50),(273,3,1,50),(274,3,1,50),(275,3,1,50),(276,3,1,50),(277,3,1,50),(278,3,1,50),(279,3,1,50),(280,3,1,50),(281,3,1,50),(282,3,1,50),(283,3,1,50),(284,3,1,50),(285,3,1,50),(286,3,1,50),(287,3,1,50),(288,3,1,50),(289,3,1,50),(290,3,1,50),(291,3,1,50),(292,3,1,50),(293,3,1,50),(294,3,1,50),(295,3,1,50),(296,3,1,50),(297,3,1,50),(298,3,1,50),(299,3,1,50),(300,3,1,50),(301,3,1,50),(302,3,1,50),(303,3,1,50),(304,3,1,50),(305,3,1,50),(306,3,1,50),(307,3,1,50),(308,3,1,50),(309,3,1,50),(310,3,1,50),(311,3,1,50),(312,3,1,50),(313,3,1,50),(314,3,1,50),(315,3,1,50),(316,3,1,50),(317,3,1,50),(318,3,1,50),(319,3,1,50),(320,3,1,50);
/*!40000 ALTER TABLE `posto_volo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volo`
--

DROP TABLE IF EXISTS `volo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `volo` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `numeroVolo` varchar(8) NOT NULL,
  `dataOraPartenza` datetime NOT NULL,
  `dataOraArrivo` datetime NOT NULL,
  `prezzoBagaglioManoGrande` float NOT NULL,
  `prezzoBagaglioStiva` float NOT NULL,
  `postiDisponibili` int NOT NULL,
  `statoVolo` enum('Programmato','Imbarco in corso','Imbarcato','Decollato','In ritardo','Cancellato') NOT NULL,
  `gateImbarco` varchar(8) DEFAULT NULL,
  `IdAereo` int NOT NULL,
  `IdAeroportoPartenza` varchar(3) NOT NULL,
  `IdAeroportoArrivo` varchar(3) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IdAereo` (`IdAereo`),
  KEY `IdAeroportoPartenza` (`IdAeroportoPartenza`),
  KEY `IdAeroportoArrivo` (`IdAeroportoArrivo`),
  KEY `numeroVolo` (`numeroVolo`),
  CONSTRAINT `volo_ibfk_1` FOREIGN KEY (`IdAereo`) REFERENCES `aereo` (`Id`),
  CONSTRAINT `volo_ibfk_2` FOREIGN KEY (`IdAeroportoPartenza`) REFERENCES `aeroporto` (`CodiceIATA`),
  CONSTRAINT `volo_ibfk_3` FOREIGN KEY (`IdAeroportoArrivo`) REFERENCES `aeroporto` (`CodiceIATA`),
  CONSTRAINT `CHK_Volo` CHECK (((`dataOraPartenza` < `dataOraArrivo`) and (`prezzoBagaglioManoGrande` > 0) and (`prezzoBagaglioStiva` > 0)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volo`
--

LOCK TABLES `volo` WRITE;
/*!40000 ALTER TABLE `volo` DISABLE KEYS */;
INSERT INTO `volo` VALUES (3,'AZ1450','2025-06-28 21:20:00','2025-06-28 23:15:00',25,50,140,'Programmato','1',2,'TRN','FCO'),(4,'AZ1850','2025-06-29 08:00:00','2025-06-29 11:42:00',25,50,180,'Programmato','5',1,'FCO','LIS'),(5,'AZ1550','2025-06-30 11:25:00','2025-06-30 15:50:00',25,50,180,'Programmato','5',1,'LIS','TRN');
/*!40000 ALTER TABLE `volo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'compagniaaerea'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-01 19:15:02

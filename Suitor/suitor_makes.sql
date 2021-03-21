-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: suitor
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `makes`
--

DROP TABLE IF EXISTS `makes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `makes` (
  `userID` char(10) NOT NULL,
  `transactionID` char(10) NOT NULL,
  PRIMARY KEY (`userID`,`transactionID`),
  KEY `transactionID` (`transactionID`),
  CONSTRAINT `makes_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  CONSTRAINT `makes_ibfk_2` FOREIGN KEY (`transactionID`) REFERENCES `financialtransactions` (`transactionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `makes`
--

LOCK TABLES `makes` WRITE;
/*!40000 ALTER TABLE `makes` DISABLE KEYS */;
INSERT INTO `makes` VALUES ('I21l6n1r5O','Mb0h2L374n'),('I21j8o1a3G','Mb1w9M013e'),('I21x9j6r5J','Mb5h5I260e'),('I21g6a1t9M','Mb6o6T540n'),('I21j0t6i5Q','Mc0p4E524h'),('I21h9a5z8Y','Md2h6T495t'),('I21h2u9c3D','Md4x8O425o'),('I21i1b1u3K','Md5b9M452t'),('I21g4q3a0C','Me0d8W423d'),('I21q1o1x3V','Me1k4K887a'),('I21d1n4r9Z','Me3g9B611s'),('I21b8x7f7C','Me6a9U102c'),('I21p6r5h3T','Me8k6H847p'),('I21d8u1g3F','Mf0v2Z877i'),('I21m2s2j0X','Mf5j1T825r'),('I21g3m9s7I','Mf8f7M636u'),('I21j4c1z0G','Mf8u9L320d'),('I21l5k8x1E','Mg1z5F259b'),('I21e8r0w4U','Mg2e4N676q'),('I21s2t1t0M','Mg4q3H676u'),('I21z8z0v1D','Mg7g3Y983x'),('I21d1s2k3T','Mg7q6O707o'),('I21n5q6a4D','Mg8a7I634u'),('I21n3q8z0T','Mh6n1S125l'),('I21i8g8k3M','Mi0l0E160a'),('I21b0f1b7U','Mi6k6S050w'),('I21n8n8x4L','Mi7m9R742w'),('I21s9w5f1N','Mj0a1U705x'),('I21l0r9l3V','Mj8h0U256y'),('I21x3a1i3J','Mk2r5G724d'),('I21u0o9p4S','Mk9y9D468e'),('I21l4l2z2V','Ml0h3P711u'),('I21l8k8k9L','Ml1h4P981r'),('I21o0f4s7Z','Ml1s3W395g'),('I21a5f4z0X','Mm6c4D957b'),('I21a0l0g1L','Mn2v4D211i'),('I21a3c7b9V','Mn6x5L289h'),('I21o0p9v2G','Mn7s2O909a'),('I21t2r5i9L','Mn9x7I604f'),('I21y1u2m4V','Mo5m8L610u'),('I21c1i0m8G','Mo8n6A500x'),('I21p9e2x7Z','Mo9r7M547r'),('I21q7x2g1S','Mp0n4S652x'),('I21e0m3b2H','Mp4a2O616q'),('I21z2d7c5Q','Mp4z5I962d'),('I21q1y3p1B','Mp6w6I243q'),('I21m0m8e1V','Mp7f8S699g'),('I21i8x8f6M','Mq1a4J648s'),('I21f2w0f2G','Mq2x6A548m'),('I21q0l7k2S','Mq3p8P009v'),('I21j0i9h1D','Mq4t6O102o'),('I21o5t8k4S','Mq6g7Z769l'),('I21r6i4t5D','Mr4x2K333u'),('I21h2l3h4T','Mr5l5A162a'),('I21y2q1v1W','Mr8f6E574i'),('I21w7w4s5D','Mr8k7I508h'),('I21z1v3d9J','Mr9v7T981t'),('I21q9k1o6D','Ms0a0G198n'),('I21b7l9f4G','Ms1q7I681f'),('I21g2z8f6O','Ms2h7U218r'),('I21p6v9u4N','Ms4s6M387h'),('I21a8r5z0R','Ms8d3Z570z'),('I21a6v1n3Y','Mt3z5D549v'),('I21k2i4s0M','Mt7v7Y217a'),('I21b5c7q0B','Mt8x3H190l'),('I21l7l3r4Q','Mu0c8V469p'),('I21o4j8t5J','Mu0i7K329x'),('I21r1z4k2D','Mu0z0Q217g'),('I21s7j5a6V','Mu2v0K283k'),('I21o2l9d5N','Mu2y1X981j'),('I21z2k0g2Z','Mu5q0X096d'),('I21r0k0b4G','Mu7q3B911o'),('I21n7x7k6Q','Mu7u5I303k'),('I21p5a6t2C','Mv1l5Q210j'),('I21t0z0b6C','Mv5z3Z965n'),('I21i1d0e4O','Mv7y0F199p'),('I21e5c5u5T','Mv8l1N656i'),('I21d3y2f0U','Mv8x9K926h'),('I21l8p2s9M','Mw0l3R867t'),('I21n7y2f4X','Mw6m8O560f'),('I21p1o3m0I','Mx0f5X901e'),('I21b1t4v6Y','Mx0v4E664u'),('I21f9d1v3S','Mx2r0Y217e'),('I21h9y4d8L','Mx6h8R926p'),('I21i3i4o2O','Mx7y6X802o'),('I21f7c9s5M','Mx8k5K647b'),('I21s9s9l4W','Mx8l1S902r'),('I21j2n0e0U','My0f5H763w'),('I21r0h1t2L','My2p6M506o'),('I21o1f7t9Z','My4v9S021v'),('I21c5y3b3D','My7k8N041k'),('I21z3e6c2F','My8q7F235n'),('I21x8u8t1N','My9c2W930j'),('I21d6h1k4S','My9f2G226i'),('I21j1a5t0U','Mz1i1O438m'),('I21c9w4e5V','Mz1x5P943g'),('I21h2g2o2Z','Mz3f2N363a'),('I21e6i6i6N','Mz4l5X072q'),('I21i2l7f5H','Mz5r9L827g'),('I21p9t3c7R','Mz6o7G601t');
/*!40000 ALTER TABLE `makes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-21 22:23:50

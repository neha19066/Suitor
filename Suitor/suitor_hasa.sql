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
-- Table structure for table `hasa`
--

DROP TABLE IF EXISTS `hasa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hasa` (
  `userID` char(10) NOT NULL,
  `caseID` char(15) NOT NULL,
  PRIMARY KEY (`userID`,`caseID`),
  KEY `caseID` (`caseID`),
  CONSTRAINT `hasa_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `clients` (`userID`),
  CONSTRAINT `hasa_ibfk_2` FOREIGN KEY (`caseID`) REFERENCES `legalcases` (`caseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hasa`
--

LOCK TABLES `hasa` WRITE;
/*!40000 ALTER TABLE `hasa` DISABLE KEYS */;
INSERT INTO `hasa` VALUES ('I21a0l0g1L','SSS21a0a6p9S000'),('I21z3e6c2F','SSS21a2d9l7A000'),('I21d8u1g3F','SSS21a3i7z1O000'),('I21i3i4o2O','SSS21a5l8y4Q000'),('I21i1b1u3K','SSS21a6j4s8S000'),('I21q0l7k2S','SSS21b9l8r3P000'),('I21j2n0e0U','SSS21c0v3j7H000'),('I21n7x7k6Q','SSS21c2h1l0H000'),('I21l0r9l3V','SSS21c4j2s1X000'),('I21x8u8t1N','SSS21c5g2t6S000'),('I21c5y3b3D','SSS21d4j9h5F000'),('I21z1v3d9J','SSS21d8m8u7S000'),('I21a8r5z0R','SSS21d9j4s9V000'),('I21u0o9p4S','SSS21e3w2w2Q000'),('I21n8n8x4L','SSS21e7a2y8X000'),('I21l8k8k9L','SSS21e8i7o9T000'),('I21k2i4s0M','SSS21f0o8f3M000'),('I21g3m9s7I','SSS21f2i1y4G000'),('I21d1n4r9Z','SSS21f2o7c6M000'),('I21a6v1n3Y','SSS21f4f1m7D000'),('I21g2z8f6O','SSS21f7g1m0X000'),('I21h9y4d8L','SSS21f8c9f6M000'),('I21h2u9c3D','SSS21g1h3u4I000'),('I21e5c5u5T','SSS21g1s2c8O000'),('I21o0p9v2G','SSS21g3n2c8L000'),('I21a5f4z0X','SSS21g4w5c6D000'),('I21d6h1k4S','SSS21g5u1k6F000'),('I21b7l9f4G','SSS21h1q4a0S000'),('I21o0f4s7Z','SSS21h2t7e7N000'),('I21n5q6a4D','SSS21h4d5s5N000'),('I21a3c7b9V','SSS21h4r3w5L000'),('I21s9s9l4W','SSS21h7e3k5M000'),('I21r0k0b4G','SSS21i1q4e2C000'),('I21i8x8f6M','SSS21i2g3x4N000'),('I21s9w5f1N','SSS21i3c0v7K000'),('I21l8p2s9M','SSS21i3k0z7H000'),('I21t2r5i9L','SSS21i4h3i7G000'),('I21e0m3b2H','SSS21i6v6f7T000'),('I21b8x7f7C','SSS21j1j4d2X000'),('I21p9t3c7R','SSS21j2b1k9V000'),('I21b5c7q0B','SSS21l9i0c0G000'),('I21o5t8k4S','SSS21m1x7b8D000'),('I21d1s2k3T','SSS21m2s8l8V000'),('I21g4q3a0C','SSS21m4j8t5Y000'),('I21i1d0e4O','SSS21m6a0d2A000'),('I21l7l3r4Q','SSS21m9w8z8C000'),('I21i8g8k3M','SSS21n2b5k6O000'),('I21q7x2g1S','SSS21n4w8u7G000'),('I21h9a5z8Y','SSS21o2d2m1T000'),('I21o2l9d5N','SSS21o2v8p8Q000'),('I21j0t6i5Q','SSS21o5q4n4D000'),('I21l6n1r5O','SSS21p2y3h0J000'),('I21h2g2o2Z','SSS21p3d1e3Z000'),('I21i2l7f5H','SSS21p4d1l5D000'),('I21x9j6r5J','SSS21p4y9k3K000'),('I21j8o1a3G','SSS21p6f6g2Y000'),('I21c1i0m8G','SSS21q0w9e4F000'),('I21r6i4t5D','SSS21q6h2r5T000'),('I21j1a5t0U','SSS21q6l8d6I000'),('I21g6a1t9M','SSS21q6m3x3T000'),('I21w7w4s5D','SSS21q9n4e2T000'),('I21b1t4v6Y','SSS21r0x1d7Q000'),('I21e6i6i6N','SSS21r0z8x1B000'),('I21h2l3h4T','SSS21r2i9s2I000'),('I21m0m8e1V','SSS21r2s0x1N000'),('I21b0f1b7U','SSS21r4j6o9L000'),('I21e8r0w4U','SSS21t0l8f1K000'),('I21y1u2m4V','SSS21t1y8p4S000'),('I21m2s2j0X','SSS21t5j9w8Q000'),('I21s7j5a6V','SSS21t5q9r6X000'),('I21p1o3m0I','SSS21t7z7y4I000'),('I21j0i9h1D','SSS21u2b9j9T000'),('I21q1o1x3V','SSS21u3f3x1U000'),('I21r1z4k2D','SSS21u5y4c9M000'),('I21s2t1t0M','SSS21u6y2o0G000'),('I21p6v9u4N','SSS21u8m5q6V000'),('I21l5k8x1E','SSS21u9p6o8P000'),('I21p6r5h3T','SSS21v2a2i2Q000'),('I21r0h1t2L','SSS21v4h8r3P000'),('I21j4c1z0G','SSS21v4i3j3Q000'),('I21y2q1v1W','SSS21v4l5t6B000'),('I21q9k1o6D','SSS21v8k1h4G000'),('I21p5a6t2C','SSS21w2k1h1K000'),('I21f7c9s5M','SSS21w4v3a8C000'),('I21n7y2f4X','SSS21w5z3w3P000'),('I21l4l2z2V','SSS21w9v7d1S000'),('I21x3a1i3J','SSS21w9x5e8R000'),('I21n3q8z0T','SSS21x3c0k9T000'),('I21o4j8t5J','SSS21x3v1i1X000'),('I21c9w4e5V','SSS21x4j4e8B000'),('I21q1y3p1B','SSS21x4s1a3V000'),('I21f2w0f2G','SSS21x6m5b8C000'),('I21z2k0g2Z','SSS21x7d9c7B000'),('I21z8z0v1D','SSS21x7t4k3L000'),('I21f9d1v3S','SSS21x9u8f6Z000'),('I21p9e2x7Z','SSS21y5z3j2Y000'),('I21d3y2f0U','SSS21y7r8q2W000'),('I21o1f7t9Z','SSS21z3g2q9E000'),('I21z2d7c5Q','SSS21z6c7c1T000'),('I21t0z0b6C','SSS21z9r7y5C000');
/*!40000 ALTER TABLE `hasa` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-21 22:23:47

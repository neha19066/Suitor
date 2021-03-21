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
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `userID` char(10) NOT NULL,
  PRIMARY KEY (`userID`),
  CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES ('I21a0l0g1L'),('I21a3c7b9V'),('I21a5f4z0X'),('I21a6v1n3Y'),('I21a8r5z0R'),('I21b0f1b7U'),('I21b1t4v6Y'),('I21b5c7q0B'),('I21b7l9f4G'),('I21b8x7f7C'),('I21c1i0m8G'),('I21c5y3b3D'),('I21c9w4e5V'),('I21d1n4r9Z'),('I21d1s2k3T'),('I21d3y2f0U'),('I21d6h1k4S'),('I21d8u1g3F'),('I21e0m3b2H'),('I21e5c5u5T'),('I21e6i6i6N'),('I21e8r0w4U'),('I21f2w0f2G'),('I21f7c9s5M'),('I21f9d1v3S'),('I21g2z8f6O'),('I21g3m9s7I'),('I21g4q3a0C'),('I21g6a1t9M'),('I21h2g2o2Z'),('I21h2l3h4T'),('I21h2u9c3D'),('I21h9a5z8Y'),('I21h9y4d8L'),('I21i1b1u3K'),('I21i1d0e4O'),('I21i2l7f5H'),('I21i3i4o2O'),('I21i8g8k3M'),('I21i8x8f6M'),('I21j0i9h1D'),('I21j0t6i5Q'),('I21j1a5t0U'),('I21j2n0e0U'),('I21j4c1z0G'),('I21j8o1a3G'),('I21k2i4s0M'),('I21l0r9l3V'),('I21l4l2z2V'),('I21l5k8x1E'),('I21l6n1r5O'),('I21l7l3r4Q'),('I21l8k8k9L'),('I21l8p2s9M'),('I21m0m8e1V'),('I21m2s2j0X'),('I21n3q8z0T'),('I21n5q6a4D'),('I21n7x7k6Q'),('I21n7y2f4X'),('I21n8n8x4L'),('I21o0f4s7Z'),('I21o0p9v2G'),('I21o1f7t9Z'),('I21o2l9d5N'),('I21o4j8t5J'),('I21o5t8k4S'),('I21p1o3m0I'),('I21p5a6t2C'),('I21p6r5h3T'),('I21p6v9u4N'),('I21p9e2x7Z'),('I21p9t3c7R'),('I21q0l7k2S'),('I21q1o1x3V'),('I21q1y3p1B'),('I21q7x2g1S'),('I21q9k1o6D'),('I21r0h1t2L'),('I21r0k0b4G'),('I21r1z4k2D'),('I21r6i4t5D'),('I21s2t1t0M'),('I21s7j5a6V'),('I21s9s9l4W'),('I21s9w5f1N'),('I21t0z0b6C'),('I21t2r5i9L'),('I21u0o9p4S'),('I21w7w4s5D'),('I21x3a1i3J'),('I21x8u8t1N'),('I21x9j6r5J'),('I21y1u2m4V'),('I21y2q1v1W'),('I21z1v3d9J'),('I21z2d7c5Q'),('I21z2k0g2Z'),('I21z3e6c2F'),('I21z8z0v1D'),('Y21a2h5f8J'),('Y21a4p1j5G'),('Y21a9z0f5X'),('Y21a9z7t6R'),('Y21b0a2b3T'),('Y21b0m9k9L'),('Y21b2c5s5X'),('Y21b3t3d4I'),('Y21b4v1r9B'),('Y21b5j1d7H'),('Y21b5m3m0U'),('Y21b7o0o9M'),('Y21b8b3x3G'),('Y21c0c7t0F'),('Y21c6m6e7X'),('Y21d5s7g0D'),('Y21d7k9b9B'),('Y21d8k6f2D'),('Y21e8x0n9D'),('Y21f0b1b9W'),('Y21f0u7q2E'),('Y21f2g0i1C'),('Y21f3d4t5C'),('Y21f4u5j8O'),('Y21f7a6o4B'),('Y21f9g6q6I'),('Y21f9q5j0G'),('Y21g1p3c3G'),('Y21g1s2d4W'),('Y21g2n6i0Z'),('Y21g2u0t9Q'),('Y21g2y7g1G'),('Y21g5x5u9X'),('Y21g8j8y7M'),('Y21h1p8s3U'),('Y21h5m5s3X'),('Y21i0f8z5U'),('Y21i4m5b5E'),('Y21i6v7v5D'),('Y21i8q5y1K'),('Y21j1t2r0Y'),('Y21k1f0p1V'),('Y21k3r5r6E'),('Y21k4o5w6C'),('Y21k8t2u9D'),('Y21l4d5v4P'),('Y21l5f9r2T'),('Y21l6k2n1L'),('Y21m0a3t8V'),('Y21m1b5d7H'),('Y21m1v3d6V'),('Y21m6p8s3I'),('Y21n9p1n2F'),('Y21o2k5g2F'),('Y21o6z6w7G'),('Y21o8j6m5Q'),('Y21o9o2w6C'),('Y21o9s5h1I'),('Y21p1m4i0V'),('Y21p3z1w6U'),('Y21p5s5v4O'),('Y21p8o6k8V'),('Y21p8v0o4G'),('Y21p9a1c3B'),('Y21q3s6c7X'),('Y21q5y2g9O'),('Y21q7j8b9V'),('Y21r1y3d2A'),('Y21r2g8t4N'),('Y21r5t3v1Y'),('Y21r7i5k7R'),('Y21r8v6d0F'),('Y21s2l2g2Y'),('Y21s4k5g0B'),('Y21s4p0h3F'),('Y21t1o7o9Y'),('Y21t6w4j0J'),('Y21u0h0r1H'),('Y21u1z9w6E'),('Y21u4a5y5V'),('Y21u6h9a9Z'),('Y21u6q9o1X'),('Y21u7j9u8C'),('Y21v5s0t5X'),('Y21v7m0z9X'),('Y21v8e5b1X'),('Y21w3k2x5I'),('Y21w4b1d7E'),('Y21w4s1x4S'),('Y21w7j4f7F'),('Y21x5j6p6T'),('Y21x8e8x9N'),('Y21x8n6z9E'),('Y21y5a3i5J'),('Y21z1u4z4R'),('Y21z3g0u2J'),('Y21z5f7v5T'),('Y21z5h8a7E'),('Y21z6i9d6D'),('Y21z8m7k6X');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-21 22:23:48

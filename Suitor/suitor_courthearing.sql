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
-- Table structure for table `courthearing`
--

DROP TABLE IF EXISTS `courthearing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courthearing` (
  `caseID` char(15) NOT NULL,
  `nextHearingDate` date DEFAULT NULL,
  `courtRoom` varchar(256) NOT NULL,
  `time` time NOT NULL,
  PRIMARY KEY (`caseID`,`time`),
  CONSTRAINT `courthearing_ibfk_1` FOREIGN KEY (`caseID`) REFERENCES `legalcases` (`caseID`),
  CONSTRAINT `courthearing_chk_1` CHECK (((`time` > _utf8mb4'09:00') and (`time` < _utf8mb4'19:00')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courthearing`
--

LOCK TABLES `courthearing` WRITE;
/*!40000 ALTER TABLE `courthearing` DISABLE KEYS */;
INSERT INTO `courthearing` VALUES ('SSS21a0a6p9S000','2021-12-29','Ap #170-5008 Odio Street','10:21:00'),('SSS21a2d9l7A000','2021-08-06','Ap #131-7761 Turpis Road','14:08:00'),('SSS21a3i7z1O000','2021-04-27','6574 Fames Ave','17:00:00'),('SSS21a5l8y4Q000','2021-05-14','Ap #310-952 Semper Avenue','17:06:00'),('SSS21a6j4s8S000','2021-12-07','P.O. Box 176, 5348 Vehicula Rd.','14:49:00'),('SSS21b9l8r3P000','2022-02-07','3522 Sociis Rd.','11:55:00'),('SSS21c0v3j7H000','2021-06-08','P.O. Box 963, 6698 Non Rd.','18:17:00'),('SSS21c2h1l0H000','2021-12-20','704-6648 Libero. St.','18:43:00'),('SSS21c4j2s1X000','2021-03-06','8433 Pretium Rd.','10:11:00'),('SSS21c5g2t6S000','2022-01-10','Ap #562-2916 Suspendisse Av.','10:52:00'),('SSS21d4j9h5F000','2021-08-18','P.O. Box 402, 9615 Ultrices St.','18:50:00'),('SSS21d8m8u7S000','2021-02-10','Ap #675-5218 Arcu. Ave','09:30:00'),('SSS21d9j4s9V000','2021-06-09','P.O. Box 548, 8902 Amet Road','18:11:00'),('SSS21e3w2w2Q000','2022-02-11','P.O. Box 662, 2384 Et, Ave','16:51:00'),('SSS21e7a2y8X000','2021-09-13','5158 Ullamcorper, Street','17:23:00'),('SSS21e8i7o9T000','2021-05-28','9281 Phasellus Rd.','10:34:00'),('SSS21f0o8f3M000','2021-02-26','P.O. Box 415, 6537 Neque Rd.','12:53:00'),('SSS21f2i1y4G000','2021-07-06','P.O. Box 306, 2905 Dolor. Street','18:30:00'),('SSS21f2o7c6M000','2021-06-06','1679 In Rd.','10:30:00'),('SSS21f4f1m7D000','2021-08-27','153-9506 Ante, Ave','17:45:00'),('SSS21f7g1m0X000','2021-10-21','487-9644 Praesent Ave','17:09:00'),('SSS21f8c9f6M000','2021-07-18','5841 Interdum Avenue','11:08:00'),('SSS21g1h3u4I000','2021-05-26','427-6363 Tincidunt, Avenue','12:28:00'),('SSS21g1s2c8O000','2021-12-04','7819 Sapien. St.','16:54:00'),('SSS21g3n2c8L000','2021-12-25','659-4545 Ante. Avenue','18:35:00'),('SSS21g4w5c6D000','2021-05-28','763-5010 Nibh Rd.','16:35:00'),('SSS21g5u1k6F000','2021-06-28','6555 Vel Avenue','15:27:00'),('SSS21h1q4a0S000','2021-08-11','121-2250 Eu St.','13:55:00'),('SSS21h2t7e7N000','2021-08-02','322-5943 Ac, Street','13:57:00'),('SSS21h4d5s5N000','2021-04-30','4580 Dui. Rd.','17:30:00'),('SSS21h4r3w5L000','2021-08-08','495-4980 Cras Ave','11:40:00'),('SSS21h7e3k5M000','2021-08-14','P.O. Box 659, 6267 Sed Avenue','18:44:00'),('SSS21i1q4e2C000','2021-03-03','3647 Imperdiet St.','11:31:00'),('SSS21i2g3x4N000','2021-08-27','P.O. Box 493, 1484 Purus. Avenue','15:51:00'),('SSS21i3c0v7K000','2021-07-19','426-8279 Ligula. Ave','15:30:00'),('SSS21i3k0z7H000','2021-07-31','P.O. Box 978, 5168 Integer Rd.','09:50:00'),('SSS21i4h3i7G000','2021-02-27','P.O. Box 329, 6455 Rutrum Av.','10:51:00'),('SSS21i6v6f7T000','2021-04-17','8136 Massa Avenue','10:52:00'),('SSS21j1j4d2X000','2021-08-02','P.O. Box 941, 2912 Cras St.','09:06:00'),('SSS21j2b1k9V000','2021-02-07','P.O. Box 805, 2678 Mi Ave','17:22:00'),('SSS21l9i0c0G000','2021-07-21','7033 Risus. St.','12:41:00'),('SSS21m1x7b8D000','2021-10-02','P.O. Box 541, 4541 Conubia Street','13:21:00'),('SSS21m2s8l8V000','2021-04-09','598-8192 Consectetuer Rd.','13:14:00'),('SSS21m4j8t5Y000','2021-12-31','742-243 Primis Rd.','13:57:00'),('SSS21m6a0d2A000','2021-12-15','Ap #164-5629 Nonummy Av.','14:07:00'),('SSS21m9w8z8C000','2021-04-28','3572 Eu, Av.','18:53:00'),('SSS21n2b5k6O000','2021-03-13','931-3222 Fermentum Rd.','13:18:00'),('SSS21n4w8u7G000','2021-04-03','4354 Fusce Ave','14:31:00'),('SSS21o2d2m1T000','2021-05-12','Ap #658-5553 Aliquet, Street','15:57:00'),('SSS21o2v8p8Q000','2022-02-19','Ap #241-453 Molestie St.','12:37:00'),('SSS21o5q4n4D000','2021-05-28','P.O. Box 851, 6257 Amet Rd.','10:28:00'),('SSS21p2y3h0J000','2021-11-29','P.O. Box 290, 3146 Velit. St.','14:33:00'),('SSS21p3d1e3Z000','2021-08-25','Ap #583-2800 Vulputate Road','18:19:00'),('SSS21p4d1l5D000','2021-05-24','Ap #813-6543 Dapibus Av.','11:36:00'),('SSS21p4y9k3K000','2022-01-17','Ap #262-4638 A St.','10:47:00'),('SSS21p6f6g2Y000','2021-11-09','P.O. Box 541, 3983 Lectus Avenue','16:35:00'),('SSS21q0w9e4F000','2021-11-30','897-8444 Nisl. Road','10:52:00'),('SSS21q6h2r5T000','2021-10-23','4718 Rutrum. St.','11:42:00'),('SSS21q6l8d6I000','2021-10-28','P.O. Box 301, 5887 Nibh Avenue','15:15:00'),('SSS21q6m3x3T000','2021-11-12','633-8235 Dictum. Street','14:05:00'),('SSS21q9n4e2T000','2021-07-02','P.O. Box 421, 6999 Non Avenue','15:28:00'),('SSS21r0x1d7Q000','2022-01-19','P.O. Box 168, 7453 Phasellus Ave','11:56:00'),('SSS21r0z8x1B000','2021-09-29','P.O. Box 655, 5388 Vel St.','12:27:00'),('SSS21r2i9s2I000','2021-06-15','3802 Nunc St.','09:46:00'),('SSS21r2s0x1N000','2021-09-06','641-6536 Risus. Street','16:08:00'),('SSS21r4j6o9L000','2021-03-07','1599 Dolor. Av.','16:26:00'),('SSS21t0l8f1K000','2021-06-07','Ap #308-983 Lacinia Rd.','16:01:00'),('SSS21t1y8p4S000','2021-05-14','P.O. Box 128, 4144 Ut, Rd.','09:43:00'),('SSS21t5j9w8Q000','2021-04-18','Ap #509-1426 Purus, St.','13:13:00'),('SSS21t5q9r6X000','2021-06-27','9322 Enim Road','15:54:00'),('SSS21t7z7y4I000','2021-07-14','Ap #974-344 Malesuada. Rd.','14:38:00'),('SSS21u2b9j9T000','2021-07-15','577-4664 Neque Avenue','18:44:00'),('SSS21u3f3x1U000','2022-02-13','Ap #939-2265 Elit, St.','11:18:00'),('SSS21u5y4c9M000','2021-09-17','P.O. Box 627, 9295 Dictum Rd.','12:57:00'),('SSS21u6y2o0G000','2021-07-13','P.O. Box 626, 6122 Urna, Avenue','18:37:00'),('SSS21u8m5q6V000','2022-01-12','931-4346 Etiam Rd.','10:38:00'),('SSS21u9p6o8P000','2021-06-15','357-243 Sed Street','11:47:00'),('SSS21v2a2i2Q000','2021-02-20','Ap #961-1437 Tempor, Rd.','12:01:00'),('SSS21v4h8r3P000','2022-01-01','124-1527 Interdum Road','12:39:00'),('SSS21v4i3j3Q000','2021-03-09','114-8034 Elit, Street','09:10:00'),('SSS21v4l5t6B000','2021-09-20','Ap #809-9857 Id Ave','13:27:00'),('SSS21v8k1h4G000','2021-10-09','Ap #457-9091 Accumsan Street','16:17:00'),('SSS21w2k1h1K000','2022-02-08','P.O. Box 843, 7909 Feugiat Street','09:13:00'),('SSS21w4v3a8C000','2022-02-13','3595 Enim St.','13:42:00'),('SSS21w5z3w3P000','2021-10-27','P.O. Box 606, 2373 Vulputate Avenue','13:37:00'),('SSS21w9v7d1S000','2021-03-01','987-7953 Proin Ave','09:43:00'),('SSS21w9x5e8R000','2021-03-07','794-2628 Semper St.','14:48:00'),('SSS21x3c0k9T000','2021-03-16','6697 Proin Rd.','16:22:00'),('SSS21x3v1i1X000','2021-08-15','3730 Libero. St.','09:14:00'),('SSS21x4j4e8B000','2021-07-04','P.O. Box 419, 2586 Sapien, St.','16:55:00'),('SSS21x4s1a3V000','2021-10-06','Ap #885-6322 Ut, Rd.','18:53:00'),('SSS21x6m5b8C000','2021-08-11','9146 Suspendisse St.','17:49:00'),('SSS21x7d9c7B000','2021-12-15','Ap #430-1828 Nisi St.','15:20:00'),('SSS21x7t4k3L000','2021-06-30','487-3320 Eget Av.','10:00:00'),('SSS21x9u8f6Z000','2021-11-17','P.O. Box 710, 7772 Eu Rd.','10:24:00'),('SSS21y5z3j2Y000','2021-03-24','6034 Gravida Ave','11:29:00'),('SSS21y7r8q2W000','2021-03-03','Ap #753-5206 A Rd.','13:20:00'),('SSS21z3g2q9E000','2021-09-15','762-4905 Non, Avenue','11:25:00'),('SSS21z6c7c1T000','2021-02-17','Ap #715-6119 Mattis. St.','09:34:00'),('SSS21z9r7y5C000','2021-02-09','Ap #637-9032 Erat Road','10:29:00');
/*!40000 ALTER TABLE `courthearing` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-21 22:23:46

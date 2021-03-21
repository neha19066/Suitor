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
-- Table structure for table `financialtransactions`
--

DROP TABLE IF EXISTS `financialtransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `financialtransactions` (
  `transactionID` char(10) NOT NULL,
  `dateOfPayment` date NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `amount` mediumint NOT NULL,
  `type` tinyint NOT NULL,
  PRIMARY KEY (`transactionID`),
  CONSTRAINT `financialtransactions_chk_1` CHECK ((`amount` <> 0)),
  CONSTRAINT `financialtransactions_chk_2` CHECK (((`type` = 0) or (`type` = 1)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financialtransactions`
--

LOCK TABLES `financialtransactions` WRITE;
/*!40000 ALTER TABLE `financialtransactions` DISABLE KEYS */;
INSERT INTO `financialtransactions` VALUES ('Mb0h2L374n','2021-10-27','Duis ac arcu. Nunc mauris. Morbi non sapien',4282,0),('Mb1w9M013e','2021-05-14','Curabitur consequat, lectus sit amet luctus vulputate, nisi',6438,0),('Mb5h5I260e','2021-08-12','fringilla purus mauris a nunc. In at pede. Cras',8912,0),('Mb6o6T540n','2021-04-17','lectus pede, ultrices a, auctor non, feugiat nec, diam.',17332,1),('Mc0p4E524h','2021-02-11','odio semper cursus. Integer mollis.',14793,0),('Md2h6T495t','2021-06-11','Nunc mauris. Morbi non sapien',17133,1),('Md4x8O425o','2021-07-06','Vivamus nibh dolor, nonummy ac, feugiat non,',12111,1),('Md5b9M452t','2021-05-12','ipsum porta elit, a feugiat tellus lorem eu metus.',10618,1),('Me0d8W423d','2022-01-23','rhoncus. Nullam velit dui, semper et, lacinia vitae,',16645,0),('Me1k4K887a','2021-02-13','Nunc commodo auctor velit. Aliquam nisl.',2789,1),('Me3g9B611s','2021-10-06','eget, ipsum. Donec sollicitudin adipiscing ligula.',19019,0),('Me6a9U102c','2021-10-26','sem eget massa. Suspendisse eleifend. Cras sed leo. Cras',5933,0),('Me8k6H847p','2021-11-07','interdum. Curabitur dictum. Phasellus in',2573,1),('Mf0v2Z877i','2021-09-27','consequat enim diam vel arcu. Curabitur ut odio vel',10956,0),('Mf5j1T825r','2021-04-01','non, cursus non, egestas a, dui. Cras',18589,0),('Mf8f7M636u','2021-05-15','Pellentesque habitant morbi tristique senectus et netus',2835,0),('Mf8u9L320d','2021-06-26','vitae nibh. Donec est mauris,',7497,1),('Mg1z5F259b','2021-02-15','Donec vitae erat vel pede blandit',14616,0),('Mg2e4N676q','2021-05-14','tincidunt nibh. Phasellus nulla. Integer',4331,0),('Mg4q3H676u','2021-10-27','Morbi sit amet massa. Quisque',17477,1),('Mg7g3Y983x','2022-02-14','dapibus quam quis diam. Pellentesque habitant morbi tristique',13043,1),('Mg7q6O707o','2021-07-08','ultricies ornare, elit elit fermentum risus, at fringilla purus mauris',13579,1),('Mg8a7I634u','2021-04-25','nonummy ac, feugiat non, lobortis quis, pede. Suspendisse dui. Fusce',8944,0),('Mh6n1S125l','2021-07-20','est ac mattis semper, dui lectus rutrum urna, nec',16333,0),('Mi0l0E160a','2021-07-03','sed libero. Proin sed turpis nec',17483,0),('Mi6k6S050w','2021-03-21','sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla',15792,0),('Mi7m9R742w','2021-11-10','at, iaculis quis, pede. Praesent eu dui. Cum sociis natoque',19276,0),('Mj0a1U705x','2022-01-10','litora torquent per conubia nostra, per inceptos hymenaeos. Mauris',12754,0),('Mj8h0U256y','2021-12-17','vitae odio sagittis semper. Nam tempor diam dictum',13550,0),('Mk2r5G724d','2021-12-03','purus gravida sagittis. Duis gravida. Praesent',6652,1),('Mk9y9D468e','2021-03-04','tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec',12870,0),('Ml0h3P711u','2021-08-18','sociosqu ad litora torquent per conubia nostra, per',5104,0),('Ml1h4P981r','2021-04-09','imperdiet dictum magna. Ut tincidunt orci quis lectus. Nullam suscipit,',5206,1),('Ml1s3W395g','2021-10-03','erat vel pede blandit congue.',16249,0),('Mm6c4D957b','2021-11-26','odio sagittis semper. Nam tempor diam dictum sapien. Aenean',16978,0),('Mn2v4D211i','2021-05-02','Ut sagittis lobortis mauris. Suspendisse',13815,0),('Mn6x5L289h','2021-07-13','ut, sem. Nulla interdum. Curabitur dictum.',3085,0),('Mn7s2O909a','2021-06-19','adipiscing non, luctus sit amet,',15044,1),('Mn9x7I604f','2021-04-11','magna sed dui. Fusce aliquam, enim',4190,1),('Mo5m8L610u','2022-01-30','Donec at arcu. Vestibulum ante ipsum primis',5373,1),('Mo8n6A500x','2021-10-17','Curabitur egestas nunc sed libero. Proin sed turpis',9142,0),('Mo9r7M547r','2021-02-06','Praesent interdum ligula eu enim. Etiam',15235,1),('Mp0n4S652x','2021-05-31','consequat purus. Maecenas libero est, congue a, aliquet vel, vulputate',18975,0),('Mp4a2O616q','2022-02-01','enim. Curabitur massa. Vestibulum accumsan neque et',7472,0),('Mp4z5I962d','2021-04-25','ipsum dolor sit amet, consectetuer adipiscing elit. Etiam',11696,0),('Mp6w6I243q','2021-07-24','a odio semper cursus. Integer mollis. Integer',19951,0),('Mp7f8S699g','2022-01-25','ut, molestie in, tempus eu, ligula. Aenean',4537,0),('Mq1a4J648s','2021-02-17','ipsum primis in faucibus orci luctus',14854,0),('Mq2x6A548m','2021-05-29','est, vitae sodales nisi magna sed dui. Fusce',13904,0),('Mq3p8P009v','2021-03-03','suscipit nonummy. Fusce fermentum fermentum',17049,1),('Mq4t6O102o','2022-01-15','lectus pede et risus. Quisque libero lacus,',2934,1),('Mq6g7Z769l','2022-01-03','Nam tempor diam dictum sapien. Aenean massa.',8848,1),('Mr4x2K333u','2021-10-31','odio. Aliquam vulputate ullamcorper magna. Sed eu eros.',18121,1),('Mr5l5A162a','2021-07-22','magna sed dui. Fusce aliquam,',14676,0),('Mr8f6E574i','2021-05-28','lacus. Nulla tincidunt, neque vitae semper egestas, urna',7639,1),('Mr8k7I508h','2022-01-09','porttitor vulputate, posuere vulputate, lacus. Cras interdum.',10711,0),('Mr9v7T981t','2022-01-05','libero at auctor ullamcorper, nisl arcu iaculis',14770,1),('Ms0a0G198n','2021-05-16','vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy',5604,1),('Ms1q7I681f','2021-09-03','mi tempor lorem, eget mollis',8965,0),('Ms2h7U218r','2021-03-02','eleifend egestas. Sed pharetra, felis',4917,1),('Ms4s6M387h','2021-10-13','purus, in molestie tortor nibh sit amet orci.',19489,0),('Ms8d3Z570z','2021-11-29','a, arcu. Sed et libero. Proin mi. Aliquam',15172,0),('Mt3z5D549v','2021-09-27','Aliquam vulputate ullamcorper magna. Sed eu eros. Nam consequat',18674,0),('Mt7v7Y217a','2022-01-22','Nunc mauris elit, dictum eu, eleifend nec, malesuada ut, sem.',8853,0),('Mt8x3H190l','2021-09-05','euismod urna. Nullam lobortis quam a felis ullamcorper',9474,0),('Mu0c8V469p','2021-02-15','blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae',14973,1),('Mu0i7K329x','2021-12-22','amet diam eu dolor egestas',15719,1),('Mu0z0Q217g','2021-03-17','Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi',2601,1),('Mu2v0K283k','2021-11-08','amet nulla. Donec non justo.',14328,1),('Mu2y1X981j','2021-05-25','Sed id risus quis diam luctus lobortis.',6262,0),('Mu5q0X096d','2022-01-28','Nunc ut erat. Sed nunc',19172,0),('Mu7q3B911o','2021-10-31','dignissim pharetra. Nam ac nulla.',19798,1),('Mu7u5I303k','2021-08-26','non, cursus non, egestas a,',6991,0),('Mv1l5Q210j','2021-04-17','adipiscing, enim mi tempor lorem, eget mollis lectus pede et',15962,1),('Mv5z3Z965n','2021-06-15','ut, pellentesque eget, dictum placerat, augue. Sed molestie. Sed id',2557,0),('Mv7y0F199p','2021-04-09','adipiscing ligula. Aenean gravida nunc',11015,1),('Mv8l1N656i','2021-10-22','elit fermentum risus, at fringilla',5992,0),('Mv8x9K926h','2021-08-16','mauris ut mi. Duis risus',11898,0),('Mw0l3R867t','2021-09-11','ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis',15720,1),('Mw6m8O560f','2021-04-05','in consectetuer ipsum nunc id enim. Curabitur massa. Vestibulum accumsan',16332,1),('Mx0f5X901e','2021-06-19','velit. Sed malesuada augue ut lacus. Nulla tincidunt,',7333,1),('Mx0v4E664u','2022-01-19','interdum. Curabitur dictum. Phasellus in',2163,0),('Mx2r0Y217e','2021-11-14','Aliquam tincidunt, nunc ac mattis ornare,',16488,1),('Mx6h8R926p','2021-05-17','ante, iaculis nec, eleifend non, dapibus rutrum, justo. Praesent',8747,0),('Mx7y6X802o','2021-03-08','ullamcorper. Duis cursus, diam at pretium aliquet, metus urna',6607,1),('Mx8k5K647b','2021-11-05','pretium et, rutrum non, hendrerit id, ante. Nunc mauris',16491,0),('Mx8l1S902r','2022-02-16','non magna. Nam ligula elit, pretium',4012,0),('My0f5H763w','2022-02-05','sagittis. Duis gravida. Praesent eu nulla at sem molestie',9081,0),('My2p6M506o','2021-08-22','tempor erat neque non quam. Pellentesque habitant',3135,1),('My4v9S021v','2021-02-18','Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum',14179,0),('My7k8N041k','2021-03-08','Nam interdum enim non nisi. Aenean eget metus.',10348,1),('My8q7F235n','2021-03-11','vitae nibh. Donec est mauris, rhoncus id,',18614,1),('My9c2W930j','2021-03-12','tortor nibh sit amet orci.',13989,0),('My9f2G226i','2021-08-15','accumsan neque et nunc. Quisque ornare tortor',7772,1),('Mz1i1O438m','2021-05-02','malesuada id, erat. Etiam vestibulum',13779,1),('Mz1x5P943g','2021-08-15','Cras pellentesque. Sed dictum. Proin eget',9412,1),('Mz3f2N363a','2021-02-24','Nunc ullamcorper, velit in aliquet lobortis, nisi',19538,1),('Mz4l5X072q','2021-11-25','gravida nunc sed pede. Cum sociis natoque penatibus et magnis',14634,1),('Mz5r9L827g','2021-04-29','lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id,',2688,0),('Mz6o7G601t','2021-05-01','mollis vitae, posuere at, velit. Cras lorem lorem, luctus',10613,0);
/*!40000 ALTER TABLE `financialtransactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-21 22:23:44

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
-- Table structure for table `otherstaff`
--

DROP TABLE IF EXISTS `otherstaff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `otherstaff` (
  `userID` char(10) NOT NULL,
  `calendarID` char(10) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `middleName` varchar(30) DEFAULT NULL,
  `lastName` varchar(30) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `gender` varchar(30) NOT NULL,
  `salary` mediumint NOT NULL,
  `experience` mediumint NOT NULL,
  `emailID` varchar(256) NOT NULL,
  `phoneNumber` char(10) NOT NULL,
  `positionAtFirm` varchar(100) NOT NULL,
  `streetName` varchar(256) NOT NULL,
  `city` varchar(50) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `state` varchar(50) NOT NULL,
  PRIMARY KEY (`userID`),
  KEY `calendarID` (`calendarID`),
  CONSTRAINT `otherstaff_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  CONSTRAINT `otherstaff_ibfk_2` FOREIGN KEY (`calendarID`) REFERENCES `calendar` (`calendarID`),
  CONSTRAINT `otherstaff_chk_1` CHECK ((`positionAtFirm` in (_utf8mb4'HR',_utf8mb4'PR',_utf8mb4'Finance and Accounting',_utf8mb4'IT',_utf8mb4'Support Staff'))),
  CONSTRAINT `otherstaff_chk_2` CHECK (((`salary` >= 2000) and (`salary` <= 20000)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otherstaff`
--

LOCK TABLES `otherstaff` WRITE;
/*!40000 ALTER TABLE `otherstaff` DISABLE KEYS */;
INSERT INTO `otherstaff` VALUES ('O21a0b2d6K','o21x1e5j3W','Keely','Duncan','Moody','1986-05-01','Female',18547,20,'dictum.magna.Ut@Nulla.net','9490378505','Support Staff','P.O. Box 631, 8421 In Road','Itagüí','76642','Antioquia'),('O21a5i1p3G','o21y0h1q4E','Brian','Gareth','Guzman','1991-11-15','Female',3813,22,'ante.ipsum.primis@semperdui.net','9602361081','HR','4152 Nec Rd.','Dir','9556 SQ','Khyber Pakhtoonkhwa'),('O21b1l4d4S','o21b7q9t5M','Jasper','Aidan','Kirkland','1993-02-19','Others',9606,17,'tellus@luctusfelis.com','9688910794','Support Staff','7083 Mi Avenue','Gravilias','164015','San José'),('O21b7i0p5B','o21c2j9g8O','Vincent','Brandon','Rivas','1989-11-24','Others',6662,4,'purus@justositamet.co.uk','9925226977','IT','996-7395 Convallis Avenue','Sneek','584645','Fr'),('O21b7n1v0N','o21n8i1p9Q','Shad','Rose','Bates','1985-10-20','Others',6504,22,'nascetur@purusNullam.com','9086422832','Finance and Accounting','Ap #501-8933 Convallis Rd.','Dabgram','9407','WB'),('O21b8c9o1N','o21t7y9g9A','Stacey','Brynne','Kerr','1990-11-08','Male',6140,21,'Etiam.ligula@pharetra.com','9179386088','HR','908-3124 Nunc Road','Cowdenbeath','47141-169','FI'),('O21b8m5o5E','o21y9t7v0G','Gil','Steel','Hansen','1987-11-25','Male',5868,9,'sed@nuncest.org','9008188087','IT','1622 Mauris Av.','Paine','PZ02 0FI','Metropolitana de Santiago'),('O21b9f9x9S','o21j0l2b0H','Lucius','Yolanda','Odom','1992-06-13','Female',5264,5,'pellentesque.massa.lobortis@suscipitestac.edu','9461440991','Support Staff','P.O. Box 894, 157 Risus Road','Champdani','2590','West Bengal'),('O21c7b3y8G','o21i9y6i4Q','Rigel','Wynter','Puckett','1985-12-03','Male',3268,4,'leo@eget.org','9365027573','Finance and Accounting','P.O. Box 502, 7958 Odio. Av.','Portland','319386','OR'),('O21c7m6t7G','o21z8v5s9L','Stephen','Chaim','Shaffer','1985-08-10','Male',18949,1,'dictum.augue@lorem.net','9844056537','HR','Ap #224-4564 Non Street','Angers','6028','Pays de la Loire'),('O21c7q8w4J','o21t0c2f2S','Maxwell','Alec','Grant','1986-01-07','Male',12892,6,'dolor@enim.ca','9997280534','IT','997-4075 Iaculis, Street','Semarang','61810','JT'),('O21d5t0b1S','o21n5p7r8F','Jordan','Phelan','Walls','1987-05-03','Male',2175,5,'faucibus@gravidanuncsed.org','9028131473','Finance and Accounting','Ap #121-4938 Pretium Ave','New Haven','179051','Connecticut'),('O21e9q0v2C','o21t6a7q3P','Barbara','Maxine','Hill','1985-10-10','Male',3550,1,'eu.accumsan.sed@sem.co.uk','9390962124','Support Staff','Ap #293-4194 Vel Ave','Parla','81092','MA'),('O21f1d3n8D','o21b1m2z4C','Gil','Mara','Obrien','1988-12-31','Male',6656,23,'adipiscing.Mauris@ullamcorpernislarcu.org','9118358424','Support Staff','Ap #705-8764 Donec St.','Poznań','8611 AZ','WP'),('O21f1z8c5E','o21e2v7b2B','Abigail','Brent','Pruitt','1993-10-01','Female',14757,15,'netus.et@Maecenasiaculisaliquet.com','9624702128','IT','9400 Nullam St.','Tay','35652','Ontario'),('O21f2n5h8B','o21i1d7s9C','Neville','Lael','Ayers','1990-05-11','Female',16912,13,'posuere.vulputate.lacus@velitSed.ca','9416578525','Support Staff','P.O. Box 194, 9390 Ac Street','Macul','356118','RM'),('O21f4d0v9S','o21t2c6w1Y','Ann','Leah','Burke','1993-03-18','Female',11688,3,'neque.vitae@montesnascetur.com','9822391230','HR','P.O. Box 851, 932 Sodales. Av.','Qambar Shahdadkot','85324','SI'),('O21g0i7i1G','o21c5s3x5Y','Hayfa','Cruz','Nielsen','1989-01-28','Female',10618,21,'sagittis.augue.eu@Fusce.ca','9551488348','Support Staff','Ap #951-7202 Aliquam Road','Mombaruzzo','02173','Piemonte'),('O21g1d1q3S','o21z2a6m1B','Dalton','Donovan','Mcbride','1987-07-23','Female',6770,18,'Cras.convallis@dignissimmagna.net','9276423917','Support Staff','P.O. Box 627, 664 Amet Rd.','Körfez','814609','Kocaeli'),('O21h1t2h9X','o21b4k3p3C','Byron','Grady','Thomas','1989-05-08','Male',2394,2,'imperdiet@a.edu','9989154493','IT','325-8389 Rhoncus. Rd.','Penza','08285','PNZ'),('O21h1t2w5O','o21d3d3o4L','Althea','Ayanna','Newton','1992-05-24','Others',12448,3,'eros@elit.com','9815359037','IT','9473 Sagittis. Ave','Duque de Caxias','18786','RJ'),('O21h2a5d0O','o21b8t9y0H','Phelan','Noah','Quinn','1991-04-14','Others',8523,20,'commodo.ipsum.Suspendisse@urnajusto.ca','9955231512','Support Staff','P.O. Box 412, 5705 Nec St.','Béthune','845823','Nord-Pas-de-Calais'),('O21h3b8f0C','o21g4v4u3Q','Adria','Gemma','Alvarado','1988-12-06','Others',7252,9,'in@fringillami.edu','9801009272','Support Staff','P.O. Box 513, 4354 Ante, St.','Ñuñoa','QE59 7TP','Metropolitana de Santiago'),('O21h7t4w7A','o21r9l7n3I','Shelly','Clementine','Lyons','1985-03-15','Female',14837,10,'est@vel.edu','9348778233','Support Staff','Ap #935-4495 Velit St.','Vienna','708282','Vienna'),('O21h8b8o6W','o21k8q6y2P','Isabelle','Griffin','Wright','1991-12-27','Male',15354,11,'est@elitCurabitursed.edu','9347149961','IT','P.O. Box 804, 695 Enim Av.','Cajamarca','5351 YB','Cajamarca'),('O21h8j2h4K','o21h9x8c9B','Glenna','Meghan','Peck','1993-06-04','Female',4015,24,'leo.in.lobortis@elitsed.org','9407615248','IT','719-4599 Semper Av.','Wimborne Minster','9978','DO'),('O21i1b8h8M','o21s6h2o3P','Sylvia','Demetrius','Sparks','1988-04-16','Others',13380,10,'non.enim@nostra.ca','9767651299','Support Staff','8515 Orci Avenue','Cobourg','7724','ON'),('O21i1v0p4N','o21y4n5g4P','Upton','Fletcher','Hardy','1986-06-24','Others',11953,4,'penatibus@Phasellusvitae.co.uk','9937487891','Finance and Accounting','Ap #652-8783 Pede, St.','Patalillo','Z2051','San José'),('O21i2c9d7A','o21o8t5y7A','Halee','Bo','Walsh','1986-01-05','Female',19544,25,'odio.Aliquam@dolorsit.com','9630593342','HR','1177 Augue Street','Awka','91338-079','Anambra'),('O21i2h1o4T','o21r0e9w8M','Sandra','Coby','Mullins','1992-03-15','Others',10174,5,'lobortis@magna.edu','9228983500','Finance and Accounting','249-5813 Eu Street','Cimahi','6611 JM','JB'),('O21i2k6s6M','o21p7f7e5F','Clark','Raja','Huber','1985-10-04','Male',5343,6,'tristique@arcuimperdiet.ca','9406028774','IT','Ap #646-822 Aliquam St.','Waitakere','Z3397','NI'),('O21i3u6f4B','o21c9h2w3K','Paki','Fitzgerald','Ayala','1988-11-27','Female',4854,14,'odio.Etiam.ligula@ligulaAeneaneuismod.com','9883740134','IT','8480 Et St.','Ñuñoa','43827','RM'),('O21i4b6a8B','o21g0w1l6W','Silas','Carla','Brock','1992-06-06','Male',12125,9,'sapien@dolorDonec.co.uk','9085914411','Finance and Accounting','9908 Metus. St.','Rionegro','23060','Antioquia'),('O21j6c6y3S','o21x3u6e8H','Neve','Jescie','Hayes','1987-07-24','Female',5350,10,'aliquam@cursus.edu','9865102774','IT','677-8132 Praesent Rd.','San Pedro de Atacama','63294','II'),('O21j7l0e7H','o21h7s2m0G','Giacomo','Naida','Valenzuela','1985-09-22','Male',7247,1,'tempor.arcu@facilisiSedneque.net','9267759611','Finance and Accounting','P.O. Box 681, 4154 Velit. Avenue','Rotterdam','841779','Zuid Holland'),('O21k0w5h9T','o21e5c2s1B','Brittany','Kibo','Farmer','1988-09-30','Male',9714,9,'est.Nunc.ullamcorper@elitpharetra.org','9197790396','HR','P.O. Box 731, 7744 Amet, Road','Cáceres','3507','EX'),('O21k4g9j2B','o21d9l7r4N','Aidan','Murphy','Bridges','1985-10-04','Others',13359,18,'nec.mollis@elitpedemalesuada.net','9001346122','Support Staff','913-3051 Velit Rd.','Pittsburgh','82515','PA'),('O21k8r2r6T','o21n1c5i6S','Josiah','Dara','Russell','1989-10-07','Male',8643,22,'mollis.Duis@mollis.net','9004681474','HR','495-8310 Id, Street','Łódź','11899','LD'),('O21k9t9k6Z','o21p1n6t4G','Kaseem','Ray','Chambers','1993-01-24','Male',15966,6,'euismod.ac@acipsum.co.uk','9230378636','HR','Ap #293-9418 Proin Ave','Berlin','82817','Berlin'),('O21l5g2g3Z','o21j2k0c3O','Cassandra','Carly','Griffin','1988-07-06','Male',15724,13,'sit.amet.faucibus@Duisgravida.org','9695602085','Finance and Accounting','Ap #342-7822 Hendrerit Rd.','San Rafael','489139','A'),('O21m4j7j5T','o21c0u7x1C','Omar','Upton','Barr','1985-02-11','Others',9760,16,'egestas.urna.justo@Integersemelit.net','9064263152','Finance and Accounting','190-7843 Curae; Ave','Gaya','97366-245','BR'),('O21m6r1f4E','o21v2g7o3F','Lila','Azalia','Stafford','1988-01-07','Male',9619,19,'Mauris.magna.Duis@ullamcorpernislarcu.net','9237209639','Finance and Accounting','Ap #913-6255 Velit. Av.','Warrnambool','00785','Victoria'),('O21m7b7y6G','o21f0a3k3G','Wallace','Keaton','Gill','1988-09-23','Others',2693,24,'vitae.sodales.at@mollislectuspede.net','9667673293','Support Staff','432-6244 Libero Rd.','Enschede','13870','Ov'),('O21n3s6j3T','o21r6d9u3E','Shelley','Quamar','Ortega','1986-08-13','Others',5816,24,'Mauris.eu.turpis@metusvitae.net','9929172972','HR','P.O. Box 648, 4973 Non, St.','Dordrecht','33030','Zuid Holland'),('O21n9a9q4Q','o21j6m6d8Y','Shay','Ina','Reyes','1987-03-07','Male',14483,24,'magna@sedorcilobortis.ca','9027959597','Finance and Accounting','P.O. Box 518, 3334 Et, St.','Okara','4569','Sindh'),('O21n9t7q9A','o21j2r6m9K','Vaughan','Yoshi','Pratt','1988-01-18','Male',4396,20,'Nullam@atliberoMorbi.edu','9413318209','Support Staff','4619 Tincidunt Rd.','Galway','5128','C'),('O21o7m0a5J','o21m9c6v6X','Howard','Burton','Cross','1990-10-18','Others',16192,2,'dui.nec.tempus@massa.ca','9627480024','Finance and Accounting','2433 Nullam Rd.','Medellín','612102','Antioquia'),('O21o8k1i4G','o21q0m5j4Y','Liberty','Vivien','Douglas','1988-11-05','Female',12280,3,'Sed@consequatdolor.co.uk','9558239794','IT','6666 Neque Ave','Tulsa','74752','Oklahoma'),('O21o9z6q5L','o21j8g2s4C','Risa','Bertha','Battle','1993-01-26','Male',3524,9,'eros.nec.tellus@dolor.org','9142809886','IT','Ap #631-9687 Ut Road','Sabanalarga','440672','Atlántico'),('O21p2p6d4C','o21l0r6p6G','Reagan','Vance','Baldwin','1992-04-17','Female',7405,7,'lectus.convallis@adipiscing.com','9173358708','Support Staff','428 Vel Road','Serang','00354','BT'),('O21p5d4e7K','o21h9i8t0I','Lana','Zorita','Brown','1985-12-31','Others',9826,2,'nec.ante@faucibusMorbi.com','9549660275','Support Staff','P.O. Box 283, 7046 Est. Street','Flushing','4622','Zeeland'),('O21p5y3f5D','o21l8h9x5M','Eaton','Maxine','Castillo','1987-07-01','Others',11194,17,'Morbi@Aliquamadipiscing.com','9423092491','IT','333-3014 Tincidunt, Avenue','Vegreville','09490','Alberta'),('O21p6y7u3O','o21c2p4b6J','Sean','Rahim','Kemp','1987-04-08','Others',10871,13,'Donec.sollicitudin.adipiscing@pulvinararcu.edu','9022162684','Finance and Accounting','4674 Nunc Ave','Itagüí','51-018','ANT'),('O21q0j8r6P','o21j8c4e3R','Emerson','Shaine','Phelps','1990-09-28','Female',19650,12,'iaculis.odio.Nam@lacus.org','9352360465','Finance and Accounting','4452 Tincidunt St.','Çermik','934416','Diyarbakır'),('O21q1q9n8K','o21m9v0u7O','TaShya','Len','Richardson','1993-11-22','Male',10043,20,'lorem.luctus.ut@at.ca','9664718513','Support Staff','Ap #452-9823 Sit Av.','Faisalabad','0083-71349','Punjab'),('O21q1t2t9W','o21j6g7d2C','Jolie','Akeem','Stark','1988-09-18','Others',3835,4,'tempor.diam.dictum@a.edu','9379004866','HR','P.O. Box 372, 9689 Ultricies Rd.','Dublin','18098','Leinster'),('O21q1z0r4I','o21m7e5c1Z','Jordan','Tara','Mitchell','1988-04-06','Others',6260,21,'interdum.Sed.auctor@rutrumFuscedolor.ca','9756815491','Finance and Accounting','685-8577 Hendrerit. Ave','Ipswich','479012','QLD'),('O21q7l2z3D','o21m3a6n0B','Ray','Louis','Schmidt','1986-10-19','Others',11620,25,'Nam.nulla.magna@loremvehiculaet.org','9674420880','Support Staff','2813 Mi St.','Puno','34869','PUN'),('O21q8e3x6V','o21j8f1x4S','Damon','Christopher','Knowles','1990-03-21','Female',9278,17,'et@quam.co.uk','9375152161','HR','2357 Odio Av.','Francavilla in Sinni','82-324','Basilicata'),('O21q9d9g4F','o21p9y8o1V','Gannon','Scarlet','Mccoy','1991-08-27','Others',9915,6,'rhoncus.id@magnis.edu','9867014764','Support Staff','Ap #276-2422 Velit. Road','Åkersberga','5935','Stockholms län'),('O21r1m3c3W','o21e1m0y5A','Hasad','Mark','Cherry','1990-05-17','Female',8364,21,'ac@euultricessit.edu','9315034631','IT','396-5864 Pharetra, Av.','Diamer','006805','GB'),('O21r2w6l9I','o21f6v1f6O','Michael','Alfonso','Lowery','1989-11-06','Female',6680,22,'eleifend.nunc.risus@eleifendnon.edu','9969574134','Support Staff','Ap #530-513 Ornare St.','Chandler','9926','AZ'),('O21r4y8d8Y','o21h2r9x4Z','Teegan','Ocean','Knapp','1985-08-26','Male',18424,20,'velit@justoPraesent.com','9821415878','Support Staff','P.O. Box 269, 3045 Est, St.','Semarang','UR1 1EY','JT'),('O21r9a5l9H','o21w5c1i7I','Christen','Hasad','Duffy','1989-05-26','Female',9238,6,'penatibus@nulla.org','9171857864','Support Staff','7776 Fusce Rd.','Marbella','08104','AN'),('O21s3s8e7A','o21p9s8l0A','Thane','Victoria','Robertson','1987-09-30','Female',3486,20,'pede@neque.co.uk','9899669077','Support Staff','762-1269 Tellus St.','Wageningen','38698-684','Gelderland'),('O21s8l2h5B','o21e6i5i8J','Brady','Sara','Gregory','1988-12-16','Female',18438,12,'eu.dolor@elementum.org','9527604744','IT','P.O. Box 589, 9696 Sed Rd.','Berlin','9651','Berlin'),('O21s9b2l5A','o21n5e1o2L','Tarik','Renee','Hurley','1992-08-12','Male',12391,18,'sit@cubiliaCurae.org','9893442155','Finance and Accounting','2233 Non Road','Ryazan','85652','Ryazan Oblast'),('O21t0o1g1I','o21f0f9z0A','Hedy','Timon','Duran','1986-06-26','Others',17188,8,'Sed@vestibulummassa.edu','9670503082','HR','Ap #386-9159 Turpis. Road','Norrköping','671794','Östergötlands län'),('O21t1k5q5Q','o21i4l6q5N','Genevieve','Carla','Conner','1985-03-04','Others',9185,19,'luctus.aliquet@commodoat.co.uk','9923764874','IT','Ap #452-3110 Mollis. Road','Kearney','18036','Nebraska'),('O21t3s8p0V','o21p2c5j8M','Vivien','Renee','Malone','1988-11-02','Female',15238,4,'non.sollicitudin.a@ultricies.com','9132587735','HR','3275 Tempus Ave','Proddatur','074732','AP'),('O21t4p5f6V','o21i8e1e4B','Clare','Quin','Macdonald','1986-02-19','Male',10668,19,'vestibulum.massa.rutrum@orcilacus.net','9601282774','Support Staff','959-529 Cursus Road','San Nicolás','328930','VII'),('O21t5q2x4T','o21b4h6g0G','Idona','Gregory','Mcpherson','1989-10-03','Female',4509,1,'lectus.Nullam@laciniaSedcongue.co.uk','9947909562','Support Staff','P.O. Box 956, 8214 Tortor. St.','Siheung','792236','Gyeonggi'),('O21u2s1j5K','o21o7w1m5Q','Fatima','Francis','Mcclure','1988-01-05','Female',7533,12,'at.iaculis@leoMorbineque.ca','9156113771','Finance and Accounting','2729 Nec Av.','Terneuzen','189682','Zl'),('O21v3r4f1U','o21t5t3i2J','Louis','Conan','Yates','1992-08-23','Others',3974,4,'morbi.tristique.senectus@Cumsociisnatoque.co.uk','9858385956','Support Staff','131-4106 Proin Av.','Balikpapan','17503','KI'),('O21v3w1d8G','o21s3q0x6D','Evan','Melodie','Pratt','1993-06-09','Male',19810,20,'sem@Donectincidunt.co.uk','9235419068','HR','Ap #103-9718 Velit. St.','Lasbela','966684680','Balochistan'),('O21v6y9z4B','o21y3q3o8G','Amal','Craig','Hoffman','1987-07-08','Others',16020,17,'Aliquam.erat@magna.net','9211875408','HR','361-7155 Tellus. Rd.','Zaragoza','31006','Aragón'),('O21v7n7v2K','o21o9p5y2H','Castor','Macon','Albert','1993-04-19','Female',14910,1,'Etiam.imperdiet@Suspendissealiquet.ca','9181098694','IT','P.O. Box 435, 7157 Libero Road','Palmerston North','79-162','North Island'),('O21w2l7x3E','o21s0g7f7P','Liberty','Leo','Lara','1988-12-28','Others',6657,6,'ornare@nuncQuisque.com','9781672843','Support Staff','5815 Sit Rd.','San Miguel','50665','San José'),('O21w2v7n7Z','o21o8j7v9Y','Wynter','Noel','Pena','1986-09-14','Female',2632,22,'accumsan.laoreet@dictumplacerataugue.ca','9152972962','HR','P.O. Box 621, 5641 Ac Road','Gladstone','584519','Queensland'),('O21w3y9k6D','o21t7m1w2C','Aiko','Joseph','Waters','1987-01-19','Others',10990,5,'hendrerit.Donec@Inscelerisque.com','9406646071','HR','Ap #213-6719 Nullam St.','Kurram Agency','404608','FA'),('O21w4h7v7O','o21r3k6b5C','Caryn','Mari','Rodriquez','1988-08-29','Others',19832,16,'amet@nibhenim.org','9794401646','Support Staff','867-1919 Ante St.','Zuienkerke','NF0R 4SM','WV'),('O21w4p7e6Q','o21t2t4r5S','Beck','Ethan','Owens','1991-03-31','Female',10076,5,'dictum.placerat@nequepellentesque.co.uk','9587905535','HR','725-8966 Ultricies St.','Bornival','87406','Waals-Brabant'),('O21w7j6x0W','o21a2g9e1T','Mariam','Vera','Mcclure','1985-08-16','Others',17703,17,'Vivamus.molestie@enim.org','9771378279','Support Staff','3764 Sed, St.','Suruç','991622493','Şan'),('O21w9t5k3P','o21p3i3c5P','Craig','Kitra','Phelps','1992-04-25','Others',11236,6,'magnis@semPellentesque.org','9774516871','HR','2674 Quam Street','Mercedes','44520','H'),('O21w9w1h9Q','o21b5a8j2D','Austin','Blythe','Wade','1987-08-24','Female',4907,23,'Donec.consectetuer.mauris@perconubia.net','9071355744','Support Staff','Ap #139-5823 Cursus. Ave','Vienna','10609','Wie'),('O21x0t2l7J','o21v4w0q7U','Breanna','Ashton','Weeks','1990-05-24','Female',11618,17,'Nulla.tincidunt.neque@necorci.ca','9929928158','Support Staff','Ap #518-7270 Faucibus. Rd.','Mount Gambier','273263','South Australia'),('O21x1f3n4O','o21n9b8b8S','Nichole','Stuart','Mayer','1989-09-09','Others',5580,22,'pede.Nunc@Sed.co.uk','9593855630','Finance and Accounting','3279 Orci. Rd.','Zamość','184929','Lubelskie'),('O21x2z0k4C','o21q1e7f9A','Keane','Marvin','Gamble','1992-11-27','Male',14631,12,'et.magnis.dis@viverra.org','9581608592','IT','782-4352 Nunc Street','Huelva','98091','AN'),('O21x5c9w6D','o21k5v5l5P','Gay','Angelica','Tyson','1992-06-21','Others',14810,5,'quis.arcu.vel@velitegestaslacinia.com','9846808162','Finance and Accounting','4165 Non St.','Lodhran','Z4964','Sindh'),('O21x6m7a6Q','o21f6p6m7N','Sarah','Vivien','Sears','1987-09-03','Male',11764,18,'dis.parturient.montes@Nullamfeugiat.ca','9227017339','Finance and Accounting','P.O. Box 513, 8779 Dui St.','Probolinggo','4272','East Java'),('O21x7e4w2T','o21v7p7n9U','Ryder','Yetta','Morales','1986-05-07','Female',3216,5,'tempor.augue.ac@habitant.org','9419918699','Support Staff','335-6321 Cras Rd.','Vetlanda','835839','Jönköpings län'),('O21y5i5m5H','o21e6m4c8R','Benedict','Byron','Workman','1991-07-05','Female',14046,10,'pellentesque.Sed@Innecorci.co.uk','9378456474','IT','Ap #751-8570 Convallis Road','Memphis','05486','Tennessee'),('O21y7j0w4Y','o21r8z3t8H','Tobias','Fleur','Wynn','1991-09-24','Female',11363,23,'rhoncus.Donec.est@fermentum.org','9391956132','HR','1821 Rutrum Street','Nandyal','41405','AP'),('O21y8g3s7O','o21r4n5f5L','Len','Kameko','Bonner','1985-11-19','Male',11846,5,'est.mollis@Craseu.net','9002237879','Support Staff','Ap #338-7610 Tempor St.','Paço do Lumiar','53970','Maranhão'),('O21y8y9b3V','o21v4z1q2J','Daria','Thaddeus','Rowe','1993-04-28','Male',14589,18,'Aenean.eget@massaMaurisvestibulum.com','9731915070','Support Staff','P.O. Box 627, 9850 Lorem Rd.','La Pintana','50338','RM'),('O21z4n3d9R','o21b5j0q6H','Ross','Iona','Barnes','1993-01-29','Male',14613,4,'consectetuer@augueidante.ca','9633845601','Finance and Accounting','435-8894 Dui. Ave','Sicuani','41524-171','CUS'),('O21z5o3i5E','o21s5x8h6O','Lysandra','Germaine','Weeks','1990-12-03','Female',5691,9,'commodo.at.libero@intempus.edu','9486713843','IT','Ap #264-9143 Eu Av.','Biała Podlaska','43640-566','LU'),('O21z5q6r7W','o21b4w6z2D','Lillian','Lana','Petty','1991-12-17','Male',12986,11,'iaculis@velit.org','9941529298','Support Staff','P.O. Box 886, 7260 Elementum Rd.','Firozabad','7108','Uttar Pradesh'),('O21z8h9p1E','o21i2d7d6F','Ishmael','Gray','Gallagher','1989-07-20','Male',14264,13,'nec@etmalesuadafames.co.uk','9009982657','HR','401-9326 Tellus Street','Flushing','77538','Zeeland'),('O21z8w5v1X','o21n4k0s6S','Wilma','Phyllis','Gallagher','1993-03-12','Female',19912,25,'dignissim.lacus@massa.net','9470541510','IT','P.O. Box 493, 3711 Arcu Avenue','Berlin','8249 XU','BE');
/*!40000 ALTER TABLE `otherstaff` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-21 22:23:45
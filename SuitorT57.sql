create database Suitor;
use Suitor;

CREATE TABLE `User` (
  `userID` char(10),
  `password` char(8),
   CHECK (length(password) = 8),
  PRIMARY KEY (`userID`)
);

create table `clients`(
	`userID` char(10) NOT NULL,
    PRIMARY KEY (`userID`),
    FOREIGN KEY (`userID`) REFERENCES `User`(`userID`)
);

CREATE TABLE `Opposition` (
  `oppositionID` char(10) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `middleName` varchar(30) DEFAULT NULL,
  `lastName` varchar(30) NOT NULL,
  `emailID` varchar(256) NOT NULL,
  `phoneNumber` char(10) NOT NULL,
  `streetName` varchar(256) NOT NULL,
  `city` varchar(50) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `state` varchar(50) NOT NULL,

  PRIMARY KEY (`oppositionID`)
);


CREATE TABLE `LegalCases` (
  `caseID` char(15) NOT NULL,
  `plaintiff` varchar(256) NOT NULL,
  `lastDateOfActivity` date NOT NULL,
  `flair` varchar(256) NOT NULL,
  `dateOfFiling` date NOT NULL,
  `duration` mediumint NOT NULL,
  `status` varchar(256),
  PRIMARY KEY (`caseID`),
  CHECK (`status` IN ("Won","Active","Lost","Settled"))
);

CREATE TABLE `FinancialTransactions` (
  `transactionID` char(10) NOT NULL,
  `dateOfPayment` date NOT NULL,
  `description` varchar(256) default NULL,
  `amount` mediumint NOT NULL,
  `type` tinyint NOT NULL,
  PRIMARY KEY (`transactionID`),
  CHECK (`amount`!=0),
  CHECK (`type`=0 OR `type`= 1)
);

CREATE TABLE `Calendar` (
  `userID` char(10) NOT NULL,
   `when` datetime not null,
  `description` varchar(256) default NULL,
    PRIMARY KEY (`userID`,`when`),
   FOREIGN KEY (`userID`) REFERENCES `User`(`userID`)
);

CREATE TABLE `ClientCompanies` (
  `userID` char(10) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `middleName` varchar(30) default NULL,
  `lastName` varchar(30) NOT NULL,
  `budget` mediumint NOT NULL,
  `emailID` varchar(256) NOT NULL,
  `phoneNumber` char(10) NOT NULL,
  `streetName` varchar(256) NOT NULL,
  `city` varchar(50) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `state` varchar(50) NOT NULL,
  `isClient` tinyint NOT NULL,
  `fax` varchar(100) default NULL,
  `companyName` varchar(256) NOT NULL,
  `gstIN` varchar(11) default NULL,

  PRIMARY KEY (`userID`),
  foreign key (`userID`) references `clients`(`userID`)
);

CREATE TABLE `CourtHearing` (
  `caseID` char(15) NOT NULL,
  `nextHearingDate` date default NULL,
  `courtRoom` varchar(256) NOT NULL,
  `time` time NOT NULL,
  PRIMARY KEY (`caseID`,`time`),
  FOREIGN KEY (`caseID`) REFERENCES `LegalCases`(`caseID`),
  CHECK (`time` > "09:00" AND `time`< "19:00")
);

CREATE TABLE `IndividualClients` (
  `userID` char(10) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `middleName` varchar(30) default NULL,
  `lastName` varchar(30) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `budget` mediumint NOT NULL,
  `emailID` varchar(256) NOT NULL,
  `phoneNumber` char(10) NOT NULL,
  `streetName` varchar(256) NOT NULL,
  `city` varchar(50) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `state` varchar(50) NOT NULL,
  `isClient` tinyint NOT NULL,
  PRIMARY KEY (`userID`),
foreign key (`userID`) references `clients`(`userID`),
  CHECK (`budget`!=0),
  CHECK (`isClient`=1 or `isClient`= 0)
);


CREATE TABLE `Lawyer` (
  `userID` char(10) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `middleName` varchar(30) DEFAULT NULL,
  `lastName` varchar(30) NOT NULL,

  `dateOfBirth` date NOT NULL,
  `gender` varchar(30) NOT NULL,

  `charges` mediumint NOT NULL,
  `casesWon` mediumint NOT NULL,
  `casesLost` mediumint NOT NULL,
  `casesSettled` mediumint NOT NULL,
  `experience` mediumint NOT NULL,

  `emailID` varchar(256) NOT NULL,
  `phoneNumber` char(10) NOT NULL,
  `positionAtFirm` varchar(100) NOT NULL,

  `avgTimePerCase` mediumint NOT NULL,
  `streetName` varchar(256) NOT NULL,
  `city` varchar(50) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `state` varchar(50) NOT NULL,
  `specialization` varchar(256) NOT NULL,
  `clientRating` mediumint NOT NULL,

  PRIMARY KEY (`userID`,`specialization`),
  FOREIGN KEY (`userID`) REFERENCES `User`(`userID`),
  CHECK (`clientRating`>=0 AND `clientRating`<=10),
  CHECK (`positionAtFirm` IN ("Lawyer","Associate","Paralegal","Partner")),
  CHECK (`charges`>=2000 AND `charges` <= 20000)
);


CREATE TABLE `LegalDocuments` (
 
  `docID` char(10) NOT NULL,
  `caseID` char(15) NOT NULL,
  `createdOn` date NOT NULL,
  `dateLastModified` date NOT NULL,
  `visibility` tinyint NOT NULL,
  `type` varchar(256) NOT NULL,

  PRIMARY KEY (`docID`,`caseID`),
  FOREIGN KEY (`caseID`) REFERENCES `LegalCases`(`caseID`),
  check(`visibility`=0 or `visibility`= 1)
  
);



CREATE TABLE `OtherStaff` (
  `userID` char(10) NOT NULL,
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
  FOREIGN KEY (`userID`) REFERENCES `User`(`userID`),
  CHECK (`positionAtFirm` IN ("HR","PR","Finance and Accounting","IT","Support Staff")),
  CHECK (`salary`>=2000 AND `salary` <= 20000)
);

CREATE TABLE `Against` (
  `oppositionID` char(10) NOT NULL,
  `caseID` char(15) NOT NULL,
  PRIMARY KEY (`oppositionID`,`caseID`),
  FOREIGN KEY (`oppositionID`) REFERENCES `Opposition`(`oppositionID`),
  FOREIGN KEY (`caseID`) REFERENCES `LegalCases`(`caseID`)
);

CREATE TABLE `DisplayedIn` (
  `caseID` char(15) NOT NULL,
  `when` datetime NOT NULL,
  `userID` char(10) not null,
  PRIMARY KEY (`caseID`,`when`,`userID`),
  -- foreign key (`when`) references `Calendar`(`when`),
  foreign key (`userID`,`when`) references `Calendar`(`userID`,`when`),
  foreign key (`caseID`) references `LegalCases`(`caseID`)
);

CREATE TABLE `Handles` (
  `userID` char(10) NOT NULL,
  `caseID` char(15) NOT NULL,
  PRIMARY KEY (`userID`,`caseID`),
  foreign key (`userID`) references `Lawyer`(`userID`),
  foreign key (`caseID`) references `LegalCases`(`caseID`)
);

CREATE TABLE `HasA` (
  `userID` char(10) NOT NULL,
  `caseID` char(15) NOT NULL,
   PRIMARY KEY (`userID`,`caseID`),
   foreign key (`userID`) references `clients`(`userID`),
  foreign key (`caseID`) references `LegalCases`(`caseID`)
);

CREATE TABLE `Invest` (
  `transactionID` char(10) NOT NULL,
  `caseID` char(15) NOT NULL,
  PRIMARY KEY (`transactionID`,`caseID`),
  foreign key (`caseID`) references `LegalCases`(`caseID`),
  foreign key (`transactionID`) references `FinancialTransactions`(`transactionID`)
);


CREATE TABLE `Makes` (
  `userID` char(10) NOT NULL,
  `transactionID` char(10) NOT NULL,
  PRIMARY KEY (`userID`,`transactionID`),
  foreign key (`userID`) references `User`(`userID`),
  foreign key (`transactionID`) references `FinancialTransactions`(`transactionID`)
);


INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21s8i4u0F","Alexis","Darius","Cooke","non.lobortis@Cras.edu","9215916717","4488 Ornare, Avenue","Nuevo Laredo","317554","Tam");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21w0i5r4O","Ulysses","Rina","Lester","Cras.sed@ac.com","9677462721","P.O. Box 245, 5431 Convallis Street","Canoas","86-577","RS");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21a3g2c4H","Basia","Carissa","Maldonado","vitae.posuere.at@Proin.co.uk","9857837096","843-1688 Varius. Rd.","Itagüí","916526","Antioquia");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21o3e9k1P","Kameko","Jennifer","Hester","nunc.ac@ProinultricesDuis.org","9754336189","Ap #571-7342 Eget Road","San Diego","8879","C");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21r6n0u3Z","Sarah","Tatiana","Hutchinson","gravida@nonlaciniaat.edu","9080055151","5388 Nulla. Rd.","Canberra","832740819","Australian Capital Territory");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21t7f1a7H","Chaney","Lee","Nelson","Nulla@Donec.edu","9567461498","752-2447 Donec Ave","Taupo","2051","North Island");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21n9g9g7P","Skyler","Acton","Montgomery","quis.lectus.Nullam@eueros.org","9432323337","4734 Aliquam Rd.","Jönköping","99693","F");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21b0d8t7H","Damian","Angelica","Buchanan","lectus.quis.massa@ut.net","9776646964","P.O. Box 212, 8341 Lorem, Avenue","Vienna","116282","Vienna");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21r7y5r3J","Gisela","Harrison","Short","eu@nislelementum.net","9331610493","3485 In Avenue","Lagos","1528","LA");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21b2y0y9N","Scott","Garth","Henry","Donec.elementum.lorem@risusDonecegestas.ca","9242452535","3949 Ligula. Street","Awaran","T4 1WO","BL");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21n6a1s3S","Benedict","Abraham","Langley","at@pellentesque.co.uk","9277860766","Ap #699-5020 Mauris Road","Soissons","7144","PI");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21a3i9t1S","Scott","Renee","Gardner","magna@ullamcorper.ca","9948799799","879-1924 Laoreet Av.","Palopo","03759","SN");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21y0x1n5E","Quinn","Patricia","Duffy","ultricies.sem.magna@utdolor.ca","9352079994","557 Eget, St.","Burhaniye","544941","Bakesir");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21v9o3w3S","Adrienne","Farrah","Hunter","laoreet.ipsum@nuncrisusvarius.org","9098908479","Ap #133-5892 Consequat St.","Renca","97119","Metropolitana de Santiago");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21k0h3y3I","Janna","Dorian","Ramos","lobortis.Class@tinciduntadipiscingMauris.co.uk","9707129421","Ap #202-4511 Mauris St.","Cholet","98-350","Pays de la Loire");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21f6z7t6Z","Murphy","Levi","Patton","Integer.vulputate@accumsanconvallisante.org","9407818454","P.O. Box 898, 9230 Mus. St.","Eisenstadt","633250","Burgenland");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21y1q2b1E","Alexandra","Madeson","Gilbert","et.commodo@magna.ca","9122390901","P.O. Box 615, 6059 Et, Ave","Kano","94679","KN");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21t1s1o7C","Ashton","Abbot","Blackburn","non@Quisquenonummy.net","9491052926","619-5854 Justo St.","Port Harcourt","213114","RI");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21p5r7u3H","Tucker","Sade","Contreras","sagittis@id.com","9099426552","Ap #799-6140 Eu Street","Abbottabad","921774","KPK");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21x7w7i6V","Hasad","Hall","Blackburn","consectetuer.ipsum@vulputate.edu","9181122466","P.O. Box 582, 2809 Felis Ave","Beauvais","6130","Picardie");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21a0d3d3Z","Emma","Cooper","Britt","Curabitur.egestas@blandit.com","9325422946","6675 Quisque Street","Strombeek-Bever","20003","Vlaams-Brabant");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21z9v2s8S","Audra","Stephen","Baxter","eu@iaculisquis.net","9872566871","P.O. Box 425, 3924 Lorem Street","Dublin","8811","Leinster");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21t5g4s9I","Len","Quentin","Holloway","ut.sem@dolorQuisquetincidunt.net","9531025815","Ap #768-3663 Proin St.","Hulst","5397 KG","Zl");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21a1d1s6J","Zia","Kirby","Mccarty","Integer@Aliquam.net","9572534155","P.O. Box 115, 9915 In St.","Montluçon","163414","AU");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21u2x3l2K","Indira","Perry","Mcmillan","nascetur@velpedeblandit.ca","9477532197","Ap #924-4079 Sit Rd.","Wilmont","15055","ON");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21i5g9s5X","Herman","Wyoming","Decker","leo.elementum.sem@acipsum.org","9634241382","9117 Quam. Rd.","Astore","549164","Gilgit Baltistan");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21h1a3y2R","Lenore","Dawn","Suarez","ultrices@Maecenas.edu","9348598740","P.O. Box 475, 2159 Feugiat. Street","Belfast","86370","U");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21c4i4j3K","Melodie","Wesley","Howe","urna.suscipit@nisi.edu","9325622333","P.O. Box 636, 5305 Condimentum St.","Guadalajara","J6Y 9E0","Jal");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21l2n4w4U","Skyler","Ria","Watts","Pellentesque@purussapien.org","9367916714","Ap #810-8029 Nibh Avenue","Ikot Ekpene","Z8861","Akwa Ibom");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21k1u7g3H","Brianna","Miriam","Tate","massa.non.ante@facilisis.net","9054468460","9793 Semper Rd.","Owen Sound","3736","ON");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21b5j1g2F","Travis","Britanney","Dorsey","nec.ante.blandit@aliquet.com","9808438652","1192 Nibh Road","Gdask","132925","delhi");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21x4y9j5E","Baxter","Lenore","Pennington","enim@mifelis.edu","9770223830","P.O. Box 667, 4741 Mollis Street","Bacabal","Z5006","MA");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21f2o7f3Y","Lael","Montana","Garcia","quis.pede.Praesent@lacuspede.ca","9546434413","163-988 Egestas Rd.","Muzaffargarh","J9 5OI","PU");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21s2y6d2Y","Bert","Castor","Cross","Donec.egestas@sed.org","9796082431","1498 Litora St.","Los Ángeles","XN5I 2LR","VII");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21z4d9u4R","Grace","Gisela","Oneal","eleifend.nec@pharetraut.org","9851461525","P.O. Box 108, 6758 Aliquet, Avenue","Galway","7207","C");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21c8t0e0L","Uriel","Basia","Anderson","sapien@quis.net","9377012153","2376 Vitae, St.","Cañas","34639-930","Guanacaste");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21d0l9d3L","Julian","Uriel","Black","a@dolor.org","9705301359","349 Quis, Road","Söderhamn","28499","X");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21j5q4k5A","Charlotte","Amal","Carpenter","ac@dictumeuplacerat.co.uk","9896808771","701-8646 Ligula. Rd.","Galashiels","1775 DT","SE");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21d4j5n6R","Summer","Kameko","Brennan","iaculis@mollis.ca","9121366254","474-5302 Tincidunt Rd.","Curitiba","682587","Paraná");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21q8k6c1N","Abigail","Barclay","Koch","non@egetlacusMauris.edu","9256789798","696-7573 A St.","Weesp","92287","Noord Holland");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21e5g5j3R","Alec","Ariana","Sanders","Vivamus@Integeridmagna.ca","9514785205","P.O. Box 188, 4721 Laoreet, Street","San José","32984","SJ");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21i2x4w8P","Whoopi","Stacy","Norton","est@lacus.com","9374104340","Ap #374-1859 Phasellus Av.","Placanica","925469","Calabria");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21i3e4t4E","Lois","Emi","Ochoa","mi@ligulaelitpretium.edu","9338890636","793-8299 Dignissim. Ave","Wyoming","Z4685","WY");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21n1l8v4I","Leila","Hayes","Rosa","Sed@imperdietornare.co.uk","9597182797","181-7305 Vivamus Rd.","Purral","697879","SJ");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21z9h7r0W","Gregory","Randall","Maxwell","feugiat@ullamcorperDuisat.edu","9969920661","374-1703 Interdum. St.","Hervey Bay","97658","QLD");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21x2r1b2P","Maisie","Thane","Keller","Donec.consectetuer.mauris@feugiatLorem.ca","9801315300","Ap 503-8404 Dictum Rd.","Moe","7705610","Victoria");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21z0f1m3M","Colin","Derek","Holmes","nec.tellus@convallisconvallisdolor.edu","9476952294","547-6213 Facilisis Rd.","poooe","61913","LD");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21h4o6e4O","Rhoda","Yetta","Fitzgerald","egestas.blandit.Nam@eratVivamus.edu","9059483826","P.O. Box 544, 729 Neque. Ave","Leticia","06352","AMA");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21z3i0b2N","Blythe","Aristotle","Foster","faucibus.orci@Donec.org","9969261552","P.O. Box 456, 6913 Fringilla Road","Vienna","120246","Vienna");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21r2f0z7Y","Aurelia","Maya","Morgan","mi@nascetur.co.uk","9611163750","P.O. Box 476, 5661 Euismod Rd.","Patarr","34913","San Jos");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21r4i0b4M","Mariko","Darius","Rocha","quam@netus.co.uk","9553551761","Ap #725-4274 Blandit Rd.","Fochabers","FB94 5HT","Morayshire");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21b8i7m4L","Shea","Sharon","Lopez","magna.a.tortor@Etiamligula.com","9583315603","Ap #268-6377 Morbi Road","Lasnigo","621652","LOM");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21h3t3h7L","Neville","Amos","Farmer","Pellentesque.ultricies@turpisnecmauris.net","9794488514","188-8783 Primis Av.","Karacabey","9844","Bur");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21p4w0k8B","Kadeem","Kristen","Sykes","Vivamus.sit.amet@ornare.edu","9606219691","624-3930 Luctus Av.","Mau","398501","So Paulo");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21v1y1a5Z","Quinn","Pearl","Maynard","ut.odio@tinciduntorciquis.net","9791974585","4407 Phasellus Ave","Balfour","70821","OK");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21u1i8d2N","Odessa","Karleigh","Hood","consequat.purus.Maecenas@nostraperinceptos.net","9003187180","5024 Vitae Road","Russell","89673","ON");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21z9w9i6J","Brenden","Kylie","Woodward","Fusce.mi.lorem@auctorodioa.com","9074581350","801-3973 Nunc Road","Loughborough","06591","Leicestershire");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21e6v8d9I","Teegan","Cedric","Bass","interdum@SuspendisseduiFusce.ca","9221744877","P.O. Box 457, 5422 Nunc St.","Camaari","775034","Bahia");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21r9h9b3M","Xerxes","Yvonne","Woodward","semper@Loremipsum.ca","9207741130","P.O. Box 945, 1694 Mollis Rd.","Mielec","2916","Podkarpackie");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21t3e1l5E","Mia","Levi","Knight","eleifend@lacus.edu","9669261492","2786 Malesuada. Road","Chilpancingo","61804","Gro");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21m0p9v7T","Rana","Kelly","Fields","blandit@utsem.org","9536519401","772-4528 Turpis Avenue","Göteborg","347282","O");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21z1a1q3I","Thaddeus","May","Hunt","Nunc.ut.erat@Mauriseuturpis.edu","9220255248","P.O. Box 926, 4662 Nec, Avenue","Tucson","17602","Arizona");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21l5i8g2Z","Jane","Madonna","Huffman","odio.tristique.pharetra@imperdiet.com","9599903094","9248 Semper, Street","Omsk","06507","Omsk Oblast");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21h5a1d3Q","Blake","Lydia","Holloway","Ut.tincidunt.orci@Aeneanegetmetus.com","9478679503","Ap #531-3228 Nonummy. Rd.","Bergama","6858","zm");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21j1y7z0D","Jackson","Willow","Burris","non.lacinia@nondapibusrutrum.net","9401011169","2703 Eu, Street","San Juan del Ro","15345","Qro");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21b9d5g2B","Jamal","Leah","Snyder","inceptos@nequeNullam.net","9446518325","Ap #847-8910 Nulla St.","Badajoz","372880","EX");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21r7z5e1E","Keiko","Josiah","Morrison","Nulla.aliquet@Donecdignissim.com","9632144817","Ap #945-4775 Duis Avenue","Gorzw Wielkopolski","520482","Lubuskie");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21g1u4a5N","Clark","Neil","Gonzalez","dolor@Curabiturdictum.edu","9573049178","790-3403 Lacus. Rd.","Södertälje","3325","AB");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21n2u6k4C","Germaine","Belle","Wade","netus@ametmassaQuisque.co.uk","9743102368","169-7109 Metus Avenue","Creil","362428","PI");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21j8f1h9A","Sandra","Martena","Trevino","at@Utsemper.net","9668034420","P.O. Box 524, 903 Etiam Rd.","Forbach","8588","Lorraine");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21l1l0j3O","Flavia","Chadwick","Wolf","velit.Cras.lorem@Aliquam.edu","9834614288","P.O. Box 291, 8933 Mus. Street","Vallentuna","25-778","AB");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21w0u2p4H","Macy","Edward","Cline","tristique.pellentesque@malesuada.ca","9273933426","9794 Eu Avenue","Camaragibe","25253","PE");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21o9a8v2K","Mercedes","Marshall","Miranda","lobortis.tellus@sociisnatoquepenatibus.com","9865113328","P.O. Box 902, 8054 At Street","Kitchener","1242","Ontario");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21w0o9b5E","Amir","Cheyenne","Knapp","quam.dignissim.pharetra@nasceturridiculus.com","9683711215","5350 Lectus. St.","Starachowice","457747","SK");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21u7b4h4V","India","Hadassah","Carver","amet.ante.Vivamus@loremvitaeodio.net","9768669794","P.O. Box 526, 6153 Et Ave","Doel","153684","Oost-Vlaanderen");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21a6t6h9C","Ann","Suki","Gaines","eleifend.egestas@odiosagittissemper.net","9037275600","665-4605 Felis. Road","Yeosu","30864","Jeo");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21v2b0x1J","Chaney","Mollie","Potts","at.iaculis@bibendumsed.co.uk","9869040336","1366 Morbi Avenue","Sandy","5195063","BD");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21q8w5q8C","Sheila","Declan","Galloway","id@facilisiSed.net","9492770358","337-3561 Commodo Avenue","Pachuca","1249 BP","Hidalgo");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21o6x3o8M","Nora","Zena","Jimenez","Praesent.luctus@antebibendumullamcorper.ca","9930857541","P.O. Box 793, 1942 Consectetuer Rd.","Port Pirie","0782408","South Australia");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21w4r3y9Q","Jesse","Cullen","Lara","Ut.tincidunt@vitaemaurissit.org","9287456612","Ap #882-6686 Sodales Street","Belfast","5683","Ulster");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21a6n1g9K","Colin","Allen","Welch","semper.rutrum@mauriseu.ca","9160509051","P.O. Box 120, 7600 Imperdiet St.","Incheon","11415","Gye");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21d2a8k0A","Orli","Nyssa","Chavez","In.mi@non.com","9091001641","788-4866 Mauris Avenue","Istanbul","73789","Ist");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21q3d5m9C","Kibo","Hiroko","Mcintyre","Donec.est.Nunc@Proin.net","9818376193","326-7371 Et Rd.","Logroño","43138","LR");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21u4z5m9Q","Sandra","Tarik","Burns","a@sedturpisnec.org","9994528677","Ap #195-3102 Vel Ave","Envigado","38996","Antioquia");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21c7t2e1Z","Alyssa","Cleo","Burks","dui.Suspendisse.ac@urna.net","9465354584","5981 Cursus Road","Vancouver","427323","WA");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21e3c9u8V","Ignatius","Myra","Burris","pharetra@pedenecante.org","9389080913","Ap #599-7564 Pharetra. Road","Yurimaguas","86379","Loreto");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21e1g2g9S","Todd","Silas","Willis","Quisque.ac.libero@auctorvitaealiquet.net","9929844583","P.O. Box 509, 7167 Nam Road","Depok","FI10VP","West Java");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21n1j0k7N","Colin","Stella","Walter","nec@mollis.co.uk","9048381213","P.O. Box 680, 5352 Massa St.","Armadale","1490","Western Australia");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21t0m7e9K","Shaine","Reese","Chandler","per.inceptos@idanteNunc.ca","9733970930","Ap #341-3891 Eu Av.","Uberlândia","57571","Minas Gerais");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21a9j4c4M","Leandra","Lucas","Peters","Cras@Loremipsum.ca","9923774959","Ap #581-9919 Sed Rd.","Balsas","89346","MA");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21e3k4b1T","Elton","Alexa","Ramos","non.lobortis@Quisqueornaretortor.edu","9322110838","1814 Nam Av.","Cuautla","509558","Mor");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21p2h9q8P","Lee","Jakeem","Ayers","ridiculus.mus.Proin@Suspendissealiquet.com","9528886887","Ap #341-4870 Lorem, St.","Comano","223250","TOS");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21p7c7x2Q","Declan","Juliet","Hughes","eget.magna@Aliquam.com","9837522338","8840 Blandit Rd.","Kano","2275 ER","Kano");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21v7u5f0T","Pandora","Darius","Ramirez","parturient.montes.nascetur@vestibulum.edu","9521656668","P.O. Box 751, 5251 Semper Ave","Livin","8687","NO");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21i4t7u0H","Penelope","Lysandra","Estes","a.odio@lobortisnisinibh.edu","9741028160","P.O. Box 992, 9705 Ultrices. Rd.","Hamburg","99332","HH");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21n3r8p8P","Colt","Malachi","Alvarado","lobortis.Class@molestietortornibh.edu","9221908338","9374 Massa. Road","Sapele","6029","Delta");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21o7d9g6X","Venus","Holmes","Bishop","non@ami.com","9786300355","P.O. Box 445, 2485 Donec Rd.","Palmerston North","31876","North Island");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21s0t8f2R","Lillith","Hyatt","Wise","Pellentesque@ut.edu","9552675071","9266 Ligula. Rd.","Hafizabad","52771","Punjab");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21k8c9r2J","May","Karyn","Carr","aliquet.lobortis@Pellentesquetincidunt.org","9740826117","P.O. Box 611, 4286 Cursus, Rd.","Columbia","830741","Missouri");
INSERT INTO `Opposition` (`oppositionID`,`firstName`,`middleName`,`lastName`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`) VALUES ("T21r7s8q4T","Brody","Walter","Vinson","Morbi.non.sapien@sed.ca","9648586600","9422 Enim. Rd.","Matamata","823323","NI");

INSERT INTO `User` (`userID`,`password`) VALUES ("A21r4a1b6X","Z54#76kS");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21a7z0h2V","Z54#71rM");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21u5w0u4X","B54#77pX");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21j6o5f1F","J54#74iR");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21k2l6c5D","E54#78nW");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21d1o5j7F","K54#75dO");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21y0e3o6E","S54#76iX");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21e4d9u7O","B54#72pS");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21i6h2v4R","Y54#79xM");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21u4f4u7F","J54#71vZ");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21k9e0m9D","F54#76iC");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21x6i8r4X","B54#79oX");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21b7y0r2S","H54#79sD");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21u5j4l6F","F54#72lG");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21t8y1o3Z","A54#75iJ");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21n6o6k0N","S54#73bN");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21a0f5x5M","N54#71hR");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21h9m7x7T","B54#70hV");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21s9n5a5A","U54#70mR");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21v1p2x4V","C54#77tM");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21q7h0u0E","B54#70dP");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21t0s5w9W","Q54#76zQ");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21c9u5e3I","M54#79vP");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21m3s3v7H","Q54#72xN");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21n2c2u6B","C54#73iU");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21e0f5s5Z","E54#74hC");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21g0p1y1W","F54#77qB");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21n8n7m3C","X54#79rE");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21y0y7o4V","Q54#73cF");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21p8y2h4F","A54#78pD");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21l5x6o0T","Q54#72lC");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21r8g4t8B","M54#77mM");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21x5n7u2H","M54#72gG");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21y6d3d4X","K54#78fE");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21x1j9n0G","N54#71bM");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21k7w6w1Y","O54#72xI");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21a3c6t8L","M54#79yK");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21y2r4m4Q","V54#79zE");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21u9i4t8B","H54#76mU");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21u8d9m8Y","R54#71hE");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21u2k4c8X","O54#78dX");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21r5r4s7U","U54#78iT");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21z0c9m4N","P54#78zN");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21s1c6q8Z","L54#72bH");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21v4l9p0Q","F54#78dH");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21u6a1c4F","W54#77zB");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21b3w5m9Q","C54#70qT");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21z1d3m8Y","K54#73lN");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21n7e0v3D","B54#71bC");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21n8x4f7G","P54#75pB");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21f7g3c6N","I54#74aT");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21d7o8k9T","H54#73gG");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21a0i6w2G","V54#77oW");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21v4u3c1K","X54#79jY");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21e3b3o7Z","Y54#78tL");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21j1c2w5C","M54#77oA");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21h1m1b0M","M54#71sI");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21x3j8o9E","A54#75fN");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21b0t8q7E","F54#72kW");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21t2x4l5I","F54#71vM");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21i4c5r8L","C54#76qU");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21f0n5l0W","K54#78iD");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21k9z5q4T","S54#77mW");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21u6p6n2J","J54#72bH");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21d2z8u6O","F54#76pP");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21d4r1a5W","J54#79vH");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21x5a3h1J","I54#79tN");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21i1n3b8G","V54#71fR");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21e2l1i9S","Y54#78hG");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21t9w6j2G","J54#70oC");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21h0j8b3J","F54#70vY");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21m5g0b7G","P54#75uG");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21y1k7z8W","Z54#72vW");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21z4z2o0M","Q54#75lZ");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21n5e0z5U","H54#75eA");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21a0o0l9O","O54#76dI");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21x0l7q4S","G54#72rF");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21y2c7g1O","D54#73jG");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21j0j0n6W","E54#77zI");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21w5h8h6Q","U54#71mU");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21i0j5n0F","D54#70mL");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21m6q9t6G","D54#74hI");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21r5s1h8J","V54#76rI");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21f4o7b3D","A54#79dW");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21j2f9t3H","L54#76oD");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21q2y9a5U","V54#79lR");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21e4g0t3P","O54#79hK");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21q4u5j5R","L54#79aM");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21v9l9b5R","F54#74cA");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21f3z4r8N","S54#73bV");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21a4v0i1Q","K54#75kV");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21y6i1e7R","Q54#77uE");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21e8f7u0L","O54#70zB");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21c6b7c7Y","T54#72qI");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21e6a6z1Q","A54#77yC");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21u3y0f3W","E54#71kT");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21q3f9a9V","E54#76xG");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21i0s6r4L","U54#76wM");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21l9o8k0W","B54#72qT");
INSERT INTO `User` (`userID`,`password`) VALUES ("A21n1q5a5G","U54#71hB");

INSERT INTO `User` (`userID`,`password`) VALUES ("Y21o6z6w7G","Z54#76kS");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21z3g0u2J","Z54#71rM");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21v8e5b1X","B54#77pX");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21g1p3c3G","J54#74iR");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21e8x0n9D","E54#78nW");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21f7a6o4B","K54#75dO");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21x5j6p6T","S54#76iX");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21p5s5v4O","B54#72pS");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21x8e8x9N","Y54#79xM");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21t1o7o9Y","J54#71vZ");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21u7j9u8C","F54#76iC");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21o8j6m5Q","B54#79oX");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21u6h9a9Z","H54#79sD");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21i6v7v5D","F54#72lG");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21f3d4t5C","A54#75iJ");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21k1f0p1V","S54#73bN");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21l4d5v4P","N54#71hR");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21r7i5k7R","B54#70hV");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21k3r5r6E","U54#70mR");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21o9s5h1I","C54#77tM");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21g2u0t9Q","B54#70dP");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21n9p1n2F","Q54#76zQ");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21m0a3t8V","M54#79vP");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21z5h8a7E","Q54#72xN");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21w3k2x5I","C54#73iU");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21h1p8s3U","E54#74hC");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21v7m0z9X","F54#77qB");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21w7j4f7F","X54#79rE");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21f4u5j8O","Q54#73cF");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21b5m3m0U","A54#78pD");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21b7o0o9M","Q54#72lC");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21m1v3d6V","M54#77mM");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21b8b3x3G","M54#72gG");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21f0u7q2E","K54#78fE");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21i4m5b5E","N54#71bM");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21s4k5g0B","O54#72xI");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21u1z9w6E","M54#79yK");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21z1u4z4R","V54#79zE");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21p3z1w6U","H54#76mU");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21r2g8t4N","R54#71hE");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21f2g0i1C","O54#78dX");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21i0f8z5U","U54#78iT");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21q7j8b9V","P54#78zN");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21s4p0h3F","L54#72bH");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21u0h0r1H","F54#78dH");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21l5f9r2T","W54#77zB");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21q5y2g9O","C54#70qT");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21c0c7t0F","K54#73lN");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21b3t3d4I","B54#71bC");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21f0b1b9W","P54#75pB");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21b0m9k9L","I54#74aT");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21a9z7t6R","H54#73gG");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21b4v1r9B","V54#77oW");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21b5j1d7H","X54#79jY");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21g5x5u9X","Y54#78tL");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21f9g6q6I","M54#77oA");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21r5t3v1Y","M54#71sI");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21b2c5s5X","A54#75fN");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21k8t2u9D","F54#72kW");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21m6p8s3I","F54#71vM");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21z5f7v5T","C54#76qU");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21i8q5y1K","K54#78iD");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21o9o2w6C","S54#77mW");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21u4a5y5V","J54#72bH");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21a4p1j5G","F54#76pP");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21l6k2n1L","J54#79vH");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21d8k6f2D","I54#79tN");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21m1b5d7H","V54#71fR");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21x8n6z9E","Y54#78hG");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21z6i9d6D","J54#70oC");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21c6m6e7X","F54#70vY");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21r8v6d0F","P54#75uG");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21p8o6k8V","Z54#72vW");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21p1m4i0V","Q54#75lZ");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21w4s1x4S","H54#75eA");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21y5a3i5J","O54#76dI");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21g8j8y7M","G54#72rF");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21v5s0t5X","D54#73jG");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21j1t2r0Y","E54#77zI");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21t6w4j0J","U54#71mU");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21q3s6c7X","D54#70mL");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21f9q5j0G","D54#74hI");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21k4o5w6C","V54#76rI");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21o2k5g2F","A54#79dW");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21a2h5f8J","L54#76oD");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21g2n6i0Z","V54#79lR");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21g2y7g1G","O54#79hK");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21r1y3d2A","L54#79aM");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21d5s7g0D","F54#74cA");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21p9a1c3B","S54#73bV");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21a9z0f5X","K54#75kV");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21d7k9b9B","Q54#77uE");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21p8v0o4G","O54#70zB");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21z8m7k6X","T54#72qI");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21w4b1d7E","A54#77yC");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21h5m5s3X","E54#71kT");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21g1s2d4W","E54#76xG");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21s2l2g2Y","U54#76wM");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21u6q9o1X","B54#72qT");
INSERT INTO `User` (`userID`,`password`) VALUES ("Y21b0a2b3T","U54#71hB");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21a6v1n3Y","Z54#76kS");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21m2s2j0X","Z54#71rM");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21p1o3m0I","B54#77pX");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21n7x7k6Q","J54#74iR");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21r0k0b4G","E54#78nW");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21l6n1r5O","K54#75dO");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21b0f1b7U","S54#76iX");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21e0m3b2H","B54#72pS");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21n8n8x4L","Y54#79xM");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21a3c7b9V","J54#71vZ");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21l4l2z2V","F54#76iC");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21n3q8z0T","B54#79oX");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21g4q3a0C","H54#79sD");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21e8r0w4U","F54#72lG");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21g6a1t9M","A54#75iJ");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21c1i0m8G","S54#73bN");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21t2r5i9L","N54#71hR");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21a8r5z0R","B54#70hV");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21b8x7f7C","U54#70mR");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21f9d1v3S","C54#77tM");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21t0z0b6C","B54#70dP");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21k2i4s0M","Q54#76zQ");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21e5c5u5T","M54#79vP");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21h2l3h4T","Q54#72xN");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21w7w4s5D","C54#73iU");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21q1o1x3V","E54#74hC");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21q9k1o6D","F54#77qB");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21s9s9l4W","X54#79rE");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21q1y3p1B","Q54#73cF");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21s2t1t0M","A54#78pD");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21x3a1i3J","Q54#72lC");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21l5k8x1E","M54#77mM");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21o4j8t5J","M54#72gG");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21j4c1z0G","K54#78fE");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21d6h1k4S","N54#71bM");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21j0i9h1D","O54#72xI");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21d1s2k3T","M54#79yK");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21b1t4v6Y","V54#79zE");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21q0l7k2S","H54#76mU");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21o5t8k4S","R54#71hE");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21d8u1g3F","O54#78dX");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21m0m8e1V","U54#78iT");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21p9t3c7R","P54#78zN");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21h2u9c3D","L54#72bH");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21a0l0g1L","F54#78dH");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21l7l3r4Q","W54#77zB");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21h9y4d8L","C54#70qT");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21p5a6t2C","K54#73lN");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21g2z8f6O","B54#71bC");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21i2l7f5H","P54#75pB");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21q7x2g1S","I54#74aT");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21i8x8f6M","H54#73gG");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21l0r9l3V","V54#77oW");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21n5q6a4D","X54#79jY");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21c9w4e5V","Y54#78tL");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21r1z4k2D","M54#77oA");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21p6v9u4N","M54#71sI");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21n7y2f4X","A54#75fN");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21f7c9s5M","F54#72kW");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21d1n4r9Z","F54#71vM");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21z2k0g2Z","C54#76qU");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21g3m9s7I","K54#78iD");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21z3e6c2F","S54#77mW");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21u0o9p4S","J54#72bH");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21s7j5a6V","F54#76pP");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21j2n0e0U","J54#79vH");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21j8o1a3G","I54#79tN");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21l8p2s9M","V54#71fR");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21c5y3b3D","Y54#78hG");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21i1b1u3K","J54#70oC");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21a5f4z0X","F54#70vY");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21x9j6r5J","P54#75uG");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21s9w5f1N","Z54#72vW");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21p6r5h3T","Q54#75lZ");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21h9a5z8Y","H54#75eA");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21y1u2m4V","O54#76dI");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21z2d7c5Q","G54#72rF");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21o1f7t9Z","D54#73jG");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21b7l9f4G","E54#77zI");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21o0p9v2G","U54#71mU");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21j0t6i5Q","D54#70mL");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21r0h1t2L","D54#74hI");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21i8g8k3M","V54#76rI");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21z1v3d9J","A54#79dW");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21i1d0e4O","L54#76oD");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21x8u8t1N","V54#79lR");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21h2g2o2Z","O54#79hK");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21o2l9d5N","L54#79aM");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21b5c7q0B","F54#74cA");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21f2w0f2G","S54#73bV");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21e6i6i6N","K54#75kV");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21p9e2x7Z","Q54#77uE");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21o0f4s7Z","O54#70zB");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21z8z0v1D","T54#72qI");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21j1a5t0U","A54#77yC");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21l8k8k9L","E54#71kT");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21y2q1v1W","E54#76xG");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21i3i4o2O","U54#76wM");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21d3y2f0U","B54#72qT");
INSERT INTO `User` (`userID`,`password`) VALUES ("I21r6i4t5D","U54#71hB");

INSERT INTO `User` (`userID`,`password`) VALUES ("O21p5y3f5D","Z54#76kS");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21r2w6l9I","Z54#71rM");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21a5i1p3G","B54#77pX");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21o8k1i4G","J54#74iR");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21x7e4w2T","E54#78nW");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21g0i7i1G","K54#75dO");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21l5g2g3Z","S54#76iX");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21h3b8f0C","B54#72pS");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21m6r1f4E","Y54#79xM");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21b1l4d4S","J54#71vZ");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21y8y9b3V","F54#76iC");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21s9b2l5A","B54#79oX");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21q7l2z3D","H54#79sD");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21r9a5l9H","F54#72lG");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21w3y9k6D","A54#75iJ");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21o7m0a5J","S54#73bN");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21t1k5q5Q","N54#71hR");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21h1t2w5O","B54#70hV");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21m4j7j5T","U54#70mR");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21y5i5m5H","C54#77tM");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21f1z8c5E","B54#70dP");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21x5c9w6D","Q54#76zQ");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21p2p6d4C","M54#79vP");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21q8e3x6V","Q54#72xN");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21a0b2d6K","C54#73iU");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21w4h7v7O","E54#74hC");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21f4d0v9S","F54#77qB");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21w7j6x0W","X54#79rE");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21h2a5d0O","Q54#73cF");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21n3s6j3T","A54#78pD");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21s8l2h5B","Q54#72lC");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21g1d1q3S","M54#77mM");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21t0o1g1I","M54#72gG");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21i3u6f4B","K54#78fE");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21x6m7a6Q","N54#71bM");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21y7j0w4Y","O54#72xI");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21t3s8p0V","M54#79yK");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21c7b3y8G","V54#79zE");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21h8b8o6W","H54#76mU");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21i2h1o4T","R54#71hE");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21r4y8d8Y","O54#78dX");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21u2s1j5K","U54#78iT");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21z5q6r7W","P54#78zN");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21o9z6q5L","L54#72bH");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21q1t2t9W","F54#78dH");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21f2n5h8B","W54#77zB");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21x1f3n4O","C54#70qT");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21p5d4e7K","K54#73lN");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21r1m3c3W","B54#71bC");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21b8m5o5E","P54#75pB");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21q1q9n8K","I54#74aT");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21n9t7q9A","H54#73gG");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21v7n7v2K","V54#77oW");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21x0t2l7J","X54#79jY");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21z8w5v1X","Y54#78tL");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21b9f9x9S","M54#77oA");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21j7l0e7H","M54#71sI");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21i2c9d7A","A54#75fN");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21t4p5f6V","F54#72kW");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21j6c6y3S","F54#71vM");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21z4n3d9R","C54#76qU");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21q9d9g4F","K54#78iD");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21b7i0p5B","S54#77mW");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21w9w1h9Q","J54#72bH");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21w9t5k3P","F54#76pP");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21h8j2h4K","J54#79vH");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21w2l7x3E","I54#79tN");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21q1z0r4I","V54#71fR");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21k4g9j2B","Y54#78hG");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21n9a9q4Q","J54#70oC");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21v3r4f1U","F54#70vY");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21b8c9o1N","P54#75uG");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21p6y7u3O","Z54#72vW");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21i2k6s6M","Q54#75lZ");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21w4p7e6Q","H54#75eA");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21q0j8r6P","O54#76dI");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21x2z0k4C","G54#72rF");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21w2v7n7Z","D54#73jG");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21c7q8w4J","E54#77zI");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21k0w5h9T","U54#71mU");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21y8g3s7O","D54#70mL");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21i4b6a8B","D54#74hI");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21c7m6t7G","V54#76rI");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21i1v0p4N","A54#79dW");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21t5q2x4T","L54#76oD");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21z8h9p1E","V54#79lR");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21h7t4w7A","O54#79hK");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21i1b8h8M","L54#79aM");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21z5o3i5E","F54#74cA");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21s3s8e7A","S54#73bV");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21v6y9z4B","K54#75kV");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21d5t0b1S","Q54#77uE");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21b7n1v0N","O54#70zB");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21k9t9k6Z","T54#72qI");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21e9q0v2C","A54#77yC");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21k8r2r6T","E54#71kT");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21v3w1d8G","E54#76xG");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21h1t2h9X","U54#76wM");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21m7b7y6G","B54#72qT");
INSERT INTO `User` (`userID`,`password`) VALUES ("O21f1d3n8D","U54#71hB");

INSERT INTO `clients` (`userID`) VALUES ("Y21o6z6w7G");
INSERT INTO `clients` (`userID`) VALUES ("Y21z3g0u2J");
INSERT INTO `clients` (`userID`) VALUES ("Y21v8e5b1X");
INSERT INTO `clients` (`userID`) VALUES ("Y21g1p3c3G");
INSERT INTO `clients` (`userID`) VALUES ("Y21e8x0n9D");
INSERT INTO `clients` (`userID`) VALUES ("Y21f7a6o4B");
INSERT INTO `clients` (`userID`) VALUES ("Y21x5j6p6T");
INSERT INTO `clients` (`userID`) VALUES ("Y21p5s5v4O");
INSERT INTO `clients` (`userID`) VALUES ("Y21x8e8x9N");
INSERT INTO `clients` (`userID`) VALUES ("Y21t1o7o9Y");
INSERT INTO `clients` (`userID`) VALUES ("Y21u7j9u8C");
INSERT INTO `clients` (`userID`) VALUES ("Y21o8j6m5Q");
INSERT INTO `clients` (`userID`) VALUES ("Y21u6h9a9Z");
INSERT INTO `clients` (`userID`) VALUES ("Y21i6v7v5D");
INSERT INTO `clients` (`userID`) VALUES ("Y21f3d4t5C");
INSERT INTO `clients` (`userID`) VALUES ("Y21k1f0p1V");
INSERT INTO `clients` (`userID`) VALUES ("Y21l4d5v4P");
INSERT INTO `clients` (`userID`) VALUES ("Y21r7i5k7R");
INSERT INTO `clients` (`userID`) VALUES ("Y21k3r5r6E");
INSERT INTO `clients` (`userID`) VALUES ("Y21o9s5h1I");
INSERT INTO `clients` (`userID`) VALUES ("Y21g2u0t9Q");
INSERT INTO `clients` (`userID`) VALUES ("Y21n9p1n2F");
INSERT INTO `clients` (`userID`) VALUES ("Y21m0a3t8V");
INSERT INTO `clients` (`userID`) VALUES ("Y21z5h8a7E");
INSERT INTO `clients` (`userID`) VALUES ("Y21w3k2x5I");
INSERT INTO `clients` (`userID`) VALUES ("Y21h1p8s3U");
INSERT INTO `clients` (`userID`) VALUES ("Y21v7m0z9X");
INSERT INTO `clients` (`userID`) VALUES ("Y21w7j4f7F");
INSERT INTO `clients` (`userID`) VALUES ("Y21f4u5j8O");
INSERT INTO `clients` (`userID`) VALUES ("Y21b5m3m0U");
INSERT INTO `clients` (`userID`) VALUES ("Y21b7o0o9M");
INSERT INTO `clients` (`userID`) VALUES ("Y21m1v3d6V");
INSERT INTO `clients` (`userID`) VALUES ("Y21b8b3x3G");
INSERT INTO `clients` (`userID`) VALUES ("Y21f0u7q2E");
INSERT INTO `clients` (`userID`) VALUES ("Y21i4m5b5E");
INSERT INTO `clients` (`userID`) VALUES ("Y21s4k5g0B");
INSERT INTO `clients` (`userID`) VALUES ("Y21u1z9w6E");
INSERT INTO `clients` (`userID`) VALUES ("Y21z1u4z4R");
INSERT INTO `clients` (`userID`) VALUES ("Y21p3z1w6U");
INSERT INTO `clients` (`userID`) VALUES ("Y21r2g8t4N");
INSERT INTO `clients` (`userID`) VALUES ("Y21f2g0i1C");
INSERT INTO `clients` (`userID`) VALUES ("Y21i0f8z5U");
INSERT INTO `clients` (`userID`) VALUES ("Y21q7j8b9V");
INSERT INTO `clients` (`userID`) VALUES ("Y21s4p0h3F");
INSERT INTO `clients` (`userID`) VALUES ("Y21u0h0r1H");
INSERT INTO `clients` (`userID`) VALUES ("Y21l5f9r2T");
INSERT INTO `clients` (`userID`) VALUES ("Y21q5y2g9O");
INSERT INTO `clients` (`userID`) VALUES ("Y21c0c7t0F");
INSERT INTO `clients` (`userID`) VALUES ("Y21b3t3d4I");
INSERT INTO `clients` (`userID`) VALUES ("Y21f0b1b9W");
INSERT INTO `clients` (`userID`) VALUES ("Y21b0m9k9L");
INSERT INTO `clients` (`userID`) VALUES ("Y21a9z7t6R");
INSERT INTO `clients` (`userID`) VALUES ("Y21b4v1r9B");
INSERT INTO `clients` (`userID`) VALUES ("Y21b5j1d7H");
INSERT INTO `clients` (`userID`) VALUES ("Y21g5x5u9X");
INSERT INTO `clients` (`userID`) VALUES ("Y21f9g6q6I");
INSERT INTO `clients` (`userID`) VALUES ("Y21r5t3v1Y");
INSERT INTO `clients` (`userID`) VALUES ("Y21b2c5s5X");
INSERT INTO `clients` (`userID`) VALUES ("Y21k8t2u9D");
INSERT INTO `clients` (`userID`) VALUES ("Y21m6p8s3I");
INSERT INTO `clients` (`userID`) VALUES ("Y21z5f7v5T");
INSERT INTO `clients` (`userID`) VALUES ("Y21i8q5y1K");
INSERT INTO `clients` (`userID`) VALUES ("Y21o9o2w6C");
INSERT INTO `clients` (`userID`) VALUES ("Y21u4a5y5V");
INSERT INTO `clients` (`userID`) VALUES ("Y21a4p1j5G");
INSERT INTO `clients` (`userID`) VALUES ("Y21l6k2n1L");
INSERT INTO `clients` (`userID`) VALUES ("Y21d8k6f2D");
INSERT INTO `clients` (`userID`) VALUES ("Y21m1b5d7H");
INSERT INTO `clients` (`userID`) VALUES ("Y21x8n6z9E");
INSERT INTO `clients` (`userID`) VALUES ("Y21z6i9d6D");
INSERT INTO `clients` (`userID`) VALUES ("Y21c6m6e7X");
INSERT INTO `clients` (`userID`) VALUES ("Y21r8v6d0F");
INSERT INTO `clients` (`userID`) VALUES ("Y21p8o6k8V");
INSERT INTO `clients` (`userID`) VALUES ("Y21p1m4i0V");
INSERT INTO `clients` (`userID`) VALUES ("Y21w4s1x4S");
INSERT INTO `clients` (`userID`) VALUES ("Y21y5a3i5J");
INSERT INTO `clients` (`userID`) VALUES ("Y21g8j8y7M");
INSERT INTO `clients` (`userID`) VALUES ("Y21v5s0t5X");
INSERT INTO `clients` (`userID`) VALUES ("Y21j1t2r0Y");
INSERT INTO `clients` (`userID`) VALUES ("Y21t6w4j0J");
INSERT INTO `clients` (`userID`) VALUES ("Y21q3s6c7X");
INSERT INTO `clients` (`userID`) VALUES ("Y21f9q5j0G");
INSERT INTO `clients` (`userID`) VALUES ("Y21k4o5w6C");
INSERT INTO `clients` (`userID`) VALUES ("Y21o2k5g2F");
INSERT INTO `clients` (`userID`) VALUES ("Y21a2h5f8J");
INSERT INTO `clients` (`userID`) VALUES ("Y21g2n6i0Z");
INSERT INTO `clients` (`userID`) VALUES ("Y21g2y7g1G");
INSERT INTO `clients` (`userID`) VALUES ("Y21r1y3d2A");
INSERT INTO `clients` (`userID`) VALUES ("Y21d5s7g0D");
INSERT INTO `clients` (`userID`) VALUES ("Y21p9a1c3B");
INSERT INTO `clients` (`userID`) VALUES ("Y21a9z0f5X");
INSERT INTO `clients` (`userID`) VALUES ("Y21d7k9b9B");
INSERT INTO `clients` (`userID`) VALUES ("Y21p8v0o4G");
INSERT INTO `clients` (`userID`) VALUES ("Y21z8m7k6X");
INSERT INTO `clients` (`userID`) VALUES ("Y21w4b1d7E");
INSERT INTO `clients` (`userID`) VALUES ("Y21h5m5s3X");
INSERT INTO `clients` (`userID`) VALUES ("Y21g1s2d4W");
INSERT INTO `clients` (`userID`) VALUES ("Y21s2l2g2Y");
INSERT INTO `clients` (`userID`) VALUES ("Y21u6q9o1X");
INSERT INTO `clients` (`userID`) VALUES ("Y21b0a2b3T");
INSERT INTO `clients` (`userID`) VALUES ("I21a6v1n3Y");
INSERT INTO `clients` (`userID`) VALUES ("I21m2s2j0X");
INSERT INTO `clients` (`userID`) VALUES ("I21p1o3m0I");
INSERT INTO `clients` (`userID`) VALUES ("I21n7x7k6Q");
INSERT INTO `clients` (`userID`) VALUES ("I21r0k0b4G");
INSERT INTO `clients` (`userID`) VALUES ("I21l6n1r5O");
INSERT INTO `clients` (`userID`) VALUES ("I21b0f1b7U");
INSERT INTO `clients` (`userID`) VALUES ("I21e0m3b2H");
INSERT INTO `clients` (`userID`) VALUES ("I21n8n8x4L");
INSERT INTO `clients` (`userID`) VALUES ("I21a3c7b9V");
INSERT INTO `clients` (`userID`) VALUES ("I21l4l2z2V");
INSERT INTO `clients` (`userID`) VALUES ("I21n3q8z0T");
INSERT INTO `clients` (`userID`) VALUES ("I21g4q3a0C");
INSERT INTO `clients` (`userID`) VALUES ("I21e8r0w4U");
INSERT INTO `clients` (`userID`) VALUES ("I21g6a1t9M");
INSERT INTO `clients` (`userID`) VALUES ("I21c1i0m8G");
INSERT INTO `clients` (`userID`) VALUES ("I21t2r5i9L");
INSERT INTO `clients` (`userID`) VALUES ("I21a8r5z0R");
INSERT INTO `clients` (`userID`) VALUES ("I21b8x7f7C");
INSERT INTO `clients` (`userID`) VALUES ("I21f9d1v3S");
INSERT INTO `clients` (`userID`) VALUES ("I21t0z0b6C");
INSERT INTO `clients` (`userID`) VALUES ("I21k2i4s0M");
INSERT INTO `clients` (`userID`) VALUES ("I21e5c5u5T");
INSERT INTO `clients` (`userID`) VALUES ("I21h2l3h4T");
INSERT INTO `clients` (`userID`) VALUES ("I21w7w4s5D");
INSERT INTO `clients` (`userID`) VALUES ("I21q1o1x3V");
INSERT INTO `clients` (`userID`) VALUES ("I21q9k1o6D");
INSERT INTO `clients` (`userID`) VALUES ("I21s9s9l4W");
INSERT INTO `clients` (`userID`) VALUES ("I21q1y3p1B");
INSERT INTO `clients` (`userID`) VALUES ("I21s2t1t0M");
INSERT INTO `clients` (`userID`) VALUES ("I21x3a1i3J");
INSERT INTO `clients` (`userID`) VALUES ("I21l5k8x1E");
INSERT INTO `clients` (`userID`) VALUES ("I21o4j8t5J");
INSERT INTO `clients` (`userID`) VALUES ("I21j4c1z0G");
INSERT INTO `clients` (`userID`) VALUES ("I21d6h1k4S");
INSERT INTO `clients` (`userID`) VALUES ("I21j0i9h1D");
INSERT INTO `clients` (`userID`) VALUES ("I21d1s2k3T");
INSERT INTO `clients` (`userID`) VALUES ("I21b1t4v6Y");
INSERT INTO `clients` (`userID`) VALUES ("I21q0l7k2S");
INSERT INTO `clients` (`userID`) VALUES ("I21o5t8k4S");
INSERT INTO `clients` (`userID`) VALUES ("I21d8u1g3F");
INSERT INTO `clients` (`userID`) VALUES ("I21m0m8e1V");
INSERT INTO `clients` (`userID`) VALUES ("I21p9t3c7R");
INSERT INTO `clients` (`userID`) VALUES ("I21h2u9c3D");
INSERT INTO `clients` (`userID`) VALUES ("I21a0l0g1L");
INSERT INTO `clients` (`userID`) VALUES ("I21l7l3r4Q");
INSERT INTO `clients` (`userID`) VALUES ("I21h9y4d8L");
INSERT INTO `clients` (`userID`) VALUES ("I21p5a6t2C");
INSERT INTO `clients` (`userID`) VALUES ("I21g2z8f6O");
INSERT INTO `clients` (`userID`) VALUES ("I21i2l7f5H");
INSERT INTO `clients` (`userID`) VALUES ("I21q7x2g1S");
INSERT INTO `clients` (`userID`) VALUES ("I21i8x8f6M");
INSERT INTO `clients` (`userID`) VALUES ("I21l0r9l3V");
INSERT INTO `clients` (`userID`) VALUES ("I21n5q6a4D");
INSERT INTO `clients` (`userID`) VALUES ("I21c9w4e5V");
INSERT INTO `clients` (`userID`) VALUES ("I21r1z4k2D");
INSERT INTO `clients` (`userID`) VALUES ("I21p6v9u4N");
INSERT INTO `clients` (`userID`) VALUES ("I21n7y2f4X");
INSERT INTO `clients` (`userID`) VALUES ("I21f7c9s5M");
INSERT INTO `clients` (`userID`) VALUES ("I21d1n4r9Z");
INSERT INTO `clients` (`userID`) VALUES ("I21z2k0g2Z");
INSERT INTO `clients` (`userID`) VALUES ("I21g3m9s7I");
INSERT INTO `clients` (`userID`) VALUES ("I21z3e6c2F");
INSERT INTO `clients` (`userID`) VALUES ("I21u0o9p4S");
INSERT INTO `clients` (`userID`) VALUES ("I21s7j5a6V");
INSERT INTO `clients` (`userID`) VALUES ("I21j2n0e0U");
INSERT INTO `clients` (`userID`) VALUES ("I21j8o1a3G");
INSERT INTO `clients` (`userID`) VALUES ("I21l8p2s9M");
INSERT INTO `clients` (`userID`) VALUES ("I21c5y3b3D");
INSERT INTO `clients` (`userID`) VALUES ("I21i1b1u3K");
INSERT INTO `clients` (`userID`) VALUES ("I21a5f4z0X");
INSERT INTO `clients` (`userID`) VALUES ("I21x9j6r5J");
INSERT INTO `clients` (`userID`) VALUES ("I21s9w5f1N");
INSERT INTO `clients` (`userID`) VALUES ("I21p6r5h3T");
INSERT INTO `clients` (`userID`) VALUES ("I21h9a5z8Y");
INSERT INTO `clients` (`userID`) VALUES ("I21y1u2m4V");
INSERT INTO `clients` (`userID`) VALUES ("I21z2d7c5Q");
INSERT INTO `clients` (`userID`) VALUES ("I21o1f7t9Z");
INSERT INTO `clients` (`userID`) VALUES ("I21b7l9f4G");
INSERT INTO `clients` (`userID`) VALUES ("I21o0p9v2G");
INSERT INTO `clients` (`userID`) VALUES ("I21j0t6i5Q");
INSERT INTO `clients` (`userID`) VALUES ("I21r0h1t2L");
INSERT INTO `clients` (`userID`) VALUES ("I21i8g8k3M");
INSERT INTO `clients` (`userID`) VALUES ("I21z1v3d9J");
INSERT INTO `clients` (`userID`) VALUES ("I21i1d0e4O");
INSERT INTO `clients` (`userID`) VALUES ("I21x8u8t1N");
INSERT INTO `clients` (`userID`) VALUES ("I21h2g2o2Z");
INSERT INTO `clients` (`userID`) VALUES ("I21o2l9d5N");
INSERT INTO `clients` (`userID`) VALUES ("I21b5c7q0B");
INSERT INTO `clients` (`userID`) VALUES ("I21f2w0f2G");
INSERT INTO `clients` (`userID`) VALUES ("I21e6i6i6N");
INSERT INTO `clients` (`userID`) VALUES ("I21p9e2x7Z");
INSERT INTO `clients` (`userID`) VALUES ("I21o0f4s7Z");
INSERT INTO `clients` (`userID`) VALUES ("I21z8z0v1D");
INSERT INTO `clients` (`userID`) VALUES ("I21j1a5t0U");
INSERT INTO `clients` (`userID`) VALUES ("I21l8k8k9L");
INSERT INTO `clients` (`userID`) VALUES ("I21y2q1v1W");
INSERT INTO `clients` (`userID`) VALUES ("I21i3i4o2O");
INSERT INTO `clients` (`userID`) VALUES ("I21d3y2f0U");
INSERT INTO `clients` (`userID`) VALUES ("I21r6i4t5D");

INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21f4f1m7D000","Thomas Santos","2021-12-17","LGBTQ Law","2020-08-12",88,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21t5j9w8Q000","Cherokee Hogan","2021-10-31","Communications and Media","2020-08-11",27,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21t7z7y4I000","Kessie Hodge","2021-04-16","Tenant Law","2020-06-18",99,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21c2h1l0H000","Kelly B. Decker","2021-09-15","Wrongful Death","2020-10-20",66,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21i1q4e2C000","Martina Macias","2021-07-13","Wills and Probate","2020-05-24",36,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21p2y3h0J000","Macey V. Baker","2022-01-22","Education","2020-08-07",80,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21r4j6o9L000","Cameran Witt","2021-08-23","Sports Law","2020-05-13",67,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21i6v6f7T000","Joelle Nixon","2021-10-20","Copyrights and Patents","2020-11-19",69,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21e7a2y8X000","Mollie Higgins","2021-08-26","Education","2020-04-25",66,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21h4r3w5L000","Adrienne L. Walton","2021-10-19","Bankruptcy","2020-07-20",61,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21w9v7d1S000","Arthur White","2021-05-12","Construction Law","2020-04-25",21,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21x3c0k9T000","Adele Christensen","2021-11-12","Whistleblower Litigation","2020-05-09",31,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21m4j8t5Y000","Carter V. Haney","2021-02-11","Copyrights and Patents","2020-11-26",70,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21t0l8f1K000","Charity Allison","2021-03-22","Drug Crimes","2020-06-29",51,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21q6m3x3T000","Gavin Curry","2021-08-21","Child Custody","2020-08-09",96,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21q0w9e4F000","Raven Norton","2021-03-04","Wills and Probate","2020-11-06",84,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21i4h3i7G000","Marshall M. Vincent","2021-07-22","Visitation Rights","2020-05-19",36,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21d9j4s9V000","Caryn Wall","2021-12-28","Wills and Probate","2020-12-20",23,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21j1j4d2X000","Claire Brooks","2021-06-10","LGBTQ Law","2020-12-22",92,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21x9u8f6Z000","Jakeem Gutierrez","2021-02-28","Wrongful Death","2020-11-22",65,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21z9r7y5C000","Vladimir Kim","2021-09-29","Construction Law","2020-05-16",90,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21f0o8f3M000","Brennan Jackson","2021-07-20","Whistleblower Litigation","2020-05-23",21,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21g1s2c8O000","Meredith N. Sweet","2021-05-21","Labour and Employment","2020-08-30",53,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21r2i9s2I000","Buckminster R. Morris","2021-10-21","LGBTQ Law","2021-01-12",23,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21q9n4e2T000","Heidi Golden","2021-04-19","Construction Law","2021-01-02",51,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21u3f3x1U000","Ifeoma Rivera","2021-10-29","Medical Malpractice","2020-04-25",31,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21v8k1h4G000","Aphrodite Leon","2021-06-19","Labour and Employment","2020-08-21",76,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21h7e3k5M000","Yasir T. Caldwell","2021-07-02","Civil","2020-05-10",70,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21x4s1a3V000","Rosalyn West","2021-06-05","Restraining Orders","2020-06-23",35,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21u6y2o0G000","Eugenia Cameron","2022-01-17","Whistleblower Litigation","2020-05-14",75,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21w9x5e8R000","Shafira Merrill","2021-04-02","Traffic Law","2020-08-12",51,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21u9p6o8P000","Iona Sherman","2021-05-10","Finance","2020-04-11",74,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21x3v1i1X000","Xena H. West","2021-03-12","Copyrights and Patents","2020-06-19",47,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21v4i3j3Q000","Fallon Henderson","2021-07-27","Income Tax","2020-06-08",27,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21g5u1k6F000","Mollie Duffy","2021-06-10","Income Tax","2020-03-12",96,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21u2b9j9T000","Driscoll G. Cole","2021-09-30","Child Custody","2020-07-29",65,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21m2s8l8V000","Len Torres","2021-11-15","Family Law","2020-08-15",32,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21r0x1d7Q000","Carly N. Osborn","2021-04-23","Politics","2020-11-09",29,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21b9l8r3P000","Tana E. Simon","2022-02-06","Drug Crimes","2021-01-12",100,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21m1x7b8D000","Lee G. Golden","2021-05-17","Felony","2020-05-02",58,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21a3i7z1O000","Blossom Ewing","2021-07-10","Felony","2020-11-26",64,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21r2s0x1N000","Larissa Eaton","2021-09-12","Drug Crimes","2020-07-24",96,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21j2b1k9V000","Theodore E. Moses","2021-05-26","Health Insurance","2020-05-12",33,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21g1h3u4I000","Brennan Brock","2021-11-05","Family Law","2020-09-07",82,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21a0a6p9S000","Leilani T. Conner","2021-09-28","Finance","2020-05-03",39,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21m9w8z8C000","Fiona Donaldson","2021-09-13","Crime","2020-06-24",75,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21f8c9f6M000","Kirsten Gross","2021-06-10","Military Law","2020-07-24",97,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21w2k1h1K000","Benedict N. Lynch","2022-01-26","Sports Law","2020-05-13",48,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21f7g1m0X000","Pamela A. Roman","2021-02-09","LGBTQ Law","2021-01-06",77,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21p4d1l5D000","Wynter Alvarez","2021-11-20","Copyrights and Patents","2020-10-07",94,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21n4w8u7G000","Leila Z. Boone","2021-09-30","Oil and Gas","2020-08-17",84,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21i2g3x4N000","Quentin E. Hopkins","2021-02-27","Family Law","2020-11-19",55,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21c4j2s1X000","Vielka Ruiz","2021-07-10","Civil","2020-03-22",79,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21h4d5s5N000","Sarah Q. Ellis","2021-08-03","Medical Malpractice","2020-12-03",97,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21x4j4e8B000","Raya Gilliam","2021-07-26","Shipping","2020-06-22",33,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21u5y4c9M000","Quintessa X. Bishop","2021-07-31","Crime","2020-04-08",46,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21u8m5q6V000","Jemima L. Odom","2021-04-10","Whistleblower Litigation","2020-03-17",94,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21w5z3w3P000","Castor Y. Hendricks","2021-04-28","Labour and Employment","2020-11-28",48,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21w4v3a8C000","Devin Brooks","2021-03-02","Construction Law","2020-05-28",87,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21f2o7c6M000","Amal Logan","2021-09-06","Oil and Gas","2020-04-08",70,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21x7d9c7B000","Maxine Tran","2021-11-13","Civil","2020-08-19",36,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21f2i1y4G000","Macon Obrien","2021-09-20","Crime","2020-06-09",88,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21a2d9l7A000","Maite Logan","2021-05-26","Divorce","2020-05-17",54,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21e3w2w2Q000","Xerxes S. Dorsey","2021-08-10","Politics","2020-10-30",56,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21t5q9r6X000","Lyle Gilliam","2021-06-22","Restraining Orders","2020-04-28",62,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21c0v3j7H000","Bernard Dale","2021-10-03","Tenant Law","2020-12-15",39,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21p6f6g2Y000","Myra Z. Lynch","2021-04-24","Communications and Media","2021-01-21",53,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21i3k0z7H000","Vance D. Andrews","2021-02-06","Medical Malpractice","2020-05-19",47,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21d4j9h5F000","Zachery Williams","2022-01-19","Politics","2020-05-28",94,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21a6j4s8S000","Althea G. Beck","2021-08-27","Communications and Media","2020-04-24",21,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21g4w5c6D000","Solomon Steele","2021-08-17","Finance","2020-06-20",34,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21p4y9k3K000","Tanner Huff","2021-10-17","Health Insurance","2020-06-05",61,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21i3c0v7K000","Adele E. Mcfarland","2021-12-26","Investments","2020-11-03",96,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21v2a2i2Q000","Maxine Silva","2021-12-06","Labour and Employment","2020-06-02",52,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21o2d2m1T000","Carl B. Bonner","2021-09-14","Divorce","2020-04-13",49,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21t1y8p4S000","Leslie Porter","2021-07-19","Homicide","2020-11-25",41,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21z6c7c1T000","Kasper Kent","2021-10-18","Agricultural Law","2020-09-29",85,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21z3g2q9E000","Rowan Nichols","2021-08-16","LGBTQ Law","2020-12-23",43,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21h1q4a0S000","Chantale X. Sanders","2021-03-15","Crime","2021-02-01",20,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21g3n2c8L000","Mariko Hewitt","2021-03-13","Tenant Law","2020-07-05",85,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21o5q4n4D000","Nolan H. Rowe","2021-08-13","Income Tax","2020-09-19",88,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21v4h8r3P000","Ivor J. Hendrix","2021-04-23","Homicide","2021-01-17",99,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21n2b5k6O000","Brittany Dotson","2021-11-21","Real Estate","2020-12-12",47,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21d8m8u7S000","Yolanda Medina","2021-09-02","Education","2020-05-31",49,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21m6a0d2A000","Vivien Fletcher","2021-03-29","Child Custody","2020-04-01",50,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21c5g2t6S000","Wilma A. Walker","2021-12-14","Bankruptcy","2020-10-07",38,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21p3d1e3Z000","Sophia Y. Hamilton","2021-05-26","LGBTQ Law","2020-10-18",31,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21o2v8p8Q000","Daniel U. Hull","2021-08-14","Income Tax","2020-12-12",82,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21l9i0c0G000","Clarke Roberts","2021-05-24","Finance","2020-10-03",96,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21x6m5b8C000","Florence Preston","2021-08-21","Traffic Law","2020-12-08",29,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21r0z8x1B000","Lee Robinson","2022-02-13","Wills and Probate","2020-11-12",29,"Won");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21y5z3j2Y000","Blaine G. Kinney","2021-10-29","Politics","2020-10-21",58,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21h2t7e7N000","Dylan Guerrero","2021-05-29","Copyrights and Patents","2020-03-24",92,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21x7t4k3L000","Isadora S. Kemp","2021-05-22","Real Estate","2020-08-10",47,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21q6l8d6I000","Lev Castaneda","2021-11-04","Finance","2020-06-30",30,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21e8i7o9T000","Kendall B. Dale","2021-08-09","Tenant Law","2020-04-19",76,"Settled");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21v4l5t6B000","Nola Frank","2021-03-13","Sports Law","2020-03-05",35,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21a5l8y4Q000","Raphael Dickerson","2021-07-31","LGBTQ Law","2020-03-25",56,"Lost");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21y7r8q2W000","Kiara Q. Mccray","2021-05-27","Divorce","2020-04-15",87,"Active");
INSERT INTO `LegalCases` (`caseID`,`plaintiff`,`lastDateOfActivity`,`flair`,`dateOfFiling`,`duration`,`status`) VALUES ("SSS21q6h2r5T000","Kenyon Mayo","2021-11-17","Traffic Law","2020-08-16",89,"Settled");

INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mt3z5D549v","2021-09-27","Aliquam vulputate ullamcorper magna. Sed eu eros. Nam consequat",18674,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mf5j1T825r","2021-04-01","non, cursus non, egestas a, dui. Cras",18589,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mx0f5X901e","2021-06-19","velit. Sed malesuada augue ut lacus. Nulla tincidunt,",7333,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mu7u5I303k","2021-08-26","non, cursus non, egestas a,",6991,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mu7q3B911o","2021-10-31","dignissim pharetra. Nam ac nulla.",19798,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mb0h2L374n","2021-10-27","Duis ac arcu. Nunc mauris. Morbi non sapien",4282,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mi6k6S050w","2021-03-21","sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla",15792,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mp4a2O616q","2022-02-01","enim. Curabitur massa. Vestibulum accumsan neque et",7472,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mi7m9R742w","2021-11-10","at, iaculis quis, pede. Praesent eu dui. Cum sociis natoque",19276,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mn6x5L289h","2021-07-13","ut, sem. Nulla interdum. Curabitur dictum.",3085,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Ml0h3P711u","2021-08-18","sociosqu ad litora torquent per conubia nostra, per",5104,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mh6n1S125l","2021-07-20","est ac mattis semper, dui lectus rutrum urna, nec",16333,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Me0d8W423d","2022-01-23","rhoncus. Nullam velit dui, semper et, lacinia vitae,",16645,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mg2e4N676q","2021-05-14","tincidunt nibh. Phasellus nulla. Integer",4331,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mb6o6T540n","2021-04-17","lectus pede, ultrices a, auctor non, feugiat nec, diam.",17332,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mo8n6A500x","2021-10-17","Curabitur egestas nunc sed libero. Proin sed turpis",9142,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mn9x7I604f","2021-04-11","magna sed dui. Fusce aliquam, enim",4190,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Ms8d3Z570z","2021-11-29","a, arcu. Sed et libero. Proin mi. Aliquam",15172,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Me6a9U102c","2021-10-26","sem eget massa. Suspendisse eleifend. Cras sed leo. Cras",5933,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mx2r0Y217e","2021-11-14","Aliquam tincidunt, nunc ac mattis ornare,",16488,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mv5z3Z965n","2021-06-15","ut, pellentesque eget, dictum placerat, augue. Sed molestie. Sed id",2557,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mt7v7Y217a","2022-01-22","Nunc mauris elit, dictum eu, eleifend nec, malesuada ut, sem.",8853,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mv8l1N656i","2021-10-22","elit fermentum risus, at fringilla",5992,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mr5l5A162a","2021-07-22","magna sed dui. Fusce aliquam,",14676,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mr8k7I508h","2022-01-09","porttitor vulputate, posuere vulputate, lacus. Cras interdum.",10711,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Me1k4K887a","2021-02-13","Nunc commodo auctor velit. Aliquam nisl.",2789,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Ms0a0G198n","2021-05-16","vel turpis. Aliquam adipiscing lobortis risus. In mi pede, nonummy",5604,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mx8l1S902r","2022-02-16","non magna. Nam ligula elit, pretium",4012,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mp6w6I243q","2021-07-24","a odio semper cursus. Integer mollis. Integer",19951,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mg4q3H676u","2021-10-27","Morbi sit amet massa. Quisque",17477,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mk2r5G724d","2021-12-03","purus gravida sagittis. Duis gravida. Praesent",6652,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mg1z5F259b","2021-02-15","Donec vitae erat vel pede blandit",14616,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mu0i7K329x","2021-12-22","amet diam eu dolor egestas",15719,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mf8u9L320d","2021-06-26","vitae nibh. Donec est mauris,",7497,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("My9f2G226i","2021-08-15","accumsan neque et nunc. Quisque ornare tortor",7772,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mq4t6O102o","2022-01-15","lectus pede et risus. Quisque libero lacus,",2934,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mg7q6O707o","2021-07-08","ultricies ornare, elit elit fermentum risus, at fringilla purus mauris",13579,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mx0v4E664u","2022-01-19","interdum. Curabitur dictum. Phasellus in",2163,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mq3p8P009v","2021-03-03","suscipit nonummy. Fusce fermentum fermentum",17049,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mq6g7Z769l","2022-01-03","Nam tempor diam dictum sapien. Aenean massa.",8848,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mf0v2Z877i","2021-09-27","consequat enim diam vel arcu. Curabitur ut odio vel",10956,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mp7f8S699g","2022-01-25","ut, molestie in, tempus eu, ligula. Aenean",4537,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mz6o7G601t","2021-05-01","mollis vitae, posuere at, velit. Cras lorem lorem, luctus",10613,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Md4x8O425o","2021-07-06","Vivamus nibh dolor, nonummy ac, feugiat non,",12111,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mn2v4D211i","2021-05-02","Ut sagittis lobortis mauris. Suspendisse",13815,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mu0c8V469p","2021-02-15","blandit congue. In scelerisque scelerisque dui. Suspendisse ac metus vitae",14973,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mx6h8R926p","2021-05-17","ante, iaculis nec, eleifend non, dapibus rutrum, justo. Praesent",8747,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mv1l5Q210j","2021-04-17","adipiscing, enim mi tempor lorem, eget mollis lectus pede et",15962,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Ms2h7U218r","2021-03-02","eleifend egestas. Sed pharetra, felis",4917,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mz5r9L827g","2021-04-29","lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id,",2688,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mp0n4S652x","2021-05-31","consequat purus. Maecenas libero est, congue a, aliquet vel, vulputate",18975,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mq1a4J648s","2021-02-17","ipsum primis in faucibus orci luctus",14854,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mj8h0U256y","2021-12-17","vitae odio sagittis semper. Nam tempor diam dictum",13550,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mg8a7I634u","2021-04-25","nonummy ac, feugiat non, lobortis quis, pede. Suspendisse dui. Fusce",8944,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mz1x5P943g","2021-08-15","Cras pellentesque. Sed dictum. Proin eget",9412,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mu0z0Q217g","2021-03-17","Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi",2601,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Ms4s6M387h","2021-10-13","purus, in molestie tortor nibh sit amet orci.",19489,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mw6m8O560f","2021-04-05","in consectetuer ipsum nunc id enim. Curabitur massa. Vestibulum accumsan",16332,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mx8k5K647b","2021-11-05","pretium et, rutrum non, hendrerit id, ante. Nunc mauris",16491,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Me3g9B611s","2021-10-06","eget, ipsum. Donec sollicitudin adipiscing ligula.",19019,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mu5q0X096d","2022-01-28","Nunc ut erat. Sed nunc",19172,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mf8f7M636u","2021-05-15","Pellentesque habitant morbi tristique senectus et netus",2835,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("My8q7F235n","2021-03-11","vitae nibh. Donec est mauris, rhoncus id,",18614,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mk9y9D468e","2021-03-04","tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec",12870,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mu2v0K283k","2021-11-08","amet nulla. Donec non justo.",14328,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("My0f5H763w","2022-02-05","sagittis. Duis gravida. Praesent eu nulla at sem molestie",9081,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mb1w9M013e","2021-05-14","Curabitur consequat, lectus sit amet luctus vulputate, nisi",6438,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mw0l3R867t","2021-09-11","ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis",15720,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("My7k8N041k","2021-03-08","Nam interdum enim non nisi. Aenean eget metus.",10348,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Md5b9M452t","2021-05-12","ipsum porta elit, a feugiat tellus lorem eu metus.",10618,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mm6c4D957b","2021-11-26","odio sagittis semper. Nam tempor diam dictum sapien. Aenean",16978,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mb5h5I260e","2021-08-12","fringilla purus mauris a nunc. In at pede. Cras",8912,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mj0a1U705x","2022-01-10","litora torquent per conubia nostra, per inceptos hymenaeos. Mauris",12754,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Me8k6H847p","2021-11-07","interdum. Curabitur dictum. Phasellus in",2573,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Md2h6T495t","2021-06-11","Nunc mauris. Morbi non sapien",17133,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mo5m8L610u","2022-01-30","Donec at arcu. Vestibulum ante ipsum primis",5373,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mp4z5I962d","2021-04-25","ipsum dolor sit amet, consectetuer adipiscing elit. Etiam",11696,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("My4v9S021v","2021-02-18","Aenean eget magna. Suspendisse tristique neque venenatis lacus. Etiam bibendum",14179,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Ms1q7I681f","2021-09-03","mi tempor lorem, eget mollis",8965,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mn7s2O909a","2021-06-19","adipiscing non, luctus sit amet,",15044,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mc0p4E524h","2021-02-11","odio semper cursus. Integer mollis.",14793,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("My2p6M506o","2021-08-22","tempor erat neque non quam. Pellentesque habitant",3135,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mi0l0E160a","2021-07-03","sed libero. Proin sed turpis nec",17483,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mr9v7T981t","2022-01-05","libero at auctor ullamcorper, nisl arcu iaculis",14770,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mv7y0F199p","2021-04-09","adipiscing ligula. Aenean gravida nunc",11015,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("My9c2W930j","2021-03-12","tortor nibh sit amet orci.",13989,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mz3f2N363a","2021-02-24","Nunc ullamcorper, velit in aliquet lobortis, nisi",19538,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mu2y1X981j","2021-05-25","Sed id risus quis diam luctus lobortis.",6262,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mt8x3H190l","2021-09-05","euismod urna. Nullam lobortis quam a felis ullamcorper",9474,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mq2x6A548m","2021-05-29","est, vitae sodales nisi magna sed dui. Fusce",13904,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mz4l5X072q","2021-11-25","gravida nunc sed pede. Cum sociis natoque penatibus et magnis",14634,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mo9r7M547r","2021-02-06","Praesent interdum ligula eu enim. Etiam",15235,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Ml1s3W395g","2021-10-03","erat vel pede blandit congue.",16249,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mg7g3Y983x","2022-02-14","dapibus quam quis diam. Pellentesque habitant morbi tristique",13043,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mz1i1O438m","2021-05-02","malesuada id, erat. Etiam vestibulum",13779,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Ml1h4P981r","2021-04-09","imperdiet dictum magna. Ut tincidunt orci quis lectus. Nullam suscipit,",5206,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mr8f6E574i","2021-05-28","lacus. Nulla tincidunt, neque vitae semper egestas, urna",7639,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mx7y6X802o","2021-03-08","ullamcorper. Duis cursus, diam at pretium aliquet, metus urna",6607,1);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mv8x9K926h","2021-08-16","mauris ut mi. Duis risus",11898,0);
INSERT INTO `FinancialTransactions` (`transactionID`,`dateOfPayment`,`description`,`amount`,`type`) VALUES ("Mr4x2K333u","2021-10-31","odio. Aliquam vulputate ullamcorper magna. Sed eu eros.",18121,1);

INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21r4a1b6X","2021-05-27 05:27:46","Review Evidence, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21a7z0h2V","2021-05-27 10:21:13","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21u5w0u4X","2020-06-01 07:47:28","Prepare Witness, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21j6o5f1F","2020-05-08 08:22:53","Case Hearing, Review Budget, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21k2l6c5D","2021-08-31 06:37:33","Case Hearing, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21d1o5j7F","2020-08-13 02:36:52","Case Hearing, Review Evidence, Complete Paperwork, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21y0e3o6E","2021-01-26 05:10:54","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21e4d9u7O","2020-04-30 12:48:48","Deposition, Complete Paperwork, Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21i6h2v4R","2021-05-03 01:52:21","Review Budget, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21u4f4u7F","2021-08-02 11:57:24","Review Evidence, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21k9e0m9D","2020-08-28 01:49:48","Client Meeting, Client Meeting, Meet Plaintiff, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21x6i8r4X","2021-04-11 01:49:38","Review Evidence, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21b7y0r2S","2021-03-29 05:34:44","Case Hearing, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21u5j4l6F","2020-04-20 03:43:26","Deposition, Prepare Witness, Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21t8y1o3Z","2020-01-02 07:39:26","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21n6o6k0N","2020-06-01 03:26:11","Deposition, Meet Plaintiff, Mock Trial, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21a0f5x5M","2020-04-27 09:29:46","Case Hearing, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21h9m7x7T","2020-04-15 08:25:41","Review Evidence, Review Budget, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21s9n5a5A","2021-02-27 05:18:42","Meet Plaintiff, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21v1p2x4V","2021-04-08 03:13:14","Mock Trial, Meet Plaintiff, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21q7h0u0E","2021-07-08 06:43:42","Meet Plaintiff, Review Budget, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21t0s5w9W","2021-08-21 12:25:24","Complete Paperwork, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21c9u5e3I","2020-03-26 07:59:33","Deposition, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21m3s3v7H","2020-01-14 09:48:34","Review Budget, Review Budget, Deposition, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21n2c2u6B","2020-05-16 08:24:21","Deposition, Review Budget, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21e0f5s5Z","2021-02-10 11:31:59","");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21g0p1y1W","2021-07-13 12:36:35","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21n8n7m3C","2020-02-21 06:13:56","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21y0y7o4V","2021-02-16 09:19:11","Review Evidence, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21p8y2h4F","2021-08-28 08:55:16","Mock Trial, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21l5x6o0T","2020-10-09 03:55:13","Mock Trial, Meet Plaintiff, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21r8g4t8B","2020-07-17 07:15:57","Case Hearing, Meet Plaintiff, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21x5n7u2H","2021-02-18 12:25:50","Meet Plaintiff, Case Hearing, Client Meeting, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21y6d3d4X","2021-12-01 07:39:14","Client Meeting, Client Meeting, Meet Plaintiff, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21x1j9n0G","2020-06-08 12:47:51","Meet Plaintiff, Deposition, Case Hearing, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21k7w6w1Y","2020-07-09 08:34:10","Prepare Witness, Deposition, Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21a3c6t8L","2021-04-04 04:31:55","Review Budget, Prepare Witness, Deposition, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21y2r4m4Q","2020-12-12 10:12:36","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21u9i4t8B","2020-12-08 01:15:16","Deposition, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21u8d9m8Y","2021-03-29 02:17:25","Complete Paperwork, Deposition, Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21u2k4c8X","2021-07-24 07:40:33","Case Hearing, Review Evidence, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21r5r4s7U","2020-10-30 03:17:23","Complete Paperwork, Deposition, Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21z0c9m4N","2020-11-02 09:22:15","Complete Paperwork, Case Hearing, Mock Trial ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21s1c6q8Z","2020-07-12 11:24:34","Deposition, Case Hearing, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21v4l9p0Q","2021-03-18 04:12:43","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21u6a1c4F","2020-06-08 05:50:45","Review Budget, Complete Paperwork, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21b3w5m9Q","2021-11-25 12:18:44","Review Evidence, Deposition, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21z1d3m8Y","2021-05-01 03:39:10","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21n7e0v3D","2021-05-15 02:32:50","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21n8x4f7G","2020-04-14 07:36:58","Case Hearing, Review Evidence, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21f7g3c6N","2021-08-13 10:39:44","Case Hearing, Firm Meeting, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21d7o8k9T","2021-05-28 01:16:27","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21a0i6w2G","2021-10-19 11:42:23","Case Hearing, Prepare Witness, Mock Trial ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21v4u3c1K","2021-12-19 04:25:59","Review Evidence, Review Budget, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21e3b3o7Z","2020-05-07 10:39:45","Client Meeting, Meet Plaintiff, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21j1c2w5C","2020-11-29 02:20:46","");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21h1m1b0M","2020-06-10 09:40:55","Meet Plaintiff, Review Budget, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21x3j8o9E","2021-07-10 04:45:55","Mock Trial, Meet Plaintiff, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21b0t8q7E","2020-12-25 07:57:29","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21t2x4l5I","2021-04-19 07:18:43","Mock Trial, Review Budget, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21i4c5r8L","2021-03-18 03:23:37","Review Budget, Meet Plaintiff, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21f0n5l0W","2021-05-28 12:50:41","Prepare Witness, Firm Meeting, Meet Plaintiff, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21k9z5q4T","2021-04-18 11:45:37","Case Hearing, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21u6p6n2J","2021-05-13 12:20:11","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21d2z8u6O","2020-01-14 10:29:42","Deposition, Prepare Witness, Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21d4r1a5W","2021-06-13 03:40:40","Prepare Witness, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21x5a3h1J","2021-04-17 01:39:15","Review Budget, Meet Plaintiff, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21i1n3b8G","2021-02-14 11:32:41","");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21e2l1i9S","2021-08-07 01:40:49","Review Evidence, Client Meeting, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21t9w6j2G","2020-10-07 07:24:54","Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21h0j8b3J","2021-08-13 11:26:58","Prepare Witness, Deposition, Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21m5g0b7G","2021-01-10 10:27:28","Mock Trial, Client Meeting, Deposition, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21y1k7z8W","2021-07-16 06:46:55","Meet Plaintiff, Review Budget, Review Budget, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21z4z2o0M","2021-05-05 10:51:18","Case Hearing, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21n5e0z5U","2021-06-25 05:15:15","Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21a0o0l9O","2021-02-16 09:50:48","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21x0l7q4S","2021-08-03 12:41:33","Mock Trial, Meet Plaintiff, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21y2c7g1O","2020-01-20 06:30:13","Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21j0j0n6W","2020-09-11 12:19:54","Meet Plaintiff, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21w5h8h6Q","2020-12-28 05:25:19","Case Hearing, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21i0j5n0F","2020-02-02 07:12:13","Case Hearing, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21m6q9t6G","2021-02-14 10:50:33","Mock Trial, Client Meeting, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21r5s1h8J","2020-04-16 11:26:38","Case Hearing, Review Evidence, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21f4o7b3D","2020-06-20 12:50:20","Meet Plaintiff, Deposition, Case Hearing, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21j2f9t3H","2020-11-01 11:45:27","Prepare Witness, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21q2y9a5U","2020-03-04 05:17:26","Prepare Witness, Deposition, Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21e4g0t3P","2020-11-27 04:44:38","Firm Meeting, Client Meeting, Prepare Witness, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21q4u5j5R","2020-04-15 07:34:54","Review Evidence, Case Hearing, Complete Paperwork, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21v9l9b5R","2021-08-05 12:50:25","Review Evidence, Mock Trial, Case Hearing, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21f3z4r8N","2021-03-19 11:18:37","Deposition, Meet Plaintiff, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21a4v0i1Q","2021-06-27 01:54:31","Review Budget, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21y6i1e7R","2020-03-03 08:31:42","Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21e8f7u0L","2021-06-13 12:40:34","Complete Paperwork, Case Hearing, Complete Paperwork, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21c6b7c7Y","2020-10-02 03:40:20","Firm Meeting, Review Evidence, Complete Paperwork, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21e6a6z1Q","2021-04-15 07:39:32","Meet Plaintiff, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21u3y0f3W","2021-03-19 01:35:40","Mock Trial, Client Meeting, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21q3f9a9V","2021-11-14 04:25:38","Deposition, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21i0s6r4L","2020-05-07 10:14:16","Deposition, Review Budget, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21l9o8k0W","2020-05-14 02:41:14","Review Evidence, Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("A21n1q5a5G","2021-10-26 08:55:27","Meet Plaintiff, Review Budget ");

INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21o6z6w7G","2021-10-01 05:11:13","Review Evidence, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21z3g0u2J","2020-10-01 05:45:46","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21v8e5b1X","2021-06-20 09:58:23","Prepare Witness, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21g1p3c3G","2021-09-10 04:18:29","Case Hearing, Review Budget, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21e8x0n9D","2021-11-22 12:18:24","Case Hearing, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21f7a6o4B","2020-03-28 01:31:45","Case Hearing, Review Evidence, Complete Paperwork, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21x5j6p6T","2021-11-04 11:57:10","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21p5s5v4O","2021-02-21 02:17:18","Deposition, Complete Paperwork, Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21x8e8x9N","2021-10-03 03:56:15","Review Budget, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21t1o7o9Y","2021-12-02 11:25:50","Review Evidence, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21u7j9u8C","2021-06-23 03:42:31","Client Meeting, Client Meeting, Meet Plaintiff, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21o8j6m5Q","2021-09-28 08:50:37","Review Evidence, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21u6h9a9Z","2020-09-21 01:37:20","Case Hearing, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21i6v7v5D","2021-10-20 01:15:27","Deposition, Prepare Witness, Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21f3d4t5C","2020-10-31 01:20:51","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21k1f0p1V","2021-07-29 05:40:20","Deposition, Meet Plaintiff, Mock Trial, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21l4d5v4P","2020-01-08 12:24:51","Case Hearing, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21r7i5k7R","2020-03-15 08:47:51","Review Evidence, Review Budget, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21k3r5r6E","2021-04-06 12:11:19","Meet Plaintiff, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21o9s5h1I","2020-11-23 09:58:40","Mock Trial, Meet Plaintiff, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21g2u0t9Q","2021-07-01 12:17:55","Meet Plaintiff, Review Budget, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21n9p1n2F","2021-03-03 08:53:56","Complete Paperwork, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21m0a3t8V","2021-08-01 10:23:50","Deposition, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21z5h8a7E","2021-10-04 03:58:27","Review Budget, Review Budget, Deposition, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21w3k2x5I","2021-04-17 02:23:56","Deposition, Review Budget, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21h1p8s3U","2021-06-19 07:56:22","");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21v7m0z9X","2020-02-24 05:50:37","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21w7j4f7F","2021-06-13 10:58:53","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21f4u5j8O","2020-09-14 07:59:50","Review Evidence, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21b5m3m0U","2021-11-27 04:58:33","Mock Trial, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21b7o0o9M","2022-01-03 08:42:43","Mock Trial, Meet Plaintiff, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21m1v3d6V","2021-03-25 07:27:27","Case Hearing, Meet Plaintiff, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21b8b3x3G","2021-12-31 05:47:26","Meet Plaintiff, Case Hearing, Client Meeting, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21f0u7q2E","2021-10-07 02:12:30","Client Meeting, Client Meeting, Meet Plaintiff, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21i4m5b5E","2021-12-26 09:36:58","Meet Plaintiff, Deposition, Case Hearing, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21s4k5g0B","2021-07-05 11:55:36","Prepare Witness, Deposition, Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21u1z9w6E","2021-12-05 02:30:39","Review Budget, Prepare Witness, Deposition, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21z1u4z4R","2020-05-08 05:50:14","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21p3z1w6U","2020-05-20 08:32:44","Deposition, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21r2g8t4N","2020-04-02 11:40:42","Complete Paperwork, Deposition, Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21f2g0i1C","2020-03-24 06:50:39","Case Hearing, Review Evidence, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21i0f8z5U","2020-02-08 02:22:25","Complete Paperwork, Deposition, Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21q7j8b9V","2020-10-22 11:32:52","Complete Paperwork, Case Hearing, Mock Trial ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21s4p0h3F","2020-03-25 07:35:46","Deposition, Case Hearing, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21u0h0r1H","2020-06-30 12:10:32","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21l5f9r2T","2022-01-22 09:40:10","Review Budget, Complete Paperwork, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21q5y2g9O","2021-02-07 06:57:44","Review Evidence, Deposition, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21c0c7t0F","2020-06-17 04:46:23","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21b3t3d4I","2021-09-22 01:53:27","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21f0b1b9W","2021-08-29 01:22:23","Case Hearing, Review Evidence, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21b0m9k9L","2021-12-20 07:16:57","Case Hearing, Firm Meeting, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21a9z7t6R","2021-07-23 06:31:56","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21b4v1r9B","2021-06-26 03:17:31","Case Hearing, Prepare Witness, Mock Trial ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21b5j1d7H","2020-03-13 03:31:53","Review Evidence, Review Budget, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21g5x5u9X","2021-10-07 02:55:41","Client Meeting, Meet Plaintiff, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21f9g6q6I","2020-12-15 10:42:36","");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21r5t3v1Y","2021-12-28 07:24:23","Meet Plaintiff, Review Budget, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21b2c5s5X","2020-03-18 04:41:10","Mock Trial, Meet Plaintiff, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21k8t2u9D","2020-03-24 01:55:24","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21m6p8s3I","2021-09-18 08:49:29","Mock Trial, Review Budget, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21z5f7v5T","2021-04-04 05:12:44","Review Budget, Meet Plaintiff, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21i8q5y1K","2020-05-19 11:31:35","Prepare Witness, Firm Meeting, Meet Plaintiff, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21o9o2w6C","2020-12-08 08:36:44","Case Hearing, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21u4a5y5V","2022-01-23 09:30:30","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21a4p1j5G","2020-02-13 11:20:45","Deposition, Prepare Witness, Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21l6k2n1L","2021-01-01 08:35:30","Prepare Witness, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21d8k6f2D","2020-05-30 10:42:10","Review Budget, Meet Plaintiff, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21m1b5d7H","2020-06-02 03:13:22","");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21x8n6z9E","2020-10-31 01:17:50","Review Evidence, Client Meeting, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21z6i9d6D","2022-01-06 05:40:35","Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21c6m6e7X","2021-04-16 07:13:13","Prepare Witness, Deposition, Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21r8v6d0F","2020-02-28 05:32:49","Mock Trial, Client Meeting, Deposition, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21p8o6k8V","2021-08-04 04:28:22","Meet Plaintiff, Review Budget, Review Budget, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21p1m4i0V","2020-08-30 03:39:25","Case Hearing, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21w4s1x4S","2020-09-16 11:29:53","Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21y5a3i5J","2020-11-03 09:21:18","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21g8j8y7M","2021-11-30 11:38:25","Mock Trial, Meet Plaintiff, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21v5s0t5X","2021-09-28 10:24:19","Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21j1t2r0Y","2021-09-26 12:46:13","Meet Plaintiff, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21t6w4j0J","2021-12-07 01:56:56","Case Hearing, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21q3s6c7X","2021-08-09 04:49:19","Case Hearing, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21f9q5j0G","2021-01-23 09:37:29","Mock Trial, Client Meeting, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21k4o5w6C","2020-04-27 06:44:39","Case Hearing, Review Evidence, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21o2k5g2F","2022-01-09 08:40:28","Meet Plaintiff, Deposition, Case Hearing, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21a2h5f8J","2020-03-25 05:32:19","Prepare Witness, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21g2n6i0Z","2020-05-11 11:29:33","Prepare Witness, Deposition, Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21g2y7g1G","2021-03-22 11:53:28","Firm Meeting, Client Meeting, Prepare Witness, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21r1y3d2A","2021-08-29 06:48:38","Review Evidence, Case Hearing, Complete Paperwork, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21d5s7g0D","2021-07-16 12:39:25","Review Evidence, Mock Trial, Case Hearing, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21p9a1c3B","2022-01-24 08:59:35","Deposition, Meet Plaintiff, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21a9z0f5X","2021-07-18 07:34:35","Review Budget, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21d7k9b9B","2020-09-04 04:48:55","Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21p8v0o4G","2021-08-08 09:29:29","Complete Paperwork, Case Hearing, Complete Paperwork, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21z8m7k6X","2021-09-30 10:59:56","Firm Meeting, Review Evidence, Complete Paperwork, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21w4b1d7E","2020-05-07 03:42:59","Meet Plaintiff, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21h5m5s3X","2020-07-31 09:55:32","Mock Trial, Client Meeting, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21g1s2d4W","2020-10-19 10:47:30","Deposition, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21s2l2g2Y","2020-03-16 01:50:18","Deposition, Review Budget, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21u6q9o1X","2021-03-21 05:41:29","Review Evidence, Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("Y21b0a2b3T","2021-06-02 01:27:51","Meet Plaintiff, Review Budget ");

INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21a6v1n3Y","2020-10-15 03:41:52","Review Evidence, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21m2s2j0X","2020-10-06 05:33:13","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21p1o3m0I","2020-09-17 05:42:30","Prepare Witness, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21n7x7k6Q","2020-12-21 02:21:51","Case Hearing, Review Budget, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21r0k0b4G","2021-02-26 06:53:47","Case Hearing, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21l6n1r5O","2020-02-09 05:10:50","Case Hearing, Review Evidence, Complete Paperwork, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21b0f1b7U","2021-01-25 04:35:15","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21e0m3b2H","2020-01-10 07:45:37","Deposition, Complete Paperwork, Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21n8n8x4L","2020-09-30 02:33:48","Review Budget, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21a3c7b9V","2021-09-15 07:52:20","Review Evidence, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21l4l2z2V","2020-11-21 04:38:11","Client Meeting, Client Meeting, Meet Plaintiff, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21n3q8z0T","2021-03-24 12:43:22","Review Evidence, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21g4q3a0C","2021-07-02 03:10:18","Case Hearing, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21e8r0w4U","2021-07-16 05:25:38","Deposition, Prepare Witness, Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21g6a1t9M","2021-03-19 02:13:22","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21c1i0m8G","2021-03-03 06:59:25","Deposition, Meet Plaintiff, Mock Trial, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21t2r5i9L","2021-05-18 02:14:30","Case Hearing, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21a8r5z0R","2020-11-01 11:19:36","Review Evidence, Review Budget, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21b8x7f7C","2020-11-28 08:53:16","Meet Plaintiff, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21f9d1v3S","2020-12-26 06:36:36","Mock Trial, Meet Plaintiff, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21t0z0b6C","2021-05-09 06:46:29","Meet Plaintiff, Review Budget, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21k2i4s0M","2021-03-21 03:53:17","Complete Paperwork, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21e5c5u5T","2022-01-07 06:38:38","Deposition, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21h2l3h4T","2020-02-22 09:42:53","Review Budget, Review Budget, Deposition, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21w7w4s5D","2021-11-03 06:14:11","Deposition, Review Budget, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21q1o1x3V","2020-10-30 12:19:21","");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21q9k1o6D","2020-04-14 03:30:34","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21s9s9l4W","2021-12-21 04:21:34","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21q1y3p1B","2020-07-21 02:21:47","Review Evidence, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21s2t1t0M","2020-01-15 10:18:21","Mock Trial, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21x3a1i3J","2020-07-03 10:17:49","Mock Trial, Meet Plaintiff, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21l5k8x1E","2020-06-19 03:35:18","Case Hearing, Meet Plaintiff, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21o4j8t5J","2020-01-22 12:52:21","Meet Plaintiff, Case Hearing, Client Meeting, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21j4c1z0G","2020-08-24 01:15:10","Client Meeting, Client Meeting, Meet Plaintiff, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21d6h1k4S","2021-12-17 01:23:22","Meet Plaintiff, Deposition, Case Hearing, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21j0i9h1D","2021-04-25 07:53:23","Prepare Witness, Deposition, Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21d1s2k3T","2020-03-05 03:34:29","Review Budget, Prepare Witness, Deposition, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21b1t4v6Y","2020-10-23 12:22:28","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21q0l7k2S","2020-09-01 03:36:37","Deposition, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21o5t8k4S","2021-07-25 06:38:52","Complete Paperwork, Deposition, Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21d8u1g3F","2020-04-21 06:27:29","Case Hearing, Review Evidence, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21m0m8e1V","2021-03-10 02:33:55","Complete Paperwork, Deposition, Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21p9t3c7R","2020-01-02 03:27:21","Complete Paperwork, Case Hearing, Mock Trial ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21h2u9c3D","2021-08-16 01:51:19","Deposition, Case Hearing, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21a0l0g1L","2020-08-22 08:31:34","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21l7l3r4Q","2021-03-14 04:11:31","Review Budget, Complete Paperwork, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21h9y4d8L","2022-01-31 11:26:48","Review Evidence, Deposition, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21p5a6t2C","2021-05-22 05:36:54","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21g2z8f6O","2020-12-19 04:17:13","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21i2l7f5H","2021-12-02 08:46:17","Case Hearing, Review Evidence, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21q7x2g1S","2021-10-15 08:33:51","Case Hearing, Firm Meeting, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21i8x8f6M","2021-03-27 11:45:49","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21l0r9l3V","2021-01-04 11:50:17","Case Hearing, Prepare Witness, Mock Trial ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21n5q6a4D","2020-09-07 06:37:32","Review Evidence, Review Budget, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21c9w4e5V","2021-08-27 03:41:36","Client Meeting, Meet Plaintiff, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21r1z4k2D","2020-06-06 08:50:14","");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21p6v9u4N","2020-11-19 09:27:28","Meet Plaintiff, Review Budget, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21n7y2f4X","2020-06-12 05:33:40","Mock Trial, Meet Plaintiff, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21f7c9s5M","2020-10-18 02:56:21","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21d1n4r9Z","2021-05-07 02:44:36","Mock Trial, Review Budget, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21z2k0g2Z","2021-02-22 10:20:29","Review Budget, Meet Plaintiff, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21g3m9s7I","2020-06-24 05:46:48","Prepare Witness, Firm Meeting, Meet Plaintiff, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21z3e6c2F","2022-01-19 04:34:24","Case Hearing, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21u0o9p4S","2021-10-01 03:28:49","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21s7j5a6V","2020-12-12 09:36:17","Deposition, Prepare Witness, Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21j2n0e0U","2021-03-03 02:58:20","Prepare Witness, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21j8o1a3G","2021-06-05 08:52:42","Review Budget, Meet Plaintiff, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21l8p2s9M","2020-05-14 07:15:51","");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21c5y3b3D","2021-03-05 11:21:13","Review Evidence, Client Meeting, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21i1b1u3K","2020-10-15 10:43:14","Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21a5f4z0X","2021-09-16 12:19:17","Prepare Witness, Deposition, Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21x9j6r5J","2021-03-29 10:42:22","Mock Trial, Client Meeting, Deposition, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21s9w5f1N","2020-03-24 08:58:46","Meet Plaintiff, Review Budget, Review Budget, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21p6r5h3T","2021-12-28 03:23:57","Case Hearing, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21h9a5z8Y","2020-03-03 02:28:14","Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21y1u2m4V","2021-09-02 11:15:36","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21z2d7c5Q","2020-11-28 08:58:36","Mock Trial, Meet Plaintiff, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21o1f7t9Z","2020-04-15 03:46:40","Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21b7l9f4G","2020-06-14 11:14:19","Meet Plaintiff, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21o0p9v2G","2021-07-03 01:15:42","Case Hearing, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21j0t6i5Q","2021-08-25 03:58:31","Case Hearing, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21r0h1t2L","2021-11-10 08:57:27","Mock Trial, Client Meeting, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21i8g8k3M","2020-10-09 11:43:22","Case Hearing, Review Evidence, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21z1v3d9J","2021-01-06 07:33:45","Meet Plaintiff, Deposition, Case Hearing, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21i1d0e4O","2021-01-26 02:39:58","Prepare Witness, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21x8u8t1N","2021-02-01 06:11:12","Prepare Witness, Deposition, Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21h2g2o2Z","2021-07-24 11:18:23","Firm Meeting, Client Meeting, Prepare Witness, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21o2l9d5N","2021-12-13 12:17:50","Review Evidence, Case Hearing, Complete Paperwork, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21b5c7q0B","2021-05-10 01:48:26","Review Evidence, Mock Trial, Case Hearing, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21f2w0f2G","2020-10-08 10:13:56","Deposition, Meet Plaintiff, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21e6i6i6N","2021-06-21 02:33:14","Review Budget, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21p9e2x7Z","2021-05-08 11:30:10","Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21o0f4s7Z","2020-06-03 02:45:27","Complete Paperwork, Case Hearing, Complete Paperwork, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21z8z0v1D","2021-05-13 07:53:39","Firm Meeting, Review Evidence, Complete Paperwork, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21j1a5t0U","2020-04-23 08:24:55","Meet Plaintiff, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21l8k8k9L","2021-10-01 09:40:41","Mock Trial, Client Meeting, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21y2q1v1W","2020-08-16 09:44:23","Deposition, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21i3i4o2O","2020-04-14 11:12:15","Deposition, Review Budget, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21d3y2f0U","2022-01-23 08:36:24","Review Evidence, Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("I21r6i4t5D","2020-06-13 10:28:43","Meet Plaintiff, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21p5y3f5D","2020-05-03 12:29:34","Review Evidence, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21r2w6l9I","2021-12-19 07:27:29","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21a5i1p3G","2020-08-09 06:44:28","Prepare Witness, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21o8k1i4G","2020-01-24 01:45:40","Case Hearing, Review Budget, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21x7e4w2T","2021-09-22 07:16:30","Case Hearing, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21g0i7i1G","2021-09-01 10:19:36","Case Hearing, Review Evidence, Complete Paperwork, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21l5g2g3Z","2021-04-17 12:25:40","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21h3b8f0C","2020-11-11 01:29:47","Deposition, Complete Paperwork, Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21m6r1f4E","2020-09-13 02:12:17","Review Budget, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21b1l4d4S","2021-01-11 05:41:21","Review Evidence, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21y8y9b3V","2020-03-02 04:23:44","Client Meeting, Client Meeting, Meet Plaintiff, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21s9b2l5A","2020-10-11 06:49:50","Review Evidence, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21q7l2z3D","2020-04-17 06:26:55","Case Hearing, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21r9a5l9H","2021-01-09 10:40:31","Deposition, Prepare Witness, Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21w3y9k6D","2020-01-21 07:36:54","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21o7m0a5J","2021-03-15 10:44:12","Deposition, Meet Plaintiff, Mock Trial, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21t1k5q5Q","2021-05-04 08:11:26","Case Hearing, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21h1t2w5O","2021-10-07 10:48:34","Review Evidence, Review Budget, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21m4j7j5T","2021-03-31 03:10:53","Meet Plaintiff, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21y5i5m5H","2021-08-18 07:54:35","Mock Trial, Meet Plaintiff, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21f1z8c5E","2020-01-04 01:38:10","Meet Plaintiff, Review Budget, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21x5c9w6D","2020-01-29 04:12:54","Complete Paperwork, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21p2p6d4C","2021-08-19 10:42:55","Deposition, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21q8e3x6V","2021-06-18 02:38:48","Review Budget, Review Budget, Deposition, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21a0b2d6K","2020-05-21 02:31:13","Deposition, Review Budget, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21w4h7v7O","2022-01-15 11:55:30","");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21f4d0v9S","2020-11-09 08:50:33","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21w7j6x0W","2020-11-28 04:32:30","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21h2a5d0O","2020-07-22 07:28:42","Review Evidence, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21n3s6j3T","2021-07-15 03:40:26","Mock Trial, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21s8l2h5B","2022-01-07 12:57:56","Mock Trial, Meet Plaintiff, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21g1d1q3S","2021-02-26 07:25:51","Case Hearing, Meet Plaintiff, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21t0o1g1I","2021-09-08 10:27:53","Meet Plaintiff, Case Hearing, Client Meeting, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21i3u6f4B","2020-08-02 07:27:38","Client Meeting, Client Meeting, Meet Plaintiff, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21x6m7a6Q","2020-01-28 06:59:14","Meet Plaintiff, Deposition, Case Hearing, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21y7j0w4Y","2021-02-05 07:10:15","Prepare Witness, Deposition, Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21t3s8p0V","2021-10-28 12:55:49","Review Budget, Prepare Witness, Deposition, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21c7b3y8G","2021-11-17 04:23:16","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21h8b8o6W","2021-08-20 07:43:39","Deposition, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21i2h1o4T","2021-04-17 06:56:28","Complete Paperwork, Deposition, Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21r4y8d8Y","2020-08-26 05:49:11","Case Hearing, Review Evidence, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21u2s1j5K","2021-05-15 04:38:52","Complete Paperwork, Deposition, Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21z5q6r7W","2020-03-20 07:38:28","Complete Paperwork, Case Hearing, Mock Trial ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21o9z6q5L","2020-06-18 09:57:38","Deposition, Case Hearing, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21q1t2t9W","2021-01-16 03:52:56","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21f2n5h8B","2021-09-23 03:26:32","Review Budget, Complete Paperwork, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21x1f3n4O","2021-10-28 12:55:41","Review Evidence, Deposition, Mock Trial, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21p5d4e7K","2021-03-26 03:11:28","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21r1m3c3W","2020-12-11 03:19:49","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21b8m5o5E","2020-01-07 01:19:46","Case Hearing, Review Evidence, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21q1q9n8K","2020-10-26 10:48:50","Case Hearing, Firm Meeting, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21n9t7q9A","2021-03-29 08:45:55","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21v7n7v2K","2020-04-17 05:26:48","Case Hearing, Prepare Witness, Mock Trial ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21x0t2l7J","2021-08-28 08:58:15","Review Evidence, Review Budget, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21z8w5v1X","2020-08-05 11:59:57","Client Meeting, Meet Plaintiff, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21b9f9x9S","2020-08-26 07:55:16","");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21j7l0e7H","2022-01-15 05:47:28","Meet Plaintiff, Review Budget, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21i2c9d7A","2020-02-17 04:46:27","Mock Trial, Meet Plaintiff, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21t4p5f6V","2021-09-08 07:25:49","Prepare Witness, Mock Trial, Prepare Witness, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21j6c6y3S","2021-03-05 09:38:44","Mock Trial, Review Budget, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21z4n3d9R","2021-10-05 04:56:11","Review Budget, Meet Plaintiff, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21q9d9g4F","2020-05-09 10:11:50","Prepare Witness, Firm Meeting, Meet Plaintiff, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21b7i0p5B","2020-02-21 11:56:51","Case Hearing, Client Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21w9w1h9Q","2020-01-09 02:10:31","Case Hearing, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21w9t5k3P","2021-06-21 02:31:49","Deposition, Prepare Witness, Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21h8j2h4K","2020-09-20 11:52:31","Prepare Witness, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21w2l7x3E","2021-09-07 09:36:17","Review Budget, Meet Plaintiff, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21q1z0r4I","2020-01-03 08:48:14","");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21k4g9j2B","2020-09-11 10:10:15","Review Evidence, Client Meeting, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21n9a9q4Q","2020-01-05 06:56:28","Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21v3r4f1U","2021-01-20 11:52:41","Prepare Witness, Deposition, Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21b8c9o1N","2021-06-15 03:57:13","Mock Trial, Client Meeting, Deposition, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21p6y7u3O","2021-01-04 03:36:34","Meet Plaintiff, Review Budget, Review Budget, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21i2k6s6M","2021-12-18 03:58:57","Case Hearing, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21w4p7e6Q","2020-05-25 10:58:49","Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21q0j8r6P","2020-01-03 10:59:19","Review Evidence, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21x2z0k4C","2021-10-05 03:13:40","Mock Trial, Meet Plaintiff, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21w2v7n7Z","2021-07-23 10:30:58","Client Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21c7q8w4J","2020-10-10 05:17:35","Meet Plaintiff, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21k0w5h9T","2021-04-18 01:11:53","Case Hearing, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21y8g3s7O","2021-08-11 04:26:28","Case Hearing, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21i4b6a8B","2020-01-20 05:51:34","Mock Trial, Client Meeting, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21c7m6t7G","2020-04-25 09:17:37","Case Hearing, Review Evidence, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21i1v0p4N","2021-04-14 09:55:10","Meet Plaintiff, Deposition, Case Hearing, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21t5q2x4T","2021-02-21 11:29:35","Prepare Witness, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21z8h9p1E","2021-12-02 06:29:15","Prepare Witness, Deposition, Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21h7t4w7A","2021-08-18 09:51:35","Firm Meeting, Client Meeting, Prepare Witness, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21i1b8h8M","2021-05-06 03:43:15","Review Evidence, Case Hearing, Complete Paperwork, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21z5o3i5E","2020-07-20 06:56:43","Review Evidence, Mock Trial, Case Hearing, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21s3s8e7A","2021-01-18 04:15:11","Deposition, Meet Plaintiff, Prepare Witness ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21v6y9z4B","2021-04-29 01:54:46","Review Budget, Case Hearing, Review Evidence ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21d5t0b1S","2020-06-06 09:49:16","Prepare Witness, Meet Plaintiff ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21b7n1v0N","2021-07-07 11:59:39","Complete Paperwork, Case Hearing, Complete Paperwork, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21k9t9k6Z","2020-03-27 10:39:59","Firm Meeting, Review Evidence, Complete Paperwork, Review Budget ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21e9q0v2C","2020-12-27 10:50:32","Meet Plaintiff, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21k8r2r6T","2021-12-20 10:53:17","Mock Trial, Client Meeting, Firm Meeting ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21v3w1d8G","2020-07-26 09:55:47","Deposition, Deposition ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21h1t2h9X","2020-05-30 04:52:51","Deposition, Review Budget, Firm Meeting, Complete Paperwork ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21m7b7y6G","2021-12-16 01:52:17","Review Evidence, Review Budget, Case Hearing ");
INSERT INTO `Calendar` (`userID`,`when`,`description`) VALUES ("O21f1d3n8D","2021-06-03 02:49:11","Meet Plaintiff, Review Budget ");

INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21o6z6w7G","Jermaine","Marvin","Glover",19585,"egestas.Sed.pharetra@Aliquam.org","9577257609","6189 Curabitur Street","Matamata","24605","NI",1,"1-961-624-7234","Orci Luctus Consulting","71396599099");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21z3g0u2J","Acton","Colin","Kramer",9280,"sed.pede@mi.com","9481373751","P.O. Box 582, 884 Quisque Road","Iquitos","3889 JV","Loreto",1,"1-511-906-8030","Augue Sed Molestie LLP","57230847899");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21v8e5b1X","Illana","Cairo","Heath",10588,"tincidunt@erat.org","9683289510","Ap #799-4599 Ac Road","Sabanalarga","12791","Atlántico",0,"1-316-141-7172","Consequat Enim Diam Company","93237581399");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21g1p3c3G","Rajah","Beau","Dixon",19993,"ante.ipsum@ullamcorper.co.uk","9410334988","Ap #348-6266 Vivamus Ave","Istanbul","V0I 3SE","Istanbul",1,"1-381-641-6346","Odio Semper Cursus Limited","12905808899");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21e8x0n9D","Avram","Christopher","Kirk",11391,"eget.odio.Aliquam@quam.co.uk","9806988941","289-1913 Bibendum St.","Samaniego","3006","Nariño",0,"1-371-891-1601","Nulla Facilisis Suspendisse Consulting","82584461699");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21f7a6o4B","Armando","Axel","Slater",12146,"Nam@cursus.co.uk","9391976044","6979 Pellentesque. Avenue","Vienna","936233","Wie",0,"1-315-599-7398","Varius Institute","46622371199");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21x5j6p6T","Merritt","Dustin","Conrad",13942,"dictum.Proin.eget@tellusfaucibusleo.co.uk","9364964030","Ap #129-9864 Nullam Rd.","Gyeongsan","25232","Gye",0,"1-202-471-8696","Nisi Inc.","03750610299");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21p5s5v4O","Daniel","Griffin","Browning",12377,"sollicitudin@a.edu","9168614025","P.O. Box 345, 7271 Quisque Ave","St. Catharines","06566","ON",0,"1-231-372-5001","Ut Nisi Institute","00802185199");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21x8e8x9N","Brandon","Axel","Sims",5244,"at.libero@Mauris.org","9711422248","P.O. Box 310, 8300 Luctus Road","Sungai Penuh","9962","Jambi",1,"1-196-480-4268","Quis Corporation","72784138299");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21t1o7o9Y","Desirae","Colorado","Bowen",19473,"vulputate.lacus.Cras@sed.org","9660825952","Ap #803-4359 Sem Street","Middelburg","5888","Zeeland",1,"1-773-228-7676","Cras Corporation","88288836899");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21u7j9u8C","Wade","Blythe","Potts",12344,"cubilia.Curae@velit.com","9256395484","P.O. Box 327, 8834 Ipsum Rd.","Gasteiz","635393","PV",0,"1-186-750-2032","Non Industries","83505555099");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21o8j6m5Q","Bianca","Aspen","Peterson",15406,"neque.sed.dictum@diam.com","9192980693","7295 Mollis Rd.","Vanier","M9G 0Y7","Ontario",1,"1-424-937-3530","Urna Foundation","22411647599");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21u6h9a9Z","Conan","Philip","Sanders",14784,"Phasellus.nulla.Integer@turpisegestasFusce.com","9453402292","580-2536 Commodo Rd.","Awka","62113","AN",0,"1-711-377-1560","Sit Ltd","80856162199");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21i6v7v5D","Desirae","Ray","Neal",18487,"tellus.Aenean.egestas@Suspendissealiquetsem.org","9026304270","828-5920 Nisl. Rd.","Toledo","184276211","Castilla - La Mancha",1,"1-252-570-2118","Risus Quisque Libero Consulting","42898082999");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21f3d4t5C","Bryar","Jesse","David",3470,"lacus.pede.sagittis@et.org","9215146854","2665 Aliquet, Rd.","Osasco","573353","São Paulo",1,"1-768-461-0789","Ut LLP","98243199699");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21k1f0p1V","Jaime","Geoffrey","Mendez",10497,"ut@dolor.ca","9703874833","Ap #255-674 Phasellus St.","Kilsyth","7288","ST",0,"1-603-384-6096","Pellentesque Eget Dictum Industries","69315799899");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21l4d5v4P","Castor","Thaddeus","Griffith",19542,"a.scelerisque.sed@In.ca","9617576407","8550 Euismod Road","Pizzoferrato","65688","ABR",0,"1-702-876-1260","Elit Corp.","30501003399");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21r7i5k7R","Oliver","Clarke","Ewing",7091,"magna.Nam@primisin.edu","9307777216","820-8607 Ac Rd.","Bandung","31235","JB",1,"1-627-702-0522","Tristique Aliquet Phasellus Ltd","80941469599");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21k3r5r6E","Yasir","Anne","Martinez",19835,"ut.ipsum.ac@arcuet.com","9587926007","P.O. Box 976, 7687 Risus. Rd.","Dandenong","37812-104","Victoria",0,"1-978-278-0229","Lectus Ante Industries","45851711999");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21o9s5h1I","Mark","Heidi","Mccarty",4551,"tortor.nibh@erat.ca","9846488141","Ap #592-440 Ac, Road","Belfast","0196","Ulster",0,"1-575-268-7707","Consectetuer Ipsum Corporation","21607628099");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21g2u0t9Q","Ross","Jamal","Burke",4374,"lorem.ac@fermentumarcuVestibulum.edu","9848792731","7407 Eu Street","Talara","979602","Piura",1,"1-970-444-1095","Orci Company","56535233799");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21n9p1n2F","Noel","Jillian","Velasquez",17196,"Cras.vulputate@interdum.com","9920473902","560-9933 Velit Rd.","Guadalupe","Y6P 3T1","SJ",0,"1-474-671-6796","Sem Consequat Nec Ltd","39455480299");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21m0a3t8V","Candice","Scarlett","Pope",7768,"Suspendisse.tristique.neque@nequeInornare.edu","9712109052","524-1190 Praesent Av.","Hamilton","13268","ON",0,"1-309-908-6399","Semper Pretium Neque Corp.","93394695899");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21z5h8a7E","Nelle","Charde","Lyons",16764,"Suspendisse.commodo.tincidunt@interdumCurabitur.ca","9993889640","1689 Ornare Av.","Campinas","NU0 8FI","SP",1,"1-376-981-2991","Curabitur Institute","62229137499");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21w3k2x5I","Josiah","Herman","Dodson",14495,"metus.sit@NullainterdumCurabitur.ca","9148936396","P.O. Box 283, 4257 In Av.","Penrith","67-969","NSW",1,"1-468-371-3814","Est LLC","56800121199");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21h1p8s3U","Stewart","Eaton","Cook",2031,"Phasellus.nulla@magnatellusfaucibus.ca","9779059416","P.O. Box 107, 5631 Viverra. Road","Grey County","497130","ON",0,"1-164-233-4279","Dapibus Quam Quis Industries","13771930499");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21v7m0z9X","Kathleen","Brielle","Michael",18397,"ultricies.sem.magna@eunulla.net","9846120754","428-6785 Diam Av.","Township of Minden Hills","Z79 4WV","ON",1,"1-906-121-6996","Nibh Consulting","17370914899");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21w7j4f7F","Yeo","Audra","Riddle",8199,"Quisque.tincidunt.pede@sit.org","9475474842","4441 Convallis St.","Hospet","61128","KA",1,"17543","Felis Purus Institute","56733789099");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21f4u5j8O","Abigail","Veda","Case",16234,"Aliquam.vulputate@euismodurna.co.uk","9235070513","Ap #587-6621 Magna. St.","Guadalupe","336919","N.L",1,"1-871-993-2809","Ligula Aenean Associates","35735632999");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21b5m3m0U","Margaret","Basia","Fox",2903,"luctus.aliquet@condimentumDonecat.ca","9568295670","Ap #904-6265 In Ave","Caucaia","7864","Ceará",1,"1-815-681-4774","Non Inc.","98637386199");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21b7o0o9M","Hakeem","Hiram","Ferguson",12879,"ac.turpis.egestas@eudoloregestas.net","9083048043","P.O. Box 100, 3443 Rutrum Ave","demi","187929","zm",0,"1-728-225-4166","Dui In Sodales Incorporated","74670257099");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21m1v3d6V","Kim","Allegra","Robbins",10755,"non.vestibulum@tristique.ca","9079593521","P.O. Box 256, 4620 Rutrum Av.","Tarnw","66976","Maopolskie",1,"1-611-690-9946","Fringilla Company","10205985999");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21b8b3x3G","Ezra","Plato","Justice",8352,"pharetra.nibh@turpisNulla.co.uk","9550152015","882-4678 Ac Avenue","Beauvais","1690","Picardie",1,"1-624-382-6997","Donec Vitae Erat Industries","75850997599");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21f0u7q2E","Murphy","Brady","Frank",19604,"Nulla@magnisdis.org","9365056877","P.O. Box 789, 9171 Luctus. Avenue","Baracaldo","74144","Euskadi",1,"1-737-416-7327","Tincidunt Adipiscing Mauris LLC","66660659699");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21i4m5b5E","Zachary","Jessica","Ballard",7123,"ipsum@Sednuncest.com","9342423324","1246 Nunc Rd.","Bello","3902","Antioquia",1,"1-682-517-1490","Natoque Penatibus Et Limited","46596252599");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21s4k5g0B","Kiayada","Audra","Newman",3503,"magna@diam.org","9789271135","592-779 Maecenas Rd.","Częstochowa","125561","Sląskie",1,"1-315-288-0969","Magna Sed Incorporated","39660173399");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21u1z9w6E","Todd","Elvis","Cline",16726,"leo@Namacnulla.co.uk","9516596995","Ap #906-2470 Tortor Rd.","Kollam","231695","Kerala",1,"1-169-156-9191","Ornare Placerat Foundation","03442644799");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21z1u4z4R","Herman","Jane","Head",4642,"malesuada.fames@sem.net","9329751431","Ap #636-2863 Duis Street","Alcorcn","125667","Madrid",0,"1-345-915-5993","Est Ac LLC","34417623499");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21p3z1w6U","Holly","Ishmael","Parrish",11507,"vel@mipede.co.uk","9354368516","517-3597 Tristique Ave","Vienna","229773","Vienna",0,"1-496-853-7053","Magna Malesuada Company","53568376199");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21r2g8t4N","Todd","Fritz","Shelton",13932,"auctor.ullamcorper@ut.org","9961744155","Ap #766-2657 Fermentum Street","Pontypridd","Z0930","Glamorgan",1,"1-619-779-9221","Eu LLC","92460980699");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21f2g0i1C","Jaquelyn","Jada","Hardin",7249,"turpis.Nulla@auctornon.ca","9649712264","475-6934 Libero St.","Tamworth","496594","NSW",1,"1-976-564-2003","Purus Foundation","88612178499");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21i0f8z5U","Jorden","Heidi","Leon",4498,"nisi@quam.edu","9166539906","2365 Lobortis Ave","shsme","15000","zmir",0,"1-640-786-9584","Etiam Gravida Associates","92390447799");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21q7j8b9V","Nichole","Giselle","Mcintosh",6992,"Quisque.varius@antebibendum.co.uk","9836898731","P.O. Box 537, 7621 Facilisis Avenue","Dongducheon","64944","Gye",0,"1-582-287-8853","Magna LLC","50943323499");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21s4p0h3F","Emmanuel","Melanie","Hopkins",16695,"pede@Cum.co.uk","9002042285","P.O. Box 916, 6981 Leo. Ave","Bremen","95507","HB",0,"1-143-915-9095","In Magna Phasellus Industries","94530692699");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21u0h0r1H","Connor","Adara","Welch",7347,"ligula.eu@cursusvestibulumMauris.co.uk","9452134082","P.O. Box 406, 5183 Euismod Av.","Oxford County","13096","ON",1,"1-477-496-0513","In Consulting","78380416599");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21l5f9r2T","Myra","Mallory","Solomon",12312,"tempor.bibendum@Quisqueliberolacus.net","9023989950","8108 Elit St.","Barranquilla","Z5412","ATL",1,"1-947-206-0732","Morbi Tristique Associates","97717669299");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21q5y2g9O","Brendan","Maris","Gibbs",13256,"eleifend.vitae.erat@interdum.ca","9232908149","872-6031 Metus Street","Chiclayo","Z6443","Lambayeque",1,"1-735-152-7649","Dignissim Magna LLC","20568118299");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21c0c7t0F","Zelda","Chantale","Flowers",10730,"tristique@feugiatLoremipsum.net","9573774157","Ap #932-9173 Volutpat Street","Haripur","20589","KPK",0,"1-267-275-9175","Malesuada Malesuada Integer LLC","86568845599");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21b3t3d4I","Ursa","Joy","Peck",6665,"libero.at@eget.edu","9521882231","Ap #630-8182 Eu, St.","Cajamarca","12050","Cajamarca",1,"1-967-802-3016","Pellentesque Tellus Inc.","59374777099");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21f0b1b9W","Clarke","Gannon","Bird",17626,"mollis.lectus@loremfringillaornare.org","9295754453","P.O. Box 820, 423 Tempus Avenue","Völklingen","2211","Saarland",1,"1-245-669-8261","Nec Diam LLC","63286640899");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21b0m9k9L","Bradley","Macey","Nelson",7642,"tincidunt.Donec.vitae@elitfermentumrisus.co.uk","9484224601","Ap #281-5294 Felis Rd.","Oosterhout","094096","N.",1,"1-603-939-1392","Feugiat Sed Nec Foundation","69903506099");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21a9z7t6R","Miriam","Ray","Logan",17545,"eu.dolor@gravidanunc.org","9801556461","279-8452 Sed Street","Galway","999754","Connacht",0,"1-906-915-1969","Sed Company","67529062099");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21b4v1r9B","Quail","Uriah","Hinton",11030,"erat@dis.net","9892064603","P.O. Box 764, 627 Blandit Rd.","Maringá","65303","PR",0,"1-918-622-9905","Aliquet Odio LLP","81681866099");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21b5j1d7H","Karleigh","McKenzie","Parks",4135,"ante.ipsum@vitae.co.uk","9924342623","529-8132 Hymenaeos. St.","San Ignacio","Z8376","Biobo",1,"1-631-635-9326","Quisque Imperdiet LLP","70974965499");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21g5x5u9X","Ignacia","Phelan","Boyd",17530,"lacus@Etiam.edu","9213160368","981 Fames Ave","Galway","210962","Connacht",0,"1-967-864-6384","Ipsum Primis In PC","65284997499");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21f9g6q6I","Ina","Sage","Castro",12714,"tempus@Intinciduntcongue.co.uk","9537841780","P.O. Box 260, 6613 Nunc Street","Jayapura","R1Z 6C9","PA",1,"1-521-326-6937","Malesuada Foundation","40205247799");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21r5t3v1Y","Melyssa","Aiko","Bass",16315,"Integer@odio.net","9493414357","3141 Urna St.","Alajuela","565767","Alajuela",0,"1-865-632-3360","Nec Corp.","78790444499");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21b2c5s5X","Piper","Kyla","Meadows",6290,"eget@lobortis.com","9759156205","783-4850 Sed Street","Belfast","35445","Ulster",0,"1-391-644-9428","Ac Mi Incorporated","48262340199");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21k8t2u9D","Harding","Hakeem","Whitehead",2841,"at.velit.Cras@necquamCurabitur.ca","9904012600","P.O. Box 131, 1638 Vel Road","Tuensne","95436","WB",0,"1-169-848-2762","In Institute","64835107499");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21m6p8s3I","Vernon","Hiroko","Ayers",16303,"risus.Donec@vehiculaPellentesque.com","9227065540","2961 Parturient Rd.","Kaduna","68875606","Kaduna",0,"1-891-606-0219","Dolor Elit Pellentesque Consulting","88329674899");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21z5f7v5T","Lawrence","Zahir","Snider",19293,"tincidunt@fringillaDonec.org","9162169421","P.O. Box 327, 4102 Malesuada Street","Gteborg","67828-880","Västra Götalands län",1,"1-725-287-6648","Quis Pede Suspendisse Inc.","04928240799");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21i8q5y1K","Perry","Jacqueline","Cherry",13533,"augue@laoreetlectus.com","9291352505","9437 Sodales St.","Surabaya","8497 LF","JI",1,"1-650-385-8775","Aliquam Tincidunt Nunc Inc.","98203671799");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21o9o2w6C","Lysandra","Brock","Zimmerman",8842,"suscipit.est@nibhenim.edu","9080976090","5399 Laoreet Rd.","Funtua","1600695995","Katsina",0,"1-595-276-6724","Purus PC","18839196399");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21u4a5y5V","Jerry","Kirk","Horton",16777,"ornare@ante.org","9801896681","P.O. Box 395, 2067 Etiam St.","Płock","21694","MA",0,"1-633-282-9095","Dictum LLC","39536120599");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21a4p1j5G","Jael","Dai","Rosa",15763,"dictum.ultricies@tellus.org","9088034548","Ap #743-6300 Arcu. Ave","Sosnowiec","6871","SL",1,"1-530-495-4211","Pellentesque Tellus Corp.","62666948299");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21l6k2n1L","Harper","Xenos","Dean",11039,"enim.Nunc@quamafelis.co.uk","9903076500","666-1229 Ut Road","Lambayeque","743474","Lambayeque",0,"1-562-960-3647","Etiam Foundation","74689942499");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21d8k6f2D","Pandora","Cruz","Horn",11617,"accumsan.convallis@acsemut.edu","9477102941","3834 At Rd.","Istanbul","5266","Ist",0,"1-949-948-1625","Odio Vel Industries","08564754299");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21m1b5d7H","Channing","Lars","Ballard",5840,"eleifend@lacus.com","9520908811","196-4306 Semper Av.","Gwangyang","903125","South Jeolla",0,"1-140-560-4431","Amet Inc.","42405267999");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21x8n6z9E","Alden","Laith","Langley",12555,"sit.amet@consectetuermaurisid.ca","9934596595","2599 A, St.","Saalfelden am Steinernen Meer","790342","Sbg",0,"1-291-980-6444","Vitae Institute","61711210799");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21z6i9d6D","Gay","Stephen","Cardenas",12174,"dictum@et.ca","9546086548","Ap #919-896 Mi Rd.","Bhiwani","04399","HR",1,"1-626-640-4845","Natoque PC","49875048899");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21c6m6e7X","Tiger","Wallace","Kelley",6394,"augue@ornarefacilisiseget.edu","9966337308","345 Etiam Rd.","Den Helder","44-663","Noord Holland",0,"1-581-564-5592","Et Ultrices Posuere LLC","83912527299");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21r8v6d0F","Yael","Camden","Daniels",3394,"nunc.sit@arcu.com","9782547733","P.O. Box 153, 3451 Maecenas Rd.","Pickering","61-374","Ontario",0,"1-848-828-4913","Lorem Semper Auctor Industries","27770820699");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21p8o6k8V","Cooper","Wallace","Noble",8178,"ultricies.sem.magna@duiquis.org","9486356554","1102 Lectus Rd.","Jinju","18858","Gye",1,"1-196-218-2425","Commodo Ipsum Suspendisse Ltd","77420531399");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21p1m4i0V","Lane","Lacey","Higgins",13058,"quam.elementum.at@Cras.org","9808560136","P.O. Box 233, 7260 Sit Street","Arrah","98671-417","BR",1,"1-522-428-6130","Tempor Diam Dictum Corporation","30956093399");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21w4s1x4S","Nomlanga","Denise","Nixon",3644,"nunc@Aliquamgravidamauris.net","9386127420","1038 Ornare Av.","Grave","412336","N.",0,"1-179-472-0063","A Facilisis Non Institute","34230775099");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21y5a3i5J","Elmo","Heather","Russell",2215,"vestibulum.massa@aptenttacitisociosqu.net","9279085138","P.O. Box 428, 7406 Imperdiet Street","Rimbey","T7W 3C6","AB",1,"1-394-497-6433","Et Rutrum Consulting","07714615299");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21g8j8y7M","Aline","Xandra","Roy",19103,"Mauris.ut.quam@semutdolor.edu","9864020617","P.O. Box 346, 8760 Ac Rd.","Mjölby","50386","Östergötlands län",1,"1-355-811-4776","Orci Industries","83494389799");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21v5s0t5X","Mariko","Caleb","Leblanc",12004,"neque.Sed@et.net","9607483979","P.O. Box 283, 7355 Mauris Street","Arles","77929","Provence-Alpes-Côte d'Azur",1,"1-114-540-9539","Non Limited","01332061599");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21j1t2r0Y","Laura","Ferris","Hess",15191,"scelerisque.scelerisque.dui@portaelita.org","9933119870","5894 Diam Rd.","Katsina","339020","KT",0,"1-971-347-1128","Vel Arcu Eu Ltd","63907770399");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21t6w4j0J","Jayme","Lacota","Holman",2388,"fames@augueeutempor.ca","9780129078","P.O. Box 920, 1098 Proin Road","Dublin","28217","Leinster",0,"1-962-682-6520","Non Leo Limited","11341391499");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21q3s6c7X","Tate","Eric","Grant",13748,"lorem.tristique.aliquet@Integer.ca","9003777029","P.O. Box 650, 1954 Tempus Rd.","Ciudad Madero","66656","Tamaulipas",0,"1-947-311-2178","Phasellus Dolor Industries","65291348699");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21f9q5j0G","Amanda","Ciara","Rosales",10272,"Class.aptent@dictum.co.uk","9518945491","Ap #463-3871 Ultrices. Rd.","Aubervilliers","28379","Île-de-France",0,"1-484-544-7815","Aliquam Fringilla Inc.","47901194199");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21k4o5w6C","Zena","Claire","Dejesus",18127,"nonummy.Fusce.fermentum@egetnisidictum.ca","9958565187","9901 Nec Rd.","Płock","8620","MA",0,"1-948-486-2070","Elementum Dui Inc.","37513410899");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21o2k5g2F","Tad","Lysandra","Wilkinson",13875,"egestas@ornarelectusante.com","9090855076","Ap #598-2186 Id, St.","Gliwice","716795","SL",0,"1-394-270-3379","Dapibus Quam Quis Incorporated","62640516399");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21a2h5f8J","Adrienne","Amber","Harper",19102,"molestie.arcu@dis.ca","9075215172","8521 Eget, Rd.","Serang","45022","Banten",1,"1-719-539-5205","Orci Corp.","92838480899");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21g2n6i0Z","Georgia","Gemma","Horn",17392,"ornare.Fusce@ametdapibus.edu","9950161644","Ap #453-9219 Diam. St.","Melton","1592","VIC",1,"1-355-764-7430","Lectus Quis Massa Company","10228129099");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21g2y7g1G","Gabriel","Ciara","Hurley",10149,"est.arcu@temporlorem.ca","9380720430","Ap #724-9330 Justo St.","Madison","55774","Wisconsin",0,"1-483-242-8951","Condimentum Eget Company","00556754799");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21r1y3d2A","Jillian","Benedict","Fox",5600,"varius.ultrices@condimentumDonec.co.uk","9896829342","7297 Massa. Rd.","Oss","353252","N.",0,"1-376-727-5273","Amet PC","31221555299");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21d5s7g0D","Bradley","Elvis","Owen",4657,"pede.ultrices.a@nectempus.co.uk","9543590034","5045 A Ave","Tauranga","18315-875","North Island",1,"1-763-155-3117","Mauris Inc.","46817201899");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21p9a1c3B","Carter","Alice","Pacheco",7523,"non.egestas.a@Aenean.edu","9901080602","Ap #898-2150 Elit Rd.","Istanbul","583812","Ist",1,"1-502-620-8863","Ligula LLC","63289274199");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21a9z0f5X","Linda","Francesca","Dyer",14983,"turpis@ac.com","9931245873","P.O. Box 558, 4069 Adipiscing Rd.","Bydgoszcz","BS7N 7SZ","Kujawsko-pomorskie",1,"1-807-835-6605","Fermentum Arcu Limited","81479670499");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21d7k9b9B","Alea","Nadine","Sosa",14763,"elit.dictum@Namligula.ca","9830643215","P.O. Box 830, 8162 Urna St.","Magangué","65016","Bolívar",0,"1-865-300-2426","Rhoncus Ltd","57983116899");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21p8v0o4G","Steven","Melyssa","Baird",9326,"lacus.Aliquam.rutrum@Nullamut.edu","9338065590","453-7308 Semper Av.","Antofagasta","09056","II",0,"1-394-891-2544","Nullam Suscipit Est Consulting","55679475299");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21z8m7k6X","Chadwick","Signe","Yates",5421,"adipiscing@pellentesqueSed.net","9181264162","P.O. Box 877, 3322 Non Avenue","Poznań","27936","WP",0,"1-304-448-9217","Metus LLC","91793493599");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21w4b1d7E","Barbara","Kim","Harrington",16108,"parturient.montes@egestasurna.org","9707933833","Ap #631-1386 In Rd.","Kielce","93-772","SK",0,"1-480-883-2406","Libero Company","24633203899");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21h5m5s3X","Clark","Owen","Serrano",5106,"natoque.penatibus@lectusquis.co.uk","9381159790","Ap #980-5153 A Av.","Tarma","66141","Junín",1,"1-717-728-0117","Risus Donec Nibh Associates","98509098699");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21g1s2d4W","Victor","Lacey","Sheppard",2063,"nec.ligula.consectetuer@nullaat.org","9264569380","Ap #376-2420 Dolor Rd.","Impe","695408","Oost-Vlaanderen",1,"1-789-738-4421","Nisi Nibh Lacinia PC","98875661499");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21s2l2g2Y","Ora","Jada","Mccarthy",9238,"sit.amet.lorem@Crasvehicula.net","9507723477","7127 Sollicitudin Street","Okene","43490","KO",1,"1-701-641-7983","Nunc Pulvinar Arcu Associates","60943701099");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21u6q9o1X","Walker","Casey","Terry",11302,"eu@parturientmontesnascetur.com","9562777075","401-4903 Ultrices Road","Cobourg","850440","Ontario",1,"1-985-868-7054","Ac Mattis Semper LLC","82698140399");
INSERT INTO `ClientCompanies` (`userID`,`firstName`,`middleName`,`lastName`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`,`fax`,`companyName`,`gstIN`) VALUES ("Y21b0a2b3T","Ann","Nyssa","Hernandez",2011,"ac.turpis.egestas@ac.net","9762207745","283 Eget St.","Hermosillo","76832","Sonora",0,"1-539-995-6926","Nam Interdum Enim LLC","16587165499");

INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21f4f1m7D000","2021-08-27","153-9506 Ante, Ave","17:45");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21t5j9w8Q000","2021-04-18","Ap #509-1426 Purus, St.","13:13");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21t7z7y4I000","2021-07-14","Ap #974-344 Malesuada. Rd.","14:38");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21c2h1l0H000","2021-12-20","704-6648 Libero. St.","18:43");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21i1q4e2C000","2021-03-03","3647 Imperdiet St.","11:31");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21p2y3h0J000","2021-11-29","P.O. Box 290, 3146 Velit. St.","14:33");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21r4j6o9L000","2021-03-07","1599 Dolor. Av.","16:26");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21i6v6f7T000","2021-04-17","8136 Massa Avenue","10:52");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21e7a2y8X000","2021-09-13","5158 Ullamcorper, Street","17:23");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21h4r3w5L000","2021-08-08","495-4980 Cras Ave","11:40");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21w9v7d1S000","2021-03-01","987-7953 Proin Ave","09:43");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21x3c0k9T000","2021-03-16","6697 Proin Rd.","16:22");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21m4j8t5Y000","2021-12-31","742-243 Primis Rd.","13:57");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21t0l8f1K000","2021-06-07","Ap #308-983 Lacinia Rd.","16:01");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21q6m3x3T000","2021-11-12","633-8235 Dictum. Street","14:05");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21q0w9e4F000","2021-11-30","897-8444 Nisl. Road","10:52");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21i4h3i7G000","2021-02-27","P.O. Box 329, 6455 Rutrum Av.","10:51");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21d9j4s9V000","2021-06-09","P.O. Box 548, 8902 Amet Road","18:11");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21j1j4d2X000","2021-08-02","P.O. Box 941, 2912 Cras St.","09:06");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21x9u8f6Z000","2021-11-17","P.O. Box 710, 7772 Eu Rd.","10:24");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21z9r7y5C000","2021-02-09","Ap #637-9032 Erat Road","10:29");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21f0o8f3M000","2021-02-26","P.O. Box 415, 6537 Neque Rd.","12:53");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21g1s2c8O000","2021-12-04","7819 Sapien. St.","16:54");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21r2i9s2I000","2021-06-15","3802 Nunc St.","09:46");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21q9n4e2T000","2021-07-02","P.O. Box 421, 6999 Non Avenue","15:28");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21u3f3x1U000","2022-02-13","Ap #939-2265 Elit, St.","11:18");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21v8k1h4G000","2021-10-09","Ap #457-9091 Accumsan Street","16:17");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21h7e3k5M000","2021-08-14","P.O. Box 659, 6267 Sed Avenue","18:44");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21x4s1a3V000","2021-10-06","Ap #885-6322 Ut, Rd.","18:53");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21u6y2o0G000","2021-07-13","P.O. Box 626, 6122 Urna, Avenue","18:37");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21w9x5e8R000","2021-03-07","794-2628 Semper St.","14:48");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21u9p6o8P000","2021-06-15","357-243 Sed Street","11:47");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21x3v1i1X000","2021-08-15","3730 Libero. St.","09:14");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21v4i3j3Q000","2021-03-09","114-8034 Elit, Street","09:10");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21g5u1k6F000","2021-06-28","6555 Vel Avenue","15:27");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21u2b9j9T000","2021-07-15","577-4664 Neque Avenue","18:44");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21m2s8l8V000","2021-04-09","598-8192 Consectetuer Rd.","13:14");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21r0x1d7Q000","2022-01-19","P.O. Box 168, 7453 Phasellus Ave","11:56");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21b9l8r3P000","2022-02-07","3522 Sociis Rd.","11:55");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21m1x7b8D000","2021-10-02","P.O. Box 541, 4541 Conubia Street","13:21");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21a3i7z1O000","2021-04-27","6574 Fames Ave","17:00");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21r2s0x1N000","2021-09-06","641-6536 Risus. Street","16:08");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21j2b1k9V000","2021-02-07","P.O. Box 805, 2678 Mi Ave","17:22");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21g1h3u4I000","2021-05-26","427-6363 Tincidunt, Avenue","12:28");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21a0a6p9S000","2021-12-29","Ap #170-5008 Odio Street","10:21");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21m9w8z8C000","2021-04-28","3572 Eu, Av.","18:53");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21f8c9f6M000","2021-07-18","5841 Interdum Avenue","11:08");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21w2k1h1K000","2022-02-08","P.O. Box 843, 7909 Feugiat Street","09:13");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21f7g1m0X000","2021-10-21","487-9644 Praesent Ave","17:09");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21p4d1l5D000","2021-05-24","Ap #813-6543 Dapibus Av.","11:36");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21n4w8u7G000","2021-04-03","4354 Fusce Ave","14:31");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21i2g3x4N000","2021-08-27","P.O. Box 493, 1484 Purus. Avenue","15:51");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21c4j2s1X000","2021-03-06","8433 Pretium Rd.","10:11");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21h4d5s5N000","2021-04-30","4580 Dui. Rd.","17:30");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21x4j4e8B000","2021-07-04","P.O. Box 419, 2586 Sapien, St.","16:55");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21u5y4c9M000","2021-09-17","P.O. Box 627, 9295 Dictum Rd.","12:57");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21u8m5q6V000","2022-01-12","931-4346 Etiam Rd.","10:38");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21w5z3w3P000","2021-10-27","P.O. Box 606, 2373 Vulputate Avenue","13:37");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21w4v3a8C000","2022-02-13","3595 Enim St.","13:42");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21f2o7c6M000","2021-06-06","1679 In Rd.","10:30");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21x7d9c7B000","2021-12-15","Ap #430-1828 Nisi St.","15:20");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21f2i1y4G000","2021-07-06","P.O. Box 306, 2905 Dolor. Street","18:30");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21a2d9l7A000","2021-08-06","Ap #131-7761 Turpis Road","14:08");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21e3w2w2Q000","2022-02-11","P.O. Box 662, 2384 Et, Ave","16:51");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21t5q9r6X000","2021-06-27","9322 Enim Road","15:54");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21c0v3j7H000","2021-06-08","P.O. Box 963, 6698 Non Rd.","18:17");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21p6f6g2Y000","2021-11-09","P.O. Box 541, 3983 Lectus Avenue","16:35");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21i3k0z7H000","2021-07-31","P.O. Box 978, 5168 Integer Rd.","09:50");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21d4j9h5F000","2021-08-18","P.O. Box 402, 9615 Ultrices St.","18:50");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21a6j4s8S000","2021-12-07","P.O. Box 176, 5348 Vehicula Rd.","14:49");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21g4w5c6D000","2021-05-28","763-5010 Nibh Rd.","16:35");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21p4y9k3K000","2022-01-17","Ap #262-4638 A St.","10:47");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21i3c0v7K000","2021-07-19","426-8279 Ligula. Ave","15:30");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21v2a2i2Q000","2021-02-20","Ap #961-1437 Tempor, Rd.","12:01");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21o2d2m1T000","2021-05-12","Ap #658-5553 Aliquet, Street","15:57");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21t1y8p4S000","2021-05-14","P.O. Box 128, 4144 Ut, Rd.","09:43");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21z6c7c1T000","2021-02-17","Ap #715-6119 Mattis. St.","09:34");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21z3g2q9E000","2021-09-15","762-4905 Non, Avenue","11:25");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21h1q4a0S000","2021-08-11","121-2250 Eu St.","13:55");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21g3n2c8L000","2021-12-25","659-4545 Ante. Avenue","18:35");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21o5q4n4D000","2021-05-28","P.O. Box 851, 6257 Amet Rd.","10:28");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21v4h8r3P000","2022-01-01","124-1527 Interdum Road","12:39");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21n2b5k6O000","2021-03-13","931-3222 Fermentum Rd.","13:18");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21d8m8u7S000","2021-02-10","Ap #675-5218 Arcu. Ave","09:30");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21m6a0d2A000","2021-12-15","Ap #164-5629 Nonummy Av.","14:07");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21c5g2t6S000","2022-01-10","Ap #562-2916 Suspendisse Av.","10:52");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21p3d1e3Z000","2021-08-25","Ap #583-2800 Vulputate Road","18:19");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21o2v8p8Q000","2022-02-19","Ap #241-453 Molestie St.","12:37");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21l9i0c0G000","2021-07-21","7033 Risus. St.","12:41");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21x6m5b8C000","2021-08-11","9146 Suspendisse St.","17:49");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21r0z8x1B000","2021-09-29","P.O. Box 655, 5388 Vel St.","12:27");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21y5z3j2Y000","2021-03-24","6034 Gravida Ave","11:29");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21h2t7e7N000","2021-08-02","322-5943 Ac, Street","13:57");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21x7t4k3L000","2021-06-30","487-3320 Eget Av.","10:00");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21q6l8d6I000","2021-10-28","P.O. Box 301, 5887 Nibh Avenue","15:15");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21e8i7o9T000","2021-05-28","9281 Phasellus Rd.","10:34");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21v4l5t6B000","2021-09-20","Ap #809-9857 Id Ave","13:27");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21a5l8y4Q000","2021-05-14","Ap #310-952 Semper Avenue","17:06");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21y7r8q2W000","2021-03-03","Ap #753-5206 A Rd.","13:20");
INSERT INTO `CourtHearing` (`caseID`,`nextHearingDate`,`courtRoom`,`time`) VALUES ("SSS21q6h2r5T000","2021-10-23","4718 Rutrum. St.","11:42");

INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21a6v1n3Y","Elaine","Montana","Solomon","1991-03-29",15234,"facilisis.eget.ipsum@leoelementum.edu","9949412833","P.O. Box 864, 7360 Neque Ave","Mojokerto","11841","JI",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21m2s2j0X","Ian","Ryan","Monroe","1988-03-12",19241,"luctus.lobortis@lectusjustoeu.net","9462918045","Ap #684-644 In St.","Wonju","211322","Gangwon",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21p1o3m0I","Amethyst","Kay","Durham","1988-11-12",13834,"eu.elit.Nulla@nullaCraseu.edu","9160657261","P.O. Box 708, 3107 Risus. Road","Bama","68308-714","Borno",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21n7x7k6Q","Bruno","Kennan","Raymond","1989-03-12",9682,"ligula.Aenean@magnaatortor.co.uk","9742184177","Ap #620-1359 Nisi. Ave","Carmen","55358-047","Cartago",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21r0k0b4G","Audrey","Paula","Clemons","1990-07-08",15261,"aliquam.eu@nonvestibulumnec.edu","9240058513","P.O. Box 571, 8865 Ligula Av.","Vienna","08273","Wie",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21l6n1r5O","Adena","Nero","Gilbert","1987-05-27",19838,"ac.fermentum@vulputate.ca","9177281654","1536 Accumsan Street","West Jordan","M8J 0P1","UT",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21b0f1b7U","Katell","Sylvester","Terrell","1986-02-14",16686,"vitae.orci.Phasellus@dignissimmagna.ca","9515054781","Ap #355-5042 Dictum Ave","Lipetsk","5687","Lipetsk Oblast",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21e0m3b2H","Malachi","Mallory","Grant","1989-08-14",12266,"Suspendisse@posuere.org","9798437731","Ap #239-8780 Odio Rd.","Hwaseong","2033","Gyeonggi",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21n8n8x4L","Dawn","Theodore","Cannon","1985-02-25",14564,"id@Nullam.org","9338633412","9447 Elementum Av.","Lexington","115119","Kentucky",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21a3c7b9V","Stuart","Riley","Rhodes","1989-05-13",12839,"libero@facilisisloremtristique.edu","9855627149","P.O. Box 777, 4690 Consequat, Rd.","Malkajgiri","95388","AP",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21l4l2z2V","Quamar","Keefe","Davis","1992-12-30",17174,"commodo.ipsum@tristiquepharetraQuisque.co.uk","9419587347","Ap #842-9993 Tincidunt, Rd.","Juliaca","9777","Puno",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21n3q8z0T","Chase","Lucius","Morales","1990-08-18",7953,"eleifend@eleifend.ca","9259341594","Ap #778-7048 Ante St.","Tywyn","53658","ME",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21g4q3a0C","Yvonne","Lester","Allen","1991-10-12",3678,"quam.quis.diam@tempuslorem.org","9938427082","5178 Elit. Av.","Adoni","76238","AP",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21e8r0w4U","Sybill","Emmanuel","Ferrell","1993-10-30",17480,"cursus@risusNunc.com","9976212325","Ap #924-9625 Diam. Road","Grand-Halleux","605129","Luxemburg",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21g6a1t9M","Marshall","Valentine","Shields","1988-05-08",3564,"Nam@euismodmauris.net","9822414237","Ap #378-6846 Pede Rd.","Montpellier","97196","Languedoc-Roussillon",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21c1i0m8G","Lillith","Leila","Evans","1989-04-29",8838,"cursus@arcuAliquamultrices.co.uk","9519724445","9825 Id, Ave","General Escobedo","4545","N.L",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21t2r5i9L","Jenette","Hall","Webb","1987-01-26",19586,"Donec@nisinibhlacinia.net","9860855153","857-9837 Mauris Road","Shimanovsk","7982 XA","Amur Oblast",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21a8r5z0R","Skyler","Bradley","Chapman","1985-05-30",3841,"ligula.Nullam.enim@turpis.co.uk","9995501693","325-7560 Quis Rd.","Bahawalnagar","878392","Punjab",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21b8x7f7C","Hyacinth","Brennan","Day","1985-08-01",8754,"eu@acmattis.ca","9125617722","P.O. Box 587, 439 Orci. Ave","Gunsan","8967","North Jeolla",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21f9d1v3S","Ciaran","Abraham","Clayton","1991-07-13",19718,"Fusce.fermentum.fermentum@aliquamarcuAliquam.ca","9580522458","Ap #346-6686 Imperdiet Avenue","Serang","Z6871","Banten",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21t0z0b6C","Quyn","Eagan","Hopkins","1988-07-08",3544,"mauris.sapien.cursus@utaliquam.co.uk","9930128017","9010 Lacus. Ave","Fayetteville","148063","Arkansas",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21k2i4s0M","Ulysses","Quentin","Klein","1990-10-31",18946,"non.hendrerit.id@tempor.ca","9111378002","Ap #880-5049 Fermentum Ave","Kurgan","1638","KGN",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21e5c5u5T","Emi","Hammett","Lopez","1994-01-21",10728,"aliquet@nequepellentesque.ca","9394510398","434-2795 Sed Rd.","Tehuacán","8676718016","Puebla",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21h2l3h4T","Dana","Mona","Rivers","1986-09-17",18403,"orci.luctus@ipsumleoelementum.com","9670325904","7733 Donec Rd.","Soma","RU7 3WR","Manisa",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21w7w4s5D","Ronan","Quinlan","Swanson","1986-05-14",3665,"sagittis@dolor.edu","9108503017","340-749 Duis St.","Alcalá de Henares","983074","Madrid",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21q1o1x3V","Jared","Lamar","Wiley","1986-12-16",12442,"tincidunt.congue.turpis@feugiatnon.org","9982715121","225-5934 Aliquet. Av.","Dongducheon","404222","Gye",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21q9k1o6D","Candice","Brendan","Adkins","1989-12-11",2782,"sapien.imperdiet@Vivamusmolestie.ca","9539242507","725 Eu, Rd.","Mora","NB1 9BC","W",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21s9s9l4W","Tucker","Wilma","Johnson","1992-03-24",14742,"eu.turpis@massanonante.co.uk","9808142881","Ap #453-9575 Sodales St.","Quesada","60402","A",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21q1y3p1B","Victor","Alana","Henderson","1990-02-10",4405,"egestas.rhoncus@enimEtiam.ca","9888501159","P.O. Box 675, 377 Vestibulum St.","Vienna","5308","Wie",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21s2t1t0M","Miriam","Hakeem","Moreno","1992-05-23",19108,"orci@vestibulummassarutrum.edu","9003216228","Ap #138-3141 Luctus Rd.","Donosti","24-858","PV",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21x3a1i3J","Bree","Claire","Chapman","1986-07-18",4680,"Sed.auctor@velfaucibusid.com","9412709740","P.O. Box 837, 4488 Aliquam Road","Biała Podlaska","47537","LU",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21l5k8x1E","Malik","Camden","Herring","1989-03-23",13306,"metus.Aliquam.erat@miAliquamgravida.ca","9227971395","Ap #230-4882 Magnis Ave","Kungälv","3598","Västra Götalands län",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21o4j8t5J","Phillip","Dean","Osborn","1989-09-07",4769,"ipsum.Curabitur@Vivamuseuismod.edu","9806076158","P.O. Box 393, 5511 Posuere Avenue","Bastia","294893","CO",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21j4c1z0G","Fulton","Nayda","Ballard","1987-05-17",17371,"magnis.dis@auctornonfeugiat.edu","9580412612","2489 Nulla St.","Chillán","44060","Biobío",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21d6h1k4S","Bert","Stacey","Ortiz","1986-07-17",2935,"metus.urna@erategetipsum.net","9572393259","P.O. Box 212, 4004 Porta Av.","Fresno","7939","CA",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21j0i9h1D","Teegan","Fitzgerald","Bradley","1990-09-10",18549,"tellus.Phasellus@Aliquamrutrumlorem.com","9952037861","139-5832 Cras Av.","Konin","29339","Wielkopolskie",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21d1s2k3T","Dale","Lenore","Gray","1985-07-26",7263,"Etiam.bibendum.fermentum@sedfacilisis.co.uk","9553136469","Ap #768-4872 Donec Ave","Quesada","38-929","A",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21b1t4v6Y","Piper","Ulric","Jenkins","1987-09-12",19500,"rhoncus.Nullam.velit@idenim.net","9437293908","9755 Eu St.","Oklahoma City","93613","OK",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21q0l7k2S","Shad","Steven","Payne","1989-07-11",7120,"ultricies.dignissim@at.net","9956644186","501-2264 Libero Road","Casperia","22-620","LAZ",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21o5t8k4S","Dennis","Boris","Glover","1994-01-17",16852,"dolor@Sed.ca","9673169888","172-5897 Tellus Street","The Hague","56845","Z.",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21d8u1g3F","Nehru","Demetrius","Cardenas","1991-05-03",18197,"ipsum.Phasellus.vitae@dolornonummyac.edu","9826006485","5870 Mollis Av.","Fallais","477094","Luik",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21m0m8e1V","Jonah","Kenyon","Lynch","1985-09-19",2340,"augue.porttitor@Phasellusliberomauris.net","9677049962","525-8403 Massa. Ave","Independence","Z0976","Missouri",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21p9t3c7R","Kareem","Harding","Bishop","1992-01-31",18558,"enim@estarcuac.org","9244822916","445-6347 Consectetuer, Ave","Bucheon","53640","Gye",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21h2u9c3D","Chase","Jennifer","Dillon","1993-08-02",14137,"pretium@ut.co.uk","9310059780","466-6816 Lobortis Street","Maizeret","582844","Namen",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21a0l0g1L","Shea","Ursa","Pollard","1985-04-23",7707,"In.at@sedestNunc.co.uk","9075400894","Ap #994-6840 Nibh Road","Tranås","070290","Jönköpings län",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21l7l3r4Q","Chastity","Nicole","Salas","1992-12-26",16716,"lacus.vestibulum@lacusQuisquepurus.ca","9900357487","2743 Aptent St.","Bhimavaram","48073","AP",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21h9y4d8L","Vaughan","Troy","Foreman","1991-11-01",15230,"at.nisi@vulputate.co.uk","9863047543","909-6790 Consectetuer Street","Vetlanda","21170","F",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21p5a6t2C","MacKensie","Trevor","Crosby","1987-04-27",13540,"arcu@necmetus.edu","9729651309","Ap #335-2862 Curae; St.","Stargard Szczeciński","80461","ZP",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21g2z8f6O","Kiara","Colton","Murray","1986-03-27",15868,"quis@egestasSedpharetra.com","9156630220","735-3274 Odio Street","Kinrooi","3884","Limburg",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21i2l7f5H","Abigail","Ferdinand","Mckinney","1992-11-17",14976,"sit.amet.risus@tristique.com","9684542744","P.O. Box 874, 1428 Dignissim. Rd.","Saalfelden am Steinernen Meer","2588","Salzburg",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21q7x2g1S","Kalia","Nora","Maxwell","1985-05-06",16477,"eu.sem@elementum.edu","9835018010","401-2193 Consequat, Ave","Owensboro","36618","KY",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21i8x8f6M","Madonna","Anastasia","Lowe","1988-06-04",4173,"Lorem@molestieintempus.co.uk","9693088138","P.O. Box 832, 4565 Eget, Street","Nizip","83198","Gaziantep",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21l0r9l3V","Gareth","Emerson","Chen","1987-01-22",14805,"ipsum.nunc@maurisidsapien.co.uk","9421662861","721-9219 Et, Rd.","Canberra","1052","ACT",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21n5q6a4D","Willa","Morgan","Odom","1987-08-23",12228,"id.nunc@habitantmorbi.org","9803229369","4841 Lacus. Road","Ollagüe","393724","Antofagasta",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21c9w4e5V","Abdul","Yoko","Richard","1986-02-22",13592,"lacus@eu.ca","9467084708","9080 Dui St.","San José de Maipo","174307","RM",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21r1z4k2D","Autumn","Brock","Stanley","1993-11-26",19568,"varius@tellusjustosit.com","9932460794","P.O. Box 376, 1530 Amet, Road","Silvan","UJ09 3CW","Diyarbakır",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21p6v9u4N","Nehru","Emmanuel","Holder","1990-05-20",9798,"risus.Donec.egestas@felisNullatempor.com","9911322658","548-2326 Scelerisque, Av.","Cáceres","3604","EX",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21n7y2f4X","Whitney","Rigel","Mcguire","1992-12-03",12320,"vitae.mauris@pellentesque.co.uk","9851072491","503 Magna. Rd.","Beaconsfield","1141","Quebec",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21f7c9s5M","Levi","Ava","Massey","1991-01-22",19729,"Nunc@etcommodoat.edu","9790264568","722-9073 Diam Av.","Sukabumi","6557","West Java",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21d1n4r9Z","Vielka","Lacota","Cash","1991-02-17",16647,"in@dapibusrutrum.net","9758323017","Ap #558-4781 Nascetur Ave","Kapiti","909966","NI",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21z2k0g2Z","Mary","Akeem","Rush","1987-10-05",13096,"ultricies.adipiscing@cursus.ca","9278728795","Ap #936-6811 Elementum, Road","Ollagüe","59509","Antofagasta",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21g3m9s7I","Ora","Fredericka","Burke","1989-07-21",18918,"egestas.rhoncus.Proin@eu.com","9948353705","396-6470 Auctor Av.","Silchar","83531","AS",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21z3e6c2F","Mannix","September","Brady","1993-06-19",14749,"auctor.ullamcorper.nisl@pulvinararcu.co.uk","9648248573","3592 Eget Rd.","Tauranga","Z4501","NI",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21u0o9p4S","Cole","Amelia","Patton","1991-01-20",17682,"leo@orci.co.uk","9652770416","348-9333 Malesuada. Avenue","Vienna","87918","Wie",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21s7j5a6V","Alma","Ali","Coffey","1985-10-04",19536,"Sed.eu.eros@ornare.edu","9362515424","P.O. Box 789, 9503 Mus. Road","LaSalle","4466","Quebec",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21j2n0e0U","Marah","Mohammad","Ayala","1986-12-04",5353,"vel.est@euismodindolor.edu","9718133373","684 Fringilla. St.","Knittelfeld","6623 GL","Stm",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21j8o1a3G","Idona","Colette","Suarez","1987-06-15",6879,"hendrerit@pellentesqueSeddictum.org","9243482116","144-4213 Porttitor Rd.","Rennes","914158","BR",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21l8p2s9M","Nathaniel","Regina","Hamilton","1992-03-18",12548,"Donec@necenim.org","9522746831","Ap #844-3116 Lorem Rd.","Rea","51850-928","LOM",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21c5y3b3D","Frances","Dillon","Morgan","1990-08-25",2450,"in.lobortis.tellus@elementum.co.uk","9398247254","P.O. Box 666, 7686 Mauris. Rd.","Schaarbeek","54406","Brussels Hoofdstedelijk Gewest",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21i1b1u3K","Joel","Xena","Hoffman","1987-11-07",19857,"auctor.Mauris.vel@erosnon.net","9625158166","3237 Commodo Ave","Malakand","27-511","Khyber Pakhtoonkhwa",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21a5f4z0X","Adena","Ryan","Fields","1986-05-29",18252,"dapibus@non.ca","9525134994","P.O. Box 870, 2584 Accumsan Avenue","Galway","339848","C",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21x9j6r5J","Scott","Ivan","Adams","1992-12-26",5681,"neque.tellus.imperdiet@semperegestasurna.co.uk","9560468025","P.O. Box 685, 7234 Enim Av.","Toulouse","1656","Midi-Pyrénées",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21s9w5f1N","Kennedy","Hasad","Marks","1987-03-16",18101,"est@ultriciesadipiscing.net","9011647668","118-7265 Diam. Ave","Valcourt","61116","Quebec",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21p6r5h3T","Anjolie","Xanthus","Carey","1993-03-19",11059,"ac@blanditviverraDonec.co.uk","9211338187","587-3976 Suspendisse St.","Cessnock","E6R 9Z6","New South Wales",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21h9a5z8Y","Giacomo","Amal","Powers","1988-06-29",14431,"amet.dapibus@nonummy.ca","9008685387","7084 Fermentum Rd.","Gols","2005","Burgenland",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21y1u2m4V","Chloe","Keiko","Stein","1993-01-27",2206,"mattis.ornare@amet.com","9270661187","323-1526 A, Av.","Ansan","36516","Gyeonggi",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21z2d7c5Q","Germaine","Arthur","Ruiz","1990-07-15",2550,"interdum.libero@vulputate.edu","9916011177","P.O. Box 714, 8967 Parturient St.","Tambov","0979","Tambov Oblast",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21o1f7t9Z","Marny","Ezekiel","Pickett","1986-01-20",13663,"ut.mi@risusIn.edu","9797385712","Ap #946-1670 Dictum Street","Boulogne-Billancourt","35-499","Île-de-France",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21b7l9f4G","Geoffrey","Violet","Noel","1992-06-07",19098,"sed.pede.nec@egestashendrerit.com","9322628073","798-1885 Suscipit Road","South Bend","3243 IZ","Indiana",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21o0p9v2G","Price","Clayton","Hopkins","1991-06-10",18145,"semper.egestas@semsempererat.ca","9404429638","P.O. Box 935, 8202 Laoreet Rd.","Boo","682272","Stockholms län",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21j0t6i5Q","Cheyenne","Tyler","Goodwin","1989-09-20",11643,"molestie@taciti.co.uk","9709375307","595-5387 Eu, Street","Haveli","J1E 0E4","Azad Kashmir",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21r0h1t2L","Elmo","Buffy","Spencer","1989-07-14",12325,"venenatis@orcilobortisaugue.edu","9047321578","9678 Libero Ave","Okara","63610","SI",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21i8g8k3M","Clark","Valentine","Parks","1989-05-04",7747,"a.felis.ullamcorper@Aenean.edu","9542090196","800 Blandit St.","Iquitos","99082","Loreto",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21z1v3d9J","Gil","Odette","Mccoy","1993-05-18",17404,"aptent@mollis.ca","9447680516","9996 Imperdiet St.","Semarang","3787 EP","Central Java",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21i1d0e4O","Alma","Nolan","King","1985-09-06",7449,"interdum.enim.non@eleifend.net","9370397212","P.O. Box 116, 7471 Nec Av.","Istanbul","77887","Istanbul",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21x8u8t1N","Burton","Flynn","Benson","1991-03-12",16962,"Sed.eu.nibh@conubia.net","9604897927","3285 Ullamcorper Av.","Doetinchem","04740","Gl",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21h2g2o2Z","Wendy","Hedda","Hancock","1987-12-14",15117,"erat@aceleifend.net","9358254134","4847 Nunc Rd.","Thames","109196","NI",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21o2l9d5N","Juliet","Calvin","Booker","1988-12-03",12443,"dui@vestibulumloremsit.net","9758241139","P.O. Box 405, 3317 At, Street","Côte Saint-Luc","663255","QC",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21b5c7q0B","Helen","Caesar","Hopkins","1985-02-27",17973,"eu@gravidaAliquam.edu","9555588733","Ap #535-9558 Sit Rd.","Ludvika","Z7499","Dalarnas län",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21f2w0f2G","Sierra","Kamal","Meadows","1993-02-02",2803,"at.velit@consequatpurus.edu","9350601550","Ap #189-2963 Suscipit Street","León","Z1828","Gto",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21e6i6i6N","Joseph","Tanner","Wells","1992-06-19",11641,"Integer@Quisquefringillaeuismod.org","9095532273","Ap #643-9312 Elit, Ave","Guadalupe","Z11 9XL","LAL",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21p9e2x7Z","Oprah","Zahir","Ruiz","1992-06-22",6447,"ornare.In.faucibus@euismod.com","9747267321","518-6420 Ornare Ave","Okene","81267","KO",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21o0f4s7Z","Lenore","Maris","Morales","1992-03-26",7395,"diam.at@liberoest.net","9370698818","Ap #217-717 Fusce Avenue","Kidwelly","2907","Carmarthenshire",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21z8z0v1D","Catherine","Dane","Hunter","1987-09-02",9409,"augue@atfringillapurus.net","9641942117","595-8906 Donec Avenue","Pabianice","63278","łódzkie",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21j1a5t0U","Ishmael","Roth","Carver","1990-01-06",12063,"dui.Fusce.aliquam@Proin.edu","9166779407","Ap #295-5242 Consequat Rd.","Cartagena","696325","Bolívar",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21l8k8k9L","Charles","Joshua","Miles","1989-06-13",10488,"dui.Fusce.diam@scelerisqueneque.ca","9917414954","Ap #723-702 Vitae Road","Kallo","67009-273","OV",1);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21y2q1v1W","Melanie","Myles","Puckett","1991-10-12",6281,"magna.malesuada@at.com","9010508355","Ap #906-4074 Nullam Avenue","Ludvika","Z4406","Dalarnas län",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21i3i4o2O","Harriet","Tanek","Neal","1988-08-28",8982,"elit.Curabitur@Integer.net","9567907932","Ap #102-6340 In, Rd.","Guelph","25-293","ON",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21d3y2f0U","Cameron","Mannix","Chambers","1985-11-05",16424,"volutpat@orciquislectus.net","9850178650","483-9469 Pede. Road","Nizhny","124209","NIZ",0);
INSERT INTO `IndividualClients` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`budget`,`emailID`,`phoneNumber`,`streetName`,`city`,`pincode`,`state`,`isClient`) VALUES ("I21r6i4t5D","Hayfa","Kenyon","Lott","1990-11-27",5829,"congue@accumsan.net","9657452426","493-5137 Eu Av.","Oss","7241","N.",0);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21r4a1b6X","Ayanna","Lane","Wilson","1987-03-09","Female",14088,5,33,10,9,"massa@eu.com","9680738063","Partner",93,"Ap #745-1084 Interdum Av.","Bremen","69387","HB","LGBTQ Law",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21a7z0h2V","Ethan","Alea","Puckett","1993-08-19","Others",14906,21,79,65,25,"adipiscing@vitae.co.uk","9890026165","Partner",59,"100-9866 Lobortis Avenue","Cork","51288","M","Communications and Media",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u5w0u4X","Hilda","Nigel","Holder","1993-10-12","Female",11375,19,99,49,17,"ligula.Nullam.feugiat@enim.com","9474722901","Associate",22,"3280 Aliquam Road","Mataram","Z1153","NB","",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21j6o5f1F","Ulric","Stewart","Mcdaniel","1988-05-21","Male",18342,100,85,10,9,"massa.Suspendisse.eleifend@tellus.org","9946118939","Lawyer",69,"1025 Diam. Ave","Lonquimay","48503","IX","Wrongful Death",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21k2l6c5D","Eagan","Harlan","Parsons","1987-04-25","Male",19152,1,91,6,20,"nunc.sed@Aliquamerat.com","9960478835","Partner",83,"7596 Consequat Rd.","Oaxaca","683979","Oaxaca","Wills and Probate",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21d1o5j7F","Kelly","Maisie","Munoz","1985-12-16","Female",5099,54,55,12,3,"Donec.tempus@dictumeu.org","9187317580","Paralegal",50,"9327 Consequat Ave","Envigado","OS96 7CP","Antioquia","Education",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y0e3o6E","Walker","Mia","Ellis","1989-09-12","Male",14992,36,68,40,14,"vel.faucibus@vitaealiquameros.com","9485555909","Partner",95,"203-4421 Semper St.","Penza","442418","Penza Oblast","Sports Law",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21e4d9u7O","Patricia","Lane","Roach","1988-07-28","Female",3602,73,21,62,11,"eget.magna@enimEtiamimperdiet.ca","9994278451","Paralegal",41,"668 Nibh Ave","Cambridge","4748","NI","Copyrights and Patents",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21i6h2v4R","Hilary","Graiden","Mckee","1990-09-01","Female",14576,12,90,78,5,"pede@malesuadavelvenenatis.org","9516828497","Associate",51,"357-4488 Suspendisse Av.","Launceston","M2Z 4E4","TAS","Education",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u4f4u7F","Emery","Vivien","Harris","1985-04-12","Others",8658,38,68,62,15,"iaculis@Donec.ca","9659606228","Partner",69,"1089 Ipsum Avenue","Sneek","4037","Friesland","Bankruptcy",3);



INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21r4a1b6X","Ayanna","Lane","Wilson","1987-03-09","Female",14088,5,33,10,9,"massa@eu.com","9680738063","Partner",93,"Ap #745-1084 Interdum Av.","Bremen","69387","HB","Tenant Law",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21a7z0h2V","Ethan","Alea","Puckett","1993-08-19","Others",14906,21,79,65,25,"adipiscing@vitae.co.uk","9890026165","Partner",59,"100-9866 Lobortis Avenue","Cork","51288","M","Tenant Law",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u5w0u4X","Hilda","Nigel","Holder","1993-10-12","Female",11375,19,99,49,17,"ligula.Nullam.feugiat@enim.com","9474722901","Associate",22,"3280 Aliquam Road","Mataram","Z1153","Delhi","Tenant Law",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21j6o5f1F","Ulric","Stewart","Mcdaniel","1988-05-21","Male",18342,100,85,10,9,"massa.Suspendisse.eleifend@tellus.org","9946118939","Lawyer",69,"1025 Diam. Ave","Lonquimay","48503","IX","Tenant Law",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21k2l6c5D","Eagan","Harlan","Parsons","1987-04-25","Male",19152,1,91,6,20,"nunc.sed@Aliquamerat.com","9960478835","Partner",83,"7596 Consequat Rd.","Oaxaca","683979","Oaxaca","Tenant Law",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21d1o5j7F","Kelly","Maisie","Munoz","1985-12-16","Female",5099,54,55,12,3,"Donec.tempus@dictumeu.org","9187317580","Paralegal",50,"9327 Consequat Ave","Envigado","OS96 7CP","Antioquia","Tenant Law",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y0e3o6E","Walker","Mia","Ellis","1989-09-12","Male",14992,36,68,40,14,"vel.faucibus@vitaealiquameros.com","9485555909","Partner",95,"203-4421 Semper St.","Penza","442418","Penza Oblast","Tenant Law",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21e4d9u7O","Patricia","Lane","Roach","1988-07-28","Female",3602,73,21,62,11,"eget.magna@enimEtiamimperdiet.ca","9994278451","Paralegal",41,"668 Nibh Ave","Cambridge","4748","NI","Tenant Law",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21i6h2v4R","Hilary","Graiden","Mckee","1990-09-01","Female",14576,12,90,78,5,"pede@malesuadavelvenenatis.org","9516828497","Associate",51,"357-4488 Suspendisse Av.","Launceston","M2Z 4E4","TAS","Tenant Law",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u4f4u7F","Emery","Vivien","Harris","1985-04-12","Others",8658,38,68,62,15,"iaculis@Donec.ca","9659606228","Partner",69,"1089 Ipsum Avenue","Sneek","4037","Friesland","Tenant Law",3);


INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21r4a1b6X","Ayanna","Lane","Wilson","1987-03-09","Female",14088,5,33,10,9,"massa@eu.com","9680738063","Partner",93,"Ap #745-1084 Interdum Av.","Bremen","69387","HB","Real Estate",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21a7z0h2V","Ethan","Alea","Puckett","1993-08-19","Others",14906,21,79,65,25,"adipiscing@vitae.co.uk","9890026165","Partner",59,"100-9866 Lobortis Avenue","Cork","51288","M","Real Estate",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u5w0u4X","Hilda","Nigel","Holder","1993-10-12","Female",11375,19,99,49,17,"ligula.Nullam.feugiat@enim.com","9474722901","Associate",22,"3280 Aliquam Road","Mataram","Z1153","Delhi","Real Estate",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21j6o5f1F","Ulric","Stewart","Mcdaniel","1988-05-21","Male",18342,100,85,10,9,"massa.Suspendisse.eleifend@tellus.org","9946118939","Lawyer",69,"1025 Diam. Ave","Lonquimay","48503","IX","Real Estate",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21k2l6c5D","Eagan","Harlan","Parsons","1987-04-25","Male",19152,1,91,6,20,"nunc.sed@Aliquamerat.com","9960478835","Partner",83,"7596 Consequat Rd.","Oaxaca","683979","Oaxaca","Real Estate",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21d1o5j7F","Kelly","Maisie","Munoz","1985-12-16","Female",5099,54,55,12,3,"Donec.tempus@dictumeu.org","9187317580","Paralegal",50,"9327 Consequat Ave","Envigado","OS96 7CP","Antioquia","Real Estate",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y0e3o6E","Walker","Mia","Ellis","1989-09-12","Male",14992,36,68,40,14,"vel.faucibus@vitaealiquameros.com","9485555909","Partner",95,"203-4421 Semper St.","Penza","442418","Penza Oblast","Real Estate",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21e4d9u7O","Patricia","Lane","Roach","1988-07-28","Female",3602,73,21,62,11,"eget.magna@enimEtiamimperdiet.ca","9994278451","Paralegal",41,"668 Nibh Ave","Cambridge","4748","NI","Real Estate",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21i6h2v4R","Hilary","Graiden","Mckee","1990-09-01","Female",14576,12,90,78,5,"pede@malesuadavelvenenatis.org","9516828497","Associate",51,"357-4488 Suspendisse Av.","Launceston","M2Z 4E4","TAS","Real Estate",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u4f4u7F","Emery","Vivien","Harris","1985-04-12","Others",8658,38,68,62,15,"iaculis@Donec.ca","9659606228","Partner",69,"1089 Ipsum Avenue","Sneek","4037","Friesland","Real Estate",3);



INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21k9e0m9D","Winifred","Carla","Holder","1990-03-20","Others",9026,46,91,10,11,"orci.luctus@nislelementum.ca","9672356748","Associate",87,"Ap #589-998 Dis St.","Hamburg","0669427521","HH","Finance",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21x6i8r4X","Jordan","Cedric","Parker","1985-06-28","Male",3813,70,68,33,5,"scelerisque.neque@pharetra.com","9470449283","Lawyer",22,"Ap #576-305 Massa Av.","Cambridge","14-081","North Island","Whistleblower Litigation",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21b7y0r2S","Isabelle","Xerxes","Mays","1986-04-26","Female",18875,40,86,54,25,"neque.sed@loremipsum.org","9794117874","Paralegal",20,"727-8621 Sed, St.","Bydgoszcz","28130","Kujawsko-pomorskie","Copyrights and Patents",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u5j4l6F","Theodore","Ann","Mason","1985-07-26","Male",6128,2,46,86,15,"dapibus.quam@libero.org","9810880450","Lawyer",48,"9209 Eget St.","Stonewall","17077","MB","Drug Crimes",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21t8y1o3Z","Geoffrey","Craig","Buckley","1988-07-18","Others",19238,32,48,35,12,"varius@vitae.ca","9636174735","Associate",98,"5838 Mauris, Ave","Dublin","0611 QI","L","Child Custody",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21n6o6k0N","Haviva","Alice","Carroll","1988-10-08","Female",17538,93,24,59,5,"vel.sapien@sociis.com","9323243487","Lawyer",80,"Ap #173-6440 A, Rd.","Sterling Heights","70500","Michigan","Wills and Probate",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21a0f5x5M","Sigourney","Talon","Houston","1990-04-14","Female",2839,5,2,27,9,"odio@auctornon.net","9481049928","Lawyer",82,"4460 Dictum Ave","Gary","09393","Indiana","Visitation Rights",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21h9m7x7T","Cairo","Britanni","Mcgee","1991-08-11","Others",7716,82,28,8,19,"mauris.sapien@Nam.ca","9694887749","Paralegal",52,"4226 Tincidunt Av.","Kalisz","5452 TF","Wielkopolskie","Wills and Probate",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21s9n5a5A","Giselle","Astra","Hanson","1989-10-22","Male",19792,14,57,19,20,"vestibulum.lorem@ornarelibero.co.uk","9900412440","Paralegal",38,"P.O. Box 759, 6311 Arcu Avenue","Cirebon","6444871126","West Java","LGBTQ Law",4);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21v1p2x4V","Lucy","Paul","Howe","1987-06-13","Female",19828,96,62,96,9,"ultrices.sit.amet@Nullam.edu","9775318899","Associate",64,"Ap #476-3492 Consectetuer Street","San Rafael","B0B 4J4","A","Wrongful Death",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21q7h0u0E","Ivory","Ann","Fletcher","1988-01-25","Male",12875,3,9,87,13,"sem.eget.massa@nectempusmauris.org","9879571707","Associate",53,"Ap #826-9735 Ornare Rd.","Tongyeong","26265","South Gyeongsang","Finance",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21t0s5w9W","Fredericka","Eaton","Guy","1989-03-26","Others",10101,56,23,82,6,"nec.quam.Curabitur@sociosquadlitora.edu","9374138515","Associate",60,"207-8436 Ipsum St.","Galway","4498","Connacht","Whistleblower Litigation",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21c9u5e3I","Keefe","Carla","Gray","1987-04-06","Female",13098,46,90,35,3,"consectetuer@Seddiam.ca","9524534655","Paralegal",34,"7307 Vitae Ave","Swan Hill","12770-01231","VIC","Labour and Employment",1);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21m3s3v7H","Hammett","Aiko","Howe","1991-11-20","Male",7458,59,71,73,25,"faucibus.orci@mollisDuis.co.uk","9857759360","Associate",30,"455-8498 Posuere Rd.","Bandırma","2017","Balıkesir","LGBTQ Law",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21n2c2u6B","Dorothy","Aiko","Sawyer","1987-10-20","Others",11091,74,44,89,9,"vestibulum.neque@noncursus.net","9310203381","Partner",80,"444-2610 Porttitor Ave","Moircy","91758","LX","Finance",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21e0f5s5Z","Maryam","Raymond","Stephenson","1990-02-07","Others",19168,92,81,45,20,"ornare.placerat@lacusUtnec.com","9359518083","Paralegal",51,"P.O. Box 604, 3545 Mauris Rd.","Antakya","105151","Hatay","Medical Malpractice",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21g0p1y1W","Isaiah","Quentin","Owens","1990-09-02","Female",3903,98,82,16,4,"elit.Etiam@Cumsociis.edu","9187892936","Partner",93,"8715 Elit Road","Harlech","50622","ME","Labour and Employment",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21n8n7m3C","Reuben","Aiko","Blevins","1990-10-27","Others",5716,14,60,52,2,"porta.elit@sodalesnisimagna.ca","9793128025","Associate",85,"3974 Aliquet, St.","Dublin","5738","L","Civil",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y0y7o4V","Lavinia","Katell","Mccall","1986-01-04","Others",19415,66,17,63,14,"Maecenas.libero@felis.ca","9554024257","Partner",85,"1514 Ipsum Street","Sangju","34978","North Gyeongsang","Restraining Orders",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21p8y2h4F","Thaddeus","Adara","Jackson","1989-09-07","Female",3183,93,74,90,9,"nec.diam@sodalesnisi.org","9282993893","Partner",78,"P.O. Box 857, 7104 Amet Rd.","Chapecó","96965","Santa Catarina","Whistleblower Litigation",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21l5x6o0T","Malachi","Angelica","Brooks","1991-10-26","Female",17453,78,33,39,20,"Morbi.metus.Vivamus@fermentumfermentum.edu","9602519821","Partner",76,"7869 Auctor Rd.","Whyalla","320221","South Australia","Traffic Law",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21r8g4t8B","Armand","Roth","Cardenas","1991-02-07","Others",5254,11,82,23,11,"ipsum.cursus@nasceturridiculusmus.co.uk","9499133510","Lawyer",80,"7915 Adipiscing St.","Groot-Bijgaarden","9784","Vlaams-Brabant","Finance",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21x5n7u2H","Kiayada","Noble","Reyes","1993-01-22","Male",13270,7,82,99,5,"neque@dolordapibus.com","9604325983","Lawyer",91,"P.O. Box 770, 281 Dolor. Av.","Caruaru","5886","PE","Copyrights and Patents",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y6d3d4X","Wynter","Cameron","Dixon","1990-12-31","Female",13312,2,5,55,25,"consectetuer.cursus@Suspendisse.net","9756634769","Associate",32,"Ap #406-4488 Donec Rd.","Erdemli","85858","Mersin","Income Tax",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21x1j9n0G","Kennan","Scarlett","Tyson","1993-05-23","Others",7994,5,7,37,20,"ullamcorper.viverra.Maecenas@lobortis.net","9887432896","Paralegal",57,"Ap #906-4211 Mauris Road","El Quisco","31123","Valparaíso","Income Tax",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21k7w6w1Y","Samuel","Amir","Moreno","1992-10-02","Female",16016,29,45,26,17,"Curabitur@lacus.net","9976029934","Associate",63,"Ap #228-2675 Aliquet, Rd.","Ribeirão Preto","49-259","SP","Child Custody",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21a3c6t8L","Malachi","Rina","Sherman","1989-02-09","Others",19947,80,99,99,3,"metus.Vivamus.euismod@est.co.uk","9904138158","Lawyer",67,"962-2346 Primis Av.","Carmen de Bolivar","4906 JC","Bolívar","Family Law",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y2r4m4Q","Henry","Hanna","Buckner","1987-02-06","Others",12888,20,3,50,16,"bibendum.Donec@egestasadui.net","9238855605","Partner",77,"2934 Commodo Av.","Collipulli","2295","Araucanía","Politics",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u9i4t8B","Lamar","Jerry","Mack","1990-05-23","Male",4792,22,96,12,21,"magnis@elementum.com","9080189185","Associate",33,"617-9820 Dis Ave","San Polo d'Enza","210553","ERM","Drug Crimes",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u8d9m8Y","Christian","Yael","Wall","1993-08-14","Male",4693,29,83,50,3,"Sed.id.risus@mi.ca","9658862747","Partner",62,"Ap #496-6630 Risus. Ave","Monterrey","963517","Nuevo León","Felony",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u2k4c8X","Chase","Kerry","Riddle","1989-03-20","Others",9688,75,65,81,1,"molestie.tortor.nibh@pharetrautpharetra.net","9388777253","Partner",39,"658-1140 A Ave","GomzŽ-Andoumont","20258","LU","Felony",1);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21r5r4s7U","Dana","Barry","Rosario","1988-03-18","Male",5157,21,35,16,4,"Sed.eget.lacus@risusatfringilla.ca","9701760983","Associate",44,"P.O. Box 153, 3313 Suspendisse Street","Haldia","3370 GE","WB","Drug Crimes",4);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21z0c9m4N","Hedley","Carissa","Blanchard","1989-02-18","Male",17057,25,48,3,11,"torquent.per@natoque.org","9311083602","Partner",37,"900-5060 Tellus Rd.","Pontevedra","05981","Galicia","Health Insurance",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21s1c6q8Z","Gregory","Nash","Fitzgerald","1987-03-01","Female",13559,59,65,63,25,"elit.elit.fermentum@nonnisiAenean.co.uk","9106408795","Paralegal",24,"101 Purus, Rd.","Hamilton","369499","North Island","Family Law",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21v4l9p0Q","Zane","Addison","Greer","1990-07-17","Male",9458,32,12,72,7,"Sed.dictum.Proin@Nunc.co.uk","9240912464","Paralegal",23,"Ap #605-4034 Ac Rd.","Hoofddorp","42090","Noord Holland","Finance",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u6a1c4F","Justine","Harding","Gilmore","1990-02-09","Male",9386,65,63,52,24,"porttitor.vulputate@augue.org","9944775582","Associate",60,"2790 Dolor. Avenue","Istanbul","89326","Istanbul","Crime",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21b3w5m9Q","Mona","Kevin","Abbott","1993-11-29","Female",2971,66,68,60,25,"vulputate.velit@pede.org","9142961813","Partner",82,"521-4828 Aenean St.","Vienna","15747","Vienna","Military Law",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21z1d3m8Y","Ruby","Cole","Warner","1993-05-05","Others",3110,29,36,31,20,"egestas@nuncnullavulputate.edu","9187789966","Paralegal",96,"Ap #212-1115 Tincidunt. St.","Istanbul","54189","Istanbul","Sports Law",3);


INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21k9e0m9D","Winifred","Carla","Holder","1990-03-20","Others",9026,46,91,10,11,"orci.luctus@nislelementum.ca","9672356748","Associate",87,"Ap #589-998 Dis St.","Hamburg","06694-27521","HH","Construction Law",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21x6i8r4X","Jordan","Cedric","Parker","1985-06-28","Male",3813,70,68,33,5,"scelerisque.neque@pharetra.com","9470449283","Lawyer",22,"Ap #576-305 Massa Av.","Cambridge","14-081","North Island","Construction Law",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21b7y0r2S","Isabelle","Xerxes","Mays","1986-04-26","Female",18875,40,86,54,25,"neque.sed@loremipsum.org","9794117874","Paralegal",20,"727-8621 Sed, St.","Bydgoszcz","28130","Kujawsko-pomorskie","Construction Law",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u5j4l6F","Theodore","Ann","Mason","1985-07-26","Male",6128,2,46,86,15,"dapibus.quam@libero.org","9810880450","Lawyer",48,"9209 Eget St.","Stonewall","17077","MB","Construction Law",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21t8y1o3Z","Geoffrey","Craig","Buckley","1988-07-18","Others",19238,32,48,35,12,"varius@vitae.ca","9636174735","Associate",98,"5838 Mauris, Ave","Dublin","0611 QI","L","Construction Law",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21n6o6k0N","Haviva","Alice","Carroll","1988-10-08","Female",17538,93,24,59,5,"vel.sapien@sociis.com","9323243487","Lawyer",80,"Ap #173-6440 A, Rd.","Sterling Heights","70500","Michigan","Construction Law",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21a0f5x5M","Sigourney","Talon","Houston","1990-04-14","Female",2839,5,2,27,9,"odio@auctornon.net","9481049928","Lawyer",82,"4460 Dictum Ave","Gary","09393","Indiana","Construction Law",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21h9m7x7T","Cairo","Britanni","Mcgee","1991-08-11","Others",7716,82,28,8,19,"mauris.sapien@Nam.ca","9694887749","Paralegal",52,"4226 Tincidunt Av.","Kalisz","5452 TF","Wielkopolskie","Construction Law",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21s9n5a5A","Giselle","Astra","Hanson","1989-10-22","Male",19792,14,57,19,20,"vestibulum.lorem@ornarelibero.co.uk","9900412440","Paralegal",38,"P.O. Box 759, 6311 Arcu Avenue","Cirebon","64448-71126","West Java","Construction Law",4);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21v1p2x4V","Lucy","Paul","Howe","1987-06-13","Female",19828,96,62,96,9,"ultrices.sit.amet@Nullam.edu","9775318899","Associate",64,"Ap #476-3492 Consectetuer Street","San Rafael","B0B 4J4","A","Construction Law",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21q7h0u0E","Ivory","Ann","Fletcher","1988-01-25","Male",12875,3,9,87,13,"sem.eget.massa@nectempusmauris.org","9879571707","Associate",53,"Ap #826-9735 Ornare Rd.","Tongyeong","26265","South Gyeongsang","Construction Law",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21t0s5w9W","Fredericka","Eaton","Guy","1989-03-26","Others",10101,56,23,82,6,"nec.quam.Curabitur@sociosquadlitora.edu","9374138515","Associate",60,"207-8436 Ipsum St.","Galway","4498","Connacht","Construction Law",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21c9u5e3I","Keefe","Carla","Gray","1987-04-06","Female",13098,46,90,35,3,"consectetuer@Seddiam.ca","9524534655","Paralegal",34,"7307 Vitae Ave","Swan Hill","12770-01231","VIC","Construction Law",1);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21m3s3v7H","Hammett","Aiko","Howe","1991-11-20","Male",7458,59,71,73,25,"faucibus.orci@mollisDuis.co.uk","9857759360","Associate",30,"455-8498 Posuere Rd.","Bandırma","2017","Balıkesir","Construction Law",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21n2c2u6B","Dorothy","Aiko","Sawyer","1987-10-20","Others",11091,74,44,89,9,"vestibulum.neque@noncursus.net","9310203381","Partner",80,"444-2610 Porttitor Ave","Moircy","91758","LX","Construction Law",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21e0f5s5Z","Maryam","Raymond","Stephenson","1990-02-07","Others",19168,92,81,45,20,"ornare.placerat@lacusUtnec.com","9359518083","Paralegal",51,"P.O. Box 604, 3545 Mauris Rd.","Antakya","105151","Hatay","Construction Law",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21g0p1y1W","Isaiah","Quentin","Owens","1990-09-02","Female",3903,98,82,16,4,"elit.Etiam@Cumsociis.edu","9187892936","Partner",93,"8715 Elit Road","Harlech","50622","ME","Construction Law",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21n8n7m3C","Reuben","Aiko","Blevins","1990-10-27","Others",5716,14,60,52,2,"porta.elit@sodalesnisimagna.ca","9793128025","Associate",85,"3974 Aliquet, St.","Dublin","5738","L","Construction Law",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y0y7o4V","Lavinia","Katell","Mccall","1986-01-04","Others",19415,66,17,63,14,"Maecenas.libero@felis.ca","9554024257","Partner",85,"1514 Ipsum Street","Sangju","34978","North Gyeongsang","Construction Law",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21p8y2h4F","Thaddeus","Adara","Jackson","1989-09-07","Female",3183,93,74,90,9,"nec.diam@sodalesnisi.org","9282993893","Partner",78,"P.O. Box 857, 7104 Amet Rd.","Chapecó","96965","Santa Catarina","Construction Law",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21l5x6o0T","Malachi","Angelica","Brooks","1991-10-26","Female",17453,78,33,39,20,"Morbi.metus.Vivamus@fermentumfermentum.edu","9602519821","Partner",76,"7869 Auctor Rd.","Whyalla","320221","South Australia","Construction Law",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21r8g4t8B","Armand","Roth","Cardenas","1991-02-07","Others",5254,11,82,23,11,"ipsum.cursus@nasceturridiculusmus.co.uk","9499133510","Lawyer",80,"7915 Adipiscing St.","Groot-Bijgaarden","9784","Vlaams-Brabant","Construction Law",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21x5n7u2H","Kiayada","Noble","Reyes","1993-01-22","Male",13270,7,82,99,5,"neque@dolordapibus.com","9604325983","Lawyer",91,"P.O. Box 770, 281 Dolor. Av.","Caruaru","5886","PE","Construction Law",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y6d3d4X","Wynter","Cameron","Dixon","1990-12-31","Female",13312,2,5,55,25,"consectetuer.cursus@Suspendisse.net","9756634769","Associate",32,"Ap #406-4488 Donec Rd.","Erdemli","85858","Mersin","Construction Law",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21x1j9n0G","Kennan","Scarlett","Tyson","1993-05-23","Others",7994,5,7,37,20,"ullamcorper.viverra.Maecenas@lobortis.net","9887432896","Paralegal",57,"Ap #906-4211 Mauris Road","El Quisco","31123","Valparaíso","Construction Law",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21k7w6w1Y","Samuel","Amir","Moreno","1992-10-02","Female",16016,29,45,26,17,"Curabitur@lacus.net","9976029934","Associate",63,"Ap #228-2675 Aliquet, Rd.","Ribeirão Preto","49-259","SP","Construction Law",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21a3c6t8L","Malachi","Rina","Sherman","1989-02-09","Others",19947,80,99,99,3,"metus.Vivamus.euismod@est.co.uk","9904138158","Lawyer",67,"962-2346 Primis Av.","Carmen de Bolivar","4906 JC","Bolívar","Construction Law",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y2r4m4Q","Henry","Hanna","Buckner","1987-02-06","Others",12888,20,3,50,16,"bibendum.Donec@egestasadui.net","9238855605","Partner",77,"2934 Commodo Av.","Collipulli","2295","Araucanía","Construction Law",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u9i4t8B","Lamar","Jerry","Mack","1990-05-23","Male",4792,22,96,12,21,"magnis@elementum.com","9080189185","Associate",33,"617-9820 Dis Ave","San Polo d'Enza","210553","ERM","Construction Law",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u8d9m8Y","Christian","Yael","Wall","1993-08-14","Male",4693,29,83,50,3,"Sed.id.risus@mi.ca","9658862747","Partner",62,"Ap #496-6630 Risus. Ave","Monterrey","963517","Nuevo León","Construction Law",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u2k4c8X","Chase","Kerry","Riddle","1989-03-20","Others",9688,75,65,81,1,"molestie.tortor.nibh@pharetrautpharetra.net","9388777253","Partner",39,"658-1140 A Ave","GomzŽ-Andoumont","20258","LU","Construction Law",1);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21r5r4s7U","Dana","Barry","Rosario","1988-03-18","Male",5157,21,35,16,4,"Sed.eget.lacus@risusatfringilla.ca","9701760983","Associate",44,"P.O. Box 153, 3313 Suspendisse Street","Haldia","3370 GE","WB","Construction Law",4);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21z0c9m4N","Hedley","Carissa","Blanchard","1989-02-18","Male",17057,25,48,3,11,"torquent.per@natoque.org","9311083602","Partner",37,"900-5060 Tellus Rd.","Pontevedra","05981","Galicia","Construction Law",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21s1c6q8Z","Gregory","Nash","Fitzgerald","1987-03-01","Female",13559,59,65,63,25,"elit.elit.fermentum@nonnisiAenean.co.uk","9106408795","Paralegal",24,"101 Purus, Rd.","Hamilton","369499","North Island","Construction Law",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21v4l9p0Q","Zane","Addison","Greer","1990-07-17","Male",9458,32,12,72,7,"Sed.dictum.Proin@Nunc.co.uk","9240912464","Paralegal",23,"Ap #605-4034 Ac Rd.","Hoofddorp","42090","Noord Holland","Construction Law",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u6a1c4F","Justine","Harding","Gilmore","1990-02-09","Male",9386,65,63,52,24,"porttitor.vulputate@augue.org","9944775582","Associate",60,"2790 Dolor. Avenue","Istanbul","89326","Istanbul","Construction Law",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21b3w5m9Q","Mona","Kevin","Abbott","1993-11-29","Female",2971,66,68,60,25,"vulputate.velit@pede.org","9142961813","Partner",82,"521-4828 Aenean St.","Vienna","15747","Vienna","Construction Law",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21z1d3m8Y","Ruby","Cole","Warner","1993-05-05","Others",3110,29,36,31,20,"egestas@nuncnullavulputate.edu","9187789966","Paralegal",96,"Ap #212-1115 Tincidunt. St.","Istanbul","54189","Istanbul","Construction Law",3);




INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21k9e0m9D","Winifred","Carla","Holder","1990-03-20","Others",9026,46,91,10,11,"orci.luctus@nislelementum.ca","9672356748","Associate",87,"Ap #589-998 Dis St.","Hamburg","06694-27521","HH","Finance and Banking",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21x6i8r4X","Jordan","Cedric","Parker","1985-06-28","Male",3813,70,68,33,5,"scelerisque.neque@pharetra.com","9470449283","Lawyer",22,"Ap #576-305 Massa Av.","Cambridge","14-081","North Island","Buisness Law",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21b7y0r2S","Isabelle","Xerxes","Mays","1986-04-26","Female",18875,40,86,54,25,"neque.sed@loremipsum.org","9794117874","Paralegal",20,"727-8621 Sed, St.","Bydgoszcz","28130","Kujawsko-pomorskie","Closer",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u5j4l6F","Theodore","Ann","Mason","1985-07-26","Male",6128,2,46,86,15,"dapibus.quam@libero.org","9810880450","Lawyer",48,"9209 Eget St.","Stonewall","17077","MB","Buisness Law",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21t8y1o3Z","Geoffrey","Craig","Buckley","1988-07-18","Others",19238,32,48,35,12,"varius@vitae.ca","9636174735","Associate",98,"5838 Mauris, Ave","Dublin","0611 QI","L","ChildCustody",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21n6o6k0N","Haviva","Alice","Carroll","1988-10-08","Female",17538,93,24,59,5,"vel.sapien@sociis.com","9323243487","Lawyer",80,"Ap #173-6440 A, Rd.","Sterling Heights","70500","Michigan","WillsProbate",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21a0f5x5M","Sigourney","Talon","Houston","1990-04-14","Female",2839,5,2,27,9,"odio@auctornon.net","9481049928","Lawyer",82,"4460 Dictum Ave","Gary","09393","Indiana","VisitationRights",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21h9m7x7T","Cairo","Britanni","Mcgee","1991-08-11","Others",7716,82,28,8,19,"mauris.sapien@Nam.ca","9694887749","Paralegal",52,"4226 Tincidunt Av.","Kalisz","5452 TF","Wielkopolskie","Finances",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21s9n5a5A","Giselle","Astra","Hanson","1989-10-22","Male",19792,14,57,19,20,"vestibulum.lorem@ornarelibero.co.uk","9900412440","Paralegal",38,"P.O. Box 759, 6311 Arcu Avenue","Cirebon","64448-71126","West Java","Banking",4);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21v1p2x4V","Lucy","Paul","Howe","1987-06-13","Female",19828,96,62,96,9,"ultrices.sit.amet@Nullam.edu","9775318899","Associate",64,"Ap #476-3492 Consectetuer Street","San Rafael","B0B 4J4","A","Drug Crime",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21q7h0u0E","Ivory","Ann","Fletcher","1988-01-25","Male",12875,3,9,87,13,"sem.eget.massa@nectempusmauris.org","9879571707","Associate",53,"Ap #826-9735 Ornare Rd.","Tongyeong","26265","South Gyeongsang","Finance and Banking",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21t0s5w9W","Fredericka","Eaton","Guy","1989-03-26","Others",10101,56,23,82,6,"nec.quam.Curabitur@sociosquadlitora.edu","9374138515","Associate",60,"207-8436 Ipsum St.","Galway","4498","Connacht","Closer",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21c9u5e3I","Keefe","Carla","Gray","1987-04-06","Female",13098,46,90,35,3,"consectetuer@Seddiam.ca","9524534655","Paralegal",34,"7307 Vitae Ave","Swan Hill","1277001231","VIC","Drug Crimes",1);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21m3s3v7H","Hammett","Aiko","Howe","1991-11-20","Male",7458,59,71,73,25,"faucibus.orci@mollisDuis.co.uk","9857759360","Associate",30,"455-8498 Posuere Rd.","Bandırma","2017","Balıkesir","Buisness Law",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21n2c2u6B","Dorothy","Aiko","Sawyer","1987-10-20","Others",11091,74,44,89,9,"vestibulum.neque@noncursus.net","9310203381","Partner",80,"444-2610 Porttitor Ave","Moircy","91758","LX","Finance and Banking",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21e0f5s5Z","Maryam","Raymond","Stephenson","1990-02-07","Others",19168,92,81,45,20,"ornare.placerat@lacusUtnec.com","9359518083","Paralegal",51,"P.O. Box 604, 3545 Mauris Rd.","Antakya","105151","Hatay","Labour and Employment",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21g0p1y1W","Isaiah","Quentin","Owens","1990-09-02","Female",3903,98,82,16,4,"elit.Etiam@Cumsociis.edu","9187892936","Partner",93,"8715 Elit Road","Harlech","50622","ME","Civil litigation",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21n8n7m3C","Reuben","Aiko","Blevins","1990-10-27","Others",5716,14,60,52,2,"porta.elit@sodalesnisimagna.ca","9793128025","Associate",85,"3974 Aliquet, St.","Dublin","5738","L","Medical malpractice",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y0y7o4V","Lavinia","Katell","Mccall","1986-01-04","Others",19415,66,17,63,14,"Maecenas.libero@felis.ca","9554024257","Partner",85,"1514 Ipsum Street","Sangju","34978","North Gyeongsang","RestrainingOrders",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21p8y2h4F","Thaddeus","Adara","Jackson","1989-09-07","Female",3183,93,74,90,9,"nec.diam@sodalesnisi.org","9282993893","Partner",78,"P.O. Box 857, 7104 Amet Rd.","Chapecó","96965","Santa Catarina","Traffice law",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21l5x6o0T","Malachi","Angelica","Brooks","1991-10-26","Female",17453,78,33,39,20,"Morbi.metus.Vivamus@fermentumfermentum.edu","9602519821","Partner",76,"7869 Auctor Rd.","Whyalla","320221","South Australia","FINANCE",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21r8g4t8B","Armand","Roth","Cardenas","1991-02-07","Others",5254,11,82,23,11,"ipsum.cursus@nasceturridiculusmus.co.uk","9499133510","Lawyer",80,"7915 Adipiscing St.","Groot-Bijgaarden","9784","Vlaams-Brabant","Income tax",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21x5n7u2H","Kiayada","Noble","Reyes","1993-01-22","Male",13270,7,82,99,5,"neque@dolordapibus.com","9604325983","Lawyer",91,"P.O. Box 770, 281 Dolor. Av.","Caruaru","5886","PE","Patents",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y6d3d4X","Wynter","Cameron","Dixon","1990-12-31","Female",13312,2,5,55,25,"consectetuer.cursus@Suspendisse.net","9756634769","Associate",32,"Ap #406-4488 Donec Rd.","Erdemli","85858","Mersin","Copyright Claims",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21x1j9n0G","Kennan","Scarlett","Tyson","1993-05-23","Others",7994,5,7,37,20,"ullamcorper.viverra.Maecenas@lobortis.net","9887432896","Paralegal",57,"Ap #906-4211 Mauris Road","El Quisco","31123","Valparaíso","Finance",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21k7w6w1Y","Samuel","Amir","Moreno","1992-10-02","Female",16016,29,45,26,17,"Curabitur@lacus.net","9976029934","Associate",63,"Ap #228-2675 Aliquet, Rd.","Ribeirão Preto","49-259","SP","Child Custody Law",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21a3c6t8L","Malachi","Rina","Sherman","1989-02-09","Others",19947,80,99,99,3,"metus.Vivamus.euismod@est.co.uk","9904138158","Lawyer",67,"962-2346 Primis Av.","Carmen de Bolivar","4906 JC","Bolívar","Divorce",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y2r4m4Q","Henry","Hanna","Buckner","1987-02-06","Others",12888,20,3,50,16,"bibendum.Donec@egestasadui.net","9238855605","Partner",77,"2934 Commodo Av.","Collipulli","2295","Araucanía","Politics law",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u9i4t8B","Lamar","Jerry","Mack","1990-05-23","Male",4792,22,96,12,21,"magnis@elementum.com","9080189185","Associate",33,"617-9820 Dis Ave","San Polo d'Enza","210553","ERM","Drug Crimes Expert",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u8d9m8Y","Christian","Yael","Wall","1993-08-14","Male",4693,29,83,50,3,"Sed.id.risus@mi.ca","9658862747","Partner",62,"Ap #496-6630 Risus. Ave","Monterrey","963517","Nuevo León","Felony Law",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u2k4c8X","Chase","Kerry","Riddle","1989-03-20","Others",9688,75,65,81,1,"molestie.tortor.nibh@pharetrautpharetra.net","9388777253","Partner",39,"658-1140 A Ave","GomzŽ-Andoumont","20258","LU","Income tax",1);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21r5r4s7U","Dana","Barry","Rosario","1988-03-18","Male",5157,21,35,16,4,"Sed.eget.lacus@risusatfringilla.ca","9701760983","Associate",44,"P.O. Box 153, 3313 Suspendisse Street","Haldia","3370 GE","WB","Drug Crime",4);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21z0c9m4N","Hedley","Carissa","Blanchard","1989-02-18","Male",17057,25,48,3,11,"torquent.per@natoque.org","9311083602","Partner",37,"900-5060 Tellus Rd.","Pontevedra","05981","Galicia","Health Insurance Law",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21s1c6q8Z","Gregory","Nash","Fitzgerald","1987-03-01","Female",13559,59,65,63,25,"elit.elit.fermentum@nonnisiAenean.co.uk","9106408795","Paralegal",24,"101 Purus, Rd.","Hamilton","369499","North Island","Life insurance law",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21v4l9p0Q","Zane","Addison","Greer","1990-07-17","Male",9458,32,12,72,7,"Sed.dictum.Proin@Nunc.co.uk","9240912464","Paralegal",23,"Ap #605-4034 Ac Rd.","Hoofddorp","42090","Noord Holland","Finance law",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u6a1c4F","Justine","Harding","Gilmore","1990-02-09","Male",9386,65,63,52,24,"porttitor.vulputate@augue.org","9944775582","Associate",60,"2790 Dolor. Avenue","Istanbul","89326","Istanbul","Crime Law",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21b3w5m9Q","Mona","Kevin","Abbott","1993-11-29","Female",2971,66,68,60,25,"vulputate.velit@pede.org","9142961813","Partner",82,"521-4828 Aenean St.","Vienna","15747","Vienna","Military Law Expert",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21z1d3m8Y","Ruby","Cole","Warner","1993-05-05","Others",3110,29,36,31,20,"egestas@nuncnullavulputate.edu","9187789966","Paralegal",96,"Ap #212-1115 Tincidunt. St.","Istanbul","54189","Istanbul","Sports Law Exper",3);


INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21n7e0v3D","Megan","Mary","Duncan","1992-01-17","Male",11383,31,5,61,18,"Quisque.ac.libero@dui.com","9268094522","Lawyer",99,"788-1334 Aliquam St.","Kupang","09328","East Nusa Tenggara","LGBTQ Law",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21n8x4f7G","Lacota","August","Valencia","1992-01-01","Others",18454,37,90,58,25,"vitae.semper@dui.ca","9557741199","Partner",67,"4644 Urna Avenue","Pasuruan","Z7P 7IF","JI","Copyrights and Patents",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21f7g3c6N","Robin","George","Davidson","1986-09-26","Others",16874,74,49,87,11,"mollis@aodio.net","9592564991","Paralegal",98,"3196 Cursus St.","Tehuacán","758890","Pue","Oil and Gas",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21d7o8k9T","Kiayada","Xenos","Fitzpatrick","1989-06-11","Female",16069,39,83,99,24,"at.pede@bibendumDonecfelis.co.uk","9336102504","Lawyer",40,"365-3777 Eros. Street","Launceston","26611","TAS","Family Law",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21a0i6w2G","Abbot","Uriah","Bradford","1988-05-08","Others",16898,54,99,42,2,"Maecenas.ornare.egestas@Sedid.com","9175690767","Associate",52,"Ap #882-6032 Adipiscing St.","Queenstown","02904","SI","Civil",1);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21v4u3c1K","Yoshio","Cameron","Mcintosh","1990-04-08","Male",9674,20,79,88,12,"neque.Nullam.nisl@Quisquetincidunt.net","9311900367","Associate",35,"3037 In Rd.","Huaral","6918","LIM","Medical Malpractice",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21e3b3o7Z","Jordan","Aquila","Gould","1993-05-10","Female",5832,19,45,4,25,"dis.parturient@Vivamus.org","9774715353","Lawyer",38,"942-8085 Luctus Rd.","Chuncheon","Y5G 2P6","Gangwon","Shipping",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21j1c2w5C","Berk","Austin","Stein","1987-05-03","Female",8466,94,10,81,9,"nec.eleifend@auctorveliteget.co.uk","9017754113","Lawyer",39,"3630 Nec Road","Richmond","677996","QC","Crime",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21h1m1b0M","Hamish","Sasha","Bender","1989-02-10","Female",16751,82,43,99,19,"lectus.pede@Fuscealiquamenim.net","9334789963","Associate",26,"6627 Suspendisse Av.","Serik","75-841","Antalya","Whistleblower Litigation",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21x3j8o9E","Adam","Beck","Powers","1993-12-26","Others",5404,70,63,31,12,"tellus.sem@dolorDonecfringilla.com","9762881183","Partner",53,"Ap #431-299 Cras Rd.","Blackwood","297263","Monmouthshire","Labour and Employment",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21b0t8q7E","Sarah","Jackson","Ochoa","1992-09-30","Male",4972,49,8,91,16,"Duis@ipsumCurabitur.com","9413782367","Associate",77,"P.O. Box 374, 753 Ridiculus Rd.","Frigento","55727","CAM","Finance",1);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21t2x4l5I","Wyoming","April","Calhoun","1990-05-13","Male",6506,100,69,1,11,"amet.ante.Vivamus@Aenean.org","9490355268","Associate",30,"Ap #958-9871 In Ave","Hamburg","17579","Hamburg","Oil and Gas",4);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21i4c5r8L","Hiroko","Slade","Underwood","1987-07-01","Male",9569,59,46,69,3,"tempus.mauris@metusInlorem.net","9713399938","Lawyer",72,"Ap #214-4592 Dignissim Avenue","Kielce","18893","Swiętokrzyskie","Civil",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21f0n5l0W","Sierra","Ursa","Hancock","1990-04-27","Male",6204,13,15,44,23,"molestie@quis.org","9517987063","Lawyer",93,"Ap #474-6176 Sagittis Road","Laren","06897","Noord Holland","Crime",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21k9z5q4T","Quinlan","Ivan","Bowman","1991-06-15","Others",14797,51,50,3,12,"tincidunt.vehicula.risus@convallis.co.uk","9051642055","Paralegal",79,"4931 Dis Rd.","Foz do Iguaçu","4878","PR","Divorce",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u6p6n2J","Shelby","Adrian","Mcgowan","1985-04-08","Others",3654,56,94,87,10,"nunc.In.at@Nullam.org","9685942872","Partner",24,"7044 Non, Avenue","Edremit","430270","Bal","Politics",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21d2z8u6O","Iola","Audrey","Griffin","1988-01-06","Others",10118,95,8,56,18,"nibh@velconvallis.net","9938671278","Associate",95,"P.O. Box 954, 4411 Mollis Av.","Guri","5449 NI","Gyeonggi","Restraining Orders",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21d4r1a5W","Thor","Dakota","Anderson","1990-08-16","Male",3141,14,60,67,2,"feugiat.non@sedturpisnec.co.uk","9967079202","Partner",96,"7723 Mus. St.","Patarrá","205777","San José","Closer",1);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21x5a3h1J","Yolanda","Leroy","Atkins","1993-12-11","Others",6746,59,1,57,7,"interdum.Sed@acturpisegestas.edu","9441148238","Paralegal",33,"P.O. Box 241, 1531 Elementum Rd.","Tranås","12092-600","F","Communications and Media",6);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21i1n3b8G","Hayfa","Moana","Mclaughlin","1989-12-13","Male",8989,59,85,20,9,"mauris.ut@aceleifendvitae.com","9966616218","Paralegal",58,"P.O. Box 497, 1325 Mollis. Rd.","Juliaca","88098","PUN","Medical Malpractice",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21e2l1i9S","Christopher","Amos","Dunlap","1991-01-16","Others",4395,83,79,29,15,"eget@mi.ca","9788185593","Associate",32,"P.O. Box 289, 3401 Ut, Rd.","Frignano","77437","CAM","Politics",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21t9w6j2G","Inez","Ahmed","Cross","1992-10-06","Others",13901,5,2,95,11,"cursus.et@Phasellusornare.edu","9078801343","Paralegal",26,"P.O. Box 863, 698 Dolor. Rd.","Lleida","99389","CA","Communications and Media",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21h0j8b3J","Hayden","Akeem","Sullivan","1990-06-11","Others",4069,49,4,53,5,"Quisque.varius@Donecconsectetuermauris.org","9190591437","Paralegal",50,"Ap #818-1254 Sit St.","Åkersberga","38610","Stockholms län","Finance",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21m5g0b7G","Vivien","Cally","Page","1991-03-14","Female",5534,95,58,99,5,"eget.magna@nisidictumaugue.ca","9341588951","Partner",35,"P.O. Box 242, 2181 Egestas. Avenue","Bhubaneswar","777246","Odisha","Health Insurance",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y1k7z8W","Kennan","Amela","Sears","1989-07-29","Others",17759,1,42,96,25,"vitae@sit.org","9447776375","Associate",25,"8678 Dolor Street","Vienna","10414","Vienna","Investments",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21z4z2o0M","Xanthus","Mallory","Robertson","1990-12-21","Male",19453,88,15,2,1,"erat.in.consectetuer@Nunccommodo.co.uk","9461759833","Lawyer",49,"133-5923 Etiam Rd.","Málaga","32175","AN","Labour and Employment",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21n5e0z5U","Judah","Britanney","Gibson","1992-12-30","Male",7975,96,96,17,8,"tincidunt.orci.quis@nislsem.edu","9729767304","Partner",61,"440-5832 Sed Rd.","Oaxaca","T7B 3N5","Oaxaca","Divorce",4);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21a0o0l9O","Mara","Lee","Coffey","1987-07-14","Others",8316,61,50,35,9,"Donec@id.ca","9782900306","Partner",88,"783-4106 Dui Rd.","Ilhéus","34345","Bahia","Homicide",2);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21x0l7q4S","Graham","Chantale","Jackson","1992-07-02","Female",9747,47,67,11,18,"nostra.per@sedturpis.edu","9055510487","Lawyer",67,"442-5390 Imperdiet Av.","Bharatpur","571098","RJ","Agricultural Law",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y2c7g1O","Avram","Colleen","Short","1988-04-04","Male",13408,9,38,11,19,"mollis.vitae.posuere@egetmassa.net","9870199121","Associate",91,"Ap #228-4694 Tellus. St.","Bida","10367-516","NI","LGBTQ Law",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21j0j0n6W","Rogan","Vivian","Mcconnell","1986-03-30","Others",18017,30,43,14,24,"turpis.Nulla@loremsit.com","9171184467","Lawyer",97,"Ap #786-1851 Nulla. Rd.","Develi","06733-316","Kayseri","Crime",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21w5h8h6Q","Lucius","Vanna","Gordon","1989-03-20","Male",4356,4,3,66,14,"faucibus.orci.luctus@congueelitsed.co.uk","9108193558","Associate",97,"395-7157 Nunc Street","Mellet","661770","HE","Closer",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21i0j5n0F","Ashton","Vance","Fry","1988-10-21","Others",14029,8,85,60,8,"non@Duis.com","9675938205","Lawyer",80,"Ap #924-8160 Suspendisse Ave","Bydgoszcz","7546 MQ","KP","Income Tax",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21m6q9t6G","Venus","Adrian","Simon","1989-01-12","Others",16879,75,86,52,16,"per@quis.edu","9197036603","Paralegal",60,"485 Cursus Rd.","Balclutha","00281-170","South Island","Homicide",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21r5s1h8J","Amanda","Echo","Nieves","1992-10-15","Male",18744,60,23,27,24,"orci.tincidunt@justo.edu","9479754588","Lawyer",60,"Ap #143-7652 Massa Street","Saint-Georges","356473","QC","Tenant Law",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21f4o7b3D","Malachi","Adrienne","Bentley","1991-04-20","Female",2815,93,1,45,6,"turpis.nec.mauris@orci.org","9883666341","Paralegal",75,"9219 Interdum. Av.","Río Bueno","1925","Los Ríos","Education",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21j2f9t3H","Martina","Jackson","Valenzuela","1990-03-02","Others",17038,7,64,67,16,"pulvinar@pede.net","9217893422","Partner",56,"P.O. Box 493, 9630 Vulputate Av.","Istanbul","01336","Istanbul","Child Custody",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21q2y9a5U","Genevieve","Alfreda","Adkins","1988-04-08","Others",15894,77,65,65,5,"iaculis.lacus.pede@Quisquevarius.ca","9122345702","Paralegal",61,"Ap #794-1353 Augue Rd.","Guardia Sanframondi","302806","Campania","Bankruptcy",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21e4g0t3P","Chava","Keith","Castillo","1986-02-15","Female",7262,4,10,66,18,"ut.nisi@nec.edu","9863492311","Associate",91,"P.O. Box 679, 5477 Varius Av.","Tehuacán","149836","Pue","LGBTQ Law",7);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21q4u5j5R","Jack","Keely","Sears","1987-10-27","Others",14433,47,67,68,2,"nec.euismod.in@dolorsit.co.uk","9121889767","Partner",46,"260-3723 At Ave","Hapur","15094","UP","Income Tax",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21v9l9b5R","Octavius","Ivor","Fuentes","1985-11-17","Others",4661,45,9,20,12,"montes.nascetur@magnaPhasellusdolor.ca","9567051880","Associate",69,"Ap #567-7985 Tellus St.","Zaragoza","57951","AR","Finance",9);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21f3z4r8N","Nero","Ella","Tucker","1989-06-04","Others",5150,4,33,68,20,"odio.vel.est@sem.org","9346487878","Paralegal",76,"Ap #750-9396 Est. Ave","Sacheon","0092243408","Gye","Traffic Law",10);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21a4v0i1Q","Ulric","Noble","Lewis","1992-12-31","Female",7814,73,19,27,3,"lectus@laciniaSed.com","9805884788","Paralegal",70,"785-5022 Et Av.","Wałbrzych","68616","Dolnośląskie","Wills and Probate",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21y6i1e7R","Iliana","Judith","Bentley","1988-10-29","Female",11093,27,1,61,4,"mollis@nullavulputatedui.ca","9197387544","Paralegal",23,"644-2146 Curabitur St.","Boo","99-804","AB","Politics",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21e8f7u0L","Lawrence","Griffin","Graves","1987-12-12","Female",5066,79,7,32,23,"enim@Phasellusdolorelit.net","9483480174","Paralegal",66,"7213 Dui Ave","Ucluelet","6255647410","British Columbia","Copyrights and Patents",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21c6b7c7Y","Bo","Kane","Mcfadden","1986-04-25","Others",2731,57,82,30,11,"leo.in@nascetur.org","9217742631","Associate",82,"2667 Erat. St.","Turbo","9046","Antioquia","Tenant Law",1);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21e6a6z1Q","Lila","Felix","Downs","1991-06-20","Others",19212,85,65,10,19,"ut.nulla.Cras@Fuscediam.edu","9635246595","Partner",70,"Ap #935-2195 Imperdiet Ave","Mandi Bahauddin","7907","Sindh","Finance",8);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21u3y0f3W","Ingrid","Raphael","Terrell","1990-12-19","Others",16454,45,99,39,10,"tellus.Nunc.lectus@urnaUttincidunt.org","9169090905","Associate",21,"8329 Fringilla Rd.","North Shore","597668","North Island","Harrasement",5);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21q3f9a9V","Dahlia","Cameron","Moreno","1989-03-29","Female",6487,63,44,66,18,"lacus@sitamet.net","9686043809","Associate",21,"Ap #193-8623 Cubilia Ave","Haripur","84347","KPK","Sports Law",4);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21i0s6r4L","Andrew","Dominique","Gilmore","1987-08-06","Male",19007,87,50,47,8,"urna@urnaNuncquis.com","9732621249","Partner",30,"P.O. Box 652, 9015 At, Ave","Radom","771801","Mazowieckie","LGBTQ Law",1);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21l9o8k0W","Bevis","Lilah","Terrell","1992-11-10","Others",8699,91,82,85,23,"Sed@faucibusorciluctus.edu","9700239120","Partner",20,"Ap #295-4651 Pede. St.","Çeşme","37900-648","İzm","Divorce",3);
INSERT INTO `Lawyer` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`charges`,`casesWon`,`casesLost`,`casesSettled`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`avgTimePerCase`,`streetName`,`city`,`pincode`,`state`,`specialization`,`clientRating`) VALUES ("A21n1q5a5G","Nerea","Breanna","Norman","1992-08-29","Female",17211,31,49,52,5,"ac.eleifend@lacusAliquam.com","9904021873","Associate",53,"P.O. Box 917, 2878 Nonummy Rd.","Carmen de Bolivar","293428","BOL","Traffic Law",10);


INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pv0m7I677z","SSS21f4f1m7D000","2021-01-25","2021-07-27",0,"Evidence");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Ps6f6O243x","SSS21t5j9w8Q000","2020-11-27","2021-12-23",0,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pa9b5D929b","SSS21t7z7y4I000","2020-04-11","2021-11-24",1,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pv7w9O681c","SSS21c2h1l0H000","2021-01-30","2021-12-09",1,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pv0y1F814o","SSS21i1q4e2C000","2020-12-24","2021-09-05",1,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pj5d8J404p","SSS21p2y3h0J000","2020-04-06","2021-03-29",1,"Engagement Letter");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pg6g9K951t","SSS21r4j6o9L000","2020-09-09","2021-10-16",1,"Engagement Letter");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pe7t8G790v","SSS21i6v6f7T000","2020-10-06","2021-04-23",0,"Patent");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Py1r7C479v","SSS21e7a2y8X000","2020-10-21","2021-10-09",0,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pn6h2L348m","SSS21h4r3w5L000","2020-12-04","2021-06-28",0,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pw5n9R144t","SSS21w9v7d1S000","2020-03-27","2022-01-08",0,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pr1e4D475r","SSS21x3c0k9T000","2021-01-08","2021-04-21",1,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pq1q7B570j","SSS21m4j8t5Y000","2020-11-23","2021-09-29",0,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pg2j6O517x","SSS21t0l8f1K000","2020-05-16","2021-11-30",0,"Patent");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Ps9c7S266l","SSS21q6m3x3T000","2020-12-12","2021-07-07",1,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pf2o3P306k","SSS21q0w9e4F000","2020-11-24","2021-03-09",0,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pa7f3L478b","SSS21i4h3i7G000","2021-01-08","2021-08-10",0,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pt1a6Z843g","SSS21d9j4s9V000","2020-09-25","2021-03-29",0,"Engagement Letter");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pw2l1X963m","SSS21j1j4d2X000","2020-05-31","2021-06-12",0,"Engagement Letter");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pw6y9X774q","SSS21x9u8f6Z000","2020-05-16","2021-09-18",0,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pj0d9H460z","SSS21z9r7y5C000","2020-05-13","2022-02-15",0,"Engagement Letter");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pw1e8F635y","SSS21f0o8f3M000","2020-07-30","2021-11-23",0,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Px8y3Y712n","SSS21g1s2c8O000","2020-05-23","2021-10-29",1,"Evidence");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pi1n2D505a","SSS21r2i9s2I000","2020-12-10","2021-10-21",0,"Engagement Letter");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pn6v8V875c","SSS21q9n4e2T000","2020-11-18","2021-03-22",0,"Patent");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Py8i7M806s","SSS21u3f3x1U000","2020-10-02","2021-05-01",0,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pi2v9Y416f","SSS21v8k1h4G000","2020-04-11","2021-08-10",1,"Patent");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pb9m6V857c","SSS21h7e3k5M000","2020-06-16","2022-02-02",1,"Evidence");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pv1o1U307n","SSS21x4s1a3V000","2020-07-22","2021-03-19",0,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Po6r2E905n","SSS21u6y2o0G000","2020-04-14","2021-07-02",1,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Ph0f5P617l","SSS21w9x5e8R000","2020-04-17","2022-02-13",0,"Evidence");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pq6l1S793f","SSS21u9p6o8P000","2020-08-02","2022-02-02",0,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pi7x2U237s","SSS21x3v1i1X000","2020-05-22","2021-04-17",0,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pz8n2C476z","SSS21v4i3j3Q000","2020-12-18","2021-03-15",1,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pr5o0M873n","SSS21g5u1k6F000","2020-08-26","2021-06-16",1,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pn0s0C421h","SSS21u2b9j9T000","2021-01-14","2021-05-01",0,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Ph2h3W492t","SSS21m2s8l8V000","2021-01-21","2022-02-20",1,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pe3o7N280y","SSS21r0x1d7Q000","2020-03-31","2021-11-13",0,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pd9q1A145m","SSS21b9l8r3P000","2020-07-06","2021-11-25",0,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pz7q1S339b","SSS21m1x7b8D000","2020-05-28","2021-09-06",0,"Patent");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pk2h6S954o","SSS21a3i7z1O000","2020-04-19","2021-10-06",1,"Engagement Letter");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pl6j3C156k","SSS21r2s0x1N000","2020-08-07","2021-05-28",1,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pm8y6W397w","SSS21j2b1k9V000","2020-06-16","2021-08-23",1,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pe2q2L448a","SSS21g1h3u4I000","2020-02-20","2021-02-18",1,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Py6z4H452u","SSS21a0a6p9S000","2020-08-19","2021-05-23",0,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pk3f8S398t","SSS21m9w8z8C000","2020-02-20","2021-03-07",1,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pg5k8D984g","SSS21f8c9f6M000","2020-06-08","2021-11-12",0,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pg9q0Q983z","SSS21w2k1h1K000","2020-09-03","2021-08-23",0,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pq2p4K565n","SSS21f7g1m0X000","2020-12-15","2021-09-11",1,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Py6x0K955w","SSS21p4d1l5D000","2020-03-24","2021-07-18",0,"Patent");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pm8l7F436o","SSS21n4w8u7G000","2021-01-22","2022-01-05",1,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pn2f6B569f","SSS21i2g3x4N000","2020-06-09","2021-07-03",0,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pm5u6N247w","SSS21c4j2s1X000","2020-12-26","2021-12-30",0,"Patent");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pu2l7U727r","SSS21h4d5s5N000","2020-08-20","2022-02-12",1,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pr6e0K331l","SSS21x4j4e8B000","2020-06-13","2021-08-15",1,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pv6q1A306l","SSS21u5y4c9M000","2021-01-14","2021-06-27",0,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pb9b2S932q","SSS21u8m5q6V000","2021-01-04","2022-02-11",1,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Ps8f4J037l","SSS21w5z3w3P000","2020-05-23","2021-06-07",1,"Patent");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pc7m7E262x","SSS21w4v3a8C000","2020-09-07","2021-05-23",0,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Py8h9Q903c","SSS21f2o7c6M000","2021-01-06","2021-02-13",1,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pu4k4P517i","SSS21x7d9c7B000","2020-03-09","2021-12-10",0,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pw2i7X743t","SSS21f2i1y4G000","2020-10-23","2021-10-28",0,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pd7h0A810x","SSS21a2d9l7A000","2020-03-13","2022-01-27",1,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pc2l4U349l","SSS21e3w2w2Q000","2020-04-14","2021-04-10",0,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pc6d5Y688v","SSS21t5q9r6X000","2020-10-11","2021-02-16",1,"Engagement Letter");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pp0n2C402g","SSS21c0v3j7H000","2020-12-06","2022-02-03",0,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pj5f1H897u","SSS21p6f6g2Y000","2020-07-08","2022-01-28",1,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Ph9g9K476u","SSS21i3k0z7H000","2021-01-24","2021-12-06",0,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Px6d2W410t","SSS21d4j9h5F000","2020-04-04","2021-08-08",0,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pa7a9K406s","SSS21a6j4s8S000","2020-03-14","2021-06-22",1,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Py0y4P757n","SSS21g4w5c6D000","2021-01-09","2021-08-02",1,"Engagement Letter");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pv6l7Z984q","SSS21p4y9k3K000","2020-04-06","2021-04-07",0,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pq0r2S223d","SSS21i3c0v7K000","2020-03-02","2021-12-23",1,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pi0n3J650v","SSS21v2a2i2Q000","2020-05-10","2022-01-06",1,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pv4k7H859n","SSS21o2d2m1T000","2020-04-26","2021-05-25",1,"Evidence");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pt9o5E241m","SSS21t1y8p4S000","2020-12-12","2021-06-14",0,"NOC");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Px4x2O457n","SSS21z6c7c1T000","2020-06-17","2021-09-20",0,"Evidence");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pd0e8Y023s","SSS21z3g2q9E000","2020-04-13","2021-03-05",1,"Patent");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Px9d9M564p","SSS21h1q4a0S000","2020-06-28","2021-05-30",1,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pi2i1Q254l","SSS21g3n2c8L000","2020-04-23","2021-04-08",1,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pw9e2M621z","SSS21o5q4n4D000","2020-12-10","2022-01-28",1,"Engagement Letter");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pj0f4K277b","SSS21v4h8r3P000","2021-01-28","2021-12-21",0,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pk0l9K933f","SSS21n2b5k6O000","2020-11-14","2021-05-01",1,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pu7s4T659n","SSS21d8m8u7S000","2020-07-21","2022-02-06",1,"Engagement Letter");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Py9x8U239r","SSS21m6a0d2A000","2020-06-12","2021-07-24",1,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Ph1o2S001o","SSS21c5g2t6S000","2021-01-22","2021-03-11",0,"Subpoena");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Ph6y5H396j","SSS21p3d1e3Z000","2020-02-20","2022-01-28",0,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pd6f3F277l","SSS21o2v8p8Q000","2020-05-12","2021-03-09",1,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pc4k6C517q","SSS21l9i0c0G000","2020-12-02","2021-06-02",1,"Evidence");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Px7o5Z361l","SSS21x6m5b8C000","2020-05-18","2022-01-07",0,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pq5x3Z455g","SSS21r0z8x1B000","2020-03-03","2021-09-10",1,"Evidence");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pg5e1F717t","SSS21y5z3j2Y000","2020-08-24","2021-06-21",1,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pt3n5Z267y","SSS21h2t7e7N000","2020-03-23","2021-08-08",1,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pr2k3Q700d","SSS21x7t4k3L000","2020-08-15","2021-04-14",1,"MOU");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pr2w5D672b","SSS21q6l8d6I000","2020-02-21","2021-10-16",1,"Patent");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pp5c0Q370t","SSS21e8i7o9T000","2020-10-29","2021-10-21",1,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pm4i5D211b","SSS21v4l5t6B000","2020-07-17","2021-09-14",1,"Engagement Letter");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pd1d8D489w","SSS21a5l8y4Q000","2020-03-01","2021-09-20",0,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pb7z8F416d","SSS21y7r8q2W000","2020-09-15","2021-08-11",1,"Agreement");
INSERT INTO `LegalDocuments` (`docID`,`caseID`,`createdOn`,`dateLastModified`,`visibility`,`type`) VALUES ("Pp0d8U651x","SSS21q6h2r5T000","2020-11-22","2021-10-10",1,"Agreement");


INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21p5y3f5D","Eaton","Maxine","Castillo","1987-07-01","Others",11194,17,"Morbi@Aliquamadipiscing.com","9423092491","IT","333-3014 Tincidunt, Avenue","Vegreville","09490","Alberta");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21r2w6l9I","Michael","Alfonso","Lowery","1989-11-06","Female",6680,22,"eleifend.nunc.risus@eleifendnon.edu","9969574134","Support Staff","Ap #530-513 Ornare St.","Chandler","9926","AZ");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21a5i1p3G","Brian","Gareth","Guzman","1991-11-15","Female",3813,22,"ante.ipsum.primis@semperdui.net","9602361081","HR","4152 Nec Rd.","Dir","9556 SQ","Khyber Pakhtoonkhwa");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21o8k1i4G","Liberty","Vivien","Douglas","1988-11-05","Female",12280,3,"Sed@consequatdolor.co.uk","9558239794","IT","6666 Neque Ave","Tulsa","74752","Oklahoma");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21x7e4w2T","Ryder","Yetta","Morales","1986-05-07","Female",3216,5,"tempor.augue.ac@habitant.org","9419918699","Support Staff","335-6321 Cras Rd.","Vetlanda","835839","Jönköpings län");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21g0i7i1G","Hayfa","Cruz","Nielsen","1989-01-28","Female",10618,21,"sagittis.augue.eu@Fusce.ca","9551488348","Support Staff","Ap #951-7202 Aliquam Road","Mombaruzzo","02173","Piemonte");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21l5g2g3Z","Cassandra","Carly","Griffin","1988-07-06","Male",15724,13,"sit.amet.faucibus@Duisgravida.org","9695602085","Finance and Accounting","Ap #342-7822 Hendrerit Rd.","San Rafael","489139","A");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21h3b8f0C","Adria","Gemma","Alvarado","1988-12-06","Others",7252,9,"in@fringillami.edu","9801009272","Support Staff","P.O. Box 513, 4354 Ante, St.","Ñuñoa","QE59 7TP","Metropolitana de Santiago");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21m6r1f4E","Lila","Azalia","Stafford","1988-01-07","Male",9619,19,"Mauris.magna.Duis@ullamcorpernislarcu.net","9237209639","Finance and Accounting","Ap #913-6255 Velit. Av.","Warrnambool","00785","Victoria");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21b1l4d4S","Jasper","Aidan","Kirkland","1993-02-19","Others",9606,17,"tellus@luctusfelis.com","9688910794","Support Staff","7083 Mi Avenue","Gravilias","164015","San José");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21y8y9b3V","Daria","Thaddeus","Rowe","1993-04-28","Male",14589,18,"Aenean.eget@massaMaurisvestibulum.com","9731915070","Support Staff","P.O. Box 627, 9850 Lorem Rd.","La Pintana","50338","RM");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21s9b2l5A","Tarik","Renee","Hurley","1992-08-12","Male",12391,18,"sit@cubiliaCurae.org","9893442155","Finance and Accounting","2233 Non Road","Ryazan","85652","Ryazan Oblast");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21q7l2z3D","Ray","Louis","Schmidt","1986-10-19","Others",11620,25,"Nam.nulla.magna@loremvehiculaet.org","9674420880","Support Staff","2813 Mi St.","Puno","34869","PUN");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21r9a5l9H","Christen","Hasad","Duffy","1989-05-26","Female",9238,6,"penatibus@nulla.org","9171857864","Support Staff","7776 Fusce Rd.","Marbella","08104","AN");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21w3y9k6D","Aiko","Joseph","Waters","1987-01-19","Others",10990,5,"hendrerit.Donec@Inscelerisque.com","9406646071","HR","Ap #213-6719 Nullam St.","Kurram Agency","404608","FA");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21o7m0a5J","Howard","Burton","Cross","1990-10-18","Others",16192,2,"dui.nec.tempus@massa.ca","9627480024","Finance and Accounting","2433 Nullam Rd.","Medellín","612102","Antioquia");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21t1k5q5Q","Genevieve","Carla","Conner","1985-03-04","Others",9185,19,"luctus.aliquet@commodoat.co.uk","9923764874","IT","Ap #452-3110 Mollis. Road","Kearney","18036","Nebraska");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21h1t2w5O","Althea","Ayanna","Newton","1992-05-24","Others",12448,3,"eros@elit.com","9815359037","IT","9473 Sagittis. Ave","Duque de Caxias","18786","RJ");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21m4j7j5T","Omar","Upton","Barr","1985-02-11","Others",9760,16,"egestas.urna.justo@Integersemelit.net","9064263152","Finance and Accounting","190-7843 Curae; Ave","Gaya","97366-245","BR");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21y5i5m5H","Benedict","Byron","Workman","1991-07-05","Female",14046,10,"pellentesque.Sed@Innecorci.co.uk","9378456474","IT","Ap #751-8570 Convallis Road","Memphis","05486","Tennessee");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21f1z8c5E","Abigail","Brent","Pruitt","1993-10-01","Female",14757,15,"netus.et@Maecenasiaculisaliquet.com","9624702128","IT","9400 Nullam St.","Tay","35652","Ontario");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21x5c9w6D","Gay","Angelica","Tyson","1992-06-21","Others",14810,5,"quis.arcu.vel@velitegestaslacinia.com","9846808162","Finance and Accounting","4165 Non St.","Lodhran","Z4964","Sindh");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21p2p6d4C","Reagan","Vance","Baldwin","1992-04-17","Female",7405,7,"lectus.convallis@adipiscing.com","9173358708","Support Staff","428 Vel Road","Serang","00354","BT");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21q8e3x6V","Damon","Christopher","Knowles","1990-03-21","Female",9278,17,"et@quam.co.uk","9375152161","HR","2357 Odio Av.","Francavilla in Sinni","82-324","Basilicata");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21a0b2d6K","Keely","Duncan","Moody","1986-05-01","Female",18547,20,"dictum.magna.Ut@Nulla.net","9490378505","Support Staff","P.O. Box 631, 8421 In Road","Itagüí","76642","Antioquia");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21w4h7v7O","Caryn","Mari","Rodriquez","1988-08-29","Others",19832,16,"amet@nibhenim.org","9794401646","Support Staff","867-1919 Ante St.","Zuienkerke","NF0R 4SM","WV");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21f4d0v9S","Ann","Leah","Burke","1993-03-18","Female",11688,3,"neque.vitae@montesnascetur.com","9822391230","HR","P.O. Box 851, 932 Sodales. Av.","Qambar Shahdadkot","85324","SI");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21w7j6x0W","Mariam","Vera","Mcclure","1985-08-16","Others",17703,17,"Vivamus.molestie@enim.org","9771378279","Support Staff","3764 Sed, St.","Suruç","9916622493","Şan");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21h2a5d0O","Phelan","Noah","Quinn","1991-04-14","Others",8523,20,"commodo.ipsum.Suspendisse@urnajusto.ca","9955231512","Support Staff","P.O. Box 412, 5705 Nec St.","Béthune","845823","Nord-Pas-de-Calais");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21n3s6j3T","Shelley","Quamar","Ortega","1986-08-13","Others",5816,24,"Mauris.eu.turpis@metusvitae.net","9929172972","HR","P.O. Box 648, 4973 Non, St.","Dordrecht","33030","Zuid Holland");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21s8l2h5B","Brady","Sara","Gregory","1988-12-16","Female",18438,12,"eu.dolor@elementum.org","9527604744","IT","P.O. Box 589, 9696 Sed Rd.","Berlin","9651","Berlin");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21g1d1q3S","Dalton","Donovan","Mcbride","1987-07-23","Female",6770,18,"Cras.convallis@dignissimmagna.net","9276423917","Support Staff","P.O. Box 627, 664 Amet Rd.","Körfez","814609","Kocaeli");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21t0o1g1I","Hedy","Timon","Duran","1986-06-26","Others",17188,8,"Sed@vestibulummassa.edu","9670503082","HR","Ap #386-9159 Turpis. Road","Norrköping","671794","Östergötlands län");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21i3u6f4B","Paki","Fitzgerald","Ayala","1988-11-27","Female",4854,14,"odio.Etiam.ligula@ligulaAeneaneuismod.com","9883740134","IT","8480 Et St.","Ñuñoa","43827","RM");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21x6m7a6Q","Sarah","Vivien","Sears","1987-09-03","Male",11764,18,"dis.parturient.montes@Nullamfeugiat.ca","9227017339","Finance and Accounting","P.O. Box 513, 8779 Dui St.","Probolinggo","4272","East Java");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21y7j0w4Y","Tobias","Fleur","Wynn","1991-09-24","Female",11363,23,"rhoncus.Donec.est@fermentum.org","9391956132","HR","1821 Rutrum Street","Nandyal","41405","AP");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21t3s8p0V","Vivien","Renee","Malone","1988-11-02","Female",15238,4,"non.sollicitudin.a@ultricies.com","9132587735","HR","3275 Tempus Ave","Proddatur","074732","AP");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21c7b3y8G","Rigel","Wynter","Puckett","1985-12-03","Male",3268,4,"leo@eget.org","9365027573","Finance and Accounting","P.O. Box 502, 7958 Odio. Av.","Portland","319386","OR");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21h8b8o6W","Isabelle","Griffin","Wright","1991-12-27","Male",15354,11,"est@elitCurabitursed.edu","9347149961","IT","P.O. Box 804, 695 Enim Av.","Cajamarca","5351 YB","Cajamarca");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21i2h1o4T","Sandra","Coby","Mullins","1992-03-15","Others",10174,5,"lobortis@magna.edu","9228983500","Finance and Accounting","249-5813 Eu Street","Cimahi","6611 JM","JB");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21r4y8d8Y","Teegan","Ocean","Knapp","1985-08-26","Male",18424,20,"velit@justoPraesent.com","9821415878","Support Staff","P.O. Box 269, 3045 Est, St.","Semarang","UR1 1EY","JT");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21u2s1j5K","Fatima","Francis","Mcclure","1988-01-05","Female",7533,12,"at.iaculis@leoMorbineque.ca","9156113771","Finance and Accounting","2729 Nec Av.","Terneuzen","189682","Zl");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21z5q6r7W","Lillian","Lana","Petty","1991-12-17","Male",12986,11,"iaculis@velit.org","9941529298","Support Staff","P.O. Box 886, 7260 Elementum Rd.","Firozabad","7108","Uttar Pradesh");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21o9z6q5L","Risa","Bertha","Battle","1993-01-26","Male",3524,9,"eros.nec.tellus@dolor.org","9142809886","IT","Ap #631-9687 Ut Road","Sabanalarga","440672","Atlántico");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21q1t2t9W","Jolie","Akeem","Stark","1988-09-18","Others",3835,4,"tempor.diam.dictum@a.edu","9379004866","HR","P.O. Box 372, 9689 Ultricies Rd.","Dublin","18098","Leinster");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21f2n5h8B","Neville","Lael","Ayers","1990-05-11","Female",16912,13,"posuere.vulputate.lacus@velitSed.ca","9416578525","Support Staff","P.O. Box 194, 9390 Ac Street","Macul","356118","RM");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21x1f3n4O","Nichole","Stuart","Mayer","1989-09-09","Others",5580,22,"pede.Nunc@Sed.co.uk","9593855630","Finance and Accounting","3279 Orci. Rd.","Zamość","184929","Lubelskie");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21p5d4e7K","Lana","Zorita","Brown","1985-12-31","Others",9826,2,"nec.ante@faucibusMorbi.com","9549660275","Support Staff","P.O. Box 283, 7046 Est. Street","Flushing","4622","Zeeland");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21r1m3c3W","Hasad","Mark","Cherry","1990-05-17","Female",8364,21,"ac@euultricessit.edu","9315034631","IT","396-5864 Pharetra, Av.","Diamer","006805","GB");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21b8m5o5E","Gil","Steel","Hansen","1987-11-25","Male",5868,9,"sed@nuncest.org","9008188087","IT","1622 Mauris Av.","Paine","PZ02 0FI","Metropolitana de Santiago");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21q1q9n8K","TaShya","Len","Richardson","1993-11-22","Male",10043,20,"lorem.luctus.ut@at.ca","9664718513","Support Staff","Ap #452-9823 Sit Av.","Faisalabad","0068371349","Punjab");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21n9t7q9A","Vaughan","Yoshi","Pratt","1988-01-18","Male",4396,20,"Nullam@atliberoMorbi.edu","9413318209","Support Staff","4619 Tincidunt Rd.","Galway","5128","C");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21v7n7v2K","Castor","Macon","Albert","1993-04-19","Female",14910,1,"Etiam.imperdiet@Suspendissealiquet.ca","9181098694","IT","P.O. Box 435, 7157 Libero Road","Palmerston North","79-162","North Island");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21x0t2l7J","Breanna","Ashton","Weeks","1990-05-24","Female",11618,17,"Nulla.tincidunt.neque@necorci.ca","9929928158","Support Staff","Ap #518-7270 Faucibus. Rd.","Mount Gambier","273263","South Australia");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21z8w5v1X","Wilma","Phyllis","Gallagher","1993-03-12","Female",19912,25,"dignissim.lacus@massa.net","9470541510","IT","P.O. Box 493, 3711 Arcu Avenue","Berlin","8249 XU","BE");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21b9f9x9S","Lucius","Yolanda","Odom","1992-06-13","Female",5264,5,"pellentesque.massa.lobortis@suscipitestac.edu","9461440991","Support Staff","P.O. Box 894, 157 Risus Road","Champdani","2590","West Bengal");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21j7l0e7H","Giacomo","Naida","Valenzuela","1985-09-22","Male",7247,1,"tempor.arcu@facilisiSedneque.net","9267759611","Finance and Accounting","P.O. Box 681, 4154 Velit. Avenue","Rotterdam","841779","Zuid Holland");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21i2c9d7A","Halee","Bo","Walsh","1986-01-05","Female",19544,25,"odio.Aliquam@dolorsit.com","9630593342","HR","1177 Augue Street","Awka","91338-079","Anambra");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21t4p5f6V","Clare","Quin","Macdonald","1986-02-19","Male",10668,19,"vestibulum.massa.rutrum@orcilacus.net","9601282774","Support Staff","959-529 Cursus Road","San Nicolás","328930","VII");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21j6c6y3S","Neve","Jescie","Hayes","1987-07-24","Female",5350,10,"aliquam@cursus.edu","9865102774","IT","677-8132 Praesent Rd.","San Pedro de Atacama","63294","II");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21z4n3d9R","Ross","Iona","Barnes","1993-01-29","Male",14613,4,"consectetuer@augueidante.ca","9633845601","Finance and Accounting","435-8894 Dui. Ave","Sicuani","4152422171","CUS");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21q9d9g4F","Gannon","Scarlet","Mccoy","1991-08-27","Others",9915,6,"rhoncus.id@magnis.edu","9867014764","Support Staff","Ap #276-2422 Velit. Road","Åkersberga","5935","Stockholms län");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21b7i0p5B","Vincent","Brandon","Rivas","1989-11-24","Others",6662,4,"purus@justositamet.co.uk","9925226977","IT","996-7395 Convallis Avenue","Sneek","584645","Fr");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21w9w1h9Q","Austin","Blythe","Wade","1987-08-24","Female",4907,23,"Donec.consectetuer.mauris@perconubia.net","9071355744","Support Staff","Ap #139-5823 Cursus. Ave","Vienna","10609","Wie");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21w9t5k3P","Craig","Kitra","Phelps","1992-04-25","Others",11236,6,"magnis@semPellentesque.org","9774516871","HR","2674 Quam Street","Mercedes","44520","H");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21h8j2h4K","Glenna","Meghan","Peck","1993-06-04","Female",4015,24,"leo.in.lobortis@elitsed.org","9407615248","IT","719-4599 Semper Av.","Wimborne Minster","9978","DO");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21w2l7x3E","Liberty","Leo","Lara","1988-12-28","Others",6657,6,"ornare@nuncQuisque.com","9781672843","Support Staff","5815 Sit Rd.","San Miguel","50665","San José");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21q1z0r4I","Jordan","Tara","Mitchell","1988-04-06","Others",6260,21,"interdum.Sed.auctor@rutrumFuscedolor.ca","9756815491","Finance and Accounting","685-8577 Hendrerit. Ave","Ipswich","479012","QLD");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21k4g9j2B","Aidan","Murphy","Bridges","1985-10-04","Others",13359,18,"nec.mollis@elitpedemalesuada.net","9001346122","Support Staff","913-3051 Velit Rd.","Pittsburgh","82515","PA");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21n9a9q4Q","Shay","Ina","Reyes","1987-03-07","Male",14483,24,"magna@sedorcilobortis.ca","9027959597","Finance and Accounting","P.O. Box 518, 3334 Et, St.","Okara","4569","Sindh");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21v3r4f1U","Louis","Conan","Yates","1992-08-23","Others",3974,4,"morbi.tristique.senectus@Cumsociisnatoque.co.uk","9858385956","Support Staff","131-4106 Proin Av.","Balikpapan","17503","KI");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21b8c9o1N","Stacey","Brynne","Kerr","1990-11-08","Male",6140,21,"Etiam.ligula@pharetra.com","9179386088","HR","908-3124 Nunc Road","Cowdenbeath","47141-169","FI");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21p6y7u3O","Sean","Rahim","Kemp","1987-04-08","Others",10871,13,"Donec.sollicitudin.adipiscing@pulvinararcu.edu","9022162684","Finance and Accounting","4674 Nunc Ave","Itagüí","51-018","ANT");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21i2k6s6M","Clark","Raja","Huber","1985-10-04","Male",5343,6,"tristique@arcuimperdiet.ca","9406028774","IT","Ap #646-822 Aliquam St.","Waitakere","Z3397","NI");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21w4p7e6Q","Beck","Ethan","Owens","1991-03-31","Female",10076,5,"dictum.placerat@nequepellentesque.co.uk","9587905535","HR","725-8966 Ultricies St.","Bornival","87406","Waals-Brabant");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21q0j8r6P","Emerson","Shaine","Phelps","1990-09-28","Female",19650,12,"iaculis.odio.Nam@lacus.org","9352360465","Finance and Accounting","4452 Tincidunt St.","Çermik","934416","Diyarbakır");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21x2z0k4C","Keane","Marvin","Gamble","1992-11-27","Male",14631,12,"et.magnis.dis@viverra.org","9581608592","IT","782-4352 Nunc Street","Huelva","98091","AN");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21w2v7n7Z","Wynter","Noel","Pena","1986-09-14","Female",2632,22,"accumsan.laoreet@dictumplacerataugue.ca","9152972962","HR","P.O. Box 621, 5641 Ac Road","Gladstone","584519","Queensland");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21c7q8w4J","Maxwell","Alec","Grant","1986-01-07","Male",12892,6,"dolor@enim.ca","9997280534","IT","997-4075 Iaculis, Street","Semarang","61810","JT");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21k0w5h9T","Brittany","Kibo","Farmer","1988-09-30","Male",9714,9,"est.Nunc.ullamcorper@elitpharetra.org","9197790396","HR","P.O. Box 731, 7744 Amet, Road","Cáceres","3507","EX");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21y8g3s7O","Len","Kameko","Bonner","1985-11-19","Male",11846,5,"est.mollis@Craseu.net","9002237879","Support Staff","Ap #338-7610 Tempor St.","Paço do Lumiar","53970","Maranhão");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21i4b6a8B","Silas","Carla","Brock","1992-06-06","Male",12125,9,"sapien@dolorDonec.co.uk","9085914411","Finance and Accounting","9908 Metus. St.","Rionegro","23060","Antioquia");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21c7m6t7G","Stephen","Chaim","Shaffer","1985-08-10","Male",18949,1,"dictum.augue@lorem.net","9844056537","HR","Ap #224-4564 Non Street","Angers","6028","Pays de la Loire");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21i1v0p4N","Upton","Fletcher","Hardy","1986-06-24","Others",11953,4,"penatibus@Phasellusvitae.co.uk","9937487891","Finance and Accounting","Ap #652-8783 Pede, St.","Patalillo","Z2051","San José");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21t5q2x4T","Idona","Gregory","Mcpherson","1989-10-03","Female",4509,1,"lectus.Nullam@laciniaSedcongue.co.uk","9947909562","Support Staff","P.O. Box 956, 8214 Tortor. St.","Siheung","792236","Gyeonggi");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21z8h9p1E","Ishmael","Gray","Gallagher","1989-07-20","Male",14264,13,"nec@etmalesuadafames.co.uk","9009982657","HR","401-9326 Tellus Street","Flushing","77538","Zeeland");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21h7t4w7A","Shelly","Clementine","Lyons","1985-03-15","Female",14837,10,"est@vel.edu","9348778233","Support Staff","Ap #935-4495 Velit St.","Vienna","708282","Vienna");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21i1b8h8M","Sylvia","Demetrius","Sparks","1988-04-16","Others",13380,10,"non.enim@nostra.ca","9767651299","Support Staff","8515 Orci Avenue","Cobourg","7724","ON");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21z5o3i5E","Lysandra","Germaine","Weeks","1990-12-03","Female",5691,9,"commodo.at.libero@intempus.edu","9486713843","IT","Ap #264-9143 Eu Av.","Biała Podlaska","43640-566","LU");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21s3s8e7A","Thane","Victoria","Robertson","1987-09-30","Female",3486,20,"pede@neque.co.uk","9899669077","Support Staff","762-1269 Tellus St.","Wageningen","38698-684","Gelderland");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21v6y9z4B","Amal","Craig","Hoffman","1987-07-08","Others",16020,17,"Aliquam.erat@magna.net","9211875408","HR","361-7155 Tellus. Rd.","Zaragoza","31006","Aragón");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21d5t0b1S","Jordan","Phelan","Walls","1987-05-03","Male",2175,5,"faucibus@gravidanuncsed.org","9028131473","Finance and Accounting","Ap #121-4938 Pretium Ave","New Haven","179051","Connecticut");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21b7n1v0N","Shad","Rose","Bates","1985-10-20","Others",6504,22,"nascetur@purusNullam.com","9086422832","Finance and Accounting","Ap #501-8933 Convallis Rd.","Dabgram","9407","WB");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21k9t9k6Z","Kaseem","Ray","Chambers","1993-01-24","Male",15966,6,"euismod.ac@acipsum.co.uk","9230378636","HR","Ap #293-9418 Proin Ave","Berlin","82817","Berlin");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21e9q0v2C","Barbara","Maxine","Hill","1985-10-10","Male",3550,1,"eu.accumsan.sed@sem.co.uk","9390962124","Support Staff","Ap #293-4194 Vel Ave","Parla","81092","MA");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21k8r2r6T","Josiah","Dara","Russell","1989-10-07","Male",8643,22,"mollis.Duis@mollis.net","9004681474","HR","495-8310 Id, Street","Łódź","11899","LD");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21v3w1d8G","Evan","Melodie","Pratt","1993-06-09","Male",19810,20,"sem@Donectincidunt.co.uk","9235419068","HR","Ap #103-9718 Velit. St.","Lasbela","9666874680","Balochistan");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21h1t2h9X","Byron","Grady","Thomas","1989-05-08","Male",2394,2,"imperdiet@a.edu","9989154493","IT","325-8389 Rhoncus. Rd.","Penza","08285","PNZ");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21m7b7y6G","Wallace","Keaton","Gill","1988-09-23","Others",2693,24,"vitae.sodales.at@mollislectuspede.net","9667673293","Support Staff","432-6244 Libero Rd.","Enschede","13870","Ov");
INSERT INTO `OtherStaff` (`userID`,`firstName`,`middleName`,`lastName`,`dateOfBirth`,`gender`,`salary`,`experience`,`emailID`,`phoneNumber`,`positionAtFirm`,`streetName`,`city`,`pincode`,`state`) VALUES ("O21f1d3n8D","Gil","Mara","Obrien","1988-12-31","Male",6656,23,"adipiscing.Mauris@ullamcorpernislarcu.org","9118358424","Support Staff","Ap #705-8764 Donec St.","Poznań","8611 AZ","WP");

INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21s8i4u0F","SSS21f4f1m7D000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21w0i5r4O","SSS21t5j9w8Q000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21a3g2c4H","SSS21t7z7y4I000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21o3e9k1P","SSS21c2h1l0H000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21r6n0u3Z","SSS21i1q4e2C000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21t7f1a7H","SSS21p2y3h0J000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21n9g9g7P","SSS21r4j6o9L000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21b0d8t7H","SSS21i6v6f7T000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21r7y5r3J","SSS21e7a2y8X000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21b2y0y9N","SSS21h4r3w5L000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21n6a1s3S","SSS21w9v7d1S000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21a3i9t1S","SSS21x3c0k9T000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21y0x1n5E","SSS21m4j8t5Y000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21v9o3w3S","SSS21t0l8f1K000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21k0h3y3I","SSS21q6m3x3T000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21f6z7t6Z","SSS21q0w9e4F000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21y1q2b1E","SSS21i4h3i7G000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21t1s1o7C","SSS21d9j4s9V000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21p5r7u3H","SSS21j1j4d2X000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21x7w7i6V","SSS21x9u8f6Z000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21a0d3d3Z","SSS21z9r7y5C000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21z9v2s8S","SSS21f0o8f3M000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21t5g4s9I","SSS21g1s2c8O000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21a1d1s6J","SSS21r2i9s2I000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21u2x3l2K","SSS21q9n4e2T000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21i5g9s5X","SSS21u3f3x1U000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21h1a3y2R","SSS21v8k1h4G000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21c4i4j3K","SSS21h7e3k5M000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21l2n4w4U","SSS21x4s1a3V000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21k1u7g3H","SSS21u6y2o0G000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21b5j1g2F","SSS21w9x5e8R000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21x4y9j5E","SSS21u9p6o8P000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21f2o7f3Y","SSS21x3v1i1X000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21s2y6d2Y","SSS21v4i3j3Q000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21z4d9u4R","SSS21g5u1k6F000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21c8t0e0L","SSS21u2b9j9T000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21d0l9d3L","SSS21m2s8l8V000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21j5q4k5A","SSS21r0x1d7Q000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21d4j5n6R","SSS21b9l8r3P000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21q8k6c1N","SSS21m1x7b8D000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21e5g5j3R","SSS21a3i7z1O000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21i2x4w8P","SSS21r2s0x1N000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21i3e4t4E","SSS21j2b1k9V000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21n1l8v4I","SSS21g1h3u4I000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21z9h7r0W","SSS21a0a6p9S000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21x2r1b2P","SSS21m9w8z8C000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21z0f1m3M","SSS21f8c9f6M000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21h4o6e4O","SSS21w2k1h1K000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21z3i0b2N","SSS21f7g1m0X000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21r2f0z7Y","SSS21p4d1l5D000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21r4i0b4M","SSS21n4w8u7G000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21b8i7m4L","SSS21i2g3x4N000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21h3t3h7L","SSS21c4j2s1X000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21p4w0k8B","SSS21h4d5s5N000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21v1y1a5Z","SSS21x4j4e8B000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21u1i8d2N","SSS21u5y4c9M000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21z9w9i6J","SSS21u8m5q6V000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21e6v8d9I","SSS21w5z3w3P000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21r9h9b3M","SSS21w4v3a8C000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21t3e1l5E","SSS21f2o7c6M000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21m0p9v7T","SSS21x7d9c7B000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21z1a1q3I","SSS21f2i1y4G000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21l5i8g2Z","SSS21a2d9l7A000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21h5a1d3Q","SSS21e3w2w2Q000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21j1y7z0D","SSS21t5q9r6X000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21b9d5g2B","SSS21c0v3j7H000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21r7z5e1E","SSS21p6f6g2Y000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21g1u4a5N","SSS21i3k0z7H000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21n2u6k4C","SSS21d4j9h5F000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21j8f1h9A","SSS21a6j4s8S000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21l1l0j3O","SSS21g4w5c6D000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21w0u2p4H","SSS21p4y9k3K000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21o9a8v2K","SSS21i3c0v7K000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21w0o9b5E","SSS21v2a2i2Q000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21u7b4h4V","SSS21o2d2m1T000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21a6t6h9C","SSS21t1y8p4S000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21v2b0x1J","SSS21z6c7c1T000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21q8w5q8C","SSS21z3g2q9E000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21o6x3o8M","SSS21h1q4a0S000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21w4r3y9Q","SSS21g3n2c8L000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21a6n1g9K","SSS21o5q4n4D000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21d2a8k0A","SSS21v4h8r3P000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21q3d5m9C","SSS21n2b5k6O000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21u4z5m9Q","SSS21d8m8u7S000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21c7t2e1Z","SSS21m6a0d2A000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21e3c9u8V","SSS21c5g2t6S000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21e1g2g9S","SSS21p3d1e3Z000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21n1j0k7N","SSS21o2v8p8Q000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21t0m7e9K","SSS21l9i0c0G000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21a9j4c4M","SSS21x6m5b8C000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21e3k4b1T","SSS21r0z8x1B000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21p2h9q8P","SSS21y5z3j2Y000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21p7c7x2Q","SSS21h2t7e7N000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21v7u5f0T","SSS21x7t4k3L000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21i4t7u0H","SSS21q6l8d6I000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21n3r8p8P","SSS21e8i7o9T000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21o7d9g6X","SSS21v4l5t6B000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21s0t8f2R","SSS21a5l8y4Q000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21k8c9r2J","SSS21y7r8q2W000");
INSERT INTO `Against` (`oppositionID`,`caseID`) VALUES ("T21r7s8q4T","SSS21q6h2r5T000");

INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21o6z6w7G","SSS21f4f1m7D000","2021-10-01 05:11:13");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21z3g0u2J","SSS21t5j9w8Q000","2020-10-01 05:45:46");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21v8e5b1X","SSS21t7z7y4I000","2021-06-20 09:58:23");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21g1p3c3G","SSS21c2h1l0H000","2021-09-10 04:18:29");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21e8x0n9D","SSS21i1q4e2C000","2021-11-22 12:18:24");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21f7a6o4B","SSS21p2y3h0J000","2020-03-28 01:31:45");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21x5j6p6T","SSS21r4j6o9L000","2021-11-04 11:57:10");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21p5s5v4O","SSS21i6v6f7T000","2021-02-21 02:17:18");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21x8e8x9N","SSS21e7a2y8X000","2021-10-03 03:56:15");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21t1o7o9Y","SSS21h4r3w5L000","2021-12-02 11:25:50");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21u7j9u8C","SSS21w9v7d1S000","2021-06-23 03:42:31");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21o8j6m5Q","SSS21x3c0k9T000","2021-09-28 08:50:37");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21u6h9a9Z","SSS21m4j8t5Y000","2020-09-21 01:37:20");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21i6v7v5D","SSS21t0l8f1K000","2021-10-20 01:15:27");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21f3d4t5C","SSS21q6m3x3T000","2020-10-31 01:20:51");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21k1f0p1V","SSS21q0w9e4F000","2021-07-29 05:40:20");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21l4d5v4P","SSS21i4h3i7G000","2020-01-08 12:24:51");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21r7i5k7R","SSS21d9j4s9V000","2020-03-15 08:47:51");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21k3r5r6E","SSS21j1j4d2X000","2021-04-06 12:11:19");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21o9s5h1I","SSS21x9u8f6Z000","2020-11-23 09:58:40");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21g2u0t9Q","SSS21z9r7y5C000","2021-07-01 12:17:55");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21n9p1n2F","SSS21f0o8f3M000","2021-03-03 08:53:56");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21m0a3t8V","SSS21g1s2c8O000","2021-08-01 10:23:50");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21z5h8a7E","SSS21r2i9s2I000","2021-10-04 03:58:27");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21w3k2x5I","SSS21q9n4e2T000","2021-04-17 02:23:56");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21h1p8s3U","SSS21u3f3x1U000","2021-06-19 07:56:22");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21v7m0z9X","SSS21v8k1h4G000","2020-02-24 05:50:37");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21w7j4f7F","SSS21h7e3k5M000","2021-06-13 10:58:53");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21f4u5j8O","SSS21x4s1a3V000","2020-09-14 07:59:50");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21b5m3m0U","SSS21u6y2o0G000","2021-11-27 04:58:33");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21b7o0o9M","SSS21w9x5e8R000","2022-01-03 08:42:43");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21m1v3d6V","SSS21u9p6o8P000","2021-03-25 07:27:27");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21b8b3x3G","SSS21x3v1i1X000","2021-12-31 05:47:26");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21f0u7q2E","SSS21v4i3j3Q000","2021-10-07 02:12:30");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21i4m5b5E","SSS21g5u1k6F000","2021-12-26 09:36:58");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21s4k5g0B","SSS21u2b9j9T000","2021-07-05 11:55:36");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21u1z9w6E","SSS21m2s8l8V000","2021-12-05 02:30:39");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21z1u4z4R","SSS21r0x1d7Q000","2020-05-08 05:50:14");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21p3z1w6U","SSS21b9l8r3P000","2020-05-20 08:32:44");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21r2g8t4N","SSS21m1x7b8D000","2020-04-02 11:40:42");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21f2g0i1C","SSS21a3i7z1O000","2020-03-24 06:50:39");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21i0f8z5U","SSS21r2s0x1N000","2020-02-08 02:22:25");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21q7j8b9V","SSS21j2b1k9V000","2020-10-22 11:32:52");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21s4p0h3F","SSS21g1h3u4I000","2020-03-25 07:35:46");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21u0h0r1H","SSS21a0a6p9S000","2020-06-30 12:10:32");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21l5f9r2T","SSS21m9w8z8C000","2022-01-22 09:40:10");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21q5y2g9O","SSS21f8c9f6M000","2021-02-07 06:57:44");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21c0c7t0F","SSS21w2k1h1K000","2020-06-17 04:46:23");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21b3t3d4I","SSS21f7g1m0X000","2021-09-22 01:53:27");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21f0b1b9W","SSS21p4d1l5D000","2021-08-29 01:22:23");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21b0m9k9L","SSS21n4w8u7G000","2021-12-20 07:16:57");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21a9z7t6R","SSS21i2g3x4N000","2021-07-23 06:31:56");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21b4v1r9B","SSS21c4j2s1X000","2021-06-26 03:17:31");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21b5j1d7H","SSS21h4d5s5N000","2020-03-13 03:31:53");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21g5x5u9X","SSS21x4j4e8B000","2021-10-07 02:55:41");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21f9g6q6I","SSS21u5y4c9M000","2020-12-15 10:42:36");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21r5t3v1Y","SSS21u8m5q6V000","2021-12-28 07:24:23");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21b2c5s5X","SSS21w5z3w3P000","2020-03-18 04:41:10");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21k8t2u9D","SSS21w4v3a8C000","2020-03-24 01:55:24");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21m6p8s3I","SSS21f2o7c6M000","2021-09-18 08:49:29");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21z5f7v5T","SSS21x7d9c7B000","2021-04-04 05:12:44");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21i8q5y1K","SSS21f2i1y4G000","2020-05-19 11:31:35");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21o9o2w6C","SSS21a2d9l7A000","2020-12-08 08:36:44");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21u4a5y5V","SSS21e3w2w2Q000","2022-01-23 09:30:30");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21a4p1j5G","SSS21t5q9r6X000","2020-02-13 11:20:45");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21l6k2n1L","SSS21c0v3j7H000","2021-01-01 08:35:30");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21d8k6f2D","SSS21p6f6g2Y000","2020-05-30 10:42:10");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21m1b5d7H","SSS21i3k0z7H000","2020-06-02 03:13:22");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21x8n6z9E","SSS21d4j9h5F000","2020-10-31 01:17:50");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21z6i9d6D","SSS21a6j4s8S000","2022-01-06 05:40:35");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21c6m6e7X","SSS21g4w5c6D000","2021-04-16 07:13:13");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21r8v6d0F","SSS21p4y9k3K000","2020-02-28 05:32:49");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21p8o6k8V","SSS21i3c0v7K000","2021-08-04 04:28:22");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21p1m4i0V","SSS21v2a2i2Q000","2020-08-30 03:39:25");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21w4s1x4S","SSS21o2d2m1T000","2020-09-16 11:29:53");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21y5a3i5J","SSS21t1y8p4S000","2020-11-03 09:21:18");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21g8j8y7M","SSS21z6c7c1T000","2021-11-30 11:38:25");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21v5s0t5X","SSS21z3g2q9E000","2021-09-28 10:24:19");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21j1t2r0Y","SSS21h1q4a0S000","2021-09-26 12:46:13");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21t6w4j0J","SSS21g3n2c8L000","2021-12-07 01:56:56");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21q3s6c7X","SSS21o5q4n4D000","2021-08-09 04:49:19");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21f9q5j0G","SSS21v4h8r3P000","2021-01-23 09:37:29");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21k4o5w6C","SSS21n2b5k6O000","2020-04-27 06:44:39");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21o2k5g2F","SSS21d8m8u7S000","2022-01-09 08:40:28");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21a2h5f8J","SSS21m6a0d2A000","2020-03-25 05:32:19");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21g2n6i0Z","SSS21c5g2t6S000","2020-05-11 11:29:33");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21g2y7g1G","SSS21p3d1e3Z000","2021-03-22 11:53:28");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21r1y3d2A","SSS21o2v8p8Q000","2021-08-29 06:48:38");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21d5s7g0D","SSS21l9i0c0G000","2021-07-16 12:39:25");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21p9a1c3B","SSS21x6m5b8C000","2022-01-24 08:59:35");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21a9z0f5X","SSS21r0z8x1B000","2021-07-18 07:34:35");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21d7k9b9B","SSS21y5z3j2Y000","2020-09-04 04:48:55");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21p8v0o4G","SSS21h2t7e7N000","2021-08-08 09:29:29");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21z8m7k6X","SSS21x7t4k3L000","2021-09-30 10:59:56");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21w4b1d7E","SSS21q6l8d6I000","2020-05-07 03:42:59");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21h5m5s3X","SSS21e8i7o9T000","2020-07-31 09:55:32");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21g1s2d4W","SSS21v4l5t6B000","2020-10-19 10:47:30");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21s2l2g2Y","SSS21a5l8y4Q000","2020-03-16 01:50:18");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21u6q9o1X","SSS21y7r8q2W000","2021-03-21 05:41:29");
INSERT INTO `DisplayedIn` (`userID`,`caseID`,`when`) VALUES ("Y21b0a2b3T","SSS21q6h2r5T000","2021-06-02 01:27:51");

INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21r4a1b6X","SSS21f4f1m7D000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21a7z0h2V","SSS21t5j9w8Q000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21u5w0u4X","SSS21t7z7y4I000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21j6o5f1F","SSS21c2h1l0H000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21k2l6c5D","SSS21i1q4e2C000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21d1o5j7F","SSS21p2y3h0J000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21y0e3o6E","SSS21r4j6o9L000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21e4d9u7O","SSS21i6v6f7T000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21i6h2v4R","SSS21e7a2y8X000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21u4f4u7F","SSS21h4r3w5L000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21k9e0m9D","SSS21w9v7d1S000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21x6i8r4X","SSS21x3c0k9T000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21b7y0r2S","SSS21m4j8t5Y000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21u5j4l6F","SSS21t0l8f1K000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21t8y1o3Z","SSS21q6m3x3T000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21n6o6k0N","SSS21q0w9e4F000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21a0f5x5M","SSS21i4h3i7G000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21h9m7x7T","SSS21d9j4s9V000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21s9n5a5A","SSS21j1j4d2X000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21v1p2x4V","SSS21x9u8f6Z000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21q7h0u0E","SSS21z9r7y5C000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21t0s5w9W","SSS21f0o8f3M000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21c9u5e3I","SSS21g1s2c8O000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21m3s3v7H","SSS21r2i9s2I000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21n2c2u6B","SSS21q9n4e2T000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21e0f5s5Z","SSS21u3f3x1U000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21g0p1y1W","SSS21v8k1h4G000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21n8n7m3C","SSS21h7e3k5M000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21y0y7o4V","SSS21x4s1a3V000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21p8y2h4F","SSS21u6y2o0G000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21l5x6o0T","SSS21w9x5e8R000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21r8g4t8B","SSS21u9p6o8P000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21x5n7u2H","SSS21x3v1i1X000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21y6d3d4X","SSS21v4i3j3Q000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21x1j9n0G","SSS21g5u1k6F000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21k7w6w1Y","SSS21u2b9j9T000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21a3c6t8L","SSS21m2s8l8V000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21y2r4m4Q","SSS21r0x1d7Q000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21u9i4t8B","SSS21b9l8r3P000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21u8d9m8Y","SSS21m1x7b8D000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21u2k4c8X","SSS21a3i7z1O000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21r5r4s7U","SSS21r2s0x1N000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21z0c9m4N","SSS21j2b1k9V000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21s1c6q8Z","SSS21g1h3u4I000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21v4l9p0Q","SSS21a0a6p9S000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21u6a1c4F","SSS21m9w8z8C000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21b3w5m9Q","SSS21f8c9f6M000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21z1d3m8Y","SSS21w2k1h1K000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21n7e0v3D","SSS21f7g1m0X000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21n8x4f7G","SSS21p4d1l5D000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21f7g3c6N","SSS21n4w8u7G000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21d7o8k9T","SSS21i2g3x4N000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21a0i6w2G","SSS21c4j2s1X000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21v4u3c1K","SSS21h4d5s5N000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21e3b3o7Z","SSS21x4j4e8B000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21j1c2w5C","SSS21u5y4c9M000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21h1m1b0M","SSS21u8m5q6V000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21x3j8o9E","SSS21w5z3w3P000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21b0t8q7E","SSS21w4v3a8C000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21t2x4l5I","SSS21f2o7c6M000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21i4c5r8L","SSS21x7d9c7B000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21f0n5l0W","SSS21f2i1y4G000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21k9z5q4T","SSS21a2d9l7A000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21u6p6n2J","SSS21e3w2w2Q000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21d2z8u6O","SSS21t5q9r6X000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21d4r1a5W","SSS21c0v3j7H000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21x5a3h1J","SSS21p6f6g2Y000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21i1n3b8G","SSS21i3k0z7H000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21e2l1i9S","SSS21d4j9h5F000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21t9w6j2G","SSS21a6j4s8S000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21h0j8b3J","SSS21g4w5c6D000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21m5g0b7G","SSS21p4y9k3K000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21y1k7z8W","SSS21i3c0v7K000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21z4z2o0M","SSS21v2a2i2Q000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21n5e0z5U","SSS21o2d2m1T000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21a0o0l9O","SSS21t1y8p4S000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21x0l7q4S","SSS21z6c7c1T000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21y2c7g1O","SSS21z3g2q9E000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21j0j0n6W","SSS21h1q4a0S000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21w5h8h6Q","SSS21g3n2c8L000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21i0j5n0F","SSS21o5q4n4D000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21m6q9t6G","SSS21v4h8r3P000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21r5s1h8J","SSS21n2b5k6O000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21f4o7b3D","SSS21d8m8u7S000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21j2f9t3H","SSS21m6a0d2A000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21q2y9a5U","SSS21c5g2t6S000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21e4g0t3P","SSS21p3d1e3Z000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21q4u5j5R","SSS21o2v8p8Q000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21v9l9b5R","SSS21l9i0c0G000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21f3z4r8N","SSS21x6m5b8C000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21a4v0i1Q","SSS21r0z8x1B000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21y6i1e7R","SSS21y5z3j2Y000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21e8f7u0L","SSS21h2t7e7N000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21c6b7c7Y","SSS21x7t4k3L000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21e6a6z1Q","SSS21q6l8d6I000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21u3y0f3W","SSS21e8i7o9T000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21q3f9a9V","SSS21v4l5t6B000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21i0s6r4L","SSS21a5l8y4Q000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21l9o8k0W","SSS21y7r8q2W000");
INSERT INTO `Handles` (`userID`,`caseID`) VALUES ("A21n1q5a5G","SSS21q6h2r5T000");

INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21a6v1n3Y","SSS21f4f1m7D000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21m2s2j0X","SSS21t5j9w8Q000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21p1o3m0I","SSS21t7z7y4I000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21n7x7k6Q","SSS21c2h1l0H000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21r0k0b4G","SSS21i1q4e2C000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21l6n1r5O","SSS21p2y3h0J000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21b0f1b7U","SSS21r4j6o9L000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21e0m3b2H","SSS21i6v6f7T000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21n8n8x4L","SSS21e7a2y8X000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21a3c7b9V","SSS21h4r3w5L000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21l4l2z2V","SSS21w9v7d1S000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21n3q8z0T","SSS21x3c0k9T000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21g4q3a0C","SSS21m4j8t5Y000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21e8r0w4U","SSS21t0l8f1K000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21g6a1t9M","SSS21q6m3x3T000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21c1i0m8G","SSS21q0w9e4F000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21t2r5i9L","SSS21i4h3i7G000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21a8r5z0R","SSS21d9j4s9V000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21b8x7f7C","SSS21j1j4d2X000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21f9d1v3S","SSS21x9u8f6Z000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21t0z0b6C","SSS21z9r7y5C000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21k2i4s0M","SSS21f0o8f3M000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21e5c5u5T","SSS21g1s2c8O000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21h2l3h4T","SSS21r2i9s2I000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21w7w4s5D","SSS21q9n4e2T000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21q1o1x3V","SSS21u3f3x1U000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21q9k1o6D","SSS21v8k1h4G000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21s9s9l4W","SSS21h7e3k5M000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21q1y3p1B","SSS21x4s1a3V000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21s2t1t0M","SSS21u6y2o0G000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21x3a1i3J","SSS21w9x5e8R000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21l5k8x1E","SSS21u9p6o8P000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21o4j8t5J","SSS21x3v1i1X000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21j4c1z0G","SSS21v4i3j3Q000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21d6h1k4S","SSS21g5u1k6F000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21j0i9h1D","SSS21u2b9j9T000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21d1s2k3T","SSS21m2s8l8V000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21b1t4v6Y","SSS21r0x1d7Q000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21q0l7k2S","SSS21b9l8r3P000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21o5t8k4S","SSS21m1x7b8D000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21d8u1g3F","SSS21a3i7z1O000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21m0m8e1V","SSS21r2s0x1N000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21p9t3c7R","SSS21j2b1k9V000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21h2u9c3D","SSS21g1h3u4I000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21a0l0g1L","SSS21a0a6p9S000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21l7l3r4Q","SSS21m9w8z8C000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21h9y4d8L","SSS21f8c9f6M000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21p5a6t2C","SSS21w2k1h1K000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21g2z8f6O","SSS21f7g1m0X000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21i2l7f5H","SSS21p4d1l5D000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21q7x2g1S","SSS21n4w8u7G000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21i8x8f6M","SSS21i2g3x4N000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21l0r9l3V","SSS21c4j2s1X000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21n5q6a4D","SSS21h4d5s5N000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21c9w4e5V","SSS21x4j4e8B000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21r1z4k2D","SSS21u5y4c9M000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21p6v9u4N","SSS21u8m5q6V000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21n7y2f4X","SSS21w5z3w3P000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21f7c9s5M","SSS21w4v3a8C000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21d1n4r9Z","SSS21f2o7c6M000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21z2k0g2Z","SSS21x7d9c7B000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21g3m9s7I","SSS21f2i1y4G000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21z3e6c2F","SSS21a2d9l7A000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21u0o9p4S","SSS21e3w2w2Q000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21s7j5a6V","SSS21t5q9r6X000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21j2n0e0U","SSS21c0v3j7H000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21j8o1a3G","SSS21p6f6g2Y000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21l8p2s9M","SSS21i3k0z7H000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21c5y3b3D","SSS21d4j9h5F000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21i1b1u3K","SSS21a6j4s8S000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21a5f4z0X","SSS21g4w5c6D000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21x9j6r5J","SSS21p4y9k3K000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21s9w5f1N","SSS21i3c0v7K000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21p6r5h3T","SSS21v2a2i2Q000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21h9a5z8Y","SSS21o2d2m1T000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21y1u2m4V","SSS21t1y8p4S000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21z2d7c5Q","SSS21z6c7c1T000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21o1f7t9Z","SSS21z3g2q9E000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21b7l9f4G","SSS21h1q4a0S000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21o0p9v2G","SSS21g3n2c8L000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21j0t6i5Q","SSS21o5q4n4D000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21r0h1t2L","SSS21v4h8r3P000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21i8g8k3M","SSS21n2b5k6O000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21z1v3d9J","SSS21d8m8u7S000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21i1d0e4O","SSS21m6a0d2A000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21x8u8t1N","SSS21c5g2t6S000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21h2g2o2Z","SSS21p3d1e3Z000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21o2l9d5N","SSS21o2v8p8Q000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21b5c7q0B","SSS21l9i0c0G000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21f2w0f2G","SSS21x6m5b8C000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21e6i6i6N","SSS21r0z8x1B000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21p9e2x7Z","SSS21y5z3j2Y000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21o0f4s7Z","SSS21h2t7e7N000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21z8z0v1D","SSS21x7t4k3L000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21j1a5t0U","SSS21q6l8d6I000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21l8k8k9L","SSS21e8i7o9T000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21y2q1v1W","SSS21v4l5t6B000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21i3i4o2O","SSS21a5l8y4Q000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21d3y2f0U","SSS21y7r8q2W000");
INSERT INTO `HasA` (`userID`,`caseID`) VALUES ("I21r6i4t5D","SSS21q6h2r5T000");

INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mt3z5D549v","SSS21f4f1m7D000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mf5j1T825r","SSS21t5j9w8Q000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mx0f5X901e","SSS21t7z7y4I000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mu7u5I303k","SSS21c2h1l0H000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mu7q3B911o","SSS21i1q4e2C000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mb0h2L374n","SSS21p2y3h0J000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mi6k6S050w","SSS21r4j6o9L000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mp4a2O616q","SSS21i6v6f7T000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mi7m9R742w","SSS21e7a2y8X000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mn6x5L289h","SSS21h4r3w5L000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Ml0h3P711u","SSS21w9v7d1S000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mh6n1S125l","SSS21x3c0k9T000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Me0d8W423d","SSS21m4j8t5Y000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mg2e4N676q","SSS21t0l8f1K000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mb6o6T540n","SSS21q6m3x3T000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mo8n6A500x","SSS21q0w9e4F000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mn9x7I604f","SSS21i4h3i7G000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Ms8d3Z570z","SSS21d9j4s9V000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Me6a9U102c","SSS21j1j4d2X000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mx2r0Y217e","SSS21x9u8f6Z000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mv5z3Z965n","SSS21z9r7y5C000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mt7v7Y217a","SSS21f0o8f3M000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mv8l1N656i","SSS21g1s2c8O000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mr5l5A162a","SSS21r2i9s2I000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mr8k7I508h","SSS21q9n4e2T000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Me1k4K887a","SSS21u3f3x1U000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Ms0a0G198n","SSS21v8k1h4G000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mx8l1S902r","SSS21h7e3k5M000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mp6w6I243q","SSS21x4s1a3V000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mg4q3H676u","SSS21u6y2o0G000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mk2r5G724d","SSS21w9x5e8R000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mg1z5F259b","SSS21u9p6o8P000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mu0i7K329x","SSS21x3v1i1X000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mf8u9L320d","SSS21v4i3j3Q000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("My9f2G226i","SSS21g5u1k6F000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mq4t6O102o","SSS21u2b9j9T000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mg7q6O707o","SSS21m2s8l8V000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mx0v4E664u","SSS21r0x1d7Q000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mq3p8P009v","SSS21b9l8r3P000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mq6g7Z769l","SSS21m1x7b8D000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mf0v2Z877i","SSS21a3i7z1O000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mp7f8S699g","SSS21r2s0x1N000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mz6o7G601t","SSS21j2b1k9V000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Md4x8O425o","SSS21g1h3u4I000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mn2v4D211i","SSS21a0a6p9S000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mu0c8V469p","SSS21m9w8z8C000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mx6h8R926p","SSS21f8c9f6M000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mv1l5Q210j","SSS21w2k1h1K000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Ms2h7U218r","SSS21f7g1m0X000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mz5r9L827g","SSS21p4d1l5D000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mp0n4S652x","SSS21n4w8u7G000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mq1a4J648s","SSS21i2g3x4N000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mj8h0U256y","SSS21c4j2s1X000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mg8a7I634u","SSS21h4d5s5N000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mz1x5P943g","SSS21x4j4e8B000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mu0z0Q217g","SSS21u5y4c9M000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Ms4s6M387h","SSS21u8m5q6V000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mw6m8O560f","SSS21w5z3w3P000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mx8k5K647b","SSS21w4v3a8C000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Me3g9B611s","SSS21f2o7c6M000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mu5q0X096d","SSS21x7d9c7B000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mf8f7M636u","SSS21f2i1y4G000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("My8q7F235n","SSS21a2d9l7A000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mk9y9D468e","SSS21e3w2w2Q000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mu2v0K283k","SSS21t5q9r6X000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("My0f5H763w","SSS21c0v3j7H000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mb1w9M013e","SSS21p6f6g2Y000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mw0l3R867t","SSS21i3k0z7H000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("My7k8N041k","SSS21d4j9h5F000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Md5b9M452t","SSS21a6j4s8S000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mm6c4D957b","SSS21g4w5c6D000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mb5h5I260e","SSS21p4y9k3K000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mj0a1U705x","SSS21i3c0v7K000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Me8k6H847p","SSS21v2a2i2Q000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Md2h6T495t","SSS21o2d2m1T000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mo5m8L610u","SSS21t1y8p4S000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mp4z5I962d","SSS21z6c7c1T000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("My4v9S021v","SSS21z3g2q9E000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Ms1q7I681f","SSS21h1q4a0S000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mn7s2O909a","SSS21g3n2c8L000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mc0p4E524h","SSS21o5q4n4D000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("My2p6M506o","SSS21v4h8r3P000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mi0l0E160a","SSS21n2b5k6O000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mr9v7T981t","SSS21d8m8u7S000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mv7y0F199p","SSS21m6a0d2A000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("My9c2W930j","SSS21c5g2t6S000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mz3f2N363a","SSS21p3d1e3Z000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mu2y1X981j","SSS21o2v8p8Q000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mt8x3H190l","SSS21l9i0c0G000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mq2x6A548m","SSS21x6m5b8C000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mz4l5X072q","SSS21r0z8x1B000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mo9r7M547r","SSS21y5z3j2Y000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Ml1s3W395g","SSS21h2t7e7N000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mg7g3Y983x","SSS21x7t4k3L000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mz1i1O438m","SSS21q6l8d6I000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Ml1h4P981r","SSS21e8i7o9T000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mr8f6E574i","SSS21v4l5t6B000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mx7y6X802o","SSS21a5l8y4Q000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mv8x9K926h","SSS21y7r8q2W000");
INSERT INTO `Invest` (`transactionID`,`caseID`) VALUES ("Mr4x2K333u","SSS21q6h2r5T000");


INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21a6v1n3Y","Mt3z5D549v");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21m2s2j0X","Mf5j1T825r");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21p1o3m0I","Mx0f5X901e");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21n7x7k6Q","Mu7u5I303k");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21r0k0b4G","Mu7q3B911o");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21l6n1r5O","Mb0h2L374n");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21b0f1b7U","Mi6k6S050w");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21e0m3b2H","Mp4a2O616q");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21n8n8x4L","Mi7m9R742w");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21a3c7b9V","Mn6x5L289h");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21l4l2z2V","Ml0h3P711u");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21n3q8z0T","Mh6n1S125l");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21g4q3a0C","Me0d8W423d");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21e8r0w4U","Mg2e4N676q");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21g6a1t9M","Mb6o6T540n");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21c1i0m8G","Mo8n6A500x");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21t2r5i9L","Mn9x7I604f");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21a8r5z0R","Ms8d3Z570z");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21b8x7f7C","Me6a9U102c");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21f9d1v3S","Mx2r0Y217e");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21t0z0b6C","Mv5z3Z965n");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21k2i4s0M","Mt7v7Y217a");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21e5c5u5T","Mv8l1N656i");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21h2l3h4T","Mr5l5A162a");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21w7w4s5D","Mr8k7I508h");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21q1o1x3V","Me1k4K887a");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21q9k1o6D","Ms0a0G198n");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21s9s9l4W","Mx8l1S902r");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21q1y3p1B","Mp6w6I243q");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21s2t1t0M","Mg4q3H676u");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21x3a1i3J","Mk2r5G724d");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21l5k8x1E","Mg1z5F259b");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21o4j8t5J","Mu0i7K329x");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21j4c1z0G","Mf8u9L320d");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21d6h1k4S","My9f2G226i");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21j0i9h1D","Mq4t6O102o");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21d1s2k3T","Mg7q6O707o");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21b1t4v6Y","Mx0v4E664u");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21q0l7k2S","Mq3p8P009v");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21o5t8k4S","Mq6g7Z769l");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21d8u1g3F","Mf0v2Z877i");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21m0m8e1V","Mp7f8S699g");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21p9t3c7R","Mz6o7G601t");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21h2u9c3D","Md4x8O425o");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21a0l0g1L","Mn2v4D211i");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21l7l3r4Q","Mu0c8V469p");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21h9y4d8L","Mx6h8R926p");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21p5a6t2C","Mv1l5Q210j");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21g2z8f6O","Ms2h7U218r");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21i2l7f5H","Mz5r9L827g");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21q7x2g1S","Mp0n4S652x");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21i8x8f6M","Mq1a4J648s");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21l0r9l3V","Mj8h0U256y");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21n5q6a4D","Mg8a7I634u");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21c9w4e5V","Mz1x5P943g");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21r1z4k2D","Mu0z0Q217g");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21p6v9u4N","Ms4s6M387h");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21n7y2f4X","Mw6m8O560f");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21f7c9s5M","Mx8k5K647b");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21d1n4r9Z","Me3g9B611s");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21z2k0g2Z","Mu5q0X096d");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21g3m9s7I","Mf8f7M636u");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21z3e6c2F","My8q7F235n");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21u0o9p4S","Mk9y9D468e");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21s7j5a6V","Mu2v0K283k");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21j2n0e0U","My0f5H763w");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21j8o1a3G","Mb1w9M013e");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21l8p2s9M","Mw0l3R867t");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21c5y3b3D","My7k8N041k");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21i1b1u3K","Md5b9M452t");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21a5f4z0X","Mm6c4D957b");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21x9j6r5J","Mb5h5I260e");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21s9w5f1N","Mj0a1U705x");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21p6r5h3T","Me8k6H847p");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21h9a5z8Y","Md2h6T495t");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21y1u2m4V","Mo5m8L610u");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21z2d7c5Q","Mp4z5I962d");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21o1f7t9Z","My4v9S021v");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21b7l9f4G","Ms1q7I681f");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21o0p9v2G","Mn7s2O909a");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21j0t6i5Q","Mc0p4E524h");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21r0h1t2L","My2p6M506o");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21i8g8k3M","Mi0l0E160a");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21z1v3d9J","Mr9v7T981t");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21i1d0e4O","Mv7y0F199p");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21x8u8t1N","My9c2W930j");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21h2g2o2Z","Mz3f2N363a");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21o2l9d5N","Mu2y1X981j");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21b5c7q0B","Mt8x3H190l");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21f2w0f2G","Mq2x6A548m");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21e6i6i6N","Mz4l5X072q");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21p9e2x7Z","Mo9r7M547r");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21o0f4s7Z","Ml1s3W395g");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21z8z0v1D","Mg7g3Y983x");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21j1a5t0U","Mz1i1O438m");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21l8k8k9L","Ml1h4P981r");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21y2q1v1W","Mr8f6E574i");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21i3i4o2O","Mx7y6X802o");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21d3y2f0U","Mv8x9K926h");
INSERT INTO `Makes` (`userID`,`transactionID`) VALUES ("I21r6i4t5D","Mr4x2K333u");


	 
-- QUERIES 
	 
-- PARALEGAL
-- 'A21s9n5a5A', 'Giselle', 'Astra', 'Hanson', '1989-10-22', 'Male', '19792', '14', '57', '19', '20', 'vestibulum.lorem@ornarelibero.co.uk', '9900412440', 'Paralegal', '38', 'P.O. Box 759, 6311 Arcu Avenue', 'Cirebon', '6444871126', 'West Java', 'LGBTQ Law', '4'


-- 1. view their personal details
CREATE OR REPLACE VIEW myDetails AS
SELECT * FROM lawyer
WHERE userID = "A21s9n5a5A";

select * from myDetails;

-- 2. view/add events
CREATE OR REPLACE VIEW myEvents AS
select * from calendar
where userID = "A21s9n5a5A";

select * from myEvents;

-- 3. view all case details for all cases in the firm
create or replace view allCases as 
select h.caseID, c.plaintiff, c.lastDateOfActivity, c.flair, c.dateOfFiling, c.duration, c.status, ic.userID as ClientID, ic.firstName as CFirstName, ic.lastName as CLastName, ic.emailID as CEmailID, ic.isClient, ic.city as CCity, l.userID as LawyerID, l.firstName as LFirstName, l.lastName as LLastName, l.emailID as LEmailID, l.positionAtFirm, l.specialization, l.city as LCity, o.oppositionID, o.firstName as OFirstName, o.lastName as OLastName from lawyer l, handles h, legalcases c, hasa ch, individualclients ic, opposition o, against a
where l.userID = h.userID and h.caseID = c.caseID and ch.userID = ic.userID and a.oppositionID = o.oppositionID and a.caseID = c.caseID;

select * from allCases;

-- 4. view/update allowed legal documents for all cases in the firm
create or replace view allLegalDocs as 
select d.docID, d.createdOn, d.dateLastModified, d.type, c.caseID, c.lastdateofactivity, c.flair, c.status, c.plaintiff from legaldocuments d, legalcases c
where d.caseID = c.caseID and d.visibility = 1;

select * from allLegalDocs;


-- 5. view their own cases
create or replace view myCases as 
select caseID, plaintiff, lastDateOfActivity, flair, dateOfFiling, duration, status, ClientID, CFirstName, CLastName, CEmailID, isClient, CCity from allCases 
where LawyerID = "A21s9n5a5A";

select * from myCases;

-- 6. search for cases using flair, client details, etc. 
-- search using flair
select * from allCases
where flair = "Tenant Law";
-- search using client's last name
select * from allCases 
where CLastName = "Brady";
-- sort all cases by client's city
select * from allCases 
order by CCity;
-- search for all cases of a particular lawyer
select * from allCases
where LLastName = "Griffin";


-- CUSTOMER/CLIENT
-- 'I21p5a6t2C', 'MacKensie', 'Trevor', 'Crosby', '1987-04-27', '13540', 'arcu@necmetus.edu', '9729651309', 'Ap #335-2862 Curae; St.', 'Stargard Szczeciński', '80461', 'ZP', '1'

-- 1. View their personal details. 
create or replace view myDetailsClient as
select * from individualclients
where userID = "I21p5a6t2C";

select * from myDetailsClient;

-- 2. view/ add events
CREATE OR REPLACE VIEW myEventsClient AS
select * from calendar
where userID = "I21p5a6t2C";

select * from myEventsClient;

-- 3. View case details of all their cases
create or replace view allMyCasesClient as 
select h.caseID, c.plaintiff, c.lastDateOfActivity, c.flair, c.dateOfFiling, c.duration, c.status, l.userID as LawyerID, l.firstName as LFirstName, l.lastName as LLastName, l.emailID as LEmailID, l.positionAtFirm, l.specialization, l.city as LCity, o.oppositionID, o.firstName as OFirstName, o.lastName as OLastName from lawyer l, handles h, legalcases c, hasa ch, individualclients ic, opposition o, against a
where l.userID = h.userID and h.caseID = c.caseID and ch.userID = ic.userID and a.oppositionID = o.oppositionID and a.caseID = c.caseID;

select * from allMyCasesClient; 

-- 4. View all bills 
create or replace view myBillsClient as 
select f.transactionID, f.dateOfPayment, f.description, f.amount, c.caseID, c.flair, c.status from financialtransactions f, invest i, hasa h, legalCases c
where f.transactionID = i.transactionid and i.caseID = h.caseID and h.caseID = c.caseID and h.userID = "I21p5a6t2C";

select * from myBillsClient;

-- Best suited lawyer from customer.	 
create or replace view BestSuitedLawyer as
select lawyer.firstname, lawyer.lastname, lawyer.userID from lawyer 
where specialization="Civil" and experience >= 0 and avgTimePerCase <= 89 and charges <= 30000 and clientRating >= 3 and casesWon div casesLost >= 0;



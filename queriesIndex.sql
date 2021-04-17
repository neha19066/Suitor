use suitor;
-- QUERIES

-- PARALEGAL
-- 'A21s9n5a5A', 'Giselle', 'Astra', 'Hanson', '1989-10-22', 'Male', '19792', '14', '57', '19', '20', 'vestibulum.lorem@ornarelibero.co.uk', '9900412440', 'Paralegal', '38', 'P.O. Box 759, 6311 Arcu Avenue', 'Cirebon', '6444871126', 'West Java', 'LGBTQ Law', '4'

CREATE USER ParalegalU@localhost IDENTIFIED BY 'pass';
CREATE ROLE Paralegal;    
GRANT SELECT ON suitor.myDetails TO Paralegal;
GRANT SELECT ON suitor.allLegalDocs TO Paralegal;
GRANT SELECT, UPDATE, DELETE, INSERT ON suitor.myEvents TO Paralegal;
GRANT SELECT ON suitor.allCases TO Paralegal;
GRANT SELECT ON suitor.myCases TO Paralegal;
GRANT Paralegal TO ParalegalU@localhost;


-- view their personal details
CREATE OR REPLACE VIEW myDetails AS
SELECT * FROM lawyer
WHERE userID = "A21s9n5a5A";

select * from myDetails;

-- view/add events
CREATE OR REPLACE VIEW myEvents AS
select * from calendar
where userID = "A21s9n5a5A";

select * from myEvents;

-- add new meeting
insert into myEvents values("A21s9n5a5A", '2021-05-01 02:00:00',"Settlement Meeting");

-- reschedule meeting
update myEvents 
set 
myEvents.when = '2021-05-01 04:30:00'
where userID = "A21s9n5a5A" and myEvents.when = '2021-05-01 02:00:00';

-- delete details of cancelled meting
delete from myEvents 
where userID = "A21s9n5a5A" and myEvents.when = '2021-05-01 04:30:00';

-- view all case details for all cases in the firm
create or replace view allCases as 
select h.caseID, c.plaintiff, c.lastDateOfActivity, c.flair, c.dateOfFiling, c.duration, c.status, ic.userID as ClientID, ic.firstName as CFirstName, ic.lastName as CLastName, ic.emailID as CEmailID, ic.isClient, ic.city as CCity, l.userID as LawyerID, l.firstName as LFirstName, l.lastName as LLastName, l.emailID as LEmailID, l.positionAtFirm, l.specialization, l.city as LCity, o.oppositionID, o.firstName as OFirstName, o.lastName as OLastName from lawyer l, handles h, legalcases c, hasa ch, individualclients ic, opposition o, against a
where l.userID = h.userID and h.caseID = c.caseID and ch.userID = ic.userID and a.oppositionID = o.oppositionID and a.caseID = c.caseID;

select * from allCases;

-- view/update allowed legal documents for all cases in the firm
create or replace view allLegalDocs as 
select d.docID, d.createdOn, d.dateLastModified, d.type, c.caseID, c.lastdateofactivity, c.flair, c.status, c.plaintiff from legaldocuments d, legalcases c
where d.caseID = c.caseID and d.visibility = 1;

select * from allLegalDocs;


-- view their own cases
create or replace view myCases as 
select caseID, plaintiff, lastDateOfActivity, flair, dateOfFiling, duration, status, ClientID, CFirstName, CLastName, CEmailID, isClient, CCity from allCases 
where LawyerID = "A21s9n5a5A";

select * from myCases;

-- search for cases using flair, client details, etc. 
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

CREATE USER CustomerU@localhost IDENTIFIED BY 'pass';
CREATE ROLE Customer;    
GRANT SELECT ON suitor.myDetailsClient TO Customer;
GRANT SELECT, INSERT, UPDATE, DELETE ON suitor.myEventsClient TO Customer;
GRANT SELECT ON suitor.allmycasesclient TO Customer;
GRANT SELECT ON suitor.mybillsClient TO Customer;
GRANT SELECT ON suitor.bestsuitedlawyer TO Customer;
GRANT Customer TO CustomerU@localhost;

drop role Customer;
drop user CustomerU@localhost;

select user, host from MySQL.user;

-- login using \connect --mysql CustomerU@localhost on MySQL Shell
-- change to sql using \sql
-- do set role all;
-- use whatever commands you want now


-- View their personal details. 
create or replace view myDetailsClient as
select * from individualclients
where userID = "I21p5a6t2C";

select * from myDetailsClient;

-- view/ add events
CREATE OR REPLACE VIEW myEventsClient AS
select * from calendar
where userID = "I21p5a6t2C";

select * from myEventsClient;

-- add new meeting
insert into myEventsClient values("I21p5a6t2C", '2021-05-01 02:00:00',"Settlement Meeting");

-- reschedule meeting
update myEventsClient 
set 
myEventsClient.when = '2021-05-01 04:30:00'
where userID = "I21p5a6t2C" and myEventsClient.when = '2021-05-01 02:00:00';

-- delete details of cancelled meting
delete from myEventsClient 
where userID = "I21p5a6t2C" and myEventsCLient.when = '2021-05-01 04:30:00';



-- View case details of all their cases
create or replace view allMyCasesClient as 
select distinct h.caseID, c.plaintiff, c.lastDateOfActivity, c.flair, c.dateOfFiling, c.duration, c.status, l.userID as LawyerID, l.firstName as LFirstName, l.lastName as LLastName, l.emailID as LEmailID, l.positionAtFirm, l.specialization, l.city as LCity, o.oppositionID, o.firstName as OFirstName, o.lastName as OLastName from lawyer l, handles h, legalcases c, hasa ch, individualclients ic, opposition o, against a
where l.userID = h.userID and h.caseID = c.caseID and ch.userID = ic.userID and a.oppositionID = o.oppositionID and a.caseID = c.caseID;

select * from allMyCasesClient; 

-- View all bills 
create or replace view myBillsClient as 
select f.transactionID, f.dateOfPayment, f.description, f.amount, c.caseID, c.flair, c.status from financialtransactions f, invest i, hasa h, legalCases c
where f.transactionID = i.transactionid and i.caseID = h.caseID and h.caseID = c.caseID and h.userID = "I21p5a6t2C";

select * from myBillsClient;

-- Best suited lawyer from customer.	 
create or replace view BestSuitedLawyer as
select lawyer.firstname, lawyer.lastname, lawyer.userID from lawyer 
where specialization="Civil" and experience >= 0 and avgTimePerCase <= 89 and charges <= 30000 and clientRating >= 3 and casesWon div casesLost >= 0;

select * from BestSuitedLawyer;


-- LAWYER

CREATE USER LawyerU@localhost IDENTIFIED BY 'pass';
CREATE ROLE Lawyer;    
GRANT SELECT, INSERT, UPDATE, DELETE ON suitor.LawyerEvents TO Lawyer;
GRANT SELECT ON suitor.LawyerDeets TO Lawyer;
GRANT SELECT, UPDATE ON suitor.LawyerCases TO Lawyer;
GRANT SELECT ON suitor.otherLawyers TO Lawyer;
GRANT SELECT ON visibleDocs TO Lawyer;
GRANT SELECT ON individualsasclients TO Lawyer;
GRANT SELECT ON companyclients TO Lawyer;
GRANT Lawyer TO LawyerU@localhost;

-- View their personal details (financial history, track record).
create or replace view LawyerDeets as 
select * from Lawyer where userId="A21a0f5x5m";

select * from LawyerDeets;

-- View events (such as current court hearings related to ongoing cases).
CREATE OR REPLACE VIEW LawyerEvents AS
select * from calendar
where userID = "A21a0f5x5m";

select * from LawyerEvents;

-- add new meeting
insert into LawyerEvents values("A21a0f5x5m", '2021-05-01 02:00:00',"Settlement Meeting");

-- reschedule meeting
update LawyerEvents 
set 
LawyerEvents.when = '2021-05-01 04:30:00'
where userID = "A21a0f5x5m" and LawyerEvents.when = '2021-05-01 02:00:00';

-- delete details of cancelled meting
delete from LawyerEvents
where userID = "A21a0f5x5m" and LawyerEvents.when = '2021-05-01 04:30:00';


-- View case details of all their cases. **** Take userID INPUT. ****
CREATE OR REPLACE VIEW LawyerCases AS
select legalcases.caseID, plaintiff, lastDateOfActivity, flair, dateOfFiling, duration, legalcases.status 
from handles inner join legalcases 
on legalcases.caseID=handles.caseID and handles.userID="A21a0f5x5m";

select * from LawyerCases;

-- update cases won/ increment by 1
update lawyerdeets
set casesWon = casesWon+1
where userID = "A21a0f5x5M";

-- View basic details of peers (not salary).
create or replace view otherlawyers as
select firstname, lastname, emailId, specialization, experience, casesLost, casesSettled, avgTimePerCase, clientRating from lawyer;

select * from otherlawyers;

-- View allowed documents related to any case of the law firm.
create or replace view visibleDocs as 
select d.docID, d.createdOn, d.dateLastModified, d.type, c.caseID, c.lastdateofactivity, c.flair, c.status, c.plaintiff from legaldocuments d, legalcases c
where d.caseID = c.caseID and d.visibility = 1;

select * from visibleDocs;

-- View data of all their clients.
CREATE OR REPLACE VIEW IndividualsAsClients AS
select * from individualclients where userID in (
select hasa.userID 
from handles inner join Lawyer 
on handles.userID=lawyer.userID and lawyer.userID="A21a0f5x5m" 
inner join hasa 
on hasa.caseID=handles.caseID);

select * from individualsasclients;

CREATE OR REPLACE VIEW CompanyClients AS
select * from clientcompanies where userID in (
select hasa.userID 
from handles inner join Lawyer 
on handles.userID=lawyer.userID and lawyer.userID="A21a0f5x5m" 
inner join hasa 
on hasa.caseID=handles.caseID);

select * from companyclients;
	 
-- MANAGING PARTNER
-- 	O21a0b2d6K	Keely	Duncan	Moody	1986-05-01	Female	18547	20	dictum.magna.Ut@Nulla.net	9490378505	Support Staff	P.O. Box 631, 8421 In Road	Itagüí	76642	Antioquia

CREATE USER MPU@localhost IDENTIFIED BY 'pass';
CREATE ROLE MP;    
GRANT SELECT, INSERT, UPDATE, DELETE ON suitor.myeventsmanagement TO MP;
GRANT SELECT ON suitor.mymanagingpartner TO MP;
GRANT SELECT, UPDATE, INSERT, DELETE ON suitor.allFinancialTrans TO MP;
GRANT SELECT ON suitor.ChooseLawyerRatio TO MP;
GRANT SELECT ON suitor.ChooseLawyerRating TO MP;
GRANT ALL PRIVILEGES ON suitor.* TO MP;
GRANT MP TO MPU@localhost;

-- 1. View their personal details. 
create or replace view myManagingPartner as
select * from OtherStaff
where userID = "O21a0b2d6K";

select * from myManagingPartner;

-- 2. view/ add events
CREATE OR REPLACE VIEW myEventsManagement AS
select * from Calendar
where userID = "O21a0b2d6K";

select * from myEventsManagement;

-- add new meeting
insert into myEventsManagement values("O21a0b2d6K", '2021-05-01 02:00:00',"Settlement Meeting");

-- reschedule meeting
update myEventsManagement 
set 
myEventsManagement.when = '2021-05-01 04:30:00'
where userID = "O21a0b2d6K" and myEventsManagement.when = '2021-05-01 02:00:00';

-- delete details of cancelled meting
delete from myEventsManagement 
where userID = "O21a0b2d6K" and myEventsManagement.when = '2021-05-01 04:30:00';

-- 3. view/update all financial transactions in the firm
CREATE OR REPLACE VIEW allFinancialTrans AS
select * from FinancialTransactions ;

select * from allFinancialTrans;

-- 4. Choose Lawyer on the basis of win/loss ratio
CREATE OR REPLACE VIEW ChooseLawyerRatio AS
Select *  From Lawyer where round(casesWon/casesLost) in
(Select max(Ratio) from
(select userID, round(casesWon/casesLost) as Ratio from Lawyer) as latest);

select * from ChooseLawyerRatio;

-- 5. Choose lawyer on the basis of rating
CREATE OR REPLACE VIEW ChooseLawyerRating AS
Select Distinct userID, firstName, lastName, clientRating From Lawyer  where clientRating in 
(Select max(clientRating) from Lawyer) limit 1;

select * From ChooseLawyerRating;


-- OTHER STAFF 
-- 	O21a0b2d6K	Keely	Duncan	Moody	1986-05-01	Female	18547	20	dictum.magna.Ut@Nulla.net	9490378505	Support Staff	P.O. Box 631, 8421 In Road	Itagüí	76642	Antioquia

CREATE USER StaffU@localhost IDENTIFIED BY 'pass';
CREATE ROLE Staff;    
GRANT SELECT, INSERT, UPDATE, DELETE ON suitor.myEventsStaff TO Staff;
GRANT SELECT ON suitor.myDetailsStaff TO Staff;
GRANT SELECT, UPDATE, INSERT, DELETE ON suitor.allFinancialTrans TO Staff;
GRANT Staff TO StaffU@localhost;

-- 1. View their personal details. 
create or replace view myDetailsStaff as
select * from OtherStaff
where userID = "O21a0b2d6K";

select * from myDetailsStaff;

-- 2. view/ add events
CREATE OR REPLACE VIEW myEventsStaff AS
select * from Calendar
where userID = "O21a0b2d6K";

select * from myeventsStaff;

-- add new meeting
insert into myEventsStaff values("O21a0b2d6K", '2021-05-01 02:00:00',"Settlement Meeting");

-- reschedule meeting
update myEventsStaff 
set 
myEventsStaff.when = '2021-05-01 04:30:00'
where userID = "O21a0b2d6K" and myEventsStaff.when = '2021-05-01 02:00:00';

-- delete details of cancelled meting
delete from myEventsStaff
where userID = "O21a0b2d6K" and myEventsStaff.when = '2021-05-01 04:30:00';

select * from myEventsStaff;

-- 3. view/update all financial transactions in the firm
CREATE OR REPLACE VIEW allFinancialTrans AS
select * from FinancialTransactions ;

select * from allFinancialTrans;


-- INDEXING
-- -----------------------------------------

create index lawyer_city on Lawyer(city);
create index lawyer_lastName on Lawyer(LastName);
create index lawyer_charges on Lawyer(cHARGES);
create index lawyer_time on Lawyer(avgTimePerCase);
create index lawyer_exp on Lawyer(experience);
create index lawyer_rating on Lawyer(clientRating);
show index from lawyer;

create index doc_visibility on LegalDocuments(visibility);

show index from legaldocuments;

show index from legalcases;

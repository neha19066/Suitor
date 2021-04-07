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
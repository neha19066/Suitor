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


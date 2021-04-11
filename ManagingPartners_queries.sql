use suitor;
-- 	O21a0b2d6K	Keely	Duncan	Moody	1986-05-01	Female	18547	20	dictum.magna.Ut@Nulla.net	9490378505	Support Staff	P.O. Box 631, 8421 In Road	Itagüí	76642	Antioquia
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
Select Distinct userID, firstName, lastName From Lawyer  where clientRating in 
(Select max(clientRating) from Lawyer) limit 1;

select * From ChooseLawyerRating;
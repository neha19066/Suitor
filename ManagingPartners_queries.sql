use suitor;
-- 	O21a0b2d6K	Keely	Duncan	Moody	1986-05-01	Female	18547	20	dictum.magna.Ut@Nulla.net	9490378505	Support Staff	P.O. Box 631, 8421 In Road	Itagüí	76642	Antioquia
-- 1. View their personal details. 
create or replace view myManagingPartner as
select * from OtherStaff
where userID = "O21a0b2d6K";

select * from myDetailsStaff;

-- 2. view/ add events
CREATE OR REPLACE VIEW myEventsStaff AS
select * from Calendar
where userID = "O21a0b2d6K";

select * from myEventsStaff;

-- 3. view/update all financial transactions in the firm
CREATE OR REPLACE VIEW allFinancialTrans AS
select * from FinancialTransactions ;

select * from allFinancialTrans;

-- 4. view/update all financial transactions in the firm
CREATE OR REPLACE VIEW ChooseLawyer AS
Select * from Lawyer where userID in
(select userID, round(casesWon/casesLost) as Ratio from Lawyer);

select * from ChooseLawyer;


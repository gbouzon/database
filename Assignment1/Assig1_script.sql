Begin
for c in (select table_name from user_tables) loop
execute immediate ('drop table '||c.table_name||' cascade constraints');
end loop;
End; 
/

/* Assignment_1 */

ALTER SESSION SET NLS_DATE_FORMAT = 'MM/DD/YYYY';

CREATE TABLE DOCTOR (
DOC_ID varchar2(5) PRIMARY KEY,
DOC_LNAME varchar2(15),
DOC_FNAME varchar2(15),
DOC_INITIAL varchar2(1),
DOC_SPECIALTY varchar2(15)
);

INSERT INTO DOCTOR VALUES('29827','Sanchez','Julio','J','Dermatology');
INSERT INTO DOCTOR VALUES('32445','Jorgensen','Annelise','G','Neurology');
INSERT INTO DOCTOR VALUES('33456','Korenski','Anatoly','A','Urology');
INSERT INTO DOCTOR VALUES('33989','LeGrande','George','','Pediatrics');
INSERT INTO DOCTOR VALUES('34409','Washington','Dennis','F','Orthopaedics');
INSERT INTO DOCTOR VALUES('36221','McPherson','Katye','H','Dermatology');
INSERT INTO DOCTOR VALUES('36712','Dreifag','Herman','G','Psychiatry');
INSERT INTO DOCTOR VALUES('38995','Minh','Tran','','Neurology');
INSERT INTO DOCTOR VALUES('40004','Chin','Ming','D','Orthopaedics');
INSERT INTO DOCTOR VALUES('40028','Feinstein','Denise','L','Gynecology');

/* -- */

CREATE TABLE DRUG (
DRUG_CODE varchar2(5) PRIMARY KEY,
DRUG_NAME varchar2(25),
DRUG_PRICE number,
DRUG_MANU_DATE DATE
);

INSERT INTO DRUG VALUES('AF15','Afgapan-15','25','10/12/2019');
INSERT INTO DRUG VALUES('AF25','Afgapan-25','35','12/12/2018');
INSERT INTO DRUG VALUES('DRO','Droalene Chloride','111.89','10/12/2017');
INSERT INTO DRUG VALUES('DRZ','Druzocholar Cryptolene','18.99','11/12/2019');
INSERT INTO DRUG VALUES('KO15','Koliabar Oxyhexalene','65.75','11/12/2020');
INSERT INTO DRUG VALUES('OLE','Oleander-Drizapan','123.95','11/12/2020');
INSERT INTO DRUG VALUES('TRYP','Tryptolac Heptadimetric','79.45','11/12/2020');

/* -- */

CREATE TABLE PATIENT (
PAT_NUM varchar2(5)PRIMARY KEY,
PAT_TITLE varchar2(4),
PAT_LNAME varchar2(15),
PAT_FNAME varchar2(15),
PAT_INITIAL varchar2(1),
PAT_DOB date,
PAT_AREACODE varchar2(3),
PAT_PHONE varchar2(8)
);

INSERT INTO PATIENT VALUES('100','Mr.','Kolmycz','George','D','6/15/1942','615','324-5456');
INSERT INTO PATIENT VALUES('101','Ms.','Lewis','Rhonda','G','3/19/2005','615','324-4472');
INSERT INTO PATIENT VALUES('102','Mr.','VanDam','Rhett','','11/14/1958','901',null);
INSERT INTO PATIENT VALUES('103','Ms.','Jones','Anne','M','10/16/1974','615','898-3456');
INSERT INTO PATIENT VALUES('104','Mr.','Lange','John','P','11/8/1971','901',null);
INSERT INTO PATIENT VALUES('105','Mr.','Williams','Robert','D','3/14/1975','615','890-3220');
INSERT INTO PATIENT VALUES('106','Mrs.','Smith','Jeanine','K','2/12/2003','615','324-7883');
INSERT INTO PATIENT VALUES('107','Mr.','Diante','Jorge','D','8/21/1974','615','890-4567');
INSERT INTO PATIENT VALUES('108','Mr.','Wiesenbach','Paul','R','2/14/1966','615','897-4358');
INSERT INTO PATIENT VALUES('109','Mr.','Smith','George','K','6/18/1961','901','504-3339');
INSERT INTO PATIENT VALUES('110','Mrs.','Genkazi','Leighla','W','5/19/1970','901','569-0093');
INSERT INTO PATIENT VALUES('111','Mr.','Washington','Rupert','E','1/3/1966','615','890-4925');
INSERT INTO PATIENT VALUES('112','Mr.','Johnson','Edward','E','5/14/1961','615','898-4387');
INSERT INTO PATIENT VALUES('113','Ms.','Smythe','Melanie','P','9/15/1970','615','324-9006');
INSERT INTO PATIENT VALUES('114','Ms.','Brandon','Marie','G','11/2/1932','901','882-0845');
INSERT INTO PATIENT VALUES('115','Mrs.','Saranda','Hermine','R','7/25/1972','615',null);
INSERT INTO PATIENT VALUES('116','Mr.','Smith','George','A','11/8/1965','615','890-2984');

/* -- */

CREATE TABLE PRESCRIPTION (
DOC_ID varchar2(5),
PAT_NUM varchar2(5),
DRUG_CODE varchar2(5),
PRES_DOSAGE varchar2(50),
PRES_DATE date,
PRIMARY KEY (DOC_ID , PAT_NUM, DRUG_CODE)
);

INSERT INTO PRESCRIPTION VALUES('32445','102','DRZ','2 tablets every four hours -- 50 tablets total','11/12/2012');
INSERT INTO PRESCRIPTION VALUES('34409','101','KO15','1 tablet every six hours -- 30 tablets total','11/15/2012');
INSERT INTO PRESCRIPTION VALUES('32445','113','OLE','1 teaspoon with each meal -- 250 ml total','11/14/2012');
INSERT INTO PRESCRIPTION VALUES('36221','109','DRO','2 tablets with every meal -- 60 tablets total','11/14/2018');
INSERT INTO PRESCRIPTION VALUES('38995','107','KO15','1 tablet every six hours -- 30 tablets total','11/10/2019');
INSERT INTO PRESCRIPTION VALUES('40028','107','OLE','2 tablet every six hours -- 30 tablets total','11/10/2018');
INSERT INTO PRESCRIPTION VALUES('32445','116','KO15','2 tablets every four hours -- 50 tablets total','11/01/2012');

----------------------------------------------------------------------------------------------------------------------------------------------------

-- 1. List all the rows in which the prescription dates occur on or after November 14th

SELECT * FROM PRESCRIPTION WHERE TO_CHAR(PRES_DATE, 'MM/DD') >= '11/14';

-- 2. How many doctors provide prescriptions with 30 tablets in total?

SELECT COUNT(DOC_ID) FROM PRESCRIPTION WHERE LOWER(PRES_DOSAGE) LIKE '%30 tablets total';

-- 3.1 List doctor�s details where speciality is either Dermatology or Neurology. (Use IN
-- operator). List the results by the first name in ascending order

SELECT * FROM DOCTOR WHERE UPPER(DOC_SPECIALTY) IN ('DERMATOLOGY', 'NEUROLOGY') ORDER BY DOC_FNAME ASC, DOC_LNAME DESC;

-- 4. Find all patients rows whose first name include 'George'.

SELECT * FROM PATIENT WHERE UPPER(PAT_FNAME) LIKE '%GEORGE%';

-- 5. List number of patients that do not have a phone number

SELECT COUNT(PAT_NUM) FROM PATIENT WHERE PAT_PHONE IS NULL;

-- 6. How many drugs with price < 40?

SELECT COUNT(DRUG_CODE) FROM DRUG WHERE DRUG_PRICE < 40;

-- 7. How many prescriptions are generated for each patient, limit the listing to patients who
-- have more than 2 prescriptions?

SELECT PAT_NUM, COUNT(*) FROM PRESCRIPTION GROUP BY PAT_NUM HAVING COUNT(PAT_NUM) > 2;

-- 8. List the drug codes and prices (rounded to one decimal place)

SELECT DRUG_CODE, ROUND(DRUG_PRICE, 1) FROM DRUG;

-- 9. How many doctors prescribe the drug code K015?

SELECT COUNT(DISTINCT DOC_ID) FROM PRESCRIPTION WHERE DRUG_CODE = 'KO15';

-- 10. List all drugs with their expiration date (one year from the date of manufacturer) 

SELECT DRUG_CODE, DRUG_NAME, DRUG_PRICE, DRUG_MANU_DATE, ADD_MONTHS(DRUG_MANU_DATE, 12) AS DRUG_EXPIRATION_DATE FROM DRUG;

-- 11. List all drugs whose prices are between 50 and 100

SELECT * FROM DRUG WHERE DRUG_PRICE BETWEEN '50' AND '100';

--12. List number of female patients born in 1970

SELECT COUNT(PAT_NUM) FROM PATIENT WHERE TO_CHAR(PAT_DOB, 'YYYY') = '1970' AND UPPER(PAT_TITLE) != 'MR.';

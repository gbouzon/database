/* Database Exam, Artist database, Dr. N. Drawel */
Begin
for c in (select table_name from user_tables) loop
execute immediate ('drop table '||c.table_name||' cascade constraints');
end loop;
End; 
/

CREATE TABLE GALLERY (
GAL_NUM char(4),
GAL_OWNER varchar(35),
GAL_AREACODE char(3),
GAL_PHONE char(8),
GAL_RATE number
);
INSERT INTO GALLERY VALUES('5','L. R. Gilliam','901','123-4456',0.37);
INSERT INTO GALLERY VALUES('6','G. G. Waters','405','353-2243',0.45 );
INSERT INTO GALLERY VALUES('1','N. D. Cosner','203','123-9956',0.67);
INSERT INTO GALLERY VALUES('2','S. H. Artwork','415','154-3243',0.30);

/* -- */

CREATE TABLE PAINTER (
PTR_NUM char(4),
PTR_LASTNAME varchar(15) NOT NULL,
PTR_FIRSTNAME varchar(15) NOT NULL,
PTR_AREACODE char(3),
PTR_PHONE char(8)
);
INSERT INTO PAINTER VALUES('123','Ross','Georgette','901','885-4567');
INSERT INTO PAINTER VALUES('126','Itero','Julio','901','346-1112');
INSERT INTO PAINTER VALUES('127','Geoff','George','615','221-4456');

/* -- */

CREATE TABLE PAINTING (
PTNG_NUM char(4),
PTNG_TITLE varchar(35),
PTNG_PRICE number,
PTR_NUM char(4),
GAL_NUM char(4)
);

INSERT INTO PAINTING VALUES('1338','Dawn Thunder',245.5,'123','5');
INSERT INTO PAINTING VALUES('1339','A Faded Rose',6723,'123','1');
INSERT INTO PAINTING VALUES('1340','The Founders',567.99,'126','6');
INSERT INTO PAINTING VALUES('1341','Hasty Pudding Exit',145.5,'123','');
INSERT INTO PAINTING VALUES('1342','Plastic Paradise',8328.99,'126','6');
INSERT INTO PAINTING VALUES('1343','Roamin''',785,'127','6');
INSERT INTO PAINTING VALUES('1344','Wild Waters',999,'127','5');
INSERT INTO PAINTING VALUES('1345','Stuff ''n Such ''n Some',9800,'123','5');

-------------------------------------------------------------------------------------------------------------------

ALTER TABLE GALLERY
ADD CONSTRAINT GALLERY_GALNUM_PK PRIMARY KEY(GAL_NUM);

ALTER TABLE PAINTER
ADD CONSTRAINT PAINTER_PTR_NUM_PK PRIMARY KEY(PTR_NUM);

ALTER TABLE PAINTING
ADD CONSTRAINT PAINTING_PNUM_PK PRIMARY KEY(PTNG_NUM);

ALTER TABLE PAINTING 
ADD CONSTRAINT PAINTING_TITLE_UQ UNIQUE(PTNG_TITLE);

ALTER TABLE PAINTING
ADD CONSTRAINT PAINTING_PRICE_CK CHECK(PTNG_PRICE > 100 AND PTNG_PRICE < 10000);

ALTER TABLE PAINTING
ADD CONSTRAINT PAINTING_PTRNUM_FK FOREIGN KEY (PTR_NUM) REFERENCES PAINTER;

ALTER TABLE PAINTING 
ADD CONSTRAINT PAINTING_GALNUM_FK FOREIGN KEY (GAL_NUM) REFERENCES GALLERY;


--1. The manager wants to add a new painter as an artist in the database. What would the
--insert statement look like?

--if the manager is adding it from the get-go then it would look like one of the INSERT statements already done above,
--such as:
INSERT INTO PAINTER VALUES('128','Magnus','Albert','514','331-5678');

--2. For a painter to be considered in the Artist database, the painter must have painted at
--least one painting, however, a painting might not be exhibited in a gallery. Based on
--these business rules, please insert one painting for the painter that you inserted in Q1.

INSERT INTO PAINTING VALUES('1346', 'A World Beneath a World', 5467, '128', null);

--3. List all painting titles with price greater than 5000$.

SELECT PTNG_TITLE FROM PAINTING WHERE PTNG_PRICE > 5000;

--4. How many paintings does �Ross Georgette� have?

SELECT COUNT(PTNG_NUM) FROM PAINTING NATURAL JOIN PAINTER 
WHERE UPPER(PTR_LASTNAME) = 'ROSS' AND UPPER(PTR_FIRSTNAME) = 'GEORGETTE';

SELECT * FROM PAINTING;
SELECT * FROM PAINTER;

--5. Find the title of paintings that displayed on �L. R. Gilliam� gallery

SELECT PTNG_TITLE FROM PAINTING NATURAL JOIN GALLERY
WHERE UPPER(GAL_OWNER) = 'L. R. GILLIAM';

SELECT * FROM PAINTING;
SELECT * FROM GALLERY;

--6. Make a discount of 10% for all paintings.

UPDATE PAINTING
SET PTNG_PRICE = PTNG_PRICE * 0.9; --A 10% DISCOUNT IMPLIES THAT WE WILL BE PAYING 90% THEREFORE 90/100 = 0.9

--7. Write the SQL command to save all the changes made to the table.? 

COMMIT;

--8. Remove a gallery number �5� from the GALLERY table. Is deleting a GALLERY row creates
--problems in the database, why/why not? If yes, how to solve this problem?

DELETE FROM GALLERY WHERE GAL_NUM = '5';

-- YES, IT WOULD CAUSE PROBLEMS BECAUSE GAL_NUMS ARE FOREIGN KEYS IN THE PAINTING TABLE SO
--THERE WILL BE AN INTEGRITY CONSTRAINT VIOLATED
--WE CAN USE ON DELETE CASCADE TO AVOID THIS AT THE END OF THE FK CONSTRAINT DEFINITION IN THE PAINTING TABLE

--9. Display painters� details who exhibit their paintings at more than one gallery at a time

SELECT PTR_NUM, COUNT(*) FROM PAINTING 
GROUP BY PTR_NUM HAVING COUNT(GAL_NUM) > 1



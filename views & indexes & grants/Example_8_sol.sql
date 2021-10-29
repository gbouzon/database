-- 1.Create a sequence named rent_num_seq to start with 1100, increment by 10,
-- and do not cache any values. 

CREATE SEQUENCE RENT_NUM_SEQ
START WITH 1100
INCREMENT BY 10
NOCACHE;

--2. Insert a new row in the rental table using the sequence created in #1 
-- above to generate the value for RENT_NUM, the current system date for 
-- the value for RENT_DATE, and the membership number MEM_NUM.
INSERT INTO RENTAL VALUES(RENT_NUM_SEQ.NEXTVAL, SYSDATE, '103');
ROLLBACK;
SELECT * FROM RENTAL;
COMMIT;
-- 3. Check the next value after the new row is inserted?
SELECT * FROM USER_SEQUENCES;

--4. The RENTAL and DETAILRENTAL tables are related in a one-to-many relationship
-- through the RENT_NUM attribute. Use the CURRVAL method in the rent_num_seq 
-- sequence to get the latest Rent_num used and assign it to the related Rent_num 
-- foreign key attribute in the DETAILRENTAL table. 

SELECT * FROM DETAILRENTAL;
INSERT INTO DETAILRENTAL VALUES (RENT_NUM_SEQ.CURRVAL, 54324, NULL,NULL,NULL, NULL);

-- 5. Create a sequence named mem_num_seq. Test your sequence by inserting
-- a new row in MEMBERSHIP table
SELECT * FROM MEMBERSHIP ;
CREATE SEQUENCE mem_num_seq
START WITH 110;

INSERT INTO MEMBERSHIP VALUES(mem_num_seq.NEXTVAL, 'John', 'Smith', '5327 West 145th Avenue', 'Norene', 'TN', '76439', 10);


-- 6. Check all of the sequences you have created
SELECT * FROM USER_SEQUENCES;

-- 7. Alter rent_num_seq to pre_allocate sequence 100 numbers in memory.
ALTER SEQUENCE RENT_NUM_SEQ
CACHE 100;

-- INVALID ALTER WHY???
ALTER SEQUENCE RENT_NUM_SEQ
START WITH 100;
-- INVALID ALTER WHY???
ALTER SEQUENCE RENT_NUM_SEQ
MAXVALUE 100;
--8. Drop the sequence created earlier
DROP SEQUENCE RENT_NUM_SEQ;


--9. Create a view to display the membership number, last name, first name, 
-- and total rental fees earned from that membership. 
-- The total rental fee is the sum of all of the detail fees (without 
-- the late fees) from all movies that the membership has rented
CREATE VIEW MEMBER_VIEW
AS SELECT M.MEM_NUM, MEM_LNAME, MEM_FNAME, SUM(DETAIL_FEE) DETAIL_FEE
FROM MEMBERSHIP M, RENTAL R, DETAILRENTAL D
WHERE M.MEM_NUM = R.MEM_NUM
AND R.RENT_NUM = D.RENT_NUM
GROUP BY M.MEM_NUM, MEM_LNAME, MEM_FNAME;

SELECT * FROM MEMBER_VIEW;








Begin
for c in (select table_name from user_tables) loop
execute immediate ('drop table '||c.table_name||' cascade constraints');
end loop;
End; 
/

CREATE TABLE MEMBERSHIP
( MEM_NUM CHAR(3) CONSTRAINT MEMBER_MEM_NUM_PK PRIMARY KEY,
MEM_FNAME   VARCHAR(30) NOT NULL,
MEM_LNAME   VARCHAR(30) NOT NULL,
MEM_STREET  VARCHAR(15),
MEM_CITY  VARCHAR(10),
MEM_STATE CHAR(2),
MEM_ZIP CHAR(5),
MEM_BALANCE NUMBER (2));

ALTER TABLE MEMBERSHIP
MODIFY MEM_STREET VARCHAR(25);
CREATE TABLE RENTAL
( RENT_NUM CHAR(4) CONSTRAINT RENTAL_RENT_NUM_PK  PRIMARY KEY,
RENT_DATE DATE,
MEM_NUM CHAR(3),
CONSTRAINT RENTAL_MEM_NUM_FK FOREIGN KEY (MEM_NUM) REFERENCES MEMBERSHIP);

CREATE TABLE PRICE
(PRICE_CODE CHAR(1) CONSTRAINT PRICE_PRICE_CODE_PK PRIMARY KEY,
PRICE_DESC VARCHAR(20),
PRICE_RENTFEE NUMBER (3,1),
PRICE_DAILYATFEE NUMBER(3,1));

CREATE TABLE MOVIE
(MOVIE_NUM  CHAR(4) CONSTRAINT MOVIE_MOVIE_NUM_PK PRIMARY KEY,
MOVIE_NAME  VARCHAR(30) NOT NULL,
MOVIE_YEAR CHAR(4),
MOVIE_COST NUMBER(5,2),
MOVIE_GENRE VARCHAR(15),
PRICE_CODE CHAR(1),
CONSTRAINT MOVIE_PRICE_CODE_FK FOREIGN KEY (PRICE_CODE) REFERENCES PRICE);


CREATE TABLE VIDEO
(VID_NUM CHAR(5) CONSTRAINT VIDEO_VIDEO_NUM_PK PRIMARY KEY,
VID_INDATE  DATE,
MOVIE_NUM  CHAR(4),
CONSTRAINT VIDEO_MOVIE_NUM_FK FOREIGN KEY (MOVIE_NUM) REFERENCES MOVIE);


CREATE TABLE DETAILRENTAL
(RENT_NUM CHAR(4),
VID_NUM CHAR(5),
DETAIL_FEE NUMBER(3,1),
DETAIL_DUEDATE DATE,
DETAIL_RETURNDATE DATE,
DETAIL_DAILYLATEFEE NUMBER(2),

CONSTRAINT DETAILRENTAL_RENT_VID_PK PRIMARY KEY(RENT_NUM, VID_NUM),
CONSTRAINT DETAILRENTAL_RENT_FK FOREIGN KEY (RENT_NUM) REFERENCES RENTAL,
CONSTRAINT DETAILRENTAL_VID_FK FOREIGN KEY (VID_NUM) REFERENCES VIDEO);



	
INSERT INTO MEMBERSHIP VALUES('102', 'Tami', 'Dawson', '2632 Takli Circle', 'Norene', 'TN', '37136', 11);
INSERT INTO MEMBERSHIP VALUES('103', 'Curt', 'Knight', '4025 Cornell Court', 'Flatgap', 'KY', '41219', 6);
INSERT INTO MEMBERSHIP VALUES('104', 'Jamal', 'Melendez', '788 East 145th Avenue', 'Quebeck', 'TN', '38579', 0);
INSERT INTO MEMBERSHIP VALUES('105', 'Iva', 'Mcclain', '6045 Musket Ball Circle', 'Summit', 'KY', '42783', 15);
INSERT INTO MEMBERSHIP VALUES('106', 'Miranda', 'Parks', '4469 Maxwell Place', 'Germantown', 'TN', '38402', 5);

INSERT INTO RENTAL VALUES('1001', TO_DATE('01-MAR-09', 'DD-MM-YY'), '103');
INSERT INTO RENTAL VALUES('1002', TO_DATE('01-MAR-09', 'DD-MM-YY'), '105');
INSERT INTO RENTAL VALUES('1003', TO_DATE('02-MAR-09', 'DD-MM-YY'), '102');

INSERT INTO PRICE VALUES('1', 'Standard', 2.0, 1);
INSERT INTO PRICE VALUES('2', 'New Release', 3.5, 3);
INSERT INTO PRICE VALUES('3', 'Discount', 1.5, 1);
INSERT INTO PRICE VALUES('4', 'Weekly Special', 1, 0.5);

INSERT INTO MOVIE VALUES('1234', 'The Cesar Family Christmas', 2007, 39.95, 'FAMILY', '2');
INSERT INTO MOVIE VALUES('1235', 'Smokey Mountain Wildlife', 2004, 59.95, 'ACTION', '3');
INSERT INTO MOVIE VALUES('1236', 'Richard Goodhope', 2008, 59.95, 'DRAMA', '2');
INSERT INTO MOVIE VALUES('1237', 'Beatnik Fever', 2007, 29.95, 'COMEDY', '2');
INSERT INTO MOVIE VALUES('1238', 'Constant Companion', 2008, 89.95, 'DRAMA', '2');
INSERT INTO MOVIE VALUES('1239', 'Where Hope Dies', 1998, 25.49, 'DRAMA', '1');
INSERT INTO MOVIE VALUES('1245', 'Time to Burn', 2005, 45.49, 'ACTION', '3');
INSERT INTO MOVIE VALUES('1246', 'What He Doesnt Know', 2006, 58.29, 'COMEDY', '1');

INSERT INTO VIDEO VALUES('54321', TO_DATE('18-JUN-08', 'DD-MM-YY'), '1234');
INSERT INTO VIDEO VALUES('54324', TO_DATE('18-JUN-08', 'DD-MM-YY'), '1234');
INSERT INTO VIDEO VALUES('54325', TO_DATE('18-JUN-08', 'DD-MM-YY'), '1234');
INSERT INTO VIDEO VALUES('34341', TO_DATE('22-JAN-07', 'DD-MM-YY'), '1235');
INSERT INTO VIDEO VALUES('34342', TO_DATE('22-JAN-07', 'DD-MM-YY'), '1235');
INSERT INTO VIDEO VALUES('34366', TO_DATE('02-MAR-09', 'DD-MM-YY'), '1236');
INSERT INTO VIDEO VALUES('34367', TO_DATE('02-MAR-09', 'DD-MM-YY'), '1236');
INSERT INTO VIDEO VALUES('34368', TO_DATE('02-MAR-09', 'DD-MM-YY'), '1236');
INSERT INTO VIDEO VALUES('34369', TO_DATE('02-MAR-09', 'DD-MM-YY'), '1236');
INSERT INTO VIDEO VALUES('44392', TO_DATE('21-OCT-08', 'DD-MM-YY'), '1237');

INSERT INTO DETAILRENTAL VALUES('1001', '34342', 2, TO_DATE('04-MAR-09', 'DD-MM-YY'), TO_DATE('02-MAR-09', 'DD-MM-YY'), 1);
INSERT INTO DETAILRENTAL VALUES('1001', '44392', 2, TO_DATE('04-MAR-09', 'DD-MM-YY'), TO_DATE('03-MAR-09', 'DD-MM-YY'), 1);
INSERT INTO DETAILRENTAL VALUES('1002', '44392', 3.5, TO_DATE('04-MAR-09', 'DD-MM-YY'), TO_DATE('04-MAR-09', 'DD-MM-YY'), 3);
INSERT INTO DETAILRENTAL VALUES('1003', '54325', 3.5, TO_DATE('04-MAR-09', 'DD-MM-YY'), TO_DATE('09-MAR-09', 'DD-MM-YY'), 3);
INSERT INTO DETAILRENTAL VALUES('1003', '34367', 2, TO_DATE('06-MAR-09', 'DD-MM-YY'), TO_DATE('09-MAR-09', 'DD-MM-YY'), 1);
INSERT INTO DETAILRENTAL VALUES('1003', '44392', 0, TO_DATE('06-MAR-09', 'DD-MM-YY'), TO_DATE('09-MAR-09', 'DD-MM-YY'), 1);
--INSERT INTO DETAILRENTAL VALUES('1004', '44392', 3.5, TO_DATE('05-MAR-09', 'DD-MM-YY'), TO_DATE('07-MAR-09', 'DD-MM-YY'), 3);
--INSERT INTO DETAILRENTAL VALUES('1004', '34367', 3.5, TO_DATE('05-MAR-09', 'DD-MM-YY'), TO_DATE('07-MAR-09', 'DD-MM-YY'), 3);
--INSERT INTO DETAILRENTAL VALUES('1004', '34341', 2, TO_DATE('07-MAR-09', 'DD-MM-YY'), TO_DATE('07-MAR-09', 'DD-MM-YY'), 1);
--INSERT INTO DETAILRENTAL VALUES('1005', '34342', 2, TO_DATE('07-MAR-09', 'DD-MM-YY'), TO_DATE('05-MAR-09', 'DD-MM-YY'), 1);
--INSERT INTO DETAILRENTAL VALUES('1005', '34366', 3.5, TO_DATE('05-MAR-09', 'DD-MM-YY'), TO_DATE('05-MAR-09', 'DD-MM-YY'), 3);

ALTER TABLE DETAILRENTAL
ADD DETAIL_DAYS_LATE NUMBER;
-----------------------------------------------------------------------------------------------------------------------------------------
SET SERVEROUTPUT ON;

ALTER TABLE VIDEO 
    ADD VIDEO_STATUS VARCHAR(4) DEFAULT 'IN'
    CONSTRAINT VIDEO_VID_STATUS_CK CHECK (VIDEO_STATUS IN ('IN', 'OUT', 'LOST'));

    
select table_name from user_tables;

select * from detailrental;
select * from membership;
select * from movie;
select * from price;
select * from rental;
select * from video;

CREATE OR REPLACE TRIGGER TRG_DETAILRENTAL_DAYSLATE 
BEFORE UPDATE OF DETAIL_RETURNDATE, DETAIL_DUEDATE ON DETAILRENTAL 
FOR EACH ROW  
    BEGIN 
        IF (:NEW.DETAIL_RETURNDATE IS NULL) THEN 
            :NEW.DETAIL_DAYS_LATE := NULL; 
        ELSIF (:NEW.DETAIL_RETURNDATE > :NEW.DETAIL_DUEDATE) THEN 
            :NEW.DETAIL_DAYS_LATE := (:NEW.DETAIL_RETURNDATE - :NEW.DETAIL_DUEDATE); 
        ELSE 
            :NEW.DETAIL_DAYS_LATE := 0; 
        END IF; 
    END;
/

--testing first if in trigger
UPDATE DETAILRENTAL 
    SET DETAIL_RETURNDATE = NULL 
    WHERE VID_NUM = '44392';

--testing second if in trigger
UPDATE DETAILRENTAL 
    SET DETAIL_RETURNDATE = DETAIL_DUEDATE + 7 
    WHERE VID_NUM = '44392';

--testing else in trigger
UPDATE DETAILRENTAL 
    SET DETAIL_RETURNDATE = DETAIL_DUEDATE 
    WHERE VID_NUM = '44392';

drop trigger trig_membership_balance;
DROP TRIGGER TRG_DETAILRENTAL_DAYSLATE;

--second question
CREATE OR REPLACE TRIGGER TRIG_MEMBERSHIP_BALANCE
AFTER UPDATE OF DETAIL_RETURNDATE, DETAIL_DUEDATE ON DETAILRENTAL 
FOR EACH ROW
    DECLARE  
        LATEFEE_OLD NUMBER; 
        LATEFEE_NEW NUMBER;
        LATEFEE NUMBER;
    BEGIN 
        LATEFEE_OLD := :OLD.DETAIL_DAYS_LATE * :OLD.DETAIL_DAILYLATEFEE;
        LATEFEE_NEW := :NEW.DETAIL_DAYS_LATE * :NEW.DETAIL_DAILYLATEFEE;
        
        IF LATEFEE_OLD IS NULL THEN
            LATEFEE_OLD := 0;
        END IF;
        
        IF LATEFEE_NEW IS NULL THEN
            LATEFEE_NEW := 0;
        END IF;
        
        LATEFEE := LATEFEE_NEW - LATEFEE_OLD;
        
        IF LATEFEE > 0 THEN
            UPDATE MEMBERSHIP
                SET MEM_BALANCE = MEM_BALANCE + LATEFEE
                WHERE MEM_NUM = (SELECT MEM_NUM FROM RENTAL WHERE RENT_NUM = :NEW.RENT_NUM);
        END IF;
    END;
/
 

--stored procedure 1
CREATE OR REPLACE PROCEDURE PRC_RENTAL_ADD (MEMB_NUM IN CHAR)
AS
    MEM_COUNT NUMBER;
    OLD_BALANCE NUMBER;
    TODAY_DATE DATE;
    RENTAL_NUM RENTAL.RENT_NUM%TYPE;
    
    BEGIN
        SELECT COUNT(MEM_NUM) INTO MEM_COUNT FROM MEMBERSHIP WHERE MEM_NUM = MEMB_NUM;
        SELECT TO_DATE(SYSDATE, 'DD-MM-YY') INTO TODAY_DATE FROM DUAL;
        SELECT MAX(RENT_NUM) + 1 INTO RENTAL_NUM FROM RENTAL;
        
        IF MEM_COUNT > 0 THEN
            SELECT MEM_BALANCE INTO OLD_BALANCE FROM MEMBERSHIP WHERE MEM_NUM = MEMB_NUM;
            INSERT INTO RENTAL VALUES (RENTAL_NUM, TODAY_DATE, MEMB_NUM);
            DBMS_OUTPUT.PUT_LINE('Previous balance: $' || OLD_BALANCE || '.00.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Member with number ' || MEMB_NUM || ' does not exist.');
        END IF;
END;

--testing procedure

--testing if (mem_num exists)
EXEC PRC_RENTAL_ADD ('105');

--testing else (mem_num doesn't exist)
EXEC PRC_RENTAL_ADD('505');


--stored procedure 2 
CREATE OR REPLACE PROCEDURE PRC_VIDEO_RETURN (VIDEO_NUM IN CHAR)
AS
    VID_COUNT NUMBER;
    RENTDETAILS_COUNT NUMBER;
    RENTDETAILSNN_COUNT NUMBER;
    TODAY_DATE DATE;

    BEGIN
        SELECT COUNT(VID_NUM) INTO VID_COUNT FROM VIDEO WHERE VID_NUM = VIDEO_NUM;
        SELECT COUNT(VID_NUM) INTO RENTDETAILS_COUNT FROM DETAILRENTAL WHERE VID_NUM = VIDEO_NUM AND DETAIL_RETURNDATE IS NULL;
        SELECT COUNT(VID_NUM) INTO RENTDETAILSNN_COUNT FROM DETAILRENTAL WHERE VID_NUM = VIDEO_NUM AND DETAIL_RETURNDATE IS NOT NULL;
        SELECT TO_DATE(SYSDATE, 'DD-MM-YY') INTO TODAY_DATE FROM DUAL;

        IF VID_COUNT > 0 AND RENTDETAILS_COUNT = 1 THEN
            UPDATE DETAILRENTAL
            SET DETAIL_RETURNDATE = TODAY_DATE
            WHERE VID_NUM = VIDEO_NUM;
            
            UPDATE VIDEO
            SET VIDEO_STATUS = 'IN'
            WHERE VID_NUM = VIDEO_NUM;
            
            DBMS_OUTPUT.PUT_LINE('Video with number ' || VIDEO_NUM || ' was successfully returned.');
            
        ELSIF VID_COUNT > 0 AND RENTDETAILS_COUNT > 1 THEN
            DBMS_OUTPUT.PUT_LINE('Video with number ' || VIDEO_NUM || ' has multiple outstanding rentals.');
            
        ELSIF VID_COUNT > 0 AND RENTDETAILSNN_COUNT >= 1 THEN
            UPDATE VIDEO
            SET VIDEO_STATUS = 'IN'
            WHERE VID_NUM = VIDEO_NUM;
            DBMS_OUTPUT.PUT_LINE('Video with number ' || VIDEO_NUM || ' has no outstanding rentals and is now available for rental.');

        ELSE
            DBMS_OUTPUT.PUT_LINE('Video with number ' || VIDEO_NUM || ' does not exist.');
        END IF;
END;
 
--testing stored procedure 2

--testing first if
UPDATE DETAILRENTAL 
    SET DETAIL_RETURNDATE = NULL 
    WHERE VID_NUM = '34342';
    
EXEC PRC_VIDEO_RETURN('34342');

--testing second if
UPDATE DETAILRENTAL 
    SET DETAIL_RETURNDATE = NULL 
    WHERE VID_NUM = '44392';
    
EXEC PRC_VIDEO_RETURN('44392');

--testing third if
UPDATE DETAILRENTAL 
    SET DETAIL_RETURNDATE = DETAIL_DUEDATE 
    WHERE VID_NUM = '44392';
    
EXEC PRC_VIDEO_RETURN('44392');

--testing else
EXEC PRC_VIDEO_RETURN('11234');
 
 
 
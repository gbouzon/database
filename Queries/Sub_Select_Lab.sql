-- Display all the staff who earn more than satffno SG14 Salary.
SELECT STAFFNO, FNAME,LNAME,SALARY
FROM STAFF
WHERE SALARY > 
              ( SELECT SALARY
                FROM STAFF
                WHERE STAFFNO = 'SG14');
-- List staff who work in branch at ‘163 Main St’ street.

SELECT STAFFNO, FNAME, LNAME, BRANCHNO
FROM STAFF
WHERE BRANCHNO = 
                (SELECT BRANCHNO 
                 FROM BRANCH
                 WHERE STREET = '163 Main St');
                
--Display staff whose POSITION is the same as that of 
--employee SG14 and whose salary is greater than that of employee SL41.

SELECT *
FROM STAFF
WHERE POSITION = 
                ( SELECT POSITION
                  FROM STAFF
                  WHERE STAFFNO = 'SG14')
AND    SALARY > 
                ( SELECT SALARY
                  FROM STAFF
                  WHERE STAFFNO ='SL41');

--Display the Staff name and salary of all Staff whose salary is 
-- equal to the minimum salary.

SELECT FNAME,LNAME, SALARY
FROM STAFF
WHERE SALARY = 
                (SELECT MIN(SALARY)
                 FROM STAFF);
                 
--List properties handled by staff at ‘163 Main St’.

SELECT PROPERTYNO, STAFFNO, BRANCHNO
FROM propertyforrent
WHERE STAFFNO IN
             (SELECT STAFFNO
              FROM STAFF
              WHERE BRANCHNO = 
                               (SELECT BRANCHNO
                                 FROM BRANCH
                                 WHERE STREET = '163 Main St'));
                                 
                                 
-- Find	staff whose	salary is larger than
-- salary of at  least one member of staff at branch B003.
SELECT FNAME, LNAME, SALARY
FROM STAFF
WHERE SALARY < ANY   
            (SELECT SALARY
             FROM STAFF
             WHERE BRANCHNO = 'B003');
             
--Find	staff whose	salary is larger than	
-- salary of every member of staff at branch B003.

SELECT FNAME, LNAME, SALARY
FROM STAFF
WHERE SALARY = ALL    
            (SELECT SALARY
             FROM STAFF
             WHERE BRANCHNO = 'B003');

-- Create a table by using a nested SELECT query. 

CREATE TABLE STAFF_2
AS
SELECT STAFFNO, FNAME,LNAME
FROM STAFF;

SELECT * FROM STAFF_2;
INSERT INTO STAFF_2 (FNAME, LNAME)
SELECT  FNAME, LNAME
FROM STAFF;

UPDATE STAFF_2
SET STAFFNO = '100'
WHERE STAFFNO =
                (SELECT STAFFNO
                FROM STAFF
                WHERE STAFFNO = 'SG14');

                
                
                
                
                






SELECT TABLE_NAME FROM USER_TABLES;

--USING AGGREGATE FUNCTIONS. WILL NOT WORK IF YOU TRY TO ADD COLUMNS
SELECT COUNT(STAFFNO) AS "NUMBER OF STAFF" FROM STAFF;

--IT'S POSSIBLE TO ADD AS MANY AGGREGATE FUNCTIONS IN ONE STATEMENT AS YOU WISH. HOWEVER, NO COLUMNS.
SELECT MAX(SALARY), MIN(SALARY), SUM(SALARY), AVG(SALARY), COUNT(SALARY) FROM STAFF;

--All aggregate functions ignore null values except for count(*). Example:

SELECT * FROM VIEWING; --displays 5 comment values (2 of them being null)

SELECT COUNT(VCOMMENT) FROM VIEWING; --only counts 3 (null values are *not* counted)

SELECT COUNT(*) FROM VIEWING; --if we use count(*), everything is counted including null values.



--1. How many properties cost more than 350 per month to rent?

SELECT * FROM PROPERTYFORRENT; --first we check what we have in our propertyforrent table

SELECT COUNT(PROPERTYNO) FROM PROPERTYFORRENT WHERE RENT > 350; --then we select the attribute we need. In this case, we use the propertyno to count the properties.


-- 2. How many different properties viewed in May '15?

SELECT * FROM VIEWING; --first we check what we have in our viewing table to choose the needed attribute.

SELECT COUNT(PROPERTYNO) FROM VIEWING WHERE VIEWDATE LIKE '15-05%'; --one way of doing it

SELECT COUNT(PROPERTYNO) FROM VIEWING WHERE VIEWDATE BETWEEN '01-05-15' AND '31-05-15'; --another way of doing it using BETWEEN


-- 3. Find number of Managers and sum of their salaries.

SELECT COUNT(STAFFNO), SUM(SALARY) FROM STAFF WHERE POSITION = 'Manager'; --count counts the number of managers and sum takes a sum of their salaries.


--------------IMPLEMENTING GROUP BY----------------------

-- 4. Find number of staff in each branch and their total salaries
--use group by when you want to get a subtotal (divided by categories instead of the whole table)

SELECT * FROM STAFF; --checking table first

--selecting branchno, counting staffno in each branch and taking the sum of the salaries of the staff in each branch, all the while grouping by branch no.
SELECT BRANCHNO, COUNT(STAFFNO), SUM(SALARY) FROM STAFF GROUP BY BRANCHNO ORDER BY BRANCHNO;

-- 5. Find the number of properties that each owner owns (propertyforrrent table)

SELECT OWNERNO, COUNT(PROPERTYNO) FROM PROPERTYFORRENT GROUP BY OWNERNO; --counting the nb of properties that each owner has.


-----------------IMPLEMENTING HAVING---------------------------

--HAVING filters groups and WHERE groups individuals. In HAVING, we can use ALL aggregate functions whilst w WHERE we cannot.

--showing only owners that own more than one property, as opposed to previous statement (question 5)
SELECT OWNERNO, COUNT(PROPERTYNO) FROM PROPERTYFORRENT GROUP BY OWNERNO HAVING COUNT(PROPERTYNO) > 1;




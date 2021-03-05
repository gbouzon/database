SELECT TABLE_NAME FROM USER_TABLES; --CHECKING EXISTING TABLES

SELECT *
FROM privateowner WHERE FNAME = 'Tina'; --if we want to search for tina specifically

SELECT * FROM privateowner WHERE FNAME LIKE 'T%'; --searching for situations where fname's first letter is 't' (use %)

SELECT * FROM privateowner WHERE ADDRESS LIKE '%Glasgow%'; --searching for something that has the word glasgow in it

-- If % is before a letter it means disregard whatever comes before, and so on and so forth

-- % used to represent 0 or more characters, for when we don't know the exact value of an attribute, check ^^

SELECT * FROM privateowner WHERE FNAME LIKE '____'; --here, the 4 underscores means we're looking for fnames having 4 characters

--UNDERSCORE (_) represents one position/character 

SELECT * FROM privateowner WHERE fname LIKE '____%'; --here, 4 _ + % means 4 or more characters

SELECT * FROM VIEWING; --shows null values

SELECT * FROM VIEWING WHERE VCOMMENT IS NULL; --shows only record where vcomment is null

SELECT * FROM VIEWING WHERE VCOMMENT IS NOT NULL; --shows only records where vcomment is not null

SELECT * FROM STAFF ORDER BY FNAME; --orders by ascending order, alphabetical order

SELECT * FROM STAFF ORDER BY FNAME DESC; --orders by descending order, n-1;

SELECT * FROM STAFF ORDER BY SALARY; --orders results by salary (default: ascending order)

--------RELATIONAL ALGEBRA STUFF------------

-- Dad indentation similar to programming, kinda weird if you ask me but whatever                             
SELECT
    CITY
FROM
    BRANCH
UNION
    SELECT
        CITY
    FROM
        propertyforrent;

--union compatible, selects all cities in branch table and propertyforrent table
SELECT CITY FROM BRANCH UNION SELECT CITY FROM propertyforrent; 

--THIS DOESN'T WORK BECAUSE BOTH TUPLES MUST BE UNION COMPATIBLE, NB OF COLUMNS AND DATATYPE HAVE TO BE EQUAL
SELECT CITY, BRANCHNO FROM BRANCH UNION SELECT CITY FROM propertyforrent; 

--selects all cities that exist in both the branch table and the propertyforrent table, acts similar to 'intersects'
SELECT DISTINCT b.city FROM branch b, propertyforrent p WHERE b.branchno = p.branchno

--same as above
SELECT CITY FROM BRANCH INTERSECT SELECT CITY FROM propertyforrent; 

--compares cities in branch (first table) and cities in propertyforrent (second table) and only selects what *isn't* in the second specified table
SELECT CITY FROM BRANCH MINUS SELECT CITY FROM propertyforrent; 

--same as inner join
SELECT * FROM client NATURAL JOIN VIEWING; 

--selects only data that exists in both tables
SELECT * FROM client c INNER JOIN VIEWING v ON c.CLIENTNO = v.CLIENTNO; 

--clients table multiplied by the viewing table, selects all possible combinations from both
SELECT * FROM client CROSS JOIN VIEWING; 

--connecting two different tables
SELECT * FROM client, VIEWING WHERE CLIENT.CLIENTNO = viewing.CLIENTNO; 



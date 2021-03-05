
SELECT * FROM STAFF WHERE FNAME = 'David'; 

--the data is case sensitive, so it will not find DAVID
SELECT * FROM STAFF WHERE FNAME = 'DAVID'; 

--however, we can use an aggregate function to get a value
SELECT * FROM STAFF WHERE UPPER(FNAME) = 'DAVID';

--we can try using the LOWER aggregate function, but it will only work if the data inside the '' is actually in lowercase
SELECT * FROM STAFF WHERE LOWER(FNAME) = 'DAVID';

--aggregate functions such as upper,lower and initcap are use for formatting the data ''.
--But they only work if the data inside the '' matches the formatting of the function.
--Ex: UPPER function would require data to be in uppercase, etc.
--what these functions do: convert all names that have 'David' in it to uppercase then search for it.
--why we need this? we don't always know if the customer entered 'david' or 'DAVID' or 'David', so this finds it all
SELECT * FROM STAFF WHERE INITCAP(FNAME) = 'David';

-- we will not find anything here because none of them are MANAGER (case sensitive) but Manager.
SELECT * FROM STAFF WHERE POSITION = 'MANAGER';

-- this is what we'd do to find all managers when we don't know what the specific format is:
SELECT * FROM STAFF WHERE UPPER(POSITION) = 'MANAGER';


-- TO_CHAR (date_value, fmt)
-- List all staff born in 1980

--to_char extracts the specified part from the data. In this case, we're extracting the year
--where the year is 1980
SELECT FNAME, LNAME, DOB, TO_CHAR(DOB, 'YYYY') FROM STAFF WHERE TO_CHAR(DOB, 'YYYY') = '1980';

--List all staff born in june
SELECT FNAME, LNAME, DOB, TO_CHAR(DOB, 'MM') FROM STAFF WHERE TO_CHAR(DOB, 'MM') = '06';

--if we were to take off the DOB from the SELECT statement, it would only return the month not the whole dob
SELECT FNAME, LNAME, TO_CHAR(DOB, 'MM') FROM STAFF WHERE TO_CHAR(DOB, 'MM') = '06';

--if we were to take off the to_char from the SELECT statement, it would not return the only the month of birth 
--the other one returns an extra column
SELECT FNAME, LNAME, DOB FROM STAFF WHERE TO_CHAR(DOB, 'MM') = '06';

-- ROUND functions rounds a double to the specified number of decimal points
--in this case, we want to round it to 2 decimal points (refer to second argument)
SELECT ROUND(23.456, 2) FROM DUAL;

--DUAL table used above is owned by SYS and it's useful to test out functions to see how they work/ what the output is.

SELECT SYSDATE FROM DUAL; --returns today's date.

--ADD_MONTHS function returns the date *this* many months from the date entered
--note: the *this* many months can be entered in the second argument
SELECT ADD_MONTHS('05-FEB-21', 3) FROM DUAL;









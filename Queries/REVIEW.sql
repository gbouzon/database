--when you open a new script, remember to click the refresh button on the left
--so that the tables appear under the tables tab of the connection

--TESTING TABLES
SELECT * FROM HOTEL;
SELECT * FROM ROOM;
SELECT * FROM GUEST;
SELECT * FROM BOOKING;

-- 1. List full details of all hotels in London.
SELECT * FROM HOTEL WHERE UPPER(CITY) = 'LONDON';

-- 2. Find the highest list price of all rooms
SELECT MAX(PRICE) AS HIGHEST_PRICE FROM ROOM; --AS here sets the name of the column

-- 2.b Find the highest price of each type of room
SELECT RTYPE,MAX(PRICE) AS HIGHEST_PRICE FROM ROOM GROUP BY RTYPE;

-- 3. List the names and addresses of all guests in London, alphabetically ordered by name
-- order by 1 here refers to guestname
SELECT GUESTNAME, GUESTADDRESS FROM GUEST WHERE UPPER(GUESTADDRESS) LIKE '%LONDON%' ORDER BY 1;

-- 4. List all double or family rooms with price below 40 per night, in ascending order of price.
-- remember to add () to AND OR operations. 
SELECT RTYPE, PRICE FROM ROOM WHERE (UPPER(RTYPE) = 'DOUBLE' OR UPPER(RTYPE) = 'FAMILY') AND PRICE < 40 ORDER BY PRICE;

--better way of doing it without having AND OR errors:
--IN here is used for multiple values
SELECT RTYPE, PRICE FROM ROOM WHERE UPPER(RTPE) IN ('DOUBLE', 'FAMILY') AND PRICE < 40;

-- 5. List the bookings for which no dateTo has been specified
SELECT * FROM BOOKING WHERE DATETO IS NULL; -- IS NULL here is a condition not a value

-- 6. Find the guests whose name ends with the letter y.
SELECT GUESTNAME FROM GUEST WHERE UPPER(GUESTNAME) LIKE '%Y';

-- 7. Find the guests where the second character is the letter a.
SELECT GUESTNAME FROM GUEST WHERE UPPER(GUESTNAME) LIKE '_A%';

-- 8. What is the average price of each type of room
SELECT ROOMNO, AVG(PRICE) FROM ROOM GROUP BY ROOMNO ORDER BY AVG(PRICE);

-- 9. What is the total revenue per night from all double rooms
SELECT SUM(PRICE) FROM ROOM WHERE UPPER(RTYPE) = 'DOUBLE';

-- 10. List the number of rooms at each hotel.
SELECT HOTELNO, COUNT(ROOMNO) FROM ROOM GROUP BY HOTELNO;

-- 10B. Using the hotelname instead of hotelno
SELECT HOTELNAME, COUNT(ROOMNO) FROM ROOM NATURAL JOIN HOTEL GROUP BY HOTELNAME;













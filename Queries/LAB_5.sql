-- 1. Produce a relation that is containing all hotel names with a room price above 50
SELECT HOTELNAME, RTYPE, PRICE FROM HOTEL NATURAL JOIN ROOM WHERE PRICE > 50;

SELECT HOTELNAME, RTYPE, PRICE FROM HOTEL H JOIN ROOM R ON H.HOTELNO = R.HOTELNO WHERE PRICE > 50;

SELECT HOTELNAME, RTYPE, PRICE FROM HOTEL H, ROOM R WHERE H.HOTELNO = R.HOTELNO AND PRICE > 50;

-- 2. List the names and addressed of all guests in London alphabetically ordered by name

SELECT GUESTNAME, GUESTADDRESS, CITY 
FROM GUEST NATURAL JOIN BOOKING NATURAL JOIN HOTEL 
WHERE UPPER(CITY) LIKE '%LONDON%'
ORDER BY GUESTNAME ASC;

--3. List the price and type of all rooms at the grosvenor hotel

SELECT RTYPE, PRICE FROM ROOM NATURAL JOIN HOTEL WHERE UPPER(HOTELNAME) = 'GROSVENOR';

--4. List the names of guests who are currently staying at the grosvenor hotel

SELECT GUESTNAME, DATEFROM, DATETO 
FROM GUEST NATURAL JOIN BOOKING NATURAL JOIN HOTEL 
WHERE UPPER(HOTELNAME) = 'GROSVENOR' 
AND DATEFROM >= SYSDATE AND DATETO <= SYSDATE;

--5. What is the number of bookings for each hotel in may?
-- HAVING filters the groups whilst WHERE filters the whole table
SELECT HOTELNO, COUNT(*) 
FROM BOOKING 
WHERE TO_CHAR(DATEFROM, 'MM') = 05 AND TO_CHAR(DATETO, 'MM') = 05
GROUP BY HOTELNO;

--6. How many different guests have made bookings for August?
SELECT GUESTNO, COUNT(DISTINCT GUESTNO) 
FROM BOOKING
WHERE TO_CHAR(DATEFROM, 'MM') = 08 AND TO_CHAR(DATETO, 'MM') = 08
GROUP BY GUESTNO;

--7.  What is the total income from bookings for the Grosvenor hotel today?
SELECT HOTELNO, SUM(PRICE) 
FROM ROOM NATURAL JOIN BOOKING NATURAL JOIN HOTEL
WHERE UPPER(HOTELNAME) = 'GROSVENOR' 
AND DATEFROM >= SYSDATE AND DATETO <= SYSDATE
GROUP BY HOTELNO; 

--8. List all guests and show the details of any bookings they have beyond 1-jan-2002

select * from guest natural join booking where datefrom >= '01/01/2002'

--9. List all double or family rooms with a price below 40 per night
-- that are booked to john kay in desc order of price

SELECT RTYPE, PRICE, GUESTNAME 
FROM ROOM NATURAL JOIN BOOKING NATURAL JOIN GUEST
WHERE UPPER(RTYPE) IN ('DOUBLE', 'FAMILY') 
AND PRICE < 40
AND UPPER(GUESTNAME) = 'JOHN KAY'
ORDER BY PRICE DESC;

--10. List the rooms that are currently occupied at the Grosvenor

SELECT * 
FROM ROOM NATURAL JOIN HOTEL NATURAL JOIN BOOKING 
WHERE UPPER(HOTELNAME) = 'GROSVENOR' AND DATEFROM >= SYSDATE AND DATETO <= SYSDATE; 

-- to format date:
ALTER SESSION SET NLS_DATE_FORMAT = 'MM/DD/YYYY';




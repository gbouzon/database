Begin
for c in (select table_name from user_tables) loop
execute immediate ('drop table '||c.table_name||' cascade constraints');
end loop;
End; 
/

CREATE TABLE hotel ( 
hotelno CHAR(4) PRIMARY KEY, 
hotelname VARCHAR(20) NOT NULL, 
city VARCHAR(20) NOT NULL 
);

CREATE TABLE room (
roomno char(4),
hotelno char(4),
rtype varchar(10),
price number (5,2),
primary key (roomno, hotelno),
foreign key (hotelno) REFERENCES hotel(hotelno)
);

CREATE TABLE guest ( 
guestno CHAR(5) PRIMARY KEY, 
guestname VARCHAR(20) NOT NULL, 
guestaddress VARCHAR(50) NOT NULL 
); 

CREATE TABLE booking (
hotelno char(4),
guestno char(5),
datefrom date,
dateto date,
roomno char(4),
primary key (hotelno, guestno, datefrom),
foreign key (hotelno) REFERENCES hotel(hotelno),
foreign key (guestno) REFERENCES guest(guestno),
foreign key (roomno, hotelno) REFERENCES room(roomno,hotelno)
);

insert into hotel values('fb01', 'Grosvenor', 'London');
insert into hotel values('fb02', 'Watergate', 'Paris');
insert into hotel values('ch01', 'Omni Shoreham', 'London');
insert into hotel values('ch02', 'Phoenix Park', 'London');
insert into hotel values('dc01', 'Latham', 'Berlin');

insert into room values('501', 'fb01', 'single', 19);
insert into room values('601', 'fb01', 'double', 29);
insert into room values('701', 'fb01', 'family', 39);
insert into room values('1001', 'fb02', 'single', 58);
insert into room values('1101', 'fb02', 'double', 86);
insert into room values('1001', 'ch01', 'single', 29.99);
insert into room values('1101', 'ch01', 'family', 59.99);
insert into room values('701', 'ch02', 'single', 10);
insert into room values('801', 'ch02', 'double', 15);
insert into room values('901', 'dc01', 'single', 18);
insert into room values('1001', 'dc01', 'double', 30);
insert into room values('1101', 'dc01', 'family', 35);

insert into guest values('10001', 'John Kay', '56 High St, London');
insert into guest values('10002', 'Mike Ritchie', '18 Tain St, London');
insert into guest values('10003', 'Mary Tregear', '5 Tarbot Rd, Aberdeen');
insert into guest values('10004', 'Joe Keogh', '2 Fergus Dr, Aberdeen');
insert into guest values('10005', 'Carol Farrel', '6 Achray St, Glasgow');
insert into guest values('10006', 'Tina Murphy', '63 Well St, Glasgow');
insert into guest values('10007', 'Tony Shaw', '12 Park Pl, Glasgow');

insert into booking values('fb01', '10001', To_date('04-04-01', 'YY-MM-DD'), DATE '04-04-08', '501');
insert into booking values('fb01', '10004', To_date ('04-04-15' , 'YY-MM-DD'), DATE'04-05-15', '601');
insert into booking values('fb01', '10005', To_date('04-05-02',  'YY-MM-DD'), DATE'04-05-07', '501');
insert into booking values('fb01', '10002',DATE '16-05-04',DATE '04-05-29', '601');
insert into booking values('fb01', '10001', DATE'04-05-01', null, '701');
insert into booking values('fb02', '10003', DATE'04-04-05', DATE'10-04-04', '1001');
insert into booking values('fb02', '10005', DATE'04-05-12', DATE'30-05-04', '1101');
insert into booking values('ch01', '10006',DATE '04-04-21', null, '1101');
insert into booking values('ch02', '10002', DATE'04-04-25',DATE '04-05-06', '801');
insert into booking values('dc01', '10007', DATE'04-05-13',DATE '04-05-15', '1001');
insert into booking values('dc01', '10003',DATE '04-05-20', null, '1001');



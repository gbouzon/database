
Begin
for c in (select table_name from user_tables) loop
execute immediate ('drop table '||c.table_name||' cascade constraints');
end loop;
End; 
/

CREATE TABLE branch (
  branchNo char(5) CONSTRAINT BRANCH_BRANCHNO_PK PRIMARY KEY,
  street varchar(35),
  city varchar(10),
  postcode varchar(10),
);

INSERT INTO branch VALUES('B005','22 Deer Rd','London','SW1 4EH');
INSERT INTO branch VALUES('B007','16 Argyll St', 'Aberdeen','AB2 3SU');
INSERT INTO branch VALUES('B003','163 Main St', 'Glasgow','G11 9QX');
INSERT INTO branch VALUES('B004','32 Manse Rd', 'Bristol','BS99 1NZ');
INSERT INTO branch VALUES('B002','56 Clover Dr', 'London','NW10 6EU');


CREATE TABLE staff (
  staffNo char(5) PRIMARY KEY,
  fName varchar(10) NOT NULL,
  lName varchar(10) NOT NULL,
  position varchar(10),
  sex char(1),
  DOB date,
  salary int,
  branchNo char(5),
  FOREIGN KEY (branchNo) REFERENCES Branch(branchNo)
);

INSERT INTO staff VALUES('SL21','John','White','Manager','M',to_date('1965-10-01', 'YYYY-MM-DD'),30000,'B005');
INSERT INTO staff VALUES('SG37','Ann','Beech','Assistant','F',to_date('1980-11-10', 'YYYY-MM-DD'),12000,'B003');
INSERT INTO staff VALUES('SG14','David','Ford','Supervisor','M',to_date('1978-03-24', 'YYYY-MM-DD'),18000,'B003');
INSERT INTO staff VALUES('SA9','Mary','Howe','Assistant','F',to_date('1990-02-19', 'YYYY-MM-DD'),9000,'B007');
INSERT INTO staff VALUES('SG5','Susan','Brand','Manager','F',to_date('1960-06-03', 'YYYY-MM-DD'),24000,'B003');
INSERT INTO staff VALUES('SL41','Julie','Lee','Assistant','F',to_date('1985-06-13', 'YYYY-MM-DD'),9000,'B005');

CREATE TABLE privateOwner (
  ownerNo char(5) PRIMARY KEY,
  fName varchar(10) NOT NULL,
  lName varchar(10) NOT NULL,
  address varchar(50),
  telNo char(15),
  email varchar(50),
  password varchar(40)
);

INSERT INTO privateOwner VALUES('CO46','Joe','Keogh','2 Fergus Dr. Aberdeen AB2 ','01224-861212', 'jkeogh@lhh.com', null);
INSERT INTO privateOwner VALUES('CO87','Carol','Farrel','6 Achray St. Glasgow G32 9DX','0141-357-7419', 'cfarrel@gmail.com', null);
INSERT INTO privateOwner VALUES('CO40','Tina','Murphy','63 Well St. Glasgow G42','0141-943-1728', 'tinam@hotmail.com', null);
INSERT INTO privateOwner VALUES('CO93','Tony','Shaw','12 Park Pl. Glasgow G4 0QR','0141-225-7025', 'tony.shaw@ark.com', null);

CREATE TABLE propertyForRent (
  propertyNo char(5) PRIMARY KEY,
  street varchar(35) NOT NULL,
  city varchar(10) NOT NULL,
  postcode varchar(10),
  type varchar(10) NOT NULL,
  rooms smallint NOT NULL,
  rent int NOT NULL,
  ownerNo char(5) not null,
  staffNo char(5),
  branchNo char(5),
  FOREIGN KEY (ownerNo) REFERENCES privateOwner,
  FOREIGN KEY (staffNo) REFERENCES Staff,
  FOREIGN KEY (branchNo) REFERENCES Branch
);

INSERT INTO propertyForRent VALUES('PA14','16 Holhead','Aberdeen','AB7 5SU','House',6,650,'CO46','SA9','B007');
INSERT INTO propertyForRent VALUES('PL94','6 Argyll St','London','NW2','Flat',4,400,'CO87','SL41','B005' );
INSERT INTO propertyForRent VALUES('PG4','6 Lawrence St','Glasgow','G11 9QX','Flat',3,350,'CO40', NULL, 'B003');
INSERT INTO propertyForRent VALUES('PG36','2 Manor Rd','Glasgow','G32 4QX','Flat',3,375,'CO93','SG37','B003' );
INSERT INTO propertyForRent VALUES('PG21','18 Dale Rd','Glasgow','G12','House',5,600,'CO87','SG37','B003');
INSERT INTO propertyForRent VALUES('PG16','5 Novar Dr','Glasgow','G12 9AX','Flat',4,450,'CO93','SG14','B003' );

CREATE TABLE client (
  clientNo char(5) PRIMARY KEY,
  fName varchar(10),
  lName varchar(10),
  telNo char(15),
  prefType varchar(10),
  maxRent int,
  email varchar(50)
);

INSERT INTO client VALUES('CR76','John','Kay','0171-774-5632','Flat',425, 'john.kay@gmail.com');
INSERT INTO client VALUES('CR56','Aline','Steward','0141-848-1825','Flat',350, 'astewart@hotmail.com');
INSERT INTO client VALUES('CR74','Mike','Ritchie','01475-943-1728','House',750, 'mritchie@yahoo.co.uk');
INSERT INTO client VALUES('CR62','Mary','Tregear','01224-196720','Flat',600, 'maryt@hotmail.co.uk');

CREATE TABLE  viewing (
  clientNo char(5) not null,
  propertyNo char(5) not null,
  viewDate date,
  vcomment varchar(15)
);

INSERT INTO viewing VALUES('CR56','PA14',to_date('2015-05-24','YYYY-MM-DD'),'too small');
INSERT INTO viewing VALUES('CR76','PG4',to_date('2015-04-20','YYYY-MM-DD'),'too remote');
INSERT INTO viewing VALUES('CR56','PG4', to_date('2015-05-26','YYYY-MM-DD'),'');
INSERT INTO viewing VALUES('CR62','PA14',to_date('2015-05-14','YYYY-MM-DD'),'no dining room');
INSERT INTO viewing VALUES('CR56','PG36',to_date('2015-04-28','YYYY-MM-DD'),'');

CREATE TABLE registration (
  clientNo char(5) not null,
  branchNo char(5) not null,
  staffNo char(5) not null,
  dateJoined date
);

INSERT INTO registration VALUES('CR76','B005','SL41',to_date('2015-01-13','YYYY-MM-DD'));
INSERT INTO registration VALUES('CR56','B003','SG37',to_date('2014-04-13','YYYY-MM-DD'));
INSERT INTO registration VALUES('CR74','B003','SG37',to_date('2013-11-16','YYYY-MM-DD'));
INSERT INTO registration VALUES('CR62','B007','SA9',to_date('2014-03-07','YYYY-MM-DD'));
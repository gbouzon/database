SHOW USER; -- shows user

SELECT * FROM HR.EMPLOYEES;

CREATE USER STAFF_1 IDENTIFIED BY 1234; --username is NOT case sensitive 

GRANT CONNECT TO STAFF_1; --we're allowing them to log in

GRANT CREATE TABLE TO STAFF_1;

GRANT SELECT, INSERT, UPDATE ON HR.EMPLOYEES TO STAFF_1;

GRANT UPDATE(FIRST_NAME) ON HR.EMPLOYEES TO STAFF_1;

revoke insert, update on hr.employees from staff_1;

grant update(first_name) on hr.employees to staff_1;

revoke connect from staff_1;

create user manager identified by 123;
grant create session to manager;

show user;

-- BASICALLY what this does is it grants all of this to a specific table
--but we need to specify the owner of the table, which in the case of the 
-- author table is gbouzon.
grant insert, update on gbouzon.author to manager; --figure this shit out please GOT IT

create role managers;
create role allstaff;

grant create any table, alter any table, drop any table to managers;

grant select any table, update any table to allstaff;

grant managers to manager;
grant allstaff to staff_1;

select username from dba_users;

--so this means that staff_1 has been given the "privilege" to grant other users privileges
grant select, update on gbouzon.client to staff_1 with grant option;
-- grant option can only grant the SAME privileges

CREATE USER STAFF_2 IDENTIFIED BY 12345;
grant connect to staff_2;
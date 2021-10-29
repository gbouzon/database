-- 1. Create a view (view_dept_50) on the employees table in a database called HR to restrict 
-- access to only those rows where the department_id is 50. Execute a simple SELECT 
-- statement against the (view_dept_50) to return employees whose salaries below 9000.

CREATE VIEW VIEW_DEPT_50
AS SELECT * 
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID = 50;

SELECT * FROM VIEW_DEPT_50
WHERE SALARY < 9000;

-- 2. Replace the existing (view_dept_50) view and include WITH CHECK OPTION. The WITH 
-- CHECK OPTION in this case should deny the entry of any values in the view's department_id
-- column not equal to 50. Execute a simple update statement against the (view_dept_50) to 
-- update the department_id to the value of 30 of all employees’. Why are you not able to
-- update the department_id?

CREATE OR REPLACE VIEW VIEW_DEPT_50
AS SELECT *
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID = 50
WITH CHECK OPTION;

UPDATE VIEW_DEPT_50
SET DEPARTMENT_ID = 30; --won't work because it has check option

-- 3. Replace the existing (view_dept_50) view and include READ-ONLY OPTION. Execute a simple 
-- delete statement against the (view_dept_50). Why are you not able to delete rows from the view?

CREATE OR REPLACE VIEW VIEW_DEPT_50
AS SELECT *
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID = 50
WITH READ ONLY;

delete from view_dept_50;

-- 4. Create a view (emp_dep_view) that joins departments table with employees table based 
-- on the department_id column. The view includes the name and address of all employees who 
-- work for the ‘IT’ department along with the manag_id. Can you insert a new row through this
-- view? Why and why not?

CREATE OR REPLACE VIEW EMP_DEP_VIEW
AS SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, DEPARTMENT_NAME, MANAGER_ID
FROM HR.EMPLOYEES NATURAL JOIN HR.DEPARTMENTS
WHERE UPPER(DEPARTMENT_NAME) = 'IT';

INSERT INTO EMP_DEP_VIEW VALUES (888, 'NAGAT', 'DRAWEL', 'WERS@GMAIL', 'IT', 103);

-- 5. Write the DDL command to create new users named user_123 and user_456. Try to login 
-- with user_123 new account

CREATE USER USER_1864 IDENTIFIED BY 1234;
CREATE USER USER_1865 IDENTIFIED BY 1234;



-- 6. Why are you not able to login to the new account, and what you have to execute to fix this?
-- we can't because we did not grant the user access 

GRANT CREATE SESSION TO USER_1864;
GRANT CREATE SESSION TO USER_1865;

-- 7. Grant the user the ability to retrieve information from the employee table in a database 
-- called HR.

GRANT SELECT ON HR.EMPLOYEES TO USER_1864;

-- 8. user_123 can retrieve information from the employees' table. He will not, however, be able 
-- to grant other users permission to retrieve information from that table because the DCL 
-- script did not include the WITH GRANT OPTION clause. what you have to do to fix this?

grant select on hr.employees to user_1864 with grant option;

-- 9. Grant privileges on the views to specific users without having to grant those users access to 
-- the base tables.

REVOKE SELECT ON HR.EMPLOYEES FROM USER_1864;

GRANT SELECT ON VIEW_DEPT_50 TO USER_1864, USER_1865;
--when selecting in the command line, we must specify the owner which is SYS, so:
-- select * form sys.view_dept_50 because that is who the view belongs to.

-- 10. Grant multiple object privilege in a single grant statement. 

GRANT SELECT, UPDATE, INSERT ON VIEW_DEPT_50 TO USER_1864;

-- 11. Grant object privilege on column level, so user_123 and only update first_name column on 
-- (view_dept_50) view

GRANT UPDATE (FIRST_NAME)
ON VIEW_DEPT_50
TO USER_1864;

-- 12. Revokes the permission granted to user_123 in the previous example. Can user_123 
-- connect with his account

REVOKE UPDATE ON VIEW_DEPT_50
FROM USER_1864;

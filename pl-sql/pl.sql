SET SERVEROUTPUT ON;

select * from hr.employees;

begin
    insert into hr.employees 
    values (14867, 'nagat', 'drawel', 'email', '123456', '03-06-17', 'AC_ACCOUNT', 12345, null, null, 60);
    dbms_output.put_line ('NEW EMPLOYEE ADDED!');
end;
/

declare 
    in_employee_id hr.employees.employee_id%type := &employee_id;
    begin
        update hr.employees
        set salary = salary * 1.10
        where employee_id = in_employee_id;
        dbms_output.put_line ('Employee salary is updated!');
    end;
/

declare
    emp_count number;
    emp_department_id number := 90;
    begin
        select count(*) into emp_count
        from hr.employees
        where department_id = emp_department_id;
        dbms_output.put_line ('the employee count is ' || emp_count || ' for the department id ' || emp_department_id);
    end;
/

declare
    emp_count number;
    emp_department_id number := &department_id;
    begin
        select count(*) into emp_count
        from hr.employees
        where department_id = emp_department_id;
        
        IF EMP_COUNT > 40 THEN
            UPDATE HR.EMPLOYEES
            SET SALARY = SALARY + 100;
        ELSE
            UPDATE HR.EMPLOYEES
            SET SALARY = SALARY + 200;
        END IF;
        
        dbms_output.put_line ('The employee count is ' || emp_count || ' for the department id ' || emp_department_id);
        
    end;
/

declare
    emp_count number;
    emp_department_id number := &department_id;
    begin
        select count(*) into emp_count
        from hr.employees
        where department_id = emp_department_id;
        
        update hr.employees
        set salary = case
            when emp_count > 40
            then salary + 100
            else
            salary + 200
        end;
        
        dbms_output.put_line ('The employee count is ' || emp_count || ' for the department id ' || emp_department_id);
        
    end;
/
        
        
        
        
        
        
        
        
        
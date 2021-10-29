Begin
for c in (select table_name from user_tables) loop
execute immediate ('drop table '||c.table_name||' cascade constraints');
end loop;
End; 
/

CREATE VIEW MANAGER3STAFF
AS SELECT *
FROM gbouzon.author a
WHERE a.auth_id = '100000001';

select * from manager3staff;

create or replace view Staff3
as select staffno, fname, lname
from staff
where branchno = 'b003'
with read only;

select * from staff3;
insert into staff3 values ('na102', 'nagat', 'drawel', 'b007'); --won't work cuz the branch MUST be b003

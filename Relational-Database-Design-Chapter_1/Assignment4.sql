--                                                       SET A 

/*
Project-Employee database 
Consider the following database:
Project (pno int, pname char (30), ptype char (20), duration int) 
Employee (empno int, ename char (20), joining_date date)
The relationship between Project and Employee is many to many with descriptive attribute start_date.
Create the above database in PostGreSQL and insert sufficient records.
*/

-- create table Project(pno int primary key, pname char(30), ptype char (20), duration int); 
-- create table Employee(eno int primary key, ename char(20), jdate date);
-- create table Project_Employee(pno int references Project(pno), eno int references Employee(eno), sdate date);


-- insert into Project values(101, 'Password Cracker', 'Software', 30);
-- insert into Project values(102, 'Web Dev.', 'Software', 5);
-- insert into Project values(103, 'Compact CPU', 'Hardware', 50);

-- insert into Employee values(1, 'Vaibhav', '07/15/2027');
-- insert into Employee values(2, 'Sanket', '07/15/2028');
-- insert into Employee values(3, 'Sushant', '07/15/2029');

-- insert into Project_Employee values(101, 1, '07/15/2027');
-- insert into Project_Employee values(102, 2, '07/16/2028');
-- insert into Project_Employee values(103, 3, '07/20/2029');


-- a. Write a stored function to accept project name as input and print the names of employees 
-- working on the project. Also print the total number of employees working on that project. 
-- Raise an exception for an invalid project name.
-- b. Write a stored function to accept empno as an input parameter from the user and count the 
-- number of projects of a given employee. Raise an exception if the employee number is 
-- invalid.


-- a)
-- create or replace function printEmpInfo(name char(30)) returns text as
-- $$
-- declare 
-- txt text := '';
-- rec record;
-- cnt int := 0;
-- begin
-- for rec in select e.* from Employee e join Project_Employee pe on e.eno = pe.eno join Project p on pe.pno = p.pno where p.pname = name loop
-- txt := txt||rec.eno||' '||rec.ename||' '||rec.jdate||e'\n'; 
-- cnt := cnt + 1;
-- end loop;
-- if cnt = 0 then 
-- raise exception '% is Wrong Project Name', name;
-- end if;
-- txt := txt||e'\nCount of Employees = '||cnt;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select printEmpInfo('Password Cracker');


-- b)
-- create or replace function totalProject(n int) returns int as
-- $$
-- declare 
-- cnt int;
-- begin
-- select count(*) into cnt from Employee e join Project_Employee pe on e.eno = pe.eno where e.eno = n;
-- if cnt = 0 then
-- raise exception '% is Invalid ID', n;
-- end if;
-- return cnt;
-- end;
-- $$
-- language 'plpgsql';

-- select totalProject(1);



--                                                    Set B

/*
Person – Area database 
Person (pno int, name varchar (20), birthdate date, income money) 
Area (aid int, aname varchar (20), area_type varchar (5))
The person and area related to many to one relationship. The attribute ‘area_type’ can have values 
either ‘urban’ or ‘rural’.
Create the above database in PostGreSQL and insert sufficient records.
*/

-- create table Area(ano int primary key, aname varchar (20), atype varchar (5));
-- create table Person(pno int primary key, name varchar (20), bdate date, income money, ano int references Area(ano)); 


-- insert into Area values(101, 'Recidential', 'Urban');
-- insert into Area values(102, 'Recidential', 'Urban');
-- insert into Area values(103, 'Public', 'Rural');

-- insert into Person values(1, 'Vaibhav', '04/18/2006', '1000000', 101);
-- insert into Person values(2, 'Sanket', '09/21/2006', '500000', 102);
-- insert into Person values(3, 'Vaibhav', '11/29/2005', '40000', 103);


-- a. Write a stored function that accepts the area name as an input parameter from the user 
-- and displays the details of persons living in that area. Raise an exception if area name is 
-- invalid

-- create or replace function perDetails(area_name varchar(20)) returns text as
-- $$
-- declare
-- txt text := '';
-- rec record;
-- begin
-- for rec in select * from Person p join Area a on p.ano = a.ano where aname = area_name loop
-- txt := txt||rec.pno||' '||rec.name||' '||rec.bdate||' '||rec.atype||e'\n';
-- end loop;
-- if txt = '' then 
-- raise exception 'Invalid Area Name';
-- end if;
-- return txt;
-- end;
-- $$ 
-- language 'plpgsql';

-- select perDetails('Recidential');
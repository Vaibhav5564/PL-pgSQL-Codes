--                                                  Set A

/*
a. Write a procedure to display addition, subtraction and multiplication of three numbers.
b. Write a procedure to display division of two numbers use raise to display error messages.
c.Create table Department (dno, dname, empname, city ).
i) Write a procedure to insert values in Department table.
ii) Write a procedure to display all employees working in ‘Pune’ city.
*/

-- a)
-- create or replace procedure calc(a int, b int, c int) as
-- $$
-- begin
-- raise notice 'Addition = %',a+b+c;
-- raise notice 'Substraction = %',a-b-c;
-- raise notice 'Multiplication = %',a*b*c;
-- end;
-- $$
-- language 'plpgsql';

-- call calc(10, 20, 30);

-- b)
-- create or replace procedure divide(a int, b int) as
-- $$
-- begin
-- if b = 0 then
-- raise exception 'Divisor is Zero' using hint = '0 as Divisor is Not Allowed';
-- end if;
-- raise notice 'Division = %', a/b;
-- end;
-- $$
-- language 'plpgsql';

-- call divide(50, 0);


-- c) i
-- create table dept(dno int primary key, deptName varchar(20), empName varchar(20), city varchar(20));
-- insert into dept values(1, 'Comp', 'Mrs. Deepashree', 'Pune');
-- insert into dept values(2, 'Math', 'Mrs. Neha', 'Satara');
-- insert into dept values(3, 'Comp', 'Mr. Shailesh', 'Pune');
-- insert into dept values(4, 'Elect', 'Mrs. Snehal', 'Mumbai');

-- create or replace procedure insertValues(dno int, deptName varchar(20), empName varchar(20), city varchar(10)) as
-- $$
-- begin
-- insert into dept values(dno, deptName, empName, city);
-- end;
-- $$
-- language 'plpgsql';

-- call insertValues(5, 'Marathi', 'Mr. Dilip', 'Pimpri-Pune');

-- select * from dept;


-- c) ii
-- create or replace procedure empByCity(inputCity varchar(20)) as
-- $$
-- declare
-- emp_names dept%rowtype;
-- begin
-- for emp_names in select *  from dept where city = inputCity loop
-- if emp_names is NULL then
-- raise exception 'No belongs from this city - %', inputCity;
-- else
-- raise notice '%', emp_names.empName;
-- end if;
-- end loop;
-- end;
-- $$
-- language 'plpgsql';

-- call empByCity('Pune');



--                                                  Set B

/*
A) Consider the following relationship 
Route(route_no,source, destination, no_of_station) Bus 
(bus_no, capacity, depot_name)
Relationship between Route and Bus is one-to-many
a. Write a procedure which display all bus details for a given route.
b. Write a procedure to update source of route no 101

*/

-- A)
-- create table route(rno int primary key, source varchar(20), dest varchar(20), noOfStation int);
-- create table bus(bno int primary key, capacity int, depo varchar(20), rno int references route(rno) on update cascade on delete cascade);

-- insert into route values(101, 'Pune', 'Satara', 10);
-- insert into route values(102, 'Pimpri-Chinchwad', 'Satara', 8);
-- insert into route values(103, 'Phaltan', 'Lonand', 7);
-- insert into route values(104, 'Pune', 'Akola', 12);

-- insert into bus values(1, 40, 'Phaltan', 101);
-- insert into bus values(2, 60, 'Akola', 103);
-- insert into bus values(3, 50, 'Mumbai', 104);
-- insert into bus values(4, 20, 'Pune', 101);

-- create or replace procedure details(routeNo int) as
-- $$
-- declare
-- info bus%rowtype;
-- begin
-- raise notice '******Bus Details******';
-- for info in select * from bus where rno = routeNo loop
-- raise notice '%', info;
-- end loop;
-- end;
-- $$
-- language 'plpgsql';

-- call details(103);


-- create or replace procedure updateRoute101() as
-- $$
-- begin
-- raise notice '******Updated******';
-- update route set source = 'Mahabaleshwar' where rno = 101 ;
-- end;
-- $$
-- language 'plpgsql';

-- call updateRoute101();

-- select * from route;

/*
B) Consider the following relationship 
Patient (p_no, p_name, p_addr)
Doctor (d_no, d_name, d_addr, city)
Relationship between Patient and Doctor is many-to-many with descriptive attribute disease and 
no_of_visits.
a. Write a procedure which display patient detail who has visited more than 3 times to the 
given doctor for ‘Diabetes’.
b. Write a procedure which displays total number of visits of Dr.Vaibhav.
*/

-- B)
-- create table patient(pno int primary key, pname varchar(10), paddr varchar(20));
-- create table doctor(dno int primary key, dname varchar(20), daddr varchar(20), city varchar(10));
-- create table doct_pat(pno int references patient(pno) on update cascade on delete cascade, dno int references doctor(dno) on update cascade on delete cascade, disease varchar(20), noOfVisit int);


-- insert into patient values(101, 'Samadhan', 'Taradgaon');
-- insert into patient values(102, 'Gayatri', 'Taradgaon');
-- insert into patient values(103, 'Mrunal', 'Pune');

-- insert into doctor values(1, 'Vaibhav', 'Malewadi', 'Pune');
-- insert into doctor values(2, 'Sanket', 'Malewadi', 'Baramati');

-- insert into doct_pat values(102, 1, 'Cough', 10);
-- insert into doct_pat values(103, 1, 'Head-Ache', 7);
-- insert into doct_pat values(101, 2, 'Diabetes', 15);
-- insert into doct_pat values(101, 1, 'Diabetes', 12);

-- -- a.
-- create or replace procedure patientDetails(num int) as 
-- $$
-- declare 
-- info patient%rowtype;
-- begin
-- for info in select p.* from patient p join doct_pat dp on dp.pno = p.pno join doctor d on dp.dno = d.dno where dp.disease = 'Diabetes' and noOfVisit > 3 and dp.dno = num loop
-- raise notice '%', info;
-- end loop;
-- end;
-- $$
-- language 'plpgsql';

-- call patientDetails(1);


-- create or replace procedure countVisit(name varchar(10)) as
-- $$
-- declare 
-- sumVisit int := 0;
-- n int ;
-- itr record;
-- begin
-- select dno into n from doctor where dname = name;
-- for itr in select noOfVisit from doct_pat where dno = n loop
-- sumVisit := sumVisit + itr.noOfVisit;
-- end loop;
-- if sumVisit = 0 then
-- raise notice 'No doctor of name %', name;
-- else
-- raise notice 'Total Visits of % is %', name, sumVisit;
-- end if;
-- end;
-- $$
-- language 'plpgsql';

-- call countVisit('x');

--                                                Set A

/* 
Using If.-Then-else,case,for,while and unconditional loops
1. Find minimum and maximum from two numbers
2. Check the number is positive, negative or zero.
3. Find maximum and minimum from three numbers
4. Find number is even or odd
5. Find sum of first 20 numbers (using unconditional loop)
6. Display all even numbers from 1 to 50.
7. Find sum and average of first n numbers using conditional loop(while)
8. Count odd numbers from given range (m to n) (for)
9. Search the given number is in given range.
10.Display a number in word (Using Case) and loop. */


-- 1
-- create or replace function minmax(a int, b int) returns void as
-- $$
-- begin
-- raise notice 'Max is %', greatest(a, b);
-- raise notice 'Min is %', least(a, b);
-- end;
-- $$
-- language 'plpgsql';

-- select minmax(4, 6);


-- 2
-- create or replace function checkNo(n int) returns void as 
-- $$
-- begin
-- if n = 0 then
-- raise notice '% is Zero', n;
-- elsif n > 0 then
-- raise notice '% is Positive', n;
-- elsif n < 0 then
-- raise notice '% is Negative', n;
-- else
-- raise notice '% is Not a Integer', n;
-- end if;
-- end;
-- $$
-- language 'plpgsql';

-- select checkNo(0);


-- 3
-- create or replace function minmax(a int, b int, c int) returns void as
-- $$
-- begin
-- raise notice 'Max is %', greatest(a, b, c);
-- raise notice 'Min is %', least(a, b, c);
-- end;
-- $$
-- language 'plpgsql';

-- select minmax(4, 6, 24);


-- 4
-- create or replace function evenOrOdd(n int) returns text as
-- $$
-- begin 
-- if n = 0 then
-- return 'No is 0';
-- elsif n % 2 = 0 then
-- return 'Even No';
-- elsif n % 2 <> 0 then
-- return 'Odd No';
-- else
-- return 'Invalid Integer';
-- end if;
-- end;
-- $$
-- language 'plpgsql';

-- select evenOrOdd(230);


-- 5
-- create or replace function sum20() returns int as
-- $$
-- declare 
-- add int := 0;
-- i int := 1;
-- begin
-- loop
-- add := add + i;
-- i = i + 1;
-- exit when i > 20;
-- end loop;
-- return add;
-- end;
-- $$
-- language 'plpgsql';

-- select sum20();


-- 6
-- create or replace function even60() returns void as 
-- $$
-- begin 
-- for i in 0..50 by 2 loop
-- raise notice '%', i;
-- end loop;
-- end;
-- $$
-- language 'plpgsql';

-- select even60();


-- 7
-- create or replace function nsum(n int) returns int as
-- $$
-- declare 
-- n1 int := n;
-- add int := 0;
-- begin
-- loop
-- add := add + n;
-- n = n - 1;
-- exit when n < 1;
-- end loop;
-- return add / n1;
-- end;
-- $$
-- language 'plpgsql';

-- select nsum(10);


-- 8
-- create or replace function countOdd(a int, b int) returns int as 
-- $$
-- declare 
-- cnt int := 0;
-- begin
-- for i in a..b loop
-- if i % 2 = 0 then
-- cnt := cnt + 1;
-- end if;
-- end loop;
-- return cnt;
-- end;
-- $$
-- language 'plpgsql';

-- select countOdd(10, 20);


-- 9
-- create or replace function findKey(a int, b int, keyElement int) returns text as 
-- $$
-- begin
-- for i in a..b loop
-- if i = keyElement then
-- return 'Key is Present in Range';
-- end if;
-- end loop;
-- return 'Key is Not Present in range';
-- end;
-- $$
-- language 'plpgsql';

-- select findKey(10, 20, 11);


-- 10
-- create or replace function printN(n int) returns text as
-- $$
-- declare
-- txt text := ' ';
-- rev int := 0;
-- rem int;
-- begin
-- while n > 0 loop
-- rem := n % 10;
-- rev := rev * 10 + rem;
-- n := n / 10;
-- end loop;
-- while rev > 0 loop
-- rem := rev % 10;
-- rev := rev / 10;
-- if rem = 1 then 
-- txt := txt||' '||'One';
-- elsif rem = 2 then 
-- txt := txt||' '||'Two';
-- elsif rem = 3 then 
-- txt := txt||' '||'Three';
-- elsif rem = 4 then 
-- txt := txt||' '||'Four';
-- elsif rem = 5 then 
-- txt := txt||' '||'Five';
-- elsif rem = 6 then 
-- txt := txt||' '||'Six';
-- elsif rem = 7 then 
-- txt := txt||' '||'Seven';
-- elsif rem = 8 then 
-- txt := txt||' '||'Eight';
-- elsif rem = 9 then 
-- txt := txt||' '||'Nine';
-- else 
-- txt := txt||' '||'Zero';
-- end if;
-- end loop;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select printN(123);

/*
Consider the following database maintained by a Bank. The Bank maintains information about its 
branches, customers and their loan applications.
Following are the tables:
branch (bid integer, brname char (30), brcity char (10))
customer (cno integer, cname char (20), caddr char (35), city char(20)) 
loan_application (lno integer, lamtrequired money, lamtapproved money, l_date date)
The relationship is as follows: branch, customer, loan_application are related with ternary 
relationship. TERNARY (bid integer, cno integer, lno integer).
*/

--                                            Set B

-- create table branch(bid int primary key, bname varchar(20), bcity varchar(10));
-- create table customer(cno int primary key, cname varchar(20), caddr varchar(40), city varchar(10));
-- create table loanApplication(lno int primary key, lrequired int, lapproved int, ldate date);
-- create table brCustLoan(bid int references branch(bid), cno int references customer(cno), lno int references loanApplication(lno));

-- insert into branch values(1, 'BOM', 'Taradgaon');
-- insert into branch values(2, 'BOI', 'Lonand');
-- insert into branch values(3, 'BOB', 'Pune');
-- insert into branch values(4, 'ICICI', 'Mumbai');

-- insert into customer values(101, 'Satyam', 'Malewadi', 'Lonand');
-- insert into customer values(102, 'Saurabh', 'Malewadi', 'Pune');
-- insert into customer values(103, 'Sushant', 'Tardgaon', 'Phaltan');
-- insert into customer values(104, 'Mrunal', 'Tardgaon', 'Mumbai');

-- insert into loanApplication values(1001, 100000, 100000, '3/6/2006');
-- insert into loanApplication values(1002, 1000000, 1000000, '3/6/2026');
-- insert into loanApplication values(1003, 1000, 1000, '3/4/2016');
-- insert into loanApplication values(1004, 10000000, 10000000, '3/6/2026');

-- insert into brCustLoan values(1, 101, 1001);
-- insert into brCustLoan values(2, 103, 1004);
-- insert into brCustLoan values(3, 104, 1004);
-- insert into brCustLoan values(1, 104, 1002);

/*
a) Write a function that returns the total number of customers of a particular branch.(Accept 
branch name as input parameter.)
b) Write a function to find the minimum loan amount approved.
c) Create a function which returns the total number of customers who have applied for a loan 
more than Rs.200000. (Accept loan amount as input parameter)
*/

-- a)
-- create or replace function totalCustomer(name varchar(20)) returns int as 
-- $$
-- declare
-- cnt int := 0;
-- fbno int;
-- begin
-- select bid into fbno from branch where name = bname;
-- select count(*) into cnt from brCustLoan group by bid having bid = fbno;
-- return cnt;
-- end;
-- $$
-- language 'plpgsql';

-- select totalCustomer('BOM');


-- b)
-- create or replace function minLoan() returns int as
-- $$
-- declare
-- res int ;
-- begin
-- select min(lapproved) into res from loanApplication;
-- return res;
-- end
-- $$
-- language 'plpgsql';

-- select minLoan();


-- c)
-- create or replace function custLoan(amt int) returns int as
-- $$
-- declare
-- res int ;
-- begin
-- select count(*) into res from loanApplication where lrequired > amt;
-- return res;
-- end
-- $$
-- language 'plpgsql';

-- select custLoan(200000);


/*

--                                            Set c

Student- Teacher database 
Consider the following database maintained by a school. The school maintains information about 
students and the teachers. It also gives information of the subject taught by the teacher.
Following are the tables:
student (sno integer, s_name char(30), s_class char(10), s_addr char(50))
teacher (tno integer, t_name char (20), qualification char (15), experience integer)
The relationship is as follows: STUDENT-TEACHER: Many to Many with descriptive attribute 
SUBJECT.
*/

-- create table student (sno integer primary key, sname varchar(30), sclass varchar(10), saddr varchar(50));
-- create table teacher (tno integer primary key, tname varchar (20), qualification varchar (15), experience integer);
-- create table Stud_Teach(sno int references student(sno), tno int references teacher(tno), subject varchar(20)); 


-- insert into student values(1, 'Vaibhav', 'SY', 'Pune');
-- insert into student values(2, 'Sushant', 'SY', 'Phaltan');
-- insert into student values(3, 'Rohit', 'FY', 'Mumbai');
-- insert into student values(4, 'Mayur', 'TY', 'Satara');

-- insert into teacher values(101, 'Mrs Deepashree', 'BCS', 20);
-- insert into teacher values(201, 'Mrs Shubhangi', 'MSC', 20);
-- insert into teacher values(301, 'Mr Parameshwar', '12th', 2);
-- insert into teacher values(401, 'Mrs Neha', 'MSC', 10);

-- insert into Stud_Teach values(1, 201, 'DSA');
-- insert into Stud_Teach values(2, 301, 'Share Market');
-- insert into Stud_Teach values(3, 401, 'Mathematics');
-- insert into Stud_Teach values(1, 101, 'Computer');

/*
a) Write a function to find name of the most experienced teacher for “Computer”.
b) Write a function to find the teacher teaching maximum number of subjects.
c) Write a function to find the number of teachers having qualification “MSC”
*/

-- a)
-- create or replace function mostExp(sub varchar(20)) returns varchar(20) as 
-- $$
-- declare 
-- res varchar(20);
-- maxres int;
-- begin
-- SELECT t.tname INTO res FROM teacher t JOIN Stud_Teach s ON t.tno = s.tno WHERE s.subject = sub ORDER BY t.experience DESC LIMIT 1;
-- return res;
-- end;
-- $$
-- language 'plpgsql';

-- select mostExp('Computer');


-- b)
-- create or replace function maxSub() returns varchar(20) as
-- $$
-- declare 
-- id int;
-- name varchar(20);
-- begin
-- select tno into id from Stud_Teach group by tno order by count(*) desc limit 1;
-- select tname into name from teacher where tno = id;
-- return name;
-- end;
-- $$
-- language 'plpgsql';

-- select maxSub();


-- c)
-- create or replace function qualNo(qual varchar(10)) returns int as
-- $$
-- declare 
-- cnt int;
-- begin
-- select count(*) into cnt from teacher where qualification = qual; 
-- return cnt;
-- end;
-- $$
-- language 'plpgsql';

-- select qualNo('BCS');


--                                            Set D

/*
Project – Employee Database 
Consider the following database
Project (pno int, pname char (30), ptype char (20), duration int) 
Employee (empno int, ename char (20), joining_date date)
The relationship between Project and Employee is many to many with descriptive attribute start_date.
Create the above database in PostGreSQL and insert sufficient records.
Execute any two of the following using PL/pgSQL
*/

-- create table Project(pno int primary key, pname char(30), ptype char(20), duration int); 
-- create table Employee(empno int primary key, ename char (20), joining_date date);
-- create table Proj_Emp(pno int references Project(pno), empno int references Employee(empno), sdate date);

-- insert into Project values(101, 'Solar', 'Hardware', 2);
-- insert into Project values(102, 'Calculator', 'Software', 1);
-- insert into Project values(103, 'Password Cracker', 'Software', 5);

-- insert into Employee values(1, 'Vaibhav', '04/18/2006');
-- insert into Employee values(2, 'Satyam', '11/10/2005');
-- insert into Employee values(3, 'Sushant', '11/29/2005');

-- insert into Proj_Emp values(103, 1, '04/18/2026');
-- insert into Proj_Emp values(102, 2, '04/14/2016');
-- insert into Proj_Emp values(101, 3, '04/18/2026');


/*
a. Write a stored function to accept project type as an input and display all project names of 
that type.
b. Write a function which accepts employee name and prints the details of the project which 
the employee works on.
c. Write a function to accept project name as input and returns the number of employees 
working on the project
*/

-- a)
-- create or replace function displayProject(projectype varchar(20)) returns text as
-- $$
-- declare
-- txt text := ' ';
-- itr project%rowtype;
-- begin
-- for itr in select * from Project where ptype = projectype loop
-- txt := txt||itr.pname||e'\n';
-- end loop;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select displayProject('Software');


-- b)
-- create or replace function empDetail(name varchar(20)) returns Project as
-- $$
-- declare
-- info Project%rowtype;
-- begin
-- select * into info from Project where pno = (select pno from Proj_Emp pe join Employee e on pe.empno = e.empno where e.ename = name);
-- return info;
-- end;
-- $$
-- language 'plpgsql';

-- select empDetail('Vaibhav');


-- c)
-- create or replace function countEmp(name varchar(20)) returns int as
-- $$
-- declare 
-- cnt int;
-- begin
-- select count(*) into cnt from Proj_Emp pe join Project p on p.pno = pe.pno where p.pname = name;
-- return cnt;
-- end;
-- $$
-- language 'plpgsql';

-- select countEmp('Solar');


--                                            Set E

/*
Student - Subject Database 
Consider the following database
Student (roll_no integer, name varchar(30), address varchar(50), class varchar(10)) Subject 
(scode varchar(10), subject_name varchar(20))
Student-Subject are related with Many to Many relationship with attributes
marks_scored. Create the above database in PostGreSQL and insert sufficient records.
*/

-- create table Student(rno integer primary key, sname varchar(30), address varchar(50), class varchar(10));
-- create table Subject(scode varchar(10) primary key, subname varchar(20));
-- create table Sub_Stud(rno int references Student(rno), scode varchar(20) references Subject(scode), marks int);

-- insert into student values(1, 'Siddharth', 'Pimpri', 'SY');
-- insert into student values(2, 'Vaibhav', 'Pune', 'SY');
-- insert into student values(3, 'Kalyani', 'Mumbai', 'SY');

-- insert into Subject values('Eng', 'English');
-- insert into Subject values('Mat', 'Mathematics');
-- insert into Subject values('Phy', 'Physics');

-- insert into Sub_Stud values(1, 'Eng', 40);
-- insert into Sub_Stud values(2, 'Mat', 100);
-- insert into Sub_Stud values(3, 'Phy', 50);

-- a.Write a function which will accept the name and print all the details of that student.
-- b. Write a function to accept student roll_no as input and displays details of that student.
-- c.Write a stored function using cursors, to accept class from the user and display the details of the 
-- students of that class.

-- a)
-- create or replace function studetails(name varchar(10))
-- returns record as
-- $$
-- declare
-- rec record;
-- begin
-- select s.*, ss.marks, sub.subname into rec from student s join sub_stud ss on s.rno = ss.rno join subject sub on sub.scode = ss.scode where s.sname = name;
-- return rec;
-- end;
-- $$
-- language plpgsql;

-- select studetails('Vaibhav');


-- b)
-- create or replace function studetails(n int)
-- returns record as
-- $$
-- declare
-- rec record;
-- begin
-- select s.*, ss.marks, sub.subname into rec from student s join sub_stud ss on s.rno = ss.rno join subject sub on sub.scode = ss.scode where s.rno = n;
-- return rec;
-- end;
-- $$
-- language plpgsql;

-- select studetails(2);


-- c)
-- create or replace function displayDetails(studClass varchar(10)) returns text as
-- $$
-- declare 
-- rec record;
-- txt text := '';
-- cur cursor for select s.*, sub.subname, ss.marks from Student s join Sub_Stud ss on s.rno = ss.rno join Subject sub on ss.scode = sub.scode where s.class = studClass;
-- begin
-- open cur;
-- loop
-- fetch cur into rec;
-- exit when not found;
-- txt := txt||rec.rno||' '||rec.sname||' '||rec.address||' '||rec.subname||' '||rec.marks||e'\n';
-- end loop;
-- close cur;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select displayDetails('SY');

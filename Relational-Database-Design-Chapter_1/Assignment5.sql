--                                              SET A 
/*
Movie – Actor Database 
Consider the following database
Movie (m_name varchar (25), release_year integer, budget money)
Actor (a_name varchar(30), role varchar(30), charges money, a_address varchar(30) ) 
Movie and Actor are related with many to many relationship.
Create the above database in PostGreSQL and insert sufficient records.
*/

-- create table Movie(mname varchar(25) primary key, ryear integer, budget money);
-- create table Actor(aname varchar(30) primary key, role varchar(30), charges money, aaddress varchar(30));
-- create table Movie_Actor(mname varchar(25) references Movie(mname) on delete cascade, aname varchar(30) references Actor(aname)on delete cascade);

-- insert into Movie values('Dilwale', 2010, 100000000);
-- insert into Movie values('Pushpa', 2024, 20000000);
-- insert into Movie values('Swarg', 2006, 50000000);

-- insert into Actor values('Shah Ruk Khan', 'Hero', 10000000, 'Mumbai');
-- insert into Actor values('Allu Arjun', 'Hero', 10000000, 'Mumbai');
-- insert into Actor values('Govinda', 'Hero', 7000000, 'Pune');

-- insert into Movie_Actor values('Dilwale', 'Shah Ruk Khan');
-- insert into Movie_Actor values('Pushpa', 'Allu Arjun');
-- insert into Movie_Actor values('Swarg', 'Govinda');

-- a. Write a trigger which will be executed whenever an actor is deleted from the actor table, 
-- display appropriate message.
-- b. Write a trigger which will be executed whenever a movie is deleted from the movie table, 
-- display appropriate message.
-- c. Write a trigger which will be executed whenever insertion is made to the movie table. If 
-- the budget is less than 1,00,000 do not allow the insertion. Give appropriate message

-- a)
-- create or replace function delActor() returns trigger as
-- $$
-- begin
-- raise notice '% Actor is Deleted From Databse', old.aname;
-- return old;
-- end;
-- $$
-- language 'plpgsql';

-- create trigger trg after delete on Actor for each row execute function delActor();

-- delete from Actor where aname = 'Shah Ruk Khan';


-- b)
-- create or replace function delMovie() returns trigger as
-- $$
-- begin 
-- raise notice '% Movie is Deleted', old.mname;
-- return old;
-- end;
-- $$
-- language 'plpgsql';

-- create trigger trg after delete on Movie for each row execute function delMovie();

-- delete from Movie where mname = 'Swarg';


-- c)
-- create or replace function insertData() returns trigger as
-- $$
-- begin
-- if new.budget < '50000000' then
-- raise exception 'Less Thn 50000000 Budget is Not Allowed';
-- end if;
-- return new;
-- end;
-- $$
-- language 'plpgsql';

-- create trigger tgr before update or insert on Movie for each row execute function insertData();

-- insert into Movie values('KGF', 2023, '4000000');



--                                               SET B
/*
Doctor – Hospital Database 
Consider the following database
Doctor (d_no int, d_name varchar(30), specialization varchar(35), charges int) 
Hospital (h_no int, h_name varchar(20), city varchar(100))
Doctor and Hospital are related with many to one relationship.
*/

-- create table Hospital(hno int primary key, hname varchar(20), city varchar(100));
-- create table Doctor(dno int primary key, dname varchar(30), specialization varchar(35), charges int, hno int references Hospital(hno) on delete cascade);

-- insert into Hospital values(101, 'YCM', 'Pimpri-Chinchwad');
-- insert into Hospital values(102, 'D.Y.Patil', 'Pune');
-- insert into Hospital values(103, 'Sahyadri', 'Hadapsar');

-- insert into doctor values(1, 'Dr. Siraj basade', 'Neuro Surgeon', 100000, 103);
-- insert into doctor values(2, 'Dr. Nitin Savant', 'Digestion Specialist', 10000, 101);
-- insert into doctor values(3, 'Dr. Sachin Adsul', 'Homopathic', 1000, 102);


-- Create the above database in PostGreSQL and insert sufficient records.
-- a. Write a trigger before insert/update on Doctor table. Raise exception if charges are <0.
-- b. Write a trigger that restricts insertion of charges value greater than 40000.

-- a)
-- create or replace function checkCharges1() returns trigger as 
-- $$
-- begin 
-- if new.charges < 0 then
-- raise exception 'Charges Cannot be Negative';
-- end if;
-- return new;
-- end;
-- $$
-- language 'plpgsql';

-- create trigger trg before insert or update on Doctor for each row execute function checkCharges1();

-- insert into Doctor values(4, 'Dr. Soham Raut', 'Normal Check Up', -100, 101);


-- b)
-- create or replace function checkCharges2() returns trigger as 
-- $$
-- begin 
-- if new.charges > 40000 then
-- raise exception 'Charges Cannot be Greater Than 40000';
-- end if;
-- return new;
-- end;
-- $$
-- language 'plpgsql';

-- create trigger trg before insert or update on Doctor for each row execute function checkCharges2();

-- insert into Doctor values(4, 'Dr. Arvind Sharma', 'Heart Specialist', 100000, 101);



--                                            SET C

/*
Student – Subject database 
Consider the following database :
Student (rollno integer, name varchar(30),city varchar(50),class varchar(10)) 
Subject(Scode varchar(10),subject name varchar(20))
Student and subject are related with M-M relationship with attributes marks_scored.
Create the above database in PostGreSQL and insert sufficient records
*/

-- create table Student(rno integer primary key, name varchar(30),city varchar(50),class varchar(10)); 
-- create table Subject(scode varchar(10) primary key, sname varchar(30));
-- create table Student_Subject(rno int references Student(rno) on delete cascade, scode varchar(20) references Subject(scode) on delete cascade on update cascade , marks int);

-- insert into Student values(1, 'Vaibhav', 'Pune', 'SY');
-- insert into Student values(2, 'Sanket', 'Baramati', 'SY');
-- insert into Student values(3, 'Vedant', 'Jalgaon', 'FY');

-- insert into Subject values('Math', 'Mathematics');
-- insert into Subject values('Eng', 'English');
-- insert into Subject values('DSA', 'Data Structure & Algorithm');

-- insert into Student_Subject values(1, 'Math', 99);
-- insert into Student_Subject values(2, 'DSA', 69);
-- insert into Student_Subject values(3, 'Eng', 50);

-- a. Write a trigger before insert/update the marks_scored. Raise exception if Marks are 
-- negative.
-- b. Write a trigger which is executed when insertion is made in the student-subject table. If
-- marks_scored is less than 0, give appropriate message and do not allow the insertion.
-- c. Write a trigger which will prevent deleting students from ‘Pune’ city.


-- a)
-- create or replace function checkMark1() returns trigger as
-- $$
-- begin
-- if new.marks < 0 then
-- raise exception 'Marks Cannot be Negative';
-- end if;
-- return new;
-- end;
-- $$
-- language 'plpgsql';

-- create trigger tgr before insert or update on Student_Subject for each row execute function checkMark1(); 

-- insert into Student_Subject values(2, 'Math', -2);


-- b)
-- create or replace function checkMark2() returns trigger as
-- $$
-- begin
-- if new.marks < 0 then
-- raise exception 'Marks Cannot be Negative, insertion Not Allowed';
-- end if;
-- return new;
-- end;
-- $$
-- language 'plpgsql';

-- create trigger tgr before insert or update on Student_Subject for each row execute function checkMark2(); 

-- insert into Student_Subject values(2, 'Math', -2);


-- c)
-- create or replace function preventPune() returns trigger as
-- $$
-- begin
-- if old.city = 'Pune' then
-- raise exception 'Student from Pune City Can Not be Deleted';
-- end if;
-- return old;
-- end;
-- $$
-- language 'plpgsql';

-- create trigger tgr after delete on Student for each row execute function preventPune();

-- delete from Student where name = 'Vaibhav';



--                                           SET D

/*
Customer – Account database 
Consider the following database
Customer (cno integer, cname varchar(20), city varchar(20))
Account (a_no int, a_type varchar(10), opening_date date, balance money) 
Customer and Account are related with one to many relationship
Create the above database in PostGreSQL and insert sufficient records.
*/

-- create table Customer(cno integer primary key, cname varchar(20), city varchar(20));
-- create table Account (ano int primary key, atype varchar(10), odate date, balance money, cno int references Customer(cno)); 

-- insert into Customer values(1, 'Vaibhav', 'Pune');
-- insert into Customer values(2, 'Sanket', 'Baramati');
-- insert into Customer values(3, 'Ujjwal', 'Jalgaon');

-- insert into Account values(101, 'Saving', '03/09/2027', '10000000', 1);
-- insert into Account values(102, 'current', '03/09/2026', '1000000', 2);
-- insert into Account values(103, 'Saving', '03/08/2026', '500000', 3);

-- a. Write a trigger which is executed whenever update is made to the account table. If the 
-- balance becomes less than 1000, print an error message that balance cannot be less than 
-- 1000.
-- b. Write a trigger before deleting an account record from Account table. Raise a notice and 
-- display the message “Account record is being deleted.”
-- c. Write a trigger before inserting an account record in Account table and raise exception if 
-- balance is <500.


-- a)
-- create or replace function accBalance1() returns trigger as
-- $$
-- begin
-- if new.balance < '1000' then
-- raise exception 'Balance Must be Greater than 1000';
-- end if;
-- return new;
-- end;
-- $$
-- language 'plpgsql';

-- create trigger tgr before update on Account for each row execute function accBalance1();

-- update Account set balance = '500' where ano = 103;


-- b)
-- create or replace function delRec() returns trigger as 
-- $$
-- begin
-- raise notice '% Account is Deleted', old.ano;
-- return old;
-- end;
-- $$
-- language 'plpgsql';

-- create trigger tgr after delete on Account for each row execute function delRec();

-- delete from Account where ano = 103;


-- c)
-- create or replace function accBalance2() returns trigger as
-- $$
-- begin
-- if new.balance < '500' then
-- raise exception 'Balance Must be Greater than 500';
-- end if;
-- return new;
-- end;
-- $$
-- language 'plpgsql';

-- create trigger tgr before insert on Account for each row execute function accBalance2();

-- insert into Account values(104, 'Saving', '03/08/2026', 400, 3);



--                                              SET E

/*
Project-Employee Database
Consider the following Entities and their Relationships for Project-Employee database. 
Project (pno integer, pname char (30), ptype char (20), duration integer) 
Employee (eno integer, ename char (20), qualification char (15), joining_date date) 
Relationship between Project and Employee is many to many with descriptive 
attribute start_date date, no_of_hours_worked integer. 
Constraints: Primary Key, pname should not be null. 
Create trigger for the following: 
*/

-- create table Project(pno integer primary key, pname char (30) not null, ptype char (20), duration integer); 
-- create table Employee(eno integer primary key, ename char (20), qualification char (15), jdate date);
-- create table Project_Employee(pno int references Project(pno)on delete cascade, eno int references Employee(eno)on delete cascade, sdate date, hrsWorked int);


-- insert into Project values(101, 'Password Cracker', 'Software', 30);
-- insert into Project values(102, 'Photo Editor', 'Software', 10);
-- insert into Project values(103, 'Efficient Farming Instrument', 'Hardware', 60);

-- insert into Employee values(1, 'Vaibhav', 'BCS', '07/15/2027');
-- insert into Employee values(2, 'Sanket', 'BTech (Mech.)', '07/15/2028');
-- insert into Employee values(3, 'Sushant', 'Agriculture', '07/15/2029');

-- insert into Project_Employee values(101, 1, '07/15/2027', 180);
-- insert into Project_Employee values(102, 2, '07/15/2028', 140);
-- insert into Project_Employee values(101, 1, '07/15/2029', 170);


-- a. Write a trigger before inserting into an employee table to check current 
-- date should be always greater than joining date. Display appropriate 
-- message. 
-- b. Write a trigger before inserting into a project table to check duration 
-- should be always greater than zero. Display appropriate message. 
-- c. Write a trigger before deleting an employee record from employee table. 
-- Raise a notice and display the message “Employee record is being 
-- deleted”.


-- a)
-- create or replace function cmpdate() returns trigger as
-- $$
-- begin
-- if new.jdate > current_date then
-- raise exception '% Date is invalid. It must be Less Than Current Date', new.jdate;
-- end if;
-- return new;
-- end;
-- $$
-- language 'plpgsql';

-- create trigger tgr before insert on Employee for each row execute function cmpdate();

-- insert into Employee values(4, 'Ujjwal', 'BCS', '07/07/2035');


-- b)
-- create or replace function projDuration() returns trigger as
-- $$
-- begin
-- if new.duration < 0 then 
-- raise exception 'Duration Must Be Greater Than 0';
-- end if;
-- return new;
-- end;
-- $$
-- language 'plpgsql';

-- create trigger tgr before insert on Project for each row execute function projDuration();

-- insert into Project values(104, 'Web Dev.', 'Software', -5);


-- c)
-- create or replace function delEmp() returns trigger as
-- $$
-- begin
-- raise notice 'Employee % data is deleted', old.ename;
-- return old;
-- end;
-- $$
-- language 'plpgsql';

-- create trigger tgr after delete on Employee for each row execute function delEmp();

-- delete from Employee where ename = 'Sushant';
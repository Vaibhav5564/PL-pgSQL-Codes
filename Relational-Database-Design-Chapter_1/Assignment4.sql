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

--                                                   Set C

/*
Wholesaler – Product database 
Consider the following entities and their relationships.
Wholesaler (w_no, w_name, address, city) 
Product (product_no, product_name, rate)
Relation between Wholesaler and Product is Many to Many with quantity as descriptive 
attribute.
Create the above database in PostGreSQL and insert sufficient records.
*/

-- create table Wholesaler(wno int primary key, wname varchar(20), address varchar(30), city varchar(10)); 
-- create table Product(pno int primary key, pname varchar(20), rate int);
-- create table Wholesaler_Product(wno int references Wholesaler(wno), pno int references Product(pno), quantity int);


-- insert into Wholesaler values(1, 'Sahil Shaha', 'Taradgaon', 'Lonand');
-- insert into Wholesaler values(2, 'Ujjwal Dhande', 'Bhusawal', 'Jalgaon');
-- insert into Wholesaler values(3, 'Savan Adsul', 'Malewadi', 'Lonand');

-- insert into Product values(101, 'Maggi', 10);
-- insert into Product values(102, 'Lassi', 30);
-- insert into Product values(103, 'Masala', 20);

-- insert into Wholesaler_Product values(1, 101, 10);
-- insert into Wholesaler_Product values(2, 102, 20);
-- insert into Wholesaler_Product values(3, 103, 10);


-- a. Write a function to accept quantity from user. Quantity must be within range 10-50. If user enters 
-- the quantity out of range, then raise a user defined exception “quantity_out_of _range” otherwise 
-- enter the record in table.
-- b. Write a function which accept rate from user. If user enters rate less than or equal to zero then 
-- raise an user defined exception “Invalid_Rate_Value” otherwise display message “Correct Input”.
-- c. Write a function to accept product name as parameter. If entered product name is not valid then 
-- raise an user defined exception”Invalid_Product_Name” otherwise display product details of 
-- Specified product


-- a)
-- create or replace function quantInfo() returns text as
-- $$
-- declare 
-- txt text := '';
-- rec record;
-- begin
-- for rec in select * from Wholesaler w join Wholesaler_Product wp on w.wno = wp.wno join Product p on wp.pno = p.pno where wp.quantity between 10 and 50 loop
-- txt := txt||rec.wno||' '||rec.wname||' '||rec.address||' '||rec.city||' '||rec.pname||e'\n';
-- end loop;
-- if txt = '' then 
-- raise exception 'No quantity present in range 10 to 50';
-- end if;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select quantInfo();


-- b)
-- create or replace function passRate(r int)
-- returns void as '
-- begin
-- if r < 0 then 
-- raise exception ''Invalid Rate Value'';
-- else
-- raise notice ''Correct Input'';
-- end if;
-- return;
-- end;
-- '
-- language 'plpgsql';

-- select passRate(-10);


-- c)
-- create or replace function checkName(name varchar(20)) returns text as' 
-- declare
-- txt text := '''';
-- rec record;
-- begin
-- select * into rec from product where pname = name;
-- if not found then 
-- raise exception ''Invalid Product Name'';
-- end if;
-- txt := txt||rec.pno||'' ''||rec.pname||'' ''||rec.rate||e''\n'';
-- return txt;
-- end;
-- 'language 'plpgsql';

-- select checkName('Bourn Vita');



--                                             Set D

/*
Student Teacher Database 
Student (sno integer, s_name char(30), s_class char(10), s_addr Char(50)) 
Teacher (tno integer, t_name char (20), qualification char (15), experience integer) 
The relationship is as follows: 
Student-Teacher: Many to Many with descriptive attribute Subject. 
*/

-- create table Student(sno integer primary key, sname varchar(30), sclass varchar(10), saddr varChar(50)); 
-- create table Teacher(tno integer primary key, tname varchar (20), qualification varchar (15), experience integer); 
-- create table Student_Teacher(sno int references Student(sno), tno int references Teacher(tno), subject varchar(20));

-- insert into Student values(1, 'Vaibhav', 'SY', 'Malewadi');
-- insert into Student values(2, 'Ujjwal', 'SY', 'Jalgaon');
-- insert into Student values(3, 'Mohir', 'FY', 'Bhusawal');

-- insert into Teacher values(101, 'Mr Choramle Sir', 'BCom', 20);
-- insert into Teacher values(102, 'Mrs Depashree Mam', 'BCS', 10);
-- insert into Teacher values(103, 'Mr Dube Sir', 'MCom', 5);

-- insert into Student_Teacher values(1, 101, 'All Subjects');
-- insert into Student_Teacher values(2, 102, 'C Programming');
-- insert into Student_Teacher values(1, 102, 'C Programming');
-- insert into Student_Teacher values(3, 103, 'Hindi');

-- a. Write a stored function to count the number of the teachers teaching to a student named
-- (Accept student name as input parameter). Raise an exception if student name does not 
-- exist. 
-- b. Write a stored function to count the number of the students who are studying subject named 
-- (Accept subject name as input parameter). Display error message if subject name is 
-- not valid. 
-- c. Write a stored function to display teacher details who have qualification as 
-- (Accept teacher’s qualification as input parameter). Raise an exception for invalid qualification.


-- a)
-- create or replace function counTeacher(name varchar(20)) returns int as
-- $$
-- declare
-- cnt int;
-- begin 
 
-- select count(*) into cnt from Student s join Student_Teacher st on s.sno = st.sno where sname = name;
-- return cnt;
-- end;
-- $$
-- language 'plpgsql';

-- select counTeacher('Vaibhav');


-- b)
-- create or replace function counTeacher(sub varchar(10)) returns int as
-- $$
-- declare
-- cnt int;
-- begin
-- select count(distinct sno) into cnt from Student_Teacher where subject = sub;
-- return cnt;
-- end;
-- $$
-- language 'plpgsql';

-- select counTeacher('C Programming');


-- c)
-- create or replace function displayInfo(qual varchar(20)) returns record as
-- $$
-- declare 
-- rec record;
-- begin
-- select * from Teacher into rec where qualification = qual;
-- return rec;
-- end;
-- $$
-- language 'plpgsql';

-- select displayInfo('BCom');



--                                                  Set E

/*
Railway Reservation System Database 
TRAIN: (train_no int, train_name varchar(20), depart_time time , arrival_time time, source_stn 
varchar (20),dest_stn varchar (20), no_of_res_bogies int ,bogie_capacity int) 
PASSENGER : (passenger_id int, passenger_name varchar(20), address varchar(30), age int ,gender 
char) 
Relationships: 
Train _Passenger: Many to Many relationship named ticket with descriptive attributes as follows 
TICKET: ( train_no int, passenger_id int, ticket_no int ,bogie_no int, no_of_berths int ,tdate date , 
ticket_amt decimal(7,2),status char) 
Constraints: The status of a berth can be 'W' (waiting) or 'C' (confirmed). 
*/

-- create table TRAIN(train_no int primary key, train_name varchar(20), depart_time time , arrival_time time, source_stn varchar (20),dest_stn varchar (20), no_of_res_bogies int ,bogie_capacity int); 
-- create table PASSENGER (passenger_id int primary key, passenger_name varchar(20), address varchar(30), age int ,gender char);
-- create table TICKET(train_no int references Train(train_no), passenger_id int references PASSENGER(passenger_id), ticket_no int, bogie_no int, no_of_bearths int, tdate date, ticket_amt decimal(7, 2), status char);


-- insert into TRAIN values(101, 'Maharashtra Express', '10:20:00', '10:10:00', 'Pune', 'Nagpur', 10, 20);
-- insert into TRAIN values(102, 'Chennai Express', '12:20:00', '12:10:00', 'Chennai', 'Mumbai', 15, 40);
-- insert into TRAIN values(103, 'Satara Demo', '10:40:00', '10:20:00', 'Pune', 'Satara', 20, 30);


-- insert into PASSENGER values(1, 'Vaibhav', 'Malewadi', 21, 'M');
-- insert into PASSENGER values(2, 'Sanket', 'Malewadi', 21, 'M');
-- insert into PASSENGER values(3, 'Mayuri', 'Malewadi', 21, 'F');

-- insert into TICKET values(101, 1, 1001, 1, 11, '07/15/2027', 5000, 'C');
-- insert into TICKET values(101, 2, 1002, 2, 21, '07/15/2027', 1000, 'C');
-- insert into TICKET values(103, 3, 1003, 3, 31, '07/15/2028', 2000, 'W');


-- a. Write a stored function to print the details of train wise confirmed bookings on date 
--  (Accept date as input parameter).Raise an error in case of invalid date. 
-- b. Write a stored function to accept date and passenger name and display no of berths reserved 
-- and ticket amount paid by him. Raise exception if passenger name is invalid. 
-- c. Write a stored function to display the ticket details of a train. (Accept train name as input 
-- parameter).Raise an exception in case of invalid train name.


-- a)
-- create or replace function confirmBooking(d date) returns text as 
-- $$
-- declare
-- txt text := '';
-- rec record;
-- begin
-- for rec in select tr.* from TRAIN tr join TICKET ti on tr.train_no = ti.train_no where ti.tdate = d and ti.status = 'C' loop
-- txt := txt||'Train No - '||rec.train_no||', Train Name - '||rec.train_name||', Depart Time - '||rec.depart_time||', Arrival Time - '||rec.arrival_time||', Source - '||rec.source_stn||', Destinantion - '||rec.dest_stn||', No. Of Res Bogies'||rec.no_of_res_bogies||', Bogie Capacity'||rec.bogie_capacity||e'\n';
-- end loop;
-- if txt = '' then
-- raise exception 'No Train on % this data', d;
-- end if;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select confirmBooking('07/15/2027');


-- b)
-- create or replace function displayBearth(name varchar(20), d date) returns record as 
-- $$
-- declare
-- rec record;
-- begin
-- select no_of_bearths, ticket_amt into rec from TICKET t join PASSENGER p on t.passenger_id = p. passenger_id where t.tdate = d and p.passenger_name = name;
-- if rec is null then 
-- raise exception 'Invalid Passenger Name or Date';
-- end if;
-- return rec;
-- end;
-- $$
-- language 'plpgsql';

-- select displayBearth('Vaibhav', '07/15/2027');


-- c)
-- create or replace function displayTicketInfo(tname varchar (20)) returns text as 
-- $$
-- declare
-- txt text := '';
-- rec record;
-- begin
-- for rec in select * from TICKET ti join PASSENGER p on ti.passenger_id = p.passenger_id join TRAIN tr on ti.train_no = tr.train_no where tr.train_name = tname loop
-- txt := txt||rec.passenger_id||' '||rec.passenger_name||' '||rec.ticket_no||' '||rec.depart_time||' '||rec.arrival_time||' '||rec.ticket_amt||e'\n';
-- end loop;
-- if txt = '' then 
-- raise exception 'Invalid Train Name';
-- end if;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select displayTicketInfo('Maharashtra Express');
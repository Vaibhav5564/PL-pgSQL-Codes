--                                               set A

/*
Bus – Route Database 
Consider the following database
Bus (bus_no int, capacity int , depot_name varchar(20))
Route (route_no int, source varchar(20), destination varchar(20), No_of_stations int)
Bus and Route are related with many to many relationship.
Create the above database in PostGreSQL and insert sufficient records.
*/

-- create table Bus(bno int primary key, capacity int , dname varchar(20));
-- create table Route(rno int primary key, source varchar(20), destination varchar(20), nOfstations int);
-- create table Bus_Route(bno int references Bus(bno), rno int references Route(rno));

-- insert into Bus values(1, 35, 'Pimpri');
-- insert into Bus values(2, 40, 'Pune');
-- insert into Bus values(3, 50, 'Mumbai');

-- insert into Route values(101, 'Pimpri', 'Swargate', 10);
-- insert into Route values(102, 'Pune', 'Mumbai', 12);
-- insert into Route values(103, 'Satara', 'Mumbai', 20);

-- insert into Bus_Route values(1, 101);
-- insert into Bus_Route values(1, 102);
-- insert into Bus_Route values(2, 103);

-- a. Write a stored function using cursor, which will give details of all routes on which bus no 
-- 103 is running.
-- b. Write a stored function using cursor, which will give details of all buses on route from 
-- “Source” to “Destination”

-- a)
-- create or replace function displayInfo(n int) returns text as 
-- $$
-- declare
-- rec record;
-- txt text := '';
-- cur cursor for select * from Bus b join Bus_Route br on b.bno = br.bno where br.rno = n;
-- begin
-- open cur;
-- loop
-- fetch cur into rec;
-- exit when not found;
-- txt := txt||' '||rec.bno||' '||rec.capacity||' '||rec.dname||e'\n';
-- end loop;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select displayInfo(102);

-- b)
-- create or replace function dispDetails(s varchar(10), d varchar(10)) returns text as
-- $$
-- declare
-- txt text := '';
-- rec record;
-- cur cursor for select * from bus b join Bus_Route br on b.bno = br.bno join route r on br.rno = r.rno where r.source = s and r. destination = d;
-- begin
-- open cur;
-- loop
-- fetch cur into rec;
-- exit when not found;
-- txt := txt||rec.bno||' '||rec.capacity||' '||rec.dname||' '||rec.nOfstations||e'\n';
-- end loop;
-- return txt;
-- close cur;
-- end;
-- $$
-- language 'plpgsql';

-- select dispDetails('Satara','Mumbai');



--                                               set B

/*
Student –Teacher database 
Consider the following database
Teacher( t_no int, t_name varchar(20), age int, yr_experience int) 
Subject (s_no int, s_namevarchar(15))
Teacher and Subject are related with many to many relationship
Create the above database in PostGreSQL and insert sufficient records.
*/

-- create table Teacher(tno int primary key, tname varchar(20), age int, exp int); 
-- create table Subject (sno int primary key, sname varchar(15));
-- create table Teacher_Subject(tno int references Teacher(tno), sno int references subject(sno));


-- insert into Teacher values(1, 'Mr. Choramle Sir', 40, 20);
-- insert into Teacher values(2, 'Mr. Dhole Sir', 35, 15);
-- insert into Teacher values(3, 'Mrs. Ghodke Madam', 40, 20);

-- insert into Subject values(101, 'Marathi');
-- insert into Subject values(102, 'Hindi');
-- insert into Subject values(103, 'Mathematics');

-- insert into Teacher_Subject values(1, 101);
-- insert into Teacher_Subject values(2, 101);
-- insert into Teacher_Subject values(1, 103);

-- a. Write a stored function using cursor which will accept the subject name and print the 
-- names of all teachers teaching that subject.
-- b. Write a cursor to accept the subject's name from the user as an input and display names
-- of all teachers teaching that student.

-- a)
-- create or replace function printNames(subName varchar(18)) returns text as
-- $$
-- declare 
-- cur cursor for select tname from Teacher t join Teacher_Subject ts on t.tno = ts.tno join Subject s on ts.sno = s.sno where sname = subName;
-- txt text := '';
-- rec record;
-- begin
-- open cur;
-- loop
-- fetch cur into rec;
-- exit when not found; 
-- txt := txt||rec.tname||e'\n';
-- end loop;
-- close cur;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select printNames('Marathi');


-- b)
-- create or replace function printNames(subName varchar(18)) returns text as
-- $$
-- declare 
-- cur cursor for select tname from Teacher t join Teacher_Subject ts on t.tno = ts.tno join Subject s on ts.sno = s.sno where sname = subName;
-- txt text := '';
-- rec record;
-- begin
-- open cur;
-- loop
-- fetch cur into rec;
-- exit when not found; 
-- txt := txt||rec.tname||e'\n';
-- end loop;
-- close cur;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select printNames('Marathi');


--                                               set C


/*
Person - Area Database 
Person(pno int, name varchar (20), birthdate date, income money)  
Area(aid int, aname varchar (20), area_type varchar (5))
The person and area related to many to one relationship. The attribute ‘area_type’ can have values 
either ‘urban’ or ‘rural’.
Create the above database in PostGreSQL and insert sufficient records.
*/

-- create table Area(aid int primary key, aname varchar (20), area_type varchar (5));
-- create table Person(pno int primary key, name varchar (20), birthdate date, income money, aid int references Area(aid));

-- insert into Area values(101, 'Residential', 'urban');
-- insert into Area values(201, 'Military', 'rural');
-- insert into Area values(301, 'Restricted', 'urban');

-- insert into Person values(1, 'Vaibhav', '04/18/2006', 100000, 101);
-- insert into Person values(2, 'Satyam', '11/29/2005', 10000, 301);
-- insert into Person values(3, 'Sushant', '11/29/2005', 15000, 201);


-- a. Write a cursor to accept a month as an input parameter from the user and display the 
-- names of persons whose birthday falls in that particular month.
-- b. Write a cursor to display the names of persons living in urban area.
-- c. Write a cursor to print names of all persons having income between 50,000 and 1,00,000.


-- a)
-- create or replace function bmonth(mon int) returns text as
-- $$
-- declare
-- txt text := '';
-- rec record;
-- cur cursor for select * from Person where extract(month from birthdate) = mon; 
-- begin
-- open cur;
-- loop
-- fetch cur into rec;
-- exit when not found;
-- txt := txt||e'\n'||rec.name;
-- end loop;
-- close cur;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select bmonth(11);


-- b)
-- create or replace function disNames(atype varchar(20)) returns text as
-- $$
-- declare
-- rec record;
-- cur cursor for select p.* from Area a join Person p on a.aid = p.aid where area_type = atype;
-- txt text := '';
-- begin
-- open cur;
-- loop
-- fetch cur into rec;
-- exit when not found;
-- txt := txt||rec.name||e'\n';
-- end loop;
-- close cur;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select disNames('urban');


-- c)
-- create or replace function midPerson(a money, b money) returns text as 
-- $$
-- declare
-- n varchar(10);
-- txt text := '';
-- begin 
-- for n in select name from Person where income between a and b loop
-- txt := txt||n||e'\n';
-- end loop;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select midPerson('50000', '1000000');



--                                                  Set D

/*
Student – Competition Database 
 Consider the following entities and their relationship.
 Student (s_reg_no int, s_name varchar(20), s_class varchar(20))
 Competition (comp_no int, comp_name varchar(20), comp_type varchar(20))
Relationship between Student and Competition is many-to-many with descriptive attribute rank and 
year.
*/

-- create table Student(sno int primary key, sname varchar(20), sclass varchar(20));
-- create table Competition(cno int primary key, cname varchar(20), ctype varchar(20));
-- create table Student_Competition(sno int references Student(sno), cno int references Competition(cno), rnk int, yr int);

-- insert into Student values(1, 'Vaibhav', 'SY');
-- insert into Student values(2, 'Sanket', 'SY');
-- insert into Student values(3, 'Mrunal', 'FY');

-- insert into Competition values(101, 'Coding', 'Inter Colligiate');
-- insert into Competition values(102, 'Mind Mash', 'College Only');
-- insert into Competition values(103, 'Treasure Hunt', 'Universal');

-- insert into Student_Competition values(1, 101, 1, 2026);
-- insert into Student_Competition values(2, 102, 3, 2026);
-- insert into Student_Competition values(3, 103, 5, 2024);


-- a) Write a cursor which will display year wise details of competitions held. (Use 
-- parameterized cursor)
-- b) Write a cursor which will display student wise total count of competition participated.


-- a)
-- create or replace function disInfo(y int) returns text as 
-- $$
-- declare 
-- rec record;
-- txt text := '';
-- cur cursor for select * from Competition c join Student_Competition sc on c.cno = sc.cno where sc.yr = y;
-- begin
-- open cur;
-- loop
-- fetch cur into rec;
-- exit when not found; 
-- txt := txt||rec.cno||' '||rec.cname||' '||rec.ctype||e'\n';
-- end loop;
-- close cur;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select disInfo(2026);


-- b)
-- create or replace function countComp() returns text as
-- $$
-- declare
-- rec record;
-- txt text := '';
-- cur cursor for select s.*, count(*) from Student s join Student_Competition sc on s.sno = sc.sno group by s.sno order by s.sno;
-- begin
-- open cur;
-- loop
-- fetch cur into rec;
-- exit when not found;
-- txt := txt||rec.sno||' '||rec.sname||' '||rec.sclass||' '||rec.count||e'\n';
-- end loop;
-- close cur;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select countComp();



--                                                    Set E
/*
Car – Driver Database 
Consider the following database:
Car (c_no int, owner varchar(20), model varchar(10), color varchar(10)
Driver (driver_no int, driver_namevarchar(20), license_no int, d_age int, salary float) 
Car and Driver are related with many to many relationship
Create the above database in PostGreSQL and insert sufficient records.
*/

-- create table Car(cno int primary key, owner varchar(20), model varchar(100), color varchar(10));
-- create table Driver (dno int primary key, dname varchar(20), lno int, dage int, salary float);
-- create table Car_Driver(cno int references Car(cno), dno int references Driver(dno));

-- insert into Car values(1, 'Vaibhav', 'Defender', 'black');
-- insert into Car values(2, 'Sanket', 'Defender', 'black');
-- insert into Car values(3, 'Jeet', 'Vitara Breeza', 'white');

-- insert into Driver values(101, 'Vaibhav', 11, 21, 200000);
-- insert into Driver values(102, 'Sanket', 12, 21, 100000);
-- insert into Driver values(103, 'Karan', 13, 21, 20000);

-- insert into Car_Driver values(1, 101);
-- insert into Car_Driver values(2, 102);
-- insert into Car_Driver values(3, 101);

-- a. Write a stored function with cursor which accepts the color and prints the names of all 
-- owners who own a car of that color.
-- b. Write a cursor which accepts the driver name and prints the details of all cars that
-- this driver has driven, if the driver name is invalid, print an appropriate message.


-- a)
-- create or replace function colorMatch(clr varchar(10)) returns text as
-- $$
-- declare 
-- txt text := '';
-- rec record;
-- cur cursor for select owner from Car where color = clr;
-- begin
-- open cur;
-- loop
-- fetch cur into rec;
-- exit when not found;
-- txt := txt||rec||e'\n';
-- end loop;
-- close cur;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select colorMatch('black');


-- b)
-- create or replace function carDetails(dr varchar(10)) returns text as
-- $$
-- declare 
-- txt text := '';
-- rec record;
-- cur cursor for select c.* from Car c join Car_Driver cd on cd.cno = c.cno join Driver d on cd.dno = d.dno where  dname = dr;
-- begin
-- open cur;
-- loop
-- fetch cur into rec;
-- exit when not found;
-- txt := txt||rec||e'\n';
-- end loop;
-- close cur;
-- if txt = '' then
-- raise exception 'Driver Not Found Please Enter Valid Driver Name';
-- end if;
-- return txt;
-- end;
-- $$
-- language 'plpgsql';

-- select carDetails('Vibhav');
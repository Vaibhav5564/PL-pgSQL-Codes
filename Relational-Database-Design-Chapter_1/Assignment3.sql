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
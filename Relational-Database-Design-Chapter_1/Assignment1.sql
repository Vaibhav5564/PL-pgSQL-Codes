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
create table patient(pno int primary key, pname varchar(10), paddr varchar(20));
create table doctor(dno int primary key, dname varchar(20), daddr varchar(20), city varchar(10));
create table doct_pat(pno int references patient(pno) on update cascade on delete cascade, dno int references doctor(dno) on update cascade on delete cascade, disease varchar(20), noOfVisit int);


insert into patient values(101, 'Samadhan', 'Taradgaon');
insert into patient values(102, 'Gayatri', 'Taradgaon');
insert into patient values(103, 'Mrunal', 'Pune');

insert into doctor values(1, 'Vaibhav', 'Malewadi', 'Pune');
insert into doctor values(2, 'Sanket', 'Malewadi', 'Baramati');

insert into doct_pat values(102, 1, 'Cough', 10);
insert into doct_pat values(103, 1, 'Head-Ache', 7);
insert into doct_pat values(101, 2, 'Diabetes', 15);
insert into doct_pat values(101, 1, 'Diabetes', 12);

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


create or replace procedure countVisit(name varchar(10)) as
$$
declare 
sumVisit int := 0;
n int ;
itr record;
begin
select dno into n from doctor where dname = name;
for itr in select noOfVisit from doct_pat where dno = n loop
sumVisit := sumVisit + itr.noOfVisit;
end loop;
if sumVisit = 0 then
raise notice 'No doctor of name %', name;
else
raise notice 'Total Visits of % is %', name, sumVisit;
end if;
end;
$$
language 'plpgsql';

call countVisit('x');

Okay for this
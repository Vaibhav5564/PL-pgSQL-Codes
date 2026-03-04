create table info(name varchar(10), surName varchar(10));
insert into info values('Vaibhav', 'Adsul');
insert into info values('Satyam', 'Adsul');
insert into info values('Sushant', 'Adsul');
insert into info values('Karan', 'Adsul');
insert into info values('Sanket', 'Sul');
insert into info values('Saurabh', 'Sul');

-- create or replace function printName1(n varchar(10)) returns text as
-- $$
-- declare
-- sn varchar(10);
-- begin
-- select surName into sn from info where name = n;
-- return n || ' ' ||sn;
-- end;
-- $$
-- language 'plpgsql';

-- SELECT printName1('Vaibhav');


-- create or replace function printName2(n varchar(10)) returns text as
-- $$
-- declare
-- sn info.surName%type;
-- begin
-- select surName into sn from info where name = n;
-- return n || ' ' || sn;
-- end;
-- $$
-- language 'plpgsql';

-- SELECT printName2('Vaibhav');


-- create or replace function printName3(n varchar(10)) returns text as
-- $$
-- declare 
-- sn info%rowtype;
-- begin
-- select * into sn from info where name = n;
-- return n||' '||sn.surName;
-- end;
-- $$
-- language 'plpgsql';

-- select printName3('Sanket');


-- create or replace function validation(varchar(10), varchar(10)) returns text as 
-- $$
-- declare 
-- input1 alias for $1;
-- input2 alias for $2;
-- s1 varchar(10);
-- s2 varchar(10);
-- begin
-- select name, surName into s1, s2 from info where input1 = name and input2 = surName;
-- if s1 is NULL and s2 is NULL then
-- return input1||' '||input2||' is not present';
-- else
-- return input1||' '||input2||' is present in table';
-- end if;
-- end;
-- $$
-- language 'plpgsql';

-- select validation('Vaibhav', 'Adsul');


-- create or replace function checkNo(n int) returns text as
-- $$
-- begin
-- if n = 0 then
-- return 'Zero';
-- elsif n > 0 then
-- return 'Positive';
-- else
-- return 'Negative';
-- end if;
-- end;
-- $$
-- language 'plpgsql';

-- select checkNo(7) as No_Is;


-- create or replace function caseFun(n varchar(10)) returns text as
-- $$
-- begin
-- case n
-- when 'Vaibhav' then
-- return 'Vaibhav Adsul 7';
-- when 'Satyam' then
-- return 'Satyam Adsul 10';
-- when 'Sushant' then
-- return 'Sushant Adsul 29';
-- when 'Saurabh' then
-- return 'Saurabh Sul 4';
-- when 'Karan' then
-- return 'Karan Adsul 11';
-- when 'Sanket' then
-- return 'Sanket Sul 1';
-- else return 'No Match In Table';
-- end case;
-- end;
-- $$
-- language 'plpgsql';

-- select caseFun('Vaibhav') as check_name;


-- create or replace function result(marks int) returns varchar(4) as 
-- $$
-- begin
-- case 
-- when marks >= 35 and marks <= 100 then 
-- return 'Pass';
-- when marks < 35 and marks >= 0 then
-- return 'Fail';
-- else
-- return 'Invalid Input';
-- end case;
-- end;
-- $$
-- language 'plpgsql';

-- select result(98);


-- create or replace function powerNext50(n int) returns int as 
-- $$
-- begin
-- loop
-- n := n * n;
-- exit when n > 50;
-- end loop;
-- return n;
-- end;
-- $$
-- language 'plpgsql';

-- select powerNext50(5);


-- create or replace function whileLoop(n int) returns int as 
-- $$
-- declare 
-- nSum int;
-- i int;
-- begin
-- nSum := 0;
-- i := 1;
-- while i <= n loop
-- nSum := nSum + i;
-- i := i + 1;
-- end loop;
-- return nSum;
-- end;
-- $$
-- language 'plpgsql';

-- select whileLoop(10);


-- create or replace function forLoop(n int) returns int as 
-- $$
-- declare 
-- sum int ;
-- begin
-- sum := 0;
-- for i in reverse n..1 by 2 loop
-- sum := sum + i;
-- end loop;
-- return sum;
-- end;
-- $$
-- language 'plpgsql';

-- select forLoop(10) as sum_of_even_no_upto_n;



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
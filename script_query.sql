-- CLEANING CUSTOMER TABLE
-- 1. Cleaning Missing Value "Maritalstatus" in Customer Table
delete from customer  
where "Marital Status" = ''

-- 2. Replace value coma to dot in Column "Income"
update customer 
set income = replace(income, ',','.')

-- 3. Change Datatype from varchar to numeric 
alter table customer 
alter column income type numeric using income::numeric

-- CLEANING STORE TABLE
ALTER TABLE store 
  ALTER COLUMN longitude TYPE float8
    USING replace(longitude,',','.')::float8,
  ALTER COLUMN latitude TYPE float8
    USING replace(latitude,',','.')::float8;

-- TASK
-- : Berapa rata-rata umur customer jika dilihat dari marital statusnya ?
select "Marital Status" ,count("Marital Status") total ,avg(age) average
from customer 
group by "Marital Status"

--Berapa rata-rata umur customer jika dilihat dari gender nya ?
select "gender",avg(age) average_age
from customer c 
group by gender


-- Tentukan nama store dengan total quantity terbanyak!
select st.storename, sum(tr.qty) as total_qty
from store as st
left join transaction as tr
on st.storeid = tr.storeid
group by st.storename
order by total_qty desc
limit 3

--Tentukan nama produk terlaris dengan total amount terbanyak!
select pr."Product Name" as best_selling_product, sum(tr.totalamount ) as total_amount
from "transaction" as tr
left join product pr
on tr.productid = pr.productid 
group by best_selling_product
order by total_amount desc
limit 3


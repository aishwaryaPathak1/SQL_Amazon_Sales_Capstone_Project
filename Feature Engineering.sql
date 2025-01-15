-- Feature Engineering:

Alter table sales_data
modify column time TIME;

Alter table sales_data
modify column payment_method VARCHAR(30);

Alter table sales_data
modify column rating Float(3,1);
SELECT * FROM amazon_sales.sales_data;

Alter table sales_data
add column timeofday varchar(30);

set sql_safe_updates=0;

update sales_data
set timeofday = case
when HOUR(time) between 6 and 11 then "Morning"
when HOUR(time) between 12 and 17 then "Afternoon"
else "Evening"
END;

Alter table sales_data
add column dayname varchar(30);

update sales_data
set dayname = dayname(date);

Alter table sales_data
add column monthname varchar(30);

update sales_data
set dayname = date_format(date,'%a');

update sales_data
set monthname = date_format(date,'%b');
-- Approach Used:

-- Data Wrangling:

create table sales_data(
invoice_id VARCHAR(30) NOT NULL,
branch VARCHAR(5) NOT NULL,
city VARCHAR(30) NOT NULL,
customer_type VARCHAR(30) NOT NULL,
gender VARCHAR(10) NOT NULL,
product_line VARCHAR(100) NOT NULL,
unit_price DECIMAL(10, 2) NOT NULL,
quantity INT NOT NULL,
VAT FLOAT(6, 4) NOT NULL,
total DECIMAL(10, 2) NOT NULL,
date DATE NOT NULL,
time TIMESTAMP NOT NULL,
payment_method DECIMAL(10, 2) NOT NULL,
cogs DECIMAL(10, 2) NOT NULL,
gross_margin_percentage FLOAT(11, 9) NOT NULL,
gross_income DECIMAL(10, 2) NOT NULL,
rating FLOAT(2, 1) NOT NULL
);

SELECT * FROM amazon_sales.sales_data;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Amazon.csv' 
INTO TABLE sales_data 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

select * from sales_data 
where invoice_id is NULL;


-- BUSINESS QUESTIONS TO ANSWER:--

-- 1.What is the count of distinct cities in the dataset?
select count(distinct city) as Distinct_city from sales_data;
-- 2.For each branch, what is the corresponding city?
select distinct branch,city from sales_data;
-- 3.What is the count of distinct product lines in the dataset?
select count(distinct product_line) as Distinct_productlines from sales_data;
-- 4.Which payment method occurs most frequently?
select payment_method,count(payment_method) as frequency from sales_data
group by payment_method
order by frequency desc
limit 1;
-- 5.Which product line has the highest sales?
select product_line,sum(total) as Total_sales from sales_data
group by product_line 
order by Total_sales desc
limit 1;



-- 6.How much revenue is generated each month?
select monthname,sum(total) as Revenue from sales_data 
group by monthname
order by field(monthname,'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
-- 7.In which month did the cost of goods sold reach its peak?
select monthname,sum(cogs) as total_cogs from sales_data
group by monthname
order by total_cogs desc
limit 1;
-- 8.Which product line generated the highest revenue?
select product_line,sum(VAT) as revenue from sales_data
group by product_line
order by revenue desc
limit 1;
-- 9.In which city was the highest revenue recorded?
select city,sum(total) as total_revenue from sales_data 
group by city 
order by total_revenue desc
limit 1;
-- 10.Which product line incurred the highest Value Added Tax?
select product_line,sum(VAT) as total_VAT from sales_data
group by product_line
order by total_VAT desc
limit 1;
-- 11.For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
select product_line,sum(total) as total_sales,
case
when total>(select avg(total_sales) from 
(select product_line,sum(total) as total_sales from sales_data
group by product_line) as subquery)
then "Good"
else "Bad"
end as sales_quality
from sales_data
group by product_line;
-- 12.Identify the branch that exceeded the average number of products sold.
select branch,sum(quantity) as total_quantity from sales_data 
group by branch 
having total_quantity>(select avg(total_quantity) from 
(select branch,sum(quantity) as total_quantity from sales_data 
group by branch) as subquery);
-- 13.Which product line is most frequently associated with each gender?
WITH product_line_counts AS (
    SELECT 
        gender, 
        product_line, 
        COUNT(*) AS purchase_count
    FROM 
        sales_data
    GROUP BY 
        gender, product_line
),

ranked_product_lines AS (
    SELECT 
        gender, 
        product_line, 
        purchase_count,
        -- Rank the product lines for each gender by purchase count
        RANK() OVER (PARTITION BY gender ORDER BY purchase_count DESC) AS ranking
    FROM 
        product_line_counts
)
SELECT 
    gender, 
    product_line, 
    purchase_count 
FROM 
    ranked_product_lines 
WHERE 
    ranking = 1;
-- 14.Calculate the average rating for each product line.
select product_line,round(avg(rating),2) as avg_rating from sales_data
group by product_line;
-- 15.Count the sales occurrences for each time of day on every weekday.
select dayname,timeofday,count(*) as sales_count from sales_data
group by dayname,timeofday
order by field(dayname,"Mon","Tue","Wed","Thu","Fri","Sat","Sun"),
field(timeofday,"Morning","Afternoon","Evening");
-- 16.Identify the customer type contributing the highest revenue.
select customer_type,sum(total) as revenue from sales_data
group by customer_type
order by revenue desc
limit 1;
-- 17.Determine the city with the highest VAT percentage.
select city,(sum(VAT)/sum(total))*100 as VAT_percentage from sales_data
group by city 
order by VAT_percentage desc
limit 1;
-- 18.Identify the customer type with the highest VAT payments.
select customer_type,sum(VAT) as total_VAT from sales_data 
group by customer_type 
order by total_VAT desc
limit 1;
-- 19.What is the count of distinct customer types in the dataset?
select count(distinct customer_type) as count_customer_type from sales_data;
-- 20.What is the count of distinct payment methods in the dataset?
select count(distinct payment_method) as count_payment_method from sales_data;
-- 21.Which customer type occurs most frequently?
select customer_type,count(customer_type) as frequency from sales_data
group by customer_type
order by frequency desc
limit 1;
-- 22.Identify the customer type with the highest purchase frequency.
select customer_type,count(*) as purchase_frequency from sales_data
group by customer_type 
order by purchase_frequency desc
limit 1;
-- 23.Determine the predominant gender among customers.
select gender,count(*) as gender_count from sales_data 
group by gender 
order by gender_count desc
limit 1;

-- 24.Examine the distribution of genders within each branch.
select branch,gender,count(*) as gender_count from sales_data 
group by branch,gender 
order by branch,gender_count desc;
-- 25.Identify the time of day when customers provide the most ratings.
select timeofday,avg(rating) as avg_rating from sales_data 
group by timeofday 
order by avg_rating desc
limit 1;

-- 26.Determine the time of day with the highest customer ratings for each branch.
with mycte as(
select branch,timeofday,avg(rating) as avg_rating,
rank() over(partition by branch order by avg(rating) desc) as rank_rating from sales_data 
group by branch,timeofday )

select branch,timeofday,avg_rating from mycte 
where rank_rating=1;
-- 27.Identify the day of the week with the highest average ratings.
select dayname,avg(rating) as avg_rating from sales_data
group by dayname 
order by avg_rating desc
limit 1;
-- 28.Determine the day of the week with the highest average ratings for each branch.
with mycte as(
select branch,dayname,avg(rating) as avg_rating,
rank() over(partition by branch order by avg(rating) desc) as rank_rating from sales_data
group by branch,dayname)
select branch,dayname,avg_rating from mycte 
where rank_rating=1;






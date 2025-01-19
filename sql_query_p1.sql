-- SQL retail sales ananylsis - P1
create database sql_project_p2;


-- CREATING A TABLE
DROP TABLE IF EXISTS RETAIL_SALES;
CREATE TABLE RETAIL_SALES(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category VARCHAR(15),
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);

SELECT * FROM RETAIL_SALES
LIMIT 10;

SELECT COUNT(*) FROM RETAIL_SALES


--DATA CLEANING

--THIS CODE WILL SHOW IF ANY ROW IS NULL
SELECT * FROM RETAIL_SALES WHERE TRANSACTIONS_ID IS NULL;
-- AS YOU CAN SEE THE RESULT GETS EMPTY ROWS MEANING WE DONT HAVE ANY RECORDS WHERE THIS TRANSACTION_ID IS NULL

--NOW TO CHECK IF SALE_DATE HAS ANY NULL VALUES
SELECT * FROM RETAIL_sALES WHERE SALE_DATE IS NULL;

--WE NEED TO CHECK ALL THE COLUMNS, THERE IS A WAY TO WRITE ONE CODE TO CHECK INSTEAD OF CHECKING ALL THE COLUMNS INDIVIDUALLY
SELECT * FROM RETAIL_SALES
WHERE
	transactions_id is NULL
	or
	sale_date is NULL
	or
	sale_time is NULL
	or
	customer_id is NULL
	or
	category is NULL
	or
	quantity is NULL
	or 
	cogs is NULL
	or 
	total_sale is NULL;


--we can either delete or replace the values, lets delete them
DELETE FROM RETAIL_SALES
WHERE 
transactions_id is NULL
	or
	sale_date is NULL
	or
	sale_time is NULL
	or
	customer_id is NULL
	or
	category is NULL
	or
	quantity is NULL
	or 
	cogs is NULL
	or 
	total_sale is NULL;
	
--LETS CHECK HOW MANY RECORDS WE ARE LEFT WITH
select count(*) from retail_sales;



--DATA EXPLORATION

--How many sales do we have?
select count(*) as total_sale from retail_sales

--How many customers do we have? we may have duplicate records, so use DISTINCT to get the unique customer
select count(distinct customer_id) as total_sale from retail_sales

-- how many unique categories do we have?
select count(distinct category) as total_sale from retail_sales

--lets say we want not the count but the names of the distinct category
select distinct category from retail_sales



 --LETS DO REAL DATA ANALYSIS NOW
 --KEY PROBLEMS AND ANSWERS
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * 
from retail_sales 
where sale_date='2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select 
*
from retail_sales
where category = 'Clothing' 
 	and 
	TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
	AND 
	quantity>=4


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
	CATEGORY,
	SUM(TOTAL_SALE) AS NET_SALE,
	COUNT (*) AS TOTAL_ORDERS
FROM RETAIL_SALES
GROUP BY 1

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
	 round(avg(age),2) 
FROM RETAIL_SALES
WHERE CATEGORY = 'Beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales where total_sale>1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select 
category,
gender,
count(*) as total_trans
from retail_sales
group by 1,2
order by 1

--IMPORTANT QUESTION #7
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select 
year,
month,
avg_sale

from
(
select 
extract (year from sale_date) as year,
extract (month from sale_date) as month, 
avg(total_sale) as avg_sale,
Rank() over(partition by extract (year from sale_date) order by avg(total_sale) desc) as rank
from retail_sales
group by 1,2
) as t1
where  rank =1


--order by 1,3 desc



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

--WE HAVE CUSTOMER_ID, LETS TAKE IT AND SEE WHICH CUSTOMER HAS HAD THE HIGHEST SALE FROM THE TOTAL_SALE
SELECT
	CUSTOMER_ID,
	SUM(TOTAL_SALE) AS TOTAL_SALES
FROM RETAIL_SALES
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 5


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
	COUNT(DISTINCT CUSTOMER_ID),
	CATEGORY
FROM RETAIL_SALES
GROUP BY 2


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT * FROM RETAIL_SALES



































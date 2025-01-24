-- Project fo Retail Sales Analysis
-- CREATE TABLE 
CREATE TABLE Sales_Analysis(
transactions_id INT PRIMARY KEY,
sale_date DATE ,
sale_time TIME ,
customer_id INT ,
gender VARCHAR(10),

age	INT,
category VARCHAR(15),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT);

SELECT * FROM Sales_Analysis ;
 UPDATE Sales_Analysis 
 SET age = 26
 Where age IS NULL;
 SELECT * FROM Sales_Analysis;

SELECT COUNT(transactions_id) from Sales_Analysis; 

SELECT * FROM Sales_Analysis 
WHERE transactions_id IS NULL
OR sale_date IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR quantiy IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale IS NULL;


-- DATA CLEANING PROCESS

DELETE FROM Sales_Analysis
WHERE transactions_id IS NULL
OR sale_date IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR quantiy IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale IS NULL;

SELECT * FROM Sales_Analysis;


-- How many sales we did
Select Count(transactions_id) as total_sale_orders from Sales_Analysis;

-- How many unique customers we have?
Select count( DISTINCT customer_id) as Total_customers from Sales_analysis;

-- How many distinct category we have?
Select count(  DISTINCT Category) as Total_customers from Sales_analysis;

SELECT count(CATEGORY),CATEGORY FROM SALES_ANALYSIS
GROUP BY CATEGORY;

-- Data Aanalysis and business key problems and answers
-- Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM Sales_Analysis where sale_date = '2022-11-05';


-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
-- the quantity sold is more than 4 in the month of Nov-2022:

SELECT category, quantiy, sale_date FROM Sales_Analysis
WHERE 
CATEGORY = 'Clothing'
AND 
quantiy >=4
AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
	
-- Write a SQL query to calculate the total sales (total_sale) for each category.:
Select category,sum(total_sale) as grand_sales from Sales_Analysis
group by Category;

-- Write a SQL query to find the average age of customers
-- who purchased items from the 'Beauty' category.:

Select age from Sales_Analysis 
where category = 'Beauty' ;

select round(avg(age)) as Average_age from(Select age from Sales_Analysis 
where category = 'Beauty');

-- or

select round(avg(age),2) from Sales_analysis
where category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select transactions_id,customer_id,total_sale from Sales_analysis 
where total_sale >=1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select count(transactions_id) , gender,category from sales_analysis 
group by category, gender;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select  TO_CHAR(sale_date, 'YYYY-MM')as Years,avg(total_sale) as Sales from sales_analysis
group by TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY Sales DESC
LIMIT 1;

OR

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM sales_analysis
GROUP BY 1, 2
) as t1
WHERE rank = 1;


-- Write a SQL query to find the top 5 customers based on the highest total sales

Select customer_id , sum(total_sale) as Sales from Sales_analysis
group by customer_id
ORDER BY Sales DESC
LIMIT 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT category , count(DISTINCT customer_id) from Sales_Analysis 
GROUP BY Category;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):


-- To make required  column in table through this method

SELECT *,
CASE
WHEN EXTRACT(HOUR FROM SALE_TIME)<12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM SALE_TIME)between 12 AND 17 THEN 'Afternooon'
ELSE 'EVENING'
END AS shift
FROM SALES_ANALYSIS AS T1;

SELECT SHIFT,Count(transactions_id) as orders from (SELECT *,
CASE
WHEN EXTRACT(HOUR FROM SALE_TIME)<12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM SALE_TIME)between 12 AND 17 THEN 'Afternooon'
ELSE 'EVENING'
END AS shift
FROM SALES_ANALYSIS AS T1) 
GROUP BY SHIFT
ORDER BY orders DESC;











































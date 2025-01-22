-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project_p2;

-- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

SELECT * FROM retail_sales
where 
      transaction_id is null
or 
sale_date is null
or
gender is null
or 
category is null
or 
quantity is null
or 
cogs is null
or 
total_sale is null:

-- data exploration-- 

-- how many sales we have-- 
select count(*) as total_sle from retail_sales

 -- how many customers we have-- 
 select count( distinct customer_id) 
       from retail_sales
       
--  how many categories we have--
select distinct category from retail_sales       

-- main data analysis and business key problems and answers-- 

-- Q.1 write a sql query to retrieve all columns for sales made on "2022-11-05"-- 
-- Q.2 Write a sql query to retrieve all transactions where the category is "clothing" and the quantity sold is more than 10 in the month of nov-2022.
-- Q.3 Write a sql query to calculate the total sales (total_sale) for each category.  
-- Q.4 Write a sql query to  find the average age of customers who purchased items from the "beauty" category. 
-- Q.5 Write a sql query to find all transactions where the total_sale is greater is than 1000.
-- Q.6 Write a sql query to find the total number of transactions(transaction_id) made by each gender in each category.
-- Q.7 Write a sql query to calculate the average sale for each month. find out best selling month in each year.
-- Q.8 Write a sql query to find the top 5 customers based in the highest total sales.
-- Q.9 Write a sql query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a sql query to create each shift and number of orders (Example Morning <=12 ,Afternoon between 12 and 17, Evening >=17)

-- Q.2 Write a sql query to retrieve all transactions where the category is "clothing" and the quantity sold is more than 10 in the month of nov-2022.
select *
       from retail_sales   
       where category = "clothing"
       and date_format(sale_date,'%M-%Y') =  "NOVEMBER-2022"
       AND quantity>=4
       
       
-- Q.3 Write a sql query to calculate the total sales (total_sale) for each category. 

select category,
       sum(total_sale) as total_sales
 from retail_sales
 group by category


-- Q.4 Write a sql query to  find the average age of customers who purchased items from the "beauty" category. 
select round(avg(age),0) as average_age
       from retail_sales
       where category = "beauty"
       
-- Q.5 Write a sql query to find all transactions where the total_sale is greater is than 1000.  
   select * 
   from retail_sales
   where (total_sale)>1000
          
-- Q.6 Write a sql query to find the total number of transactions(transaction_id) made by each gender in each category.
        
        select count(*)as total_trans,
			   gender,
               category
		 from retail_sales
		 group by category,gender
               
-- Q.7 Write a sql query to calculate the average sale for each month. find out best selling month in each year.
 with RankedSales as (
 select  
        year(sale_date) as year,
        month(sale_date) as month,
        round(avg(total_sale), 2) as avg_sale,
        rank() over (
            partition by year(sale_date) 
	order by avg(total_sale) desc
        ) as rnk
    from retail_sales
    group by year(sale_date), month(sale_date)
)
select *
from RankedSales
where rnk = 1;

-- Q.8 Write a sql query to find the top 5 customers based in the highest total sales.
select customer_id,
	   sum(total_sale) as sale_per_cust
 from retail_sales
 group by customer_id
 order by sale_per_cust desc
 limit 5
      
-- Q.9 Write a sql query to find the number of unique customers who purchased items from each category.

select   
	  category,
	  count(distinct customer_id) as unique_customer
 from retail_sales    
 group by category


-- Q.10 Write a sql query to create each shift and number of orders (Example Morning <=12 ,Afternoon between 12 and 17, Evening >=17)
with hourly_sale
as
(  
select *,
      case when hour(sale_time) <=12 then "Morning" 
		   when hour(sale_time) between 12 and 17 then "Afternoon" 
		   Else "evening"
	  End as shift
from retail_sales
)
select shift, 
	   count(*) as total_orders 
from hourly_sale
group by shift      


-- End of project


       
              
        
   

 

   
         
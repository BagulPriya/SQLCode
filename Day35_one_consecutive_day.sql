use hundred_days_sql
-- Day 35/100 days 


-- Create Sales Table
DROP TABLE IF EXISTS sales;
CREATE TABLE Sales4(
    SaleID INT PRIMARY KEY,
    ProductID INT,
    SaleDate DATE,
    Quantity INT
);

-- Insert records into Sales Table
INSERT INTO Sales4 (SaleID, ProductID, SaleDate, Quantity) VALUES
(1, 1, '2024-01-01', 100),  
(2, 1, '2024-01-02', 200), 
(3, 1, '2024-01-04', 150),  
(4, 2, '2024-01-03', 50),   
(5, 2, '2024-01-04', 75),   
(6, 3, '2024-01-05', 300), 
(7, 3, '2024-01-07', 250);

/*
Problem: Find the Products with Sales on Consecutive Days
You are given a sales table with records of sales for each product. 

Write a query to find all products that were sold on consecutive days at least once. 
Return the ProductID and the first date in each pair of consecutive sales days.
*/

select * from Sales4
with cte 
as
(
select 
   s1.SaleID,
   s1.ProductID,
   s1.SaleDate as first_sale_date,
   s2.SaleDate as Second_sale_date
from sales4 as s1
join  sales4 as s2
on s2.ProductID=s1.ProductID
where DATEDIFF(DAY,s1.SaleDate,s2.SaleDate)=1
)
SELECT 
	ProductID,
	first_sale_date
FROM cte


---anther apporach
WITH ConsecutiveSales AS (
    SELECT 
        ProductID,
        SaleDate,
        LEAD(SaleDate) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS NextSaleDate
    FROM Sales4
)
SELECT 
    ProductID,
    SaleDate
FROM ConsecutiveSales
WHERE DATEDIFF(day, SaleDate, NextSaleDate) = 1;

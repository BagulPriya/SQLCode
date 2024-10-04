SELECT TOP (1000) [id]
      ,[sale_date]
      ,[sale_amount]
  FROM [Hundred_days_sql].[dbo].[sales3]

  SELECT * ,select 
   DATEPART(Week,sale_date) as week_noFROM sales3;


-- -- Question:
-- You have a table of daily sales data of Amazon. Write a query to:
-- Find the total sales for each weekend day (Saturday and Sunday) in July 2024.

 select
	DATEPART(ISO_WEEK,sale_date) as week_no,
    sum(sale_amount) as total_sale
from sales3
where sale_date between '07-01-2024' and '07-31-2024'
      AND DATEPART(weekday,sale_date) In (1,7)
group by  
	DATEPART(ISO_WEEK,sale_date)
   


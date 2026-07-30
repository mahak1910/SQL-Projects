select  * FROM DecathlonSales;
--Total Orders
SELECT COUNT(*) AS Totalorder
from DecathlonSales;

--Total Revenue
SELECT SUM(Sales_Amount) AS TotalRevenue
from DecathlonSales;

--Total Profit
select sum(Profit) as Totalprofit
from DecathlonSales;

--Average Order Value
select AVG(Sales_Amount) as AvgOrderValue
from DecathlonSales;
 
--top 10 products
select top 10 product_name ,
sum(sales_amount) as revenue 
from DecathlonSales group by Product_Name order by revenue desc;

--Sales by Category
select Product_Category,sum(sales_amount) as revenue from DecathlonSales group by Product_Category order by revenue desc;

--Sales by City
select City , sum(sales_amount) as revenue from DecathlonSales group by City order by revenue desc;

--Highest Spending Customers
select top 10 Customer_Name,sum(sales_amount) as revenue  from DecathlonSales group by Customer_Name order by revenue desc;

--Monthly Sales Trend
SELECT
YEAR(Order_Date) AS Year,
MONTH(Order_Date) AS Month,
SUM(Sales_Amount) AS Revenue
FROM DecathlonSales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

--Sales After Discount
select avg(Discount_Amount)as AvgDiscount,sum
(Profit)as TotalProfit from DecathlonSales;

--Rank Products
select 
Product_Name,
sum(sales_amount)as revenue,
rank() over (order by sum(sales_amount) desc)as ProductRank
from DecathlonSales
group by Product_Name;

--Running Total
select 
Order_Date,
Sales_Amount,
sum(Sales_Amount) over(order by order_date) as RunningSales
from DecathlonSales;

--
WITH ProductSales AS
(
SELECT
Product_Category,
Product_Name,
SUM(Sales_Amount) AS Revenue,
ROW_NUMBER() OVER
(
PARTITION BY Product_Category
ORDER BY SUM(Sales_amount) DESC
) AS rn
FROM DecathlonSales
GROUP BY Product_Category, Product_Name
)

SELECT *
FROM Productsales
WHERE rn=1;



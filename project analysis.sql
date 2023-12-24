/*************************Task 1: Data Exploration and Cleaning*************************/
-- 1. Load the dataset into a SQL database and examine its structure.
-- Data has been loaded, now I'll examine the structure
-- structure of Geo table
SELECT COUNT(*) number_of_rows,   'Geo_table' as 'table' from geo  /*6 rows*/

-- structure of people table
SELECT COUNT(*) number_of_rows,   'people_table' as 'table' from people  /*33 rows*/

-- structure of products table
SELECT COUNT(*) number_of_rows,   'products_table' as 'table' from products  /*22 rows*/

-- structure of sales table
SELECT COUNT(*) number_of_rows,   'sales_table' as 'table' from sales  /*7617 rows*/
select*from people


-- 2.  -- CHECKING MISSING OR NULL VALUES 
-- Geo table 
SELECT count(*) FROM geo
WHERE GeoID IS NULL OR GeoID=' '
OR Geo IS NULL OR Geo =''
OR Region IS NULL OR Region = ''
-- No null values found in Geo table

-- people table 
SELECT count(*) FROM people
WHERE Sales_Person IS NULL OR Sales_person=' '
OR Team IS NULL OR Team=''
OR Location IS NULL OR Location = ''
--There are 5 NULL in the team column, but they will not affect the analysis results, so I will not remove them

-- structure of products table
SELECT count(*) FROM products
WHERE Product_ID IS NULL OR Product_ID=' '
OR Product IS NULL OR Product =''
OR Category IS NULL OR Category = ''
OR Size IS NULL OR Size = ''
OR Cost_per_Box IS NULL OR Cost_per_Box = ''
-- No null values found in prpducts table

--sales table
SELECT count(*) FROM sales 
WHERE Sales_Person IS NULL OR Sales_Person=' '
OR Geo IS NULL OR Geo =''
OR Product IS NULL OR Product=''
OR Date IS NULL OR Date = ''
OR Customers IS NULL OR Customers = ''
-- No null values found in sales table

/***************************** Data Analysis*****************************/
-- 1. Number of category : Here I am creating VIEW to use it in visualization in Power BI.
select count (DISTINCT Category) from products /*3 Category (Bites,Bars,Other)*/

--2.Number for each category
select count ( Category) from products
where Category = 'Bites' /*The total number of Bites category is 7 */

select count ( Category) from products
where Category = 'Bars' /*The total number of Bites category is 11 */

select count ( Category) from products
where Category = 'Other' /*The total number of Bites category is 4 */

--3.See the date, amount and boxes for each day of the week
select date,Amount,Boxes,datename(WEEKDAY,Date) as 'week of day'
from sales
select*from sales

--4. what day most operations occur
SELECT TOP 1
       COUNT(*) AS CountOccurrences,
       CAST(Date AS DATE) AS OccurrenceDate,
	   datename(WEEKDAY,Date) as 'week of day'
FROM   sales
GROUP BY CAST(Date AS DATE),datename(WEEKDAY,Date)
ORDER BY CountOccurrences DESC; /*Number of operations:63 وTop day: Friday*/

--5.TotalL of Number top 5  boxes for each product
select TOP 5 sum (Boxes) AS TotalBOXES ,sales.Product as Product_ID,products.product 
from sales
inner join products on sales.Product = products.Product_ID 
group by sales.Product ,products.product
order by TotalBOXES desc /*1:Orange Choco,2:White Choc,3:Organic Choco Syrup,4:Manuka Honey Choco,5:Eclairs  */


--6. How many times we shipped more than 1,000 boxes in each month?
select year(date) 'Year', month(date) 'Month', count(*) 'Times we shipped 1k boxes'
from sales
where boxes>1000
group by year(Date), month(Date)
order by year(Date), month(Date);

-- After creating that I imported the views to Power BI for visualisation
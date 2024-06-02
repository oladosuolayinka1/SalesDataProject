Select *
From Sales_Data

-- How to add week/month to a table
Alter Table Sale_Data
Add Weekk int

update sales_Data
Set Weekk = DATENAME(weekday, transaction_date)

--OR
Alter Table Sales_Data
Add Week_No int

update sales_Data
Set Week_No = DATEPART(weekday, transaction_date)



--how have Maven Roasters sales trended over time?
Select 
	[MONTH], Round(Sum(Transaction_qty*Unit_Price),0) As Total_Sale 
From
	Sales_Data
Group By 
	[Month], [Month_No]
Order By 
	[Month_No]

Alter Table Sales_Data
Add Month_No int
Update Sales_Data
Set Month_No = case
				When [Month] = 'Jan' Then 1
				When [Month] = 'Feb' Then 2
				When [Month] = 'Mar' Then 3
				When [Month] = 'Apr' Then 4
				When [Month] = 'May' Then 5
				When [Month] = 'Jun' Then 6
				End
-- which days of the week tend to be busiest, and why do yo think that's the case?
Select [Week], Round(Sum(Transaction_qty*Unit_Price),0) As Total_Sale 

From Sales_Data 

Group by [Week], Week_No
Order by Week_No

Alter Table Sales_Data
Add Week_No int
Update Sales_Data
Set Week_No = case
				When [Week] = 'Sunday' Then 1
				When [Week] = 'Monday' Then 2
				When [Week] = 'Tuesday' Then 3
				When [Week] = 'Wednesday' Then 4
				When [Week] = 'Thursday' Then 5
				When [Week] = 'Friday' Then 6
				When [Week] = 'Saturday' Then 7
	
End

-- Which products are sold most and least often? Which drive the most revenue for the business?
select Top 5 *
From Sales_Data

-- Top 5 Product Sold
Select Top 5 product_type, Sum(Transaction_qty) As Total_Quantity_Sold
From Sales_Data
Group By product_type
Order By Sum(Transaction_qty) Desc

-- Bottom 5 Product Sold
Select top 5 product_type, Sum(Transaction_qty) As Total_Quantity_Sold
From Sales_Data
Group By product_type
Order By Sum(Transaction_qty) 

-- Which Drive the Most Reveue for the business
Select Top 5 product_type, product_category, Round(Sum(Transaction_qty*unit_price),0) As Total_Sales
From Sales_Data
Group By product_type, product_category
order by Total_Sales Desc

-- Total Revenue by Month  
Shows total sales revenue for each month and year.  

SELECT 
    YEAR(OrderDate) AS Year,
    MONTH(OrderDate) AS Month,
    SUM(TotalDue) AS TotalRevenue
FROM Cleaned_Data
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Year, Month;

-- Top 10 Products by Total Revenue
SELECT 
    ProductName,
    SUM(OrderQty) AS TotalQuantitySold,
    SUM(TotalDue) AS TotalRevenue
FROM Cleaned_Data
GROUP BY ProductName
ORDER BY TotalRevenue DESC
LIMIT 10;

-- Sales KPIs (Orders, Revenue, AOV)
SELECT 
    COUNT(DISTINCT SalesOrderID) AS TotalOrders,
    SUM(TotalDue) AS TotalRevenue,
    ROUND(SUM(TotalDue) / COUNT(DISTINCT SalesOrderID), 2) AS AverageOrderValue
FROM Cleaned_Data;

-- Revenue and Average Order Quantity by Product
SELECT 
    ProductName,
    SUM(OrderQty) AS TotalUnitsSold,
    SUM(TotalDue) AS TotalRevenue,
    ROUND(AVG(OrderQty), 2) AS AvgOrderQty
FROM Cleaned_Data
GROUP BY ProductName
ORDER BY TotalRevenue DESC;

-- Sales by Order Status
SELECT 
    [OrderStatus.Order Status] AS OrderStatus,
    COUNT(SalesOrderID) AS TotalOrders,
    SUM(TotalDue) AS TotalRevenue
FROM Cleaned_Data
GROUP BY [OrderStatus.Order Status]
ORDER BY TotalRevenue DESC;

-- Daily Revenue Trend
SELECT 
    OrderDate,
    SUM(TotalDue) AS DailyRevenue
FROM Cleaned_Data
GROUP BY OrderDate
ORDER BY OrderDate;

-- Average Delivery Time by Status
SELECT 
    [OrderStatus.Order Status] AS OrderStatus,
    ROUND(AVG(DATEDIFF(DAY, OrderDate, ShipDate)), 2) AS AvgDaysToShip
FROM Cleaned_Data
WHERE ShipDate IS NOT NULL
GROUP BY [OrderStatus.Order Status]
ORDER BY AvgDaysToShip;

-- Average Freight Cost by Year
SELECT 
    YEAR(OrderDate) AS Year,
    ROUND(AVG(Freight), 2) AS AvgFreightCost,
    ROUND(SUM(Freight), 2) AS TotalFreight
FROM Cleaned_Data
GROUP BY YEAR(OrderDate)
ORDER BY Year;

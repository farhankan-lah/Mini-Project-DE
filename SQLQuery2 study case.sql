--1 trend penjualan
SELECT 
    MONTH(O.OrderDate) as Bulan,
    P.ProductName, 
    C.CompanyName as CustomerName, 
    CA.CategoryName as JenisProduk,
    SUM(OD.UnitPrice*OD.Quantity) as TotalPenjualan
FROM [Order Details] OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN [Categories] CA ON P.CategoryID = CA.CategoryID
GROUP BY MONTH(O.OrderDate), P.ProductName, C.CompanyName, CA.CategoryName
ORDER BY MONTH(O.OrderDate), TotalPenjualan DESC

--2 stock
SELECT 
    C.City as KotaTujuan,
    S.CompanyName as Shipper,
    COUNT(O.OrderID) as JumlahOrder
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Shippers S ON O.ShipVia = S.ShipperID
GROUP BY C.City, S.CompanyName
ORDER BY JumlahOrder DESC

--3 
SELECT 
    ProductName, 
    UnitsInStock,
    ReorderLevel
FROM Products
WHERE UnitsInStock <= ReorderLevel

--3B
SELECT 
    S.CompanyName as Supplier, 
    SUM(OD.UnitPrice*OD.Quantity) as TotalSales
FROM [Order Details] OD
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE 
P.ProductName = 'Geitost'
GROUP BY S.CompanyName
ORDER BY TotalSales DESC

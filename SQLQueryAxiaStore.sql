CREATE DATABASE [AxiaStores]; --SQL Server

CREATE TABLE CustomerTB
(CustomerID INT PRIMARY KEY,
FirstName VARCHAR (255),
LastName VARCHAR (255),
Email VARCHAR (255),
Phone VARCHAR (50),
City VARCHAR (100));
INSERT INTO CustomerTB (CustomerID, FirstName, LastName, Email, Phone, City)
VALUES
(1, 'Musa', 'Ahmed', 'musa.ahmed@hotmail.com', '0803‑123‑0001', 'Lagos'),
('2', 'Ray', 'Samson', 'ray.samson@yahoo.com', '0803‑123‑0002', 'Ibadan'),
('3', 'Chinedu', 'Okafor', 'chinedu.ok@yahoo.com', '0803‑123‑0003', 'Enugu'),
('4', 'Dare', 'Adewale', 'dare.ad@hotmail.com', '0803‑123‑0004', 'Abuja'),
('5', 'Efe', 'Ojo', 'efe.oj@gmail.com', '0803‑123‑0005', 'Port Harcourt'),
('6', 'Aisha', 'Bello', 'aisha.bello@hotmail.com', '0803‑123‑0006', 'Kano'),
('7', 'Tunde', 'Salami', 'tunde.salami@yahoo.com', '0803‑123‑0007', 'Ilorin'),
('8', 'Nneka', 'Umeh', 'nneka.umeh@gmail.com', '0803‑123‑0008', 'Owerri'),
('9', 'Kelvin', 'Peters', 'kelvin.peters@hotmail.com', '0803‑123‑0009', 'Asaba'),
('10', 'Blessing', 'Mark', 'Blessing.mark@gmail.com', '0803‑123‑0010', 'Uyo');

CREATE TABLE ProductTB
(ProductID INT PRIMARY KEY,
ProductName VARCHAR (255),
Category VARCHAR (50),
UnitPrice DECIMAL (10,0),
StockQty INT);

INSERT INTO ProductTB (ProductID, ProductName, Category, UnitPrice, StockQty)
VALUES
('1', 'Wireless Mouse', 'Accessories', '7500', '120'),
('2', 'USB-C Charger 65W', 'Electronics', '14500', '75'),
('3', 'Noise‑Cancel Headset', 'Audio', '85500', '50'),
('4', '27" 4K Monitor', 'Displays', '185000', '20'),
('5', 'Laptop Stand', 'Accessories', '19500', '90'),
('6', 'Bluetooth Speaker', 'Audio', '52000', '60'),
('7', 'Mechanical Keyboard', 'Accessories', '18500', '40'),
('8', 'WebCam 1080p', 'Electronics', '25000', '55'),
('9', 'Smartwatch Series 5', 'Wearables', '320000', '30'),
('10', 'Portable SSD 1TB', 'Storage', '125000', '35');


CREATE TABLE OrdersTB
(OrderID INT PRIMARY KEY,
CustomerID INT,
ProductID INT,
OrderDate DATE,
Quantity INT,
FOREIGN KEY (CustomerID) REFERENCES CustomerTB(CustomerID),
FOREIGN KEY (ProductID) REFERENCES ProductTB(ProductID));
INSERT INTO OrdersTB(OrderID, CustomerID, ProductID, OrderDate, Quantity)
VALUES
('1001', '1', '3', '2025‑06‑01', '1'),
('1002', '2', '1', '2025‑06‑03', '2'),
('1003', '3', '5', '2025‑06‑05', '1'),
('1004', '4', '4', '2025‑06‑10', '1'),
('1005', '5', '2', '2025‑06‑12', '3'),
('1006', '6', '7', '2025‑06‑15', '1'),
('1007', '7', '6', '2025‑06‑18', '2'),
('1008', '8', '8', '2025‑06‑20', '1'),
('1009', '9', '9', '2025‑06‑22', '1'),
('1010', '10', '10', '2025‑06‑25', '2');


--Return the FirstName and Email of every customer who has ever purchased the product “Wireless Mouse”
select c.firstname, c.email from customertb c
join OrdersTB o on c.CustomerID = o.CustomerID
join ProductTB p on o.ProductID = p.ProductID
where p.ProductID=1


--List all customers’ full names in ascending alphabetical order (LastName, then FirstName)
SELECT FirstName, LastName
FROM CustomerTB
ORDER BY LastName ASC, FirstName ASC;


--Show every order together with the customer’s full name, the product name, quantity, unit price, total price (quantity × unit price), and order date.
select 
c.FirstName, 
c.LastName,
p.productname, 
o.quantity, 
p.unitprice,  
sum (p.unitprice * o.quantity) as 'total price'
from CustomerTB c
join orderstb o on c.customerid = c.customerid
join producttb p on o.productid = p.productid
GROUP BY 
    c.FirstName, c.LastName, p.ProductName, o.Quantity,p.UnitPrice;


--Show average sales per product category and sort in descending order
SELECT 
    p.Category,
    AVG(o.Quantity) AS AverageSales
FROM ProductTB p
JOIN OrdersTB o ON p.ProductID = o.ProductID
GROUP BY p.Category
ORDER BY AverageSales DESC;


--Which city generated the highest revenue for AxiaStores?
SELECT 
    c.City,
    SUM(p.UnitPrice) AS TotalUnitPrice,
    SUM(o.Quantity) AS TotalQuantity,
    SUM(p.UnitPrice * o.Quantity) AS TotalRevenue
FROM 
    CustomerTB c
JOIN 
    OrdersTB o ON c.CustomerID = o.CustomerID
JOIN 
    ProductTB p ON o.ProductID = p.ProductID
GROUP BY 
    c.City
ORDER BY 
    TotalRevenue DESC;

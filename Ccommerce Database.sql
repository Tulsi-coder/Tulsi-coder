/* create an e-commerce database*/
CREATE DATABASE CcommerceDB;
SHOW DATABASES;
USE CcommerceDB;


# CUSTOMERS TABLE
CREATE TABLE Customers (
Customer_id INT PRIMARY KEY Auto_Increment,
name VARCHAR (100),
email VARCHAR (100) UNIQUE,
CITY VARCHAR (100)
);

SHOW TABLES;

#Orders Table
CREATE TABLE Orders (
order_id INT PRIMARY KEY Auto_Increment,
Customer_id INT,
order_date DATE,
total_amount Decimal (10,2),
FOREIGN key(customer_id) references Customers (customer_id)
);

# Products Table 
CREATE TABLE Products(
product_id INT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(100),
category VARCHAR(50),
price DECIMAL(10,2)
);

# Order_Items Table
CREATE TABLE Order_Items  (
item_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT,
product_id INT,
quantity INT,
price DECIMAL(10,2),
FOREIGN KEY(order_id) REFERENCES Orders(Order_id),
FOREIGN KEY(product_id) REFERENCES Products(product_id)
);

# Step 2 - Insert Sample Data
 
# Customers Table
INSERT INTO Customers(name, email, city) VALUES
( "Shyam", "shyam.gupta@gmail.com", "Noida"),
( "Rahim", "rahim.gupta@gmail.com", "Delhi"),
( "Ram", "ram.gupta@gmail.com", "Chandigarh");
 
SELECT * FROM Customers;
DELETE FROM Customers;
 
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE Customers AUTO_INCREMENT = 0;


# Products Table
INSERT INTO PRODUCTS (product_name, category, price) VALUES
('Laptop', 'Electronics', 800.00),
('Smartphone', 'Electronics', 700.00),
('Mouse', 'Accessories', 25.00),
('Keyboard', 'Accessories', 40.00);

SELECT * FROM Products;
 
# Orders Table
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2024-01-10', 825.00),
(2, '2024-02-15', 1400.00),
(3, '2024-03-05', 740.00);

SELECT * FROM Orders;
DELETE FROM Orders;
ALTER TABLE Orders AUTO_INCREMENT = 0;

# Order_Items 
INSERT INTO Order_Items (order_id, product_id, quantity, price) VALUES
(3, 1, 1, 800.00),
(3, 3, 1, 25.00),
(4, 2, 2, 700.00),
(5, 4, 1, 40.00),
(4, 2, 1, 700.00);
SELECT * FROM Order_Items;


# Step - 3 Advanced SQl Queries
 
# Joins 
SELECT * FROM Customers;
SELECT * FROM Orders;

INSERT INTO Customers(name, email, city) VALUES
( "Samir", "samir@gmail.com", "Dallas");


# Inner Join
SELECT Customers.Customer_id, Customers.name, Orders.order_id, Orders.order_date
FROM Customers
Inner Join Orders ON Customers.customer_id = Orders.customer_id;

# Left Join
SELECT Customers.Customer_id, Customers.name, Orders.order_id, Orders.order_date
FROM Customers
Left Join Orders ON Customers.customer_id = Orders.customer_id;

# Right Join
SELECT Customers.Customer_id, Customers.name, Orders.order_id, Orders.order_date
FROM Customers
Right Join Orders ON Customers.customer_id = Orders.customer_id;

# Full Join
SELECT Customers.Customer_id, Customers.name, Orders.order_id, Orders.order_date
FROM Customers
Left Join Orders ON Customers.customer_id = Orders.customer_id
UNION
SELECT Customers.Customer_id, Customers.name, Orders.order_id, Orders.order_date
FROM Customers
Right Join Orders ON Customers.customer_id = Orders.customer_id;

# Cross Join
Select Customers.name,Customers.customer_id,
Orders.order_id,
Orders.total_amount
from Customers
Cross Join Orders;
 
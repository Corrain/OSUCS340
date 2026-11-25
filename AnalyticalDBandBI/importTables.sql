-- DROP TABLES customers, employees, employeeclassifications, products, salesinvoices, salesinvoicedetails, segments, shipmethods, termscodes, vendors;

-- DROP VIEW Customer_Dimensions, Calendar_Dimensions, Employee_Dimensions, Product_Dimensions, Sales_Facts;

CREATE DATABASE IF NOT EXISTS adv_bikes_2014_analytical;
USE adv_bikes_2014_analytical;



LOAD DATA LOCAL INFILE '/home/carl/Documents/OSU/340exports/Calendar_Dimensions.csv'
INTO TABLE Calendar_Dimensions
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/carl/Documents/OSU/340exports/Customer_Dimensions.csv'
INTO TABLE Customer_Dimensions
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/carl/Documents/OSU/340exports/Employee_Dimensions.csv'
INTO TABLE Employee_Dimensions
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/carl/Documents/OSU/340exports/Product_Dimensions.csv'
INTO TABLE Product_Dimensions
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/carl/Documents/OSU/340exports/Sales_Facts.csv'
INTO TABLE Sales_Facts
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';
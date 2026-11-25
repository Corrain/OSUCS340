USE analyticalDB;

SELECT * FROM Calendar_Dimensions
INTO OUTFILE '/var/lib/mysql-files/Calendar_Dimensions.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT * FROM Customer_Dimensions
INTO OUTFILE '/var/lib/mysql-files/Customer_Dimensions.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT * FROM Employee_Dimensions
INTO OUTFILE '/var/lib/mysql-files/Employee_Dimensions.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT * FROM Product_Dimensions
INTO OUTFILE '/var/lib/mysql-files/Product_Dimensions.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT * FROM Sales_Facts
INTO OUTFILE '/var/lib/mysql-files/Sales_Facts.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';
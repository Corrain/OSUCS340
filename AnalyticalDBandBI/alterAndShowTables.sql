ALTER TABLE `Calendar_Dimensions` ADD PRIMARY KEY(`FullDate`);
ALTER TABLE `Product_Dimensions` ADD PRIMARY KEY(`ProductID`);
ALTER TABLE `Employee_Dimensions` ADD PRIMARY KEY(`EmployeeID`);
ALTER TABLE `Customer_Dimensions` ADD PRIMARY KEY(`CustomerID`);

ALTER TABLE `Sales_Facts` 
ADD FOREIGN KEY(ProductID) references `Product_Dimensions`(ProductID) ON DELETE NO ACTION ON UPDATE NO ACTION, 
ADD FOREIGN KEY(CustomerID) references `Customer_Dimensions`(CustomerID) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD FOREIGN KEY(EmployeeID) references `Employee_Dimensions`(EmployeeID) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD FOREIGN KEY(FullDate) references `Calendar_Dimensions`(FullDate) ON DELETE NO ACTION ON UPDATE NO ACTION;

SHOW CREATE TABLE Calendar_Dimensions;
SHOW CREATE TABLE Product_Dimensions;
SHOW CREATE TABLE Employee_Dimensions;
SHOW CREATE TABLE Customer_Dimensions;
SHOW CREATE TABLE Sales_Facts;
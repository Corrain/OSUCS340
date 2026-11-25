CREATE DATABASE IF NOT EXISTS adv_bikes_2014_analytical;
USE adv_bikes_2014_analytical;

DROP TABLE IF EXISTS Calendar_Dimensions;
CREATE TABLE Calendar_Dimensions AS
SELECT * FROM analyticalDB.Calendar_Dimensions WHERE 1=0;
DROP TABLE IF EXISTS Customer_Dimensions;
CREATE TABLE Customer_Dimensions AS
SELECT * FROM analyticalDB.Customer_Dimensions WHERE 1=0;
DROP TABLE IF EXISTS Employee_Dimensions;
CREATE TABLE Employee_Dimensions AS
SELECT * FROM analyticalDB.Employee_Dimensions WHERE 1=0;
DROP TABLE IF EXISTS Product_Dimensions;
CREATE TABLE Product_Dimensions AS
SELECT * FROM analyticalDB.Product_Dimensions WHERE 1=0;
DROP TABLE IF EXISTS Sales_Facts;
CREATE TABLE Sales_Facts AS
SELECT * FROM analyticalDB.Sales_Facts WHERE 1=0;
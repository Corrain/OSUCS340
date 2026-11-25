CREATE OR REPLACE
        VIEW `Customer_Dimensions`
        AS
        SELECT
                customerId,
                customer_Name AS CustomerName,
                City AS CustomerCity,
                StateProvince_Name AS CustomerState
        FROM
                  .customers;

CREATE OR REPLACE
        VIEW `Product_Dimensions`
        AS
        SELECT
            products.ProductNumber AS ProductID,
            products.ProductName,
            products.ListPrice as ProductPrice,
            segments.CategoryName as ProductCategory
        FROM  .products
        INNER JOIN .segments
        ON  .products.SegmentID = .segments.SegmentID;

CREATE OR REPLACE
        VIEW `Employee_Dimensions`
        AS
        SELECT
            .employees.EmployeeID,
            .employees.FirstName as EmployeeFirstName,
            .employees.LastName as EmployeeLastName
        FROM
            .employees
        INNER JOIN
        .salesinvoices 
        ON
            .employees.EmployeeID = .salesinvoices.SalesEmployeeID
        GROUP BY
            .employees.EmployeeID,
            .employees.FirstName,
            .employees.LastName
        HAVING
            (SUM(.salesinvoices.TotalDue)<> 0)
        ORDER BY
            .employees.EmployeeID;

CREATE OR REPLACE 
        VIEW `Calendar_Dimensions`
        AS 
        SELECT
            DISTINCT 
        CONVERT(CONVERT(InvoiceDate,
            DATETIME),
            CHAR(23)) as FullDate,
            DATE(InvoiceDate) as DayOfYr,
            MONTH(InvoiceDate) as Month,
            DAY (InvoiceDate) as Day,
            QUARTER(InvoiceDate) as Quarter,
            YEAR(InvoiceDate) as Years
        FROM
            .salesinvoices
        WHERE
            YEAR(InvoiceDate) >= 2014
        ORDER BY 
            DayOfYr;

CREATE or REPLACE
        VIEW `Sales_Facts`
        AS
        SELECT
            convert(convert(.salesinvoices.InvoiceDate,
            DATETIME),
            char(23)) as FullDate,
            .salesinvoices.CustomerID,
            .salesinvoices .SalesEmployeeID as EmployeeID,
            .salesinvoicedetails.ProductNumber as ProductID,
            .salesinvoicedetails.OrderQty as UnitsSold,
            .salesinvoicedetails.LineTotal as DollarSold
        from
            .salesinvoicedetails
        inner join
        .salesinvoices 
        on
            .salesinvoicedetails.SalesInvoiceID = .salesinvoices.SalesInvoiceID
        WHERE
            (YEAR(.salesinvoices.InvoiceDate)>= 2014)
        ORDER BY
            FullDate ;
/*
    Note this function is built on the starter code provided in the assignment
*/

/*
    ACTIVITY 4 - CREATE A CUSTOMER OBJECT TABLE

    ! NOTES !

    Anytime you see [SQUARE BRACKETS] it means something that is optional.

    Anytime you see ... three dots - it means continued iterations of the same thing.
*/



/*
    CREATE THE CUSTOMERS TABLE

    Create the table customers, replace it if it exists, defined by the columns within the parentheses.

    We can use CREATE OR REPLACE instead of putting the usual DROP IF EXISTS statements at the top of the SQL file.

    The general syntax of CREATE [OR REPLACE] (Square brackets indicates its optional) is:

    CREATE [OR REPLACE] tableName 
    (
        columnName datatype constraints,
        ...
        [[PRIMARY KEY (columnName, ...)],
        FOREIGN KEY (columnName) REFERENCES primaryTableName(primaryKey, ...)]
    );
*/


DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    CustomerID int NOT NULL AUTO_INCREMENT,
    CustomerName varchar(50),
    AddressLine1 varchar(50),
    AddressLine2 varchar(50),
    City varchar(50),
    State varchar(50),
    PostalCode varchar(50),
    YTDPurchases decimal(19,2),
    PRIMARY KEY (CustomerID)
);

SHOW TABLES; 
DESCRIBE Customers;

/*
    ADD DATA TO THE TABLE

    The general syntax of an INSERT INTO statement is:

    INSERT INTO tableName (
        column1,
        column2,
        ...
    )
    VALUES
    (
        valueForColumn1,
        valueForColumn2,
        ...
    )

    You can include multiple sets of parentheses containing values after the first set to insert multiple rows as in the code below, they just must be separated with a comma and the last set of parentheses must end with a semi-colon.
*/

INSERT INTO Customers (
    CustomerName,
    AddressLine1,
    City,
    State,
    PostalCode
)
VALUES 
(
    "Bike World",
    "60025 Bollinger Canyon Road",
    "San Ramon",
    "California",
    "94583"
),
(
    "Metro Sports",
    "482505 Warm Springs Blvd.",
    "Fremont",
    "California",
    "94536"
)
,
(
    "My Customer",
    "My Address",
    "My City",
    "My State",
    "My Zip"
);

/*
    RETRIEVE DATA FROM THE TABLE
*/

SELECT * FROM Customers;

SELECT CustomerID, CustomerName FROM Customers WHERE PostalCode = "94536";


/*
    CREATE THE TermsCode TABLE
*/

DROP TABLE IF EXISTS TermsCode;
CREATE TABLE TermsCode (
    TermsCodeID varchar(50) NOT NULL,
    Description varchar(50),
    PRIMARY KEY (TermsCodeID)
);

/*
    ADD DATA TO THE TABLE
*/

INSERT INTO TermsCode (
    TermsCodeID,
    Description
)
VALUES 
(
    "NET30",
    "Payment due in 30 days."
),
(
    "NET15",
    "Payment due in 15 days."
),
(
    "210NET30",
    "2% discount in 10 days Net 30"
);

/*
    CREATE THE Invoices TABLE
*/

DROP TABLE IF EXISTS Invoices;
CREATE TABLE Invoices (
    InvoiceID int NOT NULL AUTO_INCREMENT,
    CustomerID int,
    InvoiceDate datetime,
    TermsCodeID varchar(50),
    TotalDue decimal(19,2),    
    PRIMARY KEY (InvoiceID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (TermsCodeID) REFERENCES TermsCode(TermsCodeID)
);

/*
    ADD DATA TO THE TABLE
*/

INSERT INTO Invoices (
    CustomerID,
    InvoiceDate,
    TotalDue,
    TermsCodeID
)
VALUES 
(
    2,
    "20140207",
    "2388.98",
    "NET30"
),
(
    1,
    "20140202",
    "2443.35",
    "210NET30"
),
(
    1,
    "20140209",
    "8752.32",
    "NET30"
);
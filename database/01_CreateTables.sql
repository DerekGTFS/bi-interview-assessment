IF DB_ID('InterviewDB') IS NULL
BEGIN
    CREATE DATABASE InterviewDB;
END
GO

USE InterviewDB;
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'interview')
BEGIN
    EXEC('CREATE SCHEMA interview');
END
GO

DROP TABLE IF EXISTS interview.Cases;
DROP TABLE IF EXISTS interview.Transactions;
DROP TABLE IF EXISTS interview.Targets;
DROP TABLE IF EXISTS interview.Customers;
DROP TABLE IF EXISTS interview.Products;
DROP TABLE IF EXISTS interview.Networks;
DROP TABLE IF EXISTS interview.AccountManagers;
GO

CREATE TABLE interview.AccountManagers
(
    AccountManagerID INT NOT NULL PRIMARY KEY,
    AccountManagerName NVARCHAR(100) NOT NULL,
    Territory NVARCHAR(50) NOT NULL
);

CREATE TABLE interview.Networks
(
    NetworkID INT NOT NULL PRIMARY KEY,
    NetworkName NVARCHAR(100) NOT NULL,
    NetworkType NVARCHAR(50) NOT NULL
);

CREATE TABLE interview.Products
(
    ProductID INT NOT NULL PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    RevenueCategory NVARCHAR(50) NOT NULL,
    FuelType NVARCHAR(50) NOT NULL
);

CREATE TABLE interview.Customers
(
    CustomerID INT NOT NULL PRIMARY KEY,
    AccountNumber NVARCHAR(20) NOT NULL,
    CustomerName NVARCHAR(150) NOT NULL,
    Industry NVARCHAR(100) NOT NULL,
    Region NVARCHAR(50) NOT NULL,
    AccountManagerID INT NOT NULL,
    FirstDrawnDate DATE NULL,
    CreditLimit DECIMAL(18,2) NULL,
    PaymentTermsDays INT NULL,
    CustomerStatus NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Customers_AccountManagers
        FOREIGN KEY (AccountManagerID) REFERENCES interview.AccountManagers(AccountManagerID)
);

CREATE TABLE interview.Transactions
(
    TransactionID INT NOT NULL PRIMARY KEY,
    EventID UNIQUEIDENTIFIER NOT NULL,
    CustomerID INT NOT NULL,
    TxDate DATE NOT NULL,
    NetworkID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity DECIMAL(18,2) NOT NULL,
    Revenue DECIMAL(18,2) NOT NULL,
    Cost DECIMAL(18,2) NOT NULL,
    NetRevenue DECIMAL(18,2) NULL,
    CONSTRAINT FK_Transactions_Customers
        FOREIGN KEY (CustomerID) REFERENCES interview.Customers(CustomerID),
    CONSTRAINT FK_Transactions_Networks
        FOREIGN KEY (NetworkID) REFERENCES interview.Networks(NetworkID),
    CONSTRAINT FK_Transactions_Products
        FOREIGN KEY (ProductID) REFERENCES interview.Products(ProductID)
);

CREATE TABLE interview.Targets
(
    TargetID INT NOT NULL PRIMARY KEY,
    MonthStart DATE NOT NULL,
    AccountManagerID INT NOT NULL,
    VolumeTarget DECIMAL(18,2) NOT NULL,
    NetRevenueTarget DECIMAL(18,2) NOT NULL,
    NewCustomerTarget INT NOT NULL,
    CONSTRAINT FK_Targets_AccountManagers
        FOREIGN KEY (AccountManagerID) REFERENCES interview.AccountManagers(AccountManagerID)
);

CREATE TABLE interview.Cases
(
    CaseID INT NOT NULL PRIMARY KEY,
    CustomerID INT NOT NULL,
    CreatedDate DATE NOT NULL,
    CaseCategory NVARCHAR(100) NULL,
    CaseStatus NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Cases_Customers
        FOREIGN KEY (CustomerID) REFERENCES interview.Customers(CustomerID)
);
GO
USE InterviewDB;
GO

/*
Run this after opening the repo in Codespaces.

The CSV files are stored in /workspaces/bi-interview-assessment/data.
If your Codespace workspace path is different, update the paths below.
*/

BULK INSERT interview.AccountManagers
FROM '/workspaces/bi-interview-assessment/data/AccountManagers.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

BULK INSERT interview.Networks
FROM '/workspaces/bi-interview-assessment/data/Networks.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

BULK INSERT interview.Products
FROM '/workspaces/bi-interview-assessment/data/Products.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

BULK INSERT interview.Customers
FROM '/workspaces/bi-interview-assessment/data/Customers.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

BULK INSERT interview.Transactions
FROM '/workspaces/bi-interview-assessment/data/Transactions.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

BULK INSERT interview.Targets
FROM '/workspaces/bi-interview-assessment/data/Targets.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);

BULK INSERT interview.Cases
FROM '/workspaces/bi-interview-assessment/data/Cases.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', TABLOCK);
GO

CREATE OR ALTER VIEW interview.vwCommercialSales AS
SELECT
    t.TransactionID,
    t.EventID,
    t.TxDate,
    c.AccountNumber,
    c.CustomerName,
    c.Industry,
    c.Region,
    am.AccountManagerName,
    n.NetworkName,
    p.ProductName,
    p.RevenueCategory,
    p.FuelType,
    t.Quantity,
    t.Revenue,
    t.Cost,
    t.NetRevenue,
    CASE
        WHEN t.Quantity = 0 THEN NULL
        ELSE (t.NetRevenue / NULLIF(t.Quantity, 0)) * 100
    END AS MarginPPL,
    c.FirstDrawnDate,
    CASE
        WHEN c.FirstDrawnDate >= DATEFROMPARTS(YEAR(t.TxDate), 1, 1)
             AND t.TxDate <= DATEADD(DAY, 91, c.FirstDrawnDate)
            THEN 'Front Book'
        ELSE 'Back Book'
    END AS BookType
FROM interview.Transactions t
INNER JOIN interview.Customers c ON t.CustomerID = c.CustomerID
INNER JOIN interview.AccountManagers am ON c.AccountManagerID = am.AccountManagerID
INNER JOIN interview.Networks n ON t.NetworkID = n.NetworkID
INNER JOIN interview.Products p ON t.ProductID = p.ProductID;
GO
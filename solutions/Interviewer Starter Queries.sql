-- Example checks for interviewer use only

USE InterviewDB;
GO

-- Monthly commercial trend
SELECT
    DATEFROMPARTS(YEAR(TxDate), MONTH(TxDate), 1) AS MonthStart,
    SUM(Quantity) AS Quantity,
    SUM(Revenue) AS Revenue,
    SUM(NetRevenue) AS NetRevenue,
    SUM(NetRevenue) / NULLIF(SUM(Quantity), 0) * 100 AS MarginPPL
FROM interview.vwCommercialSales
WHERE RevenueCategory IN ('Fuel','AdBlue','EV')
GROUP BY DATEFROMPARTS(YEAR(TxDate), MONTH(TxDate), 1)
ORDER BY MonthStart;

-- Account manager volume and PPL
SELECT
    AccountManagerName,
    SUM(Quantity) AS Quantity,
    SUM(NetRevenue) AS NetRevenue,
    SUM(NetRevenue) / NULLIF(SUM(Quantity), 0) * 100 AS MarginPPL
FROM interview.vwCommercialSales
WHERE RevenueCategory = 'Fuel'
GROUP BY AccountManagerName
ORDER BY Quantity DESC;
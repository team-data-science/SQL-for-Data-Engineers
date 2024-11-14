--understanding the relative importance of each customer's contribution to the company's overall revenue and the number of sales
WITH CustomerRevenue AS (
    SELECT
        c.CustomerId,
        c.FirstName || ' ' || c.LastName AS CustomerName,
        i.InvoiceDate,
        i.Total,
        SUM(i.Total) OVER (PARTITION BY c.CustomerId) AS CustomerTotalRevenue,
        AVG(i.Total) OVER (PARTITION BY c.CustomerId) AS CustomerAverageRevenue,
        COUNT(*) OVER () AS TotalInvoices,
        COUNT(i.InvoiceId) OVER (PARTITION BY c.CustomerId) AS CustomerTotalInvoices,
        MIN(i.Total) OVER (PARTITION BY c.CustomerId) AS CustomerLowestInvoice,
        MAX(i.Total) OVER (PARTITION BY c.CustomerId) AS CustomerHighestInvoice,
        SUM(i.Total) OVER () AS TotalCompanyRevenue
    FROM Customer c
    JOIN Invoice i ON c.CustomerId = i.CustomerId
)
SELECT
    CustomerId,
    CustomerName,
    InvoiceDate,
    Total,
    CustomerTotalRevenue,
    CustomerAverageRevenue,
    CustomerTotalInvoices,
    CustomerLowestInvoice,
    CustomerHighestInvoice,
    TotalCompanyRevenue,
    ROUND((1.0 / CustomerTotalInvoices) * 100, 2) as ContributionToCustomerTotalNumInvoices,
    ROUND((1.0 / TotalInvoices) * 100, 2) as ContributionToTotalNumInvoices,
    ROUND((Total / CustomerTotalRevenue) * 100, 2) AS ContributionToCustomerTotalRevenue,
    ROUND((Total / TotalCompanyRevenue) * 100, 2) AS ContributionToTotalRevenue
FROM CustomerRevenue;

--identifying high-value customers
SELECT
    CustomerInvoiceTotal.CustomerId,
    FirstName || ' ' || LastName AS CustomerName,
    TotalAmount,
    RANK() OVER (ORDER BY TotalAmount DESC) AS CustomerRank,
    DENSE_RANK() OVER (ORDER BY TotalAmount DESC) AS DenseCustomerRank,
    ROW_NUMBER() OVER (ORDER BY TotalAmount DESC) AS RowNumber
FROM
    (
        SELECT
            Invoice.CustomerId,
            SUM(Invoice.Total) AS TotalAmount
        FROM
            Invoice
        GROUP BY
            Invoice.CustomerId
    ) AS CustomerInvoiceTotal
JOIN Customer ON CustomerInvoiceTotal.CustomerId = Customer.CustomerId;

--analyzing customer purchasing behavior to identify patterns in their order frequency and timing
SELECT
    Invoice.InvoiceId,
    InvoiceDate,
    Invoice.CustomerId,
    FirstName || ' ' || LastName AS CustomerName,
    LEAD(InvoiceDate) OVER (PARTITION BY Invoice.CustomerId ORDER BY InvoiceDate) AS NextInvoiceDate,
    LAG(InvoiceDate) OVER (PARTITION BY Invoice.CustomerId ORDER BY InvoiceDate) AS PreviousOrderDate,
    JULIANDAY(LEAD(InvoiceDate) OVER (PARTITION BY Invoice.CustomerId ORDER BY InvoiceDate)) - JULIANDAY(InvoiceDate) AS DaysBetweenOrders,
    FIRST_VALUE(InvoiceDate) OVER (PARTITION BY Invoice.CustomerId ORDER BY InvoiceDate) AS FirstOrderDate,
    LAST_VALUE(InvoiceDate) OVER (PARTITION BY Invoice.CustomerId ORDER BY InvoiceDate ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LastPurchaseDate
FROM Invoice
JOIN Customer ON Invoice.CustomerId = Customer.CustomerId;

SELECT COUNT(*) FROM Customer;

SELECT CustomerId, COUNT(*) as NumSales FROM Invoice
GROUP BY CustomerId;

SELECT AVG(Total) AS AverageInvoiceAm
FROM Invoice;

SELECT BillingCountry, AVG(Total) AS AverageInvoiceAm
FROM Invoice
GROUP BY BillingCountry;

SELECT SUM(Total) as TotalRevenue FROM Invoice;

SELECT CustomerId, COUNT(*) as NumSales, SUM(Total) as Revenue FROM Invoice
GROUP BY CustomerId;

SELECT MIN(InvoiceDate) AS EarliestInvoiceDate
FROM Invoice;

SELECT CustomerId, MIN(InvoiceDate) AS EarliestInvoiceDate
FROM Invoice
GROUP BY CustomerId;

SELECT CustomerId, MIN(InvoiceDate) AS EarliestInvoiceDate
FROM Invoice
GROUP BY CustomerId
ORDER BY EarliestInvoiceDate desc;

SELECT
    InvoiceDate,
    BillingCountry,
    COUNT(*) AS TotalInvoices,
    SUM(Total) AS TotalRevenue,
    AVG(Total) AS AverageInvoiceAm,
    MIN(Total) AS SmallestInvoiceAm,
    MAX(Total) AS LargestInvoiceAm,
    COUNT(DISTINCT CustomerId) as NumCustomers
FROM
    Invoice
GROUP BY
    1, 2;
	
SELECT BillingCountry,
       STRFTIME('%m', InvoiceDate) AS InvoiceMonth,
       STRFTIME('%Y', InvoiceDate) as InvoiceYear,
       SUM(Total) AS TotalRevenue
FROM Invoice
where STRFTIME('%Y', InvoiceDate)='2013'   
GROUP BY BillingCountry, STRFTIME('%m', InvoiceDate), STRFTIME('%Y', InvoiceDate)
HAVING SUM(Total) > (
    SELECT AVG(Total)
    FROM Invoice
    GROUP BY STRFTIME('%m', InvoiceDate),STRFTIME('%Y', InvoiceDate)
)
ORDER BY BillingCountry, InvoiceMonth, InvoiceYear;

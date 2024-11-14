
--querying the Employee table with STAR to get all records
SELECT * FROM Employee;

--querying the Employee table with STAR to get only attributes related to the employee location
SELECT EmployeeId, LastName, FirstName, City, State, Country FROM Employee;

--answering, how many customers we have
SELECT COUNT(*) FROM Customer;

--ansering what is the total number of sales by customer id
SELECT CustomerId, COUNT(*) as NumSales FROM Invoice
GROUP BY CustomerId;

--answering what is the average total amount across all invoices
SELECT AVG(Total) AS AverageInvoiceAm
FROM Invoice;

--answering what is the average invoice total for each country where invoices were billed
SELECT BillingCountry, AVG(Total) AS AverageInvoiceAm
FROM Invoice
GROUP BY BillingCountry;

--answering what was the total amount invoiced in our media store
SELECT SUM(Total) as TotalRevenue FROM Invoice;

--ansering what is the total number of sales and total revenue by customer id
SELECT CustomerId, COUNT(*) as NumSales, SUM(Total) as Revenue FROM Invoice
GROUP BY CustomerId;

--answering what was the earliest transaction data
SELECT MIN(InvoiceDate) AS EarliestInvoiceDate
FROM Invoice;

--answering what is the earliest invoice date for each customer
SELECT CustomerId, MIN(InvoiceDate) AS EarliestInvoiceDate
FROM Invoice
GROUP BY CustomerId;

--answering what is the total number of invoices, total revenue, average invoice amount, smallest invoice amount,
--and largest invoice amount for each distinct InvoiceDate and BillingCountry
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

--answering what countries had a total amount invoiced in a month greater than the average invoice across all billing countries in a given month?
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

--checking the number of unique CustomerId returned 59 rows
SELECT COUNT(DISTINCT CustomerId) FROM Customer;

--inersting records for testing
INSERT INTO Customer (CustomerId, FirstName, LastName, Country, Email) VALUES (60, 'ProspectFName', 'ProspectLNAME', 'Germany', 'test@test.com');

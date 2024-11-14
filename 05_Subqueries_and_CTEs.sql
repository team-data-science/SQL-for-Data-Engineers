--answering the question, what is the total number of invoices per customer with nested queries?
SELECT
    CustomerId,
    FirstName || ' ' || LastName AS CustomerName,
    (
        SELECT COUNT(*)
        FROM Invoice
        WHERE Invoice.CustomerId = Customer.CustomerId
    ) AS TotalInvoices
FROM Customer;

--extracting a list of all invoices along with the corresponding customer names with nested queries
SELECT i.InvoiceId, i.InvoiceDate, c.FirstName, c.LastName
FROM (
    SELECT *
    FROM Invoice
) AS i
JOIN Customer AS c ON i.CustomerId = c.CustomerId;

--answering the question, what are the invoices that have an invoiced amount greater than the average invoice amount with CTEs?
WITH AvgInvoiceTotal AS (
    SELECT AVG(Total) AS AvgTotal
    FROM Invoice
)
SELECT *
FROM Invoice
CROSS JOIN AvgInvoiceTotal
WHERE Total > AvgTotal;

--answering the question, what is the total number of invoices per customer with CTEs?
WITH InvoiceCounts AS (
    SELECT CustomerId, COUNT(*) AS TotalInvoices
    FROM Invoice
    GROUP BY CustomerId
)
SELECT
    c.CustomerId,
    c.FirstName || ' ' || c.LastName AS CustomerName,
    COALESCE(ic.TotalInvoices, 0) AS TotalInvoices
FROM Customer c
LEFT JOIN InvoiceCounts ic ON c.CustomerId = ic.CustomerId;

--extracting a list of all invoices along with the corresponding customer names with CTEs
WITH FilteredInvoice AS (
    SELECT *
    FROM Invoice
)
SELECT i.InvoiceId, i.InvoiceDate, c.FirstName, c.LastName
FROM FilteredInvoice AS i
JOIN Customer AS c ON i.CustomerId = c.CustomerId;

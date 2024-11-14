---Advanced SQL
--reviewing the query execution plan
EXPLAIN QUERY PLAN SELECT * FROM CUSTOMER WHERE CustomerId = 1;

EXPLAIN QUERY PLAN SELECT * FROM CUSTOMER WHERE FirstName LIKE '%A';

EXPLAIN QUERY PLAN SELECT c.CustomerId,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(*) as NumSales,
       SUM(i.Total) AS Revenue
FROM Customer c
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName
ORDER BY Revenue ASC;

EXPLAIN QUERY PLAN SELECT c.CustomerId,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(*) as NumSales,
       SUM(i.Total) AS Revenue
FROM Customer c
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
where c.CustomerId=2
GROUP BY c.CustomerId, CustomerName
ORDER BY Revenue ASC;

--extracting existing indexes
SELECT *
FROM sqlite_master
WHERE type = 'index';

--creating a unique index on the email field (single index)
CREATE UNIQUE INDEX employee_email_idx ON Employee('Email');
INSERT INTO Employee (FirstName, LastName, Email) VALUES ('Test', 'Test', 'laura@chinookcorp.com');

--creating a unique index on the email field (composite index)
CREATE UNIQUE INDEX employee_fname_lname_idx ON Employee('FirstName','LastName');
INSERT INTO Employee (FirstName, LastName, Email) VALUES ('Adams', 'Andrew', 'test@');
INSERT INTO Employee (FirstName, LastName, Email) VALUES ('Adams', 'Andrew', 'test@');


EXPLAIN QUERY PLAN
SELECT * FROM Invoice WHERE BillingCountry = 'Germany';

--creating a single column index
CREATE INDEX invoice_billingcountry_idx ON Invoice (BillingCountry);

EXPLAIN QUERY PLAN
SELECT * FROM Invoice
WHERE BillingCountry = 'Germany' and InvoiceDate <='2009-12-31';

--creating a composite index
CREATE INDEX invoice_billingcountry_invoicedate_idx ON Invoice('BillingCountry', 'InvoiceDate');

--BASIC SQL
---creating an empty table
CREATE TABLE Band (
ArtistId INT,
LeadSinger TEXT,
YearStart INT,
YearEnd INT
);

---inserting one row into the table
INSERT INTO Band VALUES (22, 'Robert Plant', 1968, 1980);

---inserting multipe rows into the table
INSERT INTO Band (ArtistId, LeadSinger, YearStart, YearEnd) VALUES
(50,'James Hetfield',1981,2024),
(51,'Freddie Mercury',1970,1991),
(52,'Paul Stanley and Gene Simmons',1973,2024),
(110,'Kurt Cobain',1987,1994),
(120,'David Gilmour and Roger Waters',1965,1995),
(127,'Anthony Kiedis',1983,2024),
(140,'Jim Morrison',1965,1971),
(179,'Klaus Meine',1965,2024),
(187,'Marcelo Camelo',1997,2007);

---creating an empty table
CREATE table Band_copy (
ArtistId INT,
LeadSinger TEXT,
YearStart INT,
YearEnd INT
);

---inserting values to the new table with SELECT using the existing table
INSERT INTO Band_copy (ArtistId, LeadSinger, YearStart, YearEnd)
SELECT *
FROM Band;

--dropping the table
DROP table Band;

--creating an empty table with the not null constrain
CREATE TABLE Band (
ArtistId INT,
LeadSinger TEXT,
YearStart NOT NULL,
YearEnd INT
);

--inserting a record that doesn't comply with the constrain YearStart cannot be null
INSERT INTO Band (ArtistId, LeadSinger, YearEnd) VALUES
(22, 'Robert Plant', 1980),
(50,'James Hetfield',2024),
(51,'Freddie Mercury',1991),
(52,'Paul Stanley and Gene Simmons',2024),
(110,'Kurt Cobain',1994),
(120,'David Gilmour and Roger Waters',1995),
(127,'Anthony Kiedis',2024),
(140,'Jim Morrison',1971),
(179,'Klaus Meine',2024),
(187,'Marcelo Camelo',2007);

--dropping the table
DROP table Band;

--creating an empty table with the unique constrain
CREATE TABLE Band (
ArtistId INT,
LeadSinger TEXT UNIQUE,
YearStart INT,
YearEnd INT
);

--inserting a record that doesn't comply with the constrain LeadSinger should be unique
INSERT INTO Band (ArtistId, LeadSinger, YearStart, YearEnd) VALUES
(22, 'Robert Plant', 1968, 1980),
(50,'Jim Morrison',1981,2024),
(51,'Freddie Mercury',1970,1991),
(52,'Paul Stanley and Gene Simmons',1973,2024),
(110,'Kurt Cobain',1987,1994),
(120,'David Gilmour and Roger Waters',1965,1995),
(127,'Anthony Kiedis',1983,2024),
(140,'Jim Morrison',1965,1971),
(179,'Klaus Meine',1965,2024),
(187,'Marcelo Camelo',1997,2007);

--dropping the table
DROP table Band;

--creating an empty table with the PRIMARY KEY constrain
CREATE TABLE Band (
ArtistId INT PRIMARY KEY,
LeadSinger TEXT,
YearStart INT,
YearEnd INT
);

--inserting a record that doesn't comply with the constrain id should be unique and not null
INSERT INTO Band (ArtistId, LeadSinger, YearStart, YearEnd) VALUES
(22, 'Robert Plant', 1968, 1980),
(22, 'Robert Plant', 1968, 1980),
(50,'James Hetfield',1981,2024),
(51,'Freddie Mercury',1970,1991),
(52,'Paul Stanley and Gene Simmons',1973,2024),
(110,'Kurt Cobain',1987,1994),
(120,'David Gilmour and Roger Waters',1965,1995),
(127,'Anthony Kiedis',1983,2024),
(140,'Jim Morrison',1965,1971),
(179,'Klaus Meine',1965,2024),
(187,'Marcelo Camelo',1997,2007);

--a corrected query
INSERT INTO Band (ArtistId, LeadSinger, YearStart, YearEnd) VALUES
(22, 'Robert Plant', 1968, 1980),
(50,'James Hetfield',1981,2024),
(51,'Freddie Mercury',1970,1991),
(52,'Paul Stanley and Gene Simmons',1973,2024),
(110,'Kurt Cobain',1987,1994),
(120,'David Gilmour and Roger Waters',1965,1995),
(127,'Anthony Kiedis',1983,2024),
(140,'Jim Morrison',1965,1971),
(179,'Klaus Meine',1965,2024),
(187,'Marcelo Camelo',1997,2007);

--adding a new column to the existing table
ALTER TABLE Artist ADD COLUMN BandFlag TEXT;

--updating the new column in the Artist table 
update Artist set BandFlag='1' where ArtistId=1;
update Artist set BandFlag='1' where ArtistId=22;
update Artist set BandFlag='1' where ArtistId=50;
update Artist set BandFlag='1' where ArtistId=51;
update Artist set BandFlag='1' where ArtistId=52;
update Artist set BandFlag='1' where ArtistId=110;
update Artist set BandFlag='1' where ArtistId=120;
update Artist set BandFlag='1' where ArtistId=127;
update Artist set BandFlag='1' where ArtistId=140;
update Artist set BandFlag='1' where ArtistId=179;
update Artist set BandFlag='1' where ArtistId=187;

--deleting selected records from the table
DELETE FROM Band
WHERE ArtistId=22; 

--creating a view
CREATE VIEW customer_v as 
SELECT CustomerId,
       FirstName || ' ' || c.LastName AS CustomerName,
       Company,
       Address,
       City,
       State,
       Country,
       PostalCode,
       Phone,
       Fax,
       Email from Customer;

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

--using inner join to understand how many sales were done per client and how much revenue each client brought
SELECT c.CustomerId,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(*) as NumSales,
       SUM(i.Total) AS Revenue
FROM Customer c
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName
ORDER BY Revenue ASC;

--checking the number of unique CustomerId returned 59 rows
SELECT COUNT(*) FROM
(SELECT c.CustomerId,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(*) as NumSales,
       SUM(i.Total) AS Revenue
FROM Customer c
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName
ORDER BY Revenue DESC);

--using left join  to understand whether all prospects turned into customers
SELECT c.CustomerId,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(*) as NumSales,
       SUM(i.Total) AS Revenue
FROM Customer c
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName
ORDER BY Revenue ASC;

--checking the number of unique CustomerId returned 60 rows
SELECT COUNT(*) FROM
(SELECT c.CustomerId,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(*) as NumSales,
       SUM(i.Total) AS Revenue
FROM Customer c
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName
ORDER BY Revenue ASC);

--inserting a row to the Invoice table for testing
INSERT INTO Invoice (InvoiceId, CustomerId, InvoiceDate, BillingCountry, Total) VALUES (413, 61, '2024-05-12', 'Germany', 7);

--using full join
SELECT c.CustomerId,
       i.CustomerId,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(*) as NumSales,
       SUM(i.Total) AS Revenue
FROM Customer c
FULL JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName
ORDER BY Revenue ASC;

--using cross join to get a catalog of track names and media types
SELECT MT.Name AS MediaTypeName, T.Name AS TrackName
FROM MediaType MT
CROSS JOIN Track T;

--using self-join to understand who reports to whom
SELECT e.EmployeeId, e.FirstName, e.LastName, e.ReportsTo AS SupervisorId, 
       s.FirstName AS SupervisorFirstName, s.LastName AS SupervisorLastName
FROM Employee e
LEFT JOIN Employee s ON e.ReportsTo = s.EmployeeId;


---Intermediate SQL
--running TCL commands
BEGIN;
UPDATE Customer SET Company = 'Company' WHERE CustomerId = 60;
DELETE FROM Invoice WHERE InvoiceId = 413;
INSERT INTO Customer (CustomerId, FirstName, LastName, Country) VALUES (62, 'ProspectFName', 'ProspectLNAME', 'Germany');
COMMIT;

--answering the question, what are the invoices that have an invoiced amount greater than the average invoice amount with nested queries?
SELECT *
FROM Invoice
WHERE Total > (
    SELECT AVG(Total)
    FROM Invoice
);

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

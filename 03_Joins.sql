
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

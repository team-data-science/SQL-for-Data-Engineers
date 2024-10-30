INSERT INTO Customer (CustomerId, FirstName, LastName, Country, Email) VALUES (60, 'ProspectFName', 'ProspectLNAME', 'Germany', 'test@test.com');

SELECT c.CustomerId,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(*) as NumSales,
       SUM(i.Total) AS Revenue
FROM Customer c
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName
ORDER BY Revenue ASC;

SELECT COUNT(*) FROM
(SELECT c.CustomerId,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(*) as NumSales,
       SUM(i.Total) AS Revenue
FROM Customer c
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName
ORDER BY Revenue DESC);

SELECT c.CustomerId,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(*) as NumSales,
       SUM(i.Total) AS Revenue
FROM Customer c
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName
ORDER BY Revenue ASC;

SELECT COUNT(*) FROM
(SELECT c.CustomerId,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(*) as NumSales,
       SUM(i.Total) AS Revenue
FROM Customer c
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName
ORDER BY Revenue ASC);

INSERT INTO Invoice (InvoiceId, CustomerId, InvoiceDate, BillingCountry, Total) VALUES (413, 61, '2024-05-12', 'Germany', 7);

SELECT c.CustomerId,
       i.CustomerId,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(*) as NumSales,
       SUM(i.Total) AS Revenue
FROM Customer c
FULL JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, CustomerName
ORDER BY Revenue ASC;

SELECT MT.Name AS MediaTypeName, T.Name AS TrackName
FROM MediaType MT
CROSS JOIN Track T;

SELECT e.EmployeeId, e.FirstName, e.LastName, e.ReportsTo AS SupervisorId, 
       s.FirstName AS SupervisorFirstName, s.LastName AS SupervisorLastName
FROM Employee e
LEFT JOIN Employee s ON e.ReportsTo = s.EmployeeId;
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

BEGIN;
UPDATE Customer SET Company = 'Company' WHERE CustomerId = 60;
INSERT INTO Customer (CustomerId, FirstName, LastName, Country) VALUES (62, 'ProspectFName', 'ProspectLNAME', 'Germany');

SELECT * FROM Customer;

Rollback;

SELECT * FROM Customer;

DELETE FROM Invoice WHERE InvoiceId = 413;

COMMIT;

SELECT * FROM Invoice;
## Intermediate SQL
### SQL Cheat Sheet (video 15)
You might have heard about the ACID and BASE principles. You need to know about them because it will allow you to design and implement database systems that meet the performance, scalability, availability, and consistency requirements of your applications effectively. 

ACID stands for Atomicity, Consistency, Isolation, and Durability. It's a set of properties that ensure reliability and consistency in database transactions.
- Atomicity: Atomicity ensures that a transaction is treated as a single unit of work, which either fully completes or fully fails. In other words, if any part of the transaction fails, the entire transaction is rolled back to its original state. Imagine transferring money from one bank account to another. Atomicity ensures that if the withdrawal succeeds but the deposit fails, the entire transaction is rolled back to maintain the consistency of account balances.

- Consistency: Consistency ensures that the database remains in a valid state before and after a transaction. It means that the database constraints, such as foreign key relationships and data integrity rules, are maintained. In an online shopping application, if a customer places an order, the inventory should be updated accordingly. Consistency ensures that the inventory is deducted correctly, and the product availability remains accurate.

- Isolation: Isolation ensures that transactions are executed independently of each other, even if they are running concurrently. Each transaction should see the database in a consistent state, isolated from changes made by other transactions until it's committed. When two users simultaneously update the same bank account balance, isolation ensures that each user sees the balance before the other user's update until their transaction is committed.

- Durability: Durability ensures that once a transaction is committed, its changes are permanently saved and survive system failures. Even in the event of a power outage or system crash, the changes made by committed transactions are not lost. After completing an online payment transaction, durability ensures that the payment record is safely stored in the database and remains intact, even if the server crashes.

When to Use ACID:
- ACID transactions are suitable for applications where data consistency and integrity are critical, such as financial systems, healthcare records, and e-commerce platforms.
- Use ACID when you need strict control over the outcome of transactions and want to ensure data integrity, even in the face of failures or concurrent access.

BASE (Basically Available, Soft state, Eventually consistent):
- Basically Available: BASE prioritizes availability over consistency, meaning that the system remains operational and responsive even in the presence of failures or network partitions. It sacrifices immediate consistency for continued availability.

- Soft state: BASE acknowledges that the system's state may be transient or mutable over time. It allows data to exist in a temporary or soft state, with the expectation that it will eventually converge to a consistent state.

- Eventually consistent: BASE systems aim for eventual consistency, meaning that data updates are propagated asynchronously and conflicts are resolved gradually. It accepts that there may be temporary inconsistencies between replicas, but they will eventually reconcile.

When to Use BASE:
- BASE is suitable for distributed systems, NoSQL databases, and large-scale web applications where high availability and scalability are paramount.
- Use BASE when immediate consistency is not critical, and it's acceptable for different parts of the system to see different views of the data temporarily.
- BASE is often used in scenarios where the system needs to handle high volumes of concurrent requests, tolerate network partitions, and scale horizontally.

In order to adhere to ACID principles when managing the create, update or delete transactions in a database, you could use the Transaction Control Language (TCL) commands in SQL. Here is how you can use the TCL commands practically when you want to execute a series of SQL statements as a single unit of work.

- You start with the BEGIN TRANSACTION command to start a transaction such as update a record, insert a new record or delete the existing record. 

- It will be followed with the SQL statements that you want to execute. Finally, you conclude you SQL script  with the COMMIT command to commit the transactions to indicate to the database that if all the SQL statements within the transaction execute successfully, you want to make the changes permanent. 

- If an error occurs during the execution of the SQL statements or if you decide to discard the changes made in the transaction, you can use the ROLLBACK command to rollback the transaction.

Let's try to update our Invoice and Customer tables where you want to update the details for CustomerId = 60, delete the Invoice from the Invoice table for InvoiceId = 413 and insert a new customer record to the Customer table. Here's how you could use TCL commands:
```
BEGIN;
UPDATE Customer SET Company = 'Company' WHERE CustomerId = 60;
INSERT INTO Customer (CustomerId, FirstName, LastName, Country, Email) VALUES (62, 'ProspectFName', 'ProspectLNAME', 'Germany', 'test@test.com');
SELECT * FROM Customer;
```
You will see that the tables contains the changes we have done after executing the SELECT statement. Let's assume that we didn't wanted to insert that customer or we have done some mistakes. You can execute the following steps:

```
ROLLBACK;
SELECT * FROM Customer;
```
You see the table is as in it's original state since we didn't commit the transactions.

Let's do another example:
```
BEGIN;
SELECT * FROM Invoice;
DELETE FROM Invoice WHERE InvoiceId = 413;
COMMIT;
SELECT * FROM Invoice;
```
You will see that the entry is deleted and even after reconnecting to the database this change will remain since the commit is done.

__Hint: Execute every line one by one and use this TCL outside of DBeaver (use `sqlite3 mydatabase.sqlite` in terminal) because DBeaver is auto-committing the commands.__

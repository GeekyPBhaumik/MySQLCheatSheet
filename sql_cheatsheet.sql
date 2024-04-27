-- Practicing SQL Queries --
-- Create a new database
CREATE Database mydb;
-- Show Databases -- 
show databases;     
-- Use Database --
use mydb;   
-- Create Table Syntax
-- create table tableName(
-- columnName data_type Constraints
-- );
create table userDetails(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2)
);   
-- Create Employee Table
-- AUTO_INCREMENT is used to automatically generate unique values for a column.
create table emp(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(50),
    emp_salary DECIMAL(10,2)
);        
-- Create a table with default values
-- Primary key uniquely identifies each record in a table
CREATE TABLE orders (
    id INT PRIMARY KEY,
    order_date DATE DEFAULT NULL,
    total_amount DECIMAL(10, 2) DEFAULT 0.00
);

							-- Unique Key --
-- A unique key describes that all values in a column or group of column are unique
-- -- It is same as PRIMARY KEY
-- The diff is a primary key uniquely identify each record in a table
-- Only difference is an unique key can have null values
-- (except in case of a single column unique key)


							 -- Composite Key --
-- A composite key is a key that consists of multiple columns. 
-- Together, these columns form a unique identifier for each record in the table.
/* 
CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    PRIMARY KEY (order_id, customer_id)
);
*/

-- Different Data Types:
-- DOUBLE , FLOAT , VARCHAR, DATE, TIME, DATETIME

-- Create a relationship between orders and emporder_id table
-- 	Here customer_id is the foreign key
--  A foreign key establishes a relationship between two tables.
--  It refers to a column or set of columns in one table that corresponds to the primary key in another table
--  It is the primary key of emp table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES emp(id)
);

-- Difference between VARCHAR and VARCHAR2
VARCHAR and VARCHAR2 both are used to store character strings of variable length without specific length limitations 
and both are used as per our requirement
In databases such as MySQL and Postgres,  there is no diff between VARCHAR AND VARCHAR2
But in oracle database, VARCHAR is considered outdated for new development and mostly VARCHAR2 is used.

-- Drop Table
DROP Table orders;
            
-- Describe table structure
DESC emp;
DESC orders;  
-- Altering a Table Structure 
ALTER TABLE emp 
ADD email VARCHAR(100) NOT NULL;
-- Altering a column , Adding Not Null to emp_salary column
ALTER TABLE emp
MODIFY COLUMN emp_salary DECIMAL(10, 2) NOT NULL;
-- Adding a Check constraint
ALTER TABLE emp
ADD constraint emp_salary CHECK (emp_salary>0);

-- Adding an unique constraint
ALTER TABLE emp
ADD constraint email UNIQUE (email);
-- Insert into Tables
Insert into emp(name,emp_salary,email) values ("Pushpan",750000,"pushpanbhaumik200@gmail.com");
Insert into emp(name,address,emp_salary,email) values ("User4","Ramnagar-3",850000,"user#@gmail.com");
Insert into emp(name,address,emp_salary,email) values ("User5","Ramnagar-3",850056,"user134@gmail.com");
Insert into emp(name,address,emp_salary,email) values ("User6","Ramnagar-5",300000,"user134@gmail.com");
Insert into emp(name,emp_salary,email) values ("Pushpan",750000,"pushpanbhaumik0871@gmail.com");
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (1, '2024-04-25', 150.00);

-- Update Tables
Update emp set email = "user123@gmail.com" where id=4;
update emp set email="user100@gmail.com" where id=5;

-- Reading Data From Tables
select * from emp;
select * from emp where name="Pushpan";
select * from orders;

-- Deleting Data
Delete from emp where id=2;
-- This will give us error as we are trying t perform a delete operation
-- Which may result in deletion of a large portion of data
-- as name is not a primary key
Delete from emp where name="User3";
-- We can perform this but for that we need to disable the Safe mode as below
-- SET SQL_SAFE_UPDATES = 0;

-- Using alias in Select query
select name as Name, emp_salary as Salary from emp;

-- String Manipulation Functions

-- Concatenate strings
select CONCAT(name,' ',address) AS NameAdd from emp; 
-- Concatenate strings with a separator
select CONCAT('Name:',name,',Address:',address) AS NameAndAddress from emp;
select CONCAT(name,',',address) AS NameAddress from emp;

-- Extract substring from a string
SELECT SUBSTR('Hello World', 1, 5) AS substring_address;
-- Replace Function For String
SELECT REPLACE('Hello World','Hello','Code') AS replaced_string;
-- Reverse a string
SELECT REVERSE('Code Program') as reversed_string;
-- Convert string to uppercase and lowercase

-- Get length of a string
SELECT CHAR_LENGTH('MySQL') AS string_length;

-- Extract left and right parts of a string, and trim spaces
SELECT LEFT('Hello', 3) AS left_part, RIGHT('World', 3) AS right_part, TRIM('  MySQL  ') AS trimmed_string;

-- Removing Duplicates
-- Select distinct values from a column
select distinct address from emp;
-- Select and order data
select name,address from emp order by name;
select * from emp order by emp_salary;
select * from orders;
-- Select data using pattern matching
        #'Apple%' matches strings starting with "Apple".
		#'%Apple' matches strings ending with "Apple".
        #'%Apple%' matches strings that has Apple occuring anywhere within it
select * from emp where name like '%User%';
select * from emp where name like '%5';
-- Select limited rows
select * from emp LIMIT 2;

-- Count the number of employees
SELECT COUNT(ID) from emp;
SELECT COUNT(*) from emp where name LIKE '%User%';

-- GROUP BY:- The GROUP BY clause is used to group rows that have the same values into summary rows.
/* Syntax For GROUP BY 
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
ORDER BY column_name(s); */
SELECT name,count(*) FROM emp
GROUP BY name;
-- Without using any aggregate function
select name from emp
GROUP BY name;
-- MAX and MIN salary
select MAX(emp_salary) AS MAX_SALARY from emp; 
select MIN(emp_salary) AS MIN_SALARY from emp;

-- SubQueries within Query
-- Select data using a subquery
select name,emp_salary from emp where emp_salary > (select avg(emp_salary) from emp);

-- You can use a subquery with EXISTS to check for the existence of certain conditions.
select name,emp_salary from emp
where EXISTS (select * from orders where orders.customer_id = emp.id);

-- SUM AND AVERAGE
select sum(emp_salary) AS TOTAL_SAL, avg(emp_salary) AS AVG_SAL from emp;

-- DATE TIME FUNCTIONS
-- Examples of date/time functions
SELECT CURDATE() AS today_date, CURTIME() AS today_time, NOW() AS today_datetime;

SELECT DATE_FORMAT(order_date, '%Y-%m-%d %H:%i:%s') AS formatted_orderdatetime FROM orders;
-- Output: 2024-04-25 00:00:00 for the above query

-- Relational operators example
SELECT * FROM emp WHERE emp_salary > 750000.00;

-- Logical operators example
SELECT * FROM emp WHERE name = 'Pushpan' AND address IN ('Ramnagar-1');
SELECT * FROM emp WHERE name = 'Pushpan' AND address IS NULL;

-- IN keyword
select * from emp where name IN ('Pushpan');

-- NOT IN keyword
select * from emp where name NOT IN ('Pushpan');

-- BETWEEN keyword
select * from emp where emp_salary between 800000 and 900000;

-- CASE in SQL 
select name,
	CASE
    WHEN emp_salary < 800000 THEN 'PAID'
    ELSE 'NOT PAID'
   END AS paid_status
from emp;

-- ORDER BY MORE THAN ONE COLUMN
SELECT NAME FROM STUDENTS
WHERE MARKS > 75
ORDER BY LOWER(SUBSTRING(NAME,LENGTH(NAME)-2,LENGTH(NAME))),ID ASC;

-- ORDER IN ASCENDING ORDER
-- USE ASC FOR ASCENDING ORDER
-- USE DESC FOR DESCENDING ORDER


-- Aggregate functions are used in SQL to perform calculations on groups of rows and return a single value
-- HAVING
-- 

-- HAVING AND ROLL UP
-- It is used generally in combination with GROUP BY
-- The HAVING clause allows you to apply a filter to the groups of rows resulting from a GROUP BY operation.
-- It is typically used with aggregate functions 
-- such as SUM, COUNT, AVG, MIN, or MAX to filter groups based on aggregated values.
select name,sum(emp_salary) as Total
from emp
group by name
Having Total > 800000;

-- OFFSET and FETCH NEXT are used in SQL Server to implement pagination, allowing you to retrieve a subset of rows from a result set.
-- OFFSET specifies how many rows to skip, and FETCH NEXT specifies how many rows to return.
-- OFFSET, FETCH NEXT
SELECT * FROM emp
ORDER BY name
LIMIT 1, 2;

-- Using select, from, where, group by, having, order by, limit together
-- Selecting data from the table, filtering, grouping, and ordering

SELECT 
    product_id,
    product_name,
    SUM(quantity_sold) AS total_quantity,
    COUNT(*) AS total_sales,
    AVG(quantity_sold) AS avg_quantity_per_sale
FROM 
    sales
WHERE 
    sale_date BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY 
    product_id
HAVING 
    total_sales > 10
ORDER BY 
    total_quantity DESC
LIMIT 5;





-- Different Subsets of SQL
-- DDL (Data Definition Language):
DDL is a subset of SQL (Structured Query Language) that deals with the definition and management of database structures and schemas. Common DDL commands include:
CREATE: Used to create database objects like tables, views, indexes, etc.
ALTER: Modifies existing database objects, such as adding a new column to a table.
DROP: Deletes existing database objects like tables, views, indexes, etc.
TRUNCATE: Removes all records from a table while keeping the structure intact.
RENAME: Renames an existing database object.
-- DML (Data Manipulation Language):
DML is another subset of SQL that focuses on manipulating data within the database. 
-- Common DML commands include:
INSERT INTO: Adds new records into a table.
UPDATE: Modifies existing records in a table.
SELECT: Retrieves data from a database table.
-- Other types of queries:
Apart from DDL and DML, there are other types of queries and commands that are frequently used in database management and data retrieval:
DCL (Data Control Language): Deals with user permissions and access control. 
Commands include GRANT (gives specific privileges to a user) and REVOKE (removes specific privileges from a user).
-- TCL (Transaction Control Language): 
It manages transactions within a database. 
Commands include COMMIT (saves changes to the database), ROLLBACK (undoes changes in a transaction), and 
SAVEPOINT (sets a point in a transaction to which you can later roll back).
-- DDL Triggers
DDL Triggers: These are triggers that respond to DDL events (like table creation, alteration, deletion) rather than DML events (like insert, update, delete). 
They are used for administrative purposes, auditing, or enforcing business rules


-- JOINS
-- Different Types of JOIN
-- Inner Join:
Returns records that are common in both the tables

select column_names 
from tableA as a
inner join tableB as b
on a.column_name = b.column_name;

-- LEFT Join: also termed as LEFT OUTER JOIN
Returns all the records from the left table
and the matched records from the right Table

select * 
from tableA as a
left join tableB as b
on a.column_name = b.column_name

-- Right Join: also termed as RIGHT OUTER JOIN
Returns all the records from the right table
and all the matched records from the left table

select * 
from tableA as a
right join tableB b
on a.column_name = b.column_name

-- Full Outer Join:
Returns all the matched records from both the left and right table

select * 
from tableA as a
full join tableB as b
on a.column_name = b.column_name

-- in mysql, no full join syntax is present
-- We need to use left join and right join and union both of the joins

SELECT t1.id AS id1, t1.name AS name1, t2.id AS id2, t2.name AS name2
FROM table1 t1
LEFT JOIN table2 t2 ON t1.id = t2.id
UNION
SELECT t1.id AS id1, t1.name AS name1, t2.id AS id2, t2.name AS name2
FROM table1 t1
RIGHT JOIN table2 t2 ON t1.id = t2.id
WHERE t1.id IS NULL; -- Include only rows where t1.id is null (not matched in left join)

-- Self Join:
A self join is a regular join in which a table is joined to itself
Self Joins are powerful for comparing values within the same table

select column_names
from table1 as t1
join table1 as t2
on t1.col_name1 = t2.col_name2

select t1.emp_name,t2.emp_name
from emp as t1
join emp as t2
on t1.emp_id = t2.manager_id;

-- Union
The Union returns the concatenated result of two or more SQL SELECT statements without returning the duplicates

To use this UNION caluse each select statement must have:
- The same number of columns
- Same name of columns
- Have them in the same order

SELECT column_name from table1
UNION
SELECT column_name from table2

-- Union All
The Union returns the concatenated result of two or more SQL SELECT statements with duplicates

Same conditions as union

Syntax:

SELECT column_name from table1
UNION ALL
SELECT column_name from table2


-- VIEWS
Whatever Table we create in our database, takes a physical space in the memory
But View is like a virtual tabe. It looks like a table.
It is the result-set of a stored query.
The original table is called a base table from which we make View.
-- View doesn't have any physical existence which means we are not actually storing it
We actually use views so that from a huge table, we can use some columns as a table 
Also, any change in the base table like for eg- in a column some data is changed, the same change will
also be seen in the View

We can also store data in view from more than one table.
We can also store some columns from Table 1, some columns from Table 2 in a View
We can also store specific rows in our view by providing where condition in the underlying table.

-- Types of views
-- Read Only views
Read-only views refer to a type of view in a database management system where users can only retrieve data 
but cannot perform any modifications, such as inserts, updates, or deletes. 
-- Updatable views
Updatable views are views in a database management system that allow users to perform not only read operations 
but also write operations such as inserts, updates, and deletes. Unlike read-only views, which only allow data retrieval, 
updatable views provide a way for users to interact with the underlying data through the view itself. 

Any alteration in the updatable view will also alter the data in the underlying base table

select View viewname
as (select id from tablename);

-- Simple views
Logical Table or view created from one table.
It does not hold any Data
--Complex views
Logical Table or view created from more than one Table
It also does not hold any data

-- Materialized View
Materialized views store data physically, either in memory or on disk, depending on the database system and configuration. 
This means that the result set of the view is precomputed and ready for immediate access.
Unlike the non-materialized views which executes the underlying query everytime they are accessed.
The materialized views store the query result set only which improves the performance

Suppose, from a large dataset or large table, we want to cache or store a certain amount of Data
We can cache it using Materialized views , we can also do it using simple views but 
in materialized views everytime when we try to execute it, the underlying query is not executed, unlike simple views
which will hit the base table everytime as the underlying query will get executed everytime we try to access a simple view 

-- Example
create materialized view v1 as
select dept(sal), max(sal), min(sal), avg(sal)
from tableName
group by dept;

-- Advantages of views
1)To restrict data access 
2)To make complex queries easy
3)To provide data independence
4)To provide different views of the same result data set

-- Read only View
CREATE VIEW V1 
AS (SELECT id from emp);
-- Querying the view
select * from v1 where id>3;
-- Updatable View
CREATE VIEW updatable_view AS
SELECT id, name, address
FROM emp;
-- Updating the view
update updatable_view set address= "Ramnagar Road-1,Agartala" where id='3';


-- STORED PROCEDURES
-- What is a procedure
-- What is the purpose of using a procedure in SQL

-- Syntax to create a procedure in Microsoft SQL Server
-- Syntax to create a procedure in MySQL

-- Create and execute a procedure without parameters in Microsoft SQL Server
-- Create and execute a procedure without parameters in MySQL

-- Create and execute a procedure with parameters in Microsoft SQL Server
-- Create and execute a procedure with parameters in MySQL

-- Notes Made in copy


-- Cursors and Triggers







-- Indexing
Indexing in MySQL and other database systems refers to the process of creating data structures (indexes)
that help speed up the retrieval of rows from tables based on certain columns or expressions
Indexes allows us to quickly locate specific rows instead of scanning the entire table sequentially.
Eg- When we open a book, we can see a table of contents where it is written which topic belongs to which particular page
Now if it was not there we need to sequentially go to every page to find the data
But as we are using table of content, the search becomes more efficient 

In any Read-heavy application, Indexing must be used
Disadvantage:
The disadvantage is like update, insert operations takes more time when we apply indexing
Syntax:
CREATE [UNIQUE] INDEX index_name ON table_name (column_name(s));

CREATE INDEX idx_last_name ON employees (last_name);

-- NORMALIZATION
Normalization is the process of designing a database effectively to reduce data redundancy i.e. data duplicacy

We may observe sometimes the database table has a primary key to uniquely identify all the records but in some of the columns,
the data gets repeated and this issue can be resolved using Normalization by designing the database perfectly
DB Design ---> Creating Relationships between tables

Different Types of Normalization:

1NF:
Each column/attribute needs to have a single value
Each row should have unique names, no duplicate column names should be present
Each row should be uniquely identified either by a single row or multiple rows. Not mandatory to have a primary key

Denormalized Data:
Table: Employee

employee_id	employee_name	phone_numbers
1			John Doe		555-1234, 555-5678
2			Jane Smith		555-8765
3			Mike Johnson	555-4321, 555-9999

Normalized Data:
employee_id	employee_name	phone_number
1			John Doe		555-1234
1			John Doe		555-5678
2			Jane Smith		555-8765
3			Mike Johnson	555-4321
3			Mike Johnson	555-9999

Here employee_id alongwith phone_number uniquely identifies the table rows

2NF:-
Table must be in 1NF 
All non-key attributes must be fully dependent on candidate key -> like, if there are 2 columns which forms the candidate key
Then the non-key attributes must depend on both of the columns
Non-key attributes: columns apart from the candidate keys

Every table should have a primary key and linked with each other through foreign keys


3NF:-
All the tables should be in 2NF
Avoid transitive dependencies




-- DENORMALIZATION



-- ACID Properties

A -> Atomicity
C -> Consistency
I -> Isolation
D -> Durability

Atomicity:
It ensures that either all of the transactions are successfully completed or none of them
Eg- Suppose, in a transaction between two bank accounts, atomicity should ensure that if 
the debit operation succeeds , then the credit operation in the other bank account should also need to be SUCCESSFUL.
In case, if any one of the transaction fails, the whole system needs to be rolled back to its initial state

Consistency:
It enforces all constraints, rules, and relationships defined in the database schema.
Eg- In a database, where each customer must have an unique email address. 
In such a case, if any transaction or db operation which attempts to insert a new customer with an existing
email address, it basically violates Consistency and should be rejected

Isolation:
Isolation ensures that concurrent transactions do not interfere with each other when they are executed simultaneously. 
Each transaction should operate independently as if it is the only transaction executing on the database.
Eg- Suppose two transactions are concurrently updating the same bank account balance. Isolation ensures that 
each transaction sees a consistent state of the data and does not affect the outcome of the other transaction

Durability:
Durability guarantees that once a transaction is committed, its changes are permanent and survive system failures.
The changes made by committed transactions are stored in non-volatile storage (usually disk) and are not lost.
Eg-  After a successful fund transfer, the updated balances should persist even if the database server crashes.



-- Types of Relationships In Database







START TRANSACTION;
-- Your SQL statements within the transaction
UPDATE employees SET salary = salary * 1.1 WHERE department_id = 1;

-- Check if everything is fine
-- If satisfied, commit the changes
COMMIT;

-- If something went wrong or need to cancel changes
-- ROLLBACK will undo the changes made in the transaction
ROLLBACK;

-- Important Resources
https://github.com/rishabhnmishra/SQL_Resources/blob/main/Top%2010%20SQL%20Questions%20by%20Rishabh%20Mishra.pdf

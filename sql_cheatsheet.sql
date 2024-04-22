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

-- HAVING AND ROLL UP





-- OFFSET, FETCH NEXT



-- Types of Relationships In Database





-- JOINS
-- Different Types of JOIN




-- NORMALIZATION





-- VIEWS





-- STORED PROCEDURES
-- Argument Passing in Stored Procedure
-- Return Output in variable in Stored Procedure
-- USER DEFINED Function






-- WINDOW





START TRANSACTION;
-- Your SQL statements within the transaction
UPDATE employees SET salary = salary * 1.1 WHERE department_id = 1;

-- Check if everything is fine
-- If satisfied, commit the changes
COMMIT;

-- If something went wrong or need to cancel changes
-- ROLLBACK will undo the changes made in the transaction
ROLLBACK;


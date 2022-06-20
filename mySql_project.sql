use classicmodels;
-- OBJECTIVES OF THE PROJECT-- 
	-- Combine tables
    -- Pick out the relevantcolumns
    -- Manipulate the column names using alias
-- This outlines the various steps taken combine tables filter out the revelant information (features for analysis)
-- Perusuing the tables to check for relevances
select*
from customers; -- terminate to ensure the next line is able to execute
-- from this table we can retain 
	-- customer name
    -- contacts
    -- country
    -- sales rep information 
    -- credit limit
select*
	-- concat(lastName," ",firstName)  as fullName
    from employees;
	-- from this table we can retain
		-- first and last name which will be concat to give full name
        -- email address
select*
from offices;
	-- from this table we shall city and country
select*
from orderdetails;
	-- from this table we shall retain quantity ordered and price for each
select*
from orders;
	-- from this table we shall retain shipping status and comments, order date and shipped date
select*
from payments;
	-- we shall retain amount from thi table
select*
from productlines; -- We shall retain product line
select
	productCode,
    productName,
    quantityInStock,
    buyPrice,
    MSRP,
    productLine
    productDescription
from products; -- the information in this table is very vital this will extrated/exported seperately(This will be extracted as a csv)
-- Joining tables, this will be done through combination of clauses such as using, and on
-- we shall create a table from this which shall be joined to the other relevant tables

create table if not exists CustomerInformation as
select
	c.customerName,
    c.customerNumber,
    c.phone,
    c.city,
    c.country,
    c.creditLimit,
   concat(firstName," ",lastName) as RepfullName,
   o.country as RepLocation
from customers c
join employees e
on c.salesRepEmployeeNumber=e.employeeNumber
join offices o on o.officeCode=e.officeCode;

-- We will join the sales details tables and have it merged with the customer inomation details
create table if not exists Sales_info as -- creates the sales information table
select
	os.customerNumber,
    od.quantityOrdered,
	od.priceEach,
	os.status,
    os.comments,
    ps.productName
from orderdetails od
join orders os using(orderNumber)
join products ps on ps.productCode=od.productCode;

select
	si.customerNumber,
    si.quantityOrdered,
    si.priceEach,
    si.status,
    si.comments,
    o.orderNumber,
    p.productLine,
    si.productName
from sales_info si
join orders o using (customerNumber)
join products p using(productName); -- export this as sales_info file to be used for analysis
select*
from customerinformation;
-- extracted/exported the vital information to be used the analysis, further anlaysis will be done on excel.
select
	s.customerNumber,
    s.quantityOrdered,
    s.priceEach,
    s.status,
    s.comments,
    s.productName,
    o.orderDate,
    o.shippedDate,
    o.comments
from sales_info s
join orders o using(customerNumber)


























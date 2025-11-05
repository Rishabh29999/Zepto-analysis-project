select * from customers;


CREATE TABLE customers (
     custid integer NOT NULL,
	 first_name character varying(8) NOT NULL,
	 last_name character varying(7) NOT NULL,
	 email character varying (19) NOT NULL,
	 phone bigint NOT NULL,
	 address character varying (11) NOT NULL,
	 city character varying(5) NOT NULL,
	 state character varying (6) NOT NULL,
	 postal_code integer NOT NULL
);
CREATE TABLE pizza_types (
     pizza_type_id character varying(50) NOT NULL,
	 name character varying(100) NOT NULL,
	 category character varying(50) NOT NULL,
	 ingredients text NOT NULL
);
CREATE TABLE pizzas (
     pizza_id character varying(14) NOT NULL,
     pizza_type_id character varying(12) NOT NULL,
     size character varying(3) NOT NULL,
     price numeric(5,2) NOT NULL
);
CREATE TABLE orders (
    order_id integer NOT NULL,
    order_date date NOT NULL,
    order_time character varying(8) NOT NULL,
    custid integer NOT NULL,
    status character varying(9) NOT NULL
);
CREATE TABLE order_details (
    order_details_id integer NOT NULL,
    order_id integer NOT NULL,
    pizza_id character varying(14) NOT NULL,
    quantity integer NOT NULL
);



--- Cleaning Data
--step 1- To check for duplocate
--step 2- check for null values
--step 3- treating null values
--dtep 4- handling negative values
--step 5- fixing inconsincent data formats & invalid dates
--step 6- fixing invalid email address
--step 7- checking the datatype


Analyst Tasks:

1.Count the total number of unique orders(COUNT(DISTINCT order_id)).
2.Break down orders by month and year (GROUP BY EXTRACT(MONTH/YEAR FROM order_date)).
3.Find day-wise order distribution (TO_CHAR(order_date,'Day')).
4.Compute average orders per customer (COUNT (order_id)/COUNT (DISTINCT cust_Id)).
5.Identify repeat customers and their order frequency (HAVING COUNT(order_id) > 1).
6.Use window functions to calculate month-over-month growth % (LAG(order_count) OVER ...).
7.Build a trend projection using cumulative counts or forcasting methods.

select count(order_id) from orders;
select count(DISTINCT order_id) from orders;



Analysis the data

--"We are trying to understand our order vol in detail so we ccan measure store performance and benchmark growth.
--Instead of just knowing the total no. of unique orders, I'd like a deeper breakdown".

-- 1)What is the total no. of unique order is placed.
select count(DISTINCT order_id) from orders;

-- 2)How has this order volume changed month-over-month and year-over-year.

WITH monthly_orders AS (
     SELECT DATE_TRUNC('month',order_date) as month,
     COUNT(order_id) as order_count
     from orders
     group by DATE_TRUNC('month',order_date)
)

-- 3)orders of day of week
     select
     TO_CHAR(order_date,'Day') as weekday,
	 COUNT(distinct order_id) as total_orders from orders
	 group by TO_CHAR(order_date,'Day')
	 order by total_orders;

--4)avg order by per customer
select
count(distinct order_id) * 1.0 /
Count(distinct custId) as avg_orders_per_customer
from orders;

-- 5)Most order by any customer

select
count(distinct order_id) as order_count from orders
group by custId
order by order_count desc;

select * from orders
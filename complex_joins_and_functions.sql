create database amazon;
use amazon;
create table products
(
	pid int primary key,
    pname varchar(50) not null,
    price int not null,
    stock int,
    location varchar(30) check(location in ('Mumbai','Delhi'))
);
create table customer
(
	cid int primary key,
    cname varchar(30) not null,
    age int,
    addr varchar(50)
);
create table orders
(
	oid int primary key,
    cid int,
    pid int,
    amt int not null,
    foreign key(cid) references customer(cid),
    foreign key(pid) references products(pid)
);
create table payment
(
	pay_id int primary key,
    oid int,
    amount int not null,
    mode varchar(30) check(mode in('upi','credit','debit')),
    status varchar(30),
    timestamp TIMESTAMP,
    foreign key(oid) references orders(oid)
);
insert into products values(1,'HP Laptop',50000,15,'Mumbai');
insert into products values(2,'Realme Mobile',20000,30,'Delhi');
insert into products values(3,'Boat earpods',3000,50,'Delhi');
insert into products values(4,'Levono Laptop',40000,15,'Mumbai');
insert into products values(5,'Charger',1000,0,'Mumbai');
insert into products values(6, 'Mac Book', 78000, 6, 'Delhi');
insert into products values(7, 'JBL speaker', 6000, 2, 'Delhi');
insert into products values(8 , 'Asus Laptop',50000,15,'Delhi');

#Inserting values into customer table
insert into customer values(101,'Ravi',30,'fdslfjl');
insert into customer values(102,'Rahul',25,'fdslfjl');
insert into customer values(103,'Simran',32,'fdslfjl');
insert into customer values(104,'Purvesh',28,'fdslfjl');
insert into customer values(105,'Sanjana',22,'fdslfjl');

#Inserting values into orders table
insert into orders values(10001,102,3,2700);
insert into orders values(10002,104,2,18000);
insert into orders values(10003,105,5,900);
insert into orders values(10004,101,1,46000);

#inserting values into payments table
insert into payment values(1,10001,2700,'upi','completed','2024-05-01 08:00:00');
insert into payment values(2,10002,18000,'credit','completed','2024-05-01 08:10:00');
insert into payment values(3,10003,900,'debit','in process','2024-05-01 08:15:00');
-- SINGLE ROW SUBQUERIES:-
# Example 1:- Find the customer who placed the order with the highest amount
select cname from customer where cid=(select cid from orders group by cid order by sum(amt) desc limit 1);
#ans-Ravi

# Question 2: Retrieve the names of all customers who have placed orders for products located in the same city as the customer named "Rahul". 
select cname from customer where cid in(select distinct cid from orders where pid in(select pid from products where location =( select location from customer where cname ='Rahul'))); 

# Question 3: Retrieve the names of all customers who have placed orders for products that have a price higher than the average price of products bought by each customer.
select cname from customer c where exists(select 1 from orders o join products p on o.pid = p.pid where o.cid = c.cid and p.price>(select avg(price) from products where pid in (select pid from orders where cid= c.cid)));


-- JOINS
# Question 4: Retrieve the names of customers who have placed orders for products with a price higher than the average price of all products in the same city as the customer, and also display the total amount spent by each customer on such orders.
SELECT c.cname, SUM(o.amt) AS total_amount_spent
FROM customer c
INNER JOIN orders o ON c.cid = o.cid
INNER JOIN products p ON o.pid = p.pid
INNER JOIN (
    SELECT location, AVG(price) AS avg_price
    from products
    group by location ) avg_prices ON p.location = avg_prices.location where p.price > avg_prices.avg_price group by c.cname;

# Question 5: Retrieve the names of all customers along with the total amount they have spent on orders, including customers who have not placed any orders yet.
SELECT c.cname, COALESCE(SUM(o.amt), 0) AS total_amount_spent
FROM customer c
LEFT JOIN orders o ON c.cid = o.cid
GROUP BY c.cname;

# Question 6: Retrieve all customer details along with their corresponding order details, even if there are no corresponding orders, and display 'No order' instead of NULL. If there are no corresponding orders, also display the reason for no order (e.g., 'Out of stock')
SELECT c.cid,
       c.cname,
       c.age,
       c.addr,
       CASE 
           WHEN o.oid IS NULL THEN 'No order'
           ELSE o.oid
       END AS order_id,
       CASE WHEN o.oid IS NULL THEN 'No order' ELSE p.status END AS order_status FROM customer c
left join orders o ON c.cid = o.cid right join payment p ON o.oid = p.oid order by c.cid;
# Question 7: Retrieve the names of products along with their prices and the ranking of each product based on their prices, where the products are ranked in descending order of price.
select pname, price, rank() over (order by price desc) as price_rank from products;
# Question 8: Retrieve the names of products along with their prices and the dense ranking of each product based on their prices, where products are ranked in descending order of price.
select pname, price, dense_rank() over (order by price desc) as dense_price_rank from products;
# Question 9: Retrieve the names of products along with their prices and the row number of each product, where products are ordered by their prices in descending order.
select pname, price, row_number() over (order by price desc) as row_num from products;
# Question 10: Retrieve the names of products along with their prices and the cumulative distribution of each product's price, indicating what fraction of products have prices less than or equal to the price of each product.
select pname, price, cume_dist() over (order by price) as cumulative_distribution from products;
# Question 11:  Retrieve the names of products along with their prices and the price of the previous product in the list, ordered by price in ascending order.
select pname, price, lag(price) over (order by price) as previous_price from products;
# Question 12:  Retrieve the names of products along with their prices and the price of the next product in the list, ordered by price in ascending order.
select pname, price, lead(price) over (order by price) as next_price from products;
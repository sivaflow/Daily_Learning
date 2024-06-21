use amazon;
DELIMITER //
-- Ques 1. Write a query to create a function that calculates the total revenue from the 'orders' and 'payment' tables for completed orders, and call the function to get the total revenue.
delimiter //

create function get_total_revenue()
returns int
deterministic
begin
    declare total_revenue int;
    select sum(amount) into total_revenue
    from payment
    where status = 'completed';
    return total_revenue;
end //

delimiter ;

select get_total_revenue() as total_revenue;

-- Ques 2. Write a query to create a function that calculates the total revenue from the 'orders' and 'payment' tables for completed orders, and call the function to get the total revenue.


delimiter //

create procedure get_product_details(in product_id int)
begin
    select * from products where pid = product_id;
end //

delimiter ;

call get_product_details(5);

-- Ques 3. Write a query to create a procedure with an IN parameter to retrieve details of a specific product based on the product ID passed as a parameter. Call the procedure for product ID 5.



delimiter //

create procedure get_product_details(in product_id int)
begin
    select * from products where pid = product_id;
end //

delimiter ;

call get_product_details(5);



-- Ques 4. Write a query to create a procedure with an OUT parameter to get the count of products in the 'products' table, store it in a variable, and select the variable to display the count.

delimiter //

create procedure get_product_count(out product_count int)
begin
    select count(*) into product_count from products;
end //

delimiter ;


set @count = 0;

call get_product_count(@count);

select @count as total_products;


-- Ques 5. Write a query to use the predefined SUM() cursor to calculate the total price of all products in the 'products' table where the product category is 'Electronics'. 

DELIMITER $$
CREATE PROCEDURE calc_total_electronics_price(OUT total_price DECIMAL(10,2))
BEGIN
    SELECT SUM(price) INTO total_price
    FROM products
    WHERE category = 'Electronics';
END$$
DELIMITER ;

CALL calc_total_electronics_price(@total);


-- Ques 6. Write a query to declare and use a cursor to iterate through the 'products' table and print the product name for each product.

delimiter //

create procedure print_product_names()
begin
    declare done int default false;
    declare product_name varchar(50);
    declare cur cursor for select pname from products;
    declare continue handler for not found set done = true;

    open cur;

    read_loop: loop
        fetch cur into product_name;
        if done then
            leave read_loop;
        end if;
        select product_name;
    end loop;

    close cur;
end //

delimiter ;

call print_product_names();





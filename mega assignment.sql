SELECT * FROM mega_assignment.login_logs;

# 2 Prepare a report regarding our growth between the 2 years. Please try to answer the
# following questions:a. Did our business grow?
select 
extract(year from D_ate)as year,
sum(total_sale) from 
(select D_ate,
 sum(order_quantity_accepted *rate)  as total_sale from
 (select cast(creation_time as date) as D_ate ,cast(creation_time as time) as Tme ,order_quantity_accepted,fk_product_id,
 rate from sales_orders_items join sales_orders
on sales_orders_items.fk_order_id=sales_orders.order_id where order_quantity_accepted>1)t1  group by D_ate order by D_ate)t2
group by extract(year from D_ate );

# c. Did our user base grow?
select count(user_id) as users  ,date from
(select 
cast(login_time as date) as date,user_id from login_logs)t1 
group by date;



# 3 What are our top-selling products in each of the two years? Can you draw some insight
# from this?

SELECT COUNT(order_quantity_accepted) as count ,fk_product_id  FROM 
sales_orders_items GROUP BY fk_product_id order by count desc;

#4. Looking at July 2021 data, what do you think is our biggest problem and how would you
#   recommend fixing it?
select order_id,fk_product_id,fk_buyer_id,ordered_quantity,order_quantity_accepted,sales_order_status,
(ordered_quantity-order_quantity_accepted) as diffrence from
 sales_orders join sales_orders_items
 on sales_orders.order_id=sales_orders_items.fk_order_id
 where creation_time between '2021-07-01 00:35:28.0' and '2021-07-30 23:17:29.0';
 
# 5 Does the login frequency affect the number of orders made?

select count(ordered_quantity) number_of_order,count(login_time) as number_of_timelogin,user_id from login_logs join
sales_orders   on 
login_logs.user_id=sales_orders.fk_buyer_id 
join sales_orders_items on 
sales_orders.order_id=sales_orders_items.fk_order_id
group by user_id;

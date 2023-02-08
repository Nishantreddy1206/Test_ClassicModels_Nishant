
with
    orderdetails_fact as (select * from {{ ref("Stg_orderdetails") }}),
    orders_dim as (
        select ordernumber as order_id, customernumber as customer_id from public.orders
    ),
    orders_fact as (
        select order_id, customer_id, sum(order_amount) as order_amount
        from orders_dim od
        join orderdetails_fact odf using (order_id)
        group by 1, 2
    )
select *
from orders_fact

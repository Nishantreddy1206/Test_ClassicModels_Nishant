
WITH orderdetails_fact as (
    SELECT * FROM {{ref('Stg_orderdetails')}}
),
orders_dim as (
    SELECT 
        ordernumber as order_id,
        customernumber as customer_id
    FROM public.orders
),
orders_fact as (
    SELECT
        order_id,
        customer_id,
        SUM(order_amount) as order_amount
    FROM orders_dim od
    JOIN orderdetails_fact odf USING (order_id)
    GROUP BY 1,2
)
SELECT * FROM orders_fact
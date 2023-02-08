
WITH orders_dim as (
    SELECT * FROM {{ref('Stg_orders')}}
),
orderdetails_fact AS (
    SELECT 
        ordernumber as order_id,
        SUM(quantityordered*priceeach) as order_amount
    FROM public.orderdetails
    GROUP BY 1
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
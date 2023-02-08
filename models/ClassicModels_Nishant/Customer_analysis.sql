{{config(materialized='table')}}

WITH Stg_customers as (
    SELECT * FROM {{ref('Stg_customers')}}
),
Stg_orders as (
    SELECT * FROM {{ref('Stg_orders')}}
),
Customer_Analysis as (
    SELECT
        customer_id,
        COUNT(order_id) as orders,
        SUM(payment_amount) as payment_amount,
        SUM(order_amount) as order_amount
    FROM Stg_customers sc 
    JOIN Stg_orders od USING(customer_id)
    GROUP BY 1
)
SELECT *
FROM Customer_Analysis
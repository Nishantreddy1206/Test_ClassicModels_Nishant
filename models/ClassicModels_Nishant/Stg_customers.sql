
WITH Stg_payments as (
    SELECT * FROM {{ref('Stg_payments')}}
),
Customer_dim as (      
    SELECT 
        customernumber as customer_id,
        salesrepemployeenumber as employee_id
    FROM public.Customers
),
Customer_fact as (
    SELECT 
        customer_id,
        employee_id,
        SUM(payment_amount) as payment_amount
        FROM Customer_dim 
        JOIN Stg_payments USING(customer_id)
        GROUP BY 1,2
)
SELECT * FROM Customer_fact
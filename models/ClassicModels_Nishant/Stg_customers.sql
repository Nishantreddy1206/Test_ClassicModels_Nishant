
WITH Customer_dim as (      
    SELECT 
        customernumber as customer_id,
        salesrepemployeenumber as employee_id
    FROM public.Customers
)

SELECT * FROM Customer_dim
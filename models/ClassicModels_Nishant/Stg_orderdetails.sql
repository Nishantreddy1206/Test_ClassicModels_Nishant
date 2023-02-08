
WITH orderdetails_fact AS (
    SELECT 
        ordernumber as order_id,
        SUM(quantityordered*priceeach) as order_amount
    FROM public.orderdetails
    GROUP BY 1
)

SELECT * FROM orderdetails_fact
